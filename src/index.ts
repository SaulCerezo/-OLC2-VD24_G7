import { readFileSync } from 'node:fs';
import * as Parser from './grammar.js';

window.addEventListener('DOMContentLoaded', () => {
    const editableArea = document.getElementById('editable') as HTMLTextAreaElement;
    const readonlyArea = document.getElementById('readonly') as HTMLTextAreaElement;
    const processBtn = document.getElementById('processBtn') as HTMLButtonElement;
    const lineNumbers = document.getElementById('lineNumbers') as HTMLDivElement;

    // Función para actualizar los números de línea
    const updateLineNumbers = (): void => {
        const lines = editableArea.value.split('\n').length;
        lineNumbers.textContent = Array.from({ length: lines }, (_, i) => (i + 1).toString()).join('\n');
    };

    // Sincronizar desplazamiento entre el área de texto y los números de línea
    const syncScroll = (): void => {
        lineNumbers.scrollTop = editableArea.scrollTop;  // Sincroniza el desplazamiento
    };

    // Procesar el texto al hacer clic en el botón
    processBtn.addEventListener('click', () => {
        const inputData = editableArea.value.trim();

        try {
            Parser.parse(inputData);
            readonlyArea.value = "Gramática correcta.\n\n";
        } catch (error: any) { // Uso de `any` para manejar errores personalizados
            readonlyArea.value = `Error: ${error.message}`;
        }
    });

    // Eventos para actualizar los números de línea y sincronizar el scroll
    editableArea.addEventListener('input', () => {
        updateLineNumbers();  // Actualiza los números de línea cuando el texto cambia
    });

    editableArea.addEventListener('scroll', syncScroll);  // Sincroniza el scroll entre el textarea y los números de línea

    // Inicializar números de línea
    updateLineNumbers();
});
