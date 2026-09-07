Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BEA431E76
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767944; cv=none; b=O1bPygKsanYJOU6rFMbMF/pXXDQ0Zs6JhVGjqxF5iOkvJiadFepsVgO1P6HUcKbxsznshBZLTLmKrBmlvoRyltov1lwhYTRx5dsHLKIeSJUgzIoTbKqz5OUZqyx04Hmw67v5aoDxCf49z79VNDYSc0Z4XFDU8pHDC4jAny07XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767944; c=relaxed/simple;
	bh=2L79NzTukJUgXJXZjggNz87j3UiIMsoL0x8mn0dDw/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qyNqtZ2RSpT4ZwP8X38JJ98xZAvWUHql57bOsi1hnyDAxgOS9rg4ubIkaTDZ1+552P6Vv0DNT+xTqP/fHpIbp/77YoOVDE8qWoQU/ApPK/r8GWmu3F42mpbQ63BN8TxI+Acghgvah3/B9iN4BrOC/5nEq6fvcsBZBge+Aa2kqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIMfKsJ9; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIMfKsJ9"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934956beec8so480882285a.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767938; x=1789372738; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XL02CnMEPdwncdhUGsUW/C7A7/wg7xEg3QTQZYlVwFU=;
        b=SIMfKsJ9FhZPjdcDZRc0KAnQPqLkkSu0uDuRby7lggDrvPQFdBa2bWY7Ri/msESs3z
         jbApGyd4ME7XwhFVuz8owx1p28VJzN2Rj4uWV91KE5qwwbKhNWaeC0Rx2iqGiEzVeF6i
         Q9rJ3VCSLaqG/4SB0M4ZdiGvR1fsEzb/8+BtmX+sQYokAsl0GlKnzEc2ELMv2C3CVxvv
         zidCUl5iRh3OHQeOwmqSJNOremAiqpFS06agOabI5FXfG23Mfw3Ry8sP4UgEZ3vJsHsS
         YehpMu1d6cSv7dbuMSVcXSI7eLwiSI/CB0KQPFXuiaHU2AJOVvTWWQLD7avu+9iGJczV
         WtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767938; x=1789372738;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XL02CnMEPdwncdhUGsUW/C7A7/wg7xEg3QTQZYlVwFU=;
        b=qPeavlSqBK/uLUoETXlkWNpGui+MRJTwAkkfV+VaxlluILqQMvYmfA1Jz7etPd5Y/b
         uKB6kQCKLrt1/7uomAATuESid4S3E9pIqxXcFhOEa6dZZj131jcfoncJslcoD3PJTkwu
         YSgjTq/bgoAaZDMDZv3puyinMZyV0R+Xiip2jcQQr79NUJtrE//s1Wq58KLmADg9UmR2
         +EoPUSpGjdlaAndCb7sdZHdyl7izcFu3YulUv63uD/NnYTq/ka61X3usZhW9SG7Cw9W1
         NGwqYhceL0qxnJRv+TRnWkHiC75RYvXbgmRH6sKIkgGfcU24F1ruxo2S3H/miJNT+haD
         d9uw==
X-Forwarded-Encrypted: i=1; AKwUvBwi8IFHoZFqvMP6xZS2mNKj8KmizXSfmRIa5I+DHa+BEf321uwFy3UQrGDejtPEoPbh0BFBndU=@vger.kernel.org
X-Gm-Message-State: AFuF++mkabwV13fQwl0IUBysDrKlS2jQ0U1YQpAg8q4TdR4cQqSuFa7k
	HL0FJlC4uuSsjUws5ABSM2nblwvCAa+s9f8wJkthkyASPiAhKUrAGn2cBwXyHGIDqiZWAs25X/g
	KJcdSkbyPgZpffg==
X-Received: from qknwl24.prod.google.com ([2002:a05:620a:57d8:b0:92e:5f06:dce1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4115:b0:939:9a09:6009 with SMTP id af79cd13be357-9399a0964a1mr1162270485a.33.1788767937750;
 Mon, 07 Sep 2026 00:58:57 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:44 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-8-edumazet@google.com>
Subject: [PATCH net-next 7/9] sit: dynamically allocate struct ip_tunnel_parm_kern
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for converting SIT configuration parameters to RCU,
dynamically allocate struct ip_tunnel_parm_kern as sit_parms in
struct ip_tunnel.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |   1 +
 net/ipv6/sit.c           | 152 +++++++++++++++++++++++----------------
 2 files changed, 92 insertions(+), 61 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7fff59bab53b682ac0d1efd1f47082ba7d633fd2..f464c4480edaf35f9ace1c5081c564ce51fed636 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -190,6 +190,7 @@ struct ip_tunnel {
 #endif
 	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
 	unsigned int		prl_count;	/* # of entries in PRL */
+	struct ip_tunnel_parm_kern *sit_parms;
 	unsigned int		ip_tnl_net_id;
 	struct gro_cells	gro_cells;
 	__u32			fwmark;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 35c6695909014a2c335f1de7afb48f07b7c91c39..dc37c7109af5324f2ced0301b289e7622dd1a55f 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -108,24 +108,24 @@ static struct ip_tunnel *ipip6_tunnel_lookup(struct net *net,
 	int ifindex = dev ? dev->ifindex : 0;
 
 	for_each_ip_tunnel_rcu(t, sitn->tunnels_r_l[h0 ^ h1]) {
-		if (local == t->parms.iph.saddr &&
-		    remote == t->parms.iph.daddr &&
-		    (!dev || !t->parms.link || ifindex == t->parms.link ||
-		     sifindex == t->parms.link) &&
+		if (local == t->sit_parms->iph.saddr &&
+		    remote == t->sit_parms->iph.daddr &&
+		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
+		     sifindex == t->sit_parms->link) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
 	for_each_ip_tunnel_rcu(t, sitn->tunnels_r[h0]) {
-		if (remote == t->parms.iph.daddr &&
-		    (!dev || !t->parms.link || ifindex == t->parms.link ||
-		     sifindex == t->parms.link) &&
+		if (remote == t->sit_parms->iph.daddr &&
+		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
+		     sifindex == t->sit_parms->link) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
 	for_each_ip_tunnel_rcu(t, sitn->tunnels_l[h1]) {
-		if (local == t->parms.iph.saddr &&
-		    (!dev || !t->parms.link || ifindex == t->parms.link ||
-		     sifindex == t->parms.link) &&
+		if (local == t->sit_parms->iph.saddr &&
+		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
+		     sifindex == t->sit_parms->link) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
@@ -157,7 +157,7 @@ __ipip6_bucket(struct sit_net *sitn, struct ip_tunnel_parm_kern *parms)
 static inline struct ip_tunnel __rcu **ipip6_bucket(struct sit_net *sitn,
 		struct ip_tunnel *t)
 {
-	return __ipip6_bucket(sitn, &t->parms);
+	return __ipip6_bucket(sitn, t->sit_parms);
 }
 
 static void ipip6_tunnel_unlink(struct sit_net *sitn, struct ip_tunnel *t)
@@ -236,10 +236,11 @@ static int ipip6_tunnel_create(struct net_device *dev)
 	if (err < 0)
 		goto out;
 
-	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
-	memcpy(dev->broadcast, &t->parms.iph.daddr, 4);
+	t->parms = *t->sit_parms;
+	__dev_addr_set(dev, &t->sit_parms->iph.saddr, 4);
+	memcpy(dev->broadcast, &t->sit_parms->iph.daddr, 4);
 
-	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, t->parms.i_flags))
+	if (test_bit(IP_TUNNEL_SIT_ISATAP_BIT, t->sit_parms->i_flags))
 		dev->priv_flags |= IFF_ISATAP;
 
 	dev->rtnl_link_ops = &sit_link_ops;
@@ -270,9 +271,9 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	for (tp = __ipip6_bucket(sitn, parms);
 	    (t = rtnl_dereference(*tp)) != NULL;
 	     tp = &t->next) {
-		if (local == t->parms.iph.saddr &&
-		    remote == t->parms.iph.daddr &&
-		    parms->link == t->parms.link) {
+		if (local == t->sit_parms->iph.saddr &&
+		    remote == t->sit_parms->iph.daddr &&
+		    parms->link == t->sit_parms->link) {
 			if (create)
 				return NULL;
 			else
@@ -299,7 +300,10 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->net = net;
-	nt->parms = *parms;
+	nt->sit_parms = kmalloc_obj(*nt->sit_parms);
+	if (!nt->sit_parms)
+		goto failed_free;
+	*nt->sit_parms = *parms;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
 
@@ -602,12 +606,12 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
 
 	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED) {
 		ipv4_update_pmtu(skb, dev_net(skb->dev), info,
-				 t->parms.link, iph->protocol);
+				 t->sit_parms->link, iph->protocol);
 		err = 0;
 		goto out;
 	}
 	if (type == ICMP_REDIRECT) {
-		ipv4_redirect(skb, dev_net(skb->dev), t->parms.link,
+		ipv4_redirect(skb, dev_net(skb->dev), t->sit_parms->link,
 			      iph->protocol);
 		err = 0;
 		goto out;
@@ -618,10 +622,10 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
 	    !ip6_err_gen_icmpv6_unreach(skb, iph->ihl * 4, type, data_len))
 		goto out;
 
-	if (t->parms.iph.daddr == 0)
+	if (t->sit_parms->iph.daddr == 0)
 		goto out;
 
-	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
+	if (t->sit_parms->iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
 		goto out;
 
 	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
@@ -722,8 +726,8 @@ static int ipip6_rcv(struct sk_buff *skb)
 	tunnel = ipip6_tunnel_lookup(dev_net(skb->dev), skb->dev,
 				     iph->saddr, iph->daddr, sifindex);
 	if (tunnel) {
-		if (tunnel->parms.iph.protocol != IPPROTO_IPV6 &&
-		    tunnel->parms.iph.protocol != 0)
+		if (tunnel->sit_parms->iph.protocol != IPPROTO_IPV6 &&
+		    tunnel->sit_parms->iph.protocol != 0)
 			goto out;
 
 		skb->mac_header = skb->network_header;
@@ -798,8 +802,8 @@ static int sit_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 	if (tunnel) {
 		const struct tnl_ptk_info *tpi;
 
-		if (tunnel->parms.iph.protocol != ipproto &&
-		    tunnel->parms.iph.protocol != 0)
+		if (tunnel->sit_parms->iph.protocol != ipproto &&
+		    tunnel->sit_parms->iph.protocol != 0)
 			goto drop;
 
 		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
@@ -938,9 +942,9 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	const struct iphdr  *tiph = &tunnel->parms.iph;
+	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
 	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
-	u8     tos = tunnel->parms.iph.tos;
+	u8     tos = tunnel->sit_parms->iph.tos;
 	__be16 df = tiph->frag_off;
 	struct rtable *rt;		/* Route to the other host */
 	struct net_device *tdev;	/* Device to other host */
@@ -966,7 +970,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
 		goto tx_error;
 
-	flowi4_init_output(&fl4, tunnel->parms.link, READ_ONCE(tunnel->fwmark),
+	flowi4_init_output(&fl4, tunnel->sit_parms->link, READ_ONCE(tunnel->fwmark),
 			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
 			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
@@ -1014,7 +1018,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 			df = 0;
 		}
 
-		if (tunnel->parms.iph.daddr)
+		if (tunnel->sit_parms->iph.daddr)
 			skb_dst_update_pmtu_no_confirm(skb, mtu);
 
 		if (skb->len > mtu && !skb_is_gso(skb)) {
@@ -1083,7 +1087,7 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff *skb,
 				     struct net_device *dev, u8 ipproto)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	const struct iphdr  *tiph = &tunnel->parms.iph;
+	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
 		goto tx_error;
@@ -1138,7 +1142,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 	const struct iphdr *iph;
 	struct flowi4 fl4;
 
-	iph = &tunnel->parms.iph;
+	iph = &tunnel->sit_parms->iph;
 
 	if (iph->daddr) {
 		struct rtable *rt = ip_route_output_ports(tunnel->net, &fl4,
@@ -1147,7 +1151,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 							  0, 0,
 							  IPPROTO_IPV6,
 							  iph->tos & INET_DSCP_MASK,
-							  tunnel->parms.link);
+							  tunnel->sit_parms->link);
 
 		if (!IS_ERR(rt)) {
 			tdev = rt->dst.dev;
@@ -1156,8 +1160,8 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 		dev->flags |= IFF_POINTOPOINT;
 	}
 
-	if (!tdev && tunnel->parms.link)
-		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
+	if (!tdev && tunnel->sit_parms->link)
+		tdev = __dev_get_by_index(tunnel->net, tunnel->sit_parms->link);
 
 	if (tdev && !netif_is_l3_master(tdev)) {
 		int mtu;
@@ -1171,30 +1175,41 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
 	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
 }
 
-static void ipip6_tunnel_update(struct ip_tunnel *t,
-				struct ip_tunnel_parm_kern *p,
-				__u32 fwmark)
+static int ipip6_tunnel_update(struct ip_tunnel *t,
+			       struct ip_tunnel_parm_kern *p,
+			       __u32 fwmark)
 {
 	struct net *net = t->net;
 	struct sit_net *sitn = net_generic(net, sit_net_id);
+	struct ip_tunnel_parm_kern *new_p, *old_p;
 
+	old_p = t->sit_parms;
+	new_p = kmalloc_obj(*new_p);
+	if (!new_p)
+		return -ENOMEM;
+	*new_p = *old_p;
+	new_p->iph.saddr = p->iph.saddr;
+	new_p->iph.daddr = p->iph.daddr;
+	new_p->iph.ttl = p->iph.ttl;
+	new_p->iph.tos = p->iph.tos;
+	new_p->iph.frag_off = p->iph.frag_off;
+	new_p->link = p->link;
 	ipip6_tunnel_unlink(sitn, t);
 	synchronize_net();
-	t->parms.iph.saddr = p->iph.saddr;
-	t->parms.iph.daddr = p->iph.daddr;
+	t->sit_parms = new_p;
+	t->parms.iph = new_p->iph;
+	WRITE_ONCE(t->parms.link, new_p->link);
 	__dev_addr_set(t->dev, &p->iph.saddr, 4);
 	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
 	ipip6_tunnel_link(sitn, t);
-	t->parms.iph.ttl = p->iph.ttl;
-	t->parms.iph.tos = p->iph.tos;
-	t->parms.iph.frag_off = p->iph.frag_off;
-	if (t->parms.link != p->link || t->fwmark != fwmark) {
-		t->parms.link = p->link;
+	if (old_p->link != p->link || t->fwmark != fwmark) {
 		WRITE_ONCE(t->fwmark, fwmark);
 		ipip6_tunnel_bind_dev(t->dev);
 	}
 	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(t->dev);
+	kfree(old_p);
+	return 0;
 }
 
 #ifdef CONFIG_IPV6_SIT_6RD
@@ -1326,7 +1341,7 @@ ipip6_tunnel_get(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 		t = ipip6_tunnel_locate(t->net, p, 0);
 	if (!t)
 		t = netdev_priv(dev);
-	memcpy(p, &t->parms, sizeof(*p));
+	memcpy(p, t->sit_parms, sizeof(*p));
 	return 0;
 }
 
@@ -1371,7 +1386,9 @@ ipip6_tunnel_change(struct net_device *dev, struct ip_tunnel_parm_kern *p)
 			t = netdev_priv(dev);
 		}
 
-		ipip6_tunnel_update(t, p, t->fwmark);
+		err = ipip6_tunnel_update(t, p, t->fwmark);
+		if (err)
+			return err;
 	}
 
 	return 0;
@@ -1448,7 +1465,7 @@ static int ipip6_get_iflink(const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	return READ_ONCE(tunnel->parms.link);
+	return READ_ONCE(tunnel->sit_parms->link);
 }
 
 static const struct net_device_ops ipip6_netdev_ops = {
@@ -1470,6 +1487,8 @@ static void ipip6_dev_free(struct net_device *dev)
 	RCU_INIT_POINTER(tunnel->ip6rd, NULL);
 	kfree(ip6rd);
 #endif
+	kfree(tunnel->sit_parms);
+	tunnel->sit_parms = NULL;
 	if (tunnel->dst_cache.cache) {
 		dst_cache_destroy(&tunnel->dst_cache);
 		tunnel->dst_cache.cache = NULL;
@@ -1512,7 +1531,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	strscpy(tunnel->parms.name, dev->name);
+	strscpy(tunnel->sit_parms->name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
 
@@ -1528,15 +1547,9 @@ static int ipip6_tunnel_init(struct net_device *dev)
 static void __net_init ipip6_fb_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct iphdr *iph = &tunnel->parms.iph;
 	struct net *net = dev_net(dev);
 	struct sit_net *sitn = net_generic(net, sit_net_id);
 
-	iph->version		= 4;
-	iph->protocol		= IPPROTO_IPV6;
-	iph->ihl		= 5;
-	iph->ttl		= 64;
-
 	rcu_assign_pointer(sitn->tunnels_wc[0], tunnel);
 }
 
@@ -1623,6 +1636,7 @@ static int ipip6_newlink(struct net_device *dev,
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel_6rd ip6rd;
 #endif
+	struct ip_tunnel_parm_kern p;
 	struct net *net;
 	int err;
 
@@ -1636,11 +1650,16 @@ static int ipip6_newlink(struct net_device *dev,
 			return err;
 	}
 
-	ipip6_netlink_parms(data, &nt->parms, &nt->fwmark);
+	ipip6_netlink_parms(data, &p, &nt->fwmark);
 
-	if (ipip6_tunnel_locate(net, &nt->parms, 0))
+	if (ipip6_tunnel_locate(net, &p, 0))
 		return -EEXIST;
 
+	nt->sit_parms = kmalloc_obj(*nt->sit_parms);
+	if (!nt->sit_parms)
+		return -ENOMEM;
+	*nt->sit_parms = p;
+
 	err = ipip6_tunnel_create(dev);
 	if (err < 0) {
 		ipip6_dev_free(dev);
@@ -1707,7 +1726,9 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	} else
 		t = netdev_priv(dev);
 
-	ipip6_tunnel_update(t, &p, fwmark);
+	err = ipip6_tunnel_update(t, &p, fwmark);
+	if (err)
+		return err;
 
 #ifdef CONFIG_IPV6_SIT_6RD
 	if (ipip6_netlink_6rd_parms(data, &ip6rd))
@@ -1762,7 +1783,7 @@ static size_t ipip6_get_size(const struct net_device *dev)
 static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct ip_tunnel_parm_kern *parm = &tunnel->parms;
+	struct ip_tunnel_parm_kern *parm = tunnel->sit_parms;
 #ifdef CONFIG_IPV6_SIT_6RD
 	const struct ip_tunnel_6rd_parm *ip6rd;
 #endif
@@ -1935,6 +1956,17 @@ static int __net_init sit_init_net(struct net *net)
 
 	t = netdev_priv(sitn->fb_tunnel_dev);
 	t->net = net;
+	t->sit_parms = kzalloc_obj(*t->sit_parms);
+	if (!t->sit_parms) {
+		err = -ENOMEM;
+		goto err_reg_dev;
+	}
+	t->sit_parms->iph.version	= 4;
+	t->sit_parms->iph.protocol	= IPPROTO_IPV6;
+	t->sit_parms->iph.ihl		= 5;
+	t->sit_parms->iph.ttl		= 64;
+	strscpy(t->sit_parms->name, sitn->fb_tunnel_dev->name);
+	t->parms = *t->sit_parms;
 
 	err = ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	if (err < 0)
@@ -1945,8 +1977,6 @@ static int __net_init sit_init_net(struct net *net)
 		goto err_reg_dev;
 
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
-
-	strscpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
 err_reg_dev:
-- 
2.55.0.979.g7e5102b832-goog

