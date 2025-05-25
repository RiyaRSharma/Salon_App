const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Signup a new user
router.post('/', userController.signupUser);

// Get all users
router.get('/', userController.getUsers);

// ✅ Use the correct exported function name
router.get('/profile', userController.getProfileByEmail);

// Get user by ID
router.get('/:id', userController.getUserById);

// Update user by ID
router.put('/:id', userController.updateUser);

// Delete user by ID
router.delete('/:id', userController.deleteUser);

module.exports = router;
