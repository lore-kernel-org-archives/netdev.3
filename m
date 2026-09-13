Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC13F823C;
	Sun, 13 Sep 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326079; cv=none; b=pwD7CHFpMdgcRYUwvJKGNxeo+Rab1Ls7S1A6/v+5OTii0ZwM77dPDiz6emHupd+Ytk0g54omJ2VnXklatIs37bp51UavJk1vs3C1SHyAdzhMawYebxcGkn9dbBW4hF7xuDw2fAcLs42KO9UUCUiJrkYoHT2ik1B8PEqi325eIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326079; c=relaxed/simple;
	bh=QUnmUulMgvP/tp9AGmw/PsOAgiMrxivKYmc0QrQNelo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k00qPfDcRRT9LYvdC5AEz6tlwN0sdrECaWAZmKHKn02P6i0vjNO0pKgsQAdqPHgpaTVHc1XASDUzpVrJeZwt9cC8Aku5M2ZTmLmZpdvCxBIVT4YbMs6JlpbC8VpyB9a4leIDbetPWq4MciOLQWZ98PKvOY7AiS8gzTDRkBDI838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=WHvOU3hr; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="WHvOU3hr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BB74A379F;
	Sun, 13 Sep 2026 21:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789326058; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=2H00QShfUp2kkrqvRZQGdNd/XvBzWDqU07m+hMGre3I=;
	b=WHvOU3hr4CrokQkF0vVVq7xeZMvACMbVFnwqtZdDQrso5hjnSDWCHQuhgZUsQ/oIF4ANen
	WAlds1KrrgzNi5opMawTtWywcCi/J8tRhT70Kf9Ua4ptw4G/3noOQ+EDyCHgDqYsoaP5+k
	xRSQawKSgYxiL7y9LrlU6pH5wwvlzWsBZcwRFYtAWSHqT8IqAU3pfnfWPQXcy+QNy/aI4z
	halA+Wmzlq0IO9vPSuMZN2D8J2cFPOaS8ZpnkP3qiEN+b2WzRPDuan6pe7Lil6vvdFBiv4
	GonfcXXHvEEQLOX+0BfVJFPf6FXx9HJHso1WL0M/FtpWTer2DXXD8n6pfQBd/Q==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	justin.chen@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net] net: bcmgenet: restore the hardware filters on open
Date: Sun, 13 Sep 2026 21:00:52 +0200
Message-ID: <20260913190052.939955-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_hfb_init() runs INIT_LIST_HEAD() on priv->rxnfc_list, which drops
every rule off the list, and bcmgenet_open() calls it on each ifup. Every
rule the user configured is silently lost:

  # ethtool -N eth0 flow-type ether dst $MAC action 0
  Added rule with ID 0
  # ethtool -n eth0 | grep -c Filter:
  1
  # ip link set eth0 down && ip link set eth0 up
  # ethtool -n eth0 | grep -c Filter:
  0

Initialise the lists once at probe and restore the rules on open, as
bcmgenet_resume() already does.

Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a2305e6428d1..b916080f4ff1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -749,8 +749,17 @@ static void bcmgenet_hfb_init(struct bcmgenet_priv *priv)
 		INIT_LIST_HEAD(&priv->rxnfc_rules[i].list);
 		priv->rxnfc_rules[i].state = BCMGENET_RXNFC_STATE_UNUSED;
 	}
+}
+
+static void bcmgenet_hfb_restore(struct bcmgenet_priv *priv)
+{
+	struct bcmgenet_rxnfc_rule *rule;
 
 	bcmgenet_hfb_clear(priv);
+
+	list_for_each_entry(rule, &priv->rxnfc_list, list)
+		if (rule->state != BCMGENET_RXNFC_STATE_UNUSED)
+			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 }
 
 static int bcmgenet_begin(struct net_device *dev)
@@ -3376,8 +3385,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
-	/* HFB init */
-	bcmgenet_hfb_init(priv);
+	/* Restore the filters, the MAC was reset above */
+	bcmgenet_hfb_restore(priv);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv, true);
@@ -4075,6 +4084,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	/* Mii wait queue */
 	init_waitqueue_head(&priv->wq);
+	bcmgenet_hfb_init(priv);
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
@@ -4272,10 +4282,7 @@ static int bcmgenet_resume(struct device *d)
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
 	/* Restore hardware filters */
-	bcmgenet_hfb_clear(priv);
-	list_for_each_entry(rule, &priv->rxnfc_list, list)
-		if (rule->state != BCMGENET_RXNFC_STATE_UNUSED)
-			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
+	bcmgenet_hfb_restore(priv);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv, false);
-- 
2.53.0

