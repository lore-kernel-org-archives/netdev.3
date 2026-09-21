Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871D4FD7BB
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015889; cv=none; b=o+o3/ETTrOo04Ypv48t7xRGLlPG4+25qYaGTI/zZE6KmMFQs04lXzJ3V0zdsJ5SzgyXjDPLSxylHhWy+SnTyCb5GzDffA7ALmzqlzZKcMeSOQnJIFTRh6av9GWvQC7s7uxGE+ac1p/IJM6rEZaEqurWPjd1U7MUP/uD26RmeJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015889; c=relaxed/simple;
	bh=4Mz2zKRLhU1NM/edmq7sMxvQGGqeCclZkU7VGIvBxcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N2BxqfvaZ0yV3Ov2lFnw0uZvHqSFufG6MzDFWXExXelPk7vpMHWjlueUeK+82SUOdbe1htxKnwbjoi6jKC23ORzT5enAt9hkzqy9QdKf/ZOI4RwFjI4WaId4fBM18SM8HIK1iJa4C0RrN3As7MjFvcH5kO3O8j5boI8qYHrm/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzaZWVUY; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzaZWVUY"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5329e965ba3so41695521cf.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015886; x=1790620686; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2GGW2uAYKodZkyVC/cjurxNPe9GA48w+Znxd2hVbDM=;
        b=AzaZWVUYX1Qfbv/eFYdtfKrvb2D8S4wjx/q5OlBSEj/HVaFC5RJtG7qmdOI7qUBUN4
         t4Vsvsu8QgRvUYbw9rEXrbMoOhtPGdy7CwyLkOY6L7NtBqCCUW9KBU2os/SfLgYvDADu
         rhq8VeTKMrpqM1xDPnmR8nheD4IsUebar8hgpWldxt7/eDidXr9uaA5VAMsvFguBh/ZF
         ut39JN8Y893aSg2g4VGSYjMZ8/A6+6theaPgxYbr6iPwKibGrhRs8Y81URMLgaLbArmZ
         Wox3PGn6O2kDuMajcBc5KG1vUA1LbyUq0V5Yt+v47sVpX4e2uxrnL4a3/ymmL3PssLkd
         JtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015886; x=1790620686;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2GGW2uAYKodZkyVC/cjurxNPe9GA48w+Znxd2hVbDM=;
        b=uGkEhfQjAaZ8e8Tp7tKv/kbywZolrnRYXsRrLHbh7dbsRwxMZJLuniqO7DGyBOEhVd
         f4GQOjWdQo63gVXyTnRXuoJ2aULbGrDcvSIZgd6JRF+m9j30eGjH8dObsOTehN/jNjIs
         mGrewkKsMhyivmFvw/G+T35Gzgb2CivV1SstiA4kJQEkdZct5D9eHBnxaJaBOd/91RSX
         PT3BljnXiDk2LaKInvUxrPGVbvYGnD/Sw804V3ihQKoQIR/N5HYeXQF1gf1eQbU98SNk
         Pqdh3leyWvzBWKXT/+FX+32NvPvxJEzUrvFLyqCqK0k99cmAJi1+V/Qdap9llO7iqDOW
         54PQ==
X-Forwarded-Encrypted: i=1; AKwUvBybGsleIYhIziem7AEzwnRnwzUXnB8b7oFUdJW7jhqaQjkSBHWRvi2OKovtUBFcfMdgxHMML8A=@vger.kernel.org
X-Gm-Message-State: AFuF++kUNTtqK4EI5ab+Z+tQOwp4R2USjLLU1e0tFJs/9HwcpuuiYCFE
	L+KhhQn/3aYuRG/lbj16y9EFCWyRZtSBx64a7EssyFTWDJM0UnCXzgraY0M6EiRWyV3wUkyw/tP
	IOeYFVf5TlOwHxQ==
X-Received: from qtvf15.prod.google.com ([2002:ac8:6ecf:0:b0:531:26d5:aae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:550c:b0:530:6f9f:d4b9 with SMTP id d75a77b69052e-532d8d37e9bmr18280411cf.20.1790015885626;
 Mon, 21 Sep 2026 11:38:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:37:57 +0000
In-Reply-To: <20260921183758.1812310-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921183758.1812310-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] selftests: net: check the quality of the host
 RSS key
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper library for the property netdev_rss_key_fill() now provides,
and a test checking the key the running kernel has handed out, as seen in
/proc/sys/net/core/netdev_rss_key.

The library reads back an RSS key and answers, for a position in the hash
input and a queue count, whether flows differing only in the low order bits
of a field ending there reach all the queues. It derives the position of
the named fields from the flow hash configuration rather than assuming a
4-tuple, so it describes 2-tuple hashing as well.

check_spread() uses that to report the named fields, and check_grid()
sweeps every 16-bit aligned position of the key, which is what the
generator actually promises and what a NIC hashing an encapsulated header
relies on.

This complements the KUnit tests of the generator: it does not know how the
key was made, only what it has to look like. The key is generated the first
time a driver asks for it, so the test skips on a machine whose NICs never
did.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/lib/py/__init__.py  |   5 +
 tools/testing/selftests/net/lib/py/rsskey.py  | 108 ++++++++++++++++
 tools/testing/selftests/net/netdev_rss_key.py | 117 ++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/net/lib/py/rsskey.py
 create mode 100755 tools/testing/selftests/net/netdev_rss_key.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3ee3378f8b26eff9d99a834491ad5ef594dcd782..cba6084914af5de3e8d33005484379e489c0c953 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -67,6 +67,7 @@ TEST_PROGS := \
 	nat6to4.sh \
 	ndisc_unsolicited_na_test.sh \
 	netdev-l2addr.sh \
+	netdev_rss_key.py \
 	netdevice.sh \
 	netns-name.sh \
 	netns-sysctl.sh \
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 71df5880b356a1ea3e013891d90372b04e070d02..7648ab6c2adae659d23e32cb33dfb0341afa326e 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -16,6 +16,8 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     ctl_file_write, wait_file, tool, tc
 from .bpf import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
+from .rsskey import RSS_KEY_QMAX, rss_key_bit, rss_key_assign_bit, \
+    rss_key_window, rss_key_toeplitz, rss_key_full_rank, rss_key_layout
 from .ynl import NlError, NlctrlFamily, YnlFamily, \
     EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily, RtnlRouteFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
@@ -31,6 +33,9 @@ __all__ = ["KSRC",
            "bpftool", "ip", "ethtool", "bpftrace", "rand_port", "rand_ports",
            "wait_port_listen", "ctl_file_write", "wait_file", "tool", "tc",
            "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
+           "RSS_KEY_QMAX", "rss_key_bit", "rss_key_assign_bit",
+           "rss_key_window", "rss_key_toeplitz", "rss_key_full_rank",
+           "rss_key_layout",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
diff --git a/tools/testing/selftests/net/lib/py/rsskey.py b/tools/testing/selftests/net/lib/py/rsskey.py
new file mode 100644
index 0000000000000000000000000000000000000000..4451eb80fb4577c5a8cce4dd9e973e4eabb2d666
--- /dev/null
+++ b/tools/testing/selftests/net/lib/py/rsskey.py
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Helpers to check the quality of an RSS key.
+
+The Toeplitz hash is linear over GF(2): the hash is the XOR of the 32 bit key
+windows selected by the set bits of the input, and hardware indexes the
+indirection table with the low order bits of the hash. The windows belonging
+to the q lowest bits of a header field therefore form a Toeplitz matrix, and
+when that matrix is singular the flows of a burst differing only in those
+bits, consecutive ephemeral ports typically, can not reach all of the 2 ** q
+entries of the table. A key drawn uniformly at random is singular for a given
+field and a given q with probability 1/2.
+
+netdev_rss_key_fill() generates keys that are non singular for every field of
+the hash input and every q up to RSS_KEY_QMAX.
+"""
+
+# Matches NETDEV_RSS_KEY_QMAX, that is up to 256 entries of the table.
+RSS_KEY_QMAX = 8
+
+
+def rss_key_bit(buf, bit):
+    """Bit @bit of @buf, counting from the most significant bit of byte 0."""
+    return (buf[bit // 8] >> (7 - bit % 8)) & 1
+
+
+def rss_key_assign_bit(buf, bit, value):
+    mask = 0x80 >> (bit % 8)
+
+    if value:
+        buf[bit // 8] |= mask
+    else:
+        buf[bit // 8] &= ~mask
+
+
+def rss_key_window(key, bit):
+    """The 32 key bits starting at @bit, what input bit @bit contributes."""
+    value = 0
+
+    for i in range(32):
+        value = (value << 1) | rss_key_bit(key, bit + i)
+
+    return value
+
+
+def rss_key_toeplitz(key, inp, nbits):
+    """The Toeplitz hash of the @nbits long input @inp under @key."""
+    value = 0
+
+    for i in range(nbits):
+        if rss_key_bit(inp, i):
+            value ^= rss_key_window(key, i)
+
+    return value
+
+
+def rss_key_full_rank(key, lsb, q):
+    """Do the q low order bits of the field at @lsb reach all 2 ** q entries?
+
+    Gaussian elimination over GF(2) on the q windows involved, reduced to
+    their q low order bits, which are the ones indexing the table.
+    """
+    basis = {}
+
+    for j in range(q):
+        vector = rss_key_window(key, lsb - j) & ((1 << q) - 1)
+
+        while vector:
+            low = vector & -vector
+            if low not in basis:
+                basis[low] = vector
+                break
+            vector ^= basis[low]
+
+        if not vector:
+            return False
+
+    return True
+
+
+def rss_key_layout(fields, ipv6):
+    """Describe the hash input built from @fields, as ethtool -n reports it.
+
+    @fields is the flow hash configuration, "sdfn" for a 4-tuple or "sd" for
+    a 2-tuple. Returns the list of (name, position of the least significant
+    bit) and the length of the input in bits, or None if the layout involves
+    something this does not know how to place.
+    """
+    addr_bits = 128 if ipv6 else 32
+    known = (("s", "saddr", addr_bits),
+             ("d", "daddr", addr_bits),
+             ("f", "sport", 16),
+             ("n", "dport", 16))
+
+    if set(fields) - {flag for flag, _, _ in known}:
+        return None, 0
+
+    layout = []
+    nbits = 0
+
+    for flag, name, width in known:
+        if flag not in fields:
+            continue
+        nbits += width
+        layout.append((name, nbits - 1))
+
+    return layout, nbits
diff --git a/tools/testing/selftests/net/netdev_rss_key.py b/tools/testing/selftests/net/netdev_rss_key.py
new file mode 100755
index 0000000000000000000000000000000000000000..37be2ebea6f7c1ece279dbb8c568f7cb06d568cc
--- /dev/null
+++ b/tools/testing/selftests/net/netdev_rss_key.py
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Check the quality of the host RSS key, /proc/sys/net/core/netdev_rss_key.
+
+This is the key netdev_rss_key_fill() hands to the drivers. It has to be non
+singular for every field of the hash input and every queue count up to
+2 ** RSS_KEY_QMAX, see lib/py/rsskey.py for what that means and why it
+matters. Unlike the KUnit tests of the generator, this checks the key the
+running kernel has actually handed out.
+
+The key is generated lazily, the first time a driver asks for it, so this
+test skips until a driver has done so. Any NIC calling netdev_rss_key_fill()
+is enough; in a virtual machine, virtio_net does it from
+virtnet_init_default_rss() once RSS has been negotiated.
+
+Checking what a given NIC really uses is a different question, since a
+driver may bring its own key. See drivers/net/hw/rss_key.py for that.
+"""
+
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq, ksft_ge
+from lib.py import KsftSkipEx
+from lib.py import RSS_KEY_QMAX, rss_key_full_rank, rss_key_layout
+
+KEY_PATH = "/proc/sys/net/core/netdev_rss_key"
+
+# Shortest key able to hash an IPv6 4-tuple.
+MIN_KEY_LEN = 40
+
+
+def _read_key():
+    """Return the host RSS key, skipping if it has not been generated."""
+    try:
+        with open(KEY_PATH, "r", encoding="ascii") as fp:
+            text = fp.read().strip()
+    except FileNotFoundError as exc:
+        raise KsftSkipEx(f"{KEY_PATH} is not available") from exc
+
+    key = bytes(int(byte, 16) for byte in text.split(":"))
+
+    if not any(key):
+        raise KsftSkipEx("the host RSS key has not been generated yet, "
+                         "no driver has called netdev_rss_key_fill()")
+
+    return key
+
+
+def check_length() -> None:
+    key = _read_key()
+
+    ksft_pr(f"host RSS key is {len(key)} bytes")
+    ksft_ge(len(key), MIN_KEY_LEN, "key too short to hash an IPv6 4-tuple")
+
+
+def check_spread() -> None:
+    key = _read_key()
+    degenerate = []
+
+    for ipv6 in (False, True):
+        layout, _ = rss_key_layout("sdfn", ipv6)
+        family = "IPv6" if ipv6 else "IPv4"
+
+        for name, lsb in layout:
+            if lsb + 32 > len(key) * 8:
+                continue
+
+            for q in range(1, RSS_KEY_QMAX + 1):
+                if not rss_key_full_rank(key, lsb, q):
+                    degenerate.append(f"{family} {name} over {1 << q} queues")
+
+    for bad in degenerate:
+        ksft_pr(f"degenerate: {bad}")
+
+    ksft_eq(len(degenerate), 0,
+            "the host RSS key does not spread flows over all the queues")
+
+
+def check_grid() -> None:
+    """Sweep the whole key, not only the fields of the usual layouts.
+
+    netdev_rss_key_fill() does not get to know what the hardware hashes, so
+    it gives the property at every 16-bit aligned position of the key. A NIC
+    hashing an encapsulated header reads the key well past the first 40
+    bytes, and has to find the same guarantee there.
+    """
+    key = _read_key()
+    bits = len(key) * 8
+    positions = 0
+    degenerate = []
+
+    for lsb in range(15, bits - 31, 16):
+        positions += 1
+
+        for q in range(1, RSS_KEY_QMAX + 1):
+            if not rss_key_full_rank(key, lsb, q):
+                degenerate.append(f"field ending at bit {lsb} "
+                                  f"over {1 << q} queues")
+
+    ksft_pr(f"checked {positions} positions of the {len(key)} byte key")
+
+    for bad in degenerate[:8]:
+        ksft_pr(f"degenerate: {bad}")
+
+    ksft_eq(len(degenerate), 0,
+            "the host RSS key does not spread flows over all the queues "
+            "at every 16-bit aligned position")
+
+
+def main() -> None:
+    ksft_run(globs=globals(), case_pfx={"check_"})
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0.1082.g2b9226bbc0-goog

