import React, { useState, useEffect } from 'react';

import '../css/style.css';
export const Home = () => {
    const handleOpenFile = () => {
        
        document.getElementById('fileInput').click('change', (e) => {
            const file = e.target.files[0];
            const reader = new FileReader();
            reader.onload = () => {
                const text = reader.result;
                document.getElementById('editor').innerText = text;
            };
            reader.readAsText(file);
        });
    };

    const handleExecute = () => {
        console.log('Ejecutar botón presionado');
        // Lógica para manejar la ejecución
        const text = document.getElementById('editor').innerText;
        console.log(text);
    };
    return (
        
         <div>
      <header className="header">
    
        <button id="Abrir" onClick={handleOpenFile}>
          Abrir archivo
        </button>
        <button id="Ejecutar" onClick={handleExecute}>
          Ejecutar
        </button>
      </header>
      <input type="file" id="fileInput" style={{ display: 'none' }} />
      <main className="container">
        <div id="editor"></div>
        <textarea id="salida" readOnly></textarea>
      </main>
    </div>
      );
}