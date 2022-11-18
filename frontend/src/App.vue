<template>
  <v-app id="app">
      <v-bottom-navigation
      color="#ff6b6b"
      grow
      mandatory
      >

      <v-btn to="/" class="nav-btn">
        <span class="text-h5 text-left"> Home </span>
      </v-btn>

      <v-btn to="/About" >
        <span class="text-h5 text-left">About</span>
      </v-btn>

      <v-btn to="/ER" >
        <span class="text-h5 text-left">ER Diagram</span>
      </v-btn>

      <v-btn to="/Database" >
        <span class="text-h5 text-left">Database</span>
      </v-btn>

      </v-bottom-navigation>

    <router-view />
  </v-app>
</template>

<style>
  .v-bottom-navigation {
    justify-content: right;
  }
</style>

<script>
export default {
  title: '',

};
</script>
