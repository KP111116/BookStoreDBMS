import psycopg2

hostname = 'localhost'
database = 'LookInnaBookDB'
username = 'postgres'
pwd = 'postgres'
port_id = 5432
user_id = 1

try:
    conn = psycopg2.connect(
        host=hostname,
        dbname=database,
        user=username,
        password=pwd,
        port=port_id)
    cur = conn.cursor()
except Exception as error:
    print(error)


def print_main_menu():
    print("-------------Look INNA Book----------------\n")
    print("---------------Main Menu-------------------\n")
    print("\n")
    print("1. Search Books by Title\n")
    print("2. Search Books by Publisher\n")
    print("3. Search Books by Authors\n")
    print("4. Search Books by Year Published\n")
    print("basket: to view your basket")
    print("po: to view previous order")
    return input("Your choice: \n")


def print_search_by_book():
    print("S E A R C H   B Y    T I T L E\n")
    book_name = input("Enter book name\n")
    return book_name


def print_search_by_publisher():
    print("S E A R C H   B Y    P U B L I S H E R\n")
    return input("Enter publisher name:\n")


def print_search_by_author():
    print("S E A R C H   B Y    A U T H O R\n")
    return input("Enter author name:\n")


def register():
    user_name = input("Enter a username:\n")
    user_password = input("Enter an alphanumeric password:\n")
    user_address_line = input("Enter address line: \n")
    user_postal_code = input("Enter postal code:\n")
    user_province = input("Enter province:\n")
    user_phone = input("Enter phone number:\n")
    cur.execute("")
    return user_name


def login():



login()
cur.close()
conn.close()
