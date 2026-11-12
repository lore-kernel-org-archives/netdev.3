Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794472909;
	b=kBHdQNDWxtdAtIeJRKw69bXPSHtgLXXTGO140cRluS1aRdcfiIdnsX+BOT3xOeJAe1bQ
	 97R1zlaMdtgQrL2RvNOMsEr6QMINn4s02Gy+qX/IpNe8RWJgdTgjn/x+wR2ORzCx/rpk0
	 joscYNahyBRGABmviZCro129q+p+AWbqKNIMdDqidigUhqdpr9l4DNY7gdBZCSwuxWyX7
	 T0sXwpCi1so9caE4ryqWnBXwGFhawMJVmLTWTMupZu666EfDEAynTHb0OZgkADgzq9bk4
	 nPbp0VuPEAM3K0URZrLVtKJSi7h2ciXYfWBzSuLVQxJcxLc8OIEywIge3AU6YZbV5kA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472909;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7j4ZkRwyXw7fmRhYE9lsi9fnMe99t0IsGQ1HSh6+zso=;
	b=kzZkjWF97VpPSvG/58AW3a9AR2NfhcwRkgcMiERuUSD6agtw6suyjUK2WHnn1zegFS/4
	 y/A5JezciBCCji6M3wZMt2bXZP6CUzQ5Yqs8dPHjGFR3TmCuaTQS6D3m6/zYshuoESpwq
	 2t22Z4dyzDFNkYsoyGf02d/qonNfBc2k8CuBZJP3sy6E/8RhkCVZj8BD3Dw73g5rrJjkq
	 Tk21Wc87dniklpytQBe5fUwN3l/S2z+aJumkH4upaK2nAnWB2YarSJNNC//RnAUHLt4jl
	 SjIQTtfV+IzD1nJw7dimg3GBOJo1ZgBP9Hm/xsHaTzBV7jmfQdinKAO32m6yywiwIBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNt4lR5O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB52606C839;
	Thu, 12 Nov 2026 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNt4lR5O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794472908;
	b=Kfh5sG2hjb3rydiXRatVMywSRDQocLG9KlbGYohSdZIMQIMW74GBGpjWN39KcXG8Xd0Q
	 u58LDdXOEVrB6ArL9e/JfS66imXMUVxrfTxVcNH9XdhA7vmH9EV1UCbToIUXEyEGU2y/W
	 9q+T+1a7kFSt1NllEigWW7ouOqN7Fmvjdl1ARzArTFPUysTPPEBoH/YODy3vfwOnWCxoN
	 pi9cK08sWjM288tPE0LnIc6+iTW3s3eq7HD/fxICdeTJhD1EBwZYR2fJPkXpMA2d4Z27Y
	 1QF/Gio6SnNJW+ugwlcz1SMpyQxzjBZk3zMeMz3BQb21PUvFeZXfDcK7qzo/+5vim3g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472908;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7j4ZkRwyXw7fmRhYE9lsi9fnMe99t0IsGQ1HSh6+zso=;
	b=CveUSkcr2SeZx1160NxomlqsQWTCF+O/bFPNRcsDyMZK45SJ2NV2wWOSRHfeSBkkSt8d
	 bkwTIh0N4LbC5gb8ff9SFYFGur7QTu2ES060SwImG34qV1RE/yhZPyjYyaIy3lZc7tGcf
	 IzifoHHBvPtuhe8XX5XIkEPpk/yUfZbGJo3C0roeZZdMN7LEntlTDPpTLdsN4++gExRVN
	 DMwXEuSDhY7bheqraPfE3IzfxZzmYialdbJRf7hM7/i2YVFSSGygbwqe3W2jGILi8T7YV
	 WNLPFjriHyHaEBYKBnKfp8mf9ReMb8TB9jrkwE1JuEAmlveaSKn/0jAnfwzVbHhSfPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1AD51F00A0B;
	Thu, 12 Nov 2026 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472908;
	bh=7j4ZkRwyXw7fmRhYE9lsi9fnMe99t0IsGQ1HSh6+zso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HNt4lR5OCdkNXd2V606MySq0Y6wAGv95tQGRUV80IVqb0slK+mJoDh0BsNjBCYdKt
	 5nI/f870NJK1QQgCt9TYKtaR1VjtTBWcUyYPGdySFrvhG/Jpbs9dd/Pll00W8HSXUF
	 pUixb33jzrB+hz3TWlnNbADABXPs7KnMIZcBqxCHW1mD+Jd1VB2+ebbYrN+QViqc2w
	 HkGFSExDi8usTB7SUWQXhYV8f9eAxuWaxT51tGfnZpkJriU8gUvOuHZD7Iil2WbMzR
	 CKZVp1cjbWcRVhfC5pcJlq92LKRrTZeFPqX98ToBNuEeaBIraG6lmwL+V4O9oJybjV
	 9gQWMCVsaOdzw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3DBD9493D5;
	Thu, 12 Nov 2026 08:41:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:41:48 +0000
Subject: [PATCH net-next v2 2/2] net: stmmac: dwmac-sun8i: Enable jumbo
 frames up to MTU 2018
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
Message-Id: <20261112-sun8i-emac-jumbo-v2-2-aca0cf23cf17@gmail.com>
References: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
In-Reply-To: <20261112-sun8i-emac-jumbo-v2-0-aca0cf23cf17@gmail.com>
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
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472906; l=4734;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=ZPiyfCZmfSnwUUZ2KWrlwC/8CYyWh0WpVDKIRZLdbyA=;
 b=0IUWEE0Wk0sl3sXsxfCbIwPqGk+0GPYaoUwZ0ZQ9e3Gu9EoHTdRH04zVOqGDJWJA31Sb3Mjw7
 2BID/ohoa4nCptmWbC2IZbGeDXOTyFq/y57Y/myP9y7JLcMJEQKQiFv
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


