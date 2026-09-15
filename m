Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2F248881
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460671; cv=none; b=r/uP0kbdom3OnnbWbh29jm4yIPEY3xnPzqqXX26FRYS3o0aiq5nFclb0OMSggJ8sX1JcduNBQlbooCt6z/hVVzpVP94YbDC7xzCWN552pOp//8DZFtROPdQ1cDWCl1RijKBBsOm5vZuGYvGG3QHRiYYSpuNyGc+Ptri/JdLKFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460671; c=relaxed/simple;
	bh=VaSVSvGNOEyimvK4Anlo4Z8wexqycRFEXogcDwlR67A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrN7s1dJdc0HqNgoryS4Fta3w77Kn3VSagWKCGSNKjFEyTBaTrN/JT5l7HcfMHRDo+mhr73imKf2nMUoNK1mwO6a+jlIpnut8lnhWXF+DUWI9Cwsw+UoE0Pkpz30qh/VgPQOXNfXc0jmfg7psCcu09AISw7/9v1PWmlThZv6M+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AZ4vnQsL; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AZ4vnQsL"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f20513so10391b3a.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789460669; x=1790065469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GkgxmHG570UDfiLBKnKDfBvipL+pxKJzUQX50Pt2PMw=;
        b=AZ4vnQsL3TZW1Wr28/Y1ZGo3lqhXyne4c2FxH5RPrRWpXnf4RhXTdVTCQyrWrBc/qC
         a73amykBPBR1Eujos0/9wua916z2PSj6QJPI87ixEhSGkmEaJSbG8YDZdCq3euW0uHxm
         ey2Op3MD3WsdT2wxaxAd5DZrUGTF2GRafXe7CtfOnmGR8p16N/0FiS6cCSKZCXu+rlUy
         UXKylnZi5RhRjz+Bubfv+xE2IadF0QzuWFimEs0LhFkp4dXFkqGWGm+VOZP0TnWLmxYo
         MtDWPVc+7igq6c0HhshNfVaki2pZtBneii4ByLLJjST6xpUeVrvUUCYj+tgNatL2JpDm
         3hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460669; x=1790065469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GkgxmHG570UDfiLBKnKDfBvipL+pxKJzUQX50Pt2PMw=;
        b=GunctobYirsMYsGMroVWWAKYrfH38q4MFGt4MgGEAkhYFtigfYulqzhyNfdZI2hVZN
         lL28Mq6LvtKGoPqSwF9uElE8A7i1VH5cyaT+QiLEpYCAf3vrg2OXW5KXH9ZuxaUpjNnd
         2BEKp+pTJKl+K7ZLhE8TRLWS56i2CM7c+KDzxsNyaL4H9qlVlw5Daq55vjbJcB5x734D
         qas/tOrLeCOXPpknbTwBbBBXOcW4P7LR54WZJPjf6ZB/ewrmBa3d2wy6h1eK/9MmZuNb
         AX6FDjCHcVqE1pf/+UZiO9IpgEApaZ3HSYWbfW8gCIqx1RP2rwRYdkqn4fG33/mfnj9g
         18Rw==
X-Gm-Message-State: AFuF++mMVf0CH8QzJOMmXu2dYAOTdTp9P1o9xid3nTvtJ4K4okKZsWM4
	xulK4hbC/fNkj7VIrTBIUL5uiIw+HIKjM84FlKyKcLS5skw1eNv/9txQ/rdRraFntg==
X-Gm-Gg: AYBFou05kEZ4LKJ95+1dXw9eLpujiIgpt0S8ypaWR3ATFw5L4SPVW4TR3RlK5AjILYo
	uz+zjqDKlB6/CuzUcxZSoGJHEkrp85no6VtTFT4D8HKJpqmpH1NSNzS2BtXDGgrzasmRNR082I2
	3HIclubOp9i5fZ96wb3GM1Kfq4ROv0TSy8n8jqYmTpWkkSZ+fZtSpkop7va4bLLhaz6OnXQxWax
	rMOWu0PbPFPeUCou/mHaAnu/XOLgXK2d+R67WLXh18jO5Z83Cl+VMggbVQl9eGB5Dg28Qqwj2he
	exNPKkb/9pHM5uBJWeOTtp1GszIv+oy25RQjJexeAAPqK2rR97Gq/cOXFe3WjtqgOJ/QQmVqD7V
	46EWSGgPISycKjBTRNOJDJP5PBDUEdEELI/9++hUAuCSrE3fQ6NCePwA4UH80L9LLp7ZEGbMUlO
	x1ErYRqjJPAoiAhigg/I+PDj4NRpPKo2RVpvYfQofKtZaue6h6ixUUOhvDA0TNQt2I7FKi4ERxl
	XOKif1/nwdbWDzLaLJAIC/3Nk5FiFrQfOyD4UcdE5iYB66ZY4UvYmop
X-Received: by 2002:a05:6a20:244e:b0:3d1:be60:281b with SMTP id adf61e73a8af0-3dd5285001fmr315141637.15.1789460668846;
        Tue, 15 Sep 2026 01:24:28 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365bb6ba0sm29374866c88.15.2026.09.15.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:24:28 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jakub@cloudflare.com,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH net] net: bcmgenet: restore the hardware filters on open
Date: Tue, 15 Sep 2026 01:24:24 -0700
Message-ID: <20260915082426.703892-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolai Buchwitz <nb@tipi-net.de>

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
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20260913190052.939955-1-nb@tipi-net.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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
2.43.0

