Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387A3F6610
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965640; cv=none; b=SuwrtvkAFX0xEyYvRBCW3t2E+msf6fTxdxmomqdehZ9ODbc675FII5iU/QPQaFa63fHVsWJoHNZxV//yfs/MIqqlzdGs6/gsl08BGpzSzvuRI2JyVhAb+eEeLOMST+K9ipG22/GzLv3RQuonNFsALoHFN53r+dN5iXcsFy3nlTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965640; c=relaxed/simple;
	bh=SRHgQ8LmhKbU15IR2LbmMBf69OalgBE8SicBaXH+YP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgJirdyhMfPfc9fQdt8QjkXuf6RRit3MjvfXkgu/bZ48gDe+Q7BjAZHBspB6Y6l8frjiO/0NXyTwy0pgiMF4UdLSBOOiRxo6xclhOwJB6imI3Y69FjH9RdbvjDSqaCgnIGzBp6tuNZLvaFacsSKAq1ToSOKZHnkh+QqdprCO/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZea0EsW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZea0EsW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f611b3af9so212470f8f.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965636; x=1786570436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EbdaXU49sEqhlpvM9echRpxckxR5PSfEdcrSDhpIaBU=;
        b=QZea0EsWA1yNELazimp/mhWu+SrDu8+tPgWC2jkHY4c5HI+GBzbSnqzP7K6AfySKRc
         uz9JJ9Z2UqqB6CIgwaa15KPkOEVxryYFK9OyrHH1KyiuSGpDYU5n72FqvDL3341Cv8VQ
         O3tZrJug9zPnxmVYIIXuei111x/en8QaHtif4aTWHSQDC/LmxKgJVpyuHLzSj+given9
         5fIJJrbzOzzRgOHd94I5z8tbSm3h6srZECbmQsuuGybsg1CRugYL/gIFKPEvdi+3R7Wn
         oFSoxX1aXMvmimxqTvv3trqmqI2IlaFC8MFtMJ1NjxHsreBucgs0OJ6AC2HZfoo/iwM8
         fy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965636; x=1786570436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EbdaXU49sEqhlpvM9echRpxckxR5PSfEdcrSDhpIaBU=;
        b=aWPUo6O6Uw5W9r0DANz+n93tLrmk3dxkTaXIkfa+Jft30HmmXxU4oD/KZAd43fENXm
         65LA1jriMtK07jKpe2FA0JNl9QsKqLZqsZ7MmFJZItQBS7NPgfz/NnD7BB7wcrDPbHsl
         NPKXWuZ6Dl1im6EIeSgDfWm1ChVS7U96G3aUQ/Z8234ueZz6sWoF8U17+fT9r6+unvC1
         gw2cbty7oEeMdcj04fDwxGE36DdfzJApObENAQj+660kJ3tnFqi9XcXvIey3yKcejRfO
         Quqs9yr2iqBXdsfAY2TKbMXxXxubEkxr+K3iAdZK9O1HHdu3ECCBPhsjNJ3NRBkEmFX4
         wUIw==
X-Gm-Message-State: AOJu0YxD/kLs+KpQ91sKVFmIwACMHCFPrYAmvSk6vIjuedBG4Q+nVgRh
	ekR3cq6tzHCmH0utD9Ym/P6PkdTKQL21sTabj2aEzF+Ma9h2WyUH+EuGbyJKE118Ue4=
X-Gm-Gg: AR+sD11ZC4xZ5rn0rlscGMHKehBcfJjoCXlL9Pmw4le+8soxDCLZcY8yTSwG1HHZV05
	h2tkg/ybBbJXFdZRY97HzTn0SB5hi2be4iv7eWWMWhwflwMCKCe4eBEufybVcRp5wQqNxPmpvpa
	czwogCc07k11o2tCinrcz7HqQ2mYQoq00UzTiELu4srg7CAyFqmRPSmcMM5eMTcYHx7MLdmLCUm
	Sk1vMeiyRZWURp6bYIzQArqhEoYp7DdKulIKjYBuehr3/7sqnrWn8RS7PeLH4eK+5AfqZ2tJw0j
	H9+VFch2MDFc9rj+kOZZ8D/L7RWrycciMThPVBycm2Hv1O7265mNhJSsRTjLyB31H8HlzvmuG1c
	2GST5VJplKN2sFmXWkezpA72VzCVDXL0fVkRRpghf7FPSC7hGvJ9HiFDPlwGQvswOh5LJBcJm8H
	sip0KVevzj+Ht8FMoE74dlR4R+6VHQR51rzq7POWwN/Yw=
X-Received: by 2002:a05:600c:1393:b0:495:650b:4c61 with SMTP id 5b1f17b1804b1-4994e7d0166mr73752165e9.3.1785965636167;
        Wed, 05 Aug 2026 14:33:56 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:f900])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b4bcbsm471041f8f.11.2026.08.05.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:33:55 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Aug 2026 22:33:02 +0100
Subject: [PATCH net-next 2/4] netconsole: use the address family instead of
 the ipv6 flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-netcons_ipv6-v1-2-170a35b92da1@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
In-Reply-To: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

Now that we have the address family in inet_addr, use that and remove
nt->ipv6.

We no longer need netcons_local_ip_unset() to check that all bytes are
zeroes, as that is now denoted by (family == AF_UNSPEC).

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 82 ++++++++++++++----------------------------------
 1 file changed, 23 insertions(+), 59 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d615a9256787..070bae7b4fd7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -181,7 +181,6 @@ enum target_state {
  *		local_mac	(read-only)
  * @local_ip:	Source IP address of the target (read-write).
  * @remote_ip:	Destination IP address of the target (read-write).
- * @ipv6:	Whether the target addresses are IPv6 (read-write).
  * @local_port:	Source UDP port of the target (read-write).
  * @remote_port: Destination UDP port of the target (read-write).
  * @remote_mac:	Destination ethernet address of the target (read-write).
@@ -213,7 +212,6 @@ struct netconsole_target {
 	bool			release;
 	struct netpoll		np;
 	struct inet_addr	local_ip, remote_ip;
-	bool			ipv6;
 	u16			local_port, remote_port;
 	u8			remote_mac[ETH_ALEN];
 	/* protected by target_list_lock; +1 gives scnprintf() room for its
@@ -463,23 +461,6 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
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
@@ -525,16 +506,13 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
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
 
@@ -716,22 +694,22 @@ static void netconsole_print_banner(struct netconsole_target *nt)
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
 
-/* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
- * populated, 1 if IPv6 is populated, and -1 upon failure.
+/* Parse the string and populate the `inet_addr` struct. Return 0 on success
+ * and -1 upon failure.
  */
 static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
 {
@@ -755,7 +733,7 @@ static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
 	    in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
 	    (!end || *end == 0 || *end == '\n')) {
 		addr->family = AF_INET6;
-		return 1;
+		return 0;
 	}
 
 	return -1;
@@ -861,7 +839,7 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
-	if (nt->ipv6)
+	if (nt->local_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
 		return sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
@@ -871,7 +849,7 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
 
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else
 		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip.ip);
@@ -1219,7 +1197,6 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
-	int ipv6;
 
 	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
@@ -1228,10 +1205,8 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ipv6 = netpoll_parse_ip_addr(buf, &nt->local_ip);
-	if (ipv6 == -1)
+	if (netpoll_parse_ip_addr(buf, &nt->local_ip) < 0)
 		goto out_unlock;
-	nt->ipv6 = !!ipv6;
 
 	ret = count;
 out_unlock:
@@ -1244,7 +1219,6 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
-	int ipv6;
 
 	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
@@ -1253,10 +1227,8 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	ipv6 = netpoll_parse_ip_addr(buf, &nt->remote_ip);
-	if (ipv6 == -1)
+	if (netpoll_parse_ip_addr(buf, &nt->remote_ip) < 0)
 		goto out_unlock;
-	nt->ipv6 = !!ipv6;
 
 	ret = count;
 out_unlock:
@@ -2067,7 +2039,7 @@ static void netpoll_udp_checksum(struct netconsole_target *nt,
 
 	/* check needs to be set, since it will be consumed in csum_partial */
 	udph->check = 0;
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		udph->check = csum_ipv6_magic(&nt->local_ip.in6,
 					      &nt->remote_ip.in6,
 					      udp_len, IPPROTO_UDP,
@@ -2108,7 +2080,7 @@ static void push_eth(struct netconsole_target *nt, struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	ether_addr_copy(eth->h_source, np->dev->dev_addr);
 	ether_addr_copy(eth->h_dest, nt->remote_mac);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		eth->h_proto = htons(ETH_P_IPV6);
 	else
 		eth->h_proto = htons(ETH_P_IP);
@@ -2177,7 +2149,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 		WARN_ON_ONCE(!irqs_disabled());
 
 	udp_len = len + sizeof(struct udphdr);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		ip_len = udp_len + sizeof(struct ipv6hdr);
 	else
 		ip_len = udp_len + sizeof(struct iphdr);
@@ -2193,7 +2165,7 @@ static int netpoll_send_udp(struct netconsole_target *nt, const char *msg,
 	skb_put(skb, len);
 
 	push_udp(nt, skb, len);
-	if (nt->ipv6)
+	if (nt->remote_ip.family == AF_INET6)
 		push_ipv6(nt, skb, len);
 	else
 		push_ipv4(nt, skb, len);
@@ -2513,10 +2485,8 @@ __releases(&target_list_lock)
 static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
 {
 	struct netpoll *np = &nt->np;
-	bool ipversion_set = false;
 	char *cur = opt;
 	char *delim;
-	int ipv6;
 
 	if (*cur != '@') {
 		delim = strchr(cur, '@');
@@ -2530,16 +2500,12 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
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
@@ -2581,13 +2547,11 @@ static int netconsole_parser_cmdline(struct netconsole_target *nt, char *opt)
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

