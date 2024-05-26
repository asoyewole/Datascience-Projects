import pandas as pd
from faker import Faker
from datetime import datetime

# Instantiate faker. No need to use faker producer since only basic fake data is required
fake = Faker()


def data_generator(data, number):
    '''Data generator that takes in a dataframe and generates fake data that is included in the dataframe. The data generated includes:
        firstname
        lastname
        address
        phone
    PARAMETERS: data - The dataframe to which the the fake data should be included
                number - The number of fake data to be included
    '''
    start_time = datetime.now()
    data['FirstName'] = [fake.first_name() for i in range(number)]
    data['LastName'] = [fake.last_name() for i in range(number)]
    data['Address'] = [fake.address() for i in range(number)]
    data['Phone'] = [fake.phone_number() for i in range(number)]
    data['Password'] = [fake.password() for i in range(number)]
    data['Email'] = [fake.email() for i in range(number)]

    end_time = datetime.now()
    loop_time = end_time - start_time
    return data, loop_time

# load original data into pandas dataframe
data = pd.read_csv(
    "C:/Users/asoye/Documents/Projects/online+retail/Online Retail.csv")

# Number = total number of rows
number = data.shape[0]
df, time_taken = data_generator(data, number)

print(df.head())
print(f'loops completed in {time_taken}')

# Save augmented data to new csv file without index
df.to_csv('Online_Retail_with_fake_data.csv', index=False, encoding='utf-8')
