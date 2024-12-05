import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import {Home} from './components/home'; // importamos el componente Home donde se encuentra la pagina principal


function App() {
  return (
    <Router>
      <Routes>
        
        <Route path="/" element={<Home />} />
      </Routes>  
    </Router>

  );
}

export default App;
