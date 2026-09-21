Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C84FD29C
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015890; cv=none; b=uFaVJZaxxAvnm0s+fmV0+DxYmCyYx1IEfuqTHODmBPcFnA4xOqSJC/KjMnLi+rK8kvEoyF0sEZLvMRPvswP2eAQ3dU4L0rZD0t5JD5pRU8ycBi0u/ioNagn+PTeiZM1LrcqLsjGl1gp6cQjYhcJUUUf9Q69sDKRi0X0owLrzDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015890; c=relaxed/simple;
	bh=aJkPhS5mVxCFeFanSgTRz37QTnE0h2mc9trngqy7NK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5T8ui/nUI4VJuxOUvnDmDhnsMY4vyvsYEiBBWRKX5VA9wRBk0Ze9k7MVVC96/qdlc4SAzV2QYfBLZXL13lA+Yz11bRSx/kJdPLdmTyaWoX+bbcf35JnbtWr/6c2NbBna44IpHOYVgR7NYtOWBPztm+CyOx7m5DKqiwerCXEH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpxDyARt; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpxDyARt"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53124d6a362so56039861cf.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790015888; x=1790620688; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzpqivCAEFzKZvk+Cs0LffI3A/EoSWe0MVCMWRv7wYI=;
        b=lpxDyARtfN5QQp6QE9sbA85vAi34uoNZAocrTy2d/o4o9ZWYP1+Ylcr7caOcGGioR6
         /xFHERwqQgzP9DedFXzb8dDCZQrH0PU0ITNBndAQ4uHZ92dCoXwK+tH/3Aq53H+ksNiW
         NwtRduL5Y2sX9X9lJzvcv2wTry5FcZhJTI41Om7Khf6r5r6a8TBNFemhoijufXA/RokC
         iK37Q9hlqC5KO4myn/wsCTSjbpxIx3v9U6IgH4qfEdx77ycj4H6IDyRJbLh9cX1l2lga
         sKLu8BX55JeImwJV+tIa4D1CUWEnFLz3XrBMz5yyAuy7VJLSGPeeU6zOYy0f4cTPIqfT
         +3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015888; x=1790620688;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AzpqivCAEFzKZvk+Cs0LffI3A/EoSWe0MVCMWRv7wYI=;
        b=rB14o8W8xkFRFREUn+k3hokvL3qk9n8g5wHLUVB/hpmcJnfD7A6GVwDGCzFOt8L2sk
         mbnaLosFfMU7MDaaWHb9vFbzuq833tuCArgwnUF/TdSzayuM8K7HsC3lfQkapQ75pG2n
         nkkg/XrsIyZSX2sfIGD65fu/8ZiZujEWspLe/19R4s8y6vivG+dZtnJkjklEqZ2qxowk
         L+xm7utD6DgFAchBjF50qZwq3PB2s8Rj2kxqvuDCJhrcAg7aOhmFjZYK2DGi/jv+tlmy
         XYJD31xODFDQavHIS3iZc7aQWIEANQWWX1FPSfEcft5RQaGSAG2V0DNP2LtWSbAt27tg
         yqtg==
X-Forwarded-Encrypted: i=1; AKwUvBx2kM+hZF6u+aITD5E1shOZpG0ZYh8h0q3CDxu9/T8SIO9LoPOMIZorCKBlJl9XpmRn3gxZl5k=@vger.kernel.org
X-Gm-Message-State: AFuF++nsm7oe4rQdlHkjQYGFrCn9SEn45mg0fV3PgDylJ73EefSmh4Cg
	tbHLVQymr9mQxeKvdMivsqjiJHmBsfOW2xPdDLD7A4qEKSY74+1NHwnQXOhymXFENuNx2KkXWJz
	s5a2BnL1t89bFuQ==
X-Received: from qtbki12.prod.google.com ([2002:a05:622a:770c:b0:532:c036:ce5e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:180a:b0:532:b33b:f601 with SMTP id d75a77b69052e-532d8d5dc78mr19761701cf.24.1790015887316;
 Mon, 21 Sep 2026 11:38:07 -0700 (PDT)
Date: Mon, 21 Sep 2026 18:37:58 +0000
In-Reply-To: <20260921183758.1812310-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921183758.1812310-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921183758.1812310-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] selftests: drivers: net: check the RSS key a
 device uses
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

The host key is not the whole story: a driver may bring its own key, and
firmware sometimes installs one, in which case nothing the core does helps.

Read back the key and the indirection table the device reports and check
that flows differing only in the low order bits of one hashed field fill
that table, rather than a fraction of it. Both an algebraic check on the
key and a brute force pass hashing the 2 ** q inputs and placing them in
the table.

The fields checked come from the flow hash configuration of the device, so
a NIC hashing 2-tuples is described correctly, and flow types hashing
something we can not place are reported and skipped.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/lib/py/__init__.py         |   5 +
 .../selftests/drivers/net/hw/rss_key.py       | 172 ++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_key.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8aebdc6feb177c897ccd0f3ed7ea7a5862a6c054..9bcf3c1e8caa24e715e15af4bfecaeacdd522a7a 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -46,6 +46,7 @@ TEST_PROGS = \
 	rss_drv.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	rss_key.py \
 	toeplitz.py \
 	tso.py \
 	userns_devmem.py \
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 81e1d1865cd50cd210bbfda5e702bff1a5cb71bb..96edd9dfe9e3b6ec903bb19c885298a99f081db8 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -26,6 +26,8 @@ try:
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, \
         wait_file, ctl_file_write, tool
     from net.lib.py import bpf_map_set, bpf_map_dump, bpf_prog_map_ids
+    from net.lib.py import RSS_KEY_QMAX, rss_key_bit, rss_key_assign_bit, \
+        rss_key_window, rss_key_toeplitz, rss_key_full_rank, rss_key_layout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup, ksft_variants, KsftNamedVariant
@@ -42,6 +44,9 @@ try:
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
                "wait_port_listen", "wait_file", "ctl_file_write", "tool",
                "bpf_map_set", "bpf_map_dump", "bpf_prog_map_ids",
+               "RSS_KEY_QMAX", "rss_key_bit", "rss_key_assign_bit",
+               "rss_key_window", "rss_key_toeplitz", "rss_key_full_rank",
+               "rss_key_layout",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
                "ksft_setup", "ksft_variants", "KsftNamedVariant",
diff --git a/tools/testing/selftests/drivers/net/hw/rss_key.py b/tools/testing/selftests/drivers/net/hw/rss_key.py
new file mode 100755
index 0000000000000000000000000000000000000000..dc7095f6663cd31f70118c48ad32f7a706af5ed9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/rss_key.py
@@ -0,0 +1,172 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Check that the RSS key a device actually uses spreads flows over all of the
+entries of its indirection table.
+
+Most drivers take their key from netdev_rss_key_fill(), which generates keys
+having that property, but some bring their own and firmware sometimes
+installs one of its own. This reads back the key the device reports, so it
+covers wherever the key came from. See net/lib/py/rsskey.py for what the
+property is and why a random key is not good enough.
+"""
+
+import random
+
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_eq
+from lib.py import KsftSkipEx
+from lib.py import NetDrvEnv, EthtoolFamily, cmd
+from lib.py import RSS_KEY_QMAX, rss_key_assign_bit, rss_key_toeplitz, \
+    rss_key_full_rank, rss_key_layout
+
+# "define" for the ID of the Toeplitz hash function
+ETH_RSS_HASH_TOP = 1
+
+FLOW_TYPES = ("tcp4", "udp4", "tcp6", "udp6")
+
+# How ethtool -n spells the fields of the hash input.
+FIELD_NAMES = {
+    "IP SA": "s",
+    "IP DA": "d",
+    "L3 proto": "t",
+    "L4 bytes 0 & 1 [TCP/UDP src port]": "f",
+    "L4 bytes 2 & 3 [TCP/UDP dst port]": "n",
+    "IPv6 Flow Label": "l",
+}
+
+
+def _get_rss(cfg):
+    """The key and indirection table of @cfg's device, or a skip."""
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
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
+    return bytes(hkey), indir
+
+
+def _get_layouts(cfg):
+    """The hash input layouts in use, mapped to the flow types sharing them."""
+    layouts = {}
+
+    for fl_type in FLOW_TYPES:
+        proc = cmd(f"ethtool -n {cfg.ifname} rx-flow-hash {fl_type}",
+                   fail=False)
+        if proc.ret:
+            continue
+
+        fields = ""
+        for line in proc.stdout.split("\n")[1:-2]:
+            # if this raises we probably need to add more keys to FIELD_NAMES
+            fields += FIELD_NAMES[line]
+
+        layout, nbits = rss_key_layout(fields, fl_type.endswith("6"))
+        if layout is None:
+            ksft_pr(f"{fl_type}: not checked, hashes fields we can not place "
+                    f"({fields})")
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
+def test_rss_key_rank(cfg) -> None:
+    """The key has to be non singular for the size of the table."""
+    hkey, indir = _get_rss(cfg)
+    q = min((len(indir) - 1).bit_length(), RSS_KEY_QMAX)
+    degenerate = []
+
+    if not q:
+        raise KsftSkipEx("the indirection table has a single entry")
+
+    for (layout, _), fl_types in _get_layouts(cfg).items():
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
+def test_rss_key_spread(cfg) -> None:
+    """Hash bursts differing in one field only, and place them in the table."""
+    hkey, indir = _get_rss(cfg)
+    q = (len(indir) - 1).bit_length()
+    collisions = []
+
+    if q > RSS_KEY_QMAX:
+        raise KsftSkipEx(f"{len(indir)} indirection table entries is more "
+                         "than the kernel guarantees")
+    if not q:
+        raise KsftSkipEx("the indirection table has a single entry")
+
+    for (layout, nbits), fl_types in _get_layouts(cfg).items():
+        # Unlike the rank check, this hashes the whole input, so it reads
+        # the key up to 31 bits past its last bit rather than past the last
+        # bit of one field.
+        if nbits + 31 > len(hkey) * 8:
+            ksft_pr(f"{'/'.join(fl_types)}: not checked, the key is "
+                    f"{len(hkey)} bytes")
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
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.ethnl = EthtoolFamily()
+        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.55.0.1082.g2b9226bbc0-goog

