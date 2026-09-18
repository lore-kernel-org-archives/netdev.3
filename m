Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F9233933;
	Fri, 18 Sep 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725362; cv=none; b=bD96DnAy3tnY8XkI5ULdoD0aKCyzdy8MOPTi96q8z6OzvdI7Opli/GfELsSdvTJsetMva65jb0KR6m7oObYYrlz9OVCd1TbaAqjR8oUdQaEqNkxc5wxy5f5Hureu96iuxrvx17KLqSHIG7QXBitL8Xkpctmj4TG8XmK3jmXGuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725362; c=relaxed/simple;
	bh=RloubzetdNOj3zTBg25Rv/u14MpkvCQNuwFPs/m9hxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3XkBYA4XlnavfVanVu9r3hHLKdNMUrYAVe4yx314FbWOKyS9vsWiZNbm2MwA+n3Zp2tRkdKJnUT5crUIWQAJacr3dgVvGNZIkwvuYUl8nUX4bftAwZsbj3OWnSujVTqb4NcUJla4vYTYLKVmxhtxyKKDL91kY6Q5aaABh7lMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=IPIKaSh6; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="IPIKaSh6"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FE6DA02D0;
	Fri, 18 Sep 2026 11:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789725345; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fdr599RH+uTsb7aefNgR/cD0PKRqtTo+C8uj7tmQJ7o=;
	b=IPIKaSh64fYTSmNViLLy94UAGJm0UZQS0g9nFgBe66v6NN+xxUIntI8KjzVwzL+wOSFLVu
	4Kc50f5LD/DF/MFjfRFEnlmqlrBY9x1XDwqWj+x9/V5jmDbyZ5BQ7NmLKx3iY5AJDEwCrR
	IUPIt7NTwJHqxUFj0cBBAYaESICxw85rj3OlIZYWZvt3OEZJvwiyAX15w99FMTVjWlzqAu
	DgekQu0vAnuDuE6rkMjWR5eykSUXkCqTkwp9n+rdJfLQ7wgo8k/LxQ3WWNdh9NKHAYiV5v
	/q/V5qw59SF4bh2tyeEGhRdXalZh6ZiXKeji0TehFl8kxAiwV14CLplCKspBmg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: James Clark <jjc@jclark.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: don't require the hwtstamp NDOs when a PHY provides timestamping
Date: Fri, 18 Sep 2026 11:55:40 +0200
Message-ID: <20260918095540.34286-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Removing the legacy ioctl fallback made both hwtstamp NDOs mandatory. A
device that only timestamps in its PHY implements neither, so
SIOCSHWTSTAMP fails with EOPNOTSUPP before anything looks at the PHY and
PTP stops working there.

The check only ever picked the legacy path. That path is gone, so drop it
and test where the NDOs are actually called.

SIOCGHWTSTAMP is new here, not restored. The old path went through
phy_mii_ioctl(), which only handled SIOCSHWTSTAMP.

Such a device now returns -ENODEV while absent instead of -EOPNOTSUPP,
like the ones that do implement the NDOs.

Fixes: 5062245a5a7f ("net: remove legacy way to get/set HW timestamp config")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This is an alternative to James' patch, which adds -EOPNOTSUPP stubs to
bcmgenet:

  https://lore.kernel.org/netdev/20260918030149.80398-1-jjc@jclark.com/

A quick grep finds a few dozen more drivers pointing ndo_eth_ioctl at
phylib without either NDO. So this is better fixed in the core than by
adding the same stubs everywhere.

Left the HWTSTAMP_SOURCE_NETDEV branch alone on purpose, because hwprov
only gets installed by ethnl_set_tsconfig(), which already wants both NDOs.

Tested on a Raspberry Pi CM4 (BCM54213PE, PHC from bcm-phy-ptp) with
bcmgenet unmodified, get and set with tx_type 1 and rx_filter 12:

  before 5062245a5a7f   get EOPNOTSUPP   set ok
  without this patch    get EOPNOTSUPP   set EOPNOTSUPP
  with this patch       get ok           set ok

tsconfig keeps its own copy of the check, but that one is older than
5062245a5a7f and never worked for these devices, so IMHO this is an
extra patch for net-next.

 net/core/dev_ioctl.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index a320e264eaaf..164643140a52 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -276,19 +276,18 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 	if (phy_is_default_hwtstamp(dev->phydev))
 		return phy_hwtstamp_get(dev->phydev, cfg);
 
+	if (!dev->netdev_ops->ndo_hwtstamp_get)
+		return -EOPNOTSUPP;
+
 	return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
 }
 
 static int dev_get_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct kernel_hwtstamp_config kernel_cfg = {};
 	struct hwtstamp_config cfg;
 	int err;
 
-	if (!ops->ndo_hwtstamp_get)
-		return -EOPNOTSUPP;
-
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
@@ -359,12 +358,18 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 	cfg->source = phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE_NETDEV;
 
 	if (phy_ts && dev->see_all_hwtstamp_requests) {
+		if (!ops->ndo_hwtstamp_get)
+			return -EOPNOTSUPP;
+
 		err = ops->ndo_hwtstamp_get(dev, &old_cfg);
 		if (err)
 			return err;
 	}
 
 	if (!phy_ts || dev->see_all_hwtstamp_requests) {
+		if (!ops->ndo_hwtstamp_set)
+			return -EOPNOTSUPP;
+
 		err = ops->ndo_hwtstamp_set(dev, cfg, extack);
 		if (err) {
 			if (extack->_msg)
@@ -390,7 +395,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	struct kernel_hwtstamp_config kernel_cfg = {};
 	struct netlink_ext_ack extack = {};
 	struct hwtstamp_config cfg;
@@ -413,9 +417,6 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 		return err;
 	}
 
-	if (!ops->ndo_hwtstamp_set)
-		return -EOPNOTSUPP;
-
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
@@ -441,15 +442,11 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 int generic_hwtstamp_get_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	int err;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (!ops->ndo_hwtstamp_get)
-		return -EOPNOTSUPP;
-
 	netdev_lock_ops(dev);
 	err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
 	netdev_unlock_ops(dev);
@@ -462,15 +459,11 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack)
 {
-	const struct net_device_ops *ops = dev->netdev_ops;
 	int err;
 
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (!ops->ndo_hwtstamp_set)
-		return -EOPNOTSUPP;
-
 	netdev_lock_ops(dev);
 	err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
 	netdev_unlock_ops(dev);

base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
-- 
2.53.0

