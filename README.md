# Hospital Management System Database

A comprehensive SQL database system designed to manage hospital operations, including patient records, appointments, medical records, and doctor feedback.

## Database Schema

The system consists of the following core tables:

- **Departments**: Stores different hospital departments
- **Patients**: Contains patient personal and authentication information
- **Doctors**: Manages doctor profiles and their department associations
- **Appointments**: Handles patient appointments with doctors
- **MedicalRecords**: Stores patient diagnoses, prescriptions, and allergies
- **DoctorFeedback**: Manages patient feedback for doctors

## Features

### Data Management
- Patient registration with secure password hashing
- Doctor profile management with specialty tracking
- Department organization
- Comprehensive medical record keeping
- Appointment scheduling and status tracking
- Patient feedback system for doctors

### Business Rules and Constraints
- Appointments cannot be scheduled in the past
- Appointment status must be one of: 'Pending', 'Completed', 'Cancelled', or 'Available'
- Doctor ratings must be between 1 and 5
- Email addresses must be unique for each patient
- Secure password storage using SHA2_256 hashing

### Automated Features
- Trigger system to automatically mark cancelled appointments as available
- Stored procedures for common operations:
  - Getting patient diagnoses and allergies for today's appointments
  - Updating doctor information
  - Deleting completed appointments

### Views
- DoctorAppointmentDetails: Provides a comprehensive view of all appointments with doctor and department information

## Sample Data

The database comes pre-populated with sample data including:
- 7 patients with diverse profiles
- 7 departments covering major medical specialties
- 7 doctors with different specializations
- Sample appointments and medical records
- Test feedback entries

## Key Queries

The system includes several key queries for common operations:
1. Finding patients over 40 with specific diagnoses
2. Searching medicines by name
3. Retrieving patient medical histories
4. Tracking appointment statistics by specialty
5. Managing appointment statuses

## Technical Details

### Database Requirements
- SQL Server (tested on Microsoft SQL Server)
- Supports IDENTITY columns for automatic ID generation
- Uses FOREIGN KEY constraints for referential integrity
- Implements CHECK constraints for data validation

### Security Features
- Password hashing using SHA2_256
- Unique constraints on sensitive data
- Input validation through constraints

## Installation

1. Create a new database named 'HospitalDB'
2. Execute the SQL scripts in sequence
3. Verify the sample data insertion
4. Test the stored procedures and triggers

## Usage Examples

### Adding a New Patient
```sql
INSERT INTO Patients 
(FirstName, LastName, Address, DateOfBirth, Insurance, Email, Phone, UserName, PasswordHash)
VALUES
('John', 'Doe', '123 Main St', '1990-01-01', 'Insurance Co', 'john@email.com', '123-456-7890', 'johndoe90', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'password123')));
```

### Scheduling an Appointment
```sql
INSERT INTO Appointments 
(PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Status)
VALUES
(1, 1, 1, '2024-12-25', '09:00:00', 'Pending');
```

## Maintenance

Regular maintenance tasks:
1. Archive completed appointments
2. Backup patient records
3. Update doctor specialties and departments as needed
4. Monitor feedback metrics

## Future Enhancements

Potential areas for expansion:
1. Integration with billing systems
2. Advanced reporting capabilities
3. Patient portal features
4. Mobile appointment notifications
5. Electronic prescription system

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.
