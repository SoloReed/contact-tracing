({
    startGame : function(component, event, helper) {
        // access combobox
        let gameModeComboBox = component.find("gameMode");

        // access value of combobox
        let selectedValue = gameModeComboBox.get("v.value");

        const selectedMode = component.get("v.selectedMode");
        // set the value of selectedMode attribute
        component.set("v.selectedMode", selectedValue);
        if(selectedMode){
            const boardComp = component.find("boardComp");
            // call aura method
            boardComp.startGame();
        }
    },

    reshuffleBoard : function(component, event, helper) {
        console.log("Reshuffle Board is called!");
    }
})
