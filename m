Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352188;
	b=SAgP1m8z7DTv2uSFm1wQ8AGSKUf/AF6Y6wCZ9dw0krvafRFG56z49u3DALcB9w8GDn7I
	 9E2nOD32AIMrDYiP0lEwIa/nVVTlvKZCbESKvZgxoGafPf3BCwedPU4tqc97Wv6DAkl7X
	 pbtdIzdAE6YirAelAsUQkL2vcuqLIve4LdaG1NfNUIEqgH+crftrFxbkSiz4/JQZRbtxO
	 XhGJ8f2fLFLAZaZa4qiGVBBwA+Xh4+u4n7jc4jDoa9K4rnxlgkueIX+QlXnbK3qTFBVtJ
	 dpK4Ha83Czg92Kez4U0B41PIMnDv/QlgvkPtaTMuYf8GY0vRan70OzsB37tCirVFI8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=76Cktt4TZWV1Q1Xxiy9j0GML3rCKdijj27UwdsH+dr4=;
	b=n2yywINqVD3HxSRk/N9SEeOFZHDsICKQ5G7xIuEauoZbqodLf4MkWxs01ZCs+paGxAlR
	 MhX/60KM0t0tgyxtZhAx6vwSATRGqcZvgU1KRh2iQqs0FM/ir9plnEGFGSvcUSLsdkKnd
	 O/Nty3jnQdIjyFPMMNzpFf9CWYBh7+MStmQUw7t411dG6Aee/WuBthov6rBS2acBhH12g
	 1MXFQykw6l8JTlXV1CxaaoC0Y9s3dx2iwF/roxDa8LWCrgCDGeIOHS0a1c6keW/2bAPdD
	 98Zv7k2/a+C01Q0hBCVa9aunFe+0BOtCrt5RzKpbIuc4ao84XWYUjmcLCl09I6gYoJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2xku1QP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4C606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2xku1QP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960F61F0093A;
	Fri, 30 Oct 2026 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793352187;
	bh=76Cktt4TZWV1Q1Xxiy9j0GML3rCKdijj27UwdsH+dr4=;
	h=From:To:Cc:Subject:Date;
	b=e2xku1QPwy4a6KWC6o3zCJQHqGE3EpImUooynCpQkrEcL7TRQgOBqrvCX3GXGnnA5
	 MnAmCd8V7LP6MTFINwNhZTvGPTJ8QDvyy3FgNtPRVqwbfYLfpIO/PB37Cze84FY1+q
	 hwgwjcL0xqOi5DLyu3bnaIawUqTmyPPk5HoAnAmrQXG6oCnW+jMpaQlwMT8gwxNmDf
	 drGu1UrLEDM3EpGXcxz09kOZ8Wtw5VI/u9FA52vL5raKbEFoTpU5nXZK8jkvobvpZT
	 uqQlclC7qiQSQmu+XCEhh47nJ+2VytIv2eFzgJGFctTCenModXqB9nbj3tPmkETPWZ
	 OadcnykTwlzVg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Katherine Leaver <kleaver@janestreet.com>
Subject: [PATCH net] ipmr, ip6mr: queue netlink route queries out of band
Date: Fri, 30 Oct 2026 10:23:03 +0100
Message-ID: <20261030092303.2749386-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipmr_get_route() and ip6mr_get_route() queue synthetic skbs on the
unresolved MFC entry to answer RTM_GETROUTE requests once the route
is resolved. These skbs carry a fake IP header with version 0, and
ipmr_cache_resolve(), ipmr_destroy_unres(), ip6mr_cache_resolve()
and ip6mr_destroy_unres() rely on this in-band tag to tell them
apart from regular packets queued by the input and output paths.

The IP version is only validated once, in ip_rcv_core() and
ip6_rcv_core(). A netfilter hook running later, for instance an
nftables payload statement in a PREROUTING chain owned by an
unprivileged user namespace, can rewrite the first header byte to
zero. The SRv6 End.DX6 action also passes the decapsulated packet
to ip6_mr_input() without checking that the inner header version
is 6. If no MFC entry exists, the packet is queued and later handled
as a netlink request: its payload is treated as an nlmsghdr and
written to, mr_fill_mroute() may call skb_put() on a nonlinear skb
(hitting SKB_LINEAR_ASSERT()), and the skb is unicast to a netlink
portid taken from stale IPCB/IP6CB bytes in skb->cb[].

ipmr_cache_report() also relies on the same tag since
commit 94a6736bb5ab ("ipmr: only copy pktinfo to cache reports").

Stop trusting packet contents: queue route queries on a dedicated
nl_queries list in the unresolved MFC entry, and pass an explicit
nl_query flag from the callers.

The per-entry limit of four queued skbs now applies to both lists
combined, as before. The synthetic header keeps version 0, since it
is copied into the NOCACHE report delivered to the mroute socket.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
Reported-by: Katherine Leaver <kleaver@janestreet.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/mroute_base.h |   2 +
 net/ipv4/ipmr.c             | 104 +++++++++++++++++++-----------------
 net/ipv6/ip6mr.c            |  76 +++++++++++++-------------
 3 files changed, 94 insertions(+), 88 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 4d55827e970537aff6938503a39ee3306c8fde6d..2d506966357b2591af4eadef88b27e236a2fe9cf 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -119,6 +119,7 @@ enum {
  * @mfc_flags: entry flags
  * @expires: unresolved entry expire time
  * @unresolved: unresolved cached skbs
+ * @nl_queries: queued RTM_GETROUTE requests waiting for resolution
  * @last_assert: time of last assert
  * @minvif: minimum VIF id
  * @maxvif: maximum VIF id
@@ -141,6 +142,7 @@ struct mr_mfc {
 		struct {
 			unsigned long expires;
 			struct sk_buff_head unresolved;
+			struct sk_buff_head nl_queries;
 		} unres;
 		struct {
 			unsigned long last_assert;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index e8f7d3b573d0f4f74ebabc3425993b8d39fdfd25..836f3f95b20c45f70f659379656761a18d220b93 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -109,7 +109,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			  struct net_device *dev, struct sk_buff *skb,
 			  struct mfc_cache *cache, int local);
 static int ipmr_cache_report(const struct mr_table *mrt,
-			     struct sk_buff *pkt, vifi_t vifi, int assert);
+			     struct sk_buff *pkt, vifi_t vifi, int assert,
+			     bool nl_query);
 static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
 				 int cmd);
 static void igmpmsg_netlink_event(const struct mr_table *mrt, struct sk_buff *pkt);
@@ -563,7 +564,7 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
 	ipmr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
-			  IGMPMSG_WHOLEPKT);
+			  IGMPMSG_WHOLEPKT, false);
 
 	rcu_read_unlock();
 	kfree_skb(skb);
@@ -781,23 +782,21 @@ static void ipmr_destroy_unres(struct mr_table *mrt, struct mfc_cache *c)
 	WRITE_ONCE(mrt->cache_resolve_queue_len,
 		   mrt->cache_resolve_queue_len - 1);
 
-	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved))) {
-		if (ip_hdr(skb)->version == 0) {
-			struct nlmsghdr *nlh = skb_pull(skb,
-							sizeof(struct iphdr));
-			nlh->nlmsg_type = NLMSG_ERROR;
-			nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
-			skb_trim(skb, nlh->nlmsg_len);
-			e = nlmsg_data(nlh);
-			e->error = -ETIMEDOUT;
-			memset(&e->msg, 0, sizeof(e->msg));
+	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.nl_queries))) {
+		struct nlmsghdr *nlh = skb_pull(skb, sizeof(struct iphdr));
 
-			rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
-		} else {
-			kfree_skb(skb);
-		}
+		nlh->nlmsg_type = NLMSG_ERROR;
+		nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
+		skb_trim(skb, nlh->nlmsg_len);
+		e = nlmsg_data(nlh);
+		e->error = -ETIMEDOUT;
+		memset(&e->msg, 0, sizeof(e->msg));
+
+		rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
 	}
 
+	skb_queue_purge(&c->_c.mfc_un.unres.unresolved);
+
 	ipmr_cache_free(c);
 }
 
@@ -1027,6 +1026,7 @@ static struct mfc_cache *ipmr_cache_alloc_unres(void)
 
 	if (c) {
 		skb_queue_head_init(&c->_c.mfc_un.unres.unresolved);
+		skb_queue_head_init(&c->_c.mfc_un.unres.nl_queries);
 		c->_c.mfc_un.unres.expires = jiffies + 10 * HZ;
 	}
 	return c;
@@ -1039,31 +1039,29 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 	struct sk_buff *skb;
 	struct nlmsgerr *e;
 
-	/* Play the pending entries through our router */
-	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
-		if (ip_hdr(skb)->version == 0) {
-			struct nlmsghdr *nlh = skb_pull(skb,
-							sizeof(struct iphdr));
-
-			if (mr_fill_mroute(mrt, skb, &c->_c,
-					   nlmsg_data(nlh)) > 0) {
-				nlh->nlmsg_len = skb_tail_pointer(skb) -
-						 (u8 *)nlh;
-			} else {
-				nlh->nlmsg_type = NLMSG_ERROR;
-				nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
-				skb_trim(skb, nlh->nlmsg_len);
-				e = nlmsg_data(nlh);
-				e->error = -EMSGSIZE;
-				memset(&e->msg, 0, sizeof(e->msg));
-			}
+	/* Answer the pending netlink route queries */
+	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.nl_queries))) {
+		struct nlmsghdr *nlh = skb_pull(skb, sizeof(struct iphdr));
 
-			rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
+		if (mr_fill_mroute(mrt, skb, &c->_c, nlmsg_data(nlh)) > 0) {
+			nlh->nlmsg_len = skb_tail_pointer(skb) - (u8 *)nlh;
 		} else {
-			rcu_read_lock();
-			ip_mr_forward(net, mrt, skb->dev, skb, c, 0);
-			rcu_read_unlock();
+			nlh->nlmsg_type = NLMSG_ERROR;
+			nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
+			skb_trim(skb, nlh->nlmsg_len);
+			e = nlmsg_data(nlh);
+			e->error = -EMSGSIZE;
+			memset(&e->msg, 0, sizeof(e->msg));
 		}
+
+		rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
+	}
+
+	/* Play the pending packets through our router */
+	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
+		rcu_read_lock();
+		ip_mr_forward(net, mrt, skb->dev, skb, c, 0);
+		rcu_read_unlock();
 	}
 }
 
@@ -1072,7 +1070,8 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
  * Called under rcu_read_lock().
  */
 static int ipmr_cache_report(const struct mr_table *mrt,
-			     struct sk_buff *pkt, vifi_t vifi, int assert)
+			     struct sk_buff *pkt, vifi_t vifi, int assert,
+			     bool nl_query)
 {
 	unsigned char pkt_cb[sizeof(pkt->cb)];
 	const int ihl = ip_hdrlen(pkt);
@@ -1142,7 +1141,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 
 	memset(skb->cb, 0, sizeof(skb->cb));
 	/* Route queries from ipmr_get_route() carry NETLINK_CB, not IPCB. */
-	if (ip_hdr(pkt)->version) {
+	if (!nl_query) {
 		memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
 		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
 		*PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
@@ -1165,7 +1164,8 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 /* Queue a packet for resolution. It gets locked cache entry! */
 /* Called under rcu_read_lock() */
 static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
-				 struct sk_buff *skb, struct net_device *dev)
+				 struct sk_buff *skb, struct net_device *dev,
+				 bool nl_query)
 {
 	struct net *net = read_pnet(&mrt->net);
 	const struct iphdr *iph = ip_hdr(skb);
@@ -1202,7 +1202,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 		c->mfc_mcastgrp	= iph->daddr;
 
 		/* Reflect first query at mrouted. */
-		err = ipmr_cache_report(mrt, skb, vifi, IGMPMSG_NOCACHE);
+		err = ipmr_cache_report(mrt, skb, vifi, IGMPMSG_NOCACHE,
+					nl_query);
 		if (err < 0)
 			goto err;
 
@@ -1217,7 +1218,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 	}
 
 	/* See if we can append the packet */
-	if (c->_c.mfc_un.unres.unresolved.qlen > 3) {
+	if (skb_queue_len(&c->_c.mfc_un.unres.unresolved) +
+	    skb_queue_len(&c->_c.mfc_un.unres.nl_queries) > 3) {
 		c = NULL;
 		err = -ENOBUFS;
 		goto err;
@@ -1228,7 +1230,8 @@ static int ipmr_cache_unresolved(struct mr_table *mrt, vifi_t vifi,
 		skb->skb_iif = dev->ifindex;
 	}
 
-	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
+	skb_queue_tail(nl_query ? &c->_c.mfc_un.unres.nl_queries :
+				  &c->_c.mfc_un.unres.unresolved, skb);
 
 	spin_unlock_bh(&mfc_unres_lock);
 	return 0;
@@ -1943,7 +1946,7 @@ static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
 		WRITE_ONCE(vif->bytes_out, vif->bytes_out + skb->len);
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 		DEV_STATS_INC(vif_dev, tx_packets);
-		ipmr_cache_report(mrt, skb, vifi, IGMPMSG_WHOLEPKT);
+		ipmr_cache_report(mrt, skb, vifi, IGMPMSG_WHOLEPKT, false);
 		return -1;
 	}
 
@@ -2120,10 +2123,11 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			       c->_c.mfc_un.res.last_assert +
 			       MFC_ASSERT_THRESH)) {
 			c->_c.mfc_un.res.last_assert = jiffies;
-			ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WRONGVIF);
+			ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WRONGVIF,
+					  false);
 			if (READ_ONCE(mrt->mroute_do_wrvifwhole))
 				ipmr_cache_report(mrt, skb, true_vifi,
-						  IGMPMSG_WRVIFWHOLE);
+						  IGMPMSG_WRVIFWHOLE, false);
 		}
 		goto dont_forward;
 	}
@@ -2293,7 +2297,7 @@ int ip_mr_input(struct sk_buff *skb)
 
 		vif = ipmr_find_vif(mrt, dev);
 		if (vif >= 0)
-			return ipmr_cache_unresolved(mrt, vif, skb, dev);
+			return ipmr_cache_unresolved(mrt, vif, skb, dev, false);
 		kfree_skb(skb);
 		return -ENODEV;
 	}
@@ -2401,7 +2405,7 @@ int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (!cache) {
 		vif = ipmr_find_vif(mrt, dev);
 		if (vif >= 0)
-			return ipmr_cache_unresolved(mrt, vif, skb, dev);
+			return ipmr_cache_unresolved(mrt, vif, skb, dev, false);
 		goto mc_output;
 	}
 
@@ -2523,7 +2527,7 @@ int ipmr_get_route(struct net *net, struct sk_buff *skb,
 		iph->saddr = saddr;
 		iph->daddr = daddr;
 		iph->version = 0;
-		err = ipmr_cache_unresolved(mrt, vif, skb2, dev);
+		err = ipmr_cache_unresolved(mrt, vif, skb2, dev, true);
 		rcu_read_unlock();
 		return err;
 	}
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index af968a2c2a7847c96d50774729d8aee23df5294a..9710e8958b3892403e3cac1102554eea4d0a58fe 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -827,19 +827,18 @@ static void ip6mr_destroy_unres(struct mr_table *mrt, struct mfc6_cache *c)
 	WRITE_ONCE(mrt->cache_resolve_queue_len,
 		   mrt->cache_resolve_queue_len - 1);
 
-	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.unresolved)) != NULL) {
-		if (ipv6_hdr(skb)->version == 0) {
-			struct nlmsghdr *nlh = skb_pull(skb,
-							sizeof(struct ipv6hdr));
-			nlh->nlmsg_type = NLMSG_ERROR;
-			nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
-			skb_trim(skb, nlh->nlmsg_len);
-			((struct nlmsgerr *)nlmsg_data(nlh))->error = -ETIMEDOUT;
-			rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
-		} else
-			kfree_skb(skb);
+	while ((skb = skb_dequeue(&c->_c.mfc_un.unres.nl_queries))) {
+		struct nlmsghdr *nlh = skb_pull(skb, sizeof(struct ipv6hdr));
+
+		nlh->nlmsg_type = NLMSG_ERROR;
+		nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
+		skb_trim(skb, nlh->nlmsg_len);
+		((struct nlmsgerr *)nlmsg_data(nlh))->error = -ETIMEDOUT;
+		rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
 	}
 
+	skb_queue_purge(&c->_c.mfc_un.unres.unresolved);
+
 	ip6mr_cache_free(c);
 }
 
@@ -1047,6 +1046,7 @@ static struct mfc6_cache *ip6mr_cache_alloc_unres(void)
 	if (!c)
 		return NULL;
 	skb_queue_head_init(&c->_c.mfc_un.unres.unresolved);
+	skb_queue_head_init(&c->_c.mfc_un.unres.nl_queries);
 	c->_c.mfc_un.unres.expires = jiffies + 10 * HZ;
 	return c;
 }
@@ -1060,30 +1060,26 @@ static void ip6mr_cache_resolve(struct net *net, struct mr_table *mrt,
 {
 	struct sk_buff *skb;
 
-	/*
-	 *	Play the pending entries through our router
-	 */
+	/* Answer the pending netlink route queries */
+	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.nl_queries))) {
+		struct nlmsghdr *nlh = skb_pull(skb, sizeof(struct ipv6hdr));
 
-	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
-		if (ipv6_hdr(skb)->version == 0) {
-			struct nlmsghdr *nlh = skb_pull(skb,
-							sizeof(struct ipv6hdr));
-
-			if (mr_fill_mroute(mrt, skb, &c->_c,
-					   nlmsg_data(nlh)) > 0) {
-				nlh->nlmsg_len = skb_tail_pointer(skb) - (u8 *)nlh;
-			} else {
-				nlh->nlmsg_type = NLMSG_ERROR;
-				nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
-				skb_trim(skb, nlh->nlmsg_len);
-				((struct nlmsgerr *)nlmsg_data(nlh))->error = -EMSGSIZE;
-			}
-			rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
+		if (mr_fill_mroute(mrt, skb, &c->_c, nlmsg_data(nlh)) > 0) {
+			nlh->nlmsg_len = skb_tail_pointer(skb) - (u8 *)nlh;
 		} else {
-			rcu_read_lock();
-			ip6_mr_forward(net, mrt, skb->dev, skb, c);
-			rcu_read_unlock();
+			nlh->nlmsg_type = NLMSG_ERROR;
+			nlh->nlmsg_len = nlmsg_msg_size(sizeof(struct nlmsgerr));
+			skb_trim(skb, nlh->nlmsg_len);
+			((struct nlmsgerr *)nlmsg_data(nlh))->error = -EMSGSIZE;
 		}
+		rtnl_unicast(skb, net, NETLINK_CB(skb).portid);
+	}
+
+	/* Play the pending packets through our router */
+	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
+		rcu_read_lock();
+		ip6_mr_forward(net, mrt, skb->dev, skb, c);
+		rcu_read_unlock();
 	}
 }
 
@@ -1188,7 +1184,8 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 
 /* Queue a packet for resolution. It gets locked cache entry! */
 static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
-				  struct sk_buff *skb, struct net_device *dev)
+				  struct sk_buff *skb, struct net_device *dev,
+				  bool nl_query)
 {
 	struct net *net = read_pnet(&mrt->net);
 	struct mfc6_cache *c = NULL;
@@ -1242,7 +1239,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 	}
 
 	/* See if we can append the packet */
-	if (c->_c.mfc_un.unres.unresolved.qlen > 3) {
+	if (skb_queue_len(&c->_c.mfc_un.unres.unresolved) +
+	    skb_queue_len(&c->_c.mfc_un.unres.nl_queries) > 3) {
 		c = NULL;
 		err = -ENOBUFS;
 		goto err;
@@ -1254,7 +1252,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 	}
 
 	skb_dst_drop(skb);
-	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
+	skb_queue_tail(nl_query ? &c->_c.mfc_un.unres.nl_queries :
+				  &c->_c.mfc_un.unres.unresolved, skb);
 
 	spin_unlock_bh(&mfc_unres_lock);
 	return 0;
@@ -2399,7 +2398,8 @@ int ip6_mr_input(struct sk_buff *skb)
 
 		vif = ip6mr_find_vif(mrt, dev);
 		if (vif >= 0) {
-			int err = ip6mr_cache_unresolved(mrt, vif, skb, dev);
+			int err = ip6mr_cache_unresolved(mrt, vif, skb, dev,
+							 false);
 
 			return err;
 		}
@@ -2451,7 +2451,7 @@ int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (!cache) {
 		vif = ip6mr_find_vif(mrt, dev);
 		if (vif >= 0)
-			return ip6mr_cache_unresolved(mrt, vif, skb, dev);
+			return ip6mr_cache_unresolved(mrt, vif, skb, dev, false);
 		goto ip6_output;
 	}
 
@@ -2528,7 +2528,7 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 		iph->saddr = rt->rt6i_src.addr;
 		iph->daddr = rt->rt6i_dst.addr;
 
-		err = ip6mr_cache_unresolved(mrt, vif, skb2, dev);
+		err = ip6mr_cache_unresolved(mrt, vif, skb2, dev, true);
 		rcu_read_unlock();
 
 		return err;
-- 
2.53.0

