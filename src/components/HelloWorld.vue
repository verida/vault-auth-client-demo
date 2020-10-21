<template>
  <div class="hello">
      <button verida-config-server-uri="ws://localhost:7001">{{ buttonText }}</button>
  </div>
</template>

<script>
import { veridaVaultLogin } from '@verida/vault-auth-client'

export default {
  name: 'HelloWorld',
  props: {
    buttonText: String
  },
  mounted() {
    veridaVaultLogin();
  },
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
