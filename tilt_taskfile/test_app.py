import unittest
from flask import Flask
from server import app

class TestApp(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()

    def test_index(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Flask + MySQL Example", response.data)
    def test_query_db(self):
        response = self.client.get("/query")
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertTrue("databases" in data or "error" in data)
    
if __name__ == "__main__":
    unittest.main()
