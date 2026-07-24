Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38811363C45;
	Fri, 24 Jul 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905520; cv=none; b=WF10cryAUAP97HA9XkIquG2DQb++zxPxOkZoVXR/TFHb58vrWIeWGo3LD0TQ3ym8O7nkJ+MN2AwjeulJtU+56tmijwTAYsy5EumL0uujblUk/sDk1DS7X6pAwk8EqtsjVrsS80F7moOjJ3xI41ZpUfp0hrx/NrqmnFfmVLSU0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905520; c=relaxed/simple;
	bh=xIVIdSWc3BSexOmpReadWo0F5PUNZbkIdaCjbZ12ONw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cp3OLyhDMMPsztK2xm7lTgtNCp/U/kuuOv0phkjIIRyZoUnwtimG6qPQmI3MFVlxhU5Hj2jbzBqfnNk5CqJleSrIEl4YhWPU9G2pS9x2zkJftWA4rPgF34CVFhwTRrnKnaw3q/gFeW5mw/ezAExtcdMmiKTAHwR5ihXFg9xXMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rRmIKpLj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rRmIKpLj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=EecT0FwLtdnkZ4RlJ1mzXRtA09QjugI2L2Nqcry/6OM=; b=rRmIKpLje7+iROgBGpzg+j5gEG
	UIKD+pc31IFGVDNLnKYTxbTuXmtgGdqlcmtsWEq7VVXlPOjv0IfbsEMcQ7bg3OzIsMRpOAGCyfpxS
	DbjVjgJp55T6uNBwINeAnr2xrj7DEtaPmScGqWdJPVrCmcsF2d3o4NOqkzC/RMn7uwgXPz3nWYjyG
	H7HBtDJgIkloXL/PAaFNoyjpJpJMWgd5Zctwzgou7tjweIs4ErFYn4crPB9BaiBUkTxBACQWab+Ts
	95KUXZ4u5mxNaSHYE2QHCOgNYvurj0LXwYNoDN5DxHzi9lel2Hengg5BJIno2xFIwxLQze2ey47md
	1GcXsTHw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSY-004dt4-2O;
	Fri, 24 Jul 2026 15:05:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:09 -0700
Subject: [PATCH net-next 1/9] netpoll: export carrier_timeout via
 netpoll_get_carrier_timeout()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-netconsole_move_more_final-v1-1-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=leitao@debian.org;
 h=from:subject:message-id; bh=xIVIdSWc3BSexOmpReadWo0F5PUNZbkIdaCjbZ12ONw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38dI/vd0UNaqPWul/C/0DKzOH0nqzyoSZuUe
 5K1CKlBfyqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HQAKCRA1o5Of/Hh3
 bZH9EACTPA61Lgahk2wU3J8w/fWCWaL6mnMpU6xoJJmCO/Lwl0HkFXsRnN21daFVAjc6zR9UhVP
 tW/AmoK8slWf9DurdP8TqmFNc8mcORs9PtX/MKES0IOi7+vzXnzMN7DHEK6D6R3m1GLykPoTYaE
 5x94UwQBj73xgoQ6dNWj2kPmsBFsQltdSm5El9fS5ozzPOfkipMSawU0JedcRP+EJ3bLi7ewOIT
 sZ4sAzNdjR7XP53QcFT2fZ+gWmggOiV8EwOrDy7lcmpCEQ/N5TjZZhDZy10bavT2HU8pGoYqO39
 LIG74z3vWF0c4NzmZybmIGl547wiqt78Z8HHqIDZkEz2cEaFs7MkrldbFiUSD1Ifh/ApTU8bhep
 RlLgK06shMWwC5X36CZw6W/1mAg9i4XEAqNovo0Vv8m9hgKWy+ezT7MQKbGZ/lMTqYExIsi0549
 QrxkwH19A+6mtfg2SYsIQ9wm6jYJW5k9yqllJmcfu85xjSO4kDkmHpLoNQXIFxDpgpdrjEtq6JW
 +tJaHyU3KO0JOt4+7elodhHLSIc+tCAfiH45YxZJE7WOBiYyTJtPIMG6QGnzNt0MxgTShV9j6FH
 YuG8Xqh/3ytO6Oeeq45FnHf3EGUqVgtdr1QJb+Zzw8IjXKlBekokA/3u7HNJ15Lqh1UYfQ6fTJF
 WpFnpGul5rCRRvQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

netpoll_wait_carrier() is only used in netconsole, and it will move to
netconsole.

The carrier_timeout module parameter has to stay in netpoll so the
existing netpoll.carrier_timeout kernel parameter keeps working for
current users, and we don't break user compatibility.

Add a netpoll_get_carrier_timeout() accessor and export it so netconsole
can read the value once the carrier wait lives there. Drop the now
redundant timeout argument from netpoll_wait_carrier() (its only caller
passed carrier_timeout) and read the parameter directly while the helper
still lives here.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 79315461a7b1e..d426d1844cac7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -72,6 +72,7 @@ void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 void netpoll_zap_completion_queue(void);
+unsigned int netpoll_get_carrier_timeout(void);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index f8da1048ea3ab..9b9fcc307958f 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -38,9 +38,20 @@
 
 #define USEC_PER_POLL	50
 
+/*
+ * carrier_timeout is netconsole-specific and only kept here to preserve the
+ * netpoll.carrier_timeout module-parameter ABI. Its value is exposed to
+ * netconsole through netpoll_get_carrier_timeout().
+ */
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
+unsigned int netpoll_get_carrier_timeout(void)
+{
+	return carrier_timeout;
+}
+EXPORT_SYMBOL_GPL(netpoll_get_carrier_timeout);
+
 static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev,
 				      struct netdev_queue *txq)
@@ -397,12 +408,11 @@ static char *egress_dev(struct netpoll *np, char *buf, size_t bufsz)
 	return buf;
 }
 
-static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev,
-				 unsigned int timeout)
+static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev)
 {
 	unsigned long atmost;
 
-	atmost = jiffies + timeout * HZ;
+	atmost = jiffies + carrier_timeout * HZ;
 	while (!netif_carrier_ok(ndev)) {
 		if (time_after(jiffies, atmost)) {
 			np_notice(np, "timeout waiting for carrier\n");
@@ -539,7 +549,7 @@ int netpoll_setup(struct netpoll *np)
 		}
 
 		rtnl_unlock();
-		netpoll_wait_carrier(np, ndev, carrier_timeout);
+		netpoll_wait_carrier(np, ndev);
 		rtnl_lock();
 	}
 

-- 
2.53.0-Meta

