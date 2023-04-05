({
    doInit: function (component, event, helper) {
        console.log("Initialiation completed");
        // build a list of 100 words
        const words = helper.getWords(6);
        component.set("v.words", words);
        console.log("Words: " + words);
        // get win word
        const winWord = helper.getWinWord(words);
        component.set("v.winWord", winWord);
        console.log("Win Word: " + winWord);
    },

    doRender: function (component, event, helper) {
        console.log("Render completed");
    }
});
