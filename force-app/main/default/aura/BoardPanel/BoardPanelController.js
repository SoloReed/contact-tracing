({
    startGame : function(component, event, helper) {
        // access combobox
        let gameModeComboBox = component.find("gameMode");

        // access value of combobox
        let selectedValue = gameModeComboBox.get("v.value");

        // set the value of selectedMode attribute
        component.set("v.selectedMode", selectedValue);
        console.log("The Start New Game button has been clicked! The game mode is " + selectedValue);
        console.log("The selectedMode Attribute Value is " + component.get("v.selectedMode"));
    },

    reshuffleBoard : function(component, event, helper) {
        console.log("Reshuffle Board is called!");
    }
})
