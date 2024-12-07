import * as Parser from './grammar.js';
window.addEventListener('DOMContentLoaded', () => {
    const editableArea = document.getElementById('editable');
    const readonlyArea = document.getElementById('readonly');
    const processBtn = document.getElementById('processBtn');
    processBtn.addEventListener('click', () => {
        const inputData = editableArea.value.trim();
        try {
            Parser.parse(inputData);
            readonlyArea.value = "Gramática correcta.\n\n";
        }
        catch (error) {
            readonlyArea.value = `Error: ${error.message}`;
        }
    });
});
