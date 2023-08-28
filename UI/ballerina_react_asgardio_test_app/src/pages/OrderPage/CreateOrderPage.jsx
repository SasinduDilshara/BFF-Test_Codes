import React, { useState } from 'react';
import {
  Typography,
  TextField,
  Button,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Checkbox,
  FormControlLabel,
  FormGroup,
  Grid,
  Container,
  Paper,
} from '@mui/material';

const CreateOrderPage = () => {
  const [date, setDate] = useState('');
  const [estimationTime, setEstimationTime] = useState('');
  const [username, setUsername] = useState('');
  const [selectedItems, setSelectedItems] = useState([]);
  const allItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  const handleItemSelect = event => {
    const { value } = event.target;
    setSelectedItems(prevItems => [...prevItems, value]);
  };

  const handleSubmit = event => {
    event.preventDefault();
    // Handle form submission here
    console.log('Form submitted:', { date, estimationTime, username, selectedItems });
    const response = 
  };

  return (
    <Container component="main" maxWidth="xs">
      <Paper elevation={3} style={{ padding: '20px' }}>
        <Typography variant="h5" align="center">
          Register Order
        </Typography>
        <form onSubmit={handleSubmit}>
          <TextField
            fullWidth
            margin="normal"
            label="Date"
            type="date"
            value={date}
            onChange={e => setDate(e.target.value)}
            InputLabelProps={{
              shrink: true,
            }}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Estimation Time Arrival"
            type="time"
            value={estimationTime}
            onChange={e => setEstimationTime(e.target.value)}
            InputLabelProps={{
              shrink: true,
            }}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Username"
            value={username}
            onChange={e => setUsername(e.target.value)}
          />
          <FormControl fullWidth margin="normal">
            <InputLabel>Items</InputLabel>
            <Select
              multiple
              value={selectedItems}
              onChange={handleItemSelect}
              renderValue={selected => selected.join(', ')}
            >
              {allItems.map(item => (
                <MenuItem key={item} value={item}>
                  <Checkbox checked={selectedItems.indexOf(item) > -1} />
                  {item}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
          <Button type="submit" fullWidth variant="contained" color="primary">
            Register Order
          </Button>
        </form>
      </Paper>
    </Container>
  );
};

export default CreateOrderPage;
