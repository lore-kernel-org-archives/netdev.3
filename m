Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C23B429033;
	Fri, 24 Jul 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905523; cv=none; b=hV3aCsPj3yhiGX715ncxvCXRJAV9GyRpq1/hbupTGfn5CS1S5WQRPZpwksoMvaSK7bcNGZphRfEySriucBl7mSWhYCB/LLFuZyx3gK7iKajs+cl8wnnn02MLJiXQzueVeIyg6gfWUbXNuHXOmhkMgkMh3JY687QtwOQZF78iJ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905523; c=relaxed/simple;
	bh=VOPTipKWdZmNLCeCt2EtDxonf9hu30SBjbEAgCTbvDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkNiPwlEFvFxONTyRz2912FTXmigtVL8dCwE8XMX/oPcbO6Mg5Yhku/n0Vbkab7Q0qbnfYxOtRz8XXQdPedBZfXlj1GmdV7HGwUjJXMoKxnul0pApsqhn9GnhG5TcnILbI2mZAcgIFXxPyVlR6Gc8C14lfhp5VNUf41wW/Vp51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tlDmh3oc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tlDmh3oc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=fPHxL9ALCAXwk4u1NC60Vd+u61c1JjzYmBT2Ma0qfLo=; b=tlDmh3ocVBj8YegN6Sw+4Ej5SK
	PZWU6y3HAZno14j8cwORKXItkEvVQcUFXKJ14J8rCwbolXgn7zM7qoGhzvlBVTDBRQe99Wm0vYbGh
	0Nlc8UoAzsqdlZVNoUDSpJAfyaujVUQZ+Cg5TB4oPYsUDm1MKPxVQZ9iXZKlsmxHIYjZYFRQy7lOQ
	bXvDUTZc3M6vC2CfqgC3H6H+s4WVNsXCNUpy2H40GZzBQO9yrBBeAa58BycUHcLtqMGqVinfWScWn
	mk2q5gizGSsEO/1+Mji8VrvUMs3F5k/aEXiiH6GpXvZ/Lh6KJa2ZQO3RAud+6f8mo0s59sgphbK1n
	XLKogFfg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSg-004dtS-2h;
	Fri, 24 Jul 2026 15:05:19 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:11 -0700
Subject: [PATCH net-next 3/9] netconsole: take over netpoll_setup() from
 netpoll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-3-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6656; i=leitao@debian.org;
 h=from:subject:message-id; bh=VOPTipKWdZmNLCeCt2EtDxonf9hu30SBjbEAgCTbvDI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38dImdPpmDDVva8tFxX2WcsPlY+0JVfbPoZ7
 bM+gbsK1/eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HQAKCRA1o5Of/Hh3
 bY2ND/9BulVt6dSxt1UDGYOf4xb10IgUMFD/jCFx5gV4rbgKyS9vU+qJ0YoRub7LffAjHsymiGY
 mxV2o2v39imleGOJ7gPNxE8ZVQEoWcYQOmXaKlfko40J1kQCp0bqWkWGBkjYQmoRV0BGjCZNWJL
 EO4x0OsMf//vggMKSeTYi36HLpDnuqMn1C8lahYvFkv7vS5RR2VS/WzCHzGYdhbemZCaWu1lnOO
 GZmFaNECDS8ipMFnHLXhUq24po1vaLnN/kawk5800VJSstOCsJbzD1/ONEPXBdgOeH56ETlmFsE
 I80L9xtK8zdufzS2amlZ4m4bolue2QMnvPRGyOrvasbJXws/9hHlfFVcnTJPTBBzIyltMjMOJkN
 YoTlpIyMGjJ2Ns4P+fg39WkonFsd6Ht7PcWjaxa9BJvfwD2aCkwnkGJAopWNS8VDZBD8ab9a59h
 z8Fc8OJzEGZpJ93OFCPL/P6er7vf7eUlixOOwq4C5ICI+AJMX8hRjQvKn2JEy5y8CTnBFZX3+MM
 b584Lsz/iAe0G0Wk1BgKKRoRZa7B0n4Zv18aRiTrjVIQM5U/2dk6V8tjAd1qQl0tSiA6HTJO9X6
 z2QFSTxs56VFQ5EhdEa5xAgYCzhEakQKPROPrCYS5jxd9hnc3SWhDBZqBtuvMQA+Q/Fin1ys5rn
 BUQCsy2sYH+R6hA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

netpoll_setup() is only used by netconsole. All the other users use
__netpoll_setup().

Move netpoll_setup() to netconsole, and rename it to
netcons_netpoll_setup().

Pure code motion: the body is unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 81 ---------------------------------------------
 3 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7f8851a734fcd..3a7a2cafc6276 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -351,6 +351,86 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
+static int netcons_netpoll_setup(struct netpoll *np)
+{
+	struct net *net = current->nsproxy->net_ns;
+	char buf[MAC_ADDR_STR_LEN + 1];
+	struct net_device *ndev = NULL;
+	bool ip_overwritten = false;
+	int err;
+
+	rtnl_lock();
+	if (np->dev_name[0])
+		ndev = __dev_get_by_name(net, np->dev_name);
+	else if (is_valid_ether_addr(np->dev_mac))
+		ndev = dev_getbyhwaddr(net, ARPHRD_ETHER, np->dev_mac);
+
+	if (!ndev) {
+		np_err(np, "%s doesn't exist, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
+		err = -ENODEV;
+		goto unlock;
+	}
+	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
+
+	if (netdev_master_upper_dev_get(ndev)) {
+		np_err(np, "%s is a slave device, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
+		err = -EBUSY;
+		goto put;
+	}
+
+	if (!netif_running(ndev)) {
+		np_info(np, "device %s not up yet, forcing it\n",
+			egress_dev(np, buf, sizeof(buf)));
+
+		err = dev_open(ndev, NULL);
+		if (err) {
+			np_err(np, "failed to open %s\n", ndev->name);
+			goto put;
+		}
+
+		rtnl_unlock();
+		netpoll_wait_carrier(np, ndev);
+		rtnl_lock();
+	}
+
+	if (netpoll_local_ip_unset(np)) {
+		if (!np->ipv6) {
+			err = netpoll_take_ipv4(np, ndev);
+			if (err)
+				goto put;
+		} else {
+			err = netpoll_take_ipv6(np, ndev);
+			if (err)
+				goto put;
+		}
+		ip_overwritten = true;
+	}
+
+	err = __netpoll_setup(np, ndev);
+	if (err)
+		goto put;
+	rtnl_unlock();
+
+	/* Make sure all NAPI polls which started before dev->npinfo
+	 * was visible have exited before we start calling NAPI poll.
+	 * NAPI skips locking if dev->npinfo is NULL.
+	 */
+	synchronize_rcu();
+
+	return 0;
+
+put:
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
+	if (ip_overwritten)
+		memset(&np->local_ip, 0, sizeof(np->local_ip));
+	netdev_put(ndev, &np->dev_tracker);
+unlock:
+	rtnl_unlock();
+	return err;
+}
+
 /* Attempts to resume logging to a deactivated target. */
 static void resume_target(struct netconsole_target *nt)
 {
@@ -361,7 +441,7 @@ static void resume_target(struct netconsole_target *nt)
 	 */
 	netconsole_skb_pool_init(nt);
 
-	if (netpoll_setup(&nt->np)) {
+	if (netcons_netpoll_setup(&nt->np)) {
 		/* netpoll fails setup once, do not try again. */
 		netconsole_skb_pool_flush(nt);
 		nt->state = STATE_DISABLED;
@@ -840,7 +920,7 @@ static ssize_t enabled_store(struct config_item *item,
 		 */
 		netconsole_skb_pool_init(nt);
 
-		ret = netpoll_setup(&nt->np);
+		ret = netcons_netpoll_setup(&nt->np);
 		if (ret) {
 			netconsole_skb_pool_flush(nt);
 			goto out_unlock;
@@ -2430,7 +2510,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	 */
 	netconsole_skb_pool_init(nt);
 
-	err = netpoll_setup(&nt->np);
+	err = netcons_netpoll_setup(&nt->np);
 	if (err) {
 		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
 		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 0877515fa7442..cd455a5a013d2 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -66,7 +66,6 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
-int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 6a545063223ba..d50d48a82def6 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -514,87 +514,6 @@ bool netpoll_local_ip_unset(const struct netpoll *np)
 }
 EXPORT_SYMBOL_GPL(netpoll_local_ip_unset);
 
-int netpoll_setup(struct netpoll *np)
-{
-	struct net *net = current->nsproxy->net_ns;
-	char buf[MAC_ADDR_STR_LEN + 1];
-	struct net_device *ndev = NULL;
-	bool ip_overwritten = false;
-	int err;
-
-	rtnl_lock();
-	if (np->dev_name[0])
-		ndev = __dev_get_by_name(net, np->dev_name);
-	else if (is_valid_ether_addr(np->dev_mac))
-		ndev = dev_getbyhwaddr(net, ARPHRD_ETHER, np->dev_mac);
-
-	if (!ndev) {
-		np_err(np, "%s doesn't exist, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
-		err = -ENODEV;
-		goto unlock;
-	}
-	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
-
-	if (netdev_master_upper_dev_get(ndev)) {
-		np_err(np, "%s is a slave device, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
-		err = -EBUSY;
-		goto put;
-	}
-
-	if (!netif_running(ndev)) {
-		np_info(np, "device %s not up yet, forcing it\n",
-			egress_dev(np, buf, sizeof(buf)));
-
-		err = dev_open(ndev, NULL);
-		if (err) {
-			np_err(np, "failed to open %s\n", ndev->name);
-			goto put;
-		}
-
-		rtnl_unlock();
-		netpoll_wait_carrier(np, ndev);
-		rtnl_lock();
-	}
-
-	if (netpoll_local_ip_unset(np)) {
-		if (!np->ipv6) {
-			err = netpoll_take_ipv4(np, ndev);
-			if (err)
-				goto put;
-		} else {
-			err = netpoll_take_ipv6(np, ndev);
-			if (err)
-				goto put;
-		}
-		ip_overwritten = true;
-	}
-
-	err = __netpoll_setup(np, ndev);
-	if (err)
-		goto put;
-	rtnl_unlock();
-
-	/* Make sure all NAPI polls which started before dev->npinfo
-	 * was visible have exited before we start calling NAPI poll.
-	 * NAPI skips locking if dev->npinfo is NULL.
-	 */
-	synchronize_rcu();
-
-	return 0;
-
-put:
-	DEBUG_NET_WARN_ON_ONCE(np->dev);
-	if (ip_overwritten)
-		memset(&np->local_ip, 0, sizeof(np->local_ip));
-	netdev_put(ndev, &np->dev_tracker);
-unlock:
-	rtnl_unlock();
-	return err;
-}
-EXPORT_SYMBOL(netpoll_setup);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.53.0-Meta

