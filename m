Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D654A440D;
	Fri, 25 Sep 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344394; cv=none; b=Pd07fymS9Y0GT0fmyd7C23cAZ3IT3HJOEb6Ygk0zuZOGgFqNVfOOjXFHtl7DKZq3ecqakDGgWXrvU4XpmypZQstn2Hg0Ic+3/QDRqTJoNxRufBKfNopT+c5Xi3QJ3Avk1hNZ6965vJ0rYhM+waAGKs2NFlsYyHSOlfoaVNaSoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344394; c=relaxed/simple;
	bh=tjpI0mxH1A7DXSavprRg6nCrhH41OF4GhZZemOfO4j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0ujhPpW0v3bw+7VszLV4qzfeyzDxkVLJZXGbP5NKbU2cTewqjKUghRXPrRMgWggdrcMZ8yST3chZHMCPyL1alzEaoDAa3Ql+crlXyRyBlxVkrqLSbTVDJ59NI2a5F7bwy0JulW2AA5TjFiJnzj+n/XUc+fmKYGDMu40XKjCTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=qVHfOK30; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="qVHfOK30"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE61CA4ABB;
	Fri, 25 Sep 2026 15:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790344390; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kzsals/lWEL0QFsarvpTiSLncXUNdrEQnFPKlj+bABk=;
	b=qVHfOK30Urb+3KqcTx84TG9gOecXJj2tcWAKIMlLYDFWMbnFYmgR9Z0xSYFuHOCUaeqasL
	1BBteh6KpNErqBg/N83IMTfjJR4p+0bXvEin2ONSqhSIM795bZix+brFueV5ChUR7sa/er
	VxxxGastm3eYSJscoDjdQ3dzjX6Zcp5CDnt582KvmkA7eqIxDCJ163RYpEWWo5RXxRlcpp
	+HxMDkl4+LPREJai++c7ryq+1DlCQrV+6U4NCVRx3PYmHKkjKEQHY4RhNBZ+AYoXJ6IY8U
	KE6sgQ5OLz5WIzR7NPksWFwemKjnmYg8TGPm9Su6HMvQSSmXF2FLH8SvcEzf+w==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] net: ethtool: let tsconfig reach a PHY-only timestamp provider
Date: Fri, 25 Sep 2026 15:52:36 +0200
Message-ID: <20260925135237.3432266-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925135237.3432266-1-nb@tipi-net.de>
References: <20260925135237.3432266-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

TSCONFIG_GET and TSCONFIG_SET reject a device that implements neither
hwtstamp NDO, even when its PHY can serve the request. The ioctls they
meant to replace handle it, so the two interfaces disagree on the same
hardware and user space has to pick one.

Accept the default timestamping PHY and an already installed provider on
both sides. On the set side the test moves into ethnl_set_tsconfig() as
the validate callback runs without rtnl. On the get side it stays ahead
of ethnl_ops_begin(), so a device that can serve nothing keeps failing
with EOPNOTSUPP and a dump still skips it rather than stopping there.

A netdev provider needs ndo_hwtstamp_set to be programmed at all, so
don't pick that source without it, and test for ndo_hwtstamp_get before
calling it.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 net/core/dev_ioctl.c   |  3 ++-
 net/ethtool/tsconfig.c | 24 ++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 164643140a52..f6029f60c1dc 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -267,7 +267,8 @@ int dev_get_hwtstamp_phylib(struct net_device *dev,
 		    hwprov->phydev)
 			return phy_hwtstamp_get(hwprov->phydev, cfg);
 
-		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
+		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV &&
+		    dev->netdev_ops->ndo_hwtstamp_get)
 			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
 
 		return -EOPNOTSUPP;
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 6be3aa5d4bc1..2db0e7ba8b9f 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/net_tstamp.h>
+#include <linux/phy.h>
 #include <linux/ptp_clock_kernel.h>
 #include <net/netdev_lock.h>
 
@@ -42,7 +43,9 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	struct kernel_hwtstamp_config cfg = {};
 	int ret;
 
-	if (!dev->netdev_ops->ndo_hwtstamp_get)
+	if (!dev->netdev_ops->ndo_hwtstamp_get &&
+	    !phy_is_default_hwtstamp(dev->phydev) &&
+	    !netdev_ops_lock_dereference(dev->hwprov, dev))
 		return -EOPNOTSUPP;
 
 	ret = ethnl_ops_begin(dev);
@@ -248,17 +251,6 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
 	return ret;
 }
 
-static int ethnl_set_tsconfig_validate(struct ethnl_req_info *req_base,
-				       struct genl_info *info)
-{
-	const struct net_device_ops *ops = req_base->dev->netdev_ops;
-
-	if (!ops->ndo_hwtstamp_set || !ops->ndo_hwtstamp_get)
-		return -EOPNOTSUPP;
-
-	return 1;
-}
-
 static struct hwtstamp_provider *
 tsconfig_set_hwprov_from_desc(struct net_device *dev,
 			      struct genl_info *info,
@@ -272,7 +264,7 @@ tsconfig_set_hwprov_from_desc(struct net_device *dev,
 	int ret;
 
 	ret = ethtool_net_get_ts_info_by_phc(dev, &ts_info, hwprov_desc);
-	if (!ret) {
+	if (!ret && dev->netdev_ops->ndo_hwtstamp_set) {
 		/* Found */
 		source = HWTSTAMP_SOURCE_NETDEV;
 	} else {
@@ -313,6 +305,11 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
+	if (!dev->netdev_ops->ndo_hwtstamp_set &&
+	    !phy_is_default_hwtstamp(dev->phydev) &&
+	    !netdev_ops_lock_dereference(dev->hwprov, dev))
+		return -EOPNOTSUPP;
+
 	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER]) {
 		struct hwtstamp_provider_desc __hwprov_desc = {.index = -1};
 		struct hwtstamp_provider *__hwprov;
@@ -459,6 +456,5 @@ const struct ethnl_request_ops ethnl_tsconfig_request_ops = {
 	.reply_size		= tsconfig_reply_size,
 	.fill_reply		= tsconfig_fill_reply,
 
-	.set_validate		= ethnl_set_tsconfig_validate,
 	.set			= ethnl_set_tsconfig,
 };
-- 
2.53.0

