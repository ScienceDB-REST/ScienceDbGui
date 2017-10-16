const ScienceDbGlobals = {
    install(Vue, options) {
      Vue.prototype.$mainUrl = 'Main Url'
      Vue.prototype.$mainUrl = function() {
           return 'Main Url'
      }
    }
  };

  export default ScienceDbGlobals;
