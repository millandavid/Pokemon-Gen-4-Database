<template>
  <div class = "database-page">
    <v-container fluid class="querySelect" v-if="queryVisible">

      <v-row align="center">
        <v-col cols="auto">
          <h1>Pokemon Generation 4 Database Interaction</h1>
        </v-col>
      </v-row>

      <v-row align="center">
       <v-col cols="auto">
         <h3>Select a query to display:</h3>
       </v-col>
      </v-row>

      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectQuery"
            :items="queries"
            item-text="value"
            item-value="id"
            label="What do you want to know?"
            persistent-hint
            return-object
            single-line
            solo
          ></v-autocomplete>
        </v-col>
        <v-col class = "btn-container">
          <v-btn text color="primary" @click="submit">Submit</v-btn>
        </v-col>
       </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  data() {
    return {

      // dropdown selections
      selectQuery: { value: 'query', id: '0' },
      queries: [
        { value: 'Select query', id: '0' }, // default query value
        // other values loaded via dropdown.json
        { value: 'hi', id: '1' },
        { value: 'xD', id: '2' },
        { value: ':3', id: '3' },
        { value: ':D', id: '4' },
      ],
      queryVisible: true,
      loading: false,

    };
  },
  methods: {
    submit() {
      console.log(this.selectQuery.value);
    },
  },
};
</script>

<style>
  table, th, td {
    border: solid 1px #ddd;
      border-collapse: collapse;
      padding: 1px 10px;
      text-align: center;
  }
  th {
      font-weight:bold;
  }

  .output{
    margin-left:12px;
  }

  .database-page{
      padding:25px;
  }

  .button{
      margin: 5px;
      text-decoration: none;
  }

  .checkboxLabel {
      margin: .4rem;
      font-weight: bold;
  }

  .filterClear{
    margin-left:10px;
  }

  .v-text-field.v-text-field--solo .v-input__control input,.v-list-item .v-list-item__title{
    caret-color: auto;
    text-align: center;
  }

  .btn-container{
    margin-bottom: 5vh;
  }
</style>
