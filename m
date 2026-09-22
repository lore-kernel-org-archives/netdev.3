Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68573569F1F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094911; cv=none; b=ciO9SRgntUzLKNqQARcWySnjC3j0Mdjruy84vdPbLKWDkVwMv0HgKZXf/1/qSwdmdgk21wxPy9w30H8GYqyZsZ39s+1ThWir3pYTiIfgTdk2gPqEERZE6gEHID8Lvlq64X/yKzwEksBEtDB8PreJFQ1PVrle1dGw+xOxMN1uOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094911; c=relaxed/simple;
	bh=25j+JfY9NmMx9nAqJWwcntO9COb+Kcgj0B18nyKb9RA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bfURiAq4Bh9bMx05YSLiIk5nYOiPEO5L+IDDY0Qe45dvcNLhFyeU3kpvKh9CWA/vPcbeLB89HeTPqUvH0sVDfG8+f0Cu055PKvdwrFFPQad1mftAxUxvuqiCFYgrIs+RxaEVLDIyZPQVVjSou+3pdKzhGyx+MYVyvrKW5zBW3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n81RSKkF; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n81RSKkF"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a05d645acso19297585a.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790094908; x=1790699708; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ur6WVq0xtcMT7mZPoaAqelze2WvIvcUw/+uQJ6vMMLI=;
        b=n81RSKkFbvpYhAOvhp3tAcjVYIkY/BA2IkqBrXpsAzVmPFa2XmwUCrWUmK17W9DtHe
         AZXRLtYROTNdPIHBhcU/bjkKAig/tY43XRIFvbAnknnwGqTVhzaGzzXBagTgShQq0rFm
         Kc0g00BV0GlMuG0+RV1k0BLeaYqhi9wv9CLfzcltm+eaJmZEV0CcoBM/nWktsXQJHNFA
         TgrpaC7gsudScsAQT8xeunJ/daunwI53Yfqru1un0jTcOryWU7dnHMxexB9deBR2db8H
         q6RVGHAQlm/o+v4k/5U8+kGyxnZ4BJnXF+E2qEsqmn9ATARAfGeeS/lGfYH1Pn3OdD72
         07bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094908; x=1790699708;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ur6WVq0xtcMT7mZPoaAqelze2WvIvcUw/+uQJ6vMMLI=;
        b=D4TC3hxQyzSm/GuRULB7pp73x0fPFtuYOs9qDtSaXPb4AG45QH260YWm90R4ieFrcp
         EtZW3IFMUMBn0M4MDMz+g7EK7rPC8uVB1bNQw3m9pAqz/O4TeY35/CRPNX6arc0ro4gb
         oX0DTIpgOguLBNulEwPkSe15pNxeNYd8yBVOH3AwdA/txO/ALPrNOcoRQQDj3iTFuLN9
         CFAgVdpsqpoCyI535klm0ffbwrb3vnq2zXoevGeija3n/vUzCFFJapEjN5DAcud9ecPH
         jZIL21tUIKRNtawASQLE1Tje/GRe4TCD7Rht6S5J7WCNCFuUylV62cL1AdiCMIbTn2UK
         zUig==
X-Forwarded-Encrypted: i=1; AKwUvBxcYF40BWY1fC3iqxnT83UpHRRitByzfoi7768lk2FhGrBdFf6UdGGB+UD+N/bbnEwypg/PstA=@vger.kernel.org
X-Gm-Message-State: AFuF++nlFiYCDbs6FeRwQQdiW4KoclOKRTAkPWMJRkpa0DcT1y35jpeC
	grOIm0NznB6+Sb0kq1DMLE39frIn8Dy/MImUnbEqkiDFOsXTFqXmZj1twND7Khz4yR8igwUo7EC
	YvCkIN6cDKlWqag==
X-Received: from qkntw9.prod.google.com ([2002:a05:620a:3ec9:b0:93b:d1f9:b266])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3705:b0:939:7c8:78a9 with SMTP id af79cd13be357-93c15dd1f6emr641937785a.3.1790094905209;
 Tue, 22 Sep 2026 09:35:05 -0700 (PDT)
Date: Tue, 22 Sep 2026 16:34:58 +0000
In-Reply-To: <20260922163458.3900996-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922163458.3900996-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922163458.3900996-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] selftests: drivers: net: check the host and
 device RSS keys
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest under tools/testing/selftests/drivers/net/rss_key.py
checking both the host RSS key (/proc/sys/net/core/netdev_rss_key) and
the RSS key, indirection table, and flow-hash layouts reported by a
device over ethtool netlink.

When invoked without NETIF, NetDrvEnv creates a 4-queue netdevsim device,
which calls netdev_rss_key_fill() and allows exercising both the host key
and the netlink RSS reporting path in a virtual machine without special
hardware. When invoked with NETIF, it checks the key and indirection
table of that interface.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../testing/selftests/drivers/net/rss_key.py  | 343 ++++++++++++++++++
 2 files changed, 344 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/rss_key.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index b98c0e240b7d7d4e5800039930c1a99ebe6d2b22..79c6f998e7046fed855081ee6d2e4c4c12bae446 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -25,6 +25,7 @@ TEST_PROGS := \
 	psp.py \
 	queues.py \
 	ring_reconfig.py \
+	rss_key.py \
 	shaper.py \
 	so_txtime.py \
 	stats.py \
diff --git a/tools/testing/selftests/drivers/net/rss_key.py b/tools/testing/selftests/drivers/net/rss_key.py
new file mode 100755
index 0000000000000000000000000000000000000000..4f694a99e9a08ca6ad7570d43587dff2b4968350
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/rss_key.py
@@ -0,0 +1,343 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Check the quality of the host RSS key (/proc/sys/net/core/netdev_rss_key)
+and that the RSS key a device actually uses spreads flows over all of the
+entries of its indirection table.
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
+import errno
+import random
+
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq, ksft_ge
+from lib.py import KsftSkipEx
+from lib.py import NetDrvEnv, EthtoolFamily, NlError
+
+KEY_PATH = "/proc/sys/net/core/netdev_rss_key"
+
+# Shortest key able to hash an IPv6 4-tuple.
+MIN_KEY_LEN = 40
+
+# Matches NETDEV_RSS_KEY_QMAX, that is up to 256 entries of the table.
+RSS_KEY_QMAX = 8
+
+# "define" for the ID of the Toeplitz hash function
+ETH_RSS_HASH_TOP = 1
+
+FLOW_TYPES = ("tcp4", "udp4", "tcp6", "udp6")
+
+# Map ethtool netlink rxfh-fields flag names to rss_key_layout() codes.
+FIELD_NAMES = {
+    "ip-src": "s",
+    "ip-dst": "d",
+    "l3-proto": "t",
+    "l4-b-0-1": "f",
+    "l4-b-2-3": "n",
+    "ip6-fl": "l",
+}
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
+    """Describe the hash input built from @fields.
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
+
+
+def _read_host_key():
+    """Return the host RSS key, skipping if it has not been generated."""
+    try:
+        with open(KEY_PATH, "r", encoding="ascii") as fp:
+            text = fp.read().strip()
+    except FileNotFoundError as exc:
+        raise KsftSkipEx(f"{KEY_PATH} is not available") from exc
+
+    key = bytes(int(byte, 16) for byte in text.split(":")) if text else b""
+
+    if not any(key):
+        raise KsftSkipEx("the host RSS key has not been generated yet, "
+                         "no driver has called netdev_rss_key_fill()")
+
+    return key
+
+
+def _get_rss(cfg):
+    """The key, indirection table, and flow-hash config of @cfg's device."""
+    try:
+        rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    except NlError as exc:
+        if exc.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx(f"{cfg.ifname} does not support RSS") from exc
+        raise
+
+    hkey = rss.get("hkey")
+    if not hkey or not any(hkey):
+        raise KsftSkipEx(f"{cfg.ifname} does not report an RSS key")
+
+    if rss.get("hfunc") != ETH_RSS_HASH_TOP:
+        raise KsftSkipEx(f"{cfg.ifname} does not use the Toeplitz hash")
+
+    if rss.get("input-xfrm"):
+        raise KsftSkipEx(f"{cfg.ifname} transforms the hash input")
+
+    indir = rss.get("indir")
+    if not indir:
+        raise KsftSkipEx(f"{cfg.ifname} does not report an indirection table")
+
+    if len(indir) & (len(indir) - 1):
+        raise KsftSkipEx(f"{cfg.ifname} has {len(indir)} indirection table "
+                         "entries, which is not a power of two")
+
+    return bytes(hkey), indir, rss.get("flow-hash", {})
+
+
+def _get_layouts(flow_hash):
+    """The hash input layouts in use, mapped to the flow types sharing them."""
+    layouts = {}
+
+    for fl_type in FLOW_TYPES:
+        nl_fields = flow_hash.get(fl_type)
+        if not nl_fields:
+            continue
+
+        fields = "".join(FIELD_NAMES.get(name, "?") for name in nl_fields)
+        layout, nbits = rss_key_layout(fields, fl_type.endswith("6"))
+        if layout is None:
+            ksft_pr(f"{fl_type}: not checked, hashes fields we can not place "
+                    f"({nl_fields})")
+            continue
+
+        layouts.setdefault((tuple(layout), nbits), []).append(fl_type)
+
+    if not layouts:
+        raise KsftSkipEx("no flow type with a hash input we can describe")
+
+    return layouts
+
+
+def test_host_rss_key_length(cfg) -> None:
+    key = _read_host_key()
+
+    ksft_pr(f"host RSS key is {len(key)} bytes")
+    ksft_ge(len(key), MIN_KEY_LEN, "key too short to hash an IPv6 4-tuple")
+
+
+def test_host_rss_key_spread(cfg) -> None:
+    key = _read_host_key()
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
+def test_host_rss_key_grid(cfg) -> None:
+    """Sweep the whole key, not only the fields of the usual layouts."""
+    key = _read_host_key()
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
+def test_dev_rss_key_rank(cfg) -> None:
+    """The key has to be non singular for the size of the table."""
+    hkey, indir, flow_hash = _get_rss(cfg)
+    q = min((len(indir) - 1).bit_length(), RSS_KEY_QMAX)
+    degenerate = []
+
+    if not q:
+        raise KsftSkipEx("the indirection table has a single entry")
+
+    for (layout, _), fl_types in _get_layouts(flow_hash).items():
+        for name, lsb in layout:
+            if lsb + 32 > len(hkey) * 8:
+                ksft_pr(f"{name}: not checked, the key is {len(hkey)} bytes")
+                continue
+
+            if not rss_key_full_rank(hkey, lsb, q):
+                degenerate.append(f"{'/'.join(fl_types)} {name}")
+
+    for bad in degenerate:
+        ksft_pr(f"degenerate: {bad}")
+
+    ksft_eq(len(degenerate), 0,
+            f"the key of {cfg.ifname} does not spread flows over the "
+            f"{1 << q} entries of its indirection table")
+
+
+def test_dev_rss_key_spread(cfg) -> None:
+    """Hash bursts differing in one field only, and place them in the table."""
+    hkey, indir, flow_hash = _get_rss(cfg)
+    q = (len(indir) - 1).bit_length()
+    collisions = []
+
+    if q > RSS_KEY_QMAX:
+        raise KsftSkipEx(f"{len(indir)} indirection table entries is more "
+                         "than the kernel guarantees")
+    if not q:
+        raise KsftSkipEx("the indirection table has a single entry")
+
+    for (layout, nbits), fl_types in _get_layouts(flow_hash).items():
+        if nbits + 31 > len(hkey) * 8:
+            ksft_pr(f"{'/'.join(fl_types)}: not checked, the key is "
+                    f"{len(hkey)} bytes, input needs {(nbits + 31 + 7) // 8}")
+            continue
+
+        for name, lsb in layout:
+            inp = bytearray(random.randbytes(nbits // 8))
+            entries = set()
+            for value in range(1 << q):
+                for bit in range(q):
+                    rss_key_assign_bit(inp, lsb - bit, value & (1 << bit))
+                hash_ = rss_key_toeplitz(hkey, inp, nbits)
+                entries.add(hash_ & (len(indir) - 1))
+
+            if len(entries) != 1 << q:
+                collisions.append(f"{'/'.join(fl_types)} {name} reaches "
+                                  f"{len(entries)} of the {1 << q} entries")
+
+    for bad in collisions:
+        ksft_pr(bad)
+
+    ksft_eq(len(collisions), 0,
+            f"flows differing in one field only do not fill the "
+            f"indirection table of {cfg.ifname}")
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+
+    with NetDrvEnv(__file__, queue_count=4) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0.1082.g2b9226bbc0-goog

