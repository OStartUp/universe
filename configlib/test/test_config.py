"""Unittest for one module
Test One
"""

import unittest
import config


class TestConfig(unittest.TestCase):
    """Unittest class for one module"""

    def test_getconfig(self):
        """Test one"""
        conf = config.getConfig()
        self.assertTrue(conf["version"] == "1.0.2")


if __name__ == "__main__":
    unittest.main()