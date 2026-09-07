Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0A2BDC1C;
	Mon,  7 Sep 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788750120; cv=none; b=hXnH8XFz+/mvzIbtwi3EQUwAnwuadCVa1oJMo0hO8JXfTDEkU2VOS+yIT4ZYuaHfBHwaGsUCK4naOXiepy9FAsQiOVFjNhJfTrQ/eTJ1XAJpgruitl+hdKFkCzJu1AV62PKwUd81J8EzUP7A5bylUmEPxOJEo8UGqXG0NCt4h5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788750120; c=relaxed/simple;
	bh=UEPUoGcF7oa68YMn4/8BDr/OhI1xYmdiu/yKbf/bFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ETHEE3PrFYhqgnVdJDnfcKM53xaK83kNaX3DNoNevisXwhjCaS5twPn0+c37n+baGciOsBfNCl9hUZkeD4d3oNqcqWMGqRsIGXFRTkyyhSjM6xRd1OYounRmMGRKf05dOWaTB/MZZ+L2xcRFmvLnmYf+xwWJziyZQtRKYv7MNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avnDvDgc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avnDvDgc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788750118; x=1820286118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UEPUoGcF7oa68YMn4/8BDr/OhI1xYmdiu/yKbf/bFjY=;
  b=avnDvDgcAKmjZtqu8wS83/3Jpu7rNgZWsnwy7qvZH99EamBaDDm1BXJu
   xzu9kIEpASTmDsHTkhTGEpZkZDRLfEWmjKABDf9nSVbEQ3w9/LKZPn37k
   qQAm6JqDPNTcx3VS9xyiql0hcbQTK83gVq7s99iJIL+cHSv4YnK0Mm3OX
   DXU0USBPe2uNmoTtC/qo/3/KphafGns1ceJyozzwEw/oJ6sisgHFEw/cB
   sQ8F0+cebVOz7IerAFnRmMbooFhvZCR3B1qwVgoyMxIViEDhV5menU4WM
   A1VrOotu6XLEQvS0Hra85zXJ8vU8rMR717pNhZ31J+XRCJTCBPYERAtJM
   Q==;
X-CSE-ConnectionGUID: XzbtBq6hSbuA1CefD9hVHQ==
X-CSE-MsgGUID: f5APEwIjRYCSs9g6PGZkUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="76705997"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="76705997"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 20:01:57 -0700
X-CSE-ConnectionGUID: NylP5cS6T6Ko0qgXvfppIg==
X-CSE-MsgGUID: xRTjAO1qRTyw7bmZbf8XDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268847217"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 20:01:54 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
Date: Mon,  7 Sep 2026 11:01:33 +0800
Message-ID: <20260907030133.482834-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The forwarding paths report an expired TTL or hop limit as
SKB_DROP_REASON_IP_INHDR, the reason otherwise used for a header that is
malformed (ip_input.c, exthdrs.c, br_netfilter). Nothing else in the drop
path separates the two: IPSTATS_MIB_INHDRERRORS covers both, and the TTL
check runs before NF_INET_FORWARD, so netfilter tracing stops at
PREROUTING and never sees the drop.

The Fedora bug linked below shows how that reads in practice. The
reporter took kfree_skb(reason=IP_INHDR, loc=ip_forward) to mean the
software header checksum check had failed, and worked through RX checksum
offload, tc csum actions and both libvirt firewall backends before the
drops turned out to be replies arriving with TTL 1. ip_forward() never
verifies the header checksum; that runs earlier, in ip_rcv_core(), and
reports IP_CSUM.

TTL expiry is not a corner case -- every traceroute through a Linux
router goes through too_many_hops.

The three loopback hop limit checks in exthdrs.c drop with no reason at
all; give them the new one.

IPSTATS_MIB_INHDRERRORS stays as it is: RFC 1213 counts time-to-live
exceeded under ipInHdrErrors. The drop reason has no such constraint.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2517131
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v4: kernel-doc says "<= 1" instead of "hit zero" (Jiayuan Chen)
v3: https://lore.kernel.org/netdev/20260904030112.450920-1-junjie.cao@intel.com/
v2: https://lore.kernel.org/netdev/20260901020613.417495-1-junjie.cao@intel.com/
v1: https://lore.kernel.org/netdev/20260825073906.336072-1-junjie.cao@intel.com/
 include/net/dropreason-core.h | 6 ++++++
 net/ipv4/ip_forward.c         | 2 +-
 net/ipv6/exthdrs.c            | 6 +++---
 net/ipv6/ip6_output.c         | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2f312d1f67d6..3d6aec203c3f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -128,6 +128,7 @@
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FN(RECURSION_LIMIT)		\
+	FN(IP_TTL_EXCEEDED)		\
 	FNe(MAX)
 
 /**
@@ -606,6 +607,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_OUTPUT,
 	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
 	SKB_DROP_REASON_RECURSION_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit <= 1
+	 * (see IPSTATS_MIB_INHDRERRORS)
+	 */
+	SKB_DROP_REASON_IP_TTL_EXCEEDED,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
index 8b65f12583eb..b242561d37e7 100644
--- a/net/ipv4/ip_forward.c
+++ b/net/ipv4/ip_forward.c
@@ -174,7 +174,7 @@ int ip_forward(struct sk_buff *skb)
 	/* Tell the sender its packet died... */
 	__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
 	icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
-	SKB_DR_SET(reason, IP_INHDR);
+	SKB_DR_SET(reason, IP_TTL_EXCEEDED);
 drop:
 	kfree_skb_reason(skb, reason);
 	return NET_RX_DROP;
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 09a4552f7f08..55391e2e5612 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -464,7 +464,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 			return -1;
 		}
 		ipv6_hdr(skb)->hop_limit--;
@@ -623,7 +623,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 			return -1;
 		}
 		ipv6_hdr(skb)->hop_limit--;
@@ -815,7 +815,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
 				    0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 			return -1;
 		}
 		ipv6_hdr(skb)->hop_limit--;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 96ee3de55f93..ddaba0aebcb1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -577,7 +577,7 @@ int ip6_forward(struct sk_buff *skb)
 		icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT, 0);
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 
-		kfree_skb_reason(skb, SKB_DROP_REASON_IP_INHDR);
+		kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 		return -ETIMEDOUT;
 	}
 
-- 
2.43.0

