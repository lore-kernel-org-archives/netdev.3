Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885973ABD83;
	Sat, 19 Sep 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822757; cv=none; b=BC8PPISWu/UT5CfyG9jKDkNuU8e170Di7Wh7dpYiHFSc5I8+MhY2/6LqKTM23PPKpFxP+yWhWzQq12JVBBiJNkd7a59ElS+zpv3oPLS1/pj5/D1kPVH2UsZShHIhejbLbhvjssAoGZoP6epuRB8kup5xK007waJ89PxCOy1rB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822757; c=relaxed/simple;
	bh=82pJ8jqo0Hv0DgMxJ0OSWYS4mlArumlZ1KUulhZucAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sen3c04i6iNpLlyoYAwiCARjIeG0y3UdDB0zQhqc0LapvnxvCC9zf9QS8puj15XUcE7jYy2gDZh6as8HrM7ndqRzZHEXmRQNI2Lr4GKfZp62t2ZTl4os1H9QzrJ/2RdfH8xvfNcMqUjL60dC0FBQIjtm17KvKJz6wseVC4eei6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WPBFlyZT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WPBFlyZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=t7
	74MCqksyko10xJEtl8EAD6NNryFWQ5tmKdqLGsvVE=; b=WPBFlyZTLgdRkoPIU8
	TiT7Xly5oc7sOZ3Sx3npWErNL6y9AYUYc3bjdBFv+U5hOxjh8MeBm/2f/fJJr/ZP
	WkSVwyTZVCxVIQYR3EUj9114/yKhcs8DzKaWv5/5lFXp5qIDsIUXkC6Pu2/7QdRU
	CLR6gLhfez1EsSTJCTjT8IEYU=
Received: from hpl-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wA3Rprlhq5qpMqHBg--.54511S4;
	Sat, 19 Sep 2026 20:58:14 +0800 (CST)
From: peilinhe2020@163.com
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peilin He <he.peilin@zte.com.cn>,
	xu xin <xu.xin16@zte.com.cn>,
	Jiang Kun <jiang.kun2@zte.com.cn>
Subject: [PATCH net v8 2/2] net: stmmac: remove software VLAN tag stripping
Date: Sat, 19 Sep 2026 20:54:13 +0800
Message-ID: <20260919125413.18058-3-peilinhe2020@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919125413.18058-1-peilinhe2020@163.com>
References: <20260919125413.18058-1-peilinhe2020@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Rprlhq5qpMqHBg--.54511S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw13WF4DJr15Cw1rurW3Wrg_yoW7JFy7pa
	yUAas8Cr4kJrnFvayUtw48ZFy3Aan3KayUJanYyayIyanFkryaqFsagFZIvFWkGrZ3uw13
	KFyjvFW5C3WDWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j12NtUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/xtbC8QYh0mquhub-VQAA3K

From: Peilin He <he.peilin@zte.com.cn>

The software VLAN stripping logic in stmmac_rx_vlan() was originally
introduced in 2014 by commit b93819854d6e ("stmmac: Add vlan rx for
better GRO performance.") as a workaround to improve GRO performance,
since at that time GRO could not handle frames with VLAN tags. However,
this limitation was resolved in 2015 by commit 66e5133f19e9 ("vlan: Add
GRO support for non hardware accelerated vlan"), which added GRO support
for non-hardware-accelerated VLAN frames. Keeping a software fallback
path for VLAN stripping is no longer necessary and only adds complexity.

After removing it, VLAN tags remain in the packet. Adjust
stmmac_has_ip_ethertype() to tolerate a single in-payload VLAN tag so
that the MAC RX checksum offload result is still used for tagged
IPv4/IPv6 frames on cores without MAC-level stripping.

This intentionally changes the advertised features:
- dwmac100/dwmac1000 no longer advertise NETIF_F_HW_VLAN_CTAG_RX;
  they have no hardware VLAN stripping.
- NETIF_F_HW_VLAN_STAG_RX is no longer advertised, as the hardware
  reports stripped S-tags as C-tags.
- On xmac cores NETIF_F_HW_VLAN_CTAG_RX is advertised only when the
  VLAN ops provide .set_hw_vlan_mode and .rx_hw_vlan, so DWXLGMAC no
  longer falsely advertises RX VLAN offload.

With NETIF_F_VLAN_FEATURES possibly empty, EEE RX clock stop may be
enabled on some platforms; the preceding selftests patch blocks RX
clock stop while the ethtool selftests run.

This depends on the preceding selftests fix.

Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9c9e95d66b09..6d4716b1a7ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4752,7 +4752,11 @@ static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
 	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
 				    &depth);
 
-	return (depth <= ETH_HLEN) &&
+	/* Software VLAN stripping is gone, so a single VLAN tag may
+	 * still be present. The MAC RX checksum result still applies
+	 * to the inner IP packet.
+	 */
+	return (depth <= VLAN_ETH_HLEN) &&
 		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
 }
 
@@ -5032,24 +5036,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
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
@@ -5418,9 +5404,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	if (priv->hw->hw_vlan_en)
 		/* MAC level stripping. */
 		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-	else
-		/* Driver level stripping. */
-		stmmac_rx_vlan(priv->dev, skb);
+
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
 	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
@@ -5912,9 +5896,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (priv->hw->hw_vlan_en)
 			/* MAC level stripping. */
 			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
-		else
-			/* Driver level stripping. */
-			stmmac_rx_vlan(priv->dev, skb);
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
@@ -7995,9 +7976,10 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
 	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
 #ifdef STMMAC_VLAN_TAG_USED
-	/* Both mac100 and gmac support receive VLAN tag detection */
-	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	if (dwmac_is_xmac(priv->plat->core_type)) {
+	if (priv->hw->vlan &&
+	    priv->hw->vlan->set_hw_vlan_mode &&
+	    priv->hw->vlan->rx_hw_vlan) {
+		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
-- 
2.43.0

