<template>
  <div class="hello">
      <div class="" v-if="!loggedIn">
        <input type="text" v-model="appName" />
        <p class="btn" verida-vault-login-btn="true" @click="startLogin">
          <span>{{ buttonText }}</span>
          <VeridaLogo :width="67" textColor="white"/>
        </p>
      </div>
      <div v-if="loggedIn" id="result-container">
        <p>Welcome <strong>{{ veridaApp.user.did }}</strong>, you are now connected to <strong>{{ veridaApp.appName }}</strong>!</p>
        <div class="databases">
          <p>The following databases were found in this application:</p>
          <ol>
            <li v-for="(item, index) in databases" :key="index">{{ item.dbName }}</li>
          </ol>
        </div>
      </div>
  </div>
</template>

<script>
import { veridaVaultLogin } from '@verida/vault-auth-client'
import VeridaLogo from './VeridaLogo'
import Verida from '@verida/datastore'

export default {
  name: 'HelloWorld',
  props: {
    buttonText: String
  },
  components: {
    VeridaLogo
  },
  data() {
    return {
      appName: 'Verida: Auth client demo',
      loggedIn: false,
      databases: [],
      veridaApp: null
    }
  },
  methods: {
    startLogin () {
      console.log("starting login with ", this.appName)
      veridaVaultLogin({
        loginUri: 'http://192.168.1.29:8080/mobile/auth-request.html',
        serverUri: 'ws://192.168.1.29:7001',
        appName: this.appName,
        callback: async (response) => {
          console.log(`${response.did} succesfully logged in`)

          const veridaApp = new Verida({
              did: response.did,
              signature: response.signature,
              appName: this.appName
          })

          await veridaApp.connect(true)
          this.loggedIn = true
          this.veridaApp = window.veridaApp = veridaApp
          let ds = await window.veridaApp.openDatastore("https://schemas.verida.io/storage/database/schema.json")
          this.databases = await ds.getMany()
        }
      });
    }
  }
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
#result-container .databases {
  max-width: 600px;
  text-align: left;
  margin: auto;
}
</style>
