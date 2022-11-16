import Vue from 'vue';
import VueRouter from 'vue-router';
// View import
import Home from '../views/Home.vue';
import About from '../views/About.vue';
import Database from '../views/Database.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: '/',
    component: Home,
  },
  {
    path: '/About',
    name: 'About',
    component: About,
  },
  {
    path: '/Database',
    name: 'Database',
    component: Database,
  },
];

const router = new VueRouter({
  mode: 'history',
  routes,
});

export default router;
