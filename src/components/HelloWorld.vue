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
        <p v-if="avatarSource" class="avatar"><img :src="avatarSource" /></p>
        <h3>Welcome <strong>{{ profileData.name }}</strong>!</h3>
        <p v-if="profileData.description">{{profileData.description}}</p>
        <p v-if="profileData.country">{{profileData.country}}</p>
        <p><a href="#" @click="logout">Logout</a></p>
        <hr/>
        <p>Connected to: <strong>{{ veridaApp.appName }}</strong></p>

        <div class="notes-app">
          <textarea v-model="note"></textarea>
          <button @click="saveNote">Save Note</button>
          <div class="notes">
            <h5>Encrypted Notes:</h5>
            <ol>
              <li class="note" v-for="(item, index) in notes" :key="index">{{ item.note }}</li>
            </ol>
          </div>
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
      //databases: [],
      veridaApp: null,
      profile: null,
      profileData: {},
      avatarSource: null,
      notes: [],
      note: ""
    }
  },
  methods: {
    async saveNote() {
      console.log('save note', this.note)

      let notesDb = await window.veridaApp.openDatabase("notes")
      const note = {
        note: this.note
      }
      notesDb.save(note)
      this.notes.unshift(note)
      console.log(this.notes)
    },
    logout() {
      this.loggedIn = false;
      this.profile = null
      this.profileData = {}
      this.avatarSource = null
    },
    loadAvatar() {
      if (this.profileData.avatar) {
          this.profileData.avatar = JSON.parse(this.profileData.avatar)
          this.avatarSource = `data:image/${this.profileData.avatar.format};base64,${this.profileData.avatar.base64}`
        }
    },
    startLogin () {
      console.log("starting login with ", this.appName)
      veridaVaultLogin({
        loginUri: 'https://vault.testnet.verida.io/mobile/auth-request.html',
        serverUri: 'wss://auth-server.testnet.verida.io:7001',
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
          let notesDb = await window.veridaApp.openDatabase("notes")
          this.notes = await notesDb.getMany()

          
          this.profile = await window.veridaApp.openProfile(response.did, 'Verida: Vault')
          const data = await this.profile.getMany()

          this.profileData = data.reduce((result, item) => { result[item.key] = item.value; return result }, {})
          this.loadAvatar()

          const db = await this.profile._store.getDb();
          const dbInstance = await db.getInstance();
          const component = this;
          dbInstance.changes({
              since: 'now',
              live: true
          }).on('change', async function (info) {
              const row = await db?.get(info.id, {
                rev: info.changes[0].rev
              });
              console.log(row)

              component.profileData[row.key] = row.value
              if (row.key == 'avatar') {
                this.loadAvatar()
              }
          });
        }
      });
    }
  }
}
</script>

<style>
#app {
  margin: auto;
  max-width: 500px;
  width: 80%;
  display: inherit !important;
  flex-direction: inherit !important;
}
</style>

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
  margin: auto;
  margin-top: 10px;
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
#result-container {
  max-width: 80%;
  margin: auto;
}

#result-container .databases {
  text-align: left;
  margin: auto;
}

.avatar img {
  width: 80px;
  height: 80px;
  border-radius: 40px;
}

.notes-app {
  text-align: left;
}

.notes-app textarea {
  width: 100%;
  height: 60px;
}
</style>
