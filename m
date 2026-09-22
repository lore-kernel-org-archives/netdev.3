Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6114D9F7E;
	Tue, 22 Sep 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115984; cv=none; b=hmaBqdDRWzHQorEZIjmmMVk6kMbPFXCf+8eK2mhhad4DgT7hN+25Hmskv3yLxm2GOPX6CpcH4wtIL9BxedF0dXk36wYSqSl6eeBZBG8lcgEh/vZT25X+a3KLmpa5N2SiuDdI2twCJngMGQbRQco/13n6WyZiVljHhVe/VZ6qPDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115984; c=relaxed/simple;
	bh=Vyi64tb72xQ2z+rmY8X910c3XNm2hYottt4JmZpIWV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIu/2p9pW109qUgRfYirFFpveagISl8LRkMjK46oAWvTqirbxrN680oiElJxT0Z+rB8QcUFLfHYPthrKGot/On06+aeZRRyHOdhOG38JjSEYXlWcwWpCj0YWJTn2WK5gxcpI3RxJnvtojr1bSCAtjasImTUuySWA8p17DTaStlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dqo9GHVQ; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dqo9GHVQ"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9452BC0000E6;
	Tue, 22 Sep 2026 15:26:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9452BC0000E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115974;
	bh=Vyi64tb72xQ2z+rmY8X910c3XNm2hYottt4JmZpIWV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqo9GHVQklCxBFoi7Ke9KxCiOpzkd8zWr4SipCVekoXbQdskjjnDGw+6SafM28pnT
	 yS4SaVR5qrMzft/U6ATsYvxWtw91EApGIxqrmet/nYXI7IRa82o5V4OzWklbgdnvyn
	 4X0ukkTDBon8ou1Ht58KUe/qnVh44E1Zqr3FkkYs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 6C1F3B04;
	Tue, 22 Sep 2026 15:26:14 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 1/2] net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
Date: Tue, 22 Sep 2026 15:25:24 -0700
Message-Id: <20260922222525.3992167-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
References: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcm_sysport_probe(), priv->phy_dn is only initialized if the device
tree node has a fixed-link configuration (of_phy_is_fixed_link). When
connecting to a discrete MDIO-attached PHY referenced via 'phy-handle',
priv->phy_dn remains NULL. This causes of_phy_connect() during
bcm_sysport_open() to fail with -ENODEV since of_phy_find_device(NULL)
returns NULL.

Fix this by parsing 'phy-handle' via of_parse_phandle() and falling back
to of_phy_is_fixed_link(). Ensure proper of_node_get() and of_node_put()
refcounting lifecycle on both error unwinding and module remove paths.

Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: I714a31091e833c87fc766445b90cea53090fcec9
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4f0ec136b606..8a566b98f486 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2522,17 +2522,19 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	if (ret)
 		priv->phy_interface = PHY_INTERFACE_MODE_GMII;
 
+	priv->phy_dn = of_parse_phandle(dn, "phy-handle", 0);
+
 	/* In the case of a fixed PHY, the DT node associated
 	 * to the PHY is the Ethernet MAC DT node.
 	 */
-	if (of_phy_is_fixed_link(dn)) {
+	if (!priv->phy_dn && of_phy_is_fixed_link(dn)) {
 		ret = of_phy_register_fixed_link(dn);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to register fixed PHY\n");
 			goto err_free_netdev;
 		}
 
-		priv->phy_dn = dn;
+		priv->phy_dn = of_node_get(dn);
 	}
 
 	/* Initialize netdevice members */
@@ -2617,6 +2619,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 err_deregister_fixed_link:
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
+	of_node_put(priv->phy_dn);
 err_free_netdev:
 	free_netdev(dev);
 	return ret;
@@ -2635,6 +2638,7 @@ static void bcm_sysport_remove(struct platform_device *pdev)
 	unregister_netdev(dev);
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
+	of_node_put(priv->phy_dn);
 	free_netdev(dev);
 	dev_set_drvdata(&pdev->dev, NULL);
 }
-- 
2.34.1

