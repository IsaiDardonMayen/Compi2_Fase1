import React, { useState } from 'react';
import '../css/style.css';

export const Home = () => {
  const [fileContent, setFileContent] = useState('');

  const handleOpenFile = (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();
    reader.onload = () => {
      const text = reader.result;
      setFileContent(text); // Establecer el contenido del archivo en el estado
    };
    reader.readAsText(file);
  };

  const handleExecute = () => {
    console.log('Ejecutar botón presionado');
    // Lógica para manejar la ejecución
    console.log(fileContent); // Mostrar el contenido del archivo cargado
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
        >
          {fileContent}
        </div>

        <textarea 
          id="salida" 
          readOnly 
          value={fileContent} // Establece el contenido del archivo en el textarea
          className="code-output"
        />
      </main>
    </div>
  );
};
