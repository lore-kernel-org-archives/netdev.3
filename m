Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CF306D3F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162654; cv=none; b=CsF0c+NvipTkngvs5aIYULf9wn7PZ+mn8oGq+ONEaWi36lXtO0e/NY63MqhqhAw8oNmnxtQDU7ynkorl0M4/nTp61QNHTxH14MSqOndszHZ8I8ir7S6SLEI8lh0IOCU1T8PVIJiAoQPEjqymiDknqDr5JA4yxg6aSK1Z650pdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162654; c=relaxed/simple;
	bh=8z2dU6C3TYRJ022H9N3Ej1VRtoM6gFjZ5RUegcBnuak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjXswl6AZCq9soTI0LnvV/j20LfeWwIHVaJ8VGqMZssJcN8w3/LxsRqpeDir61R3anf/7DmOB2mCaPXj4U9DNQ+aQ0UR2qni4iicaGzl06m9mBS1iqCweBsoCsjaiVl70tRlYRlP4+odpJTl/JWiOOlTSJLTjXBKdCfJxO3lhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag07XFKm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag07XFKm"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso3919526a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162648; x=1784767448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vobfv6qQPpjyzGOl008TBJ35Kdt4Q/Z2GOdMKmOELa0=;
        b=Ag07XFKm1byI2WJ9DgEnCYDBrgGXnCZ81pHFMN2wCPo5ZLlu6qhy6P8ioWmb7lv4PP
         UteJ/2MHhrWnvgnKxol8Gp+2rrcrp9b8IW214H1UvnS9ginqGXRHmYebRc0+H1VR8D9Y
         ZbBcbas5hs3Tfygv0OwMWn2vI9AwZWMehU3JNXWQs8CRoV+4bPdU/Uoucv3IgDXqgJv7
         yzarAlqWGhR5yaIfHK43Zuz8r6VYoPHTpi0voUlD30snlr1JL604VnzOUWC1GVgTSDGF
         WHZmbbC5qlLmpaAWASA3ge0dM+G7X/URzd5fQtNcYpzx7DxstkwyhN3XcjweR5innD6z
         rIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162648; x=1784767448;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vobfv6qQPpjyzGOl008TBJ35Kdt4Q/Z2GOdMKmOELa0=;
        b=ENMVAGiyijDp9jrHB7dxEJur1C+ym+6ZoNJjmU5GDXB5ZCi8HUUyxF9nZq/sfQpTR4
         UG/Ue3Blyq1fLBgeQJhnTdV97fRwHWbDDQ63Z38gSN4O2jwJ0DF2cp8mWCWX9556kFVb
         I6KgB5FsVWyD1k2LD4k7GvO1GLVBWhsZkP1Ce24arXSksZx5Z7uDh29GYnzMKaP7u5x+
         +0I/LOWxFcq8DICjkkKehTjaKfVCULc9tMva8WZznZpgU0UQwLHNLjj1h0CC7v/5wfbe
         UY4cHANiFQEQdxHOGE/hi66YaaiiOVBVRoiNugyFTZJcxsOyLuyaPCfX4B6+BkaDDDKu
         +pfQ==
X-Gm-Message-State: AOJu0YzWgkWpuIZ9s+YNvaEZVfEUyZbCEtCl98pYXT1hanvZip+Iv9xv
	QXkffWjUNjbmxMouffwuTvGu0COzIXbW8VVECR7tgThvNMt++fJ+5TS+/1X3BA==
X-Gm-Gg: AfdE7ckGIIoEY/TOEND6bTrHCmiFj7fzlhiQBtlr0qA8l3fMU9Ri8L/Np7/HjqlWrlK
	oXHVW2pKoyMHEZR50Ha3KLZeAx/JwwPXi+bYs7P/L/E7xhYyIFBgc49jxHn2Cj4cWiOwUCNyjA/
	AggEov/qqOFGYThVdgZ02XL+FTwaYeDhvoOx3llb1DWZt3SLDzwumkz2pBdPjj1CBmbLuC05wtW
	8k0Y0BsBwwIjAskkEZoxU7T7NgVutTHVe1CBaXZ1HYK3QxUjK3q4NrsO9KDgSf3thCVXWgql3rM
	UCgOMHgbyoknzrb0aGRxLe2a/CXfjh6iqeklIIiVziFPXGe2aOSJ7om+OhIItWJeGMOVso6oIvh
	/rS+/MAKj11PfQkL2HY1bz8WB4cexiNmravRFob4R+Q3yPU0V5/NWFUZC1X9Sp0Nh9Dmg1wwVw4
	CTIP4FihiC67ONvt6omvNQ+Jaehs+qfbrfTYwR3XHT09g7y92wURE8KFAXWSDaUBASzUELPBqpx
	w7nKSD5Jg==
X-Received: by 2002:a05:6a20:4310:b0:3bf:e2dc:bc7d with SMTP id adf61e73a8af0-3c36c3b1de3mr5402079637.57.1784162648082;
        Wed, 15 Jul 2026 17:44:08 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:07 -0700 (PDT)
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
Subject: [PATCH net-next v1 06/11] net: flow_dissector: add fast-path for IP-in-IP family (IPIP / 4in6 / 6in4)
Date: Wed, 15 Jul 2026 17:43:52 -0700
Message-ID: <20260716004357.3652679-7-dave.seddon.ca@gmail.com>
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

Adds flow_dissect_fast_ipip_inner() — a small recursion helper
invoked from the existing flow_dissect_fast_ipv4() and
flow_dissect_fast_ipv6() helpers when the outer IP's protocol
(IPv4) or nexthdr (IPv6) is IPPROTO_IPIP or IPPROTO_IPV6 and the
ipip gate is on. Tail-calls into the matching inner IP fast-path
then stamps FLOW_DIS_ENCAPSULATION on key_control->flags. This is
the series' first tunnel descent: the fast path parses through the
tunnel header and dissects the inner flow, the pattern the GRE and
UDP-tunnel patches later in the series reuse.

Byte-identical with the slow path's IPPROTO_IPIP and IPPROTO_IPV6
switch cases in __skb_flow_dissect(): the slow path also lets the
inner IP overwrite outer addrs/basic and OR's ENCAP into the
control flags. The ENCAP write must happen *after* the inner
returns because the existing fast-path helpers unconditionally
set key_control->flags = 0 on entry (correct for the top-level
call but clobbers the encap flag during recursion); the
ipip_inner helper re-establishes ENCAP after the inner returns.

Coverage:
  outer IPv4, protocol == IPIP   -> inner IPv4
  outer IPv4, protocol == IPV6   -> inner IPv6 (6in4)
  outer IPv6, nexthdr  == IPIP   -> inner IPv4 (4in6)
  outer IPv6, nexthdr  == IPV6   -> inner IPv6

FLOW_DISSECTOR_F_STOP_BEFORE_ENCAP and STOP_AT_ENCAP don't apply
because the top-level dispatcher already rejects anything beyond
F_PARSE_1ST_FRAG, so the fast-path entry never sees the encap-stop
flags - packets that request them go to the slow path unchanged.

Gated by:
  - new DEFINE_STATIC_KEY_FALSE(flow_dissector_ipip_key)
  - new sysctl /proc/sys/net/flow_dissector/ipip (default 0)
  - static_branch_unlikely guard inside the v4/v6 helpers, hit only
    when the outer protocol/nexthdr is not TCP/UDP (i.e. the
    TCP/UDP fast-path was about to return false anyway)

Cost when off: the not-TCP/UDP fall-through grows by one
static_branch_unlikely check. The TCP/UDP hot path is
unchanged — the new branch is below the existing TCP/UDP fast-out.

The IPv6 helper's standalone not-TCP/UDP guard becomes unreachable
once the new block handles that case in full, so it is removed here.

Documentation/admin-guide/sysctl/net.rst grows an `ipip` subsection
under /proc/sys/net/flow_dissector/.

The IPv6-outer descent mirrors the slow path's outer writes (v6addrs,
addr_type) before recursing into the inner header. The slow path
fills these for the outer header and the inner pass then overwrites
only what it uses: an inner IPv4 overwrites just the first 8 bytes of
the addrs union, leaving outer-v6 bytes in the tail. Byte-identical
output means reproducing exactly that, residue included — the KUnit
equivalence test's 4in6 cases fail otherwise. (A non-zero outer flow
label defers before any descent — see the eth_ip patch's output
contract — so no label residue exists. The IPv4-outer descent needs
no mirroring: an inner IPv4 or IPv6 write always fully covers the
outer's 8 address bytes.)

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst |  19 ++++
 include/net/flow_dissector.h             |   1 +
 net/core/flow_dissector.c                | 117 ++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 1ee5419ffaeb..15c8ace2c0a4 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -553,6 +553,25 @@ vlan -> qinq staging used earlier in this series.
 
 Default: 0
 
+ipip
+~~~~
+
+IPv4-in-IPv4 (``IPPROTO_IPIP`` 4), IPv6-in-IPv4 (``IPPROTO_IPV6`` 41
+inside an IPv4 outer), IPv4-in-IPv6 and IPv6-in-IPv6 tunnels. When
+the outer IP fast-path notices the outer protocol/nexthdr is one of
+these and this gate is on, it skips the outer header and tail-calls
+into the inner IPv4 / IPv6 fast-path. The flow_keys ends up with the
+inner 5-tuple (matching the slow path's behaviour, where the inner
+parse overwrites the outer addrs/basic), plus
+FLOW_DIS_ENCAPSULATION set on key_control->flags.
+
+Byte-identical with the slow path's IPPROTO_IPIP / IPPROTO_IPV6
+switch cases for the eligible shape. Defers on any miss — including
+fragmented outer, unusual outer IHL, or unsupported inner shapes
+that the inner IP fast-path itself would defer.
+
+Default: 0
+
 3. /proc/sys/net/unix - Parameters for Unix domain sockets
 ----------------------------------------------------------
 
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 8df7821ba769..d9b4b461cd05 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -433,6 +433,7 @@ extern struct static_key_false flow_dissector_vlan_key;
 extern struct static_key_false flow_dissector_qinq_key;
 extern struct static_key_false flow_dissector_pppoe_key;
 extern struct static_key_false flow_dissector_mpls_key;
+extern struct static_key_false flow_dissector_ipip_key;
 
 /* struct flow_keys_digest:
  *
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0ec1a6a1bb0e..abf4fdb0100b 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -50,6 +50,8 @@ DEFINE_STATIC_KEY_FALSE(flow_dissector_pppoe_key);
 EXPORT_SYMBOL(flow_dissector_pppoe_key);
 DEFINE_STATIC_KEY_FALSE(flow_dissector_mpls_key);
 EXPORT_SYMBOL(flow_dissector_mpls_key);
+DEFINE_STATIC_KEY_FALSE(flow_dissector_ipip_key);
+EXPORT_SYMBOL(flow_dissector_ipip_key);
 
 /* IPv4 version/IHL byte of an option-less header: version 4, IHL 5. */
 #define FLOW_DIS_IPV4_VIHL_NOOPT	0x45
@@ -65,6 +67,12 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 				   void *target_container,
 				   const void *data,
 				   int nhoff, int hlen);
+static bool flow_dissect_fast_ipip_inner(const struct sk_buff *skb,
+					 struct flow_dissector *flow_dissector,
+					 void *target_container,
+					 const void *data,
+					 __be16 inner_eth_proto,
+					 int inner_nhoff, int hlen);
 
 /* One of the two dissectors the fast-path eligibility check admits;
  * defined here so flow_dissect_fast() below can reference it (its keys
@@ -1114,8 +1122,25 @@ static bool flow_dissect_fast_ipv4(const struct sk_buff *skb,
 		return false;
 
 	if (unlikely(iph->protocol != IPPROTO_TCP &&
-		     iph->protocol != IPPROTO_UDP))
+		     iph->protocol != IPPROTO_UDP)) {
+		/* IPIP / IPv6-in-IPv4 outer: defer to the inner fast-path and
+		 * stamp ENCAP. Outer addrs are not written -- the inner pass
+		 * overwrites them, as in the slow path.
+		 */
+		if (static_branch_unlikely(&flow_dissector_ipip_key)) {
+			if (iph->protocol == IPPROTO_IPIP)
+				return flow_dissect_fast_ipip_inner(skb,
+						flow_dissector, target_container,
+						data, htons(ETH_P_IP),
+						nhoff + (int)sizeof(*iph), hlen);
+			if (iph->protocol == IPPROTO_IPV6)
+				return flow_dissect_fast_ipip_inner(skb,
+						flow_dissector, target_container,
+						data, htons(ETH_P_IPV6),
+						nhoff + (int)sizeof(*iph), hlen);
+		}
 		return false;
+	}
 
 	thoff = nhoff + (int)sizeof(*iph);
 
@@ -1203,8 +1228,49 @@ static bool flow_dissect_fast_ipv6(const struct sk_buff *skb,
 		return false;
 
 	if (unlikely(iph->nexthdr != IPPROTO_TCP &&
-		     iph->nexthdr != IPPROTO_UDP))
-		return false;
+		     iph->nexthdr != IPPROTO_UDP)) {
+		/* IPIP / IPV6-in-IPv6 tunnel outer: same pattern as the
+		 * IPv4 helper. The nexthdr_IPIP / nexthdr_IPV6 cases
+		 * defer to the inner IP fast-path and stamp ENCAP.
+		 */
+		bool ipip = static_branch_unlikely(&flow_dissector_ipip_key) &&
+			    (iph->nexthdr == IPPROTO_IPIP ||
+			     iph->nexthdr == IPPROTO_IPV6);
+
+		if (!ipip)
+			return false;
+
+		/* Mirror the slow path's outer-IPv6 writes before the
+		 * descent. The slow path fills v6addrs for the outer
+		 * header and the inner pass then overwrites only what
+		 * it uses — an inner IPv4 leaves the tail of the addrs
+		 * union holding outer-v6 bytes. Byte-identical means
+		 * reproducing exactly that, residue included. (The
+		 * outer flow label is always zero here — a non-zero
+		 * label deferred above — so there is no label residue.)
+		 */
+		if (dissector_uses_key(flow_dissector,
+				       FLOW_DISSECTOR_KEY_IPV6_ADDRS)) {
+			key_addrs = skb_flow_dissector_target(flow_dissector,
+							      FLOW_DISSECTOR_KEY_IPV6_ADDRS,
+							      target_container);
+			memcpy(&key_addrs->v6addrs.src, &iph->saddr,
+			       sizeof(key_addrs->v6addrs.src));
+			memcpy(&key_addrs->v6addrs.dst, &iph->daddr,
+			       sizeof(key_addrs->v6addrs.dst));
+			key_control = skb_flow_dissector_target(flow_dissector,
+								FLOW_DISSECTOR_KEY_CONTROL,
+								target_container);
+			key_control->addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
+		}
+
+		return flow_dissect_fast_ipip_inner(skb,
+				flow_dissector, target_container,
+				data,
+				iph->nexthdr == IPPROTO_IPIP ?
+				htons(ETH_P_IP) : htons(ETH_P_IPV6),
+				nhoff + (int)sizeof(*iph), hlen);
+	}
 
 	thoff = nhoff + (int)sizeof(*iph);
 
@@ -1465,6 +1531,44 @@ static bool flow_dissect_fast_mpls(const struct sk_buff *skb,
 	return true;
 }
 
+/* IPIP / 4in6 / 6in4 inner descent: recurse into the inner IP
+ * fast-path, then stamp FLOW_DIS_ENCAPSULATION -- the inner helper
+ * zeros key_control->flags, so the ENCAP write must come after.
+ */
+static bool flow_dissect_fast_ipip_inner(const struct sk_buff *skb,
+					 struct flow_dissector *flow_dissector,
+					 void *target_container,
+					 const void *data,
+					 __be16 inner_eth_proto,
+					 int inner_nhoff, int hlen)
+{
+	struct flow_dissector_key_control *key_control;
+	bool ok;
+
+	if (inner_eth_proto == htons(ETH_P_IP))
+		ok = flow_dissect_fast_ipv4(skb, flow_dissector,
+					    target_container, data,
+					    inner_nhoff, hlen);
+	else if (inner_eth_proto == htons(ETH_P_IPV6))
+		ok = flow_dissect_fast_ipv6(skb, flow_dissector,
+					    target_container, data,
+					    inner_nhoff, hlen);
+	else
+		return false;
+
+	if (!ok)
+		return false;
+
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
@@ -2681,6 +2785,13 @@ static struct ctl_table flow_dissector_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_static_key,
 	},
+	{
+		.procname	= "ipip",
+		.data		= &flow_dissector_ipip_key.key,
+		.maxlen		= sizeof(flow_dissector_ipip_key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
 };
 
 static int __init flow_dissector_sysctl_init(void)
-- 
2.54.0

