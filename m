Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6D32B12C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243547; cv=none; b=CtAHUuy0bE7i2c2jjFIzCimkjY5fcUqrSIkNy+p07mVSZWtMxrD1IOJvYl3Jm3X3dUd7p5Fszz7qcCS5f4wpmEWj0pgnl1+7e/Pk0S151Oa+0HQJCQHHNAS+XFo8iVRlcHuJKe7OfF4ts4/gMLWKXkLbTcidVZb0FbAQNb3ryIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243547; c=relaxed/simple;
	bh=STWHLF5uEVvcYuKo4Dz/DvH+J6MSOGByWm9VVdOK+Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRBqELmyKPPDgDpxUCqaz6UOQk1HlFQY5OPPvwJDFH6Xr861hD+cuQe603HjoSsWToWrn4kzYYGHgHvJBZ7uLMjDEspxsPrrkF4S4PGJ1668hDborQfR8UcYUyEPdisHzDS9tfLdhoRNBNQkaWpgv1W4v8s3KWPlbc/u0aB0zfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vbJ6tr2j; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vbJ6tr2j"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=STWHLF5uEVvcYuKo4Dz/DvH+J6MSOGByWm9VVdOK+Ao=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788243542; v=1; x=1788848342;
 b=vbJ6tr2jvCEy4/byXiNSIg84rjvtnMQVWS1cpDbzNPc24CGe6jTWaTMaGc+O4WHvmGvxFHI5
 ujswOhceCx29jJBXpXb/YH4dbt+z+JpTiLj7l+fYHk0BSx+9szuihposY88540efiSatrHO/J6a
 KFkJwyZRaa0lI+dsVUVMYjwI=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 12924fcfb43a0fd7;
	Tue, 01 Sep 2026 06:19:01 +0000
X-Mizu-Trace-ID: 12924fcfb43a0fd7
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] netdevsim: fix panic when NETIF_F_LOOPBACK is set on a VF port
Date: Tue,  1 Sep 2026 14:18:50 +0800
Message-ID: <20260901061851.61734-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netdevsim VF port cannot process incoming data.  It never runs
nsim_queue_init(), so ns->rq is NULL, and nsim_vf_netdev_ops has no
->ndo_open, so its NAPI is never set up either.

nsim_setup() offers NETIF_F_LOOPBACK to both PF and VF ports.  Turning
it on for a VF makes nsim_start_xmit() take ns itself as peer_ns and
dereference peer_ns->rq[], which panics.

A VF cannot deliver packets at all: it can't be linked as a peer either,
since netdev_is_nsim() only matches the PF netdev_ops, so ns->peer is
always NULL and every skb ends up dropped.  Give VF ports a dedicated
xmit that just drops the traffic, so VFs no longer depend on PF-only
state in nsim_start_xmit().

Reproduce in qemu:
  modprobe netdevsim
  echo "90 1" > /sys/bus/netdevsim/new_device
  echo 2 > /sys/bus/netdevsim/devices/netdevsim90/sriov_numvfs
  devlink dev eswitch set netdevsim/netdevsim90 mode switchdev
  ethtool -K eth2 loopback on   # eth2 is the vfnum 0 port
  ip link set eth2 up

Panic:
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  CPU: 0 UID: 0 PID: 141 Comm: kworker/0:3 Not tainted 7.2.0+ #338 PREEMPT
  Workqueue: mld mld_ifc_work
  RIP: 0010:nsim_start_xmit (drivers/net/netdevsim/netdev.c:159)
  dev_hard_start_xmit ( net/core/dev.c:3953)
  sch_direct_xmit (net/sched/sch_generic.c:372)
  __dev_queue_xmit (net/core/dev.c:4262 net/core/dev.c:4884)
  neigh_resolve_output (net/core/neighbour.c:1616)
  ip6_finish_output2 (net/ipv6/ip6_output.c:138)
  ip6_finish_output (net/ipv6/ip6_output.c:221)
  ip6_output (net/ipv6/ip6_output.c:248)
  ......

Fixes: 358008f41d9b ("netdevsim: add loopback support")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v2: use a dedicated drop-only xmit for VF ports instead of clearing
    NETIF_F_LOOPBACK, per Jakub
v1: https://lore.kernel.org/netdev/20260831042221.137137-1-jiayuan.chen@linux.dev/
---
 drivers/net/netdevsim/netdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b4a99f3ceac6..eebc02ccc4a9 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -185,6 +185,14 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static netdev_tx_t nsim_start_xmit_vf(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	dev_dstats_tx_dropped(dev);
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
 static int nsim_set_rx_mode(struct net_device *dev,
 			    struct netdev_hw_addr_list *uc,
 			    struct netdev_hw_addr_list *mc)
@@ -651,7 +659,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 };
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
-	.ndo_start_xmit		= nsim_start_xmit,
+	.ndo_start_xmit		= nsim_start_xmit_vf,
 	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
-- 
2.43.0

