std_msgs/Header header

## Scaled IMU Data ##
geometry_msgs/Vector3 angular_velocity
geometry_msgs/Vector3 linear_acceleration

## Data Counters ##
uint64 imu_count
uint64 driver_count
uint64 drop_count

## UTC Timestamp from HW ##
uint32 buf_utc_sec
uint32 buf_utc_usec
