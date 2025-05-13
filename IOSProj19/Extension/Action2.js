var Action2 = function() { }

Action2.prototype = {

run: function(parameters) {
parameters.completionFunction({"URL": document , "Domain": domain });
},

finalize: function(parameters) {
  var customJavaScript = parameters["customJavaScript"];
  eval(customJavaScript);
}

};

var ExtensionPreprocessingJS = new Action


