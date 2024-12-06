/*import { readFileSync } from 'node:fs';
import * as Parser from './grammar.js';


const filePath = process.argv[2];
const data = readFileSync(filePath, 'utf-8');
const salida = Parser.parse(data.trim());

console.log(salida);
*/

import * as parser from './grammar'; // Usa "import * as" para cargar el módulo completo

import * as fs from 'fs';

function mostrarError(entrada: string, error: any): void {
  const lineas = entrada.split('\n');
  const { start, end } = error.location;

  console.error(`\nError de análisis:`);
  console.error(`Mensaje: ${error.message}`);
  console.error(`Línea: ${start.line}, Columna: ${start.column}`);
  console.error(`${lineas[start.line - 1]}`); // Muestra la línea del error
  console.error(' '.repeat(start.column - 1) + '^'); // Marca el lugar del error
}

function main(): void {
 

  // Leer entrada desde archivo o directamente como string
  const entrada = fs.readFileSync('./grammar/entrada.txt', 'utf-8'); // Archivo de entrada con el código a analizar

  try {
    const resultado = parser.parse(entrada);
    console.log('Análisis exitoso:');
    console.log(resultado);
  } catch (error: any) {
    if (error.location) {
      mostrarError(entrada, error); // Captura errores léxicos o sintácticos
    } else {
      console.error('Error inesperado:', error);
    }
  }
}

// Ejecutar la función principal
main();