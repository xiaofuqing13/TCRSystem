<template>
  <div class="resource-sharing-container">
    <h1>课程资源协同</h1>
    
    <!-- 查询过滤卡片 -->
    <el-card class="filter-card">
      <template #header>
        <div class="card-header">
          <span>按条件筛选教学资源</span>
          <small>不选择课程时将显示专业内所有教师的审核通过资料</small>
        </div>
      </template>
      
      <el-form :inline="true" :model="queryParams" class="filter-form">
        <el-form-item label="课程">
          <el-select 
            v-model="queryParams.courseId" 
            placeholder="选择课程" 
            clearable 
            filterable
            style="width: 220px;"
            @change="handleCourseChange"
          >
            <el-option
              v-for="course in courseList"
              :key="course.id"
              :label="course.name"
              :value="course.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="学年">
          <el-select 
            v-model="queryParams.academicYear" 
            placeholder="选择学年" 
            clearable 
            style="width: 150px;"
          >
            <el-option
              v-for="year in academicYears"
              :key="year"
              :label="year"
              :value="year"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="学期">
          <el-select 
            v-model="queryParams.semester" 
            placeholder="选择学期" 
            clearable 
            style="width: 150px;"
          >
            <el-option label="第一学期" :value="1"></el-option>
            <el-option label="第二学期" :value="2"></el-option>
          </el-select>
        </el-form-item>
        
        <el-form-item label="材料类型">
          <el-select 
            v-model="queryParams.materialTypeId" 
            placeholder="选择材料类型" 
            clearable 
            style="width: 150px;"
          >
            <el-option
              v-for="type in materialTypes"
              :key="type.id"
              :label="type.name"
              :value="type.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="fetchMaterials">查询</el-button>
          <el-button @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    
    <!-- 同步教学大纲和授课计划按钮 -->
    <el-card class="sync-card" v-if="queryParams.courseId">
      <div class="sync-actions">
        <el-button 
          type="primary" 
          icon="Download" 
          @click="syncMaterials('教学大纲')"
        >
          下载本课程教学大纲
        </el-button>
        <el-button 
          type="success" 
          icon="Download" 
          @click="syncMaterials('授课计划')"
        >
          下载本课程授课计划
        </el-button>
      </div>
      <div class="sync-tip" v-if="queryParams.courseId && !hasCourseMaterials">
        <el-alert
          title="当前课程暂无其他教师上传的教学大纲或授课计划"
          type="info"
          show-icon
          :closable="false"
        />
      </div>
    </el-card>
    
    <!-- 材料列表 -->
    <el-card v-loading="loading" class="materials-card">
      <template #header>
        <div class="card-header">
          <span>
            {{ queryParams.courseId ? courseMap[queryParams.courseId]?.name || '所有课程' : '专业内所有资源' }} 教学资源
          </span>
          <el-tag v-if="queryParams.courseId" type="success">仅显示同课程教师的材料</el-tag>
          <el-tag v-else type="info">显示专业内所有课程的审核通过资料</el-tag>
        </div>
      </template>
      
      <div class="materials-tip" v-if="!materialList.length && !loading">
        <el-empty description="暂无符合条件的教学资源"></el-empty>
      </div>
      
      <el-table 
        v-else 
        :data="materialList" 
        style="width: 100%"
        border
      >
        <el-table-column prop="name" label="材料名称" min-width="180" show-overflow-tooltip />
        <el-table-column prop="course_name" label="所属课程" width="150" show-overflow-tooltip />
        <el-table-column prop="material_type_name" label="材料类型" width="120">
          <template #default="scope">
            {{ scope.row.material_type_name || '未知类型' }}
          </template>
        </el-table-column>
        <el-table-column prop="academic_year" label="学年" width="100">
          <template #default="scope">
            {{ scope.row.academic_year || '未知学年' }}
          </template>
        </el-table-column>
        <el-table-column prop="semester" label="学期" width="80">
          <template #default="scope">
            {{ scope.row.semester === 1 ? '第一学期' : scope.row.semester === 2 ? '第二学期' : '未知学期' }}
          </template>
        </el-table-column>
        <el-table-column prop="description" label="描述" min-width="150" show-overflow-tooltip />
        <el-table-column prop="upload_user_name" label="上传教师" width="120" />
        <el-table-column prop="create_time" label="上传时间" width="180" />
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="scope">
            <el-button 
              type="primary" 
              size="small" 
              icon="Download" 
              circle 
              plain
              @click="downloadMaterial(scope.row)"
              title="下载"
            />
          </template>
        </el-table-column>
      </el-table>
      
      <div class="pagination-container">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="queryParams.pageSize"
          :current-page="queryParams.current"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import axios from 'axios'
import { useRouter } from 'vue-router'

// 状态变量
const loading = ref(false)
const materialList = ref([])
const courseList = ref([])
const materialTypes = ref([])
const academicYears = ref([])
const total = ref(0)
const courseMap = ref({})
const currentTeacherId = ref(null)
const currentTeacherCourses = ref([])
const router = useRouter()

// 查询参数
const queryParams = reactive({
  current: 1,
  pageSize: 10,
  courseId: null,
  academicYear: null,
  semester: null,
  materialTypeId: null
})

// 计算当前课程是否有材料
const hasCourseMaterials = computed(() => {
  if (!queryParams.courseId) return false
  
  // 获取当前选中课程的名称
  const currentCourseName = courseMap.value[queryParams.courseId]?.name
  console.log('当前课程名称:', currentCourseName)
  console.log('材料列表:', materialList.value)
  console.log('当前教师ID:', currentTeacherId.value)
  
  // 检查是否有教学大纲或授课计划类型的材料（不管课程名匹配与否）
  const hasMaterialsByType = materialList.value.some(material => {
    const isOtherTeacher = material.upload_user_id !== currentTeacherId.value
    const isTargetType = material.material_type_name === '教学大纲' || material.material_type_name === '授课计划'
    return isOtherTeacher && isTargetType
  })
  
  // 优先检查同名课程的材料
  if (currentCourseName) {
    const hasMaterialsBySameName = materialList.value.some(material => {
      const isOtherTeacher = material.upload_user_id !== currentTeacherId.value
      const isSameCourse = material.course_name === currentCourseName
      console.log('材料:', material.name, 
                  '上传者ID:', material.upload_user_id, 
                  '是其他教师:', isOtherTeacher, 
                  '课程名:', material.course_name, 
                  '当前课程名:', currentCourseName, 
                  '是同名课程:', isSameCourse)
      return isOtherTeacher && isSameCourse
    })
    
    // 如果找到同名课程的材料，直接返回true
    if (hasMaterialsBySameName) {
      console.log('找到同名课程材料')
      return true
    }
  }
  
  // 如果找不到同名课程的材料，但有指定类型的材料，也返回true
  console.log('是否有教学大纲或授课计划类型的材料:', hasMaterialsByType)
  return hasMaterialsByType
})

// 获取当前教师可访问的课程
const fetchTeacherCourses = async () => {
  try {
    // 获取用户信息
    const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}')
    if (!userInfo || !userInfo.id) {
      ElMessage.warning('用户信息不完整，请重新登录')
      router.push('/login')
      return
    }
    
    currentTeacherId.value = userInfo.id
    console.log('当前教师ID:', currentTeacherId.value)
    
    const response = await axios.get(`/api/course/teacher/${currentTeacherId.value}`)
    courseList.value = response.data.data || []
    
    // 创建课程映射，方便查询
    courseList.value.forEach(course => {
      courseMap.value[course.id] = course
      
      // 记录当前教师的课程ID，用于安全管理
      currentTeacherCourses.value.push(course.id)
    })
  } catch (error) {
    console.error('获取教师课程失败:', error)
    ElMessage.error('获取教师课程失败')
  }
}

// 获取材料类型列表
const fetchMaterialTypes = async () => {
  try {
    const response = await axios.get('/api/material-type/list')
    materialTypes.value = response.data.data || []
  } catch (error) {
    console.error('获取材料类型失败:', error)
    ElMessage.error('获取材料类型失败')
  }
}

// 生成学年列表
const generateAcademicYears = () => {
  const currentYear = new Date().getFullYear()
  const years = []
  for (let i = 0; i < 5; i++) {
    const year = currentYear - i
    years.push(`${year}-${year + 1}`)
  }
  academicYears.value = years
}

// 查询教学资源
const fetchMaterials = async () => {
  try {
    loading.value = true;
    
    // 深拷贝参数，避免直接修改原始对象
    const params = JSON.parse(JSON.stringify(queryParams));
    
    // 确保semester是数字类型或者null
    if (params.semester !== null && params.semester !== undefined) {
      const semesterNum = Number(params.semester);
      params.semester = isNaN(semesterNum) ? null : semesterNum;
    }
    
    // 确保materialTypeId是数字类型或者null
    if (params.materialTypeId !== null && params.materialTypeId !== undefined) {
      const typeIdNum = Number(params.materialTypeId);
      params.materialTypeId = isNaN(typeIdNum) ? null : typeIdNum;
    }
    
    // 根据是否选择课程确定使用哪个API
    let url = '/api/material/shared';
    
    // 如果没有选择课程，则使用专业内所有教师的审核通过资料接口
    if (!params.courseId) {
      url = '/api/material/shared-by-major';
      // 确保教师ID有效
      if (!currentTeacherId.value) {
        const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}');
        currentTeacherId.value = userInfo.id;
        if (!currentTeacherId.value) {
          ElMessage.warning('无法获取用户信息，请重新登录');
          return;
        }
      }
      params.teacherId = currentTeacherId.value;
    } else {
      // 安全管理：检查课程列表是否已加载
      if (currentTeacherCourses.value.length === 0) {
        // 重新获取课程
        try {
          await fetchTeacherCourses();
        } catch (error) {
          console.error('获取教师课程失败:', error);
          ElMessage.error('获取教师课程信息失败，请刷新页面重试');
        }
      }
      
      // 安全检查：确保课程ID存在于当前教师的课程列表中
      if (!currentTeacherCourses.value.includes(params.courseId)) {
        console.warn('请求的课程ID不在当前教师的课程列表中:', params.courseId);
      }
      
      // 转换为字符串，便于后端解析
      params.courseIdsStr = currentTeacherCourses.value.join(',');
    }
    
    console.log('查询参数：', params);
    console.log('请求URL:', url);
    
    const response = await axios.get(url, { params });
    
    if (!response || !response.data) {
      ElMessage.error('获取数据失败，请稍后重试');
      return;
    }
    
    if (response.data.code !== 200) {
      ElMessage.error(response.data.message || '获取教学资源失败');
      return;
    }
    
    // 安全地获取数据，避免空值错误
    const responseData = response.data.data || {};
    const records = responseData.records || [];
    
    // 处理并格式化返回的数据
    materialList.value = records.map(record => {
      if (!record) return null;
      
      // 安全地访问对象属性
      return {
        ...record,
        // 如果缺少某些字段，使用默认值
        id: record.id || 0,
        name: record.name || '未命名材料',
        material_type_name: record.material_type_name || '未知类型',
        course_name: record.course_name || '未知课程',
        academic_year: record.academic_year || '未知学年',
        // 确保学期为数字类型
        semester: record.semester ? Number(record.semester) : null,
        upload_user_name: record.upload_user_name || '未知用户',
        create_time: record.create_time || '未知时间',
      };
    }).filter(item => item !== null); // 过滤掉无效数据
    
    total.value = responseData.total || 0;
    
    // 打印查询结果，检查字段
    console.log('获取到的材料列表:', materialList.value);
    if (materialList.value.length > 0) {
      console.log('第一条材料数据样例:', materialList.value[0]);
    }
    
  } catch (error) {
    console.error('获取教学资源失败:', error);
    const errorMsg = error.response?.data?.message || error.message || '未知错误';
    ElMessage.error('获取教学资源失败：' + errorMsg);
    // 在发生错误时，清空材料列表，避免显示过期数据
    materialList.value = [];
    total.value = 0;
  } finally {
    loading.value = false;
  }
}

// 重置查询条件
const resetQuery = () => {
  try {
    // 清空所有查询条件
    queryParams.courseId = null;
    queryParams.academicYear = null;
    queryParams.semester = null;
    queryParams.materialTypeId = null;
    queryParams.current = 1;
    
    // 重新获取数据
    fetchMaterials();
  } catch (error) {
    console.error('重置查询失败:', error);
    ElMessage.error('重置查询条件失败：' + error.message);
  }
}

// 处理课程变化
const handleCourseChange = () => {
  try {
    // 重置到第一页
    queryParams.current = 1;
    
    // 重新获取数据
    fetchMaterials();
  } catch (error) {
    console.error('处理课程变化失败:', error);
    ElMessage.error('切换课程失败：' + error.message);
  }
}

// 处理页码变化
const handleCurrentChange = (current) => {
  queryParams.current = current
  fetchMaterials()
}

// 处理每页条数变化
const handleSizeChange = (size) => {
  queryParams.pageSize = size
  queryParams.current = 1
  fetchMaterials()
}

// 下载教学资源
const downloadMaterial = (material) => {
  if (!material || !material.id) {
    console.error('下载参数错误:', material)
    ElMessage.warning('无效的材料信息')
    return
  }
  
  try {
    // 安全地创建下载链接 - 使用完整的API路径
    const materialId = encodeURIComponent(material.id)
    const downloadUrl = `/api/material/download/${materialId}`
    
    // 使用更安全的方式打开窗口
    const newWindow = window.open()
    if (newWindow) {
      // 如果窗口成功打开，则重定向到下载地址
      newWindow.location.href = downloadUrl
      
      // 记录下载次数 - 确保在尝试更新之前已经打开了下载窗口
      setTimeout(() => {
        // 异步更新下载次数
        axios.post(`/api/material/download/${materialId}`)
          .then(() => {
            console.log('下载次数更新成功')
          })
          .catch(error => {
            console.error('更新下载次数失败:', error)
            // 不影响用户体验，静默失败
          })
      }, 500)
      
      ElMessage.success('开始下载文件')
    } else {
      // 弹窗被阻止的情况下
      ElMessage.warning('下载窗口被浏览器阻止，请允许弹窗并重试')
    }
  } catch (error) {
    console.error('下载文件失败:', error)
    ElMessage.error('下载文件失败: ' + (error.message || '未知错误'))
  }
}

// 同步教学大纲或授课计划
const syncMaterials = async (materialTypeName) => {
  if (!materialTypeName) {
    ElMessage.warning('材料类型不能为空')
    return
  }

  if (!queryParams.courseId) {
    ElMessage.warning('请先选择课程')
    return
  }
  
  try {
    loading.value = true
    
    // 查找对应的材料类型ID
    const materialType = materialTypes.value.find(type => type.name === materialTypeName)
    if (!materialType || !materialType.id) {
      ElMessage.warning(`未找到${materialTypeName}材料类型`)
      return
    }
    
    const materialTypeId = materialType.id
    
    // 获取当前课程名称
    const currentCourse = courseMap.value[queryParams.courseId]
    if (!currentCourse || !currentCourse.name) {
      ElMessage.warning('课程信息获取失败')
      return
    }
    
    // 记录当前课程名称，用于日志和调试
    console.log('当前课程:', currentCourse.name)
    
    // 再次请求获取所有同名课程的指定类型材料，确保数据完整
    const params = {
      courseId: queryParams.courseId,
      materialTypeId,
    }
    
    console.log('查询下载材料参数:', params)
    const response = await axios.get('/api/material/shared', { params })
    
    if (!response || !response.data || response.data.code !== 200) {
      ElMessage.error((response?.data?.message) || '获取材料失败')
      return
    }
    
    const allMaterials = response.data.data?.records || []
    if (!allMaterials.length) {
      ElMessage.warning(`未找到${materialTypeName}材料`)
      return
    }
    
    console.log('获取到所有同名课程材料:', allMaterials)
    
    // 安全地获取教师ID
    const teacherId = currentTeacherId.value
    if (!teacherId) {
      ElMessage.warning('无法获取当前教师信息')
      return
    }
    
    // 过滤出其他教师上传的材料
    const otherTeachersMaterials = allMaterials.filter(material => 
      material && material.upload_user_id && material.upload_user_id !== teacherId
    )
    
    console.log('找到的其他教师材料数量:', otherTeachersMaterials.length)
    
    if (!otherTeachersMaterials.length) {
      ElMessage.warning(`未找到其他教师上传的${materialTypeName}`)
      return
    }
    
    // 显示确认对话框
    try {
      await ElMessageBox.confirm(
        `确定要下载同名课程的${materialTypeName}吗？共${otherTeachersMaterials.length}份资料将被下载。`,
        '确认下载',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'info'
        }
      )
    } catch (error) {
      if (error === 'cancel') {
        console.log('用户取消下载')
      } else {
        console.error('确认对话框错误:', error)
      }
      return
    }
    
    // 批量下载确认
    ElMessage.success(`正在下载${otherTeachersMaterials.length}份${materialTypeName}资料，请在弹出的窗口中查看`)
    
    // 使用更可靠的方式批量下载
    const downloadFiles = async () => {
      for (let i = 0; i < otherTeachersMaterials.length; i++) {
        const material = otherTeachersMaterials[i]
        if (!material || !material.id) {
          console.error(`第${i+1}个材料数据无效:`, material)
          continue
        }
        
        console.log(`开始下载第${i+1}个材料:`, material.name)
        
        try {
          // 安全地构建URL
          const materialId = encodeURIComponent(material.id)
          const downloadUrl = `/api/material/download/${materialId}`
          
          // 使用更安全的方式打开窗口
          const newWindow = window.open()
          if (newWindow) {
            newWindow.location.href = downloadUrl
            
            // 记录下载
            await axios.post(`/api/material/download/${materialId}`)
          } else {
            ElMessage.warning('下载窗口被浏览器阻止，请允许弹窗')
            break
          }
          
          // 每次下载间隔2秒
          if (i < otherTeachersMaterials.length - 1) {
            await new Promise(resolve => setTimeout(resolve, 2000))
          }
        } catch (error) {
          console.error(`下载材料${material.name || '未知'}失败:`, error)
          ElMessage.warning(`材料"${material.name || '未知'}"下载失败: ${error.message || '未知错误'}`)
        }
      }
      
      ElMessage.success('所有材料下载完成')
      fetchMaterials() // 刷新材料列表
    }
    
    // 开始下载
    downloadFiles()
    
  } catch (error) {
    console.error(`下载${materialTypeName}失败:`, error)
    ElMessage.error(`下载${materialTypeName}失败: ` + (error.response?.data?.message || error.message || '未知错误'))
  } finally {
    loading.value = false
  }
}

// 页面加载时获取数据
onMounted(async () => {
  try {
    // 获取用户信息
    const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}')
    if (!userInfo || !userInfo.id) {
      ElMessage.warning('用户信息不完整，请重新登录')
      router.push('/login')
      return
    }
    
    currentTeacherId.value = userInfo.id
    console.log('当前教师ID:', currentTeacherId.value)
    
    // 并行获取课程和材料类型数据
    await Promise.all([
      fetchTeacherCourses(),
      fetchMaterialTypes()
    ])
    
    // 生成学年列表
    generateAcademicYears()
    
    // 获取材料列表
    await fetchMaterials()
  } catch (error) {
    console.error('初始化页面数据失败:', error)
    ElMessage.error('页面初始化失败: ' + (error.message || '未知错误'))
  }
})
</script>

<style lang="scss" scoped>
.resource-sharing-container {
  padding: 20px;
  
  h1 {
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: 500;
    color: #303133;
  }
  
  .filter-card {
    margin-bottom: 20px;
  }
  
  .sync-card {
    margin-bottom: 20px;
    
    .sync-actions {
      display: flex;
      gap: 15px;
      margin-bottom: 15px;
    }
    
    .sync-tip {
      margin-top: 10px;
    }
  }
  
  .materials-card {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .materials-tip {
      padding: 30px 0;
    }
    
    .pagination-container {
      display: flex;
      justify-content: flex-end;
      margin-top: 20px;
    }
  }
}
</style> 