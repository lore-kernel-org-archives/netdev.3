Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62C44E05B
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502215; cv=none; b=Elv4a3+nXxtWvT1mYTXGgt5g6nAG0buFTPN3hNEo7jEj9PzCgIOjzdM9UI+mqYXwhRY91QQ9q1Nkh5cStPSulXCzWtBiNFhTwyUZYwCD4lqOyIKXxoD6DrSiLN0hrFeNclKT/x9a+JoP2yrOU1aFxlkd84PvshQieHdfo09lSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502215; c=relaxed/simple;
	bh=rZLpj21N4VA3IiZfTn1FGsRHE12qb2+V/np4zmO70lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeRrbOezBAM6v+EeWngHoiDE+5EXd3V8gFH+MGaW6DjwA11HRZV5PYxqV9llPlf96n8MKIh8XFaFG3sDNaa+RLBSfX3mTOGXYTpCHn4XxleDJU1Gwss4l5G9MLhJB8f5d5ULtT78xXCssgHqjk0oUw2uNoGF8Hc3MJrAt1eh5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpyITVuI; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpyITVuI"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d0d5ae11so1375611cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789502211; x=1790107011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFCJ2lFr9tJixEGi8k+dG6GBDM56HP737LMGurM7J9k=;
        b=rpyITVuIhtWqQ6vnsYauT4ipybwUadVrwCeGp21aQqYuDsUHNs5riXrVopkqn0MCvv
         8etWfrsQKa6+8iKhM5jyQL3JPSlHdHqNaIo4qd0gbuoraJ4v4QLNb0XpY7/0RB+TmG/i
         CLnurcFdvkJHNZe5nlYKP5Op8YmXLTralVr9/uBlmEL7k0P7fq9wQAGrU/t4eQtMFABS
         Z3fgH0T6N/Pg8QtvcBDHoWQ6ORtxKOQMfjydgZOUV8W+AQdBMWPBvnEStqfjHvVHPry3
         ZA76YGYRd/vW10PU3xrVT5L31jbGmROyh9iQy+30XrecMQZ+8kljhj9P/tEtHfr4qwSX
         FHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789502211; x=1790107011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFCJ2lFr9tJixEGi8k+dG6GBDM56HP737LMGurM7J9k=;
        b=pn2X8DbbHOPWYwqWYeZfpUg2LQcrW4IAs3MyR/2/4sdUKltbiWxRDCbLDuS/9mxJk9
         tqqgf6bHgbcFpBhYoIe3AQAH3Sx4msYrpxrl7vLFuRQxDF1pjYGCnS43eXvXTUDyaKix
         dTij86dWsJu4JSUKM7PfVlG6KsCZL/68J9M3dULYv4200tG+yhnynFpDKtgDRDQiMJ10
         XTIWTiChnj/8sZoy/OpPk1j4a+6hJWdJv2rvBhRhwt5exYMxrCXEY1pDJ0g4d63wIuVI
         y+K8pdsL84oB4zD4pn+jrsYckb9Lfpe19CqPNNHSzF/PO7g80VWWHnrplU8Cj/+5RoKn
         mmsA==
X-Gm-Message-State: AFuF++ne4+ZQcm3mQ/+e+6rLsIjm3WdLM7ANpPAgkmZgc7W0mscMRB/D
	vNEeCG2POqoqjrzeogKOwKQxiReqAJUnMj2Brc2Vw9xtUXRT4/+NQ2yK8rEFYpueJoc=
X-Gm-Gg: AYBFou2PHKzQ1f5l7eBlV57Zm5On2XwGIzoryT7q2ZI9OeAfQSNdfa2ubEYEU4R6STn
	oLH8wC3aXUYsDTqPI12DWs71GaPeGQLXt8EB5LHHMkZRLa3DruHFrJ5YHsJmA3+B6Hdzc4yu7rk
	968DX6TrwSj67DzkmdEjmZeBiej6yWwsG037HxINPQcsgwoh+XR7ECf8Z1WOYhPIhPxJ1Igq/wg
	t8eHfK5j2qtPUnhCGsIjvmWFia4fv3VrUNycMJN3FFGiKuIQma0wZLtSDHelNSIIFld9YDUUC/A
	ZbUDYvB8zrcW/xlbD2Ofq5s1SoEz9qramPpp9tP+0/z9ouhyLqLVOCgUrC3ThijFPISMXfg+Tja
	TkIKkYXQKZSbYzAZ192y9uzSJFvtwi8DvtMUfdyOBuzWiGMUJN7jWxmqugUrhmfTjxdOZN0+hXK
	4hRaRYQ5vik0t1pAKbLxljtvHAVBO4XX9SIfSsWQs8t3ToCvsysHtj2W5HLrOWlzrHm0/Eomsqw
	XXbATY=
X-Received: by 2002:ac8:5f8e:0:b0:530:b2e4:4e30 with SMTP id d75a77b69052e-5312640eab1mr35615791cf.61.1789502211210;
        Tue, 15 Sep 2026 12:56:51 -0700 (PDT)
Received: from SurHub.localdomain ([195.242.214.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be946f0sm6691096d6.27.2026.09.15.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:56:49 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	horms@kernel.org,
	kuba@kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH net-next v8] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Tue, 15 Sep 2026 22:56:42 +0300
Message-ID: <20260915195642.1912-1-suruurism@gmail.com>
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

The gates cover the configuration paths only.  Teardown (RTM_DELLINK
reaching rmnet_dellink(), and rmnet_config_notify_cb() unregistering
the bridge when the slave device is deleted) is intentionally left
ungated: link deletion is normal netdev lifecycle behaviour, and the
changelink series this matches (vxlan/geneve, CVE-2026-68432) gated
only the configuration paths.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
v8:
- drop the Fixes and stable tags, per Jakub Kicinski
- drop the explanatory comments added next to the gates, per Jakub
  Kicinski
- shorten the extack messages to "request modifies device in another
  netns", per Jakub Kicinski
v7:
- state explicitly in the commit message that the dellink and notifier
  teardown paths are out of scope, per the Sashiko review
- drop the master-moved-into-the-real-device-netns rationale from the
  rmnet_add_bridge() comment: on the add path do_set_master() resolves
  the master in the slave's netns, so the rationale only applies to
  rmnet_del_bridge(), where the master comes from
  netdev_master_upper_dev_get()
- use the netdev comment style in rmnet_set_coalesce(), per the
  Sashiko review
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
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 21 ++++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 11 +++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf25..8bf385ab44a90 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -312,6 +312,12 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
+	if (!rtnl_dev_link_net_capable(dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "request modifies device in another netns");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	if (data[IFLA_RMNET_MUX_ID]) {
@@ -441,6 +447,12 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "request modifies device in another netns");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +501,14 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	if (!rtnl_dev_link_net_capable(slave_dev, dev_net(real_dev)))
+		return -EPERM;
+
+	port = rmnet_get_port_rtnl(slave_dev);
 
 	rmnet_unregister_bridge(port);
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index 4f0ddcedfa979..53802b485a813 100644
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
@@ -240,9 +242,16 @@ static int rmnet_set_coalesce(struct net_device *dev,
 			      struct netlink_ext_ack *extack)
 {
 	struct rmnet_priv *priv = netdev_priv(dev);
+	struct net_device *real_dev = priv->real_dev;
 	struct rmnet_port *port;
 
-	port = rmnet_get_port_rtnl(priv->real_dev);
+	if (!ns_capable(dev_net(real_dev)->user_ns, CAP_NET_ADMIN)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "request modifies device in another netns");
+		return -EPERM;
+	}
+
+	port = rmnet_get_port_rtnl(real_dev);
 
 	if (kernel_coal->tx_aggr_max_frames < 1 || kernel_coal->tx_aggr_max_frames > 64)
 		return -EINVAL;
-- 
2.53.0

