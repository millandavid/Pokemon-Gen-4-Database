<template>
    <div class="INTERACThome">

      <!-- forces polling on query parameter dropdowns -->
      <h1>{{vaidateQuery}}</h1>

    <v-container fluid class="querySelect" v-if="queryVisible">

         <v-row align="center">
          <v-col cols="8">
            <h3 id ="temp">Select which info you're looking for in the drop-down below</h3>
          </v-col>
         </v-row>

         <v-row align="center">
           <v-col cols="3">
            <h3>Filter Common Queries:</h3>
            <v-btn class="filterClear" @click="showAllQueries()">Show All Queries</v-btn>
           </v-col>

           <v-col cols="2">
            <div>
              <input type="checkbox" @change="pokemonCheckboxUpdate()" id="pokemonCheckbox" checked>
              <label class = "checkboxLabel" for="pokemonCheckbox">Pokemon</label>
            </div>

            <div>
              <input type="checkbox" @change="moveCheckboxUpdate()" id="moveCheckbox" checked>
              <label class = "checkboxLabel" for="moveCheckbox">Moves</label>
            </div>
           </v-col>

             <v-col cols="2">
            <div>
              <input type="checkbox" @change="teamCheckboxUpdate()" id="teamCheckbox" checked>
              <label class = "checkboxLabel" for="teamCheckbox">Teams</label>
            </div>

            <div>
              <input type="checkbox" @change="locationCheckboxUpdate()" id="locationCheckbox" checked>
              <label class = "checkboxLabel" for="locationCheckbox">Locations</label>
            </div>
            </v-col>

           <v-col cols="2">
            <div>
              <input type="checkbox" @change="typeCheckboxUpdate()" id="typeCheckbox" checked>
              <label class = "checkboxLabel" for="typeCheckbox">Types</label>
            </div>

             <div>
              <input type="checkbox" @change="otherCheckboxUpdate()" id="otherCheckbox" checked>
              <label class = "checkboxLabel" for="otherCheckbox">Other</label>
            </div>
            </v-col>
         </v-row>

      <v-row align="center">
          <v-col cols="8">
          <v-autocomplete
            v-model="selectQuery"
            :items="queries"
            item-text="value"
            item-value="id"
            label="What do you want to know?"
            persistent-hint
            return-object
            single-line
            v-on:click="this.setVisibilty(this.selectQuery.id)"
          ></v-autocomplete>
          </v-col>

        <v-col cols="4">
             <v-btn @click="makeQuery()">Query!</v-btn>
             <p v-if="errorMessageVisible" style="color:red;"> Selection Required </p>
        </v-col>
      </v-row>

    <v-row align="center" v-if="dropdownMessageVisible">
    <v-col cols="8">
        <h3>Select the specific data you're requesting below...</h3>
    </v-col>
    </v-row>
    </v-container>

    <v-container fluid class="resultView" v-if="resultsVisible">
      <v-row align="center">
          <v-col cols="8">
              <h3>View your query results below when they've loaded...</h3>
          </v-col>

        <v-col cols="4" >
             <v-btn class="button" @click="newQuery()">New Query</v-btn>
             <v-btn class="button" v-if="downloadButtonVisible" @click="downloadFile()">Download</v-btn>
        </v-col>
      </v-row>

      <v-row align="center">
          <!-- display query result table -->
          <p class = "output" id='showData'></p>
      </v-row>
    </v-container>

      <v-container fluid class="selectLocation" v-if="locationVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectLocation"
            :items="locations"
            item-text="LocationName"
            item-value="LocationName"
            label="Which location are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectAbility" v-if="abilityVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectAbility"
            :items="abilities"
            item-text="Ability"
            item-value=Dex
            label="Which ability are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

      <v-container fluid class="selectType" v-if="typeVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectType"
            :items="types"
            item-text="TypeName"
            item-value="TypeName"
            label="Which type are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectSecondType" v-if="secondTypeVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectSecondType"
            :items="types"
            item-text="TypeName"
            item-value="TypeName"
            label="What is the second type are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

     <v-container fluid class="selectTrainerName" v-if="trainerNameVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectTrainerName"
            :items="trainerNames"
            item-text=TrainerName
            item-value=TrainerName
            label="Which trainer are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectTrainerClass" v-if="trainerClassVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectTrainerClass"
            :items="trainerClasses"
            item-text=TrainerClass
            item-value=TrainerClass
            label="Which Trainer Class are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectPokemonName" v-if="pokemonNameVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectPokemon"
            :items="pokemon"
            item-text=PokemonName
            item-value=PokemonName
            label="Which Pokemon are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectEggGroup" v-if="eggGroupVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectEggGroup"
            :items="egggroups"
            item-text=GroupName
            item-value=GroupName
            label="Which Egg Group are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectBreedingMethod" v-if="breedingMethodVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectBreedingMethod"
            :items="breedingMethods"
            item-text=MoveName
            item-value=MoveName
            label="Which Breeding Type are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectLevel" v-if="levelSelectVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectLevel"
            :items="levels"
            item-text=Level
            item-value=Level
            label="Which Level are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectMove" v-if="moveVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectMove"
            :items="moves"
            item-text=MoveName
            item-value=MoveName
            label="Which move are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectStat" v-if="statVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectStat"
            :items="stats"
            item-text=stat
            item-value=stat
            label="Which stat are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectEncounter" v-if="encounterVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectEncounter"
            :items="encounters"
            item-text=Encounter
            item-value=Encounter
            label="Which Encounter are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectQuality" v-if="qualityVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectQuality"
            :items="quality"
            item-text=Quality
            item-value=Quality
            label="Which Effectiveness are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectValue" v-if="valueVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectValue"
            :items="values"
            item-text=Value
            item-value=Value
            label="Which Value are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    <v-container fluid class="selectFather" v-if="fatherVisible">
      <v-row align="center">
        <v-col cols="6">
          <v-autocomplete
            v-model="selectFather"
            :items="pokemon"
            item-text=PokemonName
            item-value=PokemonName
            label="Which Father are you looking for?"
            persistent-hint
            return-object
            single-line
            filled
          ></v-autocomplete>
        </v-col>
      </v-row>
    </v-container>

    </div>
</template>

<script>
// Import dropdown info
import dropdown from '../Dropdown.json';

// const axios = require('axios').default;

export default {
  data() {
    return {

      // used to display results of api call
      results: { value: 'default' },

      // used to track current selections
      apiStr: { url: 'init' },

      // visibility modifiers
      locationVisible: false,
      qualityVisible: false,
      abilityVisible: false,
      fatherVisible: false,
      typeVisible: false,
      secondTypeVisible: false,
      trainerNameVisible: false,
      trainerClassVisible: false,
      pokemonNameVisible: false,
      eggGroupVisible: false,
      levelSelectVisible: false,
      moveVisible: false,
      breedingMethodVisible: false,
      encounterVisible: false,
      dropdownMessageVisible: false,
      queryVisible: true,
      resultsVisible: false,
      errorMessageVisible: false,
      statVisible: false,
      valueVisible: false,
      downloadButtonVisible: true,

      // checkbox selections
      pokemonCheckbox: true,
      moveCheckbox: true,
      typeCheckbox: true,
      teamCheckbox: true,
      locationCheckbox: true,
      otherCheckbox: true,

      // dropdown selections
      selectQuery: { value: 'query', id: '0' },
      queries: [
        { value: 'What do you want to know?', id: '0' }, // default query value
        // other values loaded via dropdown.json
      ],

      selectQuality: { Quality: null },
      quality: dropdown.quality,

      selectValue: { Value: null },
      values: dropdown.values,

      selectLevel: { Level: null },
      levels: dropdown.levels,

      selectLocation: { LocationName: null },
      locations: dropdown.location,

      selectAbility: { Ability: null },
      abilities: dropdown.abilities,

      selectSecondType: { TypeName: null, Category: null },
      selectType: { TypeName: null, Category: null },
      types: dropdown.types,

      selectTrainerClass: { TrainerClass: null },
      trainerClasses: dropdown.trainerClasses,

      selectTrainerName: { TrainerName: null, TID: null },
      trainerNames: dropdown.trainerNames,

      selectPokemon: { PokemonName: null },
      selectFather: { PokemonName: null },
      pokemon: dropdown.pokemon,

      selectEggGroup: { GroupName: null },
      egggroups: dropdown.egggroups,

      selectMove: { MoveName: null },
      moves: dropdown.moves,

      selectBreedingMethod: { MoveName: null },
      breedingMethods: dropdown.breedingMethods,

      selectStat: { stat: null },
      stats: dropdown.stats,

      selectEncounter: { Encounter: null },
      encounters: dropdown.encounters,
    };
  },

  computed: {
    // make sure all appropriate values are selected for selected query
    vaidateQuery() {
      this.setVisibilty(this.selectQuery.id); // force polling on the parameter dropdown visibility
      if (this.selectQuery.id !== 0) { return 'Interact with the Database!'; }
      return 'Interact with the Database!';
    },
  },

  // called on page load
  mounted() {
    this.$nextTick(function () {
      // make all queries visible initially
      this.showAllQueries();
    });
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

  .INTERACThome{
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
</style>
