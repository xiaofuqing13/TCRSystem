<template>
  <router-view />
</template>

<script>
export default {
  name: 'App',
  created() {
    // 简化的错误处理，仅抑制 ResizeObserver 相关循环警告
    const originalConsoleError = console.error;
    console.error = function() {
      const args = Array.from(arguments);
      const firstArg = args[0];
      
      // 仅过滤掉 ResizeObserver loop 警告
      if (firstArg && 
          typeof firstArg === 'string' && 
          firstArg.includes('ResizeObserver loop')) {
        // 忽略 ResizeObserver 循环相关的错误
        return;
      }
      return originalConsoleError.apply(console, args);
    };
  }
}
</script>

<style>
html, body {
  margin: 0;
  padding: 0;
  height: 100%;
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', '微软雅黑', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#app {
  height: 100%;
}
</style> 