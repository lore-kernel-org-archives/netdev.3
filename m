Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42B43BDC4;
	Fri, 24 Jul 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905526; cv=none; b=SYmxcLK5fWRZW1Ey1lQzd7+OkPJ9TCImh/0YewqtkF+J2dBpELOERqe76s92uNFyEwucJNRNYMJYDsS0O4jEAPSO4587DnwunhSHdM0mXIOuk7xUKJFcPvttri29Ia15WU3pmqFKEj2/IQFSlXrmTX9a7rI7n5SO8ftR3uFz+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905526; c=relaxed/simple;
	bh=PXM6xACVe72wHAS9AnEVwHbRC8VG1MH+vuha361yWjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oK+P9ReUcYw7zKvA5OnW7Evt0OB15G+PT6fD6dCG6QjU3hFlZoAX5a99gBFe2rY2Yqez+vp0zdLXI5hIRITAB8QKkWiYd6rx+dFhOi/tq1/e9NTxTje3qpX+wAZXswl1jrE5OYwWGekCbPRG3+ulIsXGW+eHmxKiRfeY5vzk5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HTKqvM/j; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HTKqvM/j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=HZWqqFB/sG9Ou+CAjbWms+SU/vlkUbbTXOQBwjRIFNg=; b=HTKqvM/jDFikVwX0Hao7HJjeQN
	M6SagyVKdM5VcjE9mEB34riMWYTFSYVUd25UfRnpcjLLuxiShhQHuyWNnvySlDdadLoeBj47KI5Hn
	R3U8ryu6btpr/ockJqVJPE8hWUnjH04qkXh/nO/5fybVssBNYyVq3Px+ssGlNgxPsmgtUbm39sK7d
	YfYKf21JfR1gqh89xvW3e58vN9smzQ23JEDjOtPfGT4ylwBBTiMeHjG3KC6c/0fSzWFAygdgjyDjv
	wg6i1dnj9XG7OdndaDKhEDU5DW398+3Fdv8K5LCMY7PiM1SnM9dBTchv224KDT95jZKi1/xD/Uq1x
	Y6Qh3iTg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wnHSl-004dtd-08;
	Fri, 24 Jul 2026 15:05:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jul 2026 08:04:12 -0700
Subject: [PATCH net-next 4/9] netconsole: move netpoll_local_ip_unset() as
 netcons_local_ip_unset()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-netconsole_move_more_final-v1-4-a5f7691db81c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3526; i=leitao@debian.org;
 h=from:subject:message-id; bh=PXM6xACVe72wHAS9AnEVwHbRC8VG1MH+vuha361yWjw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqY38dCqbrinbRGp2eyCaKGnpGumbBIaayOGbcY
 eVb1gg6yUqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamN/HQAKCRA1o5Of/Hh3
 bchLEACgVluok5U1WLxHeCaJZHI0p8xshPzI68dm63DqNNJH9/ifMfwGE6Re7a0ZBprzvaNCMvo
 LEcud3//B+X5pqlQs1kjKuzb94UurSEubi/CIw13cR0ZaIaVfK56dRaHKRgpTg0uYXN1R7ic6Sf
 5UzUM/D9MhMNZSQ1tFr7KMbqnY0rF0pGXu650BVJX33fkY53A7WHR4X6mDtWhwTgUf7Slkuasld
 w0GP0VASN8vKwb22k9a4FJXHEgtdE7i2SF2nGcGja2eVG7141NBDnF8KWPVxEqMFzjw+MDe1bDM
 UN8CYyb7m/ELkV1k3rqR8oNlBdkvDG41Qm3NHk2JVwsIuLO7Ic/XU6ufQ+2CbK9D/VR3SE8cqsi
 XDq6FrdZlCpW1IJBNB+8i+4YBpomtv2/a7m5Wzs2DSpik64Xx4QkV0ksFn8/xdHKiLxXVUv/+6e
 vz2i5CdzpfQPY7HGDvoI9/JdPpWdnKe01UZvQ6JFOn9hZS7HKX9/mutN5X2HFks6H0Fv9Epaysr
 PUbVpTbr8d6N6BWG8CLX7oRNFyXMlCFkT1gI9Uk8mXKdBceCVjVtuNUW4qQOaNJrB2vUwuuWeDI
 x3SYg3Rn+Or66QpB4BeH/WDA2fGuOyfaxhrOrGEXCdttAjPA0DWMvgoF6J+sxlc7nJa4TihrRCA
 ndTrTly0kxTv4vQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move netpoll_local_ip_unset() from netpoll to netconsole and rename it
to netcons_local_ip_unset();

The body is otherwise unchanged, only the comment's setup-function
reference is updated.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 19 ++++++++++++++++++-
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 18 ------------------
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3a7a2cafc6276..70f9c5bfb3720 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -351,6 +351,23 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
 	skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
 }
 
+/*
+ * Test whether the caller left np->local_ip unset, so that
+ * netcons_netpoll_setup() should auto-populate it from the egress device.
+ *
+ * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
+ * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
+ * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
+ * doing so would misclassify a caller-supplied address as unset and
+ * silently overwrite it with whatever address the device exposes.
+ */
+static bool netcons_local_ip_unset(const struct netpoll *np)
+{
+	if (np->ipv6)
+		return ipv6_addr_any(&np->local_ip.in6);
+	return !np->local_ip.ip;
+}
+
 static int netcons_netpoll_setup(struct netpoll *np)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -395,7 +412,7 @@ static int netcons_netpoll_setup(struct netpoll *np)
 		rtnl_lock();
 	}
 
-	if (netpoll_local_ip_unset(np)) {
+	if (netcons_local_ip_unset(np)) {
 		if (!np->ipv6) {
 			err = netpoll_take_ipv4(np, ndev);
 			if (err)
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index cd455a5a013d2..da05884f876e5 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -76,7 +76,6 @@ void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev);
 char *egress_dev(struct netpoll *np, char *buf, size_t bufsz);
 int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev);
 int netpoll_take_ipv6(struct netpoll *np, struct net_device *ndev);
-bool netpoll_local_ip_unset(const struct netpoll *np);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index d50d48a82def6..f4b110cb04167 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -496,24 +496,6 @@ int netpoll_take_ipv4(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(netpoll_take_ipv4);
 
-/*
- * Test whether the caller left np->local_ip unset, so that
- * netpoll_setup() should auto-populate it from the egress device.
- *
- * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
- * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
- * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
- * doing so would misclassify a caller-supplied address as unset and
- * silently overwrite it with whatever address the device exposes.
- */
-bool netpoll_local_ip_unset(const struct netpoll *np)
-{
-	if (np->ipv6)
-		return ipv6_addr_any(&np->local_ip.in6);
-	return !np->local_ip.ip;
-}
-EXPORT_SYMBOL_GPL(netpoll_local_ip_unset);
-
 static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 {
 	struct netpoll_info *npinfo =

-- 
2.53.0-Meta

