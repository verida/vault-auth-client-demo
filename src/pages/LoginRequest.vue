<template>
  <div>
    <QRCode v-model="dialog"/>
    <div class="container">
      <h1>Login Request</h1>
      <Button :buttonAction="open">
        <span>Login with</span>
        <VeridaLogo :width="67" textColor="white"/>
      </Button>
    </div>
  </div>

</template>

<script>
import Button from '../components/Button'
import QRCode from '../modals/QRCode'
import VeridaLogo from '../components/VeridaLogo'

export default {
  name: 'LoginRequest',
  components: {
    QRCode,
    Button,
    VeridaLogo,
  },
  data () {
    return {
      dialog: false,
    }
  },
  methods: {
    open() {
      this.dialog = true
    }
  }
}
</script>

<style scoped>
h1 {
  margin: 40px 0 80px;
}
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
