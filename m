Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619E3A782B
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635456; cv=none; b=LiqTmGccUYTRdTYm2FByPRSaZhgvle/eRtsqzAawYXlgPn684bPz7s4tQ3HrAjT4BLf0aX223R082ZJEN1hwkA4ddliTDNwXCF6VKMK4Ck5gfB8/Gp7YhYMTS4OWGha4DrwqGed4RZ5UB6LO0rhhrtWmmYTjFq8ks2xYoh2qAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635456; c=relaxed/simple;
	bh=fgiov7i7HJO2EfKcekMHZouZ7euWlEPIRfF43TXbQWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qo1jjqcKlEzk199Yg77MpAqFJFFq2Vo/7Yiug5ikT+8Vb4wtw8EIRkjTSdqqTn/gGTZx7QN4rMDikJCfimB67bMEyRnE4RE0YnqKLmPC8idnYY0WUcmBFsw9fQXmVAVJvwvcB2PqXMxXFXMFe1CcRLQzopyjhuDV9bdlMEao7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4UA8tCG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4UA8tCG"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-854f9c32c76so6131707b3.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 22:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787635451; x=1788240251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xy0SFkuKWMMtc/SL4g2KE02VlB2M1q8Q/oPABrDzF+4=;
        b=Z4UA8tCGGowAEDQWpWNIO5FQEarvuY6oYrodo0mvJos7msHnNodRrS043QHU0RNhBc
         OePERMBnCH9VUkztYYKaJXiBlOBqwCPVUgLwLXyqkgjVNlVgiEjYW1U3tT2ih3dZri75
         URMpCTHrijfzDbda3KvWgUlJNdKjRpzLZSE1cNBn32NTofvzp3G9ssWeCAjHmTwu6VHr
         nKiuwGtEvabmBhUuRmU4BmEeNXBaZf1Mj8qOlOQIESa87+WE6OOE2jVbB46D2iT+vDqN
         6c+OcOFFxDgr5U8K4bbPnwWxINwoIl0tPWxazzr6F/t/0fByFYurjWdZw7bxbHLgyAmY
         oW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787635451; x=1788240251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xy0SFkuKWMMtc/SL4g2KE02VlB2M1q8Q/oPABrDzF+4=;
        b=spCp7sNYse/Hhn25MNJfc3uk7jgnoxo56DgTzTWb6RYf/wV6s4xRdzFuK7qCteitDC
         kK4W/rLs0ravJTEdi07o8ecLkLj0EQuJ/muGmSe4K6d1QJxdFgat9jwTIufB/amzRvFm
         eJ7wMZOgeVyVk+heOyWdsef61l0/XXW+Mqou2e3Rx3Zxl3k5AwV3ho08giS2I2FleDVM
         KNCDbCTJNH4sDf8AvbXmTmEEJPBCfmWQ84LiDCYaYO1tMyJ51aGAvDdn2/dTTfuP1hZd
         h6UMZRMx//Z6HCNYCfi6aSJsnUn0dUtL+TFzO19/2MqTsfiegN3PeKRMO3JLKvr3xfS+
         A5BQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzU4kWq8geTWBce61Htm/UkCyndeVMEFA25FPD/mAPEB+DLbTLZzYjfGFzbywMjzLWERXNLRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n9CHye+Mr6+S8zkldKEvaFjYWRzZ4N1sBqeswvP8rVCW2niffv
	aGtXoW2MxRUzWA9yJut7fjZCg0mZ2W8zqo8fZfXNfMkB2omkjAcie0yC
X-Gm-Gg: AR+sD13CR3gnXuEXvwNU9QEYSAf8CHzk2sfbEfmtPP5Ldv69Ulm8WHXTdUdES06cW5D
	5C4uWiaCwo4Z//NpDKUIKKTpjlZSZdskMh0z2X8AMKA1dUVcDYCvNBiJU7FCMq8jdjijIkxgTQn
	zaa0JL8D6i/SXCHwfTlF9FO3Kx0A7tr9HjJVvk7Bmk+nB9dkX2lId2qwYYqvgRxwivkzztYdZLr
	H4o0+kAjsp/rByPzs6VsFNPrbg++JG5TJgutXP5dQm+ancvi1CYnWCaTmHNeYHdetl8TrI26iXU
	fYe5NP0s1BeJsZGxR228ePjApbcu7ljLDoT1LwllecTko8k4KoReE78SmhjJybRm0guGCfGi4ck
	SG/I8Ul1pQUB4pIyB21lxcgJ1oV4vX3yMWi3IlZun4EKYXWQDs5QBrT2CGVN9bxjN5e9QShYA+Y
	Z+yzlsVEpGhfrbbLdFwGdRGuYkco5iN4d+70MgNpKiqM+lPmpGJs4k5aCkOhB9Prj/aG4=
X-Received: by 2002:a05:690c:e299:10b0:820:10f1:d501 with SMTP id 00721157ae682-85470beb3d0mr14076457b3.6.1787635451332;
        Mon, 24 Aug 2026 22:24:11 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-851e1419e0bsm21767747b3.26.2026.08.24.22.24.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 22:24:10 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	laforge@gnumonks.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2 2/2] gtp: fix use-after-free during GTP device teardown
Date: Tue, 25 Aug 2026 01:24:04 -0400
Message-ID: <20260825052404.45665-3-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825052404.45665-1-blbllhy@gmail.com>
References: <20260825052404.45665-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gtp_encap_disable() releases the kernel-created sockets while
sk_created is still true and without waiting for in-flight readers.
This allows two concurrent use-after-free scenarios:

1. A softirq packet handler that already observed sk_created == true
   via smp_load_acquire() can dereference sk0/sk1u after they have
   been freed.

2. gtp_genl_send_echo_req() runs in process context without RTNL.
   synchronize_net() waits for RCU-protected softirq handlers but
   does not cover this non-RCU generic netlink reader, which can
   dereference freed sk0/sk1u during concurrent teardown:

     RIP: 0010:ip4_route_output_gtp  (drivers/net/gtp.c)
     gtp_genl_send_echo_req
     Kernel panic - not syncing: Fatal exception

Reorder gtp_encap_disable() to clear sk_created first, then call
synchronize_net() to wait for in-flight softirq handlers before
releasing the sockets. Hold RTNL in gtp_genl_send_echo_req() to
serialize with teardown for the process-context path. Under RTNL,
the smp_load_acquire() from patch 1/2 becomes redundant and is
replaced with a plain read.

Fixes: b20dc3c68458 ("gtp: Allow to create GTP device without FDs")
Fixes: d33bd757d362 ("gtp: Implement GTP echo request")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: New patch. Fix teardown race with synchronize_net() for softirq
    paths and rtnl_lock() for the process-context genl echo path.
v1: https://lore.kernel.org/netdev/20260816035205.57966-1-blbllhy@gmail.com/
---
 drivers/net/gtp.c | 61 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ead519ee18d1..7ac9764696f2 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -896,12 +896,14 @@ static void gtp_encap_disable_sock(struct sock *sk)
 static void gtp_encap_disable(struct gtp_dev *gtp)
 {
 	if (gtp->sk_created) {
-		udp_tunnel_sock_release(gtp->sk0);
-		udp_tunnel_sock_release(gtp->sk1u);
-		/* Pairs with smp_load_acquire() in the RX and
-		 * genl echo paths.
+		/* Prevent new readers from entering echo handlers,
+		 * then wait for in-flight softirq readers to complete
+		 * before releasing the sockets.
 		 */
 		smp_store_release(&gtp->sk_created, false);
+		synchronize_net();
+		udp_tunnel_sock_release(gtp->sk0);
+		udp_tunnel_sock_release(gtp->sk1u);
 		gtp->sk0 = NULL;
 		gtp->sk1u = NULL;
 	} else {
@@ -1473,8 +1475,7 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
 	gtp->sk1u = sk1u;
 
 	/* Ensure sk0/sk1u are visible before sk_created is set.
-	 * Pairs with smp_load_acquire() in the RX and genl
-	 * echo paths.
+	 * Pairs with smp_load_acquire() in the RX echo paths.
 	 */
 	smp_store_release(&gtp->sk_created, true);
 
@@ -2362,6 +2363,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 	struct sock *sk;
 	__be16 port;
 	int len;
+	int ret;
 
 	if (!info->attrs[GTPA_VERSION] ||
 	    !info->attrs[GTPA_LINK] ||
@@ -2373,17 +2375,22 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 	dst_ip = nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
 	src_ip = nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
 
+	rtnl_lock();
+
 	gtp = gtp_find_dev(sock_net(skb->sk), info->attrs);
-	if (!gtp)
-		return -ENODEV;
+	if (!gtp) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 
-	/* Pairs with smp_store_release() in gtp_create_sockets()
-	 * and gtp_encap_disable().
-	 */
-	if (!smp_load_acquire(&gtp->sk_created))
-		return -EOPNOTSUPP;
-	if (!(gtp->dev->flags & IFF_UP))
-		return -ENETDOWN;
+	if (!gtp->sk_created) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+	if (!(gtp->dev->flags & IFF_UP)) {
+		ret = -ENETDOWN;
+		goto out_unlock;
+	}
 
 	if (version == GTP_V0) {
 		struct gtp0_header *gtp0_h;
@@ -2392,8 +2399,10 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			sizeof(struct iphdr) + sizeof(struct udphdr);
 
 		skb_to_send = netdev_alloc_skb_ip_align(gtp->dev, len);
-		if (!skb_to_send)
-			return -ENOMEM;
+		if (!skb_to_send) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
 
 		sk = gtp->sk0;
 		port = htons(GTP0_PORT);
@@ -2409,8 +2418,10 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			sizeof(struct iphdr) + sizeof(struct udphdr);
 
 		skb_to_send = netdev_alloc_skb_ip_align(gtp->dev, len);
-		if (!skb_to_send)
-			return -ENOMEM;
+		if (!skb_to_send) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
 
 		sk = gtp->sk1u;
 		port = htons(GTP1U_PORT);
@@ -2420,7 +2431,8 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		memset(gtp1u_h, 0, sizeof(struct gtp1_header_long));
 		gtp1u_build_echo_msg(gtp1u_h, GTP_ECHO_REQ);
 	} else {
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_unlock;
 	}
 
 	rt = ip4_route_output_gtp(&fl4, sk, dst_ip, src_ip);
@@ -2428,7 +2440,8 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		netdev_dbg(gtp->dev, "no route for echo request to %pI4\n",
 			   &dst_ip);
 		kfree_skb(skb_to_send);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_unlock;
 	}
 
 	local_bh_disable();
@@ -2442,7 +2455,11 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 				    dev_net(gtp->dev)),
 			    false, 0);
 	local_bh_enable();
-	return 0;
+	ret = 0;
+
+out_unlock:
+	rtnl_unlock();
+	return ret;
 }
 
 static const struct nla_policy gtp_genl_policy[GTPA_MAX + 1] = {
-- 
2.55.0
