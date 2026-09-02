Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29771420482;
	Wed,  2 Sep 2026 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341722; cv=none; b=dsR4aUuijAXDLTYILZXunYBLyNi/H3CGEUt79UjE5Kwnxfyi7xD2JPVqU68SDuxjmmtvwe3XiYw4AK607/jHA+Ot/8LptcueKm9sN3aUSr7BonyZOEoT887yuVVPUMRgTbmxClHXkVtUQ8dtexuHMontIwAXQaJqZftyZnmSRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341722; c=relaxed/simple;
	bh=RIbxqo7/mIPWCvVT9qv+o1kCIjomZ4BJFjHwEDyAcio=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=WVIwRJIhyYImj1xvoj8oQYSC2alxORqjP2FcWmBAKnk0o14hXttrUNyibV16CjzV92sfQ8BGT303ZH8igUryaNE3F0Vo04BB01MNTw3bojyIiR+P22Bp3+HI1UpsNclPAfWhxHSwVmfUKNbkZ2j9VS0Ko4hdWahIpw5Rb0XrqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hZcyr55wwz5B12g;
	Wed, 02 Sep 2026 17:35:16 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6829Z4qx042580;
	Wed, 2 Sep 2026 17:35:04 +0800 (+08)
	(envelope-from he.peilin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 2 Sep 2026 17:35:06 +0800 (CST)
X-Zmail-TransId: 2afc6a97edcad43-ac904
X-Mailer: Zmail v1.0
Message-ID: <20260902173506784mJX3FrsAcjhcYqtGuZuxE@zte.com.cn>
Date: Wed, 2 Sep 2026 17:35:06 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <he.peilin@zte.com.cn>
To: <maxime.chevallier@bootlin.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <vbridgers2013@gmail.com>,
        <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Cc: <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldCB2NF0gbmV0OiBzdG1tYWM6IHJlbW92ZSBzb2Z0d2FyZSBWTEFOIHRhZyBzdHJpcHBpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6829Z4qx042580
X-TLS: YES
X-ENVELOPE-SENDER: he.peilin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 02 Sep 2026 17:35:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A97EDD4.005/4hZcyr55wwz5B12g

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
../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++-----------------
1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..2e3b0cf10d66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5021,24 +5021,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
return vlan_features_check(skb, features);
}

-static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
-{
- struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
- __be16 vlan_proto = veth->h_vlan_proto;
- u16 vlanid;
-
- if ((vlan_proto == htons(ETH_P_8021Q) &&
- dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
- (vlan_proto == htons(ETH_P_8021AD) &&
- dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
- /* pop the vlan tag */
- vlanid = ntohs(veth->h_vlan_TCI);
- memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
- skb_pull(skb, VLAN_HLEN);
- __vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
- }
-}
-
/**
* stmmac_rx_refill - refill used skb preallocated buffers
* @priv: driver private structure
@@ -5407,9 +5389,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
if (priv->hw->hw_vlan_en)
/* MAC level stripping. */
stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
- else
- /* Driver level stripping. */
- stmmac_rx_vlan(priv->dev, skb);
+
skb->protocol = eth_type_trans(skb, priv->dev);

if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
@@ -5901,9 +5881,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
if (priv->hw->hw_vlan_en)
/* MAC level stripping. */
stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
- else
- /* Driver level stripping. */
- stmmac_rx_vlan(priv->dev, skb);

skb->protocol = eth_type_trans(skb, priv->dev);

@@ -7964,9 +7941,8 @@ static int __stmmac_dvr_probe(struct device *device,
ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
#ifdef STMMAC_VLAN_TAG_USED
- /* Both mac100 and gmac support receive VLAN tag detection */
- ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
if (dwmac_is_xmac(priv->plat->core_type)) {
+ ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
priv->hw->hw_vlan_en = true;
}
--
2.27.0
