var Action3 = function() { }

Action3.prototype = {

run: function(parameters) {
parameters.completionFunction({"URL": document.URL, "title": document.title });
},

finalize: function(parameters) {
  var customJavaScript = parameters["customJavaScript"];
  eval(customJavaScript);
}

};

var ExtensionPreprocessingJS = new Action


