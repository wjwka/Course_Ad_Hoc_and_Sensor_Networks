#
# This class is automatically generated by mig. DO NOT EDIT THIS FILE.
# This class implements a Python interface to the 'Sensing'
# message type.
#

import tinyos.message.Message

# The default size of this message type in bytes.
DEFAULT_MESSAGE_SIZE = 8

# The Active Message type associated with this message.
AM_TYPE = -1

class Sensing(tinyos.message.Message.Message):
    # Create a new Sensing of size 8.
    def __init__(self, data="", addr=None, gid=None, base_offset=0, data_length=8):
        tinyos.message.Message.Message.__init__(self, data, addr, gid, base_offset, data_length)
        self.amTypeSet(AM_TYPE)
    
    # Get AM_TYPE
    def get_amType(cls):
        return AM_TYPE
    
    get_amType = classmethod(get_amType)
    
    #
    # Return a String representation of this message. Includes the
    # message type name and the non-indexed field values.
    #
    def __str__(self):
        s = "Message <Sensing> \n"
        try:
            s += "  [seqno=0x%x]\n" % (self.get_seqno())
        except:
            pass
        try:
            s += "  [sender=0x%x]\n" % (self.get_sender())
        except:
            pass
        try:
            s += "  [humidity=0x%x]\n" % (self.get_humidity())
        except:
            pass
        try:
            s += "  [light=0x%x]\n" % (self.get_light())
        except:
            pass
        return s

    # Message-type-specific access methods appear below.

    #
    # Accessor methods for field: seqno
    #   Field type: int
    #   Offset (bits): 0
    #   Size (bits): 16
    #

    #
    # Return whether the field 'seqno' is signed (False).
    #
    def isSigned_seqno(self):
        return False
    
    #
    # Return whether the field 'seqno' is an array (False).
    #
    def isArray_seqno(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'seqno'
    #
    def offset_seqno(self):
        return (0 / 8)
    
    #
    # Return the offset (in bits) of the field 'seqno'
    #
    def offsetBits_seqno(self):
        return 0
    
    #
    # Return the value (as a int) of the field 'seqno'
    #
    def get_seqno(self):
        return self.getUIntElement(self.offsetBits_seqno(), 16, 1)
    
    #
    # Set the value of the field 'seqno'
    #
    def set_seqno(self, value):
        self.setUIntElement(self.offsetBits_seqno(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'seqno'
    #
    def size_seqno(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'seqno'
    #
    def sizeBits_seqno(self):
        return 16
    
    #
    # Accessor methods for field: sender
    #   Field type: int
    #   Offset (bits): 16
    #   Size (bits): 16
    #

    #
    # Return whether the field 'sender' is signed (False).
    #
    def isSigned_sender(self):
        return False
    
    #
    # Return whether the field 'sender' is an array (False).
    #
    def isArray_sender(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'sender'
    #
    def offset_sender(self):
        return (16 / 8)
    
    #
    # Return the offset (in bits) of the field 'sender'
    #
    def offsetBits_sender(self):
        return 16
    
    #
    # Return the value (as a int) of the field 'sender'
    #
    def get_sender(self):
        return self.getUIntElement(self.offsetBits_sender(), 16, 1)
    
    #
    # Set the value of the field 'sender'
    #
    def set_sender(self, value):
        self.setUIntElement(self.offsetBits_sender(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'sender'
    #
    def size_sender(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'sender'
    #
    def sizeBits_sender(self):
        return 16
    
    #
    # Accessor methods for field: humidity
    #   Field type: int
    #   Offset (bits): 32
    #   Size (bits): 16
    #

    #
    # Return whether the field 'humidity' is signed (False).
    #
    def isSigned_humidity(self):
        return False
    
    #
    # Return whether the field 'humidity' is an array (False).
    #
    def isArray_humidity(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'humidity'
    #
    def offset_humidity(self):
        return (32 / 8)
    
    #
    # Return the offset (in bits) of the field 'humidity'
    #
    def offsetBits_humidity(self):
        return 32
    
    #
    # Return the value (as a int) of the field 'humidity'
    #
    def get_humidity(self):
        return self.getUIntElement(self.offsetBits_humidity(), 16, 1)
    
    #
    # Set the value of the field 'humidity'
    #
    def set_humidity(self, value):
        self.setUIntElement(self.offsetBits_humidity(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'humidity'
    #
    def size_humidity(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'humidity'
    #
    def sizeBits_humidity(self):
        return 16
    
    #
    # Accessor methods for field: light
    #   Field type: int
    #   Offset (bits): 48
    #   Size (bits): 16
    #

    #
    # Return whether the field 'light' is signed (False).
    #
    def isSigned_light(self):
        return False
    
    #
    # Return whether the field 'light' is an array (False).
    #
    def isArray_light(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'light'
    #
    def offset_light(self):
        return (48 / 8)
    
    #
    # Return the offset (in bits) of the field 'light'
    #
    def offsetBits_light(self):
        return 48
    
    #
    # Return the value (as a int) of the field 'light'
    #
    def get_light(self):
        return self.getUIntElement(self.offsetBits_light(), 16, 1)
    
    #
    # Set the value of the field 'light'
    #
    def set_light(self, value):
        self.setUIntElement(self.offsetBits_light(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'light'
    #
    def size_light(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'light'
    #
    def sizeBits_light(self):
        return 16
    
