import * as Parser from './grammar.js';
window.addEventListener('DOMContentLoaded', () => {
    const editableArea = document.getElementById('editable');
    const readonlyArea = document.getElementById('readonly');
    const processBtn = document.getElementById('processBtn');
    processBtn.addEventListener('click', () => {
        const inputData = editableArea.value.trim();
        try {
            const output = Parser.parse(inputData);
            readonlyArea.value = JSON.stringify(output, null, 2); // Mostrar el resultado como texto formateado
        }
        catch (error) {
            readonlyArea.value = `Error: ${error.message}`;
        }
    });
});
