/**
 * ResizeObserver问题修复工具
 * 用于解决Element Plus组件在调整大小时出现的ResizeObserver错误
 */

/**
 * 应用全局ResizeObserver错误处理器
 * 这会忽略"ResizeObserver loop completed with undelivered notifications"错误
 */
export const applyResizeObserverErrorFix = () => {
  // 全局标志，用于判断是否已经应用了修复
  if (window.__resizeObserverFixed) {
    return;
  }
  
  // 标记为已修复
  window.__resizeObserverFixed = true;
  
  // 保存原始console.error方法
  const originalConsoleError = window.console.error;
  
  // 重写console.error，过滤掉ResizeObserver错误
  window.console.error = (...args) => {
    // 忽略ResizeObserver相关错误
    if (args[0] && 
        typeof args[0] === 'string' && 
        (args[0].includes('ResizeObserver loop') || 
         args[0].includes('ResizeObserver Loop'))) {
      return;
    }
    // 其他错误正常输出
    originalConsoleError.apply(window.console, args);
  };
  
  // 监听全局未捕获错误
  window.addEventListener('error', (event) => {
    if (event && event.message && 
        (event.message.includes('ResizeObserver loop') || 
         event.message.includes('ResizeObserver Loop'))) {
      event.preventDefault();
      event.stopPropagation();
      return false;
    }
  }, true);

  // 监听Promise未捕获错误
  window.addEventListener('unhandledrejection', (event) => {
    if (event && event.reason && 
        String(event.reason).includes('ResizeObserver loop')) {
      event.preventDefault();
      event.stopPropagation();
      return false;
    }
  });
  
  // 修复Element Plus标签页切换问题
  const fixTabsResize = () => {
    const tabNavs = document.querySelectorAll('.el-tabs__nav');
    if (tabNavs.length > 0) {
      // 使用requestAnimationFrame确保在下一帧渲染时处理
      window.requestAnimationFrame(() => {
        tabNavs.forEach(nav => {
          if (nav.parentElement) {
            const tabHeader = nav.parentElement;
            // 触发一次重新计算布局
            tabHeader.style.display = 'none';
            setTimeout(() => {
              tabHeader.style.display = '';
            }, 0);
          }
        });
      });
    }
  };
  
  // 监听标签页切换事件
  document.addEventListener('click', (e) => {
    const target = e.target;
    if (target && target.classList && 
        (target.classList.contains('el-tabs__item') || 
         target.closest('.el-tabs__item'))) {
      setTimeout(fixTabsResize, 10);
    }
  });
};

/**
 * 为Element Plus组件提供安全的配置
 * 用于避免ResizeObserver相关问题
 */
export const safeElementConfig = {
  // 禁止传送到body，减少ResizeObserver事件
  teleported: false,
  // 关闭时销毁内容，避免累积过多监听器
  destroyOnClose: true,
  // 避免自动聚焦，减少不必要的重排
  autofocus: false,
  // 在页面调整大小时减少不必要的重排
  popperOptions: {
    strategy: 'fixed',
    modifiers: [
      {
        name: 'computeStyles',
        options: {
          adaptive: false,
          gpuAcceleration: false
        }
      },
      {
        name: 'preventOverflow',
        options: {
          padding: 10
        }
      }
    ]
  }
};

/**
 * 为Element Plus标签页提供安全的配置
 * 特别处理标签页切换问题
 */
export const safeTabsConfig = {
  // 避免自动触发ResizeObserver事件
  lazy: true,
  // 在标签页切换后重新计算布局
  onTabClick: () => {
    try {
      // 延迟后触发窗口大小调整事件
      setTimeout(() => {
        window.dispatchEvent(new Event('resize'));
      }, 50);
      
      // 延迟后尝试修复标签页布局
      setTimeout(() => {
        const tabContents = document.querySelectorAll('.el-tabs__content');
        for (const content of tabContents) {
          // 强制重排
          content.style.display = 'none';
          content.offsetHeight; // 触发重排
          content.style.display = '';
        }
      }, 100);
    } catch (e) {
      // 忽略错误
    }
  }
}; 