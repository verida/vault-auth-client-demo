<template>
  <div class="container">
    <p class="btn" @click="buttonAction">
      <slot></slot>
    </p>
  </div>
</template>

<script>
export default {
  name: 'CustomButton',
  props: {
    buttonAction: Function,
  }
}
</script>

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
