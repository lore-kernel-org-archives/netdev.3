Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940F3FF8BD;
	Fri, 24 Jul 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905548; cv=none; b=caisosJ1nuR0PFpMsAFIukrHDvPXBf0M9CDTwPU5ZBMKeC1yqXmOGQObo/f3Egct2nunLOR4bXIC4Q0a9SC/sVi4bj4YwGyCze5ZFHNsXb/9xkfsqWJWgcvUC7jIiSBRF+2d5CVrPOZEmB599IKIS4hVoRFbfUizNPn1rCjA4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905548; c=relaxed/simple;
	bh=+A8B0JPSmD/xUyC+pYs2LiOcJ/XUtyBFB0JYHXAm1MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qqj3kdHyUZG3L0Ujzcl4zUuHq6VPe134JhszKC0wwa8FtDRXMeV3Rv11x68CV04qv4zFWm9lfr+cUm5EQh03Uy9HJiGd87uLZY7JpRPYBK6P6r5SrnaeQ1Hv6sopwbQFcjewtQOWHELYtgaYvNk7Fk01B3TY/U8kOJ/+1LyOL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=T3cVR16e; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="T3cVR16e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=lv/c+QRGRLtWRpVznQafej5v9W18F2xyE1OZZGHaCVg=; b=T3cVR16e1Gru5GfYXPU98uH7Yw
	eeygEj8Wj0xF2dSkfBkXUHMgXP0oSF1a97ZJGRt6EDWN1PTY49eV2Jo/mVRIeTPQFtzFOpPXr9DXW
	v/AHk1Q3F+ADJzquM4wMGjMfJ2BEkdG9mQo+aIGyP+NlyYbjhLuz/P23rlkSvrjnvYsqMwzEYuc/4
	dMMfTyN03bGlB1hFehkBAvAHM3IsnS763vfavgIT75l/gc27Wqre96ppVEL8cavTo9249BA288Y6g
	7KZRQs8/Ks8WLxgC0f6AqWmNMFNYNC8Z78TEZXccKH9GVHxRZ0GQv91UATsCvsk1sykxpHH9+BBbw
	BEKPkOxA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHT6-004dvE-1x;
	Fri, 24 Jul 2026 15:05:44 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:17 -0700
Subject: [PATCH net-next 9/9] netconsole: move netpoll_wait_carrier() as
 netcons_wait_carrier()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-9-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3360; i=leitao@debian.org;
 h=from:subject:message-id; bh=+A8B0JPSmD/xUyC+pYs2LiOcJ/XUtyBFB0JYHXAm1MQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38evC/p7PSLCmKg+KA8GeI40lbdTs3SyQCcO
 tzwUg9d5iuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HgAKCRA1o5Of/Hh3
 bWWWD/0f837U/WtUTf+1lifEKya6uv/6rvbOlgxHyN89bxp5aGjVRT+Qr4nO+UW1it235G9muFl
 ZtC1BbLPmJ84lBcxWllGf5pafDhG4qgklm8nbnyv/Ww11JJnDIXvVG4dK1Y5TA5ADCIyPWYUD4a
 5XzS62MDANo0S4Uz+f8cPcEDZvvYODP0QDLXZPaCy33L3kvyBceIBGjBb/07w8B8tn2LdbETQuJ
 uZv+m2BWmgA54OAi85V22wfslfuqMp4ufOc4bBzrlJZFsW9V6QUhz+hwkwex6tlR6CMf0/qte54
 CMJisqDW0BiazmMhloBIaDOExnXaoSPQB9uQaP3NcRL1fKE32konzkY2rjrVUMad7v5IKbNTdV4
 oGvfxl50liP/h+TK0gEekV8jA0e/jwNogCep5r7hf5oTEwX1QmHr6ks8IsJOTkXPUIqB4K/lSOO
 TrnTQxcSPME7IdOzLJqpTuFizjNpA0y3VPyHRLkRPQeq7SmxikEoVnZfbCIpBLWj4zBjunUUtGg
 Jls0BaNRnsxQN00ZZtfF2yEcr+EXng7lkAGlVjK0Uk/6gvK1UozljIv/OmWkGytKwCquUKMs2O3
 OF9Vt3GT4tNadcrzbn+P+1km/SYLvjZ5jQjtnZYXrbQeKT6gjqrd8v5aMZVtGos34R7ba0Kcuej
 EU5tVcgzZjqZVKw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

netpoll_wait_carrier() waits for the egress device carrier during
netconsole setup. Its only caller, netcons_netpoll_setup(), already
lives in netconsole. Move the function into drivers/net/netconsole.c,
drop EXPORT_SYMBOL_GPL() and remove the prototype from <linux/netpoll.h>.

Rename it to netcons_wait_carrier() for the netcons_ prefix. It now reads
the timeout through netpoll_get_carrier_timeout(), since carrier_timeout
stays in netpoll to keep the netpoll.carrier_timeout parameter.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 17 ++++++++++++++++-
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 15 ---------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 199d0e1ac17b2..03913302328cc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -48,6 +48,7 @@
 #include <linux/utsname.h>
 #include <linux/rtnetlink.h>
 #include <linux/workqueue.h>
+#include <linux/delay.h>
 
 MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -356,6 +357,20 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
+static void netcons_wait_carrier(struct netpoll *np, struct net_device *ndev)
+{
+	unsigned long atmost;
+
+	atmost = jiffies + netpoll_get_carrier_timeout() * HZ;
+	while (!netif_carrier_ok(ndev)) {
+		if (time_after(jiffies, atmost)) {
+			np_notice(np, "timeout waiting for carrier\n");
+			break;
+		}
+		msleep(1);
+	}
+}
+
 /*
  * Returns a pointer to a string representation of the identifier used
  * to select the egress interface for the given netpoll instance. buf
@@ -504,7 +519,7 @@ static int netcons_netpoll_setup(struct netconsole_target *nt)
 		}
 
 		rtnl_unlock();
-		netpoll_wait_carrier(np, ndev);
+		netcons_wait_carrier(np, ndev);
 		rtnl_lock();
 	}
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index ef88a30b11f40..1c6b1eec5efd6 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,7 +69,6 @@ void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
 unsigned int netpoll_get_carrier_timeout(void);
-void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index f385ae4b70f5c..fe1e0cda5d6bf 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -392,21 +392,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
-void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
-{
-	unsigned long atmost;
-
-	atmost = jiffies + carrier_timeout * HZ;
-	while (!netif_carrier_ok(ndev)) {
-		if (time_after(jiffies, atmost)) {
-			np_notice(np, "timeout waiting for carrier\n");
-			break;
-		}
-		msleep(1);
-	}
-}
-EXPORT_SYMBOL_GPL(netpoll_wait_carrier);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.53.0-Meta

