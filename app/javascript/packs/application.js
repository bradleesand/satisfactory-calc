// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
console.debug(componentRequireContext);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
