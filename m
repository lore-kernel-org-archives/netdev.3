Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389313E7BBF;
	Tue,  1 Sep 2026 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229733; cv=none; b=PGdePVJap1SzRyJXdUc3iQAo81d0e3gDWv04Nr24MBTnZqFMNb33jhRFekXH2Vl9lTd1MEOh4Xm1lEcjl4aWH9drM4nlFn85vV31B+iU1buW1u2IRU6TQueU99eXt6co6weuVynoC7BaCqTGgkZPA5BSmTg8JW+iWN4XC/NA4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229733; c=relaxed/simple;
	bh=/uBjX4LxQBoAdOyHrFjv0EyZiRoi58ZS2N2lJDloRCg=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=bZmMTqmuBd9k9gMxNQ3Bcudjl14hbm1NPiOSc6vIoQVEYJEiqfFxebttNi88UY33ug2wALmPNC4Kilpkmt/N8r0PPl6AUSC1psur6lWhkbaOUY2GHFafiUfirhqTs1n7ZG16Owaq6uPeFNV/MThqf6jQlpeSd5mWKYTgH9qytt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hYqY54NlBz5B0rb;
	Tue, 01 Sep 2026 10:28:41 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6812Sbd0005903;
	Tue, 1 Sep 2026 10:28:37 +0800 (+08)
	(envelope-from he.peilin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Tue, 1 Sep 2026 10:28:38 +0800 (CST)
X-Zmail-TransId: 2af96a963856934-b1ee6
X-Mailer: Zmail v1.0
Message-ID: <20260901102838839qOylm1OxcNUptu0TbB_Cd@zte.com.cn>
Date: Tue, 1 Sep 2026 10:28:38 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHQgdjJdIG5ldDogc3RtbWFjOiByZW1vdmUgc29mdHdhcmUgVkxBTiB0YWcgc3RyaXBwaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6812Sbd0005903
X-TLS: YES
X-ENVELOPE-SENDER: he.peilin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 01 Sep 2026 10:28:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A963859.000/4hYqY54NlBz5B0rb

Problem
=======
When the stmmac driver has NETIF_F_HW_VLAN_STAG_RX enabled by default,
but the hardware does not support hardware stripping of ETH_P_8021AD
(VLAN 802.1ad) tags, the driver falls back to software stripping in
stmmac_rx_vlan(). If the received VLAN packet is fragmented and the
VLAN header resides in the non-linear part of the skb, the driver
attempts to pull the header without first ensuring it is linearized.
This leads to a kernel BUG in __skb_pull() due to invalid header
access.

Crash log
=========
[   72.212903] kernel BUG at include/linux/skbuff.h:2700!
[   72.212908] Kernel BUG [#1]
..
[   72.212958] [<ffffffff846919d2>] eth_type_trans+0xe2/0x168
[   72.212962] [<ffffffff844672e2>] stmmac_rx+0x602/0xc58
[   72.212966] [<ffffffff84467984>] stmmac_napi_poll_rx+0x4c/0xb8
[   72.212970] [<ffffffff84635246>] __napi_poll+0x2e/0x1e0
[   72.212975] [<ffffffff8463596e>] net_rx_action+0x31e/0x388
[   72.212979] [<ffffffff83c329b0>] handle_softirqs+0x170/0x358
[   72.212983] [<ffffffff83c32cc6>] __irq_exit_rcu+0xd6/0x100
[   72.212986] [<ffffffff83c32ee0>] irq_exit_rcu+0x18/0x28
[   72.212989] [<ffffffff84895b1e>] handle_riscv_irq+0x66/0x78
[   72.212994] [<ffffffff84896728>] do_irq+0x60/0xa0

Root cause
==========
In the software VLAN stripping path, stmmac_rx_vlan() does not call
pskb_may_pull() to ensure that the Ethernet header plus VLAN header
are in the linear area. As a result, __skb_pull() operates on an
skb with insufficient linear data, triggering the BUG check.

Solution
========
The software VLAN stripping logic in stmmac_rx_vlan() was originally
introduced in 2014 by commit b93819854d6e ("stmmac: Add vlan rx for
better GRO performance.") as a workaround to improve GRO performance,
since at that time GRO could not handle frames with VLAN tags. However,
this limitation was resolved in 2015 by commit 66e5133f19e9 ("vlan: Add
GRO support for non hardware accelerated vlan"), which added GRO support
for non-hardware-accelerated VLAN frames. Keeping a software fallback
path for VLAN stripping is no longer necessary and only adds complexity.

Rather than fixing the issue by adding pskb_may_pull() checks to
stmmac_rx_vlan(), remove the function entirely. Additionally, ensure
that hardware VLAN stripping features are only reported via
dev->hw_features when the hardware truly supports them.

Fixes: b93819854d6e ("stmmac: Add vlan rx for better GRO performance.")
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++-----------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..790b7362048e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5021,24 +5021,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
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
@@ -5407,9 +5389,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	if (priv->hw->hw_vlan_en)
 		/* MAC level stripping. */
 		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-	else
-		/* Driver level stripping. */
-		stmmac_rx_vlan(priv->dev, skb);
+
 	skb->protocol = eth_type_trans(skb, priv->dev);

 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
@@ -5901,9 +5881,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->hw->hw_vlan_en)
 			/* MAC level stripping. */
 			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-		else
-			/* Driver level stripping. */
-			stmmac_rx_vlan(priv->dev, skb);

 		skb->protocol = eth_type_trans(skb, priv->dev);

@@ -7965,7 +7942,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
+	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
 	if (dwmac_is_xmac(priv->plat->core_type)) {
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
-- 
2.27.0
