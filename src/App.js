import React from 'react';

function App() {
  const env = process.env.REACT_APP_ENV;
  const api = process.env.REACT_APP_API_URL;

  return (
    <div style={{ 
      textAlign: 'center', 
      backgroundColor: env === 'production' ? '#1a1a1a' : '#2c3e50', 
      color: 'white', 
      height: '100vh',
      paddingTop: '50px' 
    }}>
      <h1>{env === 'production' ? '🚀 Main Production Site' : '🛠️ Dev Staging Site'}</h1>
      <p><strong>Environment:</strong> {env}</p>
      <p><strong>API URL:</strong> {api}</p>
    </div>
  );
}

export default App;
