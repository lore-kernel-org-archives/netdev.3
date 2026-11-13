Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578751;
	b=QNNkPi3Lz2sp9eAEu20sLFWGiBAzYDkBCugk8cs9/wcEflt76WsUGAsvZERKFVZoL3BJ
	 Q4s32zBN+CJOv1dOENeT0C5Jh8EChhm7F5A/trT0KPrdX1KdE0TR/jWAeWs4f9YMCbDMH
	 dceEfF5kEYyUCn2A2LTOyp0/BpfyPkR8XHOpfH/1UQCKm1iTkxuflAlOHHWQxhSQGU2BS
	 AOJzZEyjlaiiBQI0JHXYIcc/XSHX0BuioavHozeCilZn5vzFMx85udDauWES8uaYj8T42
	 0M5Wd3HsqeQkGPcAZ5suB797c70p7BI4Egs/1wNSRrOKH1IyPdUyPMb+/c3x3GP2OzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578751;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=jAHAPfUhlZudSrtXQUG8Xz47klJad1nKdH3wyvQmdDU=;
	b=paMxeeMf6T64WAD7vQNTIjqB52TB794g4s+HT3WTjo7i0Wn7QofB5cum5RdwBq2yHWLA
	 WS2c2o0ndu7s0bw7WkYr0v1/5UWd3nCmJ2ffiUEE+CfHRoJa95klg40SjQ0JEcR/eMpLR
	 Ts1YqVfvaTpPvC/urZzosF0QVT5clLB3PT60mdofP1ovmZB4jg8YLnPyEOZmO/tXB0OqK
	 Z0hRBUEm/ZSsHgIdPjt6bAdWh5xvuinRCP7IXjfzqaho2Plfi1i2FUVOSWY0y4MuvelVJ
	 nVgDq8o4E1w1+njJSJtfCTho2ZUX//ZXP5tZ4FYQOtXRFi3HaZHUhEn6vwiK62M8Y/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dlRa4nR8;
	arc=none smtp.remote-ip=91.218.175.231
Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66258606A33E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66258606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dlRa4nR8
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=v7ifUx3zw968wVTV7DjirhM59hb0uWjfSr9Qa2JlfLc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794578748; v=1; x=1795183548;
 b=dlRa4nR88PsfsbwqPgnmGBrK2rLrKih1FxpcmTNwG33bxQGKuVZUlW7xdTma42kn5lr2WHKR
 DkSDyOgC2Bqcx1REYWeQIW2VxPrg+pF6sGKUd0L7fTVAbMRW3VbMugA+4l81QW74lmWiuZY0Amb
 PvKbFfw+ZB07Klm398KvUeRQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 64e8af105d184030;
	Fri, 13 Nov 2026 14:05:29 +0000
X-Mizu-Trace-ID: 64e8af105d184030
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 13 Nov 2026 22:04:18 +0800
Subject: [PATCH net-next 3/6] bonding: complete rollback of bond_enslave()
 error paths
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-bond_enslave_restruct-v1-3-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
In-Reply-To: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <hangbin.liu@linux.dev>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

The bond_enslave() undo labels are missing three cleanups that the
release path (__bond_release_one) already performs:

- If bond_alb_init_slave() succeeds but a later step fails, the
  slave is never passed to bond_alb_deinit_slave(), leaving TLB/RLB
  state and a possibly borrowed MAC address behind.

- If the slave is bound into 802.3ad (bond_3ad_bind_slave()) and a
  later step fails, bond_3ad_unbind_slave() is never called, so the
  port stays attached to its aggregator.

- When fail_over_mac is automatically set to "active" because the
  first slave cannot change its MAC address, a subsequent failure
  leaves the modified parameter on the bond.

Add undo steps for these 3 cleanups when error out.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 80b6c18ee9c2..f696a0d15034 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1890,7 +1890,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 {
 	struct bonding *bond = netdev_priv(bond_dev);
 	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
+	int orig_fail_over_mac = bond->params.fail_over_mac;
 	struct slave *new_slave = NULL, *prev_slave;
+	bool alb_initialized = false;
 	struct sockaddr_storage ss;
 	int res = 0, i;
 
@@ -2120,6 +2122,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		res = bond_alb_init_slave(bond, new_slave);
 		if (res)
 			goto err_close;
+		alb_initialized = true;
 	}
 
 	res = vlan_vids_add_by_dev(slave_dev, bond_dev);
@@ -2388,6 +2391,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	netdev_rx_handler_unregister(slave_dev);
 
 err_detach:
+	if (BOND_MODE(bond) == BOND_MODE_8023AD)
+		bond_3ad_unbind_slave(new_slave);
 	vlan_vids_del_by_dev(slave_dev, bond_dev);
 	if (rcu_access_pointer(bond->primary_slave) == new_slave)
 		RCU_INIT_POINTER(bond->primary_slave, NULL);
@@ -2402,6 +2407,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	slave_disable_netpoll(new_slave);
 
 err_close:
+	if (alb_initialized)
+		bond_alb_deinit_slave(bond, new_slave);
 	if (!netif_is_bond_master(slave_dev))
 		slave_dev->priv_flags &= ~IFF_BONDING;
 	dev_close(slave_dev);
@@ -2427,6 +2434,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	kobject_put(&new_slave->kobj);
 
 err_undo_flags:
+	/* Restore fail_over_mac in case the automatic "active" setting
+	 * above was applied and a later step failed.
+	 */
+	bond->params.fail_over_mac = orig_fail_over_mac;
+
 	/* Enslave of first slave has failed and we need to fix master's mac */
 	if (!bond_has_slaves(bond)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr,

-- 
2.56.0

