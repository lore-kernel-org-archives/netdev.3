Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426540F751
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716960; cv=none; b=BIoZ8TfzYbDwzEdcIVfM1btIA6G4CVSmA6/b6vMj4FdxVmqKCJT5+HL0pPPPcqyWGmeEWyr3CJCSCspm4ZXHDgx+rNVxRczR0DLNdNrjGWIwwFnv0vuupZ8ttgsHzvVs0BGeo9wpc4/An4+reecRaeLACdE1IJV1IU3LS6BUW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716960; c=relaxed/simple;
	bh=woc+3g1siAGuK4o1hFCVnUawff1HvJWOMYkjGFwJSlw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=urkIssGB9vNqfIJhQg3ExWUaO19twMUx7ZsI6Xsg9f2Udk4bFch5spnU59iOMX2/4Tgfxupgtk+h8KK87LRYKC1mWKCAb1FHphRrzMqqVbJEwNv9PGtnXH3d7YAr5EOV6QvF9881+2ocUJ+qLCdTHKwXPJGl8PsdR+i0MRrNL1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nIh56PiT; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nIh56PiT"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e632390d2so1745415685a.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784716957; x=1785321757; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMhGnG0feTShhX99dG/2JKDH+JOifL5seRL9g0VCBho=;
        b=nIh56PiTFtr7rEpTPJzEaTaSj3ElIa08OR37bQw8bKEVAYMkN3oLCPGGVY9jJwAgv4
         tkQmHkxmikGRm1ri3MOAblibwXI8kH4LhEkd/1+Zh6adqRNNUTVhazLqQvsW80hHD85h
         UDUQNHJwrg9hK31BNg5yeseZl7FR7x5gmP7GaArILQIr/0KshAycWNJbKQ2C6ULrHvl1
         N0IxFcmUSgpwKir+va6CEUSGlIKz689ZgFdOVeAuKRVLqrXqU0EIX3j+Ivi43cyC/L1d
         Smx6kA+bUi3PUoy5Je7QOpltwfLon6rAA2LRGbP4BEC4gj++vX2cmvf1wC08xDrrhRU+
         7y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784716957; x=1785321757;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMhGnG0feTShhX99dG/2JKDH+JOifL5seRL9g0VCBho=;
        b=V4JkxMecGVmILollhOoYo/93m2yL5zVWwRyPNSiykmJesrRlMzI3DdbQK7HKabioHQ
         j/4Q6PSn37K1qDt53doFi23XD2Dzlijam7fC88LkvfdRM+k5ZJjC9O/Sbniwuvs2zlH0
         pLP8dVTwMbxQtMfp0pOv2XCPH6NxyxdlQm0r6kUkaOe2JdD1txmgpuNgPLJcqgRZWplI
         /DxLaYVsCJgOZPM0TnReH0nZNV/U3YDnq1J6yOt8kYYnUWpTSnIv9xDWrUBWerA1Hi49
         VlbScnll2ENdoADZbUFhGQdWAGHtJ6c9KUK+WKk9Xx+caDBl7Jna3EDblbfhdUxSSF9k
         01RQ==
X-Forwarded-Encrypted: i=1; AHgh+RoovXlB/++vsAl8/iH/Hny2eSDU2h+z4DY1Li4I6mgGTeXdBVCfvVNQhZxqEluabjl7+xhx/YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+tDD/UbvErPcJewYb9SB04qqDA+iiBB3RgcrUFSf2iFOy40t
	QVfzN9k46KptDY9L05RqPFFIW1UEtsecU4lcOVQS5lpsAsFJI3EviSm4jQdd2tbIVDwgUbU2B8z
	c5U56r549Q7T7YQ==
X-Received: from qkmw3.prod.google.com ([2002:a05:620a:e83:b0:930:e723:4bf8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4110:b0:92e:e2a4:ae86 with SMTP id af79cd13be357-930b42f95a2mr2266118085a.80.1784716957192;
 Wed, 22 Jul 2026 03:42:37 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:42:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722104236.2938082-1-edumazet@google.com>
Subject: [PATCH v2 net] ipv4: icmp: fill flow parameters in icmp_route_lookup
 decoy lookup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Muhammad Ziad <muhzi100@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When Linux forwards a packet and needs to generate an ICMP error,
icmp_route_lookup() performs a reverse-path relookup. For non-local
destinations, it performs a decoy lookup to find the expected egress
interface (rt2->dst.dev) before validating the path with ip_route_input().

Currently, the decoy flow structure (fl4_2) only sets .daddr = fl4_dec.saddr,
leaving .saddr, .flowi4_dscp, .flowi4_proto, .flowi4_mark, .flowi4_oif,
.fl4_sport, .fl4_dport, and .flowi4_uid zeroed out.

When policy routing rules (such as ip rule add from $SRC lookup 100, or
dscp/fwmark/ipproto/port rules, or VRF bindings) are configured:
1. The decoy lookup fails to match the policy rule because saddr and other
   key flow selectors are missing in fl4_2.
2. It resolves a route using the default table instead, returning an incorrect
   egress netdev.
3. Passing the wrong netdev to ip_route_input() causes strict reverse-path
   filtering (rp_filter=1) to fail, logging false-positive "martian source"
   warnings and causing the relookup to fail.

Fix this by initializing fl4_2 from fl4_dec and:
- Swapping source/destination IP addresses.
- Swapping L4 ports for transport protocols with ports (TCP, UDP, SCTP, DCCP)
  so port-based policy routing matches correctly. Non-port protocols (such as
  ICMP or GRE) leave the flowi_uli union fields intact to prevent corruption.
- Setting .flowi4_oif = l3mdev_master_ifindex(route_lookup_dev) to ensure
  VRF routing tables are respected.
- Setting .flowi4_flags |= FLOWI_FLAG_ANYSRC to allow output route lookups
  for non-local source IP addresses.
- Using __ip_route_output_key() instead of ip_route_output_key() for fl4_2
  so that raw FIB routing is used without triggering spurious XFRM policy
  lookups on the decoy flow (the actual XFRM lookup is performed later using
  fl4_dec).

Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
Reported-by: Muhammad Ziad <muhzi100@gmail.com>
Closes: https://lore.kernel.org/netdev/CAOAwikA60AYKdFr_UDLyja3oU4hqyAE7uFZWqum5uRdaQsgRYg@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: addressed Sashiko and Jakub feedback
v1: https://lore.kernel.org/netdev/20260716021049.2124921-1-edumazet@google.com/

 net/ipv4/icmp.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23e921d313b36b00d8ae5e14846527220c9db32b..0caedfc7ca92f64d146c11c552e73650541b508c 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -548,11 +548,23 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		if (IS_ERR(rt2))
 			err = PTR_ERR(rt2);
 	} else {
-		struct flowi4 fl4_2 = {};
+		struct flowi4 fl4_2 = fl4_dec;
 		unsigned long orefdst;
 
-		fl4_2.daddr = fl4_dec.saddr;
-		rt2 = ip_route_output_key(net, &fl4_2);
+		swap(fl4_2.daddr, fl4_2.saddr);
+		switch (fl4_2.flowi4_proto) {
+		case IPPROTO_TCP:
+		case IPPROTO_UDP:
+		case IPPROTO_SCTP:
+		case IPPROTO_DCCP:
+			swap(fl4_2.fl4_sport, fl4_2.fl4_dport);
+			break;
+		}
+
+		fl4_2.flowi4_oif = l3mdev_master_ifindex(route_lookup_dev);
+		fl4_2.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+
+		rt2 = __ip_route_output_key(net, &fl4_2);
 		if (IS_ERR(rt2)) {
 			err = PTR_ERR(rt2);
 			goto relookup_failed;
-- 
2.55.0.229.g6434b31f56-goog

