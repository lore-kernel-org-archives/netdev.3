Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BD43F8CB;
	Wed,  7 Oct 2026 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393211; cv=none; b=kUB8z/GWfe07QtTrG9b8mgl3Q5t4gYRedMcyERWRpRI9YQcMKeMvYIG2gUWpq7uklpcaVZ3nR49WO6tO0yorhXuowqMgWg7GwHwJRncmEKGU+Sz24Gae2pwbEmrjPFDyoFmcoOuYbGKyEhpc3+r0dCnoiR0FgQgItRxIqQdXYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393211; c=relaxed/simple;
	bh=CCSFW0V5Im3/8+9tq8ECAONKGXdwaUbyPl92jUu8pYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaHXzc8MUGQI7CVLRMiXgaCP0Q9Kvd3CJPX2P6mMDsuZaz+bp5uSiQ3y1Z6qcKz5IdHUofelOJ396CVJsGqv4qOYie4SwaQ9rWu6Ww/3QmZ/GK81iX5F1tta5pdIq9KMuBYesM81urEyjb1+seC/K6L64UwUiXLMZWeIy+CXzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=lN/CYq64; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="lN/CYq64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1791392888; bh=CCSFW0V5Im3/8+9tq8ECAONKGXdwaUbyPl92jUu8pYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lN/CYq64fKKrJH02SDBP4rXCwg9SDKTaPJegz/z7/p6bDPi3IY4lP8td4SrNfrp/I
	 v64NyvynOzyzaTx/NWXztfLkuQdcWV3lKAbLeAwPfc1edgrktxgGyIHj5iyI506E2W
	 iiErkMwSV7c3Sk5bHU4E4EZ5ccSFY7562cJfBaRzHjrSm8DJoz0htaArb8RtQJ3PDs
	 j+EZ/LxwODZpJRHYSwhBrSlqB8s2qUkPemhCfLbbB8POdjdJgZF+deKv6qVchg6VEJ
	 lHe0g20/8tcr609umHR9qs1j9F0rz1Ne4HmJh8f7mDFfjJmDGOgicDr1WEs/tQXQZF
	 Rgxupzv2PVpCw==
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6ac67c77-c83a-7f0000032729-7f000001a3d0-1
	for <multiple-recipients>; Wed, 07 Oct 2026 19:08:07 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed,  7 Oct 2026 19:08:07 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/1] macvlan: allow source mode devices along with passthru
Date: Wed,  7 Oct 2026 19:06:37 +0200
Message-ID: <20261007170638.2086790-3-t.martitz@fritz.com>
In-Reply-To: <20261007170638.2086790-1-t.martitz@fritz.com>
References: <20261007170638.2086790-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1791392887-26FA7455-0E57C2D1/0/0
X-purgate-type: clean
X-purgate-size: 11496
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-02  mail-id: 1CE4FA08AB  external: no

This allows for configurations where there are a few
known senders in the system (e.g. multiple SoCs on the same
board) along with unlimited external senders.

The source mode devices represent the known senders while
all external senders terminate on passthru device.

Although you can still receive packets on the lower device
without the need for the passthru vlan device, there
are use cases where you need additional packet processing
in the pipeline that hooks via rx_handler. With this the
rx_handler can be attached to the passthru device while
macvlan itself remains attached to the lower device.

We use this to use the same physical link for inter-SoC
networking and external networking. Some of our chips
have no other viable link for inter-SoC traffic.

Signed-off-by: Thomas Martitz <t.martitz@fritz.com>
---
 drivers/net/macvlan.c | 146 +++++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 53 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a2..4af10cc517993 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -83,6 +83,11 @@ static inline void macvlan_set_passthru(struct macvlan_port *port)
 	port->flags |= MACVLAN_F_PASSTHRU;
 }
 
+static inline void macvlan_clear_passthru(struct macvlan_port *port)
+{
+	port->flags &= ~MACVLAN_F_PASSTHRU;
+}
+
 static inline bool macvlan_addr_change(const struct macvlan_port *port)
 {
 	return port->flags & MACVLAN_F_ADDRCHANGE;
@@ -217,8 +222,7 @@ static bool macvlan_addr_busy(const struct macvlan_port *port,
 	 * currently in use by the underlying device or
 	 * another macvlan.
 	 */
-	if (!macvlan_passthru(port) && !macvlan_addr_change(port) &&
-	    ether_addr_equal_64bits(port->dev->dev_addr, addr))
+	if (ether_addr_equal_64bits(port->dev->dev_addr, addr))
 		return true;
 
 	if (macvlan_hash_lookup(port, addr))
@@ -637,7 +641,7 @@ static int macvlan_open(struct net_device *dev)
 	struct net_device *lowerdev = vlan->lowerdev;
 	int err;
 
-	if (macvlan_passthru(vlan->port)) {
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
 		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC)) {
 			err = dev_set_promiscuity(lowerdev, 1);
 			if (err < 0)
@@ -712,7 +716,7 @@ static int macvlan_stop(struct net_device *dev)
 	dev_uc_unsync(lowerdev, dev);
 	dev_mc_unsync(lowerdev, dev);
 
-	if (macvlan_passthru(vlan->port)) {
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
 		if (!(vlan->flags & MACVLAN_FLAG_NOPROMISC))
 			dev_set_promiscuity(lowerdev, -1);
 		goto hash_del;
@@ -737,17 +741,18 @@ static int macvlan_sync_address(struct net_device *dev,
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct net_device *lowerdev = vlan->lowerdev;
 	struct macvlan_port *port = vlan->port;
+	bool passthru_dev = vlan->mode == MACVLAN_MODE_PASSTHRU;
 	int err;
 
 	if (!(dev->flags & IFF_UP)) {
 		/* Just copy in the new address */
 		eth_hw_addr_set(dev, addr);
 	} else {
-		/* Rehash and update the device filters */
-		if (macvlan_addr_busy(vlan->port, addr))
-			return -EADDRINUSE;
+		if (!passthru_dev) {
+			/* Rehash and update the device filters */
+			if (macvlan_addr_busy(vlan->port, addr))
+					return -EADDRINUSE;
 
-		if (!macvlan_passthru(port)) {
 			err = dev_uc_add(lowerdev, addr);
 			if (err)
 				return err;
@@ -757,7 +762,7 @@ static int macvlan_sync_address(struct net_device *dev,
 
 		macvlan_hash_change_addr(vlan, addr);
 	}
-	if (macvlan_passthru(port) && !macvlan_addr_change(port)) {
+	if (passthru_dev && !macvlan_addr_change(port)) {
 		/* Since addr_change isn't set, we are here due to lower
 		 * device change.  Save the lower-dev address so we can
 		 * restore it later.
@@ -781,14 +786,17 @@ static int macvlan_set_mac_address(struct net_device *dev, void *p)
 	if (ether_addr_equal(dev->dev_addr, addr->__data))
 		return 0;
 
+	if (macvlan_addr_busy(vlan->port, addr->__data))
+		return -EADDRINUSE;
+
 	if (READ_ONCE(vlan->mode) == MACVLAN_MODE_PASSTHRU) {
 		macvlan_set_addr_change(vlan->port);
+		/* macvlan_sync_address() via netdev notifier,
+		 * to keep passthru and lower in sync.
+		 */
 		return dev_set_mac_address(vlan->lowerdev, addr, NULL);
 	}
 
-	if (macvlan_addr_busy(vlan->port, addr->__data))
-		return -EADDRINUSE;
-
 	return macvlan_sync_address(dev, addr->__data);
 }
 
@@ -800,7 +808,7 @@ static void macvlan_change_rx_flags(struct net_device *dev, int change)
 	if (dev->flags & IFF_UP) {
 		if (change & IFF_ALLMULTI)
 			dev_set_allmulti(lowerdev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (!macvlan_passthru(vlan->port) && change & IFF_PROMISC)
+		if (READ_ONCE(vlan->mode) != MACVLAN_MODE_PASSTHRU && change & IFF_PROMISC)
 			dev_set_promiscuity(lowerdev,
 					    dev->flags & IFF_PROMISC ? 1 : -1);
 
@@ -979,7 +987,26 @@ static void macvlan_uninit(struct net_device *dev)
 
 	macvlan_flush_sources(port, vlan);
 	port->count -= 1;
-	if (!port->count)
+
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
+		/* If the lower device address has been changed by passthru
+		 * macvlan, put it back.
+		 *
+		 * Caution: This triggers NETDEV_CHANGEADDR on
+		 * the lower device. But we're in the green because
+		 * the passthru interface is already off the list.
+		 */
+		if (!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
+			struct sockaddr_storage ss;
+
+			ss.ss_family = port->dev->type;
+			memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
+			dev_set_mac_address(port->dev, &ss, NULL);
+		}
+		macvlan_clear_passthru(port);
+	}
+
+	if (port->count == 0)
 		macvlan_port_destroy(port->dev);
 }
 
@@ -1054,7 +1081,7 @@ static int macvlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (vlan->mode != MACVLAN_MODE_PASSTHRU && is_unicast_ether_addr(addr))
 		return -EOPNOTSUPP;
 
 	if (flags & NLM_F_REPLACE)
@@ -1079,7 +1106,7 @@ static int macvlan_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (vlan->mode != MACVLAN_MODE_PASSTHRU && is_unicast_ether_addr(addr))
 		return -EOPNOTSUPP;
 
 	if (is_unicast_ether_addr(addr))
@@ -1268,7 +1295,6 @@ static int macvlan_port_create(struct net_device *dev)
 		return -ENOMEM;
 
 	port->dev = dev;
-	ether_addr_copy(port->perm_addr, dev->dev_addr);
 	INIT_LIST_HEAD(&port->vlans);
 	for (i = 0; i < MACVLAN_HASH_SIZE; i++)
 		INIT_HLIST_HEAD(&port->vlan_hash[i]);
@@ -1310,18 +1336,6 @@ static void macvlan_port_destroy(struct net_device *dev)
 		kfree_skb(skb);
 	}
 
-	/* If the lower device address has been changed by passthru
-	 * macvlan, put it back.
-	 */
-	if (macvlan_passthru(port) &&
-	    !ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
-		struct sockaddr_storage ss;
-
-		ss.ss_family = port->dev->type;
-		memcpy(&ss.__data, port->perm_addr, port->dev->addr_len);
-		dev_set_mac_address(port->dev, &ss, NULL);
-	}
-
 	kfree(port);
 }
 
@@ -1523,15 +1537,6 @@ int macvlan_common_newlink(struct net_device *dev,
 	}
 	port = macvlan_port_get_rtnl(lowerdev);
 
-	/* Only 1 macvlan device can be created in passthru mode */
-	if (macvlan_passthru(port)) {
-		/* The macvlan port must be not created this time,
-		 * still goto destroy_macvlan_port for readability.
-		 */
-		err = -EINVAL;
-		goto destroy_macvlan_port;
-	}
-
 	vlan->lowerdev = lowerdev;
 	vlan->dev      = dev;
 	vlan->port     = port;
@@ -1544,12 +1549,32 @@ int macvlan_common_newlink(struct net_device *dev,
 	if (data && data[IFLA_MACVLAN_FLAGS])
 		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
 
+	/* Only 1 macvlan device can be created in passthru mode. There may be
+	 * additional source mode devices but nothing else at the moment.
+	 *
+	 * First check if adding a source mode device to an existing passthru vlan.
+	 */
+	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
+		/* The macvlan port must be not created this time,
+		 * still goto destroy_macvlan_port for readability.
+		 */
+		err = -EINVAL;
+		goto destroy_macvlan_port;
+	}
+
+	/* Now check if adding a passthru device to an existing set of source mode
+	 * devices.
+	 */
 	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
-		if (port->count) {
-			err = -EINVAL;
-			goto destroy_macvlan_port;
+		struct macvlan_dev *p;
+
+		list_for_each_entry(p, &port->vlans, list) {
+			if (p->mode != MACVLAN_MODE_SOURCE) {
+				err = -EINVAL;
+				goto destroy_macvlan_port;
+			}
 		}
-		macvlan_set_passthru(port);
+		ether_addr_copy(port->perm_addr, lowerdev->dev_addr);
 		eth_hw_addr_inherit(dev, lowerdev);
 	}
 
@@ -1581,7 +1606,12 @@ int macvlan_common_newlink(struct net_device *dev,
 	if (err)
 		goto unregister_netdev;
 
-	list_add_tail_rcu(&vlan->list, &port->vlans);
+	/* macvlan_handle_frame expects the (one and only) passthru device first. */
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
+		list_add_rcu(&vlan->list, &port->vlans);
+		macvlan_set_passthru(port);
+	} else
+		list_add_tail_rcu(&vlan->list, &port->vlans);
 	update_port_bc_queue_len(vlan->port);
 	netif_stacked_transfer_operstate(lowerdev, dev);
 	linkwatch_fire_event(dev);
@@ -1652,19 +1682,23 @@ static int macvlan_changelink(struct net_device *dev,
 	if (data && data[IFLA_MACVLAN_MODE]) {
 		set_mode = true;
 		mode = nla_get_u32(data[IFLA_MACVLAN_MODE]);
-		/* Passthrough mode can't be set or cleared dynamically */
-		if ((mode == MACVLAN_MODE_PASSTHRU) !=
-		    (vlan->mode == MACVLAN_MODE_PASSTHRU))
-			return -EINVAL;
-		if (vlan->mode == MACVLAN_MODE_SOURCE &&
-		    vlan->mode != mode)
-			macvlan_flush_sources(vlan->port, vlan);
+		if (mode != vlan->mode) {
+			/* Passthrough mode can't be set or cleared dynamically,
+			 * regardless of existing source interfaces. Furthermore, source
+			 * interfaces can't switch modes within a passhtrough port.
+			 */
+			if (mode == MACVLAN_MODE_PASSTHRU ||
+			    macvlan_passthru(vlan->port))
+				return -EINVAL;
+			if (vlan->mode == MACVLAN_MODE_SOURCE)
+				macvlan_flush_sources(vlan->port, vlan);
+		}
 	}
 
 	if (data && data[IFLA_MACVLAN_FLAGS]) {
 		__u16 flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
 		bool promisc = (flags ^ vlan->flags) & MACVLAN_FLAG_NOPROMISC;
-		if (macvlan_passthru(vlan->port) && promisc) {
+		if (vlan->mode == MACVLAN_MODE_PASSTHRU && promisc) {
 			int err;
 
 			if (flags & MACVLAN_FLAG_NOPROMISC)
@@ -1897,8 +1931,14 @@ static int macvlan_device_event(struct notifier_block *unused,
 		vlan = list_first_entry_or_null(&port->vlans,
 						struct macvlan_dev,
 						list);
-
-		if (vlan && macvlan_sync_address(vlan->dev, dev->dev_addr))
+		/* Validate the interface mode again because we're potentially
+		 * triggered upon removal of the passthru interface. In which
+		 * case it is already off the list (and has restored the lower
+		 * device mac already).
+		 */
+		if (!vlan || vlan->mode != MACVLAN_MODE_PASSTHRU)
+			return NOTIFY_DONE;
+		if (macvlan_sync_address(vlan->dev, dev->dev_addr))
 			return NOTIFY_BAD;
 
 		break;
-- 
2.55.0

