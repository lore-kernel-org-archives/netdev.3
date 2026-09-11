Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B631B131;
	Fri, 11 Sep 2026 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135979; cv=none; b=hONBfMabJPJHNdaUVWO4bZNTrr+GEufqVPde1NiJWtmH7ZRrgxeE/59EMh7s1fqylSrnQZCjSlDnvXTv5d+77d/ELjlA2i8R5YFZgLjI9pXfq8hCniLs6iAuVMnYmncZzknbBD+Qo2YxAftVcUnoOYz10TwG+4roCzttDvnBRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135979; c=relaxed/simple;
	bh=T8WxXO9FTT15rv4bA9384oDKwaVYNYFd2lxKZ3hSvq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLvjxaG6tImvul/ACJH1FzNfrfcwKxLaTw4pjrxbFpOQcC2l9DIIp2iJVEZ+9PbgZBTk3Drfocyt1SB7VNXUeUNue5OGjflyy6seJ5XrBkiB7jhsnRvtLPTfQdTINL5CwLyZMPbb4Tu/ec1ExTbTqCzCm0xi3hKXs2QTycyJu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VEZyFa43; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VEZyFa43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qE
	vj2N232ECgtoHTuAKDk68SEw+Xf7RHLDkBFRGAiTM=; b=VEZyFa43NvzEOVAeoV
	SFA2I1jwwejcsVZDx8C9CfhXV+rNzcNR3EYAUgUHskQl5edH/gO4j3IjcEH7qa4o
	U757JgN40ax4VGtVSKZAfPV5ly4dHphlheTceEWjV1sLASwgt+WO4Q79nBAcrAcf
	xkej0k02vS2iST8mb1TcMUgDg=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnP38ODKRqLAZVAA--.27919S2;
	Fri, 11 Sep 2026 22:11:26 +0800 (CST)
From: peilinhe2020@163.com
To: he.peilin@zte.com.cn
Cc: alexandre.torgue@foss.st.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jiang.kun2@zte.com.cn,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vbridgers2013@gmail.com,
	xu.xin16@zte.com.cn
Subject: [PATCH net v6] net: stmmac: remove software VLAN tag stripping
Date: Fri, 11 Sep 2026 22:11:25 +0800
Message-ID: <20260911141126.10592-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202609040845307827XHaxAT2PmgJc9jjPqfAP@zte.com.cn>
References: <202609040845307827XHaxAT2PmgJc9jjPqfAP@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnP38ODKRqLAZVAA--.27919S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw13WF4DJr15Cw1rKFykXwb_yoW5try3pa
	47Aa4DCr4kAr17Za1Utw48ZFyfAay5tayUJasYyw4ftanFkr9IqrnagFZxAFW0yrWfuw13
	K34qva4UC3WDWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhyCXUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbCzw7Je2qkDA7fkwAA3z

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
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
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

