Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C32E06D2;
	Fri, 24 Jul 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905535; cv=none; b=FveJqeFgj19ZovicbEpzp2YY1fkWnrTRECRLlqY0Jm5WmVbKl+XB6aB/44SJJDPzxjdDFSHxUq27Mm1pj/p5utks+S4TcBCHpJCf1LVGTlbj+I4KWcKDYR6WKIINjWdaNaItxU/7/vpbxKYO3GXwMr/X4NUIYZs4hWShLV0WWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905535; c=relaxed/simple;
	bh=5NWr276nfsb9wy6M3mzvluqmgGsc9a7+js9/Cs1kgH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k16sMQhNlkkphhaZszFI5CZFgIiDavdj+Vyl9cqt4WNre5Mt+08+TfNZ7XeWtEUs432zgCSphks542K+VXP69nrcR1xvOstL41tX9fAXNRHwPS+2hL9Wj4v+uwV9CHcA1m88ui5usjkINudCz0LZtcDODLy6MuEd1oQ9LfDecMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QhzP7qAm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QhzP7qAm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=0UTvVrKvQbjV2z09c5HIhwKfNEpVhCVsdba1S1ijn7E=; b=QhzP7qAmhCRBJRWIBRUtZRfncZ
	0vNk1UcaKKKgQ8TWfjtU5uo5NBsNszCD/kXGsdOO7UBkTCM+MlOUUwKlB5uU03SGthvEyeR3ZKDfy
	lgMd3ib62N9rDULcMRM/pc+GL0TxdONRSsrc8ZQTx3GADHtdHylaio5FVFBxuhyo7k3HeZJjmtmkb
	L6D7UHJ7HLkwUgRF5RD087k/js9LuxumSgvdkg06o6pDnaFBv/gCH1j/Mr0osccL3RPAatqnD9FrN
	OK8zcQSZvshrfllcNAxyBxGhDe4iZV3lQ5tOexE4xyL+28CMXodBiudZrFDBVY+yKHymxUC8eR3dW
	Nz7567qg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSu-004duB-1u;
	Fri, 24 Jul 2026 15:05:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:14 -0700
Subject: [PATCH net-next 6/9] netconsole: move netpoll_take_ipv6() as
 netcons_take_ipv6()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-6-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; i=leitao@debian.org;
 h=from:subject:message-id; bh=5NWr276nfsb9wy6M3mzvluqmgGsc9a7+js9/Cs1kgH4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38eQMhOplqT7oNojJmVOaNgO5b0d2/cjSsHo
 wvhWcaWoOOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HgAKCRA1o5Of/Hh3
 bcg1EACHGr1Bfelbbnq1xYAcovUdbhas6OC35weclVb2Qi+2v2qi4Q6gFzARTudI5EyiM9fCbb8
 iDfpf8QibuItBWfs0gvVUZfEbM2KsIO1jDUuztt7dCur+gMS2it4NqZDlyBpA3om9pl8RMdY+3q
 cyAF73CIqGsfn5prs593We8QD3qrIEoRE9vFYcnajbVW11qy5N+89MC5sGbKWTX6/OTGrxmI+xy
 ilD2EniEZq272xDrp4ce4mMs1yDUOvMbERQSBPc8Yu+wWDw2Aflwn3Yet45AM8ElZwNC5vi37JX
 pOGCLTNHiE3c+K0qifPH0BEZ7IU1SeIwxGH6irtqDMvFJrxQl3B7Y4rx9pLYOfaaFoCI/avSZD8
 wHJA7ItyAhxedn+tqCZcHT/cpZh26IdfRbcBw1ZG17tt4H7y06hRCnbHlJJ/wxW6jgH1YnMkBn/
 11F7DuCabujpHvI+FjtkXk1eycW/chL3cugcdWxO7Y4tmE45VvIL0GDJ86JvQO1FnjZr+ta3Sy8
 df4Yb18DgE9Mz5vP5sxuJ3Kqi3gIUH5UqN06o+kHQRET5A8zi4htfIaXvft6d1c1xPSHQ6xU7xZ
 I4XnWxGDVA/e/kdmkHUozLQAFG9V1L8yLcokgM/e9CkTIaAaHH5x7t0tPF3UasIzxFigLfiV2qi
 5RmR1hn+jF+sGvg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move netpoll_take_ipv6() to netconsole, and add netcons_ prefix.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 42 ------------------------------------------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9506b1e1193fd..b6cbda4722d5b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -40,6 +40,7 @@
 #include <linux/inetdevice.h>
 #include <linux/unaligned.h>
 #include <net/ip6_checksum.h>
+#include <net/addrconf.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
 #include <linux/hex.h>
@@ -352,6 +353,47 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
+/*
+ * Take the IPv6 from ndev and populate local_ip structure in netpoll
+ */
+static int netcons_take_ipv6(struct netpoll *np, struct net_device *ndev)
+{
+	char buf[MAC_ADDR_STR_LEN + 1];
+	int err = -EDESTADDRREQ;
+	struct inet6_dev *idev;
+
+	if (!IS_ENABLED(CONFIG_IPV6)) {
+		np_err(np, "IPv6 is not supported %s, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
+		return -EINVAL;
+	}
+
+	idev = __in6_dev_get(ndev);
+	if (idev) {
+		struct inet6_ifaddr *ifp;
+
+		read_lock_bh(&idev->lock);
+		list_for_each_entry(ifp, &idev->addr_list, if_list) {
+			if (!!(ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) !=
+				!!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
+				continue;
+			/* Got the IP, let's return */
+			np->local_ip.in6 = ifp->addr;
+			err = 0;
+			break;
+		}
+		read_unlock_bh(&idev->lock);
+	}
+	if (err) {
+		np_err(np, "no IPv6 address for %s, aborting\n",
+		       egress_dev(np, buf, sizeof(buf)));
+		return err;
+	}
+
+	np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
+	return 0;
+}
+
 /*
  * Take the IPv4 from ndev and populate local_ip structure in netpoll
  */
@@ -448,7 +490,7 @@ static int netcons_netpoll_setup(struct netpoll *np)
 			if (err)
 				goto put;
 		} else {
-			err = netpoll_take_ipv6(np, ndev);
+			err = netcons_take_ipv6(np, ndev);
 			if (err)
 				goto put;
 		}
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index e212cb86a9429..7736339f9880e 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ void netpoll_zap_completion_queue(void);
 unsigned int netpoll_get_carrier_timeout(void);
 void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev);
 char *egress_dev(struct netpoll *np, char *buf, size_t bufsz);
-int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 60c3faf9ea944..246aa2bfd7805 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -424,48 +424,6 @@ void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(netpoll_wait_carrier);
 
-/*
- * Take the IPv6 from ndev and populate local_ip structure in netpoll
- */
-int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev)
-{
-	char buf[MAC_ADDR_STR_LEN + 1];
-	int err = -EDESTADDRREQ;
-	struct inet6_dev *idev;
-
-	if (!IS_ENABLED(CONFIG_IPV6)) {
-		np_err(np, "IPv6 is not supported %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
-		return -EINVAL;
-	}
-
-	idev = __in6_dev_get(ndev);
-	if (idev) {
-		struct inet6_ifaddr *ifp;
-
-		read_lock_bh(&idev->lock);
-		list_for_each_entry(ifp, &idev->addr_list, if_list) {
-			if (!!(ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) !=
-				!!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
-				continue;
-			/* Got the IP, let's return */
-			np->local_ip.in6 = ifp->addr;
-			err = 0;
-			break;
-		}
-		read_unlock_bh(&idev->lock);
-	}
-	if (err) {
-		np_err(np, "no IPv6 address for %s, aborting\n",
-		       egress_dev(np, buf, sizeof(buf)));
-		return err;
-	}
-
-	np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(netpoll_take_ipv6);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.53.0-Meta

