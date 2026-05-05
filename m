Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A203A6F05;
	Tue,  5 May 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987337; cv=none; b=Z4IcnYS/8dRd0EkCuqayZd4jDdfQE3uGtkH7keI/6ruRKrb3SKIYCrZdRqbOYgIhtIQN3nUjOM1m1JVbFrSE7wKaQChc31pVcTogjSisBWrvqEqCPVuMr0FdWWsjpRkLMG+UhiqFDGl9OFaadOdwldFsL9xuZgK+p9tR7Pr9W0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987337; c=relaxed/simple;
	bh=dY5gAI1Fa8oDYwSxEJDa0qL3hZJGKftL43uRkTgW/9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciOWfX7OYjUTV9tYyz1vVcleu6q3MZnWivoMYxupltw+ikljKA49a3zhTLwl/jLPSshl5/Jcjb+57UiRYrTM8iCQUAg3UH1/w18Fs5BcZLJFcuDWBTH7Kfc345Z10XOxGEnC373tnBPO9bSHkQWvCpGTuP6WELcMGyHRUCo672s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2G0DsI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2G0DsI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836BFC2BCB4;
	Tue,  5 May 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987337;
	bh=dY5gAI1Fa8oDYwSxEJDa0qL3hZJGKftL43uRkTgW/9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2G0DsI76aNmvAqbADJx2SwckcU14/V4uVOYdH05j8QPjUachVK0X3Hz7BHMc10Om
	 poi1+RfO3MSF9ZL1Ncx552YLfGVi4knN72wAdUEbUXWWSA4JMaauX1C/49OhUFRKMy
	 gJflvFT7okYLB7m4/EPWG3eJC/4H8ih+Tc+re6xkaMoqINeNcena18mSNTi6hm5iXi
	 MgbJpXV9QkrJn4ErAbYNi/lqQMt7kMIRHRU/TvfZ794W9yXEUDvlemMsP71VK7Xby/
	 j6qvmwBo3Cf1AN4Cnq32HdFE3+w12r48zEIRAPQH5wVgG6j4MN+sdMGW+6mzusK1on
	 IQdKQA6O2nmZg==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Christian Brauner <brauner@kernel.org>,
	Yury Norov <ynorov@nvidia.com>,
	Krishna Kumar <krikku@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/5] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
Date: Tue,  5 May 2026 15:21:54 +0200
Message-ID: <20260505132159.241305-3-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132159.241305-1-hawk@kernel.org>
References: <20260505132159.241305-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesper Dangaard Brouer <hawk@kernel.org>

Virtual devices with IFF_NO_QUEUE or lltx are excluded from BQL sysfs
by netdev_uses_bql(), since they traditionally lack real hardware
queues. However, some virtual devices like veth implement a real
ptr_ring FIFO with NAPI processing and benefit from BQL to limit
in-flight bytes and reduce latency.

Add a per-device 'bql' bitfield boolean in the priv_flags_slow section
of struct net_device. When set, it overrides the IFF_NO_QUEUE/lltx
exclusion and exposes BQL sysfs entries (/sys/class/net/<dev>/queues/
tx-<n>/byte_queue_limits/). The flag is still gated on CONFIG_BQL.

This allows drivers that use BQL despite being IFF_NO_QUEUE to opt in
to sysfs visibility for monitoring and debugging.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 2 ++
 net/core/net-sysfs.c                                   | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..b775d3235a2d 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -170,6 +170,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     bql                                                                 netdev_uses_bql(net-sysfs.c)
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 744ffa243501..d4c7b020b6a7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2065,6 +2065,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@bql:		device uses BQL (DQL sysfs) despite having IFF_NO_QUEUE
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2479,6 +2480,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		bql:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3318b5666e43..82833e5dae03 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1945,10 +1945,16 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_BQL))
+		return false;
+
+	if (dev->bql)
+		return true;
+
 	if (dev->lltx || (dev->priv_flags & IFF_NO_QUEUE))
 		return false;
 
-	return IS_ENABLED(CONFIG_BQL);
+	return true;
 }
 
 static int netdev_queue_add_kobject(struct net_device *dev, int index)
-- 
2.43.0

