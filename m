Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB53043DC
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162656; cv=none; b=JBtmFKJ/nygXa7Tb0BuYWTpgxxZA9k6OqTxu3AMhFm9kYATkLQIfIoh+sW92sZKz5A2PYHz+XVtLM7Mb6up6YsJe8SBna3OYF2KtScEAsI2YT6wJ21nSESD1Drb1qMR5+sXM7MKbWR/Nrc7ItDMJTRKcYSJV4RyfoAqNRqHPm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162656; c=relaxed/simple;
	bh=dknHAWVDVr4VbWy52X7Bw83RZF3ZCZHYuBg0q4g0ZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGJH/B6PiSTuK3Y/C/vnQPf4Fp1k6kaKK1g9cnyWkXUO6s01UEVSLg4EQszOf60E4X/K84pPQteXZOMB/1L17qBIZWZkYbesq3qU/7PR8eVjifrEmE+4NJpwNTH+rk0ekU6w8/vWAEtiQXa46g3+SbBWqSpynTywO8t368ghy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5B2r3lv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5B2r3lv"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca957432c7fso4203154a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162649; x=1784767449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3WXKkArdNhSXf7ay7wr0ijzbhyQDDS4XvU5X+d1Sp8s=;
        b=F5B2r3lvueKB4Rdpe/r0/yUBkLh/jUcsJZ78AUNiHHnh9ff4gxQ4fZ8EwMHnv0ye5G
         FBFW5fiZV9DiQ0NU6cwOv3/p3poodmWq3IXS2WdFQBlTdqVeGqfWSZNtQBdgTXFqcr8R
         lT/sS4eE3p7yrfVPa7w0bMAvx2I92/irqahFZPmyZFu+R+Sk+f/0F194vBxmREAbWe3w
         aN20fxQX5G9fMOpwB7DMXBguxSj0nOw3Y624i6KqYYy1lhJbiLmAF3lBmrQURghDNKXk
         +PznGhQAi+4P0yoLskBIh5vrcfAFk1CC/mLZcFXJVq/DN6gjHozsMf+F1HaqKdDxD997
         jceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162649; x=1784767449;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WXKkArdNhSXf7ay7wr0ijzbhyQDDS4XvU5X+d1Sp8s=;
        b=kWbgXNyLbiTJeYol5Q89zYGqO9gZXEX5EwK6Gs3uHghRXx5ulrTsHJilYpSeMsZikP
         soQsAjBs9MXxg4dDARcpfK2s2FnFuGjjTEjSbQuktbsoiqWZtBQZLAgsoyznzUCIvJMu
         lydobISpVWSfX9EBWDYEHvhS1EBqdBRtO7DAh/DQL4eYrxoErOWsCO+gebAfgS+P/fIE
         th7I+O9AqC4rbD72bE6cKiMgMYL4g2mja1m/OrfDcFm59MFlNSDvwX5iAgQbo8u8hofl
         8gIrUp6fbx753bFaT2SyfH5zvIF5ykSH/XOsWSk232ETzYbLZU+8EJsMU8RbSb2V4H1r
         +Wzg==
X-Gm-Message-State: AOJu0Yxa8XZW9HR9uNHaTsa8veP4FXLgmPj6I1v968fmddhzEeJbXv5x
	xQvFcfggpLxGUcfbLoAMw3AcUmeivt9CwhT9rmlp5wY5vFjzCNEcMP7vQ4RY5g==
X-Gm-Gg: AfdE7cm/u/xHqD8DTsmAIXr+y1Vq5ErJtkizW+4fvswxdWjBWVSsTHXCnGGC2Pr82DZ
	1ZTpQp6wYuG8ZET6U1qPSxFORz7qMCdieLdwkErJFlgbTp2OsVJSYYJ8c6NQ/YBVg6h1NLgal2I
	TrbF7sTjvbQhCgzg82QCrSKpljfLHrJOZI5ah1p3poWV9LpGnybT1uh0lf7FFpadfJXwjXWR2HO
	SCxOE1pHLtB2mBwBhfHVSjF2omiWXropbf6FvlxquGr4efTV6yT87ErmMFYEAvF87Dfmg2PjHoS
	M3svokHGwB5TtYpDTSyXAtzT3vsfVBvGHjwdqrJnmnj3xAUIF45kAoIA1QLf2sDJh+29gp+xbbW
	mEte0GFrTu5Kk2GZ5h/Xlu85pqp23EvmShV+W2N04jpf5Cf/mC9ci/7AogcFPJITYD6p5tnxUIL
	Haai/g1vgJaCGgbfQ60mqLmJEmabH/Faq4e2j9oZX2surVmqR0Pb5xHw0KeFFowCu1D31Xtkmt6
	/zBgf00ag==
X-Received: by 2002:a05:6a20:9f04:b0:3c0:b3f7:e5e5 with SMTP id adf61e73a8af0-3c3573959c8mr10863618637.25.1784162649425;
        Wed, 15 Jul 2026 17:44:09 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:08 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dave Seddon <dave.seddon.ca@gmail.com>
Subject: [PATCH net-next v1 07/11] net: flow_dissector: add byte-identical fast-path for plain GRE inner
Date: Wed, 15 Jul 2026 17:43:53 -0700
Message-ID: <20260716004357.3652679-8-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds flow_dissect_fast_gre_inner() — invoked from inside the
existing flow_dissect_fast_ipv4() / flow_dissect_fast_ipv6() helpers
when the outer IP's protocol/nexthdr is IPPROTO_GRE and the GRE gate
is on.

Byte-identical with the slow path's __skb_flow_dissect_gre() for the
subset where:

  - GRE version == 0 (v1 = PPTP defers to slow path)
  - All GRE flags clear (no CSUM, KEY, SEQ, ROUTING)
  - protocol == ETH_P_IP or ETH_P_IPV6 (no TEB, PPP, MPLS-over-GRE)

In that subset, the GRE base header is exactly 4 bytes; slow path also
descends to inner IP (sets *p_proto = hdr->protocol and returns
PROTO_AGAIN) and stamps FLOW_DIS_ENCAPSULATION on key_control->flags.
The fast-path produces the same output: skips the 4-byte header,
tail-calls into the inner IP fast-path, re-establishes ENCAP on
key_control after the inner overwrites it (same pattern as the
IPIP family fast-path from the prior patch).

Why this matters: plain GRE (no key, no checksum) is the dominant
shape for cloud backbone tunnels (AWS GRE between regions, GCP
inter-region overlays) and corporate site-to-site VPNs that don't
need per-tunnel keying. The existing slow-path GRE handler does a
__skb_header_pointer + flag-walk per packet; the fast-path saves
that for the common case while keeping the slow path as the escape
valve for GRE-with-flags, v1/PPTP, TEB, and PPP-over-GRE.

Gated by:
  - new DEFINE_STATIC_KEY_FALSE(flow_dissector_gre_key)
  - new sysctl /proc/sys/net/flow_dissector/gre (default 0)
  - static_branch_unlikely guard inside the v4/v6 helpers, on the
    same not-TCP/UDP fall-through path as the IPIP gate (so the
    eth_ip hot path remains unchanged when this is off)

Cost when off: the not-TCP/UDP fall-through grows by one
static_branch_unlikely check on top of the IPIP check. The TCP/UDP
hot path is untouched.

GRE-with-KEY (used in some MPLS-over-GRE and cloud-overlay
deployments) is a natural follow-up: same descent shape with the
optional 4-byte key field read and a write to
FLOW_DISSECTOR_KEY_GRE_KEYID.

Documentation/admin-guide/sysctl/net.rst grows a `gre` subsection
under /proc/sys/net/flow_dissector/.

Classification note: the slow path already descends through plain
GRE unconditionally, so this fast path is byte-identical with
today's behaviour — a pure CPU saving. That is unlike the UDP-tunnel
descents later in the series (VXLAN/Geneve/GTP-U/FOU/GUE), where the
slow path stops at the outer UDP header today and the descent itself
is the new, gated behaviour.

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst |  25 ++++++
 include/net/flow_dissector.h             |   1 +
 net/core/flow_dissector.c                | 101 +++++++++++++++++++++--
 3 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 15c8ace2c0a4..dbc819740db0 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -572,6 +572,31 @@ that the inner IP fast-path itself would defer.
 
 Default: 0
 
+gre
+~~~
+
+GRE-encapsulated inner IP (``IPPROTO_GRE`` 47). The fast-path
+mirrors the slow path's __skb_flow_dissect_gre() descent for the
+common subset:
+
+- GRE version 0 (the v1 PPTP variant defers to slow path)
+- All GRE flags clear (no GRE_CSUM, GRE_KEY, GRE_SEQ, GRE_ROUTING —
+  i.e. plain 4-byte GRE base header)
+- protocol field is ``ETH_P_IP`` 0x0800 or ``ETH_P_IPV6`` 0x86DD
+  (no Transparent Ethernet Bridging, no PPP-over-GRE, no MPLS-
+  over-GRE)
+
+In that subset, slow path also descends to inner IP and stamps
+``key_control->flags |= FLOW_DIS_ENCAPSULATION``; the fast-path
+produces the same output.
+
+GRE-with-KEY (common in MPLS-over-GRE deployments and some cloud
+overlays) is a follow-up patch — same descent shape with an
+additional 4-byte key field read and a write to
+``FLOW_DISSECTOR_KEY_GRE_KEYID``.
+
+Default: 0
+
 3. /proc/sys/net/unix - Parameters for Unix domain sockets
 ----------------------------------------------------------
 
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index d9b4b461cd05..ba7226a42d19 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -434,6 +434,7 @@ extern struct static_key_false flow_dissector_qinq_key;
 extern struct static_key_false flow_dissector_pppoe_key;
 extern struct static_key_false flow_dissector_mpls_key;
 extern struct static_key_false flow_dissector_ipip_key;
+extern struct static_key_false flow_dissector_gre_key;
 
 /* struct flow_keys_digest:
  *
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index abf4fdb0100b..b79c80612dee 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -52,6 +52,8 @@ DEFINE_STATIC_KEY_FALSE(flow_dissector_mpls_key);
 EXPORT_SYMBOL(flow_dissector_mpls_key);
 DEFINE_STATIC_KEY_FALSE(flow_dissector_ipip_key);
 EXPORT_SYMBOL(flow_dissector_ipip_key);
+DEFINE_STATIC_KEY_FALSE(flow_dissector_gre_key);
+EXPORT_SYMBOL(flow_dissector_gre_key);
 
 /* IPv4 version/IHL byte of an option-less header: version 4, IHL 5. */
 #define FLOW_DIS_IPV4_VIHL_NOOPT	0x45
@@ -73,6 +75,11 @@ static bool flow_dissect_fast_ipip_inner(const struct sk_buff *skb,
 					 const void *data,
 					 __be16 inner_eth_proto,
 					 int inner_nhoff, int hlen);
+static bool flow_dissect_fast_gre_inner(const struct sk_buff *skb,
+					struct flow_dissector *flow_dissector,
+					void *target_container,
+					const void *data,
+					int nhoff, int hlen);
 
 /* One of the two dissectors the fast-path eligibility check admits;
  * defined here so flow_dissect_fast() below can reference it (its keys
@@ -1139,6 +1146,11 @@ static bool flow_dissect_fast_ipv4(const struct sk_buff *skb,
 						data, htons(ETH_P_IPV6),
 						nhoff + (int)sizeof(*iph), hlen);
 		}
+		if (static_branch_unlikely(&flow_dissector_gre_key) &&
+		    iph->protocol == IPPROTO_GRE)
+			return flow_dissect_fast_gre_inner(skb, flow_dissector,
+					target_container, data,
+					nhoff + (int)sizeof(*iph), hlen);
 		return false;
 	}
 
@@ -1236,8 +1248,10 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 		bool ipip = static_branch_unlikely(&flow_dissector_ipip_key) &&
 			    (iph->nexthdr == IPPROTO_IPIP ||
 			     iph->nexthdr == IPPROTO_IPV6);
+		bool gre = static_branch_unlikely(&flow_dissector_gre_key) &&
+			   iph->nexthdr == IPPROTO_GRE;
 
-		if (!ipip)
+		if (!ipip && !gre)
 			return false;
 
 		/* Mirror the slow path's outer-IPv6 writes before the
@@ -1264,11 +1278,15 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 		}
 
-		return flow_dissect_fast_ipip_inner(skb,
-				flow_dissector, target_container,
-				data,
-				iph->nexthdr == IPPROTO_IPIP ?
-				htons(ETH_P_IP) : htons(ETH_P_IPV6),
+		if (ipip)
+			return flow_dissect_fast_ipip_inner(skb,
+					flow_dissector, target_container,
+					data,
+					iph->nexthdr == IPPROTO_IPIP ?
+					htons(ETH_P_IP) : htons(ETH_P_IPV6),
+					nhoff + (int)sizeof(*iph), hlen);
+		return flow_dissect_fast_gre_inner(skb, flow_dissector,
+				target_container, data,
 				nhoff + (int)sizeof(*iph), hlen);
 	}
 
@@ -1569,6 +1587,70 @@ static bool flow_dissect_fast_ipip_inner(const struct sk_buff *skb,
 	return true;
 }
 
+/* Plain-GRE inner descent (version 0, no flags, inner IP): a 4-byte
+ * base header the slow path steps over with PROTO_AGAIN. Any flags,
+ * version 1 (PPTP) or a non-IP inner defers. ENCAP is stamped after
+ * the inner pass, which zeros key_control->flags.
+ */
+static bool flow_dissect_fast_gre_inner(const struct sk_buff *skb,
+					struct flow_dissector *flow_dissector,
+					void *target_container,
+					const void *data,
+					int nhoff, int hlen)
+{
+	struct flow_dissector_key_control *key_control;
+	const struct gre_base_hdr *hdr;
+	__be16 inner_proto;
+	int inner_nhoff;
+	bool ok;
+
+	if (unlikely(hlen - nhoff < (int)sizeof(*hdr)))
+		return false;
+	hdr = (const struct gre_base_hdr *)((const u8 *)data + nhoff);
+
+	/* flags field carries the GRE control flags *and* the 3-bit
+	 * version in its low bits. A zero word means "no flags set
+	 * AND version 0" — the byte-identical fast subset.
+	 */
+	if (hdr->flags != 0)
+		return false;
+
+	switch (hdr->protocol) {
+	case htons(ETH_P_IP):
+		inner_proto = htons(ETH_P_IP);
+		break;
+	case htons(ETH_P_IPV6):
+		inner_proto = htons(ETH_P_IPV6);
+		break;
+	default:
+		return false;
+	}
+
+	inner_nhoff = nhoff + (int)sizeof(*hdr);
+
+	if (inner_proto == htons(ETH_P_IP))
+		ok = flow_dissect_fast_ipv4(skb, flow_dissector,
+					    target_container, data,
+					    inner_nhoff, hlen);
+	else
+		ok = flow_dissect_fast_ipv6(skb, flow_dissector,
+					    target_container, data,
+					    inner_nhoff, hlen);
+
+	if (!ok)
+		return false;
+
+	/* Re-establish ENCAP after the inner pass zeroed key_control->flags. */
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_CONTROL)) {
+		key_control = skb_flow_dissector_target(flow_dissector,
+							FLOW_DISSECTOR_KEY_CONTROL,
+							target_container);
+		key_control->flags |= FLOW_DIS_ENCAPSULATION;
+	}
+	return true;
+}
+
 /* Top-level dispatcher: eligibility check (only the two standard
  * dissectors and flag subset) + per-proto switch with per-shape
  * static_branch gating. Each case's branch is a forward not-taken JMP
@@ -2792,6 +2874,13 @@ static struct ctl_table flow_dissector_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_static_key,
 	},
+	{
+		.procname	= "gre",
+		.data		= &flow_dissector_gre_key.key,
+		.maxlen		= sizeof(flow_dissector_gre_key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
 };
 
 static int __init flow_dissector_sysctl_init(void)
-- 
2.54.0

