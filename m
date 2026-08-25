Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651213CCFAF
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688168; cv=none; b=q5OsAJmlfW0yLZ+KOTPNaq/yVlAasc/Ccy0QqVxEriGFmSdgwJdz8zuPQ+ShBnHWArUz+DtfCU4X98oLGu2ozGZ7T2ZWDt5fDCDVyzMP2ETKpwUOe2g9e/x/YY8DSjuzDb/9sFGfVxk8+MP8bakm6HHeTx4CtB+n8fW4JAhbaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688168; c=relaxed/simple;
	bh=V35f59bCekE8ZUWgSoKnxMWl4e7TWixgUoSuwhnZjw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/SD2+RyC0BcEs5XYpTwJIY5oXCG2guBUAMOZmQBmiDEGCff+EADRgl5Q2jsn+azO+Rk5cD51Pduxy88vZvmaFPmhHPXUt6vdTVacUQhWeHKMs7LtXvyxgEhzml9j4BLHJ9R9kp1E89XM2CD8G1QH9o2Gwmq6j/kyeBtQz+AXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=raIwyEfq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCTWymny; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="raIwyEfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCTWymny"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 61DFA1D00165;
	Tue, 25 Aug 2026 16:02:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Aug 2026 16:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787688165; x=
	1787774565; bh=gEHX+HGWLn027ubYLehx1qhJWLQcdlONruIakDHL3Ik=; b=r
	aIwyEfqa5wEAWZpfkZJ04EFkL5lsMgt5hVqCpVK17RLMtOjv97fyaNt278/hcvA4
	0XOYhgdKizJ/5C/vZc3T67MPfBv7VPbQhj3gvd1XjXlOnsGj9GcQb6z78h0Km3Jl
	ErzevXuyUKDO+9cR2yHkGkx3wM13oVAaMRd7Y9QxACV+1uNlf7E2/wX7RBPd6uKQ
	c1Bjj+gjyJtczNhh2iploZSRcL9IwKTxxGhYyFFLJznpsabYEtp79AOzRfn+0nG2
	Echrg7zxVnH55kV8Orq0xILNDeoPjUZzqnW3TKw+j9EtsuKdrFUhS/13MFHd+3de
	IlVRgLHJeCmchOnXKmTwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787688165; x=1787774565; bh=g
	EHX+HGWLn027ubYLehx1qhJWLQcdlONruIakDHL3Ik=; b=HCTWymnyWVbJJVJ+F
	wOGEVcp9ku4Y4RNjrq6B79akF7PGlODBlGVoMD7rVkXSThM7Vxwc7Mnmcs4mM6yM
	w9duVHc2nzVtwFfV1x2CSTFVj1M1QBr0nlZYxxqZvtIuvKqe6adCYvBc44JSfoi0
	3tZlNfSl7ct+nBu6zLvky7iBnKzh9h0+Rt9FaGbZTanm0aXPQ0mgx5/wCqr7iBIr
	UpxyU8Y2bPg61L7x/4iduqKrqpLBbcqXGyMIaKgGJ0OWgvf9KDZjmnlbqQsaC6tI
	uy2qwCdl9WkU1png0CK2e9g/Ra1cg9YzwK0sk3DB4nUSRPu6W9XiCq6QJfr08Dvm
	MX4fg==
X-ME-Sender: <xms:5fSNarI0YJ7FdivB4Om_1iTwVyA4XuDOzuGGSwdvJxeEumytNdSk4w>
    <xme:5fSNalja0CBlcAfn0KCgUfYi6Gn3JBwuFAxnhTez8HqVr5CtXUaYvJn5zo9PXmAut
    CMZAA7vONYf6h4UGBE0UlFDJfpcWs3_ql6CxZ-NHxvQpXLjZY6pUffy>
X-ME-Received: <xmr:5fSNav8oKLMUsvITwiQCv4hrtPB3CWk3lplFe8Hvg_x1HSylmx9owgnakIQ3wTdDKnxLJIIwP0U3d2EyHCY>
X-ME-Proxy-Cause: dmFkZTGRNBp03G1ZbyME3RHAiv1rQV9qYSv5xTLueOSqmrut0f4R/qcwU1eteo2mFEXDeU
    lUytmqAEzGq57viy/QCGXRAPCkTiTdUidxtXRyBySk+R1SpPp7DyJ48FVkQJldnb2Ma9uB
    RDfcuagw1YanDHMKSAkcO8dxB/sV6lfVWzop+R/6BSNwVlu6Cg6EfbI6Ho8VnwovKcYQ3h
    uPgVy9f92wYhHS9t1Z4uYYaDAE6mInHPAffsMoCfD5eFbrf+V0p9ctRACP2YAth2WKTctj
    FTWnmiw2CNgXpzBVO2QDDMyrO0wlJfV3HGyAqX+WsjaurUbi/mb8aqHEWjpDW2L8ohXkIu
    2IRX94AuCiX/EQ65qbzeajEawc2gLFPKn/87jSI7NcMJBDaAHKgJuW1wg+CqSsGebKF87/
    mKwp+rg/3CGjLfKntj6RRfUlxEn/Slx/6hh+ZCAdtMkpMz94epAWrlX2cO2tn7PzYJDzrZ
    GIh28FoTKGFjRYVTxL0tIov4FkO4l3BbAfs1r1bV+7CKR4jLBBQI/SQchsYfLzwc1GJQJr
    LYHgGANb9MHU/5PA+zOspTZr9aVn8NUam5ohvRg+ilXySUTdWjb8nje0fLTqCsP1V7sKC5
    +S/H/+KmjHEUuHV5ikIULpcexmvh2ltSkqmFfGRcWQoBzIVKmeKGHy0Kj56g
X-ME-Proxy: <xmx:5fSNaiMucK-EAwn7Rg79kck4-hrpjiVuBreNBTkJMzsmgilStET-Rw>
    <xmx:5fSNarAhZfefwl9JZqp_zbfiMqEP1gqkIOwTDX1bUbuOe0NxuW-a4Q>
    <xmx:5fSNauPDPe7T7cKKOrCF86FwLFYx1a0oFCSKoKdJmiKa4Dp4mmJibA>
    <xmx:5fSNaqc8fNcPJkj3ZIpPIUF66klCScc37RhFIMm4E4-pgHO7VTApzA>
    <xmx:5fSNatSVdPPkdT2Av7VwC-SvKpf6PtmeSvfBlWVxxT99F2QMP7OHB4Nl>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 16:02:44 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net v4 3/4] selftests: net: Test UDP length overflow with PMTU discover and big MTU
Date: Tue, 25 Aug 2026 23:02:14 +0300
Message-ID: <20260825200215.90326-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825200215.90326-1-alice.kernel@fastmail.im>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

Two previous commits fixed overflow of UDP length when setsockopt
IP(V6)_MTU_DISCOVER is set to IPV6_PMTUDISC_DO or IP(V6)_PMTUDISC_PROBE,
and a large packet is sent over a netdev with an unusually large MTU.

This commit adds the selftests that replicate the described steps to
reproduce for IPv6 and IPv4, and also one more test that ensures that
sending UDP jumbograms over a raw socket is still possible after the
fix.

Signed-off-by: Alice Mikityanska <alice@isovalent.com>
---
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/cork_fragsize.py | 140 +++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100755 tools/testing/selftests/net/cork_fragsize.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 0f5c178bc224..c6d332c90a54 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -25,6 +25,7 @@ TEST_PROGS := \
 	cmsg_so_mark.sh \
 	cmsg_so_priority.sh \
 	cmsg_time.sh \
+	cork_fragsize.py \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
 	ecmp_rehash.sh \
diff --git a/tools/testing/selftests/net/cork_fragsize.py b/tools/testing/selftests/net/cork_fragsize.py
new file mode 100755
index 000000000000..c54af8f21e3b
--- /dev/null
+++ b/tools/testing/selftests/net/cork_fragsize.py
@@ -0,0 +1,140 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.
+
+import errno
+import gzip
+import os
+import socket
+import struct
+import subprocess
+from contextlib import contextmanager
+
+from lib.py import KsftSkipEx, ksft_eq, ksft_raises, ksft_true
+from lib.py import KsftNamedVariant, ksft_exit, ksft_pr, ksft_run, ksft_variants
+from lib.py import NetNS, NetNSEnter, ip
+
+
+IP_MTU_DISCOVER = 10
+IP_PMTUDISC_PROBE = 3
+IPV6_MTU_DISCOVER = 23
+IPV6_PMTUDISC_DO = 2
+IPV6_PMTUDISC_PROBE = 3
+IPV6_TLV_JUMBO = 194
+
+
+def check_kernel_config(option: str) -> bool | None:
+    for filename, method in [
+        ('/proc/config.gz', gzip.open),
+        (f'/boot/config-{os.uname().release}', open),
+    ]:
+        try:
+            with method(filename, 'rt') as config:
+                for line in config:
+                    if line.rstrip() == f'{option}=y':
+                        return True
+                return False
+        except OSError:
+            continue
+        return None
+
+
+def assert_debug_kernel() -> None:
+    res = check_kernel_config('CONFIG_DEBUG_NET')
+    if res is None:
+        ksft_pr("WARN: Can't read kernel config; assuming debug kernel, and running the test")
+    elif not res:
+        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')
+
+
+def check_dmesg_clean(func: str) -> bool:
+    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
+        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
+    return res.returncode != 0 and dmesg.returncode == 0
+
+
+@contextmanager
+def dummy_netdev(ns: NetNS, mtu: int, ipv6: bool) -> None:
+    try:
+        ip('link add dummy type dummy', ns=ns)
+        ip(f'link set dummy mtu {mtu}', ns=ns)
+        ip('link set dummy up', ns=ns)
+        flag = '-6' if ipv6 else ''
+        nodad = 'nodad' if ipv6 else ''
+        local = 'fd00::1/64' if ipv6 else '10.0.0.1/24'
+        remote = 'fd00::2' if ipv6 else '10.0.0.2'
+        ip(f'{flag} addr add {local} dev dummy {nodad}', ns=ns)
+        ip(f'{flag} neigh add {remote} lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
+        yield
+    finally:
+        ip('link del dummy', ns=ns)
+
+
+@ksft_variants([
+    KsftNamedVariant(
+        'ipv6',
+        True,
+        socket.AF_INET6,
+        (socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER, IPV6_PMTUDISC_DO),
+        'fd00::2',
+        'udp_v6_send_skb',
+    ),
+    KsftNamedVariant(
+        'ipv4',
+        False,
+        socket.AF_INET,
+        (socket.IPPROTO_IP, IP_MTU_DISCOVER, IP_PMTUDISC_PROBE),
+        '10.0.0.2',
+        'udp_send_skb',
+    ),
+])
+def test_udp(
+    ipv6: bool,
+    af: socket.AddressFamily,
+    sockopts: tuple[int, int, int],
+    destip: str,
+    func: str
+) -> None:
+    if not ipv6:
+        assert_debug_kernel()
+
+    with (
+        NetNS() as ns,
+        dummy_netdev(ns, 65556 + 20 * ipv6, ipv6),
+        NetNSEnter(ns),
+        socket.socket(af, socket.SOCK_DGRAM) as fd
+    ):
+        fd.setsockopt(*sockopts)
+        with ksft_raises(OSError) as e:
+            fd.sendto(b' ' * 65528, (destip, 1234))
+        # IPv6: EMSGSIZE happens on kernels with the fix.
+        # IPv4: EMSGSIZE happens on both fixed and unfixed kernels, after the
+        #       WARN is printed - ignore it and rely on the dmesg check.
+        if e.exception is not None:
+            ksft_eq(e.exception.errno, errno.EMSGSIZE)
+
+    ksft_true(check_dmesg_clean(func), 'WARNING detected in dmesg')
+
+
+def test_ipv6_jumbo() -> None:
+    with (
+        NetNS() as ns,
+        dummy_netdev(ns, 65584, True),
+        NetNSEnter(ns),
+        socket.socket(socket.AF_INET6, socket.SOCK_RAW, socket.IPPROTO_UDP) as fd
+    ):
+        hopopts = struct.pack('!BBBBI', 0, 0, IPV6_TLV_JUMBO, 4, 65544)
+        fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_HOPOPTS, hopopts)
+        fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_CHECKSUM, 6)
+        fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER, IPV6_PMTUDISC_PROBE)
+        udp = struct.pack('!HHHH', 1234, 1234, 0, 0) + b' ' * 65528
+        fd.sendto(udp, ('fd00::2', 0))
+
+
+if __name__ == "__main__":
+    ksft_run([
+        test_udp,
+        test_ipv6_jumbo,
+    ])
+    ksft_exit()
-- 
2.55.0

