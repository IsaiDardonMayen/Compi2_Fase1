import React, { useState, useRef } from 'react'
import '../css/style.css';
import * as Parser from '../lib/parser/peg-parser'; // Importar el parser generado por Peggy.js

export const Home = () => {
  const [fileContent, setFileContent] = useState('');
  const [parsedOutput, setParsedOutput] = useState('');
  const editorRef = useRef(null); // Referencia al editor

  const handleOpenFile = (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();
    reader.onload = () => {
      const text = reader.result;
      setFileContent(text); // Establecer el contenido del archivo en el estado
    };
    reader.readAsText(file);
  };
//sss
  const handleExecute = () => {
    const editorContent = editorRef.current.innerText; // Capturar el texto del editor
    console.log('Texto del editor:', editorContent);

    try {
      const parsedResult = Parser.parse(editorContent); // Parsear el texto usando Peggy.js
      setParsedOutput("No hay ningun error Lexico O Semantico!:)"); // Guardar el resultado parseado
    } catch (error) {
      console.error('Error al parsear:', error);
      setParsedOutput(`Error al parsear: ${error.message}`);
    }
  };

  return (
    <div>
      <header className="header">
        <button id="Abrir" onClick={() => document.getElementById('fileInput').click()}>
          Abrir archivo
        </button>
        <button id="Ejecutar" onClick={handleExecute}>
          Ejecutar
        </button>
      </header>

      <input 
        type="file" 
        id="fileInput" 
        style={{ display: 'none' }} 
        onChange={handleOpenFile} // Manejador de evento para cuando el archivo se selecciona
      />

      <main className="container">
        {/* Editor ahora es un div desplazable y editable */}
        <div 
          id="editor" 
          contentEditable={true} 
          className="code-editor"
          ref={editorRef} // Asignación de referencia
        >
          {fileContent}
        </div>

        <textarea 
          id="salida" 
          readOnly 
          value={parsedOutput} // Mostrar el resultado del parsing
          className="code-output"
        />
      </main>
    </div>
  );
};
