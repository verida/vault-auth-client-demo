<template>
  <v-dialog
    v-model="isVisible"
    fullscreen
    hide-overlay
    transition="dialog-bottom-transition"
  >
    <v-card>
      <v-toolbar color="primary">
        <v-spacer></v-spacer>
        <v-toolbar-items>
        <v-btn
          icon
          @click="isVisible = false"
        >
          <v-icon>mdi-close</v-icon>
        </v-btn>
        </v-toolbar-items>
      </v-toolbar>
      <v-card-text>
        <div class="card-body">
          <div class="logo">
            <span>Login with</span>
            <VeridaLogo />
          </div>
          <canvas id="canvas" class="qr"></canvas>
          <p>Scan this QR code on your mobile phone to login or signup.</p>
        </div>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import AuthClient from '@verida/vault-auth-client'
import VeridaLogo from '../components/VeridaLogo'

const authConfig = {
  serverUri: "ws://localhost:7001",
  canvasId: "canvas"
}

export default {
  name: "QRCode",
  props: {
    value: Boolean
  },
  components: {
    VeridaLogo
  },
  computed: {
    isVisible: {
      get () {
        return this.value
      },
      set (value) {
         this.$emit('input', value)
      }
    }
  },
  watch: {
    isVisible(visible) {
      if (visible) this.start()
    }
  },
  methods: {
    start() {
      console.log("Starting auth process...")
      new AuthClient(authConfig)
    }
  }
};
</script>

<style scoped>
.card-body{
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 3% 0 0;
}
.qr {
  padding: 20px;
  box-shadow: 0 0 10px rgba(0,0,0,0.5);
  border-radius: 10px;
  margin-bottom: 3%;
}
.logo {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #000;
  width: 334px;
  height: 44px;
  padding: 0 0 3%;
}
.logo span {
  padding-right: 5px;
}

@media screen and (max-width: 700px), screen and (max-height: 600px) {
  .qr {
    height: 70% !important;
    width: 70% !important;
  }
  .logo {
    width: 50%;
    height: max-content;
    flex-direction: column;
  }
  .logo span {
    padding-right: 0px;
  }
}
</style>