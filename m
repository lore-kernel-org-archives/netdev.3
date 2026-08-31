Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1339EF01
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146914; cv=none; b=LFOd4Ix05Oi+xFoczjOu4b0NQkF6A11w2JosELveCDlI09JPu8D30b7oHqo57w/nXux8AUTw4xSZQThngqKzYhELN5KUWH0T8v0j3D4sbcSvG1vbjgMAyk+Y38+nHEKT3Vwo+ATcsNRati5XPqPwHesd+RTgyK572DhdS0RYeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146914; c=relaxed/simple;
	bh=1gsJOXGf/E6xufKHweGQszf77SbKMiZsrOXoexOCrjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+lZIIVtFUQGX3QGcImwaaNZUCsYN9v3KxUUXUgYoTxKDVo0epxhfqdYaOqMagpHxtY1vZERo5BXlvYkCQuwB3pQ3v+NY8pNlfiJg0yghnl/OB53J+VJfnHjqU8blbzfK0XloXv+9a2vnRnEyYgdN9RkiJOBZBYDDcdYLuP3/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KdiIF7Lb; arc=none smtp.client-ip=95.215.58.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KdiIF7Lb"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1gsJOXGf/E6xufKHweGQszf77SbKMiZsrOXoexOCrjg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788146909; v=1; x=1788751709;
 b=KdiIF7LbLxZbd9HdVC4JgQ+SG9D2wHD3WYWCYxDlVVCSiKSUcVk2IAsKXS4AAw3pjvfI+kwJ
 wyEyFYPgFdw5gi8Memfmt22CybBdzf8qrol0MVzDgy7D7p3iyn3Fx/u4BSPB1f6PbDB0LNFOwmR
 4soGvoeQkO4aqEUrLBKO8Y4A=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d582106826e16177;
	Mon, 31 Aug 2026 03:28:29 +0000
X-Mizu-Trace-ID: d582106826e16177
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 31 Aug 2026 11:28:10 +0800
Subject: [PATCH net-next 1/2] netdevsim: add link speed support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nsim_speed-v1-1-7a651ee65738@kylinos.cn>
References: <20260831-nsim_speed-v1-0-7a651ee65738@kylinos.cn>
In-Reply-To: <20260831-nsim_speed-v1-0-7a651ee65738@kylinos.cn>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Add ethtool get/set_link_ksettings callbacks to netdevsim so the simulated
link speed and duplex can be queried and configured from userspace.

Move NSIM_LINK_SPEED_MAX and NSIM_LINK_SPEED_UNIT from dev.c to netdevsim.h
so they are available to both the devlink rate path and the new ethtool
code. The set callback rejects speeds exceeding NSIM_LINK_SPEED_MAX.

The default link speed is set to SPEED_5000 with DUPLEX_FULL, matching the
existing NSIM_LINK_SPEED_MAX definition.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/netdevsim/dev.c       |  6 ------
 drivers/net/netdevsim/ethtool.c   | 30 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  8 ++++++++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index feb88ccbbced..729ce80f6c83 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1138,12 +1138,6 @@ nsim_dev_devlink_trap_policer_counter_get(struct devlink *devlink,
 	return 0;
 }
 
-#define NSIM_LINK_SPEED_MAX     5000 /* Mbps */
-#define NSIM_LINK_SPEED_UNIT    125000 /* 1 Mbps given in bytes/sec to avoid
-					* u64 overflow during conversion from
-					* bytes to bits.
-					*/
-
 static int nsim_rate_bytes_to_units(char *name, u64 *rate, struct netlink_ext_ack *extack)
 {
 	u64 val;
diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 025ea79879f3..59768bd7b620 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -205,6 +205,30 @@ static int nsim_get_ts_info(struct net_device *dev,
 	return 0;
 }
 
+static int nsim_get_link_ksettings(struct net_device *dev,
+				   struct ethtool_link_ksettings *cmd)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	cmd->base.speed		= ns->ethtool.speed;
+	cmd->base.duplex	= ns->ethtool.duplex;
+	cmd->base.port		= PORT_OTHER;
+	cmd->base.autoneg	= AUTONEG_DISABLE;
+	return 0;
+}
+
+static int nsim_set_link_ksettings(struct net_device *dev,
+				   const struct ethtool_link_ksettings *cmd)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (cmd->base.speed > NSIM_LINK_SPEED_MAX)
+		return -EINVAL;
+
+	return ethtool_virtdev_set_link_ksettings(dev, cmd, &ns->ethtool.speed,
+						  &ns->ethtool.duplex);
+}
+
 static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
@@ -223,6 +247,8 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.set_fecparam			= nsim_set_fecparam,
 	.get_fec_stats			= nsim_get_fec_stats,
 	.get_ts_info			= nsim_get_ts_info,
+	.get_link_ksettings		= nsim_get_link_ksettings,
+	.set_link_ksettings		= nsim_set_link_ksettings,
 };
 
 static void nsim_ethtool_ring_init(struct netdevsim *ns)
@@ -250,12 +276,16 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	ns->ethtool.fec.active_fec = ETHTOOL_FEC_NONE;
 
 	ns->ethtool.channels = ns->nsim_bus_dev->num_queues;
+	ns->ethtool.duplex = DUPLEX_FULL;
+	ns->ethtool.speed = SPEED_5000;
 
 	ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
 	ns->ethtool_ddir = ethtool;
 
 	debugfs_create_u32("get_err", 0600, ethtool, &ns->ethtool.get_err);
 	debugfs_create_u32("set_err", 0600, ethtool, &ns->ethtool.set_err);
+	debugfs_create_u32("speed", 0600, ethtool, &ns->ethtool.speed);
+	debugfs_create_u8("duplex", 0600, ethtool, &ns->ethtool.duplex);
 
 	dir = debugfs_create_dir("pause", ethtool);
 	debugfs_create_bool("report_stats_rx", 0600, dir,
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 55aec41237b9..ce0d0dea00fb 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -39,6 +39,11 @@
 
 #define NSIM_HDS_THRESHOLD_MAX		1024
 
+#define NSIM_LINK_SPEED_MAX     5000 /* Mbps */
+#define NSIM_LINK_SPEED_UNIT    125000 /* 1 Mbps given in bytes/sec to avoid
+					* u64 overflow during conversion from
+					* bytes to bits.
+					*/
 struct nsim_sa {
 	struct xfrm_state *xs;
 	__be32 ipaddr[4];
@@ -95,6 +100,9 @@ struct nsim_ethtool {
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
 	struct ethtool_fecparam fec;
+
+	u32 speed;
+	u8 duplex;
 };
 
 struct nsim_rq {

-- 
2.55.0

