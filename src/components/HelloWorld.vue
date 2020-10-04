<template>
  <div class="hello">
    <button @click="start">{{ buttonText }}</button>
    <canvas id="canvas"></canvas>
  </div>
</template>

<script>
import AuthClient from '@verida/vault-auth-client'

const authConfig = {
  serverUri: "ws://localhost:7001",
  canvasId: "canvas"
}

export default {
  name: 'HelloWorld',
  props: {
    buttonText: String
  },
  methods: {
    start() {
      console.log("Starting auth process...")
      new AuthClient(authConfig)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
