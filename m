Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633952D2D6
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115357; cv=none; b=DNyjtAYbJZecdV1eLr7Kk1BxuMNKs1FfbsBgYxNsfuQtAkKx9YMCBQDh6j+te+6Y0eOn8TW3guPX4M34t0VfBJ1McUfHMPz/ER71Uz2qixSggODuUHI39vvsHpm3U+hvJE9sqUjQP3NU5TGNo2aIK5ECAfEP8ENogaV4Lf0vPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115357; c=relaxed/simple;
	bh=LYqfMz1Xf9p68ThTbvdVPQbfV51P5lpd0AW0nBgb1t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLB9PTf4WEvmUSg6m/F98efaP4BcFLQcWf065ly/1lJCDiZJUjfvNZZuvCA6kjuIit8ivId5P0hCfepr9+ed0naH1QRYEuYwNrXTpmotbPO2yzRzwORoLYEYORsnjpMzxEYShdH0gfa+jKKUgVuI7cU487lfB5GXx1ELOdJ6IdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfOd3Qr3; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfOd3Qr3"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74dbc7359so265660e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115341; x=1790720141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfn824KmhJ9fBHCepYYAG7VguuAYpc4vdl723gZMDWQ=;
        b=RfOd3Qr34eZrYj8SIuFYyYw7C9ez/wz6ENhh/qtFr7hVxu67N8NLnybepvEYCBQBbZ
         +ZfIohj1TEPx5nggIApmY+gExlRnGr5ONFirP5BzZJk1MKWhCgvwkWd+iZTPGhZ/p4b4
         /yKK+gV11GbL8iX/kZKSO61daoRC2xodQKFTSiJE5VFw833DHZOxecBoorJQaJZSAfTX
         FogQxHJIti6jwKia8S9Ahjpfoza5TblESsFQoPrhBZub17SoheGOJ/bhxF1RyT2Z2Mnl
         +wY2aU2TiKej/aVwWePPY2cxkHtEXLW2YYA2Yid9QFHGN9pPDEJx2x8iqBBLF9+lw/RW
         67+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115341; x=1790720141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tfn824KmhJ9fBHCepYYAG7VguuAYpc4vdl723gZMDWQ=;
        b=PkBNaY4iO6TAsrPhUQaERSNWLvesPXmh5YqTmPtJ2Tfnegbag85CwN3hxYG7KA+flo
         6PLWYv+gqAUy2Rp0BPyInfj8toojVYizl/nqfDp6lBMmSnaKPAY5IO5o8yCJCe64Z9VQ
         D9S6yfPXqwS0LbgZGQQZhP8uqorA2adkmzhlAVXyB6X5Ljiwh+I+9ZUhcZzul2yyHjMI
         6+DAqZSS3kDnFghQZuTvGyp12JFVLMu8pwNeKAlcCPVL+VaP02sqQn7sKtUsTN4e5Jes
         n08xUb/aJCqSw3MFqPXINV3VQhZqbR4XuiSrB/xhHwwNpenzNRaXDddllhk0reC4DVCX
         oSzg==
X-Gm-Message-State: AFuF++kwUjZXdztLHiSicvn/QJxD95zXWtIBevQdu0DCKL+l42e7SBew
	OYzEx/PAt1QMo7GCmYXk56hHE0JCK7dxzGE6Hc2aLxynmbMnYV8LQhdukBtL4JBLKH4=
X-Gm-Gg: AYBFou3QstbjoiOqEgzthhQVQeAmuCnr3UH7ZBOs3kj8AtMJYrQJI4b4WPumgTDN+ZW
	6AhDIqZMP5Lkm9/GxnyyHohtkhxzUjTCtUOvGP7rqMcvjxxRS0hkrLGhnBdWCMGQ0Eh6UBVquk0
	5Td9S4bsO7ZtNO7cuBAzEM47Zk0YkVhAs3vfiUGDmOmBBuWb7fCiIdIe8SdJ8LUXJ5vcx+5R8iK
	mCSUtfJLGAC205/VAD7rafhrD6J83nKOlVcsOR9olo/Wj1SuAu2axrgNkaqRF66zGCcEBvnB0lu
	kMcpkgzRoygFKWbnaRXc47Vdew8T6LL5rPMx1tFyOoalyGtPlamlszGeuIAjHFoDICNpQfG3Htq
	w8InovB8kGNFMXBUGGUx4Rg3xL4KKMxXQhfypsVgz+TdudSjg4u8EJXzCMy3ZGO/jiL8BmVTcnk
	EV3pIDzmLE6EmN82YCk0UEIwfKox1LZQYzGcypqPG2SMXNW6ZikTejU/OTBFLhMub23SUz/vghU
	Jv4x3SRK3ReutbYBE+e/XEFtn2lHFS/91TBlqhcGDhTGIrvgznuwDRsECPiAA==
X-Received: by 2002:a05:6512:6204:b0:5b8:b37f:15a with SMTP id 2adb3069b0e04-5b8d896873bmr146541e87.3.1790115341027;
        Tue, 22 Sep 2026 15:15:41 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([94.28.220.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d857873asm164920e87.17.2026.09.22.15.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:15:40 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 10/10] ip6_tunnel: add drop reasons to the transmit path
Date: Wed, 23 Sep 2026 01:15:07 +0300
Message-ID: <20260922221507.3268127-11-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
References: <20260922221507.3268127-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do for the IPv6 tunnels what the previous patches did for the IPv4 ones.
The situation is the same, with one difference: ip6_tnl_xmit() does not
free the packet itself, it returns an error and the callers do, so the
reason has to travel with it.

Make ip6_tnl_xmit() return the drop reason, SKB_NOT_DROPPED_YET on
success, instead of 0, -1 or an errno, and do the same for
ipxip6_tnl_xmit(), __gre6_xmit() and the ip6gre_xmit_*() helpers, so
that the ndo_start_xmit handlers, where the packet is actually freed,
can report it. The callers only told success from failure and looked
for -EMSGSIZE to send an ICMP error back. ip6_tnl_xmit() returns
-EMSGSIZE only for a packet that exceeds the path MTU, which is exactly
when it reports SKB_DROP_REASON_PKT_TOO_BIG, so the ICMP error is now
sent when that reason is returned. A failed xfrm lookup never returns
-EMSGSIZE, so its errno only ever meant failure and goes away.
__gre6_xmit() was declared as returning netdev_tx_t while it returned an
errno, and now returns the reason as well.

ip6_gre is converted in the same patch because it calls ip6_tnl_xmit()
and depends on its return value.

As in ip_gre, the ndo_start_xmit handlers take the length reason from
pskb_inet_may_pull_reason() instead of pskb_inet_may_pull(). The other
reasons are the ones already used on the IPv4 side:

 - SKB_DROP_REASON_PKT_TOO_BIG for a packet that exceeds the path MTU,
 - SKB_DROP_REASON_IP_OUTNOROUTES for the route and xfrm lookups,
   including the source address selection that a collect_md tunnel does
   when the flow has no source address,
 - SKB_DROP_REASON_NO_TX_TARGET when an NBMA tunnel gets an skb with no
   destination to derive its endpoint from,
 - SKB_DROP_REASON_NEIGH_CREATEFAIL when the NBMA neighbour lookup
   fails,
 - SKB_DROP_REASON_RECURSION_LIMIT for a route pointing back at the
   tunnel, and for the trivial tunnelling loop ip6_tnl_addr_conflict()
   guards against, a packet whose source is the exit point of the
   tunnel,
 - SKB_DROP_REASON_NOMEM for the allocations,
 - SKB_DROP_REASON_TUNNEL_TXINFO for the collect_md metadata checks,
 - SKB_DROP_REASON_TNL_ENCAP when the encapsulation header cannot be
   built, and for a collect_md tunnel that has an encapsulation
   configured, which ip6_tnl_xmit() does not support,
 - SKB_DROP_REASON_UNHANDLED_PROTO for a payload the tunnel does not
   carry, either by its mode or because it is neither IPv4, IPv6 nor
   MPLS, and for an ERSPAN version that is not implemented.

Two more fit here: SKB_DROP_REASON_DEV_READY when ip6_tnl_xmit_ctl()
refuses the transmit, and SKB_DROP_REASON_IPV6_BAD_EXTHDR when the
packet's tunnel encapsulation limit option is 0, which forbids
encapsulating it again.

A collect_md tunnel has no fixed exit point and its raddr is normally
::, so ip6_tnl_addr_conflict() and the same check in ip6gre_xmit_ipv6()
also drop the packets it sends from ::, such as the DAD probes of an
ip6gretap device. They were dropped before as well;
SKB_DROP_REASON_RECURSION_LIMIT names the check that drops them.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip6_tunnel.h |   5 +-
 net/ipv6/ip6_gre.c       | 137 ++++++++++++++++++++++++---------------
 net/ipv6/ip6_tunnel.c    | 100 ++++++++++++++++------------
 3 files changed, 146 insertions(+), 96 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index d1f0a427e9c8..363eed61b296 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -143,8 +143,9 @@ int ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		bool log_ecn_error);
 int ip6_tnl_xmit_ctl(struct ip6_tnl *t, const struct in6_addr *laddr,
 		     const struct in6_addr *raddr);
-int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
-		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto);
+enum skb_drop_reason
+ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
+	     struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto);
 __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw);
 __u32 ip6_tnl_get_cap(struct ip6_tnl *t, const struct in6_addr *laddr,
 			     const struct in6_addr *raddr);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 6a0a508e0091..31930ff813dd 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -716,10 +716,10 @@ static struct ip_tunnel_info *skb_tunnel_info_txcheck(struct sk_buff *skb)
 	return tun_info;
 }
 
-static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
-			       struct net_device *dev, __u8 dsfield,
-			       struct flowi6 *fl6, int encap_limit,
-			       __u32 *pmtu, __be16 proto)
+static enum skb_drop_reason __gre6_xmit(struct sk_buff *skb,
+					struct net_device *dev, __u8 dsfield,
+					struct flowi6 *fl6, int encap_limit,
+					__u32 *pmtu, __be16 proto)
 {
 	struct ip6_tnl *tunnel = netdev_priv(dev);
 	IP_TUNNEL_DECLARE_FLAGS(flags);
@@ -744,7 +744,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 		tun_info = skb_tunnel_info_txcheck(skb);
 		if (IS_ERR(tun_info) ||
 		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6))
-			return -EINVAL;
+			return SKB_DROP_REASON_TUNNEL_TXINFO;
 
 		key = &tun_info->key;
 		memset(fl6, 0, sizeof(*fl6));
@@ -763,7 +763,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 		tun_hlen = gre_calc_hlen(flags);
 
 		if (skb_cow_head(skb, dev->needed_headroom ?: tun_hlen + tunnel->encap_hlen))
-			return -ENOMEM;
+			return SKB_DROP_REASON_NOMEM;
 
 		gre_build_header(skb, tun_hlen,
 				 flags, protocol,
@@ -774,7 +774,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 
 	} else {
 		if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
-			return -ENOMEM;
+			return SKB_DROP_REASON_NOMEM;
 
 		ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
@@ -789,9 +789,11 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 			    NEXTHDR_GRE);
 }
 
-static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
+static inline enum skb_drop_reason ip6gre_xmit_ipv4(struct sk_buff *skb,
+						    struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	enum skb_drop_reason reason;
 	int encap_limit = -1;
 	struct flowi6 fl6;
 	__u8 dsfield = 0;
@@ -807,54 +809,56 @@ static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
 	if (err)
-		return -1;
+		return SKB_DROP_REASON_NOMEM;
 
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			  skb->protocol);
-	if (err != 0) {
+	reason = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			     skb->protocol);
+	if (reason) {
 		/* XXX: send ICMP error even if DF is not set. */
-		if (err == -EMSGSIZE)
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG)
 			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 				      htonl(mtu));
-		return -1;
+		return reason;
 	}
 
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
-static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
+static inline enum skb_drop_reason ip6gre_xmit_ipv6(struct sk_buff *skb,
+						    struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	enum skb_drop_reason reason;
 	int encap_limit = -1;
 	struct flowi6 fl6;
 	__u8 dsfield = 0;
 	__u32 mtu;
-	int err;
 
 	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
-		return -1;
+		return SKB_DROP_REASON_RECURSION_LIMIT;
 
 	if (!t->parms.collect_md &&
 	    prepare_ip6gre_xmit_ipv6(skb, dev, &fl6, &dsfield, &encap_limit))
-		return -1;
+		return SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 
 	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 					      t->parms.o_flags)))
-		return -1;
+		return SKB_DROP_REASON_NOMEM;
 
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit,
-			  &mtu, skb->protocol);
-	if (err != 0) {
-		if (err == -EMSGSIZE)
+	reason = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit,
+			     &mtu, skb->protocol);
+	if (reason) {
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG)
 			icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-		return -1;
+		return reason;
 	}
 
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
-static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
+static enum skb_drop_reason ip6gre_xmit_other(struct sk_buff *skb,
+					      struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	int encap_limit = -1;
@@ -870,25 +874,28 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
 	if (err)
-		return err;
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu, skb->protocol);
+		return SKB_DROP_REASON_NOMEM;
 
-	return err;
+	return __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			   skb->protocol);
 }
 
 static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	struct net_device *dev)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
 	__be16 payload_protocol;
-	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
-	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
+	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err;
+	}
 
 	if (t->parms.collect_md)
 		tun_info = skb_tunnel_info_txcheck(skb);
@@ -896,17 +903,17 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	payload_protocol = skb_protocol(skb, true);
 	switch (payload_protocol) {
 	case htons(ETH_P_IP):
-		ret = ip6gre_xmit_ipv4(skb, dev);
+		reason = ip6gre_xmit_ipv4(skb, dev);
 		break;
 	case htons(ETH_P_IPV6):
-		ret = ip6gre_xmit_ipv6(skb, dev);
+		reason = ip6gre_xmit_ipv6(skb, dev);
 		break;
 	default:
-		ret = ip6gre_xmit_other(skb, dev);
+		reason = ip6gre_xmit_other(skb, dev);
 		break;
 	}
 
-	if (ret < 0)
+	if (reason)
 		goto tx_err;
 
 	return NETDEV_TX_OK;
@@ -915,13 +922,14 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
 static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
@@ -930,23 +938,29 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	int encap_limit = -1;
 	__u8 dsfield = false;
 	struct flowi6 fl6;
-	int err = -EINVAL;
 	__be16 proto;
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
-	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
+	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err;
+	}
 
-	if (gre_handle_offloads(skb, false))
+	if (gre_handle_offloads(skb, false)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err;
+	}
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len)) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_err;
+		}
 		truncate = true;
 	}
 
@@ -966,8 +980,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			truncate = true;
 	}
 
-	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
+	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err;
+	}
 
 	IPCB(skb)->flags = 0;
 
@@ -981,8 +997,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 
 		tun_info = skb_tunnel_info_txcheck(skb);
 		if (IS_ERR(tun_info) ||
-		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6))
+		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
+		}
 
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));
@@ -994,10 +1012,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 
 		dsfield = key->tos;
 		if (!test_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
-			      tun_info->key.tun_flags))
+			      tun_info->key.tun_flags)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
-		if (tun_info->options_len < sizeof(*md))
+		}
+		if (tun_info->options_len < sizeof(*md)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
+		}
 		md = ip_tunnel_info_opts(tun_info);
 
 		tun_id = tunnel_id_to_key32(key->tun_id);
@@ -1015,6 +1037,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					       truncate, false);
 			proto = htons(ETH_P_ERSPAN2);
 		} else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_err;
 		}
 	} else {
@@ -1025,11 +1048,16 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 						 &dsfield, &encap_limit);
 			break;
 		case htons(ETH_P_IPV6):
-			if (ipv6_addr_equal(&t->parms.raddr, &ipv6_hdr(skb)->saddr))
+			if (ipv6_addr_equal(&t->parms.raddr,
+					    &ipv6_hdr(skb)->saddr)) {
+				reason = SKB_DROP_REASON_RECURSION_LIMIT;
 				goto tx_err;
+			}
 			if (prepare_ip6gre_xmit_ipv6(skb, dev, &fl6,
-						     &dsfield, &encap_limit))
+						     &dsfield, &encap_limit)) {
+				reason = SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 				goto tx_err;
+			}
 			break;
 		default:
 			memcpy(&fl6, &t->fl.u.ip6, sizeof(fl6));
@@ -1048,6 +1076,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					       truncate, false);
 			proto = htons(ETH_P_ERSPAN2);
 		} else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_err;
 		}
 
@@ -1065,11 +1094,11 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		if (dst_mtu(dst) > mtu)
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 	}
-	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			   NEXTHDR_GRE);
-	if (err != 0) {
+	reason = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			      NEXTHDR_GRE);
+	if (reason) {
 		/* XXX: send ICMP error even if DF is not set. */
-		if (err == -EMSGSIZE) {
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG) {
 			if (skb->protocol == htons(ETH_P_IP))
 				icmp_ndo_send(skb, ICMP_DEST_UNREACH,
 					      ICMP_FRAG_NEEDED, htonl(mtu));
@@ -1085,7 +1114,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 458ce328311b..77400a1087af 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1103,14 +1103,14 @@ EXPORT_SYMBOL_GPL(ip6_tnl_xmit_ctl);
  *   it.
  *
  * Return:
- *   0 on success
- *   -1 fail
- *   %-EMSGSIZE message too big. return mtu in this case.
+ *   %SKB_NOT_DROPPED_YET on success, otherwise the drop reason.
+ *   %SKB_DROP_REASON_PKT_TOO_BIG means the message is too big, the path MTU
+ *   is stored in @pmtu in this case.
  **/
 
-int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
-		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu,
-		 __u8 proto)
+enum skb_drop_reason
+ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
+	     struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net *net = t->net;
@@ -1121,11 +1121,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	int err_count, mtu;
 	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
 	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	unsigned int max_headroom = psh_hlen;
 	__be16 payload_protocol;
 	bool use_cache = false;
 	u8 hop_limit;
-	int err = -1;
 
 	payload_protocol = skb_protocol(skb, true);
 
@@ -1143,13 +1143,17 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			struct neighbour *neigh;
 			int addr_type;
 
-			if (!skb_dst(skb))
+			if (!skb_dst(skb)) {
+				reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_err_link_failure;
+			}
 
 			neigh = dst_neigh_lookup(skb_dst(skb),
 						 &ipv6_hdr(skb)->daddr);
-			if (!neigh)
+			if (!neigh) {
+				reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
 				goto tx_err_link_failure;
+			}
 
 			addr6 = (struct in6_addr *)&neigh->primary_key;
 			addr_type = ipv6_addr_type(addr6);
@@ -1162,8 +1166,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		} else if (payload_protocol == htons(ETH_P_IP)) {
 			const struct rtable *rt = skb_rtable(skb);
 
-			if (!rt)
+			if (!rt) {
+				reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_err_link_failure;
+			}
 
 			if (rt->rt_gw_family == AF_INET6)
 				memcpy(&fl6->daddr, &rt->rt_gw6, sizeof(fl6->daddr));
@@ -1180,8 +1186,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	if (use_cache)
 		dst = dst_cache_get(&t->dst_cache);
 
-	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
+	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err_link_failure;
+	}
 
 	if (!dst) {
 route_lookup:
@@ -1190,18 +1198,22 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 		dst = ip6_route_output(net, NULL, fl6);
 
-		if (dst->error)
+		if (dst->error) {
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
+		}
 		dst = xfrm_lookup(net, dst, flowi6_to_flowi(fl6), NULL, 0);
 		if (IS_ERR(dst)) {
-			err = PTR_ERR(dst);
 			dst = NULL;
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
 		}
 		if (t->parms.collect_md && ipv6_addr_any(&fl6->saddr) &&
 		    ipv6_dev_get_saddr(net, ip6_dst_idev(dst)->dev,
-				       &fl6->daddr, 0, &fl6->saddr))
+				       &fl6->daddr, 0, &fl6->saddr)) {
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
+		}
 		ndst = dst;
 	}
 
@@ -1211,6 +1223,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     t->parms.name);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_err_dst_release;
 	}
 	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
@@ -1224,7 +1237,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 	if (skb->len - t->tun_hlen - eth_hlen > mtu && !skb_is_gso(skb)) {
 		*pmtu = mtu;
-		err = -EMSGSIZE;
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_err_dst_release;
 	}
 
@@ -1247,12 +1260,16 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom += LL_RESERVED_SPACE(tdev);
 
-	if (skb_cow_head(skb, max_headroom))
+	if (skb_cow_head(skb, max_headroom)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err_dst_release;
+	}
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (t->encap.type != TUNNEL_ENCAP_NONE) {
+			reason = SKB_DROP_REASON_TNL_ENCAP;
 			goto tx_err_dst_release;
+		}
 	} else {
 		if (use_cache && ndst)
 			dst_cache_set_ip6(&t->dst_cache, ndst, &fl6->saddr);
@@ -1275,9 +1292,8 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			+ dst->header_len + t->hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	err = ip6_tnl_encap(skb, t, &proto, fl6);
-	if (err)
-		return err;
+	if (ip6_tnl_encap(skb, t, &proto, fl6))
+		return SKB_DROP_REASON_TNL_ENCAP;
 
 	if (encap_limit >= 0) {
 		init_tel_txopt(&opt, encap_limit);
@@ -1294,21 +1310,22 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ipv6h->saddr = fl6->saddr;
 	ipv6h->daddr = fl6->daddr;
 	ip6tunnel_xmit(NULL, skb, dev, 0);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 tx_err_link_failure:
 	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
-	return err;
+	return reason;
 }
 EXPORT_SYMBOL(ip6_tnl_xmit);
 
-static inline int
+static inline enum skb_drop_reason
 ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 		u8 protocol)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	enum skb_drop_reason reason;
 	struct ipv6hdr *ipv6h;
 	const struct iphdr  *iph;
 	int encap_limit = -1;
@@ -1317,11 +1334,10 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 	__u8 dsfield, orig_dsfield;
 	__u32 mtu;
 	u8 tproto;
-	int err;
 
 	tproto = READ_ONCE(t->parms.proto);
 	if (tproto != protocol && tproto != 0)
-		return -1;
+		return SKB_DROP_REASON_UNHANDLED_PROTO;
 
 	if (t->parms.collect_md) {
 		struct ip_tunnel_info *tun_info;
@@ -1330,7 +1346,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 		tun_info = skb_tunnel_info(skb);
 		if (unlikely(!tun_info || !(tun_info->mode & IP_TUNNEL_INFO_TX) ||
 			     ip_tunnel_info_af(tun_info) != AF_INET6))
-			return -1;
+			return SKB_DROP_REASON_TUNNEL_TXINFO;
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));
 		fl6.flowi6_proto = protocol;
@@ -1367,7 +1383,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 				if (tel->encap_limit == 0) {
 					icmpv6_ndo_send(skb, ICMPV6_PARAMPROB,
 							ICMPV6_HDR_FIELD, offset + 2);
-					return -1;
+					return SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 				}
 				encap_limit = tel->encap_limit - 1;
 			}
@@ -1409,15 +1425,15 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 	dsfield = INET_ECN_encapsulate(dsfield, orig_dsfield);
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
-		return -1;
+		return SKB_DROP_REASON_NOMEM;
 
 	skb_set_inner_ipproto(skb, protocol);
 
-	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			   protocol);
-	if (err != 0) {
+	reason = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			      protocol);
+	if (reason) {
 		/* XXX: send ICMP error even if DF is not set. */
-		if (err == -EMSGSIZE)
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG)
 			switch (protocol) {
 			case IPPROTO_IPIP:
 				icmp_ndo_send(skb, ICMP_DEST_UNREACH,
@@ -1429,20 +1445,21 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 			default:
 				break;
 			}
-		return -1;
+		return reason;
 	}
 
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static netdev_tx_t
 ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip6_tnl *t = netdev_priv(dev);
 	u8 ipproto;
-	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
 	switch (skb->protocol) {
@@ -1450,19 +1467,22 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		ipproto = IPPROTO_IPIP;
 		break;
 	case htons(ETH_P_IPV6):
-		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb)))
+		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb))) {
+			reason = SKB_DROP_REASON_RECURSION_LIMIT;
 			goto tx_err;
+		}
 		ipproto = IPPROTO_IPV6;
 		break;
 	case htons(ETH_P_MPLS_UC):
 		ipproto = IPPROTO_MPLS;
 		break;
 	default:
+		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 		goto tx_err;
 	}
 
-	ret = ipxip6_tnl_xmit(skb, dev, ipproto);
-	if (ret < 0)
+	reason = ipxip6_tnl_xmit(skb, dev, ipproto);
+	if (reason)
 		goto tx_err;
 
 	return NETDEV_TX_OK;
@@ -1470,7 +1490,7 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 tx_err:
 	DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
-- 
2.47.3

