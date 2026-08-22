Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757539CD17
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399860; cv=none; b=hmNZMjLrD9EHfKyHPp/FcEwKzc0BVNcIlHtpCH6XS9OJ+eFV9/dgfenRuIQy3vTZqIBcdGAIfC7ULctIJZhH/ze0lqoC/pI9tUh3JWctv//nj9sYvtuvGO3q9W22uwavGOk4yRU98nZRNb1SPktlxudic0AOC2sCIogyChdxh5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399860; c=relaxed/simple;
	bh=4gK705/TmhY7uaIcr6tDpW/qphXXegBSWZmY5QWyzwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cchofxoGZjkoixfTNhLUvYlszsjnkmmC4qrsvUEorZ1Y60ysfHZsZpTI95cgwWqCmhyyyHWmfhb/E2E1ETKnIj/VQkQRdHaNA2Hf40qDV5joQKClfewuY9YcPJv8bFmk7XA59hBV3nrT84xU1CzAj6m3mCwmXpgavPrBzQXlqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ZKYFstJj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZxz7RB9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ZKYFstJj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZxz7RB9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D36CBEC019B;
	Sat, 22 Aug 2026 07:57:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 22 Aug 2026 07:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787399857; x=
	1787486257; bh=PBXkk0ax2/ibDdqs3mMrlTJex2MT/lYcLgDxpA2oxF4=; b=Z
	KYFstJj5fLHvEFc1KTgzPTV6o4XUaGGEP68DfUoIcZt8Elkj2ylxVjgYCbr9wUXY
	WKt1nSnVfTFdkia8IA2K8G3rMdXcDVhk6mYGOeFBkXJHP6HG6b7HNgQuuyOTtBZc
	ZAH6QOedQtQlOt7ScOhpm2/zMyX9f7g36FXGOHtg9JW+ZQpV4dXFqtO2W5FpJf7u
	0AdWzUtzMVjIyPv0Im9nUFrYyzM9JlFAAzT8Ucjsyo8I6rWtGjYAvL8ffm40ZXuR
	KSGNSJ3UB+StejYnplZxz1acw8eNuGcrhq/dUmk1Dj7YdavS0FQrUkKxi7jzSMdH
	fW/BinYnB4ZR2NAkuNmLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787399857; x=1787486257; bh=P
	BXkk0ax2/ibDdqs3mMrlTJex2MT/lYcLgDxpA2oxF4=; b=YZxz7RB9+w1laO28V
	IHJahjXbi6DZGX2Fme/GT9xA/XCfS56JcCAy6kx8luIarHi91pq9EsARAloy5fU/
	hbUgt3eZ447vVIjtdvdCd6fchnWCJcayMEyUW56jpA2YMuX2/B8kJ2OQY9BmiCAl
	I72esajQruDaGnRXWLbxZTfB+EHK+tUl5dlzdONp1fw+R+CM24mPjzFY7HO4hlRV
	b9MvLAOWlwWAxZV9Y01b5MnCvpkYAB278WoPEmJ82/rNr9pv6WL4vSuXOtSZhPH1
	Kt+DSHD2eq6Ai1WIUymz3+Ur+TuyZ9h+CS06EQbBiEfR3yZ5aPEJJkvMuSiFRiJ/
	CwsIw==
X-ME-Sender: <xms:sY6Jakfv4Y_aAA7XotBgRRyYvrOM2QCUFu0chf4RWzOQp-JQL8Q05A>
    <xme:sY6JaskpC7osgXnrROX-NGC35iDahVIRrU-u_H554AlkzGYSJDEf7xXcRe28OkrRU
    E7XAG413GQssrr1bc9ji6TYijOPUfnd20ph2ODpsuzM90o7CyncufPK>
X-ME-Received: <xmr:sY6JahyCh44xCOic4G5-FLjSS2qf9KGed2byFPeoZUKoH_LyVzwb3ZLMjmY8Rg>
X-ME-Proxy-Cause: dmFkZTFd034jC8nUOw0TOn41m7WJNpQW59w5hf7L9oaBLHsW45NsiTTFVnR/zuULPxbddD
    ASf/reVYZ8Ev8NV8PUNiSobbfuBZ2gIV3b/e0/Mx/2J/+k4tfYp3wuPXcykYBq8NGisp4i
    SY2lINF5nemTlUi+U1oMLwTJZfpU5yMHp3qjGDCnjEqIwnmGwXAvfvIDLOjYBbqlxBCC1o
    alHQlTTgtSPhnxRJlDfvBbnqcCQQXmGL+XIRvfxHcxJK2JOyaSxbGr5QHDz9Tzsv9rmhB+
    nb+3DPKBrR0lyxBwr2dHkSZQbAye/GlnujXKDqzalusrMlR7h8K2riepHjwevI648FBzrj
    Qbyicssjs68Ulr7Ck6oCWO/y8jxs/moZ5I1fIh88jAvF/ZE9owMe7jAyas1Xb5JBJTQXNH
    nFRf+sMiJ5QVG1NJQfJXME0PIREU1PAy6gYuI8IC5JIf5tWZCn4UzwUUWVc5uolXNMXI+L
    IZpFzdLDAv15BG0X0lPwknK+V5dkfbJ+NoZNgBEsbAA4MKUUSdo7mfpEv09eE0glPO8Dbn
    5w9ID+Q2iWWvzh2XVIbpzxODYFggPNDxLscX7+wNxWBAb7sE8YY3QpTZ69pO6XDbnxInxy
    P7w1WPC80XIgCEDEPO7RhbRM8bKrwQjV/Hpc0T1MPhgh1kFRYsIuL2O8i3oA
X-ME-Proxy: <xmx:sY6Janwt1Q0jmzmq9TtFgNxzryqxXeepU-P5RS7_BP-ZZRcN9sywLg>
    <xmx:sY6JapXQ23mmg46bz6l-jXis95_2gmbc5w3wtFS8YPcVDHVvd-jIkA>
    <xmx:sY6JamT5A-0bXoqt7x1cO0VwELirZbg0K-XYm6yL_A6riFYM7wfwPg>
    <xmx:sY6JapTq3pbeKjeyFxvE0c736yNGNXmBBsV67wN-QIJS3prGTBb4-g>
    <xmx:sY6JamVtOGx757YPheygbPYT8IJQuB4GwIfEuDjcc0NDgkBkmeUSq12u>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 07:57:37 -0400 (EDT)
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
Subject: [PATCH net v3 3/4] selftests: net: Test UDP length overflow with PMTU discover and big MTU
Date: Sat, 22 Aug 2026 14:57:16 +0300
Message-ID: <20260822115717.1161782-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822115717.1161782-1-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
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
 tools/testing/selftests/net/cork_fragsize.py | 130 +++++++++++++++++++
 2 files changed, 131 insertions(+)
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
index 000000000000..d89ef9892329
--- /dev/null
+++ b/tools/testing/selftests/net/cork_fragsize.py
@@ -0,0 +1,130 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.
+
+from lib.py import ksft_run, ksft_exit, ksft_true, KsftSkipEx
+from lib.py import ip, NetNS, NetNSEnter
+import errno
+import gzip
+import os
+import socket
+import struct
+import subprocess
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
+def check_kernel_config(option) -> bool | None:
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
+
+
+def assert_debug_kernel() -> None:
+    res = check_kernel_config('CONFIG_DEBUG_NET')
+    if res is None:
+        print("WARN: Can't read kernel config; assuming debug kernel, and running the test")
+    elif not res:
+        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')
+
+
+def check_dmesg_clean(func) -> bool:
+    dmesg = subprocess.Popen(['dmesg'], stdout=subprocess.PIPE)
+    result = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout)
+    dmesg.wait()
+    return result.returncode != 0 and dmesg.returncode == 0
+
+
+def ip_setup(ns: NetNS, mtu: int, ipv6: bool) -> None:
+    ip('link add dummy type dummy', ns=ns)
+    ip(f'link set dummy mtu {mtu}', ns=ns)
+    ip('link set dummy up', ns=ns)
+    flag = '-6' if ipv6 else ''
+    nodad = 'nodad' if ipv6 else ''
+    addr_local = 'fd00::1/64' if ipv6 else '10.0.0.1/24'
+    addr_remote = 'fd00::2' if ipv6 else '10.0.0.2'
+    ip(f'{flag} addr add {addr_local} dev dummy {nodad}', ns=ns)
+    ip(f'{flag} neigh add {addr_remote} lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
+
+
+def test_ipv6() -> None:
+    assert_debug_kernel()
+
+    with NetNS() as ns:
+        ip_setup(ns, 65576, True)
+
+        with NetNSEnter(ns):
+            with socket.socket(socket.AF_INET6, socket.SOCK_DGRAM) as fd:
+                fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER, IPV6_PMTUDISC_DO)
+                try:
+                    fd.sendto(b' ' * 65528, ('fd00::2', 1234))
+                except OSError as e:
+                    # Ignore EMSGSIZE: it happens on kernels with the fix.
+                    if e.errno != errno.EMSGSIZE:
+                        raise
+
+        ip('link del dummy', ns=ns)
+
+    ksft_true(check_dmesg_clean('udp_v6_send_skb'), 'WARNING detected in dmesg')
+
+
+def test_ipv4() -> None:
+    assert_debug_kernel()
+
+    with NetNS() as ns:
+        ip_setup(ns, 65556, False)
+
+        with NetNSEnter(ns):
+            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as fd:
+                fd.setsockopt(socket.IPPROTO_IP, IP_MTU_DISCOVER, IP_PMTUDISC_PROBE)
+                try:
+                    fd.sendto(b' ' * 65528, ('10.0.0.2', 1234))
+                except OSError as e:
+                    # Ignore EMSGSIZE: the check happens after the WARN is printed.
+                    if e.errno != errno.EMSGSIZE:
+                        raise
+
+        ip('link del dummy', ns=ns)
+
+    ksft_true(check_dmesg_clean('udp_send_skb'), 'WARNING detected in dmesg')
+
+
+def test_ipv6_jumbo() -> None:
+    with NetNS() as ns:
+        ip_setup(ns, 65584, True)
+
+        with NetNSEnter(ns):
+            with socket.socket(socket.AF_INET6, socket.SOCK_RAW, socket.IPPROTO_UDP) as fd:
+                hopopts = struct.pack('!BBBBI', 0, 0, IPV6_TLV_JUMBO, 4, 65544)
+                fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_HOPOPTS, hopopts)
+                fd.setsockopt(socket.IPPROTO_IPV6, socket.IPV6_CHECKSUM, 6)
+                fd.setsockopt(socket.IPPROTO_IPV6, IPV6_MTU_DISCOVER, IPV6_PMTUDISC_PROBE)
+                udp = struct.pack('!HHHH', 1234, 1234, 0, 0) + b' ' * 65528
+                fd.sendto(udp, ('fd00::2', 0))
+
+        ip('link del dummy', ns=ns)
+
+
+if __name__ == "__main__":
+    ksft_run([
+        test_ipv6,
+        test_ipv4,
+        test_ipv6_jumbo,
+    ])
+    ksft_exit()
-- 
2.55.0

