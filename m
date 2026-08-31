Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EE3AAF61
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788150153; cv=none; b=WWMJYlGxCsoOEqwR73uJIiN6o0+omJbcFjNeAervFZyNx9g6jZICxHYyWoaQBve28XEsnZtgEeyUPfHRXIsYcjay6Qv1xuG3m0D5j8Hjm9CVF1Sgo1HvIVGzHQXTE9jm4h1ZP4TbG6+fP+YNPcwOpvADPDE8WSiWxh02VD/Y2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788150153; c=relaxed/simple;
	bh=jF99/EO6lld/rF/a9EiyZEVSNAjllsY5+Q5svVHTm1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OoxH6lNVJUijMm2SXspnF68KF4zMCGo0uFA8mWWSXSPQ4lVW8PFx2gcfyQi1fbLudqbvgm75ehw+TWBhdT5Jg7ihTrKTkJhiYO5tWqNuDMbkfHsVhmIBLUdbvFzIkHaB7fu5bS4AP57e7L4/wSa8GoaV8zFHGSrJD56UAoEixpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pY64tpGG; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pY64tpGG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jF99/EO6lld/rF/a9EiyZEVSNAjllsY5+Q5svVHTm1o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788150149; v=1; x=1788754949;
 b=pY64tpGGicPY82ZmATNSwl0LN7/rwtAnrUq59NTo9LAf2J/wEq0qTBjU5g+BxgVF9oqo9eNY
 m00ALFiHnr1/TMWkyDI3jFxhVnlLVrQm8PG+PER9ysNmAXFJ44PwdSk/blRuzOyxZXGM2pzGQq/
 lHhpTUM4NIryAc9SmoXAtwKA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 515f821b0dbb075c;
	Mon, 31 Aug 2026 04:22:28 +0000
X-Mizu-Trace-ID: 515f821b0dbb075c
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] netdevsim: fix panic when NETIF_F_LOOPBACK is set on a VF port
Date: Mon, 31 Aug 2026 12:22:20 +0800
Message-ID: <20260831042221.137137-1-jiayuan.chen@linux.dev>
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

Since commit 358008f41d9b ("netdevsim: add loopback support") an outgoing
netdevsim can also be the incoming device.  nsim_setup() is shared by PF
and VF ports and offers NETIF_F_LOOPBACK to both, so the feature can be
turned on for a VF; nsim_start_xmit() then takes ns as peer_ns and
dereferences peer_ns->rq[], which panics.

Disable NETIF_F_LOOPBACK on VF ports.

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
 drivers/net/netdevsim/netdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b4a99f3ceac6..7bb72aea90a0 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1113,6 +1113,14 @@ static int nsim_init_netdevsim_vf(struct netdevsim *ns)
 	int err;
 
 	ns->netdev->netdev_ops = &nsim_vf_netdev_ops;
+
+	/* nsim_setup() offers NETIF_F_LOOPBACK to every port, but a VF port
+	 * has neither queues nor NAPI, and looping a frame back means
+	 * receiving it.
+	 */
+	ns->netdev->hw_features &= ~NETIF_F_LOOPBACK;
+	ns->netdev->features &= ~NETIF_F_LOOPBACK;
+
 	rtnl_lock();
 	err = register_netdevice(ns->netdev);
 	rtnl_unlock();
-- 
2.43.0

