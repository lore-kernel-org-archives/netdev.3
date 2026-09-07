Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D4427F8A
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767946; cv=none; b=ps1H8w++FA6Ck5iu09R6W3bGaz1gu41CTig+Hn/HP7Wf2xoiLM+ZE0QGZqfpAdc0cC+3tB1y0RGEpuBaU9uWKsIucmJbzW43JXw1gCbC7tdmNfhy8mCZWInVcYXwYJbP48MJdYNejJrJ1zP3ZCnrMXAorUn8EMChsOAJctqVkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767946; c=relaxed/simple;
	bh=6uddK2KAukYVwaXKiMs5G1+B8HsLN6hk2ZUy6EgM3m4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EFSzoGMpYjrv10Jck6U36Ub1/U0CncpjH/ci39hY8pcp5eBnO8kNaQVaAUBbRSRP1Bw57tasgybGT0uv/uUf60hrLSlY/Srja9wYGH3Su8qJUcsJldqxaitM5/J0hCm4+4tE+PTe7vgKOjnWVZEMpjW0rqhyA7a/rBGhCKzFVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtGQeaTG; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtGQeaTG"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52f52ccd459so44189691cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767939; x=1789372739; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6gsMZxaM8VuVEF4JUTzY4IhePbzd3WVZfMFScmphB0=;
        b=PtGQeaTGE2zzC9HqoFENrJuXKbEsgccWQ3IPaIQqMEhyG0sNxwmVu4adxU3HrrihBO
         EWzqxQmC1kjCG9pKbjPfpLZv0I+idsy83IEjNdBCflcuuRmKNI+FZgpZLqkf1l1q7rIa
         iQAZS6gGHEFCrHfKhAu5RTK6i6XgC28sAqGn9eSmfq8o8/mBh07IodeDQfOhNKVeqZMs
         N0eXCMh7YWfiK0Uklz1/sQhELtqI2GPsepYG2HEBiqfUp1LuYk7PRRP2qzho4stLJyeA
         oleRQ0LOP8lDB3jaJsk6Dot+ivnQQySgD1bhjGQ0LTGdXPLZmfZXhwa6Pglmq400r8XM
         67zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767939; x=1789372739;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6gsMZxaM8VuVEF4JUTzY4IhePbzd3WVZfMFScmphB0=;
        b=YOecj4lL2Bcfg4ogbcMMvJ5Vmt+WSPg/wt4v6JJOljIIpOR/En4tnVh9JHJrVIavQ6
         S4moFobGkr3THq8RgQeoo1JXbw8y3dpKJiTPR+WcYzAPhas2zQ5BrwRm7KcId0++SFkA
         Zk4g1XE8XQuth7G8/dfQy2K/dCJNxvLNqDgrMMJZLvucry3GssXJ8VbkP+ISmZTWgWP4
         edyhYCDMV5UDsfCbyMXMLN9PisSC04oKAoMXv2NgJmbxtty5JApD5U2b/l0bRI/1KZtj
         mGaEUTdfk4sAjqYqfEBZLwje/0aIK2Z66ue5zPrl15OJNDnzG2iQFfTbzSjdbqpFsw88
         cnSw==
X-Forwarded-Encrypted: i=1; AKwUvBx5niwncmJjZ4ZzehcY/YtiPndVlSX2CpusFjkxtaMU1lNhdA7R2XlsosJl0IAAptT4v1H8SKg=@vger.kernel.org
X-Gm-Message-State: AFuF++lBSgLVEmKxNTi8hE9LIHEmQJaOw15W2lURSD5aIZln78x5Bm+S
	w4rCIE6tD1drr91khj/Ce3gET2PeBtRjI1hfw5UcHw/29G1YqwWeLc2JAnlj14V5vVceSibRzES
	tG6kqmMYpe1d0cw==
X-Received: from qvbda18.prod.google.com ([2002:a05:6214:8d2:b0:905:c82b:c979])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2b49:b0:530:42e4:1b66 with SMTP id d75a77b69052e-53054a1588bmr246411471cf.42.1788767939188;
 Mon, 07 Sep 2026 00:58:59 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:45 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-9-edumazet@google.com>
Subject: [PATCH net-next 8/9] sit: convert configuration to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that SIT parameters are dynamically allocated, convert
tunnel->sit_parms to an RCU-protected pointer.

Updates in ipip6_tunnel_update() allocate a new parameter block,
publish it using rcu_assign_pointer(), and free the old one
via kfree_rcu().

We only need to unlink and re-link the tunnel in the hash table
if either saddr or daddr changed. When neither address changes,
the unhash/re-hash and synchronize_net() can be completely skipped.

Readers in ipip6_tunnel_lookup(), ipip6_tunnel_xmit(), ipip6_err(),
and ipip6_rcv() now safely dereference tunnel->sit_parms under RCU.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |   3 +-
 net/ipv6/sit.c           | 245 +++++++++++++++++++++++++--------------
 2 files changed, 157 insertions(+), 91 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f464c4480edaf35f9ace1c5081c564ce51fed636..be4cc10f88ed64114cebac7f2e01bea21f5419da 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -149,6 +149,7 @@ struct ip_tunnel_parm_kern {
 	__be32			o_key;
 	int			link;
 	struct iphdr		iph;
+	struct rcu_head		rcu;
 };
 
 struct ip_tunnel {
@@ -190,7 +191,7 @@ struct ip_tunnel {
 #endif
 	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
 	unsigned int		prl_count;	/* # of entries in PRL */
-	struct ip_tunnel_parm_kern *sit_parms;
+	struct ip_tunnel_parm_kern __rcu *sit_parms;
 	unsigned int		ip_tnl_net_id;
 	struct gro_cells	gro_cells;
 	__u32			fwmark;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index dc37c7109af5324f2ced0301b289e7622dd1a55f..c9049ab87e010eed5f53a342460ed10006083cd7 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -108,24 +108,33 @@ static struct ip_tunnel *ipip6_tunnel_lookup(struct net *net,
 	int ifindex = dev ? dev->ifindex : 0;
 
 	for_each_ip_tunnel_rcu(t, sitn->tunnels_r_l[h0 ^ h1]) {
-		if (local == t->sit_parms->iph.saddr &&
-		    remote == t->sit_parms->iph.daddr &&
-		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
-		     sifindex == t->sit_parms->link) &&
+		const struct ip_tunnel_parm_kern *parms;
+
+		parms = rcu_dereference(t->sit_parms);
+		if (local == parms->iph.saddr &&
+		    remote == parms->iph.daddr &&
+		    (!dev || !parms->link || ifindex == parms->link ||
+		     sifindex == parms->link) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
 	for_each_ip_tunnel_rcu(t, sitn->tunnels_r[h0]) {
-		if (remote == t->sit_parms->iph.daddr &&
-		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
-		     sifindex == t->sit_parms->link) &&
+		const struct ip_tunnel_parm_kern *parms;
+
+		parms = rcu_dereference(t->sit_parms);
+		if (remote == parms->iph.daddr &&
+		    (!dev || !parms->link || ifindex == parms->link ||
+		     sifindex == parms->link) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
 	for_each_ip_tunnel_rcu(t, sitn->tunnels_l[h1]) {
-		if (local == t->sit_parms->iph.saddr &&
-		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
-		     sifindex == t->sit_parms->link) &&
+		const struct ip_tunnel_parm_kern *parms;
+
+		parms = rcu_dereference(t->sit_parms);
+		if (local == parms->iph.saddr &&
+		    (!dev || !parms->link || ifindex == parms->link ||
+		     sifindex == parms->link) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
@@ -157,7 +166,7 @@ __ipip6_bucket(struct sit_net *sitn, struct ip_tunnel_parm_kern *parms)
 static inline struct ip_tunnel __rcu **ipip6_bucket(struct sit_net *sitn,
 		struct ip_tunnel *t)
 {
-	return __ipip6_bucket(sitn, t->sit_parms);
+	return __ipip6_bucket(sitn, rtnl_dereference(t->sit_parms));
 }
 
 static void ipip6_tunnel_unlink(struct sit_net *sitn, struct ip_tunnel *t)
@@ -230,17 +239,19 @@ static int ipip6_tunnel_create(struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct sit_net *sitn = net_generic(t->net, sit_net_id);
+	struct ip_tunnel_parm_kern *parms;
 	int err;
 
 	err = ipip6_tunnel_clone_6rd(dev, sitn);
 	if (err < 0)
 		goto out;
 
-	t->parms = *t->sit_parms;
-	__dev_addr_set(dev, &t->sit_parms->iph.saddr, 4);
-	memcpy(dev->broadcast, &t->sit_parms->iph.daddr, 4);
+	parms = rtnl_dereference(t->sit_parms);
+	t->parms = *parms;
+	__dev_addr_set(dev, &parms->iph.saddr, 4);
+	memcpy(dev->broadcast, &parms->iph.daddr, 4);
 
-	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, t->sit_parms->i_flags))
+	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, parms->i_flags))
 		dev->priv_flags |= IFF_ISATAP;
 
 	dev->rtnl_link_ops = &sit_link_ops;
@@ -264,6 +275,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	__be32 local = parms->iph.saddr;
 	struct ip_tunnel *t, *nt;
 	struct ip_tunnel __rcu **tp;
+	struct ip_tunnel_parm_kern *nt_parms;
 	struct net_device *dev;
 	char name[IFNAMSIZ];
 	struct sit_net *sitn = net_generic(net, sit_net_id);
@@ -271,9 +283,12 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	for (tp = __ipip6_bucket(sitn, parms);
 	    (t = rtnl_dereference(*tp)) != NULL;
 	     tp = &t->next) {
-		if (local == t->sit_parms->iph.saddr &&
-		    remote == t->sit_parms->iph.daddr &&
-		    parms->link == t->sit_parms->link) {
+		const struct ip_tunnel_parm_kern *tparms;
+
+		tparms = rtnl_dereference(t->sit_parms);
+		if (local == tparms->iph.saddr &&
+		    remote == tparms->iph.daddr &&
+		    parms->link == tparms->link) {
 			if (create)
 				return NULL;
 			else
@@ -300,10 +315,11 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->net = net;
-	nt->sit_parms = kmalloc_obj(*nt->sit_parms);
-	if (!nt->sit_parms)
+	nt_parms = kmalloc_obj(*nt_parms);
+	if (!nt_parms)
 		goto failed_free;
-	*nt->sit_parms = *parms;
+	*nt_parms = *parms;
+	rcu_assign_pointer(nt->sit_parms, nt_parms);
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
 
@@ -599,41 +615,45 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
 	err = -ENOENT;
 
 	sifindex = netif_is_l3_master(skb->dev) ? IPCB(skb)->iif : 0;
+	rcu_read_lock();
 	t = ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
 				iph->daddr, iph->saddr, sifindex);
-	if (!t)
-		goto out;
+	if (t) {
+		const struct ip_tunnel_parm_kern *parms;
 
-	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
-		ipv4_update_pmtu(skb, dev_net(skb->dev), info,
-				 t->sit_parms->link, iph->protocol);
-		err = 0;
-		goto out;
-	}
-	if (type == ICMP_REDIRECT) {
-		ipv4_redirect(skb, dev_net(skb->dev), t->sit_parms->link,
-			      iph->protocol);
-		err = 0;
-		goto out;
-	}
+		parms = rcu_dereference(t->sit_parms);
+		if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
+			ipv4_update_pmtu(skb, dev_net(skb->dev), info,
+					 parms->link, iph->protocol);
+			err = 0;
+			goto out;
+		}
+		if (type == ICMP_REDIRECT) {
+			ipv4_redirect(skb, dev_net(skb->dev), parms->link,
+				      iph->protocol);
+			err = 0;
+			goto out;
+		}
 
-	err = 0;
-	if (__in6_dev_get(skb->dev) &&
-	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
-		goto out;
+		err = 0;
+		if (__in6_dev_get(skb->dev) &&
+		    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
+			goto out;
 
-	if (t->sit_parms->iph.daddr == 0)
-		goto out;
+		if (parms->iph.daddr == 0)
+			goto out;
 
-	if (t->sit_parms->iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
-		goto out;
+		if (parms->iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
+			goto out;
 
-	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
-		WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
-	else
-		WRITE_ONCE(t->err_count, 1);
-	WRITE_ONCE(t->err_time, jiffies);
+		if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
+			WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
+		else
+			WRITE_ONCE(t->err_count, 1);
+		WRITE_ONCE(t->err_time, jiffies);
+	}
 out:
+	rcu_read_unlock();
 	return err;
 }
 
@@ -726,8 +746,11 @@ static int ipip6_rcv(struct sk_buff *skb)
 	tunnel = ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
 				     iph->saddr, iph->daddr, sifindex);
 	if (tunnel) {
-		if (tunnel->sit_parms->iph.protocol != IPPROTO_IPV6 &&
-		    tunnel->sit_parms->iph.protocol != 0)
+		const struct ip_tunnel_parm_kern *parms;
+
+		parms = rcu_dereference(tunnel->sit_parms);
+		if (parms->iph.protocol != IPPROTO_IPV6 &&
+		    parms->iph.protocol != 0)
 			goto out;
 
 		skb->mac_header = skb->network_header;
@@ -800,10 +823,12 @@ static int sit_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 	tunnel = ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
 				     iph->saddr, iph->daddr, sifindex);
 	if (tunnel) {
+		const struct ip_tunnel_parm_kern *parms;
 		const struct tnl_ptk_info *tpi;
 
-		if (tunnel->sit_parms->iph.protocol != ipproto &&
-		    tunnel->sit_parms->iph.protocol != 0)
+		parms = rcu_dereference(tunnel->sit_parms);
+		if (parms->iph.protocol != ipproto &&
+		    parms->iph.protocol != 0)
 			goto drop;
 
 		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
@@ -942,20 +967,27 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
+	const struct ip_tunnel_parm_kern *parms;
+	const struct iphdr  *tiph;
 	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
-	u8     tos = tunnel->sit_parms->iph.tos;
-	__be16 df = tiph->frag_off;
+	u8     tos;
+	__be16 df;
 	struct rtable *rt;		/* Route to the other host */
 	struct net_device *tdev;	/* Device to other host */
 	unsigned int max_headroom;	/* The extra header space needed */
-	__be32 dst = tiph->daddr;
+	__be32 dst;
 	int err_count, mtu;
 	struct flowi4 fl4;
 	u8 ttl;
 	u8 protocol = IPPROTO_IPV6;
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
+	parms = rcu_dereference(tunnel->sit_parms);
+	tiph = &parms->iph;
+	tos = parms->iph.tos;
+	df = tiph->frag_off;
+	dst = tiph->daddr;
+
 	if (tos == 1)
 		tos = ipv6_get_dsfield(iph6);
 
@@ -970,7 +1002,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
 		goto tx_error;
 
-	flowi4_init_output(&fl4, tunnel->sit_parms->link, READ_ONCE(tunnel->fwmark),
+	flowi4_init_output(&fl4, parms->link, READ_ONCE(tunnel->fwmark),
 			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
 			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
@@ -1018,7 +1050,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 			df = 0;
 		}
 
-		if (tunnel->sit_parms->iph.daddr)
+		if (parms->iph.daddr)
 			skb_dst_update_pmtu_no_confirm(skb, mtu);
 
 		if (skb->len > mtu && !skb_is_gso(skb)) {
@@ -1087,13 +1119,17 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff *skb,
 				     struct net_device *dev, u8 ipproto)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
+	const struct ip_tunnel_parm_kern *parms;
+	const struct iphdr  *tiph;
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
 		goto tx_error;
 
 	skb_set_inner_ipproto(skb, ipproto);
 
+	parms = rcu_dereference(tunnel->sit_parms);
+	tiph = &parms->iph;
+
 	ip_tunnel_xmit(skb, dev, tiph, ipproto);
 	return NETDEV_TX_OK;
 tx_error:
@@ -1108,6 +1144,7 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 	if (!pskb_inet_may_pull(skb))
 		goto tx_err;
 
+	rcu_read_lock();
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		sit_tunnel_xmit__(skb, dev, IPPROTO_IPIP);
@@ -1121,8 +1158,10 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 		break;
 #endif
 	default:
+		rcu_read_unlock();
 		goto tx_err;
 	}
+	rcu_read_unlock();
 
 	return NETDEV_TX_OK;
 
@@ -1130,19 +1169,20 @@ static netdev_tx_t sit_tunnel_xmit(struct sk_buff *skb,
 	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
-
 }
 
 static void ipip6_tunnel_bind_dev(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
+	const struct ip_tunnel_parm_kern *parms;
 	struct net_device *tdev = NULL;
 	int hlen = LL_MAX_HEADER;
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	iph = &tunnel->sit_parms->iph;
+	parms = rtnl_dereference(tunnel->sit_parms);
+	iph = &parms->iph;
 
 	if (iph->daddr) {
 		struct rtable *rt = ip_route_output_ports(tunnel->net, &fl4,
@@ -1151,7 +1191,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 							  0, 0,
 							  IPPROTO_IPV6,
 							  iph->tos & INET_DSCP_MASK,
-							  tunnel->sit_parms->link);
+							  parms->link);
 
 		if (!IS_ERR(rt)) {
 			tdev = rt->dst.dev;
@@ -1160,8 +1200,8 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		dev->flags |= IFF_POINTOPOINT;
 	}
 
-	if (!tdev && tunnel->sit_parms->link)
-		tdev = __dev_get_by_index(tunnel->net, tunnel->sit_parms->link);
+	if (!tdev && parms->link)
+		tdev = __dev_get_by_index(tunnel->net, parms->link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
 		int mtu;
@@ -1182,8 +1222,9 @@ static int ipip6_tunnel_update(struct ip_tunnel *t,
 	struct net *net = t->net;
 	struct sit_net *sitn = net_generic(net, sit_net_id);
 	struct ip_tunnel_parm_kern *new_p, *old_p;
+	bool move;
 
-	old_p = t->sit_parms;
+	old_p = rtnl_dereference(t->sit_parms);
 	new_p = kmalloc_obj(*new_p);
 	if (!new_p)
 		return -ENOMEM;
@@ -1194,21 +1235,29 @@ static int ipip6_tunnel_update(struct ip_tunnel *t,
 	new_p->iph.tos = p->iph.tos;
 	new_p->iph.frag_off = p->iph.frag_off;
 	new_p->link = p->link;
-	ipip6_tunnel_unlink(sitn, t);
-	synchronize_net();
-	t->sit_parms = new_p;
+	move = old_p->iph.saddr != p->iph.saddr ||
+	       old_p->iph.daddr != p->iph.daddr;
+
+	if (move)
+		ipip6_tunnel_unlink(sitn, t);
+
 	t->parms.iph = new_p->iph;
 	WRITE_ONCE(t->parms.link, new_p->link);
-	__dev_addr_set(t->dev, &p->iph.saddr, 4);
-	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
-	ipip6_tunnel_link(sitn, t);
+	rcu_assign_pointer(t->sit_parms, new_p);
+
+	if (move) {
+		synchronize_net();
+		__dev_addr_set(t->dev, &p->iph.saddr, 4);
+		memcpy(t->dev->broadcast, &p->iph.daddr, 4);
+		ipip6_tunnel_link(sitn, t);
+	}
 	if (old_p->link != p->link || t->fwmark != fwmark) {
 		WRITE_ONCE(t->fwmark, fwmark);
 		ipip6_tunnel_bind_dev(t->dev);
 	}
 	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(t->dev);
-	kfree(old_p);
+	kfree_rcu(old_p, rcu);
 	return 0;
 }
 
@@ -1336,12 +1385,14 @@ static int
 ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel_parm_kern *parms;
 
 	if (dev == dev_to_sit_net(dev)->fb_tunnel_dev)
 		t = ipip6_tunnel_locate(t->net, p, 0);
 	if (!t)
 		t = netdev_priv(dev);
-	memcpy(p, t->sit_parms, sizeof(*p));
+	parms = rtnl_dereference(t->sit_parms);
+	memcpy(p, parms, sizeof(*p));
 	return 0;
 }
 
@@ -1464,8 +1515,15 @@ ipip6_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 static int ipip6_get_iflink(const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	const struct ip_tunnel_parm_kern *parms;
+	int link;
 
-	return READ_ONCE(tunnel->sit_parms->link);
+	rcu_read_lock();
+	parms = rcu_dereference(tunnel->sit_parms);
+	link = parms ? parms->link : 0;
+	rcu_read_unlock();
+
+	return link;
 }
 
 static const struct net_device_ops ipip6_netdev_ops = {
@@ -1480,6 +1538,7 @@ static const struct net_device_ops ipip6_netdev_ops = {
 static void ipip6_dev_free(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	struct ip_tunnel_parm_kern *parms;
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel_6rd_parm *ip6rd;
 
@@ -1487,8 +1546,9 @@ static void ipip6_dev_free(struct net_device *dev)
 	RCU_INIT_POINTER(tunnel->ip6rd, NULL);
 	kfree(ip6rd);
 #endif
-	kfree(tunnel->sit_parms);
-	tunnel->sit_parms = NULL;
+	parms = rcu_dereference_protected(tunnel->sit_parms, 1);
+	RCU_INIT_POINTER(tunnel->sit_parms, NULL);
+	kfree(parms);
 	if (tunnel->dst_cache.cache) {
 		dst_cache_destroy(&tunnel->dst_cache);
 		tunnel->dst_cache.cache = NULL;
@@ -1528,10 +1588,12 @@ static void ipip6_tunnel_setup(struct net_device *dev)
 static int ipip6_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	struct ip_tunnel_parm_kern *parms;
 	int err;
 
 	tunnel->dev = dev;
-	strscpy(tunnel->sit_parms->name, dev->name);
+	parms = rtnl_dereference(tunnel->sit_parms);
+	strscpy(parms->name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
 
@@ -1549,7 +1611,6 @@ static void __net_init ipip6_fb_tunnel_init(struct net_device *dev)
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 	struct net *net = dev_net(dev);
 	struct sit_net *sitn = net_generic(net, sit_net_id);
-
 	rcu_assign_pointer(sitn->tunnels_wc[0], tunnel);
 }
 
@@ -1636,6 +1697,7 @@ static int ipip6_newlink(struct net_device *dev,
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel_6rd ip6rd;
 #endif
+	struct ip_tunnel_parm_kern *nt_parms;
 	struct ip_tunnel_parm_kern p;
 	struct net *net;
 	int err;
@@ -1655,10 +1717,11 @@ static int ipip6_newlink(struct net_device *dev,
 	if (ipip6_tunnel_locate(net, &p, 0))
 		return -EEXIST;
 
-	nt->sit_parms = kmalloc_obj(*nt->sit_parms);
-	if (!nt->sit_parms)
+	nt_parms = kmalloc_obj(*nt_parms);
+	if (!nt_parms)
 		return -ENOMEM;
-	*nt->sit_parms = p;
+	*nt_parms = p;
+	rcu_assign_pointer(nt->sit_parms, nt_parms);
 
 	err = ipip6_tunnel_create(dev);
 	if (err < 0) {
@@ -1783,7 +1846,7 @@ static size_t ipip6_get_size(const struct net_device *dev)
 static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct ip_tunnel_parm_kern *parm = tunnel->sit_parms;
+	const struct ip_tunnel_parm_kern *parm = rtnl_dereference(tunnel->sit_parms);
 #ifdef CONFIG_IPV6_SIT_6RD
 	const struct ip_tunnel_6rd_parm *ip6rd;
 #endif
@@ -1929,6 +1992,7 @@ static void __net_exit sit_exit_rtnl_net(struct net *net, struct list_head *head
 static int __net_init sit_init_net(struct net *net)
 {
 	struct sit_net *sitn = net_generic(net, sit_net_id);
+	struct ip_tunnel_parm_kern *nt_parms;
 	struct ip_tunnel *t;
 	int err;
 
@@ -1956,17 +2020,18 @@ static int __net_init sit_init_net(struct net *net)
 
 	t = netdev_priv(sitn->fb_tunnel_dev);
 	t->net = net;
-	t->sit_parms = kzalloc_obj(*t->sit_parms);
-	if (!t->sit_parms) {
+	nt_parms = kzalloc_obj(*nt_parms);
+	if (!nt_parms) {
 		err = -ENOMEM;
 		goto err_reg_dev;
 	}
-	t->sit_parms->iph.version	= 4;
-	t->sit_parms->iph.protocol	= IPPROTO_IPV6;
-	t->sit_parms->iph.ihl		= 5;
-	t->sit_parms->iph.ttl		= 64;
-	strscpy(t->sit_parms->name, sitn->fb_tunnel_dev->name);
-	t->parms = *t->sit_parms;
+	nt_parms->iph.version	= 4;
+	nt_parms->iph.protocol	= IPPROTO_IPV6;
+	nt_parms->iph.ihl	= 5;
+	nt_parms->iph.ttl	= 64;
+	strscpy(nt_parms->name, sitn->fb_tunnel_dev->name);
+	t->parms = *nt_parms;
+	rcu_assign_pointer(t->sit_parms, nt_parms);
 
 	err = ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	if (err < 0)
-- 
2.55.0.979.g7e5102b832-goog

