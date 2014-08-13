def test_set_get_long(mc):
    mc.set("key_long_short", long(1L))
    v = mc.get("key_long_short")
    assert v == 1L
    assert isinstance(v, long)

    big = 1233345435353543L
    mc.set("key_long_big", big)
    v = mc.get("key_long_big")
    assert v == big
    assert isinstance(v, long)
