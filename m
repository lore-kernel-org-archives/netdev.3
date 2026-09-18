Received: from mta0.migadu.com (out-134.mta0.migadu.com [91.218.175.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BA3B0586
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734738; cv=none; b=TkSx5rIVPuW7tTPwGR2Y12EDYsfw2E0PL1LFC+62qHIC2PsBPYYJW5A2S7jmQjf7BJRRMGXLrOHgSi2zumD6z13xrBB+Ws+EfbS/ToTu8Sg0i/S+BuM736kWNW+gKEwF4x80lQ4sVDByP8GqLQJrxyTzE71fEmaSk+CA3AmDqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734738; c=relaxed/simple;
	bh=8uiO9U/2BnEzChyrQLc5F2J6jU60oIiTWfMimwuv1Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0T4Xg8qB9MvCvTSAsEwd8ImWkCE6vPwyFMr2FC1yqHfklRCinj6JMRJyjhW40qBeKZwoyoGceKf9PquVyUmy27Y9TYUM9XfXp0SRkwZtVfKMgwmrDzeTbERNXGlgO+p9f1SO1c4XJ2gHpQ/L1tpM6M7QfanvvUHvJeBWWmeCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gTtEmCTA; arc=none smtp.client-ip=91.218.175.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gTtEmCTA"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8uiO9U/2BnEzChyrQLc5F2J6jU60oIiTWfMimwuv1Kg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789734732; v=1; x=1790339532;
 b=gTtEmCTAcUNNprdk0kQth0n5JD2vR4ElmBeM8oV2qfJDu8lqPqd04e+6YfW+5vAaJer3vn2I
 69HLTNJ8Qj9HQk1gPSQUJ4ilo8eEkOpqPBeSFXnLIiacpbckfx1Egn+Yx/aOlXs4MdWxwd2Cg3U
 kMh6VW8wkgb09Y6/zTfJgcF8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8eb446be46abee73;
	Fri, 18 Sep 2026 12:32:12 +0000
X-Mizu-Trace-ID: 8eb446be46abee73
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@linux.intel.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] pfcp: fix socket lifetime on netdevice registration failure
Date: Fri, 18 Sep 2026 20:31:58 +0800
Message-ID: <20260918123158.5631-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

pfcp_newlink() creates the UDP socket before register_netdevice().
If registration fails after pfcp_dev_init() succeeds, the core calls
pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
The newlink error path then releases it again, causing a NULL pointer
dereference. This was observed with failslab fault injection:

  FAULT_INJECTION: forcing a failure.
  kobject: kobject_add_internal failed for pfcp0 (error: -12 parent: net)
  BUG: KASAN: null-ptr-deref in udp_tunnel_sock_release+0x1c/0x50
  Read of size 8 at addr 0000000000000120 by task ip/1037
  Call trace:
   show_stack+0x18/0x24 (C)
   dump_stack_lvl+0x78/0x90
   print_report+0x468/0x5cc
   kasan_report+0xa4/0xf0
   __asan_load8+0x7c/0xd0
   udp_tunnel_sock_release+0x1c/0x50
   pfcp_newlink+0x128/0x184
   rtnl_newlink+0x848/0xe44
   rtnetlink_rcv_msg+0x468/0x514
   netlink_rcv_skb+0xc0/0x1f0
   rtnetlink_rcv+0x18/0x24
   netlink_unicast+0x4b8/0x558
   netlink_sendmsg+0x2b8/0x584
   ...

Create the socket in pfcp_dev_init() after initializing the GRO cells,
and let pfcp_dev_uninit() release it on registration failure or removal.

Move the RCU wait into pfcp_dev_uninit(), using synchronize_net() after
socket release to drain receive callbacks before destroying the GRO cells.

Fixes: 76c8764ef36a5 ("pfcp: add PFCP module")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
A NULL check would fix the crash. Moving socket creation into ndo_init
also removes the duplicate cleanup and ensures the receive state is
initialized before enabling the socket's receive callback.

 drivers/net/pfcp.c | 90 ++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index e1cca779d2ecc..3db813ba2344c 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -103,27 +103,63 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static void pfcp_del_sock(struct pfcp_dev *pfcp)
+static struct sock *pfcp_create_sock(struct pfcp_dev *pfcp)
 {
-	udp_tunnel_sock_release(pfcp->sk);
-	pfcp->sk = NULL;
+	struct udp_tunnel_sock_cfg tuncfg = {};
+	struct udp_port_cfg udp_conf = {
+		.local_ip.s_addr	= htonl(INADDR_ANY),
+		.family			= AF_INET,
+	};
+	struct net *net = pfcp->net;
+	struct socket *sock;
+	int err;
+
+	udp_conf.local_udp_port = htons(PFCP_PORT);
+
+	err = udp_sock_create(net, &udp_conf, &sock);
+	if (err)
+		return ERR_PTR(err);
+
+	tuncfg.sk_user_data = pfcp;
+	tuncfg.encap_rcv = pfcp_encap_recv;
+	tuncfg.encap_type = 1;
+
+	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
+
+	return sock->sk;
 }
 
 static void pfcp_dev_uninit(struct net_device *dev)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
 
+	udp_tunnel_sock_release(pfcp->sk);
+	pfcp->sk = NULL;
+	/* Wait for receive callbacks before destroying their state. */
+	synchronize_net();
 	gro_cells_destroy(&pfcp->gro_cells);
-	pfcp_del_sock(pfcp);
 }
 
 static int pfcp_dev_init(struct net_device *dev)
 {
 	struct pfcp_dev *pfcp = netdev_priv(dev);
+	struct sock *sk;
+	int err;
 
 	pfcp->dev = dev;
 
-	return gro_cells_init(&pfcp->gro_cells, dev);
+	err = gro_cells_init(&pfcp->gro_cells, dev);
+	if (err)
+		return err;
+
+	sk = pfcp_create_sock(pfcp);
+	if (IS_ERR(sk)) {
+		gro_cells_destroy(&pfcp->gro_cells);
+		return PTR_ERR(sk);
+	}
+	pfcp->sk = sk;
+
+	return 0;
 }
 
 static const struct net_device_ops pfcp_netdev_ops = {
@@ -153,39 +189,6 @@ static void pfcp_link_setup(struct net_device *dev)
 	netif_keep_dst(dev);
 }
 
-static struct sock *pfcp_create_sock(struct pfcp_dev *pfcp)
-{
-	struct udp_tunnel_sock_cfg tuncfg = {};
-	struct udp_port_cfg udp_conf = {
-		.local_ip.s_addr	= htonl(INADDR_ANY),
-		.family			= AF_INET,
-	};
-	struct net *net = pfcp->net;
-	struct socket *sock;
-	int err;
-
-	udp_conf.local_udp_port = htons(PFCP_PORT);
-
-	err = udp_sock_create(net, &udp_conf, &sock);
-	if (err)
-		return ERR_PTR(err);
-
-	tuncfg.sk_user_data = pfcp;
-	tuncfg.encap_rcv = pfcp_encap_recv;
-	tuncfg.encap_type = 1;
-
-	setup_udp_tunnel_sock(net, sock->sk, &tuncfg);
-
-	return sock->sk;
-}
-
-static int pfcp_add_sock(struct pfcp_dev *pfcp)
-{
-	pfcp->sk = pfcp_create_sock(pfcp);
-
-	return PTR_ERR_OR_ZERO(pfcp->sk);
-}
-
 static int pfcp_newlink(struct net_device *dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
@@ -197,16 +200,10 @@ static int pfcp_newlink(struct net_device *dev,
 
 	pfcp->net = link_net;
 
-	err = pfcp_add_sock(pfcp);
-	if (err) {
-		netdev_dbg(dev, "failed to add pfcp socket %d\n", err);
-		goto exit_err;
-	}
-
 	err = register_netdevice(dev);
 	if (err) {
 		netdev_dbg(dev, "failed to register pfcp netdev %d\n", err);
-		goto exit_del_pfcp_sock;
+		goto exit_err;
 	}
 
 	pn = net_generic(link_net, pfcp_net_id);
@@ -219,9 +216,6 @@ static int pfcp_newlink(struct net_device *dev,
 
 	return 0;
 
-exit_del_pfcp_sock:
-	pfcp_del_sock(pfcp);
-	synchronize_rcu();
 exit_err:
 	pfcp->net = NULL;
 	return err;
-- 
2.43.0

