Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABA3EC833;
	Thu, 10 Sep 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033794; cv=none; b=L9m1r5dSiTNl9jSiDo6joI6w1ELuDR43aXV11iMcjn54EHq9T1tuFoLbN8DQDgiAJOB6knH0/rrpaHVn5dkK+Tb1xtuiYtkAkAS/mJe+yM/CWAfaZLkoXXlfezf3dvZRKYe8ynxkJrdO5IOx6akqy5RweBi2pkp8DkfGeiPCIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033794; c=relaxed/simple;
	bh=3BAYu0D+Mo+P+pf6NkjoZAwucBgKWwDr/7pku6ciMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yykug8SqMobrlwtArUnqduSrMkXb2/FRws52GzdLr56ekiFW36tMKZ8IKJAcYBv9uPYJ3aUVx0ndyEkwp0I5IvhM9w/FpBKfWsF0OkhhgMUctVDX4sgnej6Xq5MbQgODHvFuC7Ix38cDIyKQVeEdn+Xg1zovgCZBV4oq+yVk+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InUByWLF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InUByWLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789033791; x=1820569791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3BAYu0D+Mo+P+pf6NkjoZAwucBgKWwDr/7pku6ciMYQ=;
  b=InUByWLFH0gS+hwDWtvgcQPjICaEBnbTrFQVr153U3TmuiomfHnP37O7
   LIeVQoxRRJoa4Y7MNdOjzIkMc7UCJrDrqwKI4vfkevdjdAeoLGGQNX7CB
   qPqLidqy+bQQG1DLW0tlwjxEk95usmKQsurq5Z1hMmRv6GjYma+Yu1Y+/
   aJRIgFdvNSuALS2AwTPf8YkucvJXq2HUWxu9wfBmnbEhYhdPm+QXtrvmS
   FqXj1p36qwVg8Q/+rJzwlmhsKUbF4whg25BXjT8lccWYrzkP2O9MHtDuB
   UIHBy68wbjkSdkNW5ULyY2kzq1JHODfwEk5hKdVtlJ+bWw2NYZenpeUew
   A==;
X-CSE-ConnectionGUID: VGYOR4qaRwKpRlcmZCiL9g==
X-CSE-MsgGUID: nb25ZWd4TsGjErSQPCwYpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100644670"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="100644670"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:49:49 -0700
X-CSE-ConnectionGUID: jWJMylsjRgiH4WPMwnabUQ==
X-CSE-MsgGUID: npujtPKFTwK2nlHbnq5NPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="271561696"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:49:46 -0700
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
	Hangbin Liu <hangbin.liu@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
Date: Thu, 10 Sep 2026 17:49:37 +0800
Message-ID: <20260910094937.536150-1-junjie.cao@intel.com>
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
v5: move the entry next to the other IP_* reasons, after IP_INVALID_DEST
    (Jakub Kicinski)
    IPVS decrement_ttl() is a follow-up: its xmit callers free at tx_error
    with plain kfree_skb(), so the reason has to come back out of
    __ip_vs_get_out_rt() (David Ahern, Hangbin Liu)
v4: https://lore.kernel.org/netdev/20260907030133.482834-1-junjie.cao@intel.com/
v3: https://lore.kernel.org/netdev/20260904030112.450920-1-junjie.cao@intel.com/
v2: https://lore.kernel.org/netdev/20260901020613.417495-1-junjie.cao@intel.com/
v1: https://lore.kernel.org/netdev/20260825073906.336072-1-junjie.cao@intel.com/
 include/net/dropreason-core.h | 6 ++++++
 net/ipv4/ip_forward.c         | 2 +-
 net/ipv6/exthdrs.c            | 6 +++---
 net/ipv6/ip6_output.c         | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2f312d1f67d6..12f909651591 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -93,6 +93,7 @@
 	FN(IP_INVALID_SOURCE)		\
 	FN(IP_LOCALNET)			\
 	FN(IP_INVALID_DEST)		\
+	FN(IP_TTL_EXCEEDED)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -474,6 +475,11 @@ enum skb_drop_reason {
 	 * 1) dest ip is 0
 	 */
 	SKB_DROP_REASON_IP_INVALID_DEST,
+	/**
+	 * @SKB_DROP_REASON_IP_TTL_EXCEEDED: IPv4 TTL or IPv6 hop limit <= 1
+	 * (see IPSTATS_MIB_INHDRERRORS)
+	 */
+	SKB_DROP_REASON_IP_TTL_EXCEEDED,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
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

