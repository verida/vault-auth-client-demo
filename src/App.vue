<template>
  <div id="app" data-app>
    <LoginRequest />
  </div>
</template>

<script>
import LoginRequest from './pages/LoginRequest'

export default {
  name: 'App',
  components: {
    LoginRequest
  }
}
</script>

<style>
@font-face {
  font-family: "NunitoSans";
  src: url(./assets/fonts/NunitoSans-Regular.ttf) format("truetype");
}
#app {
  font-family: NunitoSans, Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
