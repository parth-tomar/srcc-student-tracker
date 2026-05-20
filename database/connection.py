"""
database/connection.py
Singleton MySQL connection manager using mysql-connector-python.
"""

import os
import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv

load_dotenv()


class Database:
    _connection = None

    @classmethod
    def get_connection(cls):
        if cls._connection is None or not cls._connection.is_connected():
            try:
                cls._connection = mysql.connector.connect(
                    host=os.getenv("DB_HOST", "localhost"),
                    user=os.getenv("DB_USER", "root"),
                    password=os.getenv("DB_PASSWORD", ""),
                    database=os.getenv("DB_NAME", "srcc_tracker"),
                    charset="utf8mb4",
                    autocommit=False,
                )
            except Error as e:
                print(f"[DB ERROR] Could not connect: {e}")
                raise
        return cls._connection

    @classmethod
    def get_cursor(cls, dictionary=True):
        conn = cls.get_connection()
        return conn.cursor(dictionary=dictionary)

    @classmethod
    def commit(cls):
        if cls._connection:
            cls._connection.commit()

    @classmethod
    def rollback(cls):
        if cls._connection:
            cls._connection.rollback()

    @classmethod
    def close(cls):
        if cls._connection and cls._connection.is_connected():
            cls._connection.close()
            cls._connection = None
