Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290617;
	b=wiEezKCFlQ7YnJ12Ktz6zWg7lCx09wWLiw8OcaSMv/qKW7R2oE//kLsP94sSBqX7LxK1
	 ZSLLpVIY3h8NMj4zI5ZfiXlUWyTqYDoXCaLm6DK86aBgQEpXWd6NvpMQnBD4MrRfyqrtF
	 Ql3pYS4vBd0s9PjY5HaEWUQS51NTk4wowBxoCNZMLy6za+SPl/9LMEm3tNvy5zNubnXBs
	 J2LvjK0FMGlq6RDf9zh/ipnSdEieAz22ZFzMhp/yaM/4wXXrxFtK7cz4KCxoeJBRcu3Hj
	 xitqXPu0R3eI2oNO/2n2a5cqJ9mISrCgMwX2kmF7J8ULl8rUCSrDmQ7oLg/49d2qPJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290617;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7j4ZkRwyXw7fmRhYE9lsi9fnMe99t0IsGQ1HSh6+zso=;
	b=K9F79ee3cAcCu4PeOX1wQ23cF6sbmDFoxjeI5O8OggWAhH09EAz6wz2UT9m6byANBTjL
	 LKMo3Gyu5uJ2ywN+HntmUD/rHlXduWymNQlMyzjIotJkkaLffHS9J6gy3EVie73D5Bxtn
	 wQezm8J0O6+7ZlzUpk0da7hTp4jiBQMl68xKuiAVMF0ifaTOtIZEkJzeFmAK9oJXefRty
	 5yWzWPWC9QGj87mcZe1VQcOJUG5OodgYqFnTVJ1iKxxIgm08zQD7RANylUaCJjERcsZVE
	 KqMUlL13ZpkQZzZhRCPRAn/gWsBu96Ot7378zOdQVhHM+mxX7QjOySRMcpXmGyLWGmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqkhoaJi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C3606A330;
	Tue, 10 Nov 2026 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iqkhoaJi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794290616;
	b=QggrAHDbBrnUc+MyotqVhpy13EUQt8T+HR30YVvgnF2cdZvdKcaAsvoeom7oNTzSPgg7
	 rLU3u+ronNR35xPEJCOJ7uE2lP6bziGtSLYXnyF9QTzxYnwQ6Fb7t+oy7k/60/cwD9LDi
	 Uj9FFUAeZ4vzgSNmTSuPWFUZiSxfbpnHSULilj99YTBhR5gxwQN6hWXXXilnxkXzPvZ7n
	 geUh1krCrBoZdblnWtGJGDV6qDzEG2ydFkkFN7Jq788lRNapRA5kjWiznm20s0Wm6lfHe
	 5vLrgK5n1so+jfS0DyuKXvryMsWPkglezNgm5AHrkdXNVjpqn8kqxRDM44GkEg6HEYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794290616;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7j4ZkRwyXw7fmRhYE9lsi9fnMe99t0IsGQ1HSh6+zso=;
	b=ovRGRoGJAzLlTGXqeWoU72IwtTeDVxabr+WLu2WIr1fZlOjspv6HhLwZOLrL/rA968/J
	 owlN9JJTAt62hWK9NoJYgmghV5+4XSEk+lLgL+njd+cuD338lnjD7YKsUEaJTPzg5NZVy
	 onQPi3atPXPIiT1DCP5WeCT6KcQs4XnxS+22ABBhpbsh/hVn1z9qJAeB/b8zG1JBCcNRY
	 qI5wqqFVcjlz2fGZ2IvkxQg0DtYdj5XYrtbT5YweMUbvOE+wkI9Kwc64zzKRXqNG7+s/4
	 D7iSn/uSsiCPUtl/B04DIo5LuyDbB92ik9DREmnTo7rgM8QKToBKRxxgJ1LddB0ViQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9AAA31F008A2;
	Tue, 10 Nov 2026 06:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290616;
	bh=7j4ZkRwyXw7fmRhYE9lsi9fnMe99t0IsGQ1HSh6+zso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iqkhoaJixNaEZGwlP7iaOv6TR8+TrD4wN10VDtod2gSKgSyRPSmfR8Ac+x+5OqgHb
	 tRI/1Hpe05gCqnPIsX+F0q66az29PkEcq7I9uAcZCpIZDF99p/gbGo+DYswGybO0Yr
	 VIrZvriqzg6RSO3qxRbXmIVtDV0B7r6S+AgczqBOEjZjcAl/Fg2or3BNQwaWJd6lkf
	 nXG9hAf9L094Ze0QG4XmWRgrow+OzDOr9tdl97iinfTSuyZ/UrJ+JCUfgoixwTUDRo
	 aonlhhmWxLhztR1ZS3kbHy2ZaFWs1GAFZ3SJ6pgkBbnb5VBi3WJhGgBBsAVi2av2L4
	 5KgmhjIK13WRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2C8A0488D7;
	Tue, 10 Nov 2026 06:03:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:03:36 +0000
Subject: [PATCH net-next 2/2] net: stmmac: dwmac-sun8i: Enable jumbo frames
 up to MTU 2018
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-sun8i-emac-jumbo-v1-2-84bf00e9ffa3@gmail.com>
References: <20261110-sun8i-emac-jumbo-v1-0-84bf00e9ffa3@gmail.com>
In-Reply-To: <20261110-sun8i-emac-jumbo-v1-0-84bf00e9ffa3@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290614; l=4734;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=ZPiyfCZmfSnwUUZ2KWrlwC/8CYyWh0WpVDKIRZLdbyA=;
 b=rKIpUVWHTnbdoyIqofyDn2uTAGdmjCHH77Y6R/mjiVOYw8kDcJLjl3SUGBGfdQBu84DirQ8YF
 B2bwr757bDBBc8ygm8GGZTULgHil+lI7aryjIKAjQ5wGak7UDLbjNPR
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The sun8i EMAC advertises a maximum MTU of 3712, but no frame larger
than the standard 1518 bytes is actually received: on an H616 board
(Orange Pi Zero2, RTL8211F over RGMII) every ping above 1472 bytes with
DF set is lost, and the rx_length counter goes up for each one.

There are two independent limits:

1. EMAC_RX_CTL0 bit 29 (JUMBO_FRM_EN) is never set, so the receiver
   rejects frames longer than 1518 (1522 with a VLAN tag) bytes. The
   Allwinner BSP driver (sunxi-gmac) sets this bit unconditionally at
   init. Set it in core_init as well; core_init runs after every DMA
   soft reset, including the one done by an MTU change.

2. The EMAC has no Synopsys HW feature register, so stmmac uses normal
   descriptors in chain mode and, without enh_desc, sets max_mtu to
   SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN), which is 3712 with 4K
   pages. That value is not a hardware limit. The descriptor buffer
   size field is 11 bits wide (the same in the BSP and the QEMU model),
   so ndesc_init_rx_desc() caps each RX buffer at 2047 bytes, and
   ndesc_get_rx_status() discards any frame that needs a second
   descriptor. On TX, stmmac_xmit() only splits jumbo frames for
   enh_desc, and norm_set_tx_desc_len_on_chain() masks the length to
   11 bits, so a linear frame longer than 2047 bytes would be silently
   truncated.

Moreover, the RX DMA only fills a multiple of 4 bytes of a buffer: on
the H616, with 2047 programmed, a 2044 byte frame (FCS included) is
received in one descriptor and a 2045 byte frame already spills into a
second one. The usable size is therefore 2044 bytes, the same value as
DESC_BUF_MAX in the original sun8i-emac submission and in the U-Boot
driver.

Limit max_mtu so that a frame with two VLAN tags and the FCS fits in
2044 bytes (MTU 2018). A device tree max-frame-size can still lower it.
Longer frames from the wire span two descriptors and are dropped as a
whole by stmmac_rx(), which drains the descriptors of a split frame
since commit 834ec9530832 ("net: stmmac: drop split frames on AF_XDP
zero-copy RX").

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 0c82662fbe6e..a18d3daf6a3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/if_vlan.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mdio-mux.h>
@@ -219,12 +220,25 @@ static const struct emac_variant emac_variant_h616_emac1 = {
 
 /* Used in RX_CTL0 */
 #define EMAC_RX_RECEIVER_EN             BIT(31)
+#define EMAC_RX_JUMBO_FRM_EN		BIT(29)
 #define EMAC_RX_DO_CRC BIT(27)
 #define EMAC_RX_FLOW_CTL_EN             BIT(16)
 
 /* Used in TX_CTL0 */
 #define EMAC_TX_TRANSMITTER_EN  BIT(31)
 
+/* The buffer size field of the EMAC DMA descriptors is 11 bits wide, and
+ * the RX DMA only fills a multiple of 4 bytes of a buffer: with 2047
+ * programmed, frames longer than 2044 bytes spill into a second
+ * descriptor. The stmmac normal descriptor code used for this EMAC only
+ * handles frames that fit in a single RX descriptor and a single TX
+ * descriptor buffer. Bound the MTU so that a frame, including two VLAN
+ * tags and the FCS, always fits in 2044 bytes.
+ */
+#define EMAC_MAX_FRAME_LEN	2044
+#define EMAC_MAX_MTU		(EMAC_MAX_FRAME_LEN - ETH_HLEN - \
+				 2 * VLAN_HLEN - ETH_FCS_LEN)
+
 /* Used in EMAC_TX_FLOW_CTL */
 #define EMAC_TX_FLOW_CTL_EN             BIT(0)
 
@@ -645,6 +659,15 @@ static void sun8i_dwmac_core_init(struct mac_device_info *hw,
 
 	v = (8 << EMAC_BURSTLEN_SHIFT); /* burst len */
 	writel(v, ioaddr + EMAC_BASIC_CTL1);
+
+	/* Without JUMBO_FRM_EN the receiver flags every frame longer than
+	 * 1518 bytes (1522 with a VLAN tag) as a length error, so any MTU
+	 * above 1500 is unusable. Frames are still bounded by the RX
+	 * descriptor buffer size, see EMAC_MAX_MTU.
+	 */
+	v = readl(ioaddr + EMAC_RX_CTL0);
+	v |= EMAC_RX_JUMBO_FRM_EN;
+	writel(v, ioaddr + EMAC_RX_CTL0);
 }
 
 static void sun8i_dwmac_set_mac(void __iomem *ioaddr, bool enable)
@@ -1209,6 +1232,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	plat_dat->mac_setup = sun8i_dwmac_setup;
 	plat_dat->tx_fifo_size = 4096;
 	plat_dat->rx_fifo_size = 16384;
+	plat_dat->maxmtu = min(plat_dat->maxmtu, EMAC_MAX_MTU);
 
 	ret = sun8i_dwmac_set_syscon(&pdev->dev, plat_dat);
 	if (ret)

-- 
2.55.0


