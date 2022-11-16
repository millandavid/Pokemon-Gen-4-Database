<template>
  <div class="Home-Page">

    <div class="wrapper">
      <div class="box a">
        <h1>Group 69</h1>
        <h3 >Millan David </h3>
        <h3 >Paul Gameiro</h3>
      </div>
      <div class="box b">
        <h1>Github Repo</h1>
        <h4 class="text-h6 text-left">Link to GitHub Repository <a target="_blank" href = "https://github.com/millandavid/Pokemon-Gen-4-Database"> HERE</a></h4>
      </div>
      <div class="box c">
        <h1>Instructions</h1>
        <p>loremloremlorem</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>

  .tabcontent{
    padding-left:50px;
  }

  .Home-Page{
    background-image: url("../assets/sinnoh.jpg");
    height: 100%;
    width: 100%;
    overflow: hidden;
    background-size: cover;
    background-position: center;
  }

  // css for info
  .wrapper {
    margin-top: 3%;
    margin-left: 5vw;
    width: 90%;
    display: grid;
    grid-template-columns: 50% 50% ;
    background-color: #444;
    border-radius: 25px;
  }

  .box {
    background-color: #fff;
    color: #000;
    padding: 20px;
  }

  .a {
    grid-column: 1 / 2;
    grid-row: 1;
  }
  .b {
    grid-column: 2 / 3;
    grid-row: 1;
  }
  .c {
    grid-column: 1 / 3;
    grid-row: 2 ;
  }

</style>
