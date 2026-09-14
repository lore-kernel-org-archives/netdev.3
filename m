Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3049F110;
	Mon, 14 Sep 2026 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398439; cv=none; b=Tqd9+IOwts+Xoixa2LbkjmRVWsV3DV79/353FMofCYB6lSz+lTF5mJz/Cjv6YREiQ+1ojDttEYQewB8aWRAT8lds7iZDY+LPt9lOxaKbIFWpmz0vX37EnDEAaNhO/FoCfbMfe3JfADAbqf9q4E7tbXwukIP914Y8opMpbSUz7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398439; c=relaxed/simple;
	bh=vJkUpC8pMzanCVN0b+dgLn8IQPxP5EU3npOWwvqvzWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMCOXShi1m4vkY4nFCJTHzqFhvvabadQEiAYcUk8gxx8Lx4u2xuGFrNkYhWiTMcOBi5X9zv4nhqBZOHGIK7B7DXAjqvn7btY00osy7iCBIFluyHzIKVdtE4m3yTCKJx8AAqOCJhl5kGpxuvX0al72t/SCOi+2tASzCGWIxrjJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IfUTewxe; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IfUTewxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3z
	dokcfPvG6aJZ9T1Ug1bQ5p7UlokNGesYVjy160PgU=; b=IfUTewxeg9PRQvmh8S
	XEtdkgdKAKeBMLaKE28v3n9oKamJhHt1qNVrproWGM+cVwfcWK/q/nhMvC6+/RLW
	u17NtrMSahpFDmb6ljDtpreHEeNiNrnHIh32G3m6Va2HvyI6tg8DuASAeUyFO17C
	lRzdFs8jJp0XZ3m/D2CfMVebk=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDn_3pkDahqCSeIAg--.42971S4;
	Mon, 14 Sep 2026 23:06:14 +0800 (CST)
From: peilinhe2020@163.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	he.peilin@zte.com.cn,
	jiang.kun2@zte.com.cn,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	pabeni@redhat.com,
	vbridgers2013@gmail.com,
	xu.xin16@zte.com.cn
Subject: [PATCH net v7 2/2] net: stmmac: remove software VLAN tag stripping
Date: Mon, 14 Sep 2026 23:06:12 +0800
Message-ID: <20260914150612.9798-3-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914150612.9798-1-peilinhe2020@163.com>
References: <20260914150612.9798-1-peilinhe2020@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn_3pkDahqCSeIAg--.42971S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw13WF4DJr15Cw1rKFykXwb_yoW5KFyrpa
	y7Aa4DCr4kArnrZa1Utw48ZFy3Aa45tayUJasYyw4Iqa1qkr9IqrnagFZxAFW8trZ3uw13
	G3yqvayUC3WDWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNL0OUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC0AYh0mqoDWaQmwAA3H

From: Peilin He <he.peilin@zte.com.cn>

The software VLAN stripping logic in stmmac_rx_vlan() was originally
introduced in 2014 by commit b93819854d6e ("stmmac: Add vlan rx for
better GRO performance.") as a workaround to improve GRO performance,
since at that time GRO could not handle frames with VLAN tags. However,
this limitation was resolved in 2015 by commit 66e5133f19e9 ("vlan: Add
GRO support for non hardware accelerated vlan"), which added GRO support
for non-hardware-accelerated VLAN frames. Keeping a software fallback
path for VLAN stripping is no longer necessary and only adds complexity.

Fixes: b93819854d6e ("stmmac: Add vlan rx for better GRO performance.")
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
Changes in v7:
- Resend as part of a series after adding Maxime's selftests fix as patch 1/2.
- No code change.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++-----------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9c9e95d66b09..854b488611b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5032,24 +5032,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
-static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
-{
-	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
-	__be16 vlan_proto = veth->h_vlan_proto;
-	u16 vlanid;
-
-	if ((vlan_proto == htons(ETH_P_8021Q) &&
-	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (vlan_proto == htons(ETH_P_8021AD) &&
-	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
-		/* pop the vlan tag */
-		vlanid = ntohs(veth->h_vlan_TCI);
-		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
-		skb_pull(skb, VLAN_HLEN);
-		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
-	}
-}
-
 /**
  * stmmac_rx_refill - refill used skb preallocated buffers
  * @priv: driver private structure
@@ -5418,9 +5400,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	if (priv->hw->hw_vlan_en)
 		/* MAC level stripping. */
 		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-	else
-		/* Driver level stripping. */
-		stmmac_rx_vlan(priv->dev, skb);
+
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
@@ -5912,9 +5892,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->hw->hw_vlan_en)
 			/* MAC level stripping. */
 			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-		else
-			/* Driver level stripping. */
-			stmmac_rx_vlan(priv->dev, skb);
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
@@ -7995,9 +7972,8 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
 	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
 #ifdef STMMAC_VLAN_TAG_USED
-	/* Both mac100 and gmac support receive VLAN tag detection */
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
 	if (dwmac_is_xmac(priv->plat->core_type)) {
+		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
-- 
2.43.0

