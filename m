Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AC45DF69
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940938; cv=none; b=DDkcjj1DV8eIppwKPKOvY4mTcaAhgZLVOO9zeZb+c+5fn7KLV98a929f4aNmEezFT2/sJ1qxfsR+igj6Eosu6n0Mmx5u5W0opM4xiQEgF4M0A7jV59Rjzw6MQ7aat/xkc+AF0jqavpwUMCSOaB6yc4VP9Tvwc+p6mkAgD48r5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940938; c=relaxed/simple;
	bh=Jn6WB6gHElv96qrSzSmASQP9AhHrMtagblryMeSycnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2c5it++yMS2OPMthQOer4nJQwIB5QDnAaA989O50rsAL8hzrToErPselcZFRozOeCw7aFXN+7ItTptXTxzFie2TZbYQWeZzTlbLHNWypwK187LiG4DxP7H8uO1lNpyDjCPEqehcD8+Z/d/JBVlyIL+zp6Wy4XnR3fp6B1cLqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mvk3hvcx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mvk3hvcx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f96c5b722so3912602f8f.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 01:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940934; x=1789545734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ll8VAgV04XQDjiDhfgtl64C8SnosCd5UNG3ReUXeI/c=;
        b=Mvk3hvcxnPP5f3M9yW8OlQdUWgRqtUVu+HV3sD5txndFnP4Ncefn7qwV/gge0frsx0
         1/hogQw5+QN/SjKGubcyONR+OBoYuQFo9ipsCLaJQ3daX0Rm3k3y+6V5siHbMlAEDIJb
         DRGZFGtqOz6K6KMav/6evUbUj51DGU4ssOVZS3N30r0OQEMow/ofkJ5ITnCqMsKzVutQ
         8w5i07V5O4nO1RnxJAjQcfTy2YrmrHV+J9rlb36yj0Swgu3jYUtwPRc+TTlqjNxkPQo/
         fu0jDInQI57beYLjBX87Rqaof6LWZ/ab2X2gqkF7W0SBysqJ63cqR40JRkSfCEXMoeQZ
         ccKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940934; x=1789545734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ll8VAgV04XQDjiDhfgtl64C8SnosCd5UNG3ReUXeI/c=;
        b=JKBrxCK8faqB6N7kJOt4xEZANHqXpH7IVISB1BKS//4NkShUpl7P6kmaD3r/aJdMQg
         hcyrQfSc8fjc+PBPVNMRGxg/NeCrp3r8Lkhdi1H21vntrGbNt/6QDy40qRFjL/OkQ1p/
         p/g6+lHmniVzw5P2PsGI8Q0VXYP6BVc2k1cZiES72sjUthQQTp3ULh6G/oH3eAxoU36C
         3VPZQp7j9Z5SC3UPs8L7lPJ5GeQKSCewBb4R+TvYB5d+EN9e5cBthTCcAaj2BCgcda3z
         1KTBs8WIq6ImNE8ZUdLD2fONrBDmYb10ImyC8eg/7eaIcTssSQ6wJnPh0/jSFjZWOw4i
         NHfA==
X-Gm-Message-State: AFuF++lBFPW4BDsFE2+xFA+UHSIk1JQYiPjy7jZ3nhjcA4Df5R4SFhos
	BcK195u5G++Q4/r+B7lAj135k96JBtZzpQWmhGtnFD1OuGaoXUAUCNyBv20GQQ==
X-Gm-Gg: AYBFou1kTvklu6vodXODSTbBp7ymMjV9NVH/fLHL16jyf5+y4T/7vonJN6is0iu5RMN
	vICF0iqB35OwiirIufW61qKIVySPTd4k8Xcq91Pv8FKtuOFYQZdZvwheymXNbEJK+ONm6TNCmxA
	6GzhisAyu1k0VENnUwfTNLOciL+gyUbpEHG2Qjhbk586a6vUL3/gPXFTiA7/qAbXG1V0ZdKHPKp
	ffVd6xTwUMGHbiLcsyO/U+cUTKPiJJ86VBDBvUN5yPRoK+cyM7SejDaOxn412aBfojGjQMGz5ft
	StIbQ+4/G8VSMYTvAGNcBRLZWnvrh8m2cvfsKFDzORVNCeHpMEM/kDdBgqM/gmhiK5yKx8AmwxD
	GnDzLmD4Ie0OGAmGJgv4k3pOyrVRKwgssWIFg6Bv81SAiwqt9GldD16VQAxj7SXI4mF0blxUiOb
	VQ3Uk19bgr9Gm/9HlRFmb9rsvvpZxGzeMulY9p1fLWepklR8A85oUNO6aeji5CWhRcZ69g2Rz8j
	fUIBRU=
X-Received: by 2002:a05:600c:8b8c:b0:49c:e3ad:41d3 with SMTP id 5b1f17b1804b1-49cf7f4aea6mr331141235e9.0.1788940934264;
        Wed, 09 Sep 2026 01:02:14 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm412796785e9.3.2026.09.09.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:02:13 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	dnlplm@gmail.com,
	linux-kernel@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v6] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Wed,  9 Sep 2026 11:02:09 +0300
Message-ID: <20260909080209.6348-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An rmnet device may be created with its real device in a different
netns than the rmnet device itself (rmnet_newlink() resolves it in
link_net), and the config paths below only check CAP_NET_ADMIN against
dev_net(dev), while mutating rmnet port state attached to the real
device:

- rmnet_changelink() rewrites the endpoint mux table and
  port->data_format and, via rmnet_vnd_update_dev_mtu(), can shrink the
  MTU of the rmnet endpoint netdevs.
- rmnet_add_bridge() and rmnet_del_bridge(), reachable via
  ndo_add_slave/ndo_del_slave through RTM_SETLINK IFLA_MASTER, flip
  port->rmnet_mode and port->bridge_ep on the real device's port; with
  bridge_ep pointing at a caller-owned device, rmnet_rx_handler() then
  forwards real-device ingress frames to it.
- rmnet_set_coalesce() rewrites the port aggregation parameters via
  ETHTOOL_SCOALESCE (ioctl) or ETHTOOL_MSG_COALESCE_SET (netlink),
  whose capability checks likewise only cover dev's netns.

A caller privileged only in the rmnet device's netns can therefore
rewrite the shared cellular data-path state owned by another netns, and
steer its ingress traffic.

Gate the rtnl paths with rtnl_dev_link_net_capable(), matching the
"require CAP_NET_ADMIN in the device netns for changelink" series
(vxlan/geneve, CVE-2026-68432), and gate the ethtool setter with
ns_capable() in the real device netns, mirroring the check dev_ethtool()
already applies to dev's netns.  Report the new rejections through
extack where one is available.

Fixes: 2abb5792387e ("net: qualcomm: rmnet: Allow configuration updates to existing devices")
Fixes: 60d58f971c1077 ("net: qualcomm: rmnet: Implement bridge mode")
Fixes: db8a563a9d9024 ("net: qualcomm: rmnet: add ethtool support for configuring tx aggregation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
v6:
- gate rmnet_add_bridge() and rmnet_del_bridge() on slave_dev, the
  RTM_SETLINK target the caller was actually authorized against,
  instead of rmnet_dev: a master moved into the real device's netns
  short-circuits rtnl_dev_link_net_capable() through the net_eq()
  check, so a caller only privileged in the slave's netns could
  otherwise attach or clear the bridge state of the real device's
  port
- add the Fixes tag for the commit that introduced rmnet_set_coalesce()
v5:
- also gate rmnet_set_coalesce(), the ethtool setter that rewrites the
  port aggregation parameters of the real device's port, per the
  Sashiko review
- report the new capability rejections through extack where available
v4:
- use the netdev comment style, per Subash Abhinov Kasiviswanathan
v3:
- cover rmnet_add_bridge() and rmnet_del_bridge() with the same gate;
  they mutate the same real-device port state via ndo_add_slave/
  ndo_del_slave and have no capability check of their own
- correct the impact wording: rmnet_vnd_update_dev_mtu() only reads
  real_dev->mtu; the MTU store lands on the rmnet endpoint netdevs via
  rmnet_vnd_change_mtu(), not on the real device
v2:
- drop Reported-by: (implied for the author), per Jakub Kicinski
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 40 ++++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 18 ++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf25..8df9e455110dd 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,16 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing the port settings requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	if (data[IFLA_RMNET_MUX_ID]) {
@@ -441,6 +451,19 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/* The rtnl path authorizes the caller against the RTM_SETLINK
+	 * target, slave_dev, but the port state mutated below is attached
+	 * to real_dev, which may live in a different netns.  Check the
+	 * capability against slave_dev so the master's netns, which the
+	 * caller was never checked against, cannot short-circuit the gate
+	 * after being moved into the real device's netns.
+	 */
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching a bridge device requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +512,22 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/* The rtnl path authorizes the caller against the RTM_SETLINK
+	 * target, slave_dev, but rmnet_unregister_bridge() below clears
+	 * the bridge state of the real device's port, which may live in a
+	 * different netns.  Check the capability against slave_dev so the
+	 * master's netns, which the caller was never checked against,
+	 * cannot short-circuit the gate after being moved into the real
+	 * device's netns.
+	 */
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 4f0ddcedfa979..1f4a3246f254a 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -4,9 +4,11 @@
  * RMNET Data virtual network driver
  */
 
+#include <linux/capability.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_arp.h>
+#include <linux/netlink.h>
 #include <net/pkt_sched.h>
 #include "rmnet_config.h"
 #include "rmnet_handlers.h"
@@ -240,9 +242,23 @@ static int rmnet_set_coalesce(struct net_device *dev,
 			      struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct net_device *real_dev = priv->real_dev;
 	struct rmnet_port *port;
 
-	port = rmnet_get_port_rtnl(priv->real_dev);
+	/*
+	 * The aggregation parameters live in the port attached to
+	 * real_dev, which may reside in a different netns.  The ethtool
+	 * paths only require CAP_NET_ADMIN in dev's netns, so require it
+	 * in real_dev's netns as well before mutating the shared port
+	 * state.
+	 */
+	if (!ns_capable(dev_net(real_dev)->user_ns, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing aggregation parameters requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
+	port = rmnet_get_port_rtnl(real_dev);
 
 	if (kernel_coal->tx_aggr_max_frames < 1 || kernel_coal->tx_aggr_max_frames > 64)
 		return -EINVAL;
-- 
2.53.0

