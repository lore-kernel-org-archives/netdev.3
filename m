Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EA1A9F8C;
	Thu, 17 Sep 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639854; cv=none; b=P9oueXI/QrWIKCj5MuPJJfCSTGOklRhVE62ccVR4NwJ9NxYKSw+WAlVwjrf1UhV85XnR/bszDg+/oKxxt8uV7nmcOdj8ENdMszkYhPS62XLaAmZUyfqNxPsSB3pfcajFf7JNObzyDHG2gpMIcNkhjvOyDljuzRGkL/MWYY86364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639854; c=relaxed/simple;
	bh=2YIieptIapOpd8zs8eRHGxCpIXTbo3WJ10JESG4Dv2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJjsfVZ4vRMR/fvV6GaXMWbRPJJDSjRSgmvGkENyvwYa7zLFhmy5D8kWoyy7bwHbfz9Ib5lnxPhmWYSzgCuAvSLKm0SY4rzxorhCgfmI2F/Pv3/45Gf7QZgzLfV06AWyxZVRcPi1yMdiPeWZU0aVZDjwqC/6CjYgLdqCJXOTNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=PXYKBIni; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="PXYKBIni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1789639847; bh=2YIieptIapOpd8zs8eRHGxCpIXTbo3WJ10JESG4Dv2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXYKBIni952Ub2euFFnVpgtLBR8oNyXbhnLRtvAtU6Huzt7sWF0Q4tYLaJpFO+AmN
	 i8xkH85SyPDoWHF4gi34xs4P1sOtvjaBfUH3lUsBrXCErYIqiWuhO/aX0PlI62/Fg0
	 cVWuajy75HTTOFxHXtwZVNK0JJqfwVZYkZtE1DqNbbYE//he2EIR9h7o0J3lmd/7op
	 XTm4HkhK5rtaT31XmhVv7Dp8bEL18FMCXq1z61FPuR5HnciG4+iGhllsW//KFgMRma
	 EnWkXUrWrPh0LNU4vWh5Umbe9WB933KVVWymM7dJ8CRFxDlpxyPjweRlypzt6JAF4j
	 sxvjrqSA3Hyrw==
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6aabbca7-6dc7-7f0000032729-7f000001e660-1
	for <multiple-recipients>; Thu, 17 Sep 2026 12:10:47 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 12:10:47 +0200 (CEST)
From: Thomas Martitz <t.martitz@fritz.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Thomas Martitz <t.martitz@fritz.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/1] macvlan: allow source mode devices along with passthru
Date: Thu, 17 Sep 2026 12:10:43 +0200
Message-ID: <20260917101044.2654867-1-t.martitz@fritz.com>
In-Reply-To: <20260917100258.2582568-1-t.martitz@fritz.com>
References: <20260917100258.2582568-1-t.martitz@fritz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1789639847-184801FC-B5A4951B/0/0
X-purgate-type: clean
X-purgate-size: 10055
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-03  mail-id: A955DA0197  external: no

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
 drivers/net/macvlan.c | 133 +++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 48 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index afad90b9222a2..76c11e5260334 100644
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
@@ -979,7 +984,26 @@ static void macvlan_uninit(struct net_device *dev)
 
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
+		if(!ether_addr_equal(port->dev->dev_addr, port->perm_addr)) {
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
 
@@ -1054,7 +1078,7 @@ static int macvlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (vlan->mode != MACVLAN_MODE_PASSTHRU && is_unicast_ether_addr(addr))
 		return -EOPNOTSUPP;
 
 	if (flags & NLM_F_REPLACE)
@@ -1079,7 +1103,7 @@ static int macvlan_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
 	/* Support unicast filter only on passthru devices.
 	 * Multicast filter should be allowed on all devices.
 	 */
-	if (!macvlan_passthru(vlan->port) && is_unicast_ether_addr(addr))
+	if (vlan->mode != MACVLAN_MODE_PASSTHRU && is_unicast_ether_addr(addr))
 		return -EOPNOTSUPP;
 
 	if (is_unicast_ether_addr(addr))
@@ -1310,18 +1334,6 @@ static void macvlan_port_destroy(struct net_device *dev)
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
 
@@ -1523,15 +1535,6 @@ int macvlan_common_newlink(struct net_device *dev,
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
@@ -1544,12 +1547,31 @@ int macvlan_common_newlink(struct net_device *dev,
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
 		eth_hw_addr_inherit(dev, lowerdev);
 	}
 
@@ -1581,7 +1603,12 @@ int macvlan_common_newlink(struct net_device *dev,
 	if (err)
 		goto unregister_netdev;
 
-	list_add_tail_rcu(&vlan->list, &port->vlans);
+	/* macvlan_handle_frame expects the (one and only) passthru device first. */
+	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
+		macvlan_set_passthru(port);
+		list_add_rcu(&vlan->list, &port->vlans);
+	} else
+		list_add_tail_rcu(&vlan->list, &port->vlans);
 	update_port_bc_queue_len(vlan->port);
 	netif_stacked_transfer_operstate(lowerdev, dev);
 	linkwatch_fire_event(dev);
@@ -1652,19 +1679,23 @@ static int macvlan_changelink(struct net_device *dev,
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
+			if (vlan->mode == MACVLAN_MODE_PASSTHRU ||
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
@@ -1897,8 +1928,14 @@ static int macvlan_device_event(struct notifier_block *unused,
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

