Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BF3D3D14;
	Tue, 25 Aug 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643561; cv=none; b=RlsWSr6F2aV55vu6lz95R/ibpLFJEqrGNJc4sVlfBsj73XW434QDdwLb9oggJuR2JFsMjIQDjy6fiAO1TbnPaOolMy9mbnpSakP719wjFU0CUnFAY7VnRSM1vp6wF7iXWofN7nRDFrEZRsQjeyw1ZETyi69lTARuth0WP5UpfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643561; c=relaxed/simple;
	bh=Ix/BHT81kZPoDKNVHSLLiR4CDY9vIlfk3g2S5VOVQyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJr1Hd+73rLruSxkWd5zhotRw9GKnVBwtWdvquML4jwSdzk7WHPxVfRArEX8djXMEHNgueLjS+dtb+enNZ65P8UNNXL2tBTILpVSb7WW7LAufODhS+xHOgyIEO3cHenDhyA4+pzFgkGJy6ZQ/JC88r7zZErjCSNJlKffB7tSCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE8OlKX2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE8OlKX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787643559; x=1819179559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ix/BHT81kZPoDKNVHSLLiR4CDY9vIlfk3g2S5VOVQyc=;
  b=TE8OlKX2twmBNbcsNzaSkZAr0jfkRo9h0bonBVj3LN2eQMvjOUqtdmgD
   MRM1pOCZ4BZRrPFF9u45NwQCySF4FYBbz/YvBRmPIFrxz8mxtGgp7HQKi
   YfeYHCZ8Dh6qxD624RilJVkepQdvFMnUsoSMTJLm9PqD3xvlq8MpyoUIa
   e/OOutYhiNIaA9r4yZyf2mDXaWr6VWlFU+pKCURJSucb1fXj2WxFQMDSs
   VN2r3s72cC0O4kf8zgT3qhY20IcTQ7IH8cSf5Wafw4NrVop0EaDJICgs9
   NGRwvWoi3IFErR4ojNPvFD2fyvnk3Oo/gtT4YQ2Heq4r5iW1VCn0BpVDx
   w==;
X-CSE-ConnectionGUID: P1uOSS/aTK2CtARk5NNS6w==
X-CSE-MsgGUID: tcfF/x3+QL2lNGGpOHjnnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99451300"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="99451300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 00:39:18 -0700
X-CSE-ConnectionGUID: SCNcEudRSbOaYE2aUOeLmg==
X-CSE-MsgGUID: pF7ZWUSLSNyNhYl9oSJ8cw==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 00:39:16 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dropreason: add SKB_DROP_REASON_IP_TTL_EXCEEDED
Date: Tue, 25 Aug 2026 15:39:06 +0800
Message-ID: <20260825073906.336072-1-junjie.cao@intel.com>
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
 include/net/dropreason-core.h | 6 ++++++
 net/ipv4/ip_forward.c         | 2 +-
 net/ipv6/exthdrs.c            | 6 +++---
 net/ipv6/ip6_output.c         | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2f312d1f67d6..3046a2699479 100644
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
+	 * zero on a packet being forwarded (see IPSTATS_MIB_INHDRERRORS)
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
index 9c677eb1d1a6..b9103b02e8c7 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -471,7 +471,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 			return -1;
 		}
 		ipv6_hdr(skb)->hop_limit--;
@@ -633,7 +633,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 			return -1;
 		}
 		ipv6_hdr(skb)->hop_limit--;
@@ -821,7 +821,7 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
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

