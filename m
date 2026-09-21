Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D747668A;
	Mon, 21 Sep 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032486; cv=none; b=QDuGVSmSjZw3f8P8+XuKdFHBXHc5gb705QoohiwKn6dzluf99BgSRrr8V4yacSX/QlcJE8Z3JxRrtcJd8/2w9XvhW4STCIxrgHv7Vt5EQTh/vUM53zkF9aHfoGGq2Zfk1qT6+uTjc3y+o6JhmUhzA3LphgsrC11PZpy57jY1j2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032486; c=relaxed/simple;
	bh=vSEpRx87+JJSHfzugsNccsnqXxh50JVHNdY5tCgVU1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzhPwtHY8WCX7cGwVKQeJ3z7d4/WCMQJr8IvvWENOemXJo2i5YAzFO/JBW1hNvFU979m/tFf3MRUTv34cwAXftz06VSbOtastk5t2XdqEDFIci2D/ciHj7rbgR9qfs65atZfmBWXsq6MyPtu8ehPmzzy+VypxXRVk4ml+sdd9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T+Jv+IgY; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T+Jv+IgY"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2A887C0000F5;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2A887C0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032473;
	bh=vSEpRx87+JJSHfzugsNccsnqXxh50JVHNdY5tCgVU1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+Jv+IgYP2hzqYk71hKSPD+7MZxpmDz4swEfUCtF34llmtnLYp4c7mA9gRaJBJKzn
	 ZrKUL9fbz5YLJDZfSYiJUWfRp9O4KlYl1a6Z2Y2vZzSUN/rl4+jcLKH4y8wK8TG9fh
	 3yF4wGBUnHec3XLgFbute9nwRsOKUXIhMJra46UQ=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id C7309AD9;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
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
Subject: [PATCH net 04/12] net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
Date: Mon, 21 Sep 2026 16:12:57 -0700
Message-Id: <20260921231305.394773-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
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

Fixes: 186534a3f832 ("net: systemport: use the new fixed PHY helpers")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index b91a57540f55..78b96b192185 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2527,17 +2527,19 @@ static int bcm_sysport_probe(struct platform_device *pdev)
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
@@ -2622,6 +2624,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 err_deregister_fixed_link:
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
+	of_node_put(priv->phy_dn);
 err_free_netdev:
 	free_netdev(dev);
 	return ret;
@@ -2640,6 +2643,7 @@ static void bcm_sysport_remove(struct platform_device *pdev)
 	unregister_netdev(dev);
 	if (of_phy_is_fixed_link(dn))
 		of_phy_deregister_fixed_link(dn);
+	of_node_put(priv->phy_dn);
 	free_netdev(dev);
 	dev_set_drvdata(&pdev->dev, NULL);
 }
-- 
2.34.1

