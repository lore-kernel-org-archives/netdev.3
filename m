Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33B442FC2;
	Fri, 24 Jul 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905544; cv=none; b=MZKbM3G6ews1bgqXrASQEYHpIhoYKaQe0XHi+pIcVP4PDN8gunN6j3Vw/zmdp3pmCnkUpGitQp7EanTbp7nZy2LKKh4SYBiFRUYznZ1hPHp2BtMLOW5DqfCMAcKIWC4SHIQQjp6Gff+vU3LX1gptOSu2AIYZQ25FQGmO+i273qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905544; c=relaxed/simple;
	bh=T6zfCgyixfhFVf6mf7wUgxE7TI3tXpKbZSGQeq1uEzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovHOt4D8597J6O3B5JzNsXueRl8rRZOqX+Z13fD8v94yeJhpBORhpSLMNC7Ib/dRPp6thppdTgHSI5PCxa8DifMTgoUISeAz+HnY9hZntHhEkrv0Qlp9tNfIpAMIqMRG7Y0LpqCWNtxR7UZKUxOGju8AW5ma4RMoodtmJUuiS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=n6pp7OLO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="n6pp7OLO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=90xnO+J2mJ+eHNoKZAPHI75XwrWJYe6aVGfen1xqeg4=; b=n6pp7OLOSVsL3hf4AGjURX9+Iw
	HPrul7uIiSU9kpzgWZfH8qwCDTMqHQ1+iCFgzriSEewvUBHavvKHrevFxaQSTlTNIqcT92rBmjxsS
	3sNhcARzNs/8Bo+tSPK7d/tdVaSwJyI6KYg8woD6U1jfsdTXme4gfqngOuJIgApawspaAoZWp51DL
	9+EVgEwO/jdrasFnxKw33SAkY+GXk31CKlemPdXG+VXleIPh4RKJS9YMSsZez42iplYdEwxoZ4FQ2
	QmyBFrv0CqAukTK7MZ+tGNJY5WvYoKIUUSb925VKVgG1YsZEwB78cxGldRt10RsX834LwhEDrhSrb
	/vMYaTIw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHT2-004duy-1k;
	Fri, 24 Jul 2026 15:05:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:16 -0700
Subject: [PATCH net-next 8/9] netconsole: move local_ip/remote_ip/ipv6 to
 netconsole_target
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-netconsole_move_more_final-v1-8-a5f7691db81c@debian.org>
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=14995; i=leitao@debian.org;
 h=from:subject:message-id; bh=T6zfCgyixfhFVf6mf7wUgxE7TI3tXpKbZSGQeq1uEzw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38eq/951/Jwq5/GaKGErp9PrkhX2TvYIKnsW
 to6aM7sq32JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HgAKCRA1o5Of/Hh3
 bXP5D/9CZgw+J//ES7ydu3yNqpBFpZoR7GrTntXg3WEnOoS724UIwRUDbRkg1eADKA3Z0dEVoTW
 zqmETve9JoS4XWddND+WInkdVqdr23w5E4vf34qWkxwEk6Qg3W+Xq3xrZawS0/ng6G8zrhu0hGl
 nl6jUXYCW3bBOybpjeuF8EVaghoNX2jvJRmUISa2Pe6lbWwLWFLCK6YtIB1jhvvqveYuqN0sGja
 nbxcfhUsj4jIQsr+HNlx5ggvZhOxIXd/CkX1VyIZQvmOYJucL0J4/xg62Zh5/o1e+zgrqORs+J3
 VEttVuhmBNeYqj8tBZJBd9B5GVVTD98L7LqHkgOAitM4eVGu9RygX2JZy4KW4qK8Kzdts5H3Ox2
 jP+IjUMvBJQJL651lVcWfPm4m7fOO9zjKC8TWjrFsRuAiucgwQjTWlh7DOXOz+bb5hayEDJ+nP6
 pJ9Myz8DJyRNp8RIlrnL016+QmyPfGCEzTiQaK2SRLpl4U3O/DPV4bBpR/5Vf+IPUD96MzKeS7i
 qbqsoKW9wYN02tOYYWSeXQ/JV5gXsRvzLffANhy7OV3dYj9d7HkWlM0ZWQ3t0slp8VLZGqtzsG1
 fSx6RYiBhyj2dIx8aHncitP+/u0O/UhIjdZCFHnm0Rr63+W3YweNeWdZ3aN32I83aQqEls85gqO
 rZZ+cVoE94CtpXw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

With netpoll_setup() and the packet-building path now living in
netconsole, local_ip, remote_ip and ipv6 in struct netpoll are read
and written only by netconsole. No other netpoll user touches them.

Move the three fields into netconsole_target and switch the packet
builders and setup helpers to take the target instead of the netpoll
handle. struct netpoll is left holding only the device-binding state
that the shared netpoll transport needs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 143 +++++++++++++++++++++++++----------------------
 include/linux/netpoll.h  |   3 -
 2 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index fc575adc29bd7..199d0e1ac17b2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -177,9 +177,10 @@ enum target_state {
  * @np:		The netpoll structure for this target.
  *		Contains the other userspace visible parameters:
  *		dev_name	(read-write)
- *		local_ip	(read-write)
- *		remote_ip	(read-write)
  *		local_mac	(read-only)
+ * @local_ip:	Source IP address of the target (read-write).
+ * @remote_ip:	Destination IP address of the target (read-write).
+ * @ipv6:	Whether the target addresses are IPv6 (read-write).
  * @local_port:	Source UDP port of the target (read-write).
  * @remote_port: Destination UDP port of the target (read-write).
  * @remote_mac:	Destination ethernet address of the target (read-write).
@@ -210,6 +211,8 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
+	union inet_addr		local_ip, remote_ip;
+	bool			ipv6;
 	u16			local_port, remote_port;
 	u8			remote_mac[ETH_ALEN];
 	/* protected by target_list_lock; +1 gives scnprintf() room for its
@@ -370,11 +373,13 @@ static char *netcons_egress_dev(struct netpoll *np, char *buf, size_t bufsz)
 }
 
 /*
- * Take the IPv6 from ndev and populate local_ip structure in netpoll
+ * Populate the target's local_ip with the IPv6 address from ndev.
  */
-static int netcons_take_ipv6(struct netpoll *np, struct net_device *ndev)
+static int netcons_take_ipv6(struct netconsole_target *nt,
+			     struct net_device *ndev)
 {
 	char buf[MAC_ADDR_STR_LEN + 1];
+	struct netpoll *np = &nt->np;
 	int err = -EDESTADDRREQ;
 	struct inet6_dev *idev;
 
@@ -391,10 +396,10 @@ static int netcons_take_ipv6(struct netpoll *np, struct net_device *ndev)
 		read_lock_bh(&idev->lock);
 		list_for_each_entry(ifp, &idev->addr_list, if_list) {
 			if (!!(ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) !=
-				!!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
+				!!(ipv6_addr_type(&nt->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 				continue;
 			/* Got the IP, let's return */
-			np->local_ip.in6 = ifp->addr;
+			nt->local_ip.in6 = ifp->addr;
 			err = 0;
 			break;
 		}
@@ -406,16 +411,18 @@ static int netcons_take_ipv6(struct netpoll *np, struct net_device *ndev)
 		return err;
 	}
 
-	np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
+	np_info(np, "local IPv6 %pI6c\n", &nt->local_ip.in6);
 	return 0;
 }
 
 /*
- * Take the IPv4 from ndev and populate local_ip structure in netpoll
+ * Populate the target's local_ip with the IPv4 address from ndev.
  */
-static int netcons_take_ipv4(struct netpoll *np, struct net_device *ndev)
+static int netcons_take_ipv4(struct netconsole_target *nt,
+			     struct net_device *ndev)
 {
 	char buf[MAC_ADDR_STR_LEN + 1];
+	struct netpoll *np = &nt->np;
 	const struct in_ifaddr *ifa;
 	struct in_device *in_dev;
 
@@ -433,34 +440,35 @@ static int netcons_take_ipv4(struct netpoll *np, struct net_device *ndev)
 		return -EDESTADDRREQ;
 	}
 
-	np->local_ip.ip = ifa->ifa_local;
-	np_info(np, "local IP %pI4\n", &np->local_ip.ip);
+	nt->local_ip.ip = ifa->ifa_local;
+	np_info(np, "local IP %pI4\n", &nt->local_ip.ip);
 
 	return 0;
 }
 
 /*
- * Test whether the caller left np->local_ip unset, so that
+ * Test whether the caller left nt->local_ip unset, so that
  * netcons_netpoll_setup() should auto-populate it from the egress device.
  *
- * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
+ * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
  * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
  * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
  * doing so would misclassify a caller-supplied address as unset and
  * silently overwrite it with whatever address the device exposes.
  */
-static bool netcons_local_ip_unset(const struct netpoll *np)
+static bool netcons_local_ip_unset(const struct netconsole_target *nt)
 {
-	if (np->ipv6)
-		return ipv6_addr_any(&np->local_ip.in6);
-	return !np->local_ip.ip;
+	if (nt->ipv6)
+		return ipv6_addr_any(&nt->local_ip.in6);
+	return !nt->local_ip.ip;
 }
 
-static int netcons_netpoll_setup(struct netpoll *np)
+static int netcons_netpoll_setup(struct netconsole_target *nt)
 {
 	struct net *net = current->nsproxy->net_ns;
 	char buf[MAC_ADDR_STR_LEN + 1];
 	struct net_device *ndev = NULL;
+	struct netpoll *np = &nt->np;
 	bool ip_overwritten = false;
 	int err;
 
@@ -500,13 +508,13 @@ static int netcons_netpoll_setup(struct netpoll *np)
 		rtnl_lock();
 	}
 
-	if (netcons_local_ip_unset(np)) {
-		if (!np->ipv6) {
-			err = netcons_take_ipv4(np, ndev);
+	if (netcons_local_ip_unset(nt)) {
+		if (!nt->ipv6) {
+			err = netcons_take_ipv4(nt, ndev);
 			if (err)
 				goto put;
 		} else {
-			err = netcons_take_ipv6(np, ndev);
+			err = netcons_take_ipv6(nt, ndev);
 			if (err)
 				goto put;
 		}
@@ -529,7 +537,7 @@ static int netcons_netpoll_setup(struct netpoll *np)
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
-		memset(&np->local_ip, 0, sizeof(np->local_ip));
+		memset(&nt->local_ip, 0, sizeof(nt->local_ip));
 	netdev_put(ndev, &np->dev_tracker);
 unlock:
 	rtnl_unlock();
@@ -546,7 +554,7 @@ static void resume_target(struct netconsole_target *nt)
 	 */
 	netconsole_skb_pool_init(nt);
 
-	if (netcons_netpoll_setup(&nt->np)) {
+	if (netcons_netpoll_setup(nt)) {
 		/* netpoll fails setup once, do not try again. */
 		netconsole_skb_pool_flush(nt);
 		nt->state = STATE_DISABLED;
@@ -691,17 +699,17 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 	struct netpoll *np = &nt->np;
 
 	np_info(np, "local port %d\n", nt->local_port);
-	if (np->ipv6)
-		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
+	if (nt->ipv6)
+		np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.in6);
 	else
-		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
+		np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip);
 	np_info(np, "interface name '%s'\n", np->dev_name);
 	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
 	np_info(np, "remote port %d\n", nt->remote_port);
-	if (np->ipv6)
-		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
+	if (nt->ipv6)
+		np_info(np, "remote IPv6 address %pI6c\n", &nt->remote_ip.in6);
 	else
-		np_info(np, "remote IPv4 address %pI4\n", &np->remote_ip.ip);
+		np_info(np, "remote IPv4 address %pI4\n", &nt->remote_ip.ip);
 	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
 }
 
@@ -832,20 +840,20 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
-	if (nt->np.ipv6)
-		return sysfs_emit(buf, "%pI6c\n", &nt->np.local_ip.in6);
+	if (nt->ipv6)
+		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->np.local_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->local_ip);
 }
 
 static ssize_t remote_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
-	if (nt->np.ipv6)
-		return sysfs_emit(buf, "%pI6c\n", &nt->np.remote_ip.in6);
+	if (nt->ipv6)
+		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->np.remote_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip);
 }
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
@@ -1025,7 +1033,7 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		netconsole_skb_pool_init(nt);
 
-		ret = netcons_netpoll_setup(&nt->np);
+		ret = netcons_netpoll_setup(nt);
 		if (ret) {
 			netconsole_skb_pool_flush(nt);
 			goto out_unlock;
@@ -1199,10 +1207,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.local_ip);
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->local_ip);
 	if (ipv6 == -1)
 		goto out_unlock;
-	nt->np.ipv6 = !!ipv6;
+	nt->ipv6 = !!ipv6;
 
 	ret = count;
 out_unlock:
@@ -1224,10 +1232,10 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.remote_ip);
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->remote_ip);
 	if (ipv6 == -1)
 		goto out_unlock;
-	nt->np.ipv6 = !!ipv6;
+	nt->ipv6 = !!ipv6;
 
 	ret = count;
 out_unlock:
@@ -2027,8 +2035,8 @@ static struct sk_buff *find_skb(struct netconsole_target *nt, int len,
 	return skb;
 }
 
-static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
-				 int len)
+static void netpoll_udp_checksum(struct netconsole_target *nt,
+				 struct sk_buff *skb, int len)
 {
 	struct udphdr *udph;
 	int udp_len;
@@ -2038,14 +2046,14 @@ static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 
 	/* check needs to be set, since it will be consumed in csum_partial */
 	udph->check = 0;
-	if (np->ipv6)
-		udph->check = csum_ipv6_magic(&np->local_ip.in6,
-					      &np->remote_ip.in6,
+	if (nt->ipv6)
+		udph->check = csum_ipv6_magic(&nt->local_ip.in6,
+					      &nt->remote_ip.in6,
 					      udp_len, IPPROTO_UDP,
 					      csum_partial(udph, udp_len, 0));
 	else
-		udph->check = csum_tcpudp_magic(np->local_ip.ip,
-						np->remote_ip.ip,
+		udph->check = csum_tcpudp_magic(nt->local_ip.ip,
+						nt->remote_ip.ip,
 						udp_len, IPPROTO_UDP,
 						csum_partial(udph, udp_len, 0));
 	if (udph->check == 0)
@@ -2054,7 +2062,6 @@ static void netpoll_udp_checksum(struct netpoll *np, struct sk_buff *skb,
 
 static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
 {
-	struct netpoll *np = &nt->np;
 	struct udphdr *udph;
 	int udp_len;
 
@@ -2068,7 +2075,7 @@ static void push_udp(struct netconsole_target *nt, struct sk_buff *skb, int len)
 	udph->dest = htons(nt->remote_port);
 	udp_set_len_short(udph, udp_len);
 
-	netpoll_udp_checksum(np, skb, len);
+	netpoll_udp_checksum(nt, skb, len);
 }
 
 static void push_eth(struct netconsole_target *nt, struct sk_buff *skb)
@@ -2080,13 +2087,14 @@ static void push_eth(struct netconsole_target *nt, struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	ether_addr_copy(eth->h_source, np->dev->dev_addr);
 	ether_addr_copy(eth->h_dest, nt->remote_mac);
-	if (np->ipv6)
+	if (nt->ipv6)
 		eth->h_proto = htons(ETH_P_IPV6);
 	else
 		eth->h_proto = htons(ETH_P_IP);
 }
 
-static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
+static void push_ipv4(struct netconsole_target *nt, struct sk_buff *skb,
+		      int len)
 {
 	static atomic_t ip_ident;
 	struct iphdr *iph;
@@ -2107,13 +2115,14 @@ static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 	iph->ttl = 64;
 	iph->protocol = IPPROTO_UDP;
 	iph->check = 0;
-	put_unaligned(np->local_ip.ip, &iph->saddr);
-	put_unaligned(np->remote_ip.ip, &iph->daddr);
+	put_unaligned(nt->local_ip.ip, &iph->saddr);
+	put_unaligned(nt->remote_ip.ip, &iph->daddr);
 	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
 	skb->protocol = htons(ETH_P_IP);
 }
 
-static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
+static void push_ipv6(struct netconsole_target *nt, struct sk_buff *skb,
+		      int len)
 {
 	struct ipv6hdr *ip6h;
 
@@ -2130,8 +2139,8 @@ static void push_ipv6(struct netpoll *np, struct sk_buff *skb, int len)
 	ip6h->payload_len = htons(sizeof(struct udphdr) + len);
 	ip6h->nexthdr = IPPROTO_UDP;
 	ip6h->hop_limit = 32;
-	ip6h->saddr = np->local_ip.in6;
-	ip6h->daddr = np->remote_ip.in6;
+	ip6h->saddr = nt->local_ip.in6;
+	ip6h->daddr = nt->remote_ip.in6;
 
 	skb->protocol = htons(ETH_P_IPV6);
 }
@@ -2147,7 +2156,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 		WARN_ON_ONCE(!irqs_disabled());
 
 	udp_len = len + sizeof(struct udphdr);
-	if (np->ipv6)
+	if (nt->ipv6)
 		ip_len = udp_len + sizeof(struct ipv6hdr);
 	else
 		ip_len = udp_len + sizeof(struct iphdr);
@@ -2163,10 +2172,10 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 	skb_put(skb, len);
 
 	push_udp(nt, skb, len);
-	if (np->ipv6)
-		push_ipv6(np, skb, len);
+	if (nt->ipv6)
+		push_ipv6(nt, skb, len);
 	else
-		push_ipv4(np, skb, len);
+		push_ipv4(nt, skb, len);
 	push_eth(nt, skb);
 	skb->dev = np->dev;
 
@@ -2505,11 +2514,11 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 		if (!delim)
 			goto parse_failed;
 		*delim = 0;
-		ipv6 = netpoll_parse_ip_addr(cur, &np->local_ip);
+		ipv6 = netpoll_parse_ip_addr(cur, &nt->local_ip);
 		if (ipv6 < 0)
 			goto parse_failed;
 		else
-			np->ipv6 = (bool)ipv6;
+			nt->ipv6 = (bool)ipv6;
 		cur = delim;
 	}
 	cur++;
@@ -2551,13 +2560,13 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 	if (!delim)
 		goto parse_failed;
 	*delim = 0;
-	ipv6 = netpoll_parse_ip_addr(cur, &np->remote_ip);
+	ipv6 = netpoll_parse_ip_addr(cur, &nt->remote_ip);
 	if (ipv6 < 0)
 		goto parse_failed;
-	else if (ipversion_set && np->ipv6 != (bool)ipv6)
+	else if (ipversion_set && nt->ipv6 != (bool)ipv6)
 		goto parse_failed;
 	else
-		np->ipv6 = (bool)ipv6;
+		nt->ipv6 = (bool)ipv6;
 	cur = delim + 1;
 
 	if (*cur != 0) {
@@ -2615,7 +2624,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	 */
 	netconsole_skb_pool_init(nt);
 
-	err = netcons_netpoll_setup(&nt->np);
+	err = netcons_netpoll_setup(nt);
 	if (err) {
 		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
 		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index dac8dc2529de0..ef88a30b11f40 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -32,9 +32,6 @@ struct netpoll {
 	char dev_name[IFNAMSIZ];
 	u8 dev_mac[ETH_ALEN];
 	const char *name;
-
-	union inet_addr local_ip, remote_ip;
-	bool ipv6;
 };
 
 #define np_info(np, fmt, ...)				\

-- 
2.53.0-Meta

