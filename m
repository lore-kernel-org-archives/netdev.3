Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F884A4F14;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594568; cv=none; b=GIUWFdPAC1/BuJF+cIwM4YlvaGGY6NyVlCzcclCSpdfYwkW9mEUPyN9S54ZSbwj4bypfdXtBKSF4rx7oiNSgVQ5lQRJQZidnZNsHfWhbtBOSjdBSM7Yy60SIUj7HPETpbTG0JewOlU0OX9Q8QHuxm2y1LDoHw6AXsennWe2wAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594568; c=relaxed/simple;
	bh=hi+ODxW/2E17k3AjhdTFaIiciuGihPhL1UxN3AqlJ+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gecLeWtdsie9bB2wafknKnWS+nc4fcdFMb4sahe+fAx4cCEfgrjYVLJDMjNdgSI/PZZnWYSKy1c3L/4FjAj4Nhkzt4ototRUlRJ9hlGBpuyZ9vO9HfCEiu1b7AL/jam/GTgiSWdXk/zXGysBru7l/6xRJGXsPK6BYQCtGmoWoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAbjtibY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAbjtibY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95EDEC4AF12;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790594568;
	bh=hi+ODxW/2E17k3AjhdTFaIiciuGihPhL1UxN3AqlJ+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dAbjtibY/FUyneXxhNuMYIOzF9Iqv66wIwwNFo4eyKxXITkOgNuLVE+/oOlgOsq3c
	 nArs/oVWD3UnCaoDwuI3hzazPChMCy1WCdgihpAZqLfldGE3E1lEIvXxKpRDS3B/db
	 5zJzYl5wk9Z6GNZ/E/84TzQNPhV9+ViEfHxCnI7jbRjueYuAWALPj9zRkpPlq+kFJ1
	 KHhUivctvkhc2qUbP7OLtwdHKar8ZG6ntu5dk0KVw6lxBfKZNU5RSTK7kl2bIXp4OC
	 1ComQatSoncvU6ur7U+BdVMKkzTCzsz82W2sUzyFLBBlaPjDvautWXWMKVqsRq31qE
	 HYu0MgiScCuJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78444CA5FA5;
	Mon, 28 Sep 2026 11:22:48 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Mon, 28 Sep 2026 13:22:45 +0200
Subject: [PATCH net-next v2 1/2] dpaa2-eth: use the DPMAC id as the devlink
 physical port number
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-for-upstream-dpaa2_ports-v2-1-1cda148530bf@free.fr>
References: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
In-Reply-To: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790594566; l=4195;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=Se0L6ry47CEmbyCV5mgMNcNOvS9j01H3UNrFZjfeJnk=;
 b=beaCjOk6+2LWDtZd10zE30y2xJ//NK/uUsJnxb1GnJ/eHDVG5svcsGQgrmGoEtXdDIcBt0EE/
 b4T4rEwhhNCDP6XBAgNipQKvb0pyVuW+/JX8aMFaYiIPxqXudabLoOM
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

dpaa2-eth registers every DPNI as a devlink port of flavour physical
without setting a port number. All DPAA2 interfaces report the same
phys_port_name, p0 (see devlink port show).

The DPNI endpoint can change at runtime while the attributes of a
registered devlink port cannot, so log a warning when it happens.

Another benefit: udev rules can match ATTR{phys_port_name} to name an
interface based on its DPMAC.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../ethernet/freescale/dpaa2/dpaa2-eth-devlink.c   | 40 +++++++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  2 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |  3 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
index 8775c931106b..4c0a04c2d458 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
@@ -213,20 +213,58 @@ void dpaa2_eth_dl_unregister(struct dpaa2_eth_priv *priv)
 	devlink_unregister(priv->devlink);
 }
 
+static u32 dpaa2_eth_dl_port_number(struct dpaa2_eth_priv *priv)
+{
+	lockdep_assert_held(&priv->mac_lock);
+
+	return dpaa2_eth_has_mac(priv) ? priv->mac->mc_dev->obj_desc.id : 0;
+}
+
 int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
 {
 	struct devlink_port *devlink_port = &priv->devlink_port;
 	struct devlink_port_attrs attrs = {};
+	u32 port_number;
+	int err;
+
+	mutex_lock(&priv->mac_lock);
+	port_number = dpaa2_eth_dl_port_number(priv);
+	priv->dl_port_number = port_number;
+	priv->dl_port_valid = true;
+	mutex_unlock(&priv->mac_lock);
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	attrs.phys.port_number = port_number;
 	devlink_port_attrs_set(devlink_port, &attrs);
-	return devlink_port_register(priv->devlink, devlink_port, 0);
+	err = devlink_port_register(priv->devlink, devlink_port, 0);
+	if (err) {
+		mutex_lock(&priv->mac_lock);
+		priv->dl_port_valid = false;
+		mutex_unlock(&priv->mac_lock);
+	}
+
+	return err;
+}
+
+void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
+{
+	mutex_lock(&priv->mac_lock);
+	if (priv->dl_port_valid &&
+	    priv->dl_port_number != dpaa2_eth_dl_port_number(priv))
+		netdev_warn(priv->net_dev,
+			    "devlink port number %u is stale, rebind to update\n",
+			    priv->dl_port_number);
+	mutex_unlock(&priv->mac_lock);
 }
 
 void dpaa2_eth_dl_port_del(struct dpaa2_eth_priv *priv)
 {
 	struct devlink_port *devlink_port = &priv->devlink_port;
 
+	mutex_lock(&priv->mac_lock);
+	priv->dl_port_valid = false;
+	mutex_unlock(&priv->mac_lock);
+
 	devlink_port_unregister(devlink_port);
 }
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 6f1046c9cc51..def2d5c0e7f7 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4771,6 +4771,8 @@ static irqreturn_t dpni_irq0_handler_thread(int irq_num, void *arg)
 			dpaa2_eth_disconnect_mac(priv);
 		else
 			dpaa2_eth_connect_mac(priv);
+
+		dpaa2_eth_dl_port_check(priv);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index 834cba8c3a41..3e0acd15549e 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -632,6 +632,8 @@ struct dpaa2_eth_priv {
 	struct devlink *devlink;
 	struct dpaa2_eth_trap_data *trap_data;
 	struct devlink_port devlink_port;
+	u32 dl_port_number;
+	bool dl_port_valid;
 
 	u32 rx_copybreak;
 
@@ -802,6 +804,7 @@ void dpaa2_eth_dl_unregister(struct dpaa2_eth_priv *priv);
 
 int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv);
 void dpaa2_eth_dl_port_del(struct dpaa2_eth_priv *priv);
+void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv);
 
 int dpaa2_eth_dl_traps_register(struct dpaa2_eth_priv *priv);
 void dpaa2_eth_dl_traps_unregister(struct dpaa2_eth_priv *priv);

-- 
2.43.0


