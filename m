Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A84A440B;
	Tue, 22 Sep 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060921; cv=none; b=YnIxrul5yQWYkTyToaM5lAMiJNYOYYoMGr1vWjjhAftyOSEcLPSmZBFSvSYp/Z0cacxI2RtE4fYLFEbNrbCuJc/fciccpJwZ4aHA+W2hgPsGoT4coMdUbMFWr/C5suqwqQvmbW8GVRX/Q+e02Ak+SLMcNbIFYoDlz9/Svx9Q9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060921; c=relaxed/simple;
	bh=x3xw6LdrAgcIAd2OpnVOsn30UYdsvY/3nctUUs1Idr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kr7HE+1xDpIGPrNyDLKJShwm1oGCfxlI32WpMM0pNib1UqVOmKFuVV506Z9TFnaoiE8KWbVjJCleP0mIqSD0ic14jU6r6ySe5kDZ9ZQlPNxGvp6izfdsioFw47mnYcFkbBFhR9zAlXDSVPBIbiAGstL6pyzbP9SHrn8ZVVlaJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=d5cnEWOF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="d5cnEWOF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0C0BA4A34;
	Tue, 22 Sep 2026 09:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790060907; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=g+RJKI+8caUsE4jPIfDxSq4OFRVU+yGcHBFmweung/Q=;
	b=d5cnEWOF/t6wrKhbWfpQn7HnmOhd4jtmMUb4gUtVQg+eZ6MqPgRoLaaCG3BdL5w0oXDrie
	EZ7djcTTA/SesrOyXEEklRf1IUH8oAvmLWio3mEwoDVH6vrzqbo5JzXWM1dtDZYonlGQIU
	hCx7lXwQolQ7hn59SKDksZ5RzYvawPv5IdUz9efUhjPk05tjJOpzKBYBN/nN8JOxJIlD31
	0znT+ev42kZRjMB+FHZf7j52mzagPwBaa9+2pFPWcMTIqR6Gbf6JsVhQCa+nuctZ5hTJXN
	+xCYZZfJe+T+lOQYHwTJC2hMNwrb8OsHOFYUKPsGkyvWkhkaoPqxj9tUPzuRTg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: James Clark <jjc@jclark.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethtool: let tsconfig reach a PHY-only timestamp provider
Date: Tue, 22 Sep 2026 09:08:12 +0200
Message-ID: <20260922070813.1458713-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
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

Drop both checks and let the phylib helpers decide, like the ioctls do.

As this makes a netdev provider reachable without ndo_hwtstamp_get, test
for the callback before calling it.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Follow-up to 31995571219c ("net: don't require the hwtstamp NDOs when a
PHY provides timestamping"), which fixed the ioctl side:

  https://lore.kernel.org/netdev/20260918095540.34286-1-nb@tipi-net.de/

Tested on a Raspberry Pi CM4 with BCM54213PE.

 net/core/dev_ioctl.c   |  3 ++-
 net/ethtool/tsconfig.c | 15 ---------------
 2 files changed, 2 insertions(+), 16 deletions(-)

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
index 6be3aa5d4bc1..8c99b2dc26d0 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -42,9 +42,6 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 	struct kernel_hwtstamp_config cfg = {};
 	int ret;
 
-	if (!dev->netdev_ops->ndo_hwtstamp_get)
-		return -EOPNOTSUPP;
-
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
@@ -248,17 +245,6 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
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
@@ -459,6 +445,5 @@ const struct ethnl_request_ops ethnl_tsconfig_request_ops = {
 	.reply_size		= tsconfig_reply_size,
 	.fill_reply		= tsconfig_fill_reply,
 
-	.set_validate		= ethnl_set_tsconfig_validate,
 	.set			= ethnl_set_tsconfig,
 };

base-commit: f0b88fade64c6fe52e15b246097d10bb115d8af3
-- 
2.53.0

