import { readFileSync } from 'node:fs';
import * as Parser from './grammar.js';


const filePath = process.argv[2];
const data = readFileSync(filePath, 'utf-8');
const salida = Parser.parse(data.trim());

console.log(salida);