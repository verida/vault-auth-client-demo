<template>
  <div class="hello">
        <p class="btn" verida-vault-login-btn="true">
          <span>{{ buttonText }}</span>
          <VeridaLogo :width="67" textColor="white"/>
        </p>
  </div>
</template>

<script>
import { veridaVaultLogin } from '@verida/vault-auth-client'
import VeridaLogo from './VeridaLogo'

export default {
  name: 'HelloWorld',
  props: {
    buttonText: String
  },
  components: {
    VeridaLogo
  },
  mounted() {
    veridaVaultLogin({
      loginUri: 'http://192.168.1.29:8080/mobile/auth-request.html',
      serverUri: 'ws://localhost:7001'
    });
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.btn {
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 5px;
  width: 334px;
  height: 44px;
  border: 1px solid;
  background: #041133;
  color: #fff;
  padding: 0 15px 0 15px;
}

.btn span {
  padding-right: 10px;
}

@media screen and (max-width: 700px) {
  .btn {
    width: 50%;
    height: max-content;
    flex-direction: column;
    padding: 5px;
  }
  .btn span {
    padding-right: 0px;
  }
}
.btn:hover {
  background: #08256d;
  cursor: pointer;
}
</style>
