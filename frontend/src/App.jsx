import { h } from 'preact';
import { useEffect, useState } from 'react';
import Form from '@rjsf/mui';
import validator from '@rjsf/validator-ajv8';

const baseUrl = import.meta.env.VITE_BASE_URL || '/api';
const entity = import.meta.env.VITE_ENTITY || 'Settings';
const entityUrl = `${baseUrl}/${entity}`; // Supports GET and PUT
const jsonSchemaUrl = `${baseUrl}/JsonSchema/${entity}`;
const uiSchemaUrl = `${baseUrl}/UiSchema/${entity}`;

function App() {
  const [jsonSchema, setJsonSchema] = useState(null);
  const [uiSchema, setUiSchema] = useState(null);
  const [formData, setFormData] = useState(null);

  useEffect(() => {
    const fetchSchemas = async () => {
      try {
        const jsonSchemaResponse = await fetch(jsonSchemaUrl);
        const uiSchemaResponse = await fetch(uiSchemaUrl);
        const jsonSchemaData = await jsonSchemaResponse.json();
        const uiSchemaData = await uiSchemaResponse.json();
        setJsonSchema(jsonSchemaData);
        setUiSchema(uiSchemaData);
      } catch (error) {
        console.error('Error fetching schemas:', error);
      }
    };

    fetchSchemas();
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(entityUrl);
        const data = await response.json();
        setFormData(data);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  const onSubmit = async ({formData}) => {
    console.log(formData);
    // Send formData to the backend
    try {
      const response = await fetch(entityUrl, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData)
      })
      //const data = await response.json();
      //console.log(data);
    } catch (error) {
      console.error('Error sending data:', error);
    }
  };

  return (
    <div>
      {jsonSchema && uiSchema && formData && (
        <Form 
          schema={jsonSchema}
          uiSchema={uiSchema}
          formData={formData}
          validator={validator}
          onSubmit={onSubmit}
        />
      )}
    </div>
  );
}

export default App;