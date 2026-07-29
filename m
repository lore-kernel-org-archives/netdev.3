Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11F3ADBA3
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307570; cv=none; b=e08+taJzFjmJgLnu7BYAV0wb96zem9VleRjON9ATmzrqoy/abr6pS0mA6fHWJyjqYH4fnjsAJrZylbsxKLpdQhxc6fuEq9gK6iwoAXnCljG8xAUf4FkFB2WAMK95Up9EIbVOuaaG1NKPotP61IOX8N0tzM7yKF7jZvVE8EupGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307570; c=relaxed/simple;
	bh=DHQ8jG1MLa2dkF76FWtM1+lotXrRIbJMN3JAKI1Wffs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKRTLZWZzOkXNcZRZvZEKFyUktDwKpvRJKOiny+oykFI092yiOh+VKsdNWjxV5nZfvSlWTB4Y2DsFh1Oeo3UZyRLdtl6KhQyKscJvFSlTOxuqyDdZUTUUcNTVm1iqzb/ZhfGzdD9tlIJHGbTwjeEcKQl5UhhhNS8oqeKv8pUVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KScRoTnr; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KScRoTnr"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bfc54558d5so614533e0c.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785307568; x=1785912368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WvzbQY6+r4yHo//P0nmvdespXXC0SxC/QUN5xESpNE0=;
        b=KScRoTnr/HcMn4sB2XdZZoFKHegJqGiMKTN2ZRf3LzMJ9pSUQvXoqowNIE1IoWZzui
         ghsbzDOt4JW55IpFeto5kicg0Cp2JjG+NLgjjRNTF8ZXGHqWZxYLfNq5oQ5YWZZnLBWx
         sVzCWOZhWJBtdff/tJWfUZOcLsFdy6DhOx8BFsk6HyBcQgLFvGqpzcsYrNhykslqicbs
         9sSB4QRal59Gzjucye98dA8K0SxELmfa2i2m19d0JGQ4+bTRPLxszJv5JX2n+CYPlS7y
         qc6KJYmteTDy+52O3GZESJaDxilQOFAJLVB/7cy/yn+ubjDiaX2cuCnVvmUxWjOHG1hG
         +h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785307568; x=1785912368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WvzbQY6+r4yHo//P0nmvdespXXC0SxC/QUN5xESpNE0=;
        b=qlkVjsFetM67wpOrkUlGp9Y+sCwAtJDg04SahbLEVl5zVoaJVOllHrziNiDmrJYWlk
         OMuU9zZGcLVsxIdI6QI+7kAsTB3RWLYNtTH/Q9PnfyROhtnfiIlBhMyEalImXEXtB9Oa
         A+JztnPfsKRud99/D/zmLCCDiLPt4fROJHzdv2VDl4Trda5oy0vXwvV3d/5/Ke/fVV1e
         322OF/kR6t19aB6RcZ6FHmGs/vRMknu8UjeVHpXExCyP75wyitq3Jh04K0tw7zKQvGfJ
         XcDq7VJ6ecvbqhqL97jsUG0/ifImd6N4MLQcXKqKsgVXZ3soqE3acR6PSNJnXP5tbms9
         /elA==
X-Gm-Message-State: AOJu0Yxeyx7TqnSvfHYIhOxhNrduvJ2LQ1Fb5Od00UfxU/X33LqEU6Y0
	NlAN/J+ppAOf2rbK+MaV7dbPRhYk9WEH+w72F+sJ95Jhquk4xsR7dFigXhlTvD7+QYdDgQ==
X-Gm-Gg: AR+sD10q/NOAaykuc/mRJa8MBIxd/QhGgjZ+EZ606fAmOwqBby/Bd70C29YztSDrGK7
	9XKzhAiYacngjhjWbnm4/c4XqbEy3XND5C7XJnaQ88f1rGwGsvr5CAlZJowvhkeVc3PA5yFUsR4
	nTp9351mOT0ZMntEM9MKx6DwWWSrtzwaAqSgPN4Muh3UJKa/EJuBl8AhqN2H6MXrLW12qglqejV
	iGw46/WqwVVGpo1bYz7QnVR0sJnptZPJjkV8sWM12025iMqsBmyaRSGDaXGHuMS/I1MNWG+C8fH
	SjosZdwr9JgXi0xwsO3TfQ5oys9C8eF+bhrgO8H/U3moz6nVu1lrr2cWJFZanPnHfaHAnxBwz1/
	wt5nKSjgarZSGUuTQKWHDpRSomZCQml50jyy1T0/Wod4vOgK8hqdCJ383fALQoGT/sZArrONc6Q
	5ZaX151sU2OPypz9iGT5mBccao3+fl0uEB9BVHFzSp4mxXw+mBNfdX
X-Received: by 2002:a05:6122:134c:b0:5a1:b296:78fc with SMTP id 71dfb90a1353d-5c3543fec63mr303085e0c.1.1785307567574;
        Tue, 28 Jul 2026 23:46:07 -0700 (PDT)
Received: from houminxi ([61.170.216.249])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c34ef4dcf5sm1548090e0c.6.2026.07.28.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 23:46:06 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH 1/2] selftests/net/openvswitch: add SCTP flow key parsing to ovs-dpctl.py
Date: Wed, 29 Jul 2026 02:45:48 -0400
Message-ID: <20260729064549.3647518-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729064549.3647518-1-houminxi@gmail.com>
References: <20260729064549.3647518-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovskey flow-string parser has no OVS_KEY_ATTR_SCTP entry, so a
flow string containing sctp(src=.../dst=...) parses without error but
silently drops the L4 key. The resulting flow carries only
ipv4(proto=132), and the kernel rejects it: match_validate() in
flow_netlink.c requires OVS_KEY_ATTR_SCTP when the IP protocol is
IPPROTO_SCTP and returns -EINVAL for the missing key.

Register OVS_KEY_ATTR_SCTP in the parse table and add unit tests
(runnable via ovs-dpctl.py --test) covering the SCTP key parser.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index f3edd198223f..944292bf9349 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -15,6 +15,7 @@ import struct
 import sys
 import time
 import types
+import unittest
 import uuid
 
 try:
@@ -1984,6 +1985,11 @@ class ovskey(nla):
                 "udp",
                 ovskey.ovs_key_udp,
             ),
+            (
+                "OVS_KEY_ATTR_SCTP",
+                "sctp",
+                ovskey.ovs_key_sctp,
+            ),
             (
                 "OVS_KEY_ATTR_ICMP",
                 "icmp",
@@ -3165,5 +3171,81 @@ def main(argv):
     return 0
 
 
+def _init_ovskey_nlas():
+    """Initialize required NLA classes for ovskey parsing."""
+    nlmsg_atoms.encap_ovskey = encap_ovskey
+    nlmsg_atoms.ovskey = ovskey
+    nlmsg_atoms.ovsactions = ovsactions
+
+
+def _parse_flow(flowstr):
+    """Parse a flow string and return the key."""
+    key = ovskey()
+    key["attrs"] = []
+    remainder = key.parse(flowstr)
+    if remainder:
+        raise ValueError(f"unparsed remainder: {remainder!r}")
+    return key
+
+
+def _find_attr(key, attr_name):
+    """Find an attribute in parsed key."""
+    for attr in key["attrs"]:
+        if attr[0] == attr_name:
+            return attr[1]
+    return None
+
+
+class TestOvsKeyParse(unittest.TestCase):
+    """Unit tests for ovskey.parse() flow string parsing."""
+
+    @classmethod
+    def setUpClass(cls):
+        _init_ovskey_nlas()
+
+    def test_sctp_dst(self):
+        """Test SCTP destination port parsing."""
+        key = _parse_flow("sctp(dst=4443)")
+        attr = _find_attr(key, "OVS_KEY_ATTR_SCTP")
+        self.assertIsNotNone(attr, "SCTP key not found")
+        self.assertEqual(attr["dst"], 4443)
+
+    def test_sctp_src(self):
+        """Test SCTP source port parsing."""
+        key = _parse_flow("sctp(src=4443)")
+        attr = _find_attr(key, "OVS_KEY_ATTR_SCTP")
+        self.assertIsNotNone(attr, "SCTP key not found")
+        self.assertEqual(attr["src"], 4443)
+
+    def test_sctp_src_and_dst(self):
+        """Test SCTP source and destination port parsing."""
+        key = _parse_flow("sctp(src=1234,dst=5678)")
+        attr = _find_attr(key, "OVS_KEY_ATTR_SCTP")
+        self.assertIsNotNone(attr, "SCTP key not found")
+        self.assertEqual(attr["src"], 1234)
+        self.assertEqual(attr["dst"], 5678)
+
+    def test_sctp_roundtrip(self):
+        """Test parse -> dpstr -> parse keeps the SCTP key."""
+        key = _parse_flow("sctp(dst=4443)")
+        key2 = ovskey()
+        key2["attrs"] = []
+        remainder = key2.parse(key.dpstr())
+        self.assertEqual(remainder, "", "round-trip left unparsed text")
+        attr = _find_attr(key2, "OVS_KEY_ATTR_SCTP")
+        self.assertIsNotNone(attr, "SCTP key lost in round-trip")
+        self.assertEqual(attr["dst"], 4443)
+
+
+def test_ovskey_parse():
+    """Test ovskey.parse() method for various flow key types."""
+    suite = unittest.TestLoader().loadTestsFromTestCase(TestOvsKeyParse)
+    runner = unittest.TextTestRunner(verbosity=2)
+    result = runner.run(suite)
+    return 0 if result.wasSuccessful() else 1
+
+
 if __name__ == "__main__":
+    if len(sys.argv) > 1 and sys.argv[1] == "--test":
+        sys.exit(test_ovskey_parse())
     sys.exit(main(sys.argv))
-- 
2.55.0

