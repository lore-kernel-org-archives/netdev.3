Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463F3B0583;
	Fri,  4 Sep 2026 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490887; cv=none; b=kW8wWQC6uTjROJrqGcIuDLCk96tly0LlwB93V3WM23ZHsaCfOdnQ/D/KYXuD0Jf5YL0Akp4OjfJla9igOLWtnFzECXjSdCow3gyfFL+jeqNfMhq31Jz3mmcb9sHq+LBLkQqC/ESDdv0HV+RIgJdYwFzpxSYoACfTDFlk6xe19Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490887; c=relaxed/simple;
	bh=iB/LIVT+7LyebkjdctEfNIn73Fdepn/Ybg7PtZxfME0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6NfYIQanpBqzbCor5UlMlO9qSxYWj9BvVTt4m85/6ztZxEkQyFknvY0YirU2wMTqutOf0rZyzmy/Cybt4teJGdqIAd7N+9BLJUN4QjTL6H7uWoyBTieGFM8CbwU+o4Yzh+qoNB8GnK+IHnXwWSq89tkvImi7iQCIAaW/tcJM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emXn/IZE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emXn/IZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788490885; x=1820026885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iB/LIVT+7LyebkjdctEfNIn73Fdepn/Ybg7PtZxfME0=;
  b=emXn/IZESH4eJ1eWYw4vgw+Ainlgk1L0K5LKMZHySipejxfuQvkO3df9
   OKVKzwCr9598oodsuKpF/R2wkS4xXoDQjptv4QRVX9H0bw62nXUJ9HePF
   mvQ+PozkiSbw8m1MXFVsAsmpBiGBh6y3lrKABPcdemgnHy9DTXAJ5ii4I
   ZZSc/7sGhMhJ74yWrzL9oUaGsN4Q0efAVFzRsvhx0iJctveKFfVfmtSfu
   RniTJd5sgd+l/y/ID+7ujfxc7y3WZ9vi4RWLq2HZE+oilgPk1pwfkHkSF
   T0ONWc9o2QCVDrLRmoNEf3g3b54zc9sH3xpMC7Yw3bUJgdtlaNj5P0IYf
   w==;
X-CSE-ConnectionGUID: bFBUFqcCTImPOsH1mjBNAQ==
X-CSE-MsgGUID: cjTrBNjmSImj+1MTQ1sP4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92807015"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92807015"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:01:21 -0700
X-CSE-ConnectionGUID: 2bXcDhOST/66VzQF8sIYHg==
X-CSE-MsgGUID: B2qQoxbpTc2i1TZIwZHUJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="273690264"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:01:18 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
Date: Fri,  4 Sep 2026 11:01:12 +0800
Message-ID: <20260904030112.450920-1-junjie.cao@intel.com>
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
---
v3: drop the "on a packet being forwarded" qualifier from the kernel-doc;
    the reason also covers the loopback hop-limit checks in exthdrs.c
    (David Ahern)
v2: https://lore.kernel.org/netdev/20260901020613.417495-1-junjie.cao@intel.com/
v1: https://lore.kernel.org/netdev/20260825073906.336072-1-junjie.cao@intel.com/

 include/net/dropreason-core.h | 6 ++++++
 net/ipv4/ip_forward.c         | 2 +-
 net/ipv6/exthdrs.c            | 6 +++---
 net/ipv6/ip6_output.c         | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2f312d1f67d6..ed2c02884b68 100644
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
+	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit hit
+	 * zero (see IPSTATS_MIB_INHDRERRORS)
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
index 51941ad656a3..74caaf8746ff 100644
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
index 8fc4766c8da9..0b6d78c8b6be 100644
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

