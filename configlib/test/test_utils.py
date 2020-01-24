"""Unittest for one module
Test One
"""

import unittest
import utils


class TestUtils(unittest.TestCase):
    """Unittest class for one module"""

    def test_some_utility(self):
        """Test one"""
        util = utils.someUtility("")
        self.assertTrue(util)


if __name__ == "__main__":
    unittest.main()