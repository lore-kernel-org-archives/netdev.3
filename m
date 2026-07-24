Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB96442B23;
	Fri, 24 Jul 2026 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905540; cv=none; b=SkGgD2XGu4r4EwuL/bwDIB+2wN0JQZ7JhoCCI519lKVvg1Nlq1WCSK9kYNLoT4dMCD0wnfzTKj90ddGb4IAqWeK10odfE2FNYu2CRxsl1K2smDBRN3hlvgIQFBg5j6zbQ0YRd5mv1sTpYttHK6rm24bbjnwcc+y9jIAnY+ZIJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905540; c=relaxed/simple;
	bh=0GT3H6luF68DLEJYuF2v8B2YQnks5PYIrQ6WewmJIUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gfk+CqELeZhfHc6ady2FVVZFATJIoKt8ifuHsE24kUU5kuVebF2Vh8I3OOI6CN+z3fYwAU+H+BJwvWl6NKH2Tysf8euowwNGodyDIyrxqc8+x+TkuUMgSAuKrTS+QTz3Tt71jUxCYhZ2tFK/+P2JhBzcKpR5F1+/6wukdXyyWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nJfMDqeB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nJfMDqeB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=o1W+gUNCPN3ikfxj2HMnWY41j2z+OLXY31chZvXltFQ=; b=nJfMDqeBBmZ/98QV+syCXWkcCx
	/Llz/t+O1VG3SOXcwVS/7q3dNR/fVvgOlG5ptrMDP7kP/Otlz5axMYO3Pr7LMZnqMTXWHjK5I/T+m
	uogjgWN56yXfi4ta1W99AwHG/2yWQgqaOk8hU3xxoQqPiUYwOfAlqF6ZcXSmRyOpWjXH+e0HdG+zq
	iYVn8Pmdp+zRx/cdMC6jlpI8bJBmbL8raRBT0zFitwZRpDAwbM3K+i2lEQdpXqXcg7i9RNQqSq3xl
	evWaWUkA9rmtOK3NukC8oyFjW5zklQxJ3NSOKK3QMXMqNTqsoXt1R186c75BtT/t9ydfH9k9Rfy47
	CG2kd7JA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSy-004duS-1Q;
	Fri, 24 Jul 2026 15:05:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:15 -0700
Subject: [PATCH net-next 7/9] netconsole: move egress_dev() as
 netcons_egress_dev()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-7-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4819; i=leitao@debian.org;
 h=from:subject:message-id; bh=0GT3H6luF68DLEJYuF2v8B2YQnks5PYIrQ6WewmJIUc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38e3Jt6sC1N3+oOagaxQbgMdNc0spH4kE81s
 gEJLlS/DOqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HgAKCRA1o5Of/Hh3
 bQ43EACcVZYkfYy7M5l88DK2ZDkJlY4QpEGlMBV23W5H8drQYXH6bSN/Ed/+42KhtFteufGvvAG
 yYyqB9WJEcirP4x5/o8NEKfLaR8b5oFdXUgRYNRWxBDv0cvzPqIo2yv0bxje259ua694drpky+C
 FVLAZuCapTIvU63/1k74eAgii4505SGP/rM2Uq1l4llFLVntmoFB+FwQiLUi0rxS5u/7/Yy32UZ
 LdI79OHHnl484YqX8xB6Q+QvZtBKW6O7qIR/rp7+DOftz76X1XUunjB3nVN/GAnXrQnFfGdUyj1
 MiwbwkwGPJqIjI/6xdhb4mnuXR2mYz2UA8+RvVfJT+1zgBZ+1oWdFPxN2pXsCq9UN31kzE3mg+a
 0E4xjzXvsJY92A+VgzIIoa537Dq4LFwdEnv7nF0rFiLy2/bgkP58oTipdXqknfK3KxL9Q91A7y+
 MxL56I9R5AN8MMC5DJAiBP/FrVEz0ioP9/u0pSC9f5LsION7QFyzWY3CEy0+yD03jVJV/ZBcB5o
 1AmzVcwCwQY7D+PQtHKMk/ueWTTyST0vasBcK2eJZrsOzx1DrmkUVvh6HEPrZL2G7XXD8xft6VS
 SHHQBeFfyr2oZQgVQOoxPZ2rcWqVVvt8SnZpOOO3gWJlG9cjbOPYsp0DNQCJ/LSUATRdwwWtlPk
 E/S1F+t14ItqBQw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

move egress_dev() from netpoll to netconsole, and append netcons_
prefix.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 30 +++++++++++++++++++++++-------
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 17 -----------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b6cbda4722d5b..fc575adc29bd7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -353,6 +353,22 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
+/*
+ * Returns a pointer to a string representation of the identifier used
+ * to select the egress interface for the given netpoll instance. buf
+ * is used to format np->dev_mac when np->dev_name is empty; bufsz must
+ * be at least MAC_ADDR_STR_LEN + 1 to fit the formatted MAC address
+ * and its NUL terminator.
+ */
+static char *netcons_egress_dev(struct netpoll *np, char *buf, size_t bufsz)
+{
+	if (np->dev_name[0])
+		return np->dev_name;
+
+	snprintf(buf, bufsz, "%pM", np->dev_mac);
+	return buf;
+}
+
 /*
  * Take the IPv6 from ndev and populate local_ip structure in netpoll
  */
@@ -364,7 +380,7 @@ static int netcons_take_ipv6(struct netpoll *np, struct net_device *ndev)
 
 	if (!IS_ENABLED(CONFIG_IPV6)) {
 		np_err(np, "IPv6 is not supported %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
+		       netcons_egress_dev(np, buf, sizeof(buf)));
 		return -EINVAL;
 	}
 
@@ -386,7 +402,7 @@ static int netcons_take_ipv6(struct netpoll *np, struct net_device *ndev)
 	}
 	if (err) {
 		np_err(np, "no IPv6 address for %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
+		       netcons_egress_dev(np, buf, sizeof(buf)));
 		return err;
 	}
 
@@ -406,14 +422,14 @@ static int netcons_take_ipv4(struct netpoll *np, struct net_device *ndev)
 	in_dev = __in_dev_get_rtnl(ndev);
 	if (!in_dev) {
 		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
+		       netcons_egress_dev(np, buf, sizeof(buf)));
 		return -EDESTADDRREQ;
 	}
 
 	ifa = rtnl_dereference(in_dev->ifa_list);
 	if (!ifa) {
 		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
+		       netcons_egress_dev(np, buf, sizeof(buf)));
 		return -EDESTADDRREQ;
 	}
 
@@ -456,7 +472,7 @@ static int netcons_netpoll_setup(struct netpoll *np)
 
 	if (!ndev) {
 		np_err(np, "%s doesn't exist, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
+		       netcons_egress_dev(np, buf, sizeof(buf)));
 		err = -ENODEV;
 		goto unlock;
 	}
@@ -464,14 +480,14 @@ static int netcons_netpoll_setup(struct netpoll *np)
 
 	if (netdev_master_upper_dev_get(ndev)) {
 		np_err(np, "%s is a slave device, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
+		       netcons_egress_dev(np, buf, sizeof(buf)));
 		err = -EBUSY;
 		goto put;
 	}
 
 	if (!netif_running(ndev)) {
 		np_info(np, "device %s not up yet, forcing it\n",
-			egress_dev(np, buf, sizeof(buf)));
+			netcons_egress_dev(np, buf, sizeof(buf)));
 
 		err = dev_open(ndev, NULL);
 		if (err) {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 7736339f9880e..dac8dc2529de0 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -73,7 +73,6 @@ netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
 unsigned int netpoll_get_carrier_timeout(void);
 void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev);
-char *egress_dev(struct netpoll *np, char *buf, size_t bufsz);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 246aa2bfd7805..f385ae4b70f5c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -392,23 +392,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
-/*
- * Returns a pointer to a string representation of the identifier used
- * to select the egress interface for the given netpoll instance. buf
- * is used to format np->dev_mac when np->dev_name is empty; bufsz must
- * be at least MAC_ADDR_STR_LEN + 1 to fit the formatted MAC address
- * and its NUL terminator.
- */
-char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
-{
-	if (np->dev_name[0])
-		return np->dev_name;
-
-	snprintf(buf, bufsz, "%pM", np->dev_mac);
-	return buf;
-}
-EXPORT_SYMBOL_GPL(egress_dev);
-
 void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
 {
 	unsigned long atmost;

-- 
2.53.0-Meta

