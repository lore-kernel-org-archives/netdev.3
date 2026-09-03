Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5E4EC667
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452802; cv=none; b=KQ6JGtvULY98vJIxdjhbGvIXOFna1YsfZ5/zleYrkS8voeyGQSYy7beZGgaS7w9xzRONfiKdwrA18UTYQNMCr2o0HVslLknJ3LOU6W0pnDiwEJGLaZG47x5l/WUfDVlj7LiNoyCxWMxaX5EPHV8AnN/ioCrniPB9nva7gOoJGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452802; c=relaxed/simple;
	bh=GhZD17cuw5gYUVnyHmaSI6jBf22mSnRirzc/2LtRvPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFn8QZ440/i7MdE84sp2spEihPrDmPWL38cS9l2N3S9N3xMcdZDE+8akOU7lvQbncsiHqSl3mx/6bEgSlF4roE2X48gv3lV8004QuQ3T1hvJsEZq5XfzKDsOrVMDBPRKKsWm++iHAuoYwy4cDy91MlVvPD5N2N4jitEvEr5x1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkQK1+Zq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkQK1+Zq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-499dd4900dfso72795e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452798; x=1789057598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECtMwAmDF1K5nODesCePL78MgfJUPMGWesJDcm6OOPY=;
        b=TkQK1+ZqfzFRRNtxW8CGQGXmQqaP82imfiuOZFqb01U5rpf4293/IZ/KDwGt4mNONH
         qlNouAGBH7aj4VTjNax19/TkwL1swfFxZCJxA/l5+h+JpgR8rEollXl3cnhxhKbivsaF
         nKaAgFiOSrz6qUpQ7wTf6Y84XOkz5lIwcnGlHZupKiM4KjMBo1GE/f8WOb63dNTWsMM+
         8WiO4+YFvymkFdMAkgkk99oZ+aQb04V87g1eua82R5w1OgCAtF8yHAmyQcOVMz5yiJCK
         ijskx22e70psnKcldPU+Nb75XFF8dkJ7E7COeANCUbP1PJQDHC5sS74nftY+2VWKIFKf
         tcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452798; x=1789057598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECtMwAmDF1K5nODesCePL78MgfJUPMGWesJDcm6OOPY=;
        b=Wncj03kyZ7BHoJI172DahKMJqCXVj1VmfmhccQwg40dgp4IZAkWZERjp/4mlQ0OYm4
         Xgr7Z1o4arbm5KvlRJvdnu1lyV9x0rdjbrvIt1dohSjwh3Z7C6fejGsPrmXARERCrysm
         E0RNmeUvUcr6M0p6t3sAxpxsKHy3+kxv+48SjzTg3bd98PrrFg6phC+sWDcmNjEDoITn
         rDFkCj0HiiJjbG5KmPFoEgALtS6eZdzVElfWYggCo5JI8N3dujO+2k7Yew+4m+yTwx2m
         ri4SOiTWEkzzlMhpcubZiq41ey6Pm8AoTjXyLQeW+yILOTNfA0hzE38qrDbFTrUj2PLj
         hVxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSha3uapeIIb+XXwvc89wMRtcKmaMile9xclxmCro0ulThEdgB7ClFte+l0wJ8Y1Xx1L9qdNA=@vger.kernel.org
X-Gm-Message-State: AFuF++m3ieta6CkzQbTsQD3p/XeUhPup47Po9UT3ibka9Xk81RyGfuG3
	Qok/JsGwwCbUPTtNGWSoLM7bdXkXqoxKdAYe9mVXoV93UF6CX+/1iHVg3QAqU5CmOPwRPg==
X-Gm-Gg: AYBFou15/Yo6VbAkS1X9rqEqdKf1e0oHiEYUiv/w+GO+2i+AzmLdXQ2GCcCNgI7NVkR
	jM31SeOnNIIfVOpiPXESRhl9p53WrWk/z/Yc590Z/sU/4sVgaw13nkwSiXB7WOuhqUZ/TzfisH0
	SlSZfhUZ5/TW6cITe+JTyEu1Ea1NdQspNfFLQm+KSYfKzuh1b6ygdhg9mRnQ29RDoZaOTCkqeij
	sfSC5g3zdS8NQNkJMAisvD3QDya1t9XfM5U3PDK4y+o4DDQLOxedV+P/+2f+Sz9T+XLg3eUOUtA
	EEmA9oc9PqCFNw3nU6W0LBXCncJHiaG2q0UZWejOKxVbmbLJ+/tiFfaonSJLg5JwD0b2xL6bkvS
	b6Ym9E00tTEFYFHfQ7/8T8tJV/3iKoRCdokLLDt44TOGQqqe45LBTSkqGj4x2bGhEiCBkdAJn4j
	wwrMeiq6amKeAFUL+RZEhZrhfFNl7awvtpGEoFM8b5MJM=
X-Received: by 2002:a05:600c:3496:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-49ce581acb5mr107851965e9.1.1788452797521;
        Thu, 03 Sep 2026 09:26:37 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:124b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d9db2sm86260845e9.8.2026.09.03.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:36 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 03 Sep 2026 17:26:01 +0100
Subject: [PATCH net-next v4 2/7] netconsole: use the address family instead
 of the ipv6 flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-netcons_ipv6-v4-2-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
In-Reply-To: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

Now that we have the address family in inet_addr, use that and remove
nt->ipv6.

We no longer need netcons_local_ip_unset() to check that all bytes are
zeroes, as that is now denoted by (family == AF_UNSPEC).

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 82 ++++++++++++++----------------------------------
 1 file changed, 23 insertions(+), 59 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 432b66cf111a..351754d53cf9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -195,7 +195,6 @@ struct netcons_userdata {
  *		local_mac	(read-only)
  * @local_ip:	Source IP address of the target (read-write).
  * @remote_ip:	Destination IP address of the target (read-write).
- * @ipv6:	Whether the target addresses are IPv6 (read-write).
  * @local_port:	Source UDP port of the target (read-write).
  * @remote_port: Destination UDP port of the target (read-write).
  * @remote_mac:	Destination ethernet address of the target (read-write).
@@ -226,7 +225,6 @@ struct netconsole_target {
 	bool			release;
 	struct netpoll		np;
 	struct inet_addr	local_ip, remote_ip;
-	bool			ipv6;
 	u16			local_port, remote_port;
 	u8			remote_mac[ETH_ALEN];
 	/* protected by target_list_lock; +1 gives scnprintf() room for its
@@ -476,23 +474,6 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
 	return 0;
 }
 
-/*
- * Test whether the caller left nt->local_ip unset, so that
- * netcons_netpoll_setup() should auto-populate it from the egress device.
- *
- * nt->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
- * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
- * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
- * doing so would misclassify a caller-supplied address as unset and
- * silently overwrite it with whatever address the device exposes.
- */
-static bool netcons_local_ip_unset(const struct netconsole_target *nt)
-{
-	if (nt->ipv6)
-		return ipv6_addr_any(&nt->local_ip.in6);
-	return !nt->local_ip.ip;
-}
-
 static int netcons_netpoll_setup(struct netconsole_target *nt)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -538,16 +519,13 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		rtnl_lock();
 	}
 
-	if (netcons_local_ip_unset(nt)) {
-		if (!nt->ipv6) {
-			err = netcons_take_ipv4(nt, ndev);
-			if (err)
-				goto put;
-		} else {
+	if (nt->local_ip.family == AF_UNSPEC) {
+		if (nt->remote_ip.family == AF_INET6)
 			err = netcons_take_ipv6(nt, ndev);
-			if (err)
-				goto put;
-		}
+		else
+			err = netcons_take_ipv4(nt, ndev);
+		if (err)
+			goto put;
 		ip_overwritten = true;
 	}
 
@@ -729,22 +707,22 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 	struct netpoll *np = &nt->np;
 
 	np_info(np, "local port %d\n", nt->local_port);
-	if (nt->ipv6)
+	if (nt->local_ip.family == AF_INET6)
 		np_info(np, "local IPv6 address %pI6c\n", &nt->local_ip.in6);
 	else
 		np_info(np, "local IPv4 address %pI4\n", &nt->local_ip.ip);
 	np_info(np, "interface name '%s'\n", np->dev_name);
 	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
 	np_info(np, "remote port %d\n", nt->remote_port);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		np_info(np, "remote IPv6 address %pI6c\n", &nt->remote_ip.in6);
 	else
 		np_info(np, "remote IPv4 address %pI4\n", &nt->remote_ip.ip);
 	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
 }
 
-/* Parse the string and populate the `inet_addr` struct. Return 0 if IPv4 is
- * populated, 1 if IPv6 is populated, and -1 upon failure.
+/* Parse the string and populate the `inet_addr` struct. Return 0 on success
+ * and -1 upon failure.
  */
 static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
 {
@@ -768,7 +746,7 @@ static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
 	    in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
 	    (!end || *end == 0 || *end == '\n')) {
 		addr->family = AF_INET6;
-		return 1;
+		return 0;
 	}
 
 	return -1;
@@ -874,7 +852,7 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
-	if (nt->ipv6)
+	if (nt->local_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
 		return sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
@@ -884,7 +862,7 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else
 		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip.ip);
@@ -1232,7 +1210,6 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
-	int ipv6;
 
 	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
@@ -1241,10 +1218,8 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ipv6 = netpoll_parse_ip_addr(buf, &nt->local_ip);
-	if (ipv6 == -1)
+	if (netpoll_parse_ip_addr(buf, &nt->local_ip) < 0)
 		goto out_unlock;
-	nt->ipv6 = !!ipv6;
 
 	ret = count;
 out_unlock:
@@ -1257,7 +1232,6 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
-	int ipv6;
 
 	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
@@ -1266,10 +1240,8 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ipv6 = netpoll_parse_ip_addr(buf, &nt->remote_ip);
-	if (ipv6 == -1)
+	if (netpoll_parse_ip_addr(buf, &nt->remote_ip) < 0)
 		goto out_unlock;
-	nt->ipv6 = !!ipv6;
 
 	ret = count;
 out_unlock:
@@ -2078,7 +2050,7 @@ static void netpoll_udp_checksum(struct netconsole_target *nt,
 
 	/* check needs to be set, since it will be consumed in csum_partial */
 	udph->check = 0;
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		udph->check = csum_ipv6_magic(&nt->local_ip.in6,
 					      &nt->remote_ip.in6,
 					      udp_len, IPPROTO_UDP,
@@ -2119,7 +2091,7 @@ static void push_eth(struct netconsole_target *nt, struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	ether_addr_copy(eth->h_source, np->dev->dev_addr);
 	ether_addr_copy(eth->h_dest, nt->remote_mac);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		eth->h_proto = htons(ETH_P_IPV6);
 	else
 		eth->h_proto = htons(ETH_P_IP);
@@ -2188,7 +2160,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 		WARN_ON_ONCE(!irqs_disabled());
 
 	udp_len = len + sizeof(struct udphdr);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		ip_len = udp_len + sizeof(struct ipv6hdr);
 	else
 		ip_len = udp_len + sizeof(struct iphdr);
@@ -2204,7 +2176,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 	skb_put(skb, len);
 
 	push_udp(nt, skb, len);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		push_ipv6(nt, skb, len);
 	else
 		push_ipv4(nt, skb, len);
@@ -2533,10 +2505,8 @@ __releases(&target_list_lock)
 static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 {
 	struct netpoll *np = &nt->np;
-	bool ipversion_set = false;
 	char *cur = opt;
 	char *delim;
-	int ipv6;
 
 	if (*cur != '@') {
 		delim = strchr(cur, '@');
@@ -2550,16 +2520,12 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 	cur++;
 
 	if (*cur != '/') {
-		ipversion_set = true;
 		delim = strchr(cur, '/');
 		if (!delim)
 			goto parse_failed;
 		*delim = 0;
-		ipv6 = netpoll_parse_ip_addr(cur, &nt->local_ip);
-		if (ipv6 < 0)
+		if (netpoll_parse_ip_addr(cur, &nt->local_ip) < 0)
 			goto parse_failed;
-		else
-			nt->ipv6 = (bool)ipv6;
 		cur = delim;
 	}
 	cur++;
@@ -2601,13 +2567,11 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 	if (!delim)
 		goto parse_failed;
 	*delim = 0;
-	ipv6 = netpoll_parse_ip_addr(cur, &nt->remote_ip);
-	if (ipv6 < 0)
+	if (netpoll_parse_ip_addr(cur, &nt->remote_ip) < 0)
 		goto parse_failed;
-	else if (ipversion_set && nt->ipv6 != (bool)ipv6)
+	if (nt->local_ip.family != AF_UNSPEC &&
+	    nt->local_ip.family != nt->remote_ip.family)
 		goto parse_failed;
-	else
-		nt->ipv6 = (bool)ipv6;
 	cur = delim + 1;
 
 	if (*cur != 0) {

-- 
2.55.0

