
from faker import Faker
from hl7apy.core import Message
import random

fake = Faker()

def generate_random_patient_data():
    return {
        "first_name": fake.first_name(),
        "last_name": fake.last_name(),
        "birthdate": fake.date_of_birth().strftime("%Y%m%d"),
        "gender": random.choice(["M", "F"]),
        "address": fake.address().replace("\n", "^"),
    }

def create_adt_message(patient_data):
    message_type = "ADT_A01"
    msg = Message(message_type)
    msg.msh.msh_3 = "ExampleSender"
    msg.msh.msh_4 = "ExampleFacility"
    msg.msh.msh_5 = "ExampleReceiver"
    msg.msh.msh_6 = "ExampleReceiverFacility"
    msg.msh.msh_7 = fake.date_time().strftime("%Y%m%d%H%M%S")
    msg.msh.msh_9 = f"{message_type}"
    msg.msh.msh_10 = str(random.randint(100000, 999999))
    msg.msh.msh_11 = "P"
    msg.msh.msh_12 = "2.5"

    msg.evn.evn_1 = message_type.split("_")[1]
    msg.evn.evn_2 = fake.date_time().strftime("%Y%m%d%H%M%S")

    msg.pid.pid_3 = str(random.randint(100000, 999999))
    msg.pid.pid_5 = f"{patient_data['last_name']}^{patient_data['first_name']}"
    msg.pid.pid_7 = patient_data["birthdate"]
    msg.pid.pid_8 = patient_data["gender"]
    msg.pid.pid_11 = patient_data["address"]

    msg.pv1.pv1_1 = "1"
    msg.pv1.pv1_2 = "I"
    msg.pv1.pv1_3 = f"{random.randint(1, 10)}^0{random.randint(1, 9)}^00{random.randint(1, 9)}^"
    msg.pv1.pv1_18 = str(random.randint(100000, 999999))
    msg.pv1.pv1_44 = fake.date_time().strftime("%Y%m%d%H%M%S")

    msg.al1.al1_1 = "1"
    msg.al1.al1_2 = "DA"
    msg.al1.al1_3 = "001^PENICILLIN^99HIC"

    return msg.to_er7().split("\r")

if __name__ == "__main__":
    patient_data = generate_random_patient_data()
    adt_message_segments = create_adt_message(patient_data)
    print("\nGenerated ADT_A01 message:")
    for segment in adt_message_segments:
        print(segment)
