"""Unittest for one module
Test One
"""

import unittest
from loggerlib.pretify import decorate


class TestUtils(unittest.TestCase):
    """Unittest class for one module"""

    def test_some_utility(self):
        """Test one"""
        deco  = decorate("aaa")
        self.assertTrue(deco == f"~~ aaa ~~")


if __name__ == "__main__":
    unittest.main()