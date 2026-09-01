Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2944A3FA
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292685; cv=none; b=t3H7PpgxWoNxXesC1aC3YcE8WmAiyvmF8B5Ge82DGWh6/9lM8GXdSNEdZVJq2FjgpJVAkQd90or6DyHYrnLtEPGkjWpF9JOwJfyeLhuABNEK1lTjxsccIc7fEjkEi/sDxmpHKcg0tz0JeskLbfd3msPPssMwVnc19AZB7PqhUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292685; c=relaxed/simple;
	bh=j3sIE7/td1UQR5aqrkQVo32qqvjOyElnFvESsfQtLW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLCzty5NkW10nBDlkSiujRZv7W7Ai9iYymw+eEBYViK9Noy7VHp92pNdszXkALUb0NZBpnrwqJaJ9Rkoa/dvCCqVDw6pqy/yxho5wQlLxMYP+bJb9O9E1iGNKi9U7oubLlWeZgrRl7X885WQ1dLmuFj/kPbtqRQi6hltbcl7G94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=n5I8j/98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkDs9x3M; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="n5I8j/98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkDs9x3M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 986BA1D0004D;
	Tue,  1 Sep 2026 15:58:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 15:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1788292682; x=
	1788379082; bh=bUp0aDEU2Qg7BkNvZ8kFDUr9s6HJCefZfV0vTbZUqM8=; b=n
	5I8j/98Yacmez2+OQXmtuJfD0QUx9BsF0Pukc/CIGqGkjjO5wTEbvMsWNPIEyTaq
	mddyjh8mudZImPxAsqzl9wz/SVo97yKIv42B654Mg7dynRgWJ6d20k/DvJFy9vjz
	7T4zyX14eJM7RbV8TahCaWoe9O8NLm6ebStEbbruoK65gMnaZkDAfirkiq4dQumI
	Ct5br/KCI1ryvMhuaGmwJSYUfGf8COqTW8J7JT+XewoWOZ58ug7bg6HZO79LixzS
	aP4iE41RCnSK33TXQAxcgPdwu1iKoP1uNiE4PifFjQE6EpPo5IkcYcf6hfUvyzek
	3POdWhIQ8AwtGerqb26tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788292682; x=1788379082; bh=b
	Up0aDEU2Qg7BkNvZ8kFDUr9s6HJCefZfV0vTbZUqM8=; b=HkDs9x3M9gmIBb/kO
	SqESjF3LfLp4kDZBiL+dxzJ2FUbv2Yjc2flepZ2RnLHm7wQ8Yu3XUkGR2RvbUBP7
	6jeSEaPE+OnzWxvaQ5iGdlzSyiA+hMJhcdJbWUqFAVScKMj8QDN3iQjx9MH1y6YP
	8s/5S/oCDVAVGVxi4TpLqcyWJROhpcs8z8TlLNZwkxpWmD34kvXaWl13MCAmZ/5G
	8Abmt2aoBmjMlUZdb8O6T4FwyiDSDQEZ5JscRHmsN2OwzQcEeJCoOpVRqaBdaQmy
	IQrE2aMWvm9w/QwVTAdoCCnTIjhDyWCXMSso/kD7wB5fq9bQRE6lM81dIvUBc4C3
	O3Niw==
X-ME-Sender: <xms:Si6Xaq_ubTyxHyBvQ4UGk2R_-Lh_Oa6tgI0hVrXBObAoVeh83ycksw>
    <xme:Si6XaubNWeiovA5ImfCIAfBcr0gWhFc332tul5mh-wXBZyVUvZC6tnf_SaxKC0SRx
    YKkWEq7SvC1Fn8hlenX4PgMyGen_YoqiQm9XAY14PdkX2yvPlAA4EQF>
X-ME-Received: <xmr:Si6XaoqcuKgF6Od07esOrk-7Lp_VAniVAxZ5iH7oDGGPy2dI-j4vCwvuvYYuWM0X6_s6FV1mfHGkaRBkjcRByr4>
X-ME-Proxy-Cause: dmFkZTFbOziUSr6IKVqYzGMnQqqLqpz4/GW9SiBKHax7ntUiJyYR2tQiayaS8y0igZY2vR
    nV625AU9QVfc1wz1bFtctU0X3jKJ6nbYAolqzUobflk66zRPZSdPdeg22EaptFLG2NLPlQ
    oDbDHVUYLFn4qZSYUtWoGo8wgLbknoRxYsy/qzGjxCnl0yT4iXZaGbGdgUXK8MzYcioT9w
    wHgLyBooZFiULBZLRB4ObY5sY7I8nZO6YhJLgqZuvPKM2+w5gDcmxvt3BpJmK+Kk0pOJIK
    BnX5WToKcjfsd4um7E/sabkCVGKlbyPd3GlMmlAk2zX4jRYzzNDS7c/s1PcjzAxhX/PYiW
    CPFL5wIdJOzR00oAaT9d3YvmgP7hWyOcSFNLbcROBNlqCuRxS1V7nUy2fvb/86VHMzSnpc
    V3oUM80AF4MkX2C8TsrteRns+eX1OCuBaqed5Y9JKUm90p/73RHne65ImQNJghvZHnzlXR
    /HFq0vT9fKtjrJs7bGN5mmJXS36oAJbunnbPJjRnDNLM2B96UkEEyHStMWzIRg2zAPMXPC
    d8HqKkY1CWTxirM4zn9jjGNUoyvlturnEmZg4iQRe6TWSGHrtf9beVOgmSFbljOjqhU9/8
    0q0wfQGqcMM8gLfEWNaKmkeheq5WLZ8CkQzMyfmINJevVcMksP/1zPSQLEDg
X-ME-Proxy: <xmx:Si6Xaj3q9t6Qs7koWKytc1-3wYcjC84gjoHC0CUESm2Wg-904NOh0Q>
    <xmx:Si6XagkSO7u7k9zQUhY74O8By5nE0fgp3zy71ADX2jJKoMkP8nbjDw>
    <xmx:Si6XavYCxdZTHACEnO0FPob-JMFiUrdQHzDdbg1kG4gPL0G-atfhmQ>
    <xmx:Si6Xai_azmPylpN8HMZPxH_G5sWeZN4R9IyW5qmHkvUS4Um_f_folQ>
    <xmx:Si6Xal61sZA3vl2gaErVShg08vNq_Mdr_IGEFp4hHhwvgj34Lj6NP4f->
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 15:58:01 -0400 (EDT)
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
	Alice Mikityanska <alice@isovalent.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v5 3/4] selftests: net: Test UDP length overflow with PMTU discover and big MTU
Date: Tue,  1 Sep 2026 22:57:13 +0300
Message-ID: <20260901195714.673548-4-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195714.673548-1-alice.kernel@fastmail.im>
References: <20260901195714.673548-1-alice.kernel@fastmail.im>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/cork_fragsize.py | 187 +++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100755 tools/testing/selftests/net/cork_fragsize.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 517c09d60bef..3ee3378f8b26 100644
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
index 000000000000..7afd643d07ec
--- /dev/null
+++ b/tools/testing/selftests/net/cork_fragsize.py
@@ -0,0 +1,187 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+'''Test possible UDP length overflow in udp_send_skb/udp_v6_send_skb.'''
+
+import errno
+import gzip
+import os
+import socket
+import struct
+import subprocess
+from contextlib import contextmanager
+
+from lib.py import (
+    KsftNamedVariant,
+    KsftSkipEx,
+    NetNS,
+    NetNSEnter,
+    defer,
+    ip,
+    ksft_eq,
+    ksft_exit,
+    ksft_pr,
+    ksft_raises,
+    ksft_run,
+    ksft_true,
+    ksft_variants,
+)
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
+    '''
+    Check whether the option is enabled in the config of the running kernel.
+    Returns None if the config is not found; otherwise returns True/False
+    depending on the option value in the config.
+    '''
+
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
+    '''
+    Skip the test if CONFIG_DEBUG_NET is not set in the kernel config.
+    '''
+
+    res = check_kernel_config('CONFIG_DEBUG_NET')
+    if res is None:
+        ksft_pr("WARN: Can't read kernel config; assuming debug kernel, and running the test")
+    elif not res:
+        raise KsftSkipEx('CONFIG_DEBUG_NET is not set')
+
+
+def check_dmesg_clean(func: str) -> bool:
+    '''
+    Check if the given function produced a WARN in dmesg.
+    '''
+
+    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
+        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
+    return res.returncode != 0 and dmesg.returncode == 0
+
+
+@contextmanager
+def dummy_netdev(ns: NetNS, mtu: int, ipv6: bool) -> None:
+    '''
+    Create a dummy netdev inside the given namespace, and tune it for the test.
+    '''
+
+    ip('link add dummy type dummy', ns=ns)
+    with defer(ip, 'link del dummy', ns=ns):
+        ip(f'link set dummy mtu {mtu}', ns=ns)
+        ip('link set dummy up', ns=ns)
+        flag = '-6' if ipv6 else ''
+        nodad = 'nodad' if ipv6 else ''
+        local = 'fd00::1/64' if ipv6 else '10.0.0.1/24'
+        remote = 'fd00::2' if ipv6 else '10.0.0.2'
+        ip(f'{flag} addr add {local} dev dummy {nodad}', ns=ns)
+        ip(f'{flag} neigh add {remote} lladdr 02:00:00:00:00:02 dev dummy nud permanent', ns=ns)
+        yield
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
+    '''
+    Test that sending an oversized UDP packet over a UDP socket doesn't overflow
+    the 16-bit length field in the UDP header, which could happen on older
+    kernels in udp_send_skb/udp_v6_send_skb.
+
+    IPv4: The packet will be dropped with EMSGSIZE, but the overflow could
+    happen before it happens. The only way to test this is to check dmesg on
+    CONFIG_DEBUG_NET=y kernels that have udp_set_len_short with the warning.
+
+    IPv6: The packet will be dropped with EMSGSIZE on fixed kernels, and will be
+    sent corrupted on older kernels. Test both: sendto must return EMSGSIZE, and
+    dmesg must be clean of warnings on CONFIG_DEBUG_NET=y kernels.
+    '''
+
+    if not ipv6:
+        assert_debug_kernel()
+
+    with (
+        NetNS() as ns,
+        dummy_netdev(ns, 65556 + 20 * ipv6, ipv6),
+        NetNSEnter(ns),
+        socket.socket(af, socket.SOCK_DGRAM) as fd,
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
+    '''
+    Test that sending UDP jumbograms over a raw IPv6 socket works, despite
+    having the fix for oversized UDP packets. sendto must not raise an OSError
+    exception (when raised, the test fails automatically).
+    '''
+
+    with (
+        NetNS() as ns,
+        dummy_netdev(ns, 65584, True),
+        NetNSEnter(ns),
+        socket.socket(socket.AF_INET6, socket.SOCK_RAW, socket.IPPROTO_UDP) as fd,
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

