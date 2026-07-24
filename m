Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D32E06D2;
	Fri, 24 Jul 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905531; cv=none; b=rUlKIuhnbAKuayt2V1fAIlnqr1NmaeJXPWHCgPMwu67DGIztqcH4ASBj9zmEt4E5m+8puDiVrp51fDGlAUnNfnEeB7FDR1Lq+fBKQrqg9HbxQASOObmy6JLscrONlQFkkQ+YfazWbhHFUYIsAA/Q4SXssndmNg9O7VBoVS30Cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905531; c=relaxed/simple;
	bh=mlDY/zX2KTie5pzo4FqkW9q27O9eKpjbY7m3QfH26SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzrPGc+r5mhKJiaBvId3Q+Qxy9rba6qarlRo+bIpTGbZVHMPWuIYVugMomkIJ5318no+Xy8PWdH9Fc1b9PBViM0GwE28moTv5NljfDRIanSv8ax2PMirtGcGv4wRKhDzQ5YDw7URH/l+oXfjQLsZp41RsoslWEyq8tnsRmzjGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CCoHBQ0y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CCoHBQ0y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=x95ozE6vlaiEbH/s1wIisxnuJ0Bxj6JFRSh9n0PbKN4=; b=CCoHBQ0ya9YAtB7G6xPNP4iGKF
	/S/Fw6pgfIJZUjE41uKSnPhkvQGXqD+FRwL0b3wAsV6iPrwMFPKdX4/mhb9d64VIh6gHAVjoeXqOl
	/kk1WSxmfCw25zR/AzG1wgEuuj2DGUqV3vqoWpKrrvE2Qw43MkwLqdMpFmZ3ZtmnyZog0OkUqInh0
	Pgezj6NCNuzIwMM/LG74mOyDaCQZ3o+CeLyboN5XbR0JAZbt14CRPTXi5FQzAcKu94I7f2heCfDQR
	25rN36POsBffcvycgmzUUl+jI/i7RMRiF8l2vVzedlAdaE05N/JzRrkXO5WNwkh7IYR73f6MXafmK
	1AF3oqjA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSo-004dtq-2q;
	Fri, 24 Jul 2026 15:05:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:13 -0700
Subject: [PATCH net-next 5/9] netconsole: move netpoll_take_ipv4() as
 netcons_take_ipv4()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-5-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3903; i=leitao@debian.org;
 h=from:subject:message-id; bh=mlDY/zX2KTie5pzo4FqkW9q27O9eKpjbY7m3QfH26SI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38e1nUf/pYpF31wSiMV9NPzjcXQyUGnLkXoX
 TVBstdv9piJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HgAKCRA1o5Of/Hh3
 bSPYD/48+GyqUWq4wGPfVCbI3V4Z+sYISs5Z3XyCfiJhgqwe5rNi/X4PsVKETiUw1S8hT4Tu8ON
 OER0Ge0zswFnlNBGRJrIkp+QVjpvFb8XpHUIrT7cRF1MORmd84CvK44JZX311Zse2uqIjqH50OV
 5AW7IMtSTROmkDKKvMdLU3EcvO0yizHUgW2uXlTu1+SAUWkFKky/VHoveGabTwbz1tWQkPYjYVt
 yZ/zRk49c8YsN8up7I65cwYREMCK3HwxcpzUKcdFixo65TdcpgvDaQglY4Hze1JprcGtv6rqm58
 hTrFFulccsm0Ykp221gbMx8QhiGYZE6mAuhHlIHVrfVqO/LpFkPHZlcxXVTD3DriGXy46yL0Df9
 jaND5XWfb9u3ZKBeYfWLfZj+jGwMe9jTlnfi5jbxs7n7SFVFbWyck+BULmxcOTyEbRz+l8PI13X
 p6CZ2PRRxGxSl5+Inv+dFkpbwbYIwrt0Q3/JXroozfVgeoakfRWwp8YzK4jY/zP5MHf0YKb8A67
 uzNACu79E/QG5K5/Pv9LAcHsyHvAO3aM64bcoID9NUUNyjpScXzBaUVMaLuAJRtsbjqWm4sl4ls
 dc5ug7xtgH930QGN33d0+hdqCD3j0aGZS32TrGwaTtkExEHyrf+y/xk7KUOABVVDLFqL2YzHKFL
 /G5J8zJs1VpL+Ow==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move netpoll_take_ipv4() to netconsole, which is the only user. Rename
it to netcons_take_ipv4() for the netcons_ prefix. The body is
unchanged.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 30 ------------------------------
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 70f9c5bfb3720..9506b1e1193fd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -37,6 +37,7 @@
 #include <linux/udp.h>
 #include <linux/netpoll.h>
 #include <linux/inet.h>
+#include <linux/inetdevice.h>
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
 #include <linux/configfs.h>
@@ -351,6 +352,35 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
+/*
+ * Take the IPv4 from ndev and populate local_ip structure in netpoll
+ */
+static int netcons_take_ipv4(struct netpoll *np, struct net_device *ndev)
+{
+	char buf[MAC_ADDR_STR_LEN + 1];
+	const struct in_ifaddr *ifa;
+	struct in_device *in_dev;
+
+	in_dev = __in_dev_get_rtnl(ndev);
+	if (!in_dev) {
+		np_err(np, "no IP address for %s, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
+		return -EDESTADDRREQ;
+	}
+
+	ifa = rtnl_dereference(in_dev->ifa_list);
+	if (!ifa) {
+		np_err(np, "no IP address for %s, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
+		return -EDESTADDRREQ;
+	}
+
+	np->local_ip.ip = ifa->ifa_local;
+	np_info(np, "local IP %pI4\n", &np->local_ip.ip);
+
+	return 0;
+}
+
 /*
  * Test whether the caller left np->local_ip unset, so that
  * netcons_netpoll_setup() should auto-populate it from the egress device.
@@ -414,7 +444,7 @@ static int netcons_netpoll_setup(struct netpoll *np)
 
 	if (netcons_local_ip_unset(np)) {
 		if (!np->ipv6) {
-			err = netpoll_take_ipv4(np, ndev);
+			err = netcons_take_ipv4(np, ndev);
 			if (err)
 				goto put;
 		} else {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index da05884f876e5..e212cb86a9429 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ void netpoll_zap_completion_queue(void);
 unsigned int netpoll_get_carrier_timeout(void);
 void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev);
 char *egress_dev(struct netpoll *np, char *buf, size_t bufsz);
-int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev);
 int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index f4b110cb04167..60c3faf9ea944 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -466,36 +466,6 @@ int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(netpoll_take_ipv6);
 
-/*
- * Take the IPv4 from ndev and populate local_ip structure in netpoll
- */
-int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
-{
-	char buf[MAC_ADDR_STR_LEN + 1];
-	const struct in_ifaddr *ifa;
-	struct in_device *in_dev;
-
-	in_dev = __in_dev_get_rtnl(ndev);
-	if (!in_dev) {
-		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
-		return -EDESTADDRREQ;
-	}
-
-	ifa = rtnl_dereference(in_dev->ifa_list);
-	if (!ifa) {
-		np_err(np, "no IP address for %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
-		return -EDESTADDRREQ;
-	}
-
-	np->local_ip.ip = ifa->ifa_local;
-	np_info(np, "local IP %pI4\n", &np->local_ip.ip);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(netpoll_take_ipv4);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.53.0-Meta

