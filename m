Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99B515993;
	Wed, 23 Sep 2026 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165829; cv=none; b=l4wAh0cu7ibdtg+jo9DY7LZ/ZfNGHdzwge4EfXlLQUutvXwBNdMK/5FR3cnVGRwAJdwfepYTlUjiF7aQhtoYGMz7YbhGoxtFikIzOPAqskAdQ7sflr7TB2J4Z+uFJvEJSrHxQiiTsZQoNi+BMrXDHe2FIQng58K2RCfcAQtk0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165829; c=relaxed/simple;
	bh=aGVTECu7ZJVqCq/+QHudBaMZA8SqWjVeO6ErEPKgekY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxEZC/GRiHMYy25EqgMyWaGIbLtFMSfIx8PDlu1pJ7oFa1WFPnJX+jzqQ8XXP5Yb/K8YG3BNGrXvuy7jYMc91KxHddFdQdy1Xy3rx8SJKssWLWcL7WMthUvld8bZWxVHzBrGpenqp8OdkG9thFHLLt0oEWqBkeD7ilzU40KoBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=a8M7+0ZH; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="a8M7+0ZH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30917A4AA9;
	Wed, 23 Sep 2026 14:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790165815; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1daXE1zlgTL8Tx+9RcojuNP5Nay7xLtl+CUPnbTMZzU=;
	b=a8M7+0ZHN/U6YkXYD03HL+KWTh23ssI91kocTrymrEBXuwqmIhDuu+rPi/KJ4ILzczyyjV
	6GZaOQTNrsTWhojgszoODBVldRaj82KPOr8hJE+N+JPLjij8UWlblKlzbla2Z9PRusk/j+
	4UVXMZSc560iyAxOTP7N7UvOYBo1dZtNutcOvjQIrvQhao9j6InoUyNH4nxYYDjTDiVpOE
	ZtMjKps7EIeE8kIj5asu9i8y7d78LvCLfxGtULR11yhCBL4JfL+bP62SUcxuR/2P70H4zd
	VZmZCiuOeka2t5Rj2bybkgb4vgoWPAo2PmlBEo3h0/o5A2qsdSun99tv51/ybw==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: vadim.fedorenko@linux.dev,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] net: ethtool: let tsconfig reach a PHY-only timestamp provider
Date: Wed, 23 Sep 2026 14:16:43 +0200
Message-ID: <20260923121644.2194183-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923121644.2194183-1-nb@tipi-net.de>
References: <20260923121644.2194183-1-nb@tipi-net.de>
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

Drop the check on the get side, dev_get_hwtstamp_phylib() already fails
when there is no provider. On the set side also accept the default
timestamping PHY and move the check into ethnl_set_tsconfig() as the
validate callback runs without rtnl.

As this makes a netdev provider reachable without ndo_hwtstamp_get, test
for the callback before calling it.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 net/core/dev_ioctl.c   |  3 ++-
 net/ethtool/tsconfig.c | 20 +++++---------------
 2 files changed, 7 insertions(+), 16 deletions(-)

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
index 6be3aa5d4bc1..2b1cdd9b5a23 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/net_tstamp.h>
+#include <linux/phy.h>
 #include <linux/ptp_clock_kernel.h>
 #include <net/netdev_lock.h>
 
@@ -42,9 +43,6 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	struct kernel_hwtstamp_config cfg = {};
 	int ret;
 
-	if (!dev->netdev_ops->ndo_hwtstamp_get)
-		return -EOPNOTSUPP;
-
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
@@ -248,17 +246,6 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
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
@@ -313,6 +300,10 @@ static int ethnl_set_tsconfig(struct ethnl_req_info *req_base,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
+	if (!dev->netdev_ops->ndo_hwtstamp_set &&
+	    !phy_is_default_hwtstamp(dev->phydev))
+		return -EOPNOTSUPP;
+
 	if (tb[ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER]) {
 		struct hwtstamp_provider_desc __hwprov_desc = {.index = -1};
 		struct hwtstamp_provider *__hwprov;
@@ -459,6 +450,5 @@ const struct ethnl_request_ops ethnl_tsconfig_request_ops = {
 	.reply_size		= tsconfig_reply_size,
 	.fill_reply		= tsconfig_fill_reply,
 
-	.set_validate		= ethnl_set_tsconfig_validate,
 	.set			= ethnl_set_tsconfig,
 };
-- 
2.53.0

