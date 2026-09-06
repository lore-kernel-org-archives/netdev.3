Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A71940B0
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697956; cv=none; b=K/pTrIy1PL5swuMJ1wNqD6dKLovNLG9mVSKplEW5pqU3rAeAsNeuzpBag0c3fdJVLcQa86k93npiA7dcSD8QrHqLRZmSjiZ7PgL2RdnkEoPCql+2+VDL9PE7I+2LlWclvwzObkQv2WuFqY8a3jpWMs/CKsGAccCXF0PtvaOXjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697956; c=relaxed/simple;
	bh=Sgcn14L0g02bItZ04E+YkjO9u5qGmAuMZdZAS26Crys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=asQq1ltUtHCQ+SpYaPvdIDgaXIW0cXBHuPeNkyLpjYPEb78SRM5qMEZktR55GrX3i/z+vYYlryzcSMN3NpKlvLHfwNmobwMnGJG30yZLpufr3vlzXWwj0ZjHi9FDPR0HPdNK/dxDE2L+vTLBn8QiYxtUI0HV4NxsJTLOB0VejIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGLJaZ1K; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGLJaZ1K"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so19538825e9.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788697953; x=1789302753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bRw+3griMmmm9uOADm1tBgo3gIoZKRYcTHKvyuLxuU=;
        b=YGLJaZ1KysSaNP7GwB5C2qbCFuItqtBZxoquO1FvJwmB81AsgomrPHuORDh8DnqkSH
         CWP/XY8bf6svNrFM4zW9y+/RvmSmpZYtCIMLVD0ImcJrzYURtCVNVkf5fzXkSMco1pKR
         p4EMhJ8VL9F1ibBkob9lH4P0hNTWavO2gitA6C2lhL+rVHlUW12JErHJdiJQiPGc54jh
         7MH62BIs2iKCorX6koKWvTNj4Pw+LRD3TcotNqm2i/YJPtRL1s7omC20ApEXCWGyadQ9
         D2t6pdSHvbpujXuUZRLwkKha5hChF2wvDGX4hvQ46nnE/k5O7xhDhQJf5Mcw+k+f1E9e
         jzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697953; x=1789302753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7bRw+3griMmmm9uOADm1tBgo3gIoZKRYcTHKvyuLxuU=;
        b=tH+srFThPoZUICyYC44Mj6WY86zIKU22PPFEEWPTxsC+jd6+kbFXgKHCEY6X4h1Qc4
         JHDYvp3Mv6URUfewZfeboHWgl6x97gldw03SEQNGEoIWKEi2M2nWMZX1uWPas4DeJzjI
         ypxfKP7TFkzeny8w3cLHEOrHjFAIGj1/5yuss8ZQ66pWKof9niKD7bF09MZUkmc+rmuH
         CVwq4IZz3HXUyQu5/11Uv+/DHh7ywo4dze3lPRcPFpQ/64+yPkB6ARka2FwjqS3ggwn0
         Wy8w7swNH9tN5MQ41skaNhkLqQAeHmAb5ctrNAYiwkes4rDB7ZE17pVguxPoitSqi6H/
         CGMA==
X-Gm-Message-State: AFuF++kIjfvTXu4bEEe60at/Xmeu1jb5062dUrQavSZEW+FM1ffsyERy
	TuwzzIVxv/ef1iwrbJ0Au72ghdJsxhuX+YjreQ6R9LfxjRiz3BCLNQ8VxBvc4g==
X-Gm-Gg: AYBFou1oEFIHCT4wlPTOkVH/9ZKFoaQ706yxlbdjhiCZPT8qKPffr9yqxBPnx1L5MQm
	mLUGciAPScE9wOpj4E67QKAiQDVR2zzM9xiWTKrjyKmRmanBt1S9teyBX0zwjUycv3OHDvvSPtw
	jXfhMh6TJ5/sJTPg1vHoQb3t6t+ghg+nDPnFRA17eBCVEDlxLM817e70Y/xCicqN59loIkv6d5o
	gqIXvymyRb5jXnjb/9CvU1rnoQHIOxTR7G0opg5MENiXhMfv0xXHtSLci1on+3/XzEBt5YmQ5AI
	NTbbfVNVUDol86HQIpFEZonhbajLmLm0kSSFOtmAbaROzX54JMexvo9Bx7twBktCxWVxal7uiLb
	z7pwy+nEZYZOpspAUQXbxNBePFVADVxRY82czQzWPS1R1UC/hV9adkg/yoWuGM0eK5LDZsqlEvO
	MZGN24Fjxs22FHSDj92ASDCgSDiCG17VttgFvWARBsVg6kEeMA7t0rsdSSrED8terivKy8
X-Received: by 2002:a05:600d:8481:20b0:49c:fde6:8b39 with SMTP id 5b1f17b1804b1-49cfde68bacmr97434185e9.29.1788697952905;
        Sun, 06 Sep 2026 05:32:32 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d0af538d0sm65779485e9.8.2026.09.06.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:32:32 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
	sean.tranchetti@oss.qualcomm.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH net v5] net: qualcomm: rmnet: require CAP_NET_ADMIN in the real device netns for config ops
Date: Sun,  6 Sep 2026 15:32:11 +0300
Message-ID: <20260906123212.10829-1-suruurism@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
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
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 33 ++++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 18 +++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index bed6f63facf25..7757fcb2fcc9f 100644
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
@@ -441,6 +451,16 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 	struct rmnet_port *port, *slave_port;
 	int err;
 
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but the port state mutated below is attached to real_dev, which
+	 * may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Attaching a bridge device requires CAP_NET_ADMIN in the real device network namespace");
+		return -EPERM;
+	}
+
 	port = rmnet_get_port_rtnl(real_dev);
 
 	/* If there is more than one rmnet dev attached, its probably being
@@ -489,7 +509,18 @@ int rmnet_add_bridge(struct net_device *rmnet_dev,
 int rmnet_del_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev)
 {
-	struct rmnet_port *port = rmnet_get_port_rtnl(slave_dev);
+	struct rmnet_priv *priv = netdev_priv(rmnet_dev);
+	struct net_device *real_dev = priv->real_dev;
+	struct rmnet_port *port;
+
+	/* The rtnl path only checks CAP_NET_ADMIN against dev_net(dev),
+	 * but rmnet_unregister_bridge() below clears the bridge state of
+	 * the real device's port, which may live in a different netns.
+	 */
+	if (!rtnl_dev_link_net_capable(rmnet_dev, dev_net(real_dev)))
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

