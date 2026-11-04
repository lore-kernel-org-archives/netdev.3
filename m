Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803857;
	b=cliTFzGn0sgpf6HN3Mjzj9+7diW+2c0tj9rMlvgLlKLdteuIjqsWTil0NRixCJQcXkvs
	 PY7+xTXFzMZkL8fvRl/9Ebl/PvpDUmdgXJTuN4MzLb9iMbQGQBAlSPK+RCqvLEU+YhOEU
	 e2wl0Rca5zK8TmascUGnnks21donOjkTA3feibJ9R6VX/T9DRYwvNdSHLIKiZcJLRPGCP
	 D7k6FsrKUQz/QL3+L5kidyVxHCDSciQrZaTCseccN9cb1+cDlwKVD3nLp44LSOUBkQ1sd
	 kyoO03LV2DUF5PoVdhoVZ7B4AGrDJaNc4jndAyQ0MeoRwpiZCUt/LtpKYFZwyA/0T9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=COiGvN53RLqmwzDXWEiflL6i8ej8yEcAoxlmG5lM3Zc=;
	b=PkrWKf5Q+p8GFjAakcE/h+2MrecDTH39bamunWtw33bnJpnRSKQYB3gDL6k4CcZt5/vB
	 hHxaOhAxfVemtKhELabP94lrKVBcJXU+oZEpsqzYL3b472pf/X3NaI4Bu2b2VEHR77IR9
	 WwFkSLvvgBrSf/fFGcfnzbIssZr41nJxb64qXga4LYhu0Yn1SToHXYgRChdrO8QytIe5h
	 muutTEK2FjNYetwIf0KoCGUSojyi0yZm6I7ZN+F6PnNiTwcNVEf8vdxg2de28J1raMHRw
	 sMfl3i7MF5sB9MeaCKb/0QlCxsfZHJRbA0XDnIE05T2pixWM7vNGbHN0Y37bXcJbmfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oI5jPV2j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF45606A32D;
	Wed,  4 Nov 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oI5jPV2j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12EE1F00A16;
	Wed,  4 Nov 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803856;
	bh=COiGvN53RLqmwzDXWEiflL6i8ej8yEcAoxlmG5lM3Zc=;
	h=From:To:Cc:Subject:Date;
	b=oI5jPV2jT8prM3UY6YElmGMEV9XHRp/MImL8cFuRPpjOLBZdqXCmXUVNTp6Oib9c2
	 5q3t+0JKx5C4s6p2IKcu1JBmaLAvrnebE4s74UzUs1900JwI/X2KFUqataflusaXug
	 V5aWJwpXOCj2/Pz3TrBbT54GaqH3TwGcyXPO094ih0WaF22Li20DCeOaBek+3zVvDC
	 8d4QFykvlqI4P1673zlVuPhYeR1joLTLKLp5s77H8K+7nnQV0GuRnflyMlMpEyW/wg
	 ycmYXG0P96/yDs9JtS7KJxizz7Qyn0v5NBogGB4xbi68Mt/q5Fq40JBZzb4ZD6luWi
	 ZsOMvQg3zJ0vg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: hisilicon: Remove orphan femac driver
Date: Wed,  4 Nov 2026 08:50:34 -0600
Message-ID: <20261104145038.946918-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the HiSilicon femac driver as it is not used on any upstream SoC.
The hi3516cv300 only has clock, pwm, and this driver.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/hisilicon-femac-mdio.txt     |  22 -
 .../bindings/net/hisilicon-femac.txt          |  41 -
 drivers/net/ethernet/hisilicon/Kconfig        |  12 -
 drivers/net/ethernet/hisilicon/Makefile       |   1 -
 drivers/net/ethernet/hisilicon/hisi_femac.c   | 976 ------------------
 drivers/net/mdio/Kconfig                      |   7 -
 drivers/net/mdio/Makefile                     |   1 -
 drivers/net/mdio/mdio-hisi-femac.c            | 150 ---
 8 files changed, 1210 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
 delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-femac.txt
 delete mode 100644 drivers/net/ethernet/hisilicon/hisi_femac.c
 delete mode 100644 drivers/net/mdio/mdio-hisi-femac.c

diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt b/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
deleted file mode 100644
index 23a39a309d17..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Hisilicon Fast Ethernet MDIO Controller interface
-
-Required properties:
-- compatible: should be "hisilicon,hisi-femac-mdio".
-- reg: address and length of the register set for the device.
-- clocks: A phandle to the reference clock for this device.
-
-- PHY subnode: inherits from phy binding [1]
-[1] Documentation/devicetree/bindings/net/phy.txt
-
-Example:
-mdio: mdio@10091100 {
-	compatible = "hisilicon,hisi-femac-mdio";
-	reg = <0x10091100 0x10>;
-	clocks = <&crg HI3516CV300_MDIO_CLK>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	phy0: phy@1 {
-		reg = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/hisilicon-femac.txt b/Documentation/devicetree/bindings/net/hisilicon-femac.txt
deleted file mode 100644
index 5f96976f3cea..000000000000
--- a/Documentation/devicetree/bindings/net/hisilicon-femac.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Hisilicon Fast Ethernet MAC controller
-
-Required properties:
-- compatible: should contain one of the following version strings:
-	* "hisilicon,hisi-femac-v1"
-	* "hisilicon,hisi-femac-v2"
-	and the soc string "hisilicon,hi3516cv300-femac".
-- reg: specifies base physical address(s) and size of the device registers.
-  The first region is the MAC core register base and size.
-  The second region is the global MAC control register.
-- interrupts: should contain the MAC interrupt.
-- clocks: A phandle to the MAC main clock.
-- resets: should contain the phandle to the MAC reset signal(required) and
-	the PHY reset signal(optional).
-- reset-names: should contain the reset signal name "mac"(required)
-	and "phy"(optional).
-- phy-mode: see ethernet.txt [1].
-- phy-handle: see ethernet.txt [1].
-- hisilicon,phy-reset-delays-us: triplet of delays if PHY reset signal given.
-	The 1st cell is reset pre-delay in micro seconds.
-	The 2nd cell is reset pulse in micro seconds.
-	The 3rd cell is reset post-delay in micro seconds.
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt[1].
-
-[1] Documentation/devicetree/bindings/net/ethernet.txt
-
-Example:
-	hisi_femac: ethernet@10090000 {
-		compatible = "hisilicon,hi3516cv300-femac","hisilicon,hisi-femac-v2";
-		reg = <0x10090000 0x1000>,<0x10091300 0x200>;
-		interrupts = <12>;
-		clocks = <&crg HI3518EV200_ETH_CLK>;
-		resets = <&crg 0xec 0>,<&crg 0xec 3>;
-		reset-names = "mac","phy";
-		mac-address = [00 00 00 00 00 00];
-		phy-mode = "mii";
-		phy-handle = <&phy0>;
-		hisilicon,phy-reset-delays-us = <10000 20000 20000>;
-	};
diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 18eca7d12c20..824070aa84b5 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -25,18 +25,6 @@ config HIX5HD2_GMAC
 	help
 	  This selects the hix5hd2 mac family network device.
 
-config HISI_FEMAC
-	tristate "Hisilicon Fast Ethernet MAC device support"
-	depends on HAS_IOMEM
-	select PHYLIB
-	select RESET_CONTROLLER
-	help
-	  This selects the Hisilicon Fast Ethernet MAC device(FEMAC).
-	  The FEMAC receives and transmits data over Ethernet
-	  ports at 10/100 Mbps in full-duplex or half-duplex mode.
-	  The FEMAC exchanges data with the CPU, and supports
-	  the energy efficient Ethernet (EEE).
-
 config HIP04_ETH
 	tristate "HISILICON P04 Ethernet support"
 	depends on HAS_IOMEM	# For MFD_SYSCON
diff --git a/drivers/net/ethernet/hisilicon/Makefile b/drivers/net/ethernet/hisilicon/Makefile
index 0e2cadfea8ff..73fca4e21748 100644
--- a/drivers/net/ethernet/hisilicon/Makefile
+++ b/drivers/net/ethernet/hisilicon/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_HIP04_ETH) += hip04_eth.o
 obj-$(CONFIG_HNS_MDIO) += hns_mdio.o
 obj-$(CONFIG_HNS) += hns/
 obj-$(CONFIG_HNS3) += hns3/
-obj-$(CONFIG_HISI_FEMAC) += hisi_femac.o
 obj-$(CONFIG_HIBMCGE) += hibmcge/
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
deleted file mode 100644
index a44ea0a2b1ee..000000000000
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ /dev/null
@@ -1,976 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Hisilicon Fast Ethernet MAC Driver
- *
- * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
- */
-
-#include <linux/circ_buf.h>
-#include <linux/clk.h>
-#include <linux/etherdevice.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/of_mdio.h>
-#include <linux/of_net.h>
-#include <linux/platform_device.h>
-#include <linux/reset.h>
-
-/* MAC control register list */
-#define MAC_PORTSEL			0x0200
-#define MAC_PORTSEL_STAT_CPU		BIT(0)
-#define MAC_PORTSEL_RMII		BIT(1)
-#define MAC_PORTSET			0x0208
-#define MAC_PORTSET_DUPLEX_FULL		BIT(0)
-#define MAC_PORTSET_LINKED		BIT(1)
-#define MAC_PORTSET_SPEED_100M		BIT(2)
-#define MAC_SET				0x0210
-#define MAX_FRAME_SIZE			1600
-#define MAX_FRAME_SIZE_MASK		GENMASK(10, 0)
-#define BIT_PAUSE_EN			BIT(18)
-#define RX_COALESCE_SET			0x0340
-#define RX_COALESCED_FRAME_OFFSET	24
-#define RX_COALESCED_FRAMES		8
-#define RX_COALESCED_TIMER		0x74
-#define QLEN_SET			0x0344
-#define RX_DEPTH_OFFSET			8
-#define MAX_HW_FIFO_DEPTH		64
-#define HW_TX_FIFO_DEPTH		12
-#define HW_RX_FIFO_DEPTH		(MAX_HW_FIFO_DEPTH - HW_TX_FIFO_DEPTH)
-#define IQFRM_DES			0x0354
-#define RX_FRAME_LEN_MASK		GENMASK(11, 0)
-#define IQ_ADDR				0x0358
-#define EQ_ADDR				0x0360
-#define EQFRM_LEN			0x0364
-#define ADDRQ_STAT			0x036C
-#define TX_CNT_INUSE_MASK		GENMASK(5, 0)
-#define BIT_TX_READY			BIT(24)
-#define BIT_RX_READY			BIT(25)
-/* global control register list */
-#define GLB_HOSTMAC_L32			0x0000
-#define GLB_HOSTMAC_H16			0x0004
-#define GLB_SOFT_RESET			0x0008
-#define SOFT_RESET_ALL			BIT(0)
-#define GLB_FWCTRL			0x0010
-#define FWCTRL_VLAN_ENABLE		BIT(0)
-#define FWCTRL_FW2CPU_ENA		BIT(5)
-#define FWCTRL_FWALL2CPU		BIT(7)
-#define GLB_MACTCTRL			0x0014
-#define MACTCTRL_UNI2CPU		BIT(1)
-#define MACTCTRL_MULTI2CPU		BIT(3)
-#define MACTCTRL_BROAD2CPU		BIT(5)
-#define MACTCTRL_MACT_ENA		BIT(7)
-#define GLB_IRQ_STAT			0x0030
-#define GLB_IRQ_ENA			0x0034
-#define IRQ_ENA_PORT0_MASK		GENMASK(7, 0)
-#define IRQ_ENA_PORT0			BIT(18)
-#define IRQ_ENA_ALL			BIT(19)
-#define GLB_IRQ_RAW			0x0038
-#define IRQ_INT_RX_RDY			BIT(0)
-#define IRQ_INT_TX_PER_PACKET		BIT(1)
-#define IRQ_INT_TX_FIFO_EMPTY		BIT(6)
-#define IRQ_INT_MULTI_RXRDY		BIT(7)
-#define DEF_INT_MASK			(IRQ_INT_MULTI_RXRDY | \
-					IRQ_INT_TX_PER_PACKET | \
-					IRQ_INT_TX_FIFO_EMPTY)
-#define GLB_MAC_L32_BASE		0x0100
-#define GLB_MAC_H16_BASE		0x0104
-#define MACFLT_HI16_MASK		GENMASK(15, 0)
-#define BIT_MACFLT_ENA			BIT(17)
-#define BIT_MACFLT_FW2CPU		BIT(21)
-#define GLB_MAC_H16(reg)		(GLB_MAC_H16_BASE + ((reg) * 0x8))
-#define GLB_MAC_L32(reg)		(GLB_MAC_L32_BASE + ((reg) * 0x8))
-#define MAX_MAC_FILTER_NUM		8
-#define MAX_UNICAST_ADDRESSES		2
-#define MAX_MULTICAST_ADDRESSES		(MAX_MAC_FILTER_NUM - \
-					MAX_UNICAST_ADDRESSES)
-/* software tx and rx queue number, should be power of 2 */
-#define TXQ_NUM				64
-#define RXQ_NUM				128
-#define FEMAC_POLL_WEIGHT		16
-
-#define PHY_RESET_DELAYS_PROPERTY	"hisilicon,phy-reset-delays-us"
-
-enum phy_reset_delays {
-	PRE_DELAY,
-	PULSE,
-	POST_DELAY,
-	DELAYS_NUM,
-};
-
-struct hisi_femac_queue {
-	struct sk_buff **skb;
-	dma_addr_t *dma_phys;
-	int num;
-	unsigned int head;
-	unsigned int tail;
-};
-
-struct hisi_femac_priv {
-	void __iomem *port_base;
-	void __iomem *glb_base;
-	struct clk *clk;
-	struct reset_control *mac_rst;
-	struct reset_control *phy_rst;
-	u32 phy_reset_delays[DELAYS_NUM];
-	u32 link_status;
-
-	struct device *dev;
-	struct net_device *ndev;
-
-	struct hisi_femac_queue txq;
-	struct hisi_femac_queue rxq;
-	u32 tx_fifo_used_cnt;
-	struct napi_struct napi;
-};
-
-static void hisi_femac_irq_enable(struct hisi_femac_priv *priv, int irqs)
-{
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_IRQ_ENA);
-	writel(val | irqs, priv->glb_base + GLB_IRQ_ENA);
-}
-
-static void hisi_femac_irq_disable(struct hisi_femac_priv *priv, int irqs)
-{
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_IRQ_ENA);
-	writel(val & (~irqs), priv->glb_base + GLB_IRQ_ENA);
-}
-
-static void hisi_femac_tx_dma_unmap(struct hisi_femac_priv *priv,
-				    struct sk_buff *skb, unsigned int pos)
-{
-	dma_addr_t dma_addr;
-
-	dma_addr = priv->txq.dma_phys[pos];
-	dma_unmap_single(priv->dev, dma_addr, skb->len, DMA_TO_DEVICE);
-}
-
-static void hisi_femac_xmit_reclaim(struct net_device *dev)
-{
-	struct sk_buff *skb;
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-	struct hisi_femac_queue *txq = &priv->txq;
-	unsigned int bytes_compl = 0, pkts_compl = 0;
-	u32 val;
-
-	netif_tx_lock(dev);
-
-	val = readl(priv->port_base + ADDRQ_STAT) & TX_CNT_INUSE_MASK;
-	while (val < priv->tx_fifo_used_cnt) {
-		skb = txq->skb[txq->tail];
-		if (unlikely(!skb)) {
-			netdev_err(dev, "xmitq_cnt_inuse=%d, tx_fifo_used=%d\n",
-				   val, priv->tx_fifo_used_cnt);
-			break;
-		}
-		hisi_femac_tx_dma_unmap(priv, skb, txq->tail);
-		pkts_compl++;
-		bytes_compl += skb->len;
-		dev_kfree_skb_any(skb);
-
-		priv->tx_fifo_used_cnt--;
-
-		val = readl(priv->port_base + ADDRQ_STAT) & TX_CNT_INUSE_MASK;
-		txq->skb[txq->tail] = NULL;
-		txq->tail = (txq->tail + 1) % txq->num;
-	}
-
-	netdev_completed_queue(dev, pkts_compl, bytes_compl);
-
-	if (unlikely(netif_queue_stopped(dev)) && pkts_compl)
-		netif_wake_queue(dev);
-
-	netif_tx_unlock(dev);
-}
-
-static void hisi_femac_adjust_link(struct net_device *dev)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-	struct phy_device *phy = dev->phydev;
-	u32 status = 0;
-
-	if (phy->link)
-		status |= MAC_PORTSET_LINKED;
-	if (phy->duplex == DUPLEX_FULL)
-		status |= MAC_PORTSET_DUPLEX_FULL;
-	if (phy->speed == SPEED_100)
-		status |= MAC_PORTSET_SPEED_100M;
-
-	if ((status != priv->link_status) &&
-	    ((status | priv->link_status) & MAC_PORTSET_LINKED)) {
-		writel(status, priv->port_base + MAC_PORTSET);
-		priv->link_status = status;
-		phy_print_status(phy);
-	}
-}
-
-static void hisi_femac_rx_refill(struct hisi_femac_priv *priv)
-{
-	struct hisi_femac_queue *rxq = &priv->rxq;
-	struct sk_buff *skb;
-	u32 pos;
-	u32 len = MAX_FRAME_SIZE;
-	dma_addr_t addr;
-
-	pos = rxq->head;
-	while (readl(priv->port_base + ADDRQ_STAT) & BIT_RX_READY) {
-		if (!CIRC_SPACE(pos, rxq->tail, rxq->num))
-			break;
-		if (unlikely(rxq->skb[pos])) {
-			netdev_err(priv->ndev, "err skb[%d]=%p\n",
-				   pos, rxq->skb[pos]);
-			break;
-		}
-		skb = netdev_alloc_skb_ip_align(priv->ndev, len);
-		if (unlikely(!skb))
-			break;
-
-		addr = dma_map_single(priv->dev, skb->data, len,
-				      DMA_FROM_DEVICE);
-		if (dma_mapping_error(priv->dev, addr)) {
-			dev_kfree_skb_any(skb);
-			break;
-		}
-		rxq->dma_phys[pos] = addr;
-		rxq->skb[pos] = skb;
-		writel(addr, priv->port_base + IQ_ADDR);
-		pos = (pos + 1) % rxq->num;
-	}
-	rxq->head = pos;
-}
-
-static int hisi_femac_rx(struct net_device *dev, int limit)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-	struct hisi_femac_queue *rxq = &priv->rxq;
-	struct sk_buff *skb;
-	dma_addr_t addr;
-	u32 rx_pkt_info, pos, len, rx_pkts_num = 0;
-
-	pos = rxq->tail;
-	while (readl(priv->glb_base + GLB_IRQ_RAW) & IRQ_INT_RX_RDY) {
-		rx_pkt_info = readl(priv->port_base + IQFRM_DES);
-		len = rx_pkt_info & RX_FRAME_LEN_MASK;
-		len -= ETH_FCS_LEN;
-
-		/* tell hardware we will deal with this packet */
-		writel(IRQ_INT_RX_RDY, priv->glb_base + GLB_IRQ_RAW);
-
-		rx_pkts_num++;
-
-		skb = rxq->skb[pos];
-		if (unlikely(!skb)) {
-			netdev_err(dev, "rx skb NULL. pos=%d\n", pos);
-			break;
-		}
-		rxq->skb[pos] = NULL;
-
-		addr = rxq->dma_phys[pos];
-		dma_unmap_single(priv->dev, addr, MAX_FRAME_SIZE,
-				 DMA_FROM_DEVICE);
-		skb_put(skb, len);
-		if (unlikely(skb->len > MAX_FRAME_SIZE)) {
-			netdev_err(dev, "rcv len err, len = %d\n", skb->len);
-			dev->stats.rx_errors++;
-			dev->stats.rx_length_errors++;
-			dev_kfree_skb_any(skb);
-			goto next;
-		}
-
-		skb->protocol = eth_type_trans(skb, dev);
-		napi_gro_receive(&priv->napi, skb);
-		dev->stats.rx_packets++;
-		dev->stats.rx_bytes += len;
-next:
-		pos = (pos + 1) % rxq->num;
-		if (rx_pkts_num >= limit)
-			break;
-	}
-	rxq->tail = pos;
-
-	hisi_femac_rx_refill(priv);
-
-	return rx_pkts_num;
-}
-
-static int hisi_femac_poll(struct napi_struct *napi, int budget)
-{
-	struct hisi_femac_priv *priv = container_of(napi,
-					struct hisi_femac_priv, napi);
-	struct net_device *dev = priv->ndev;
-	int work_done = 0, task = budget;
-	int ints, num;
-
-	do {
-		hisi_femac_xmit_reclaim(dev);
-		num = hisi_femac_rx(dev, task);
-		work_done += num;
-		task -= num;
-		if (work_done >= budget)
-			break;
-
-		ints = readl(priv->glb_base + GLB_IRQ_RAW);
-		writel(ints & DEF_INT_MASK,
-		       priv->glb_base + GLB_IRQ_RAW);
-	} while (ints & DEF_INT_MASK);
-
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
-		hisi_femac_irq_enable(priv, DEF_INT_MASK &
-					(~IRQ_INT_TX_PER_PACKET));
-	}
-
-	return work_done;
-}
-
-static irqreturn_t hisi_femac_interrupt(int irq, void *dev_id)
-{
-	int ints;
-	struct net_device *dev = (struct net_device *)dev_id;
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-
-	ints = readl(priv->glb_base + GLB_IRQ_RAW);
-
-	if (likely(ints & DEF_INT_MASK)) {
-		writel(ints & DEF_INT_MASK,
-		       priv->glb_base + GLB_IRQ_RAW);
-		hisi_femac_irq_disable(priv, DEF_INT_MASK);
-		napi_schedule(&priv->napi);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int hisi_femac_init_queue(struct device *dev,
-				 struct hisi_femac_queue *queue,
-				 unsigned int num)
-{
-	queue->skb = devm_kcalloc(dev, num, sizeof(struct sk_buff *),
-				  GFP_KERNEL);
-	if (!queue->skb)
-		return -ENOMEM;
-
-	queue->dma_phys = devm_kcalloc(dev, num, sizeof(dma_addr_t),
-				       GFP_KERNEL);
-	if (!queue->dma_phys)
-		return -ENOMEM;
-
-	queue->num = num;
-	queue->head = 0;
-	queue->tail = 0;
-
-	return 0;
-}
-
-static int hisi_femac_init_tx_and_rx_queues(struct hisi_femac_priv *priv)
-{
-	int ret;
-
-	ret = hisi_femac_init_queue(priv->dev, &priv->txq, TXQ_NUM);
-	if (ret)
-		return ret;
-
-	ret = hisi_femac_init_queue(priv->dev, &priv->rxq, RXQ_NUM);
-	if (ret)
-		return ret;
-
-	priv->tx_fifo_used_cnt = 0;
-
-	return 0;
-}
-
-static void hisi_femac_free_skb_rings(struct hisi_femac_priv *priv)
-{
-	struct hisi_femac_queue *txq = &priv->txq;
-	struct hisi_femac_queue *rxq = &priv->rxq;
-	struct sk_buff *skb;
-	dma_addr_t dma_addr;
-	u32 pos;
-
-	pos = rxq->tail;
-	while (pos != rxq->head) {
-		skb = rxq->skb[pos];
-		if (unlikely(!skb)) {
-			netdev_err(priv->ndev, "NULL rx skb. pos=%d, head=%d\n",
-				   pos, rxq->head);
-			continue;
-		}
-
-		dma_addr = rxq->dma_phys[pos];
-		dma_unmap_single(priv->dev, dma_addr, MAX_FRAME_SIZE,
-				 DMA_FROM_DEVICE);
-
-		dev_kfree_skb_any(skb);
-		rxq->skb[pos] = NULL;
-		pos = (pos + 1) % rxq->num;
-	}
-	rxq->tail = pos;
-
-	pos = txq->tail;
-	while (pos != txq->head) {
-		skb = txq->skb[pos];
-		if (unlikely(!skb)) {
-			netdev_err(priv->ndev, "NULL tx skb. pos=%d, head=%d\n",
-				   pos, txq->head);
-			continue;
-		}
-		hisi_femac_tx_dma_unmap(priv, skb, pos);
-		dev_kfree_skb_any(skb);
-		txq->skb[pos] = NULL;
-		pos = (pos + 1) % txq->num;
-	}
-	txq->tail = pos;
-	priv->tx_fifo_used_cnt = 0;
-}
-
-static int hisi_femac_set_hw_mac_addr(struct hisi_femac_priv *priv,
-				      const unsigned char *mac)
-{
-	u32 reg;
-
-	reg = mac[1] | (mac[0] << 8);
-	writel(reg, priv->glb_base + GLB_HOSTMAC_H16);
-
-	reg = mac[5] | (mac[4] << 8) | (mac[3] << 16) | (mac[2] << 24);
-	writel(reg, priv->glb_base + GLB_HOSTMAC_L32);
-
-	return 0;
-}
-
-static int hisi_femac_port_reset(struct hisi_femac_priv *priv)
-{
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_SOFT_RESET);
-	val |= SOFT_RESET_ALL;
-	writel(val, priv->glb_base + GLB_SOFT_RESET);
-
-	usleep_range(500, 800);
-
-	val &= ~SOFT_RESET_ALL;
-	writel(val, priv->glb_base + GLB_SOFT_RESET);
-
-	return 0;
-}
-
-static int hisi_femac_net_open(struct net_device *dev)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-
-	hisi_femac_port_reset(priv);
-	hisi_femac_set_hw_mac_addr(priv, dev->dev_addr);
-	hisi_femac_rx_refill(priv);
-
-	netif_carrier_off(dev);
-	netdev_reset_queue(dev);
-	netif_start_queue(dev);
-	napi_enable(&priv->napi);
-
-	priv->link_status = 0;
-	if (dev->phydev)
-		phy_start(dev->phydev);
-
-	writel(IRQ_ENA_PORT0_MASK, priv->glb_base + GLB_IRQ_RAW);
-	hisi_femac_irq_enable(priv, IRQ_ENA_ALL | IRQ_ENA_PORT0 | DEF_INT_MASK);
-
-	return 0;
-}
-
-static int hisi_femac_net_close(struct net_device *dev)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-
-	hisi_femac_irq_disable(priv, IRQ_ENA_PORT0);
-
-	if (dev->phydev)
-		phy_stop(dev->phydev);
-
-	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
-
-	hisi_femac_port_reset(priv);
-	hisi_femac_free_skb_rings(priv);
-
-	return 0;
-}
-
-static netdev_tx_t hisi_femac_net_xmit(struct sk_buff *skb,
-				       struct net_device *dev)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-	struct hisi_femac_queue *txq = &priv->txq;
-	dma_addr_t addr;
-	u32 val;
-
-	val = readl(priv->port_base + ADDRQ_STAT);
-	val &= BIT_TX_READY;
-	if (!val) {
-		hisi_femac_irq_enable(priv, IRQ_INT_TX_PER_PACKET);
-		dev->stats.tx_dropped++;
-		dev->stats.tx_fifo_errors++;
-		netif_stop_queue(dev);
-		return NETDEV_TX_BUSY;
-	}
-
-	if (unlikely(!CIRC_SPACE(txq->head, txq->tail,
-				 txq->num))) {
-		hisi_femac_irq_enable(priv, IRQ_INT_TX_PER_PACKET);
-		dev->stats.tx_dropped++;
-		dev->stats.tx_fifo_errors++;
-		netif_stop_queue(dev);
-		return NETDEV_TX_BUSY;
-	}
-
-	addr = dma_map_single(priv->dev, skb->data,
-			      skb->len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(priv->dev, addr))) {
-		dev_kfree_skb_any(skb);
-		dev->stats.tx_dropped++;
-		return NETDEV_TX_OK;
-	}
-	txq->dma_phys[txq->head] = addr;
-
-	txq->skb[txq->head] = skb;
-	txq->head = (txq->head + 1) % txq->num;
-
-	writel(addr, priv->port_base + EQ_ADDR);
-	writel(skb->len + ETH_FCS_LEN, priv->port_base + EQFRM_LEN);
-
-	priv->tx_fifo_used_cnt++;
-
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-	netdev_sent_queue(dev, skb->len);
-
-	return NETDEV_TX_OK;
-}
-
-static int hisi_femac_set_mac_address(struct net_device *dev, void *p)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-	struct sockaddr *skaddr = p;
-
-	if (!is_valid_ether_addr(skaddr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(dev, skaddr->sa_data);
-	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
-
-	hisi_femac_set_hw_mac_addr(priv, dev->dev_addr);
-
-	return 0;
-}
-
-static void hisi_femac_enable_hw_addr_filter(struct hisi_femac_priv *priv,
-					     unsigned int reg_n, bool enable)
-{
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_MAC_H16(reg_n));
-	if (enable)
-		val |= BIT_MACFLT_ENA;
-	else
-		val &= ~BIT_MACFLT_ENA;
-	writel(val, priv->glb_base + GLB_MAC_H16(reg_n));
-}
-
-static void hisi_femac_set_hw_addr_filter(struct hisi_femac_priv *priv,
-					  unsigned char *addr,
-					  unsigned int reg_n)
-{
-	unsigned int high, low;
-	u32 val;
-
-	high = GLB_MAC_H16(reg_n);
-	low = GLB_MAC_L32(reg_n);
-
-	val = (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5];
-	writel(val, priv->glb_base + low);
-
-	val = readl(priv->glb_base + high);
-	val &= ~MACFLT_HI16_MASK;
-	val |= ((addr[0] << 8) | addr[1]);
-	val |= (BIT_MACFLT_ENA | BIT_MACFLT_FW2CPU);
-	writel(val, priv->glb_base + high);
-}
-
-static void hisi_femac_set_promisc_mode(struct hisi_femac_priv *priv,
-					bool promisc_mode)
-{
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_FWCTRL);
-	if (promisc_mode)
-		val |= FWCTRL_FWALL2CPU;
-	else
-		val &= ~FWCTRL_FWALL2CPU;
-	writel(val, priv->glb_base + GLB_FWCTRL);
-}
-
-/* Handle multiple multicast addresses (perfect filtering)*/
-static void hisi_femac_set_mc_addr_filter(struct hisi_femac_priv *priv)
-{
-	struct net_device *dev = priv->ndev;
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_MACTCTRL);
-	if ((netdev_mc_count(dev) > MAX_MULTICAST_ADDRESSES) ||
-	    (dev->flags & IFF_ALLMULTI)) {
-		val |= MACTCTRL_MULTI2CPU;
-	} else {
-		int reg = MAX_UNICAST_ADDRESSES;
-		int i;
-		struct netdev_hw_addr *ha;
-
-		for (i = reg; i < MAX_MAC_FILTER_NUM; i++)
-			hisi_femac_enable_hw_addr_filter(priv, i, false);
-
-		netdev_for_each_mc_addr(ha, dev) {
-			hisi_femac_set_hw_addr_filter(priv, ha->addr, reg);
-			reg++;
-		}
-		val &= ~MACTCTRL_MULTI2CPU;
-	}
-	writel(val, priv->glb_base + GLB_MACTCTRL);
-}
-
-/* Handle multiple unicast addresses (perfect filtering)*/
-static void hisi_femac_set_uc_addr_filter(struct hisi_femac_priv *priv)
-{
-	struct net_device *dev = priv->ndev;
-	u32 val;
-
-	val = readl(priv->glb_base + GLB_MACTCTRL);
-	if (netdev_uc_count(dev) > MAX_UNICAST_ADDRESSES) {
-		val |= MACTCTRL_UNI2CPU;
-	} else {
-		int reg = 0;
-		int i;
-		struct netdev_hw_addr *ha;
-
-		for (i = reg; i < MAX_UNICAST_ADDRESSES; i++)
-			hisi_femac_enable_hw_addr_filter(priv, i, false);
-
-		netdev_for_each_uc_addr(ha, dev) {
-			hisi_femac_set_hw_addr_filter(priv, ha->addr, reg);
-			reg++;
-		}
-		val &= ~MACTCTRL_UNI2CPU;
-	}
-	writel(val, priv->glb_base + GLB_MACTCTRL);
-}
-
-static void hisi_femac_net_set_rx_mode(struct net_device *dev)
-{
-	struct hisi_femac_priv *priv = netdev_priv(dev);
-
-	if (dev->flags & IFF_PROMISC) {
-		hisi_femac_set_promisc_mode(priv, true);
-	} else {
-		hisi_femac_set_promisc_mode(priv, false);
-		hisi_femac_set_mc_addr_filter(priv);
-		hisi_femac_set_uc_addr_filter(priv);
-	}
-}
-
-static const struct ethtool_ops hisi_femac_ethtools_ops = {
-	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
-};
-
-static const struct net_device_ops hisi_femac_netdev_ops = {
-	.ndo_open		= hisi_femac_net_open,
-	.ndo_stop		= hisi_femac_net_close,
-	.ndo_start_xmit		= hisi_femac_net_xmit,
-	.ndo_eth_ioctl		= phy_do_ioctl_running,
-	.ndo_set_mac_address	= hisi_femac_set_mac_address,
-	.ndo_set_rx_mode	= hisi_femac_net_set_rx_mode,
-};
-
-static void hisi_femac_core_reset(struct hisi_femac_priv *priv)
-{
-	reset_control_assert(priv->mac_rst);
-	reset_control_deassert(priv->mac_rst);
-}
-
-static void hisi_femac_sleep_us(u32 time_us)
-{
-	u32 time_ms;
-
-	if (!time_us)
-		return;
-
-	time_ms = DIV_ROUND_UP(time_us, 1000);
-	if (time_ms < 20)
-		usleep_range(time_us, time_us + 500);
-	else
-		msleep(time_ms);
-}
-
-static void hisi_femac_phy_reset(struct hisi_femac_priv *priv)
-{
-	/* To make sure PHY hardware reset success,
-	 * we must keep PHY in deassert state first and
-	 * then complete the hardware reset operation
-	 */
-	reset_control_deassert(priv->phy_rst);
-	hisi_femac_sleep_us(priv->phy_reset_delays[PRE_DELAY]);
-
-	reset_control_assert(priv->phy_rst);
-	/* delay some time to ensure reset ok,
-	 * this depends on PHY hardware feature
-	 */
-	hisi_femac_sleep_us(priv->phy_reset_delays[PULSE]);
-	reset_control_deassert(priv->phy_rst);
-	/* delay some time to ensure later MDIO access */
-	hisi_femac_sleep_us(priv->phy_reset_delays[POST_DELAY]);
-}
-
-static void hisi_femac_port_init(struct hisi_femac_priv *priv)
-{
-	u32 val;
-
-	/* MAC gets link status info and phy mode by software config */
-	val = MAC_PORTSEL_STAT_CPU;
-	if (priv->ndev->phydev->interface == PHY_INTERFACE_MODE_RMII)
-		val |= MAC_PORTSEL_RMII;
-	writel(val, priv->port_base + MAC_PORTSEL);
-
-	/*clear all interrupt status */
-	writel(IRQ_ENA_PORT0_MASK, priv->glb_base + GLB_IRQ_RAW);
-	hisi_femac_irq_disable(priv, IRQ_ENA_PORT0_MASK | IRQ_ENA_PORT0);
-
-	val = readl(priv->glb_base + GLB_FWCTRL);
-	val &= ~(FWCTRL_VLAN_ENABLE | FWCTRL_FWALL2CPU);
-	val |= FWCTRL_FW2CPU_ENA;
-	writel(val, priv->glb_base + GLB_FWCTRL);
-
-	val = readl(priv->glb_base + GLB_MACTCTRL);
-	val |= (MACTCTRL_BROAD2CPU | MACTCTRL_MACT_ENA);
-	writel(val, priv->glb_base + GLB_MACTCTRL);
-
-	val = readl(priv->port_base + MAC_SET);
-	val &= ~MAX_FRAME_SIZE_MASK;
-	val |= MAX_FRAME_SIZE;
-	writel(val, priv->port_base + MAC_SET);
-
-	val = RX_COALESCED_TIMER |
-		(RX_COALESCED_FRAMES << RX_COALESCED_FRAME_OFFSET);
-	writel(val, priv->port_base + RX_COALESCE_SET);
-
-	val = (HW_RX_FIFO_DEPTH << RX_DEPTH_OFFSET) | HW_TX_FIFO_DEPTH;
-	writel(val, priv->port_base + QLEN_SET);
-}
-
-static int hisi_femac_drv_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	struct net_device *ndev;
-	struct hisi_femac_priv *priv;
-	struct phy_device *phy;
-	int ret;
-
-	ndev = alloc_etherdev(sizeof(*priv));
-	if (!ndev)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, ndev);
-	SET_NETDEV_DEV(ndev, &pdev->dev);
-
-	priv = netdev_priv(ndev);
-	priv->dev = dev;
-	priv->ndev = ndev;
-
-	priv->port_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->port_base)) {
-		ret = PTR_ERR(priv->port_base);
-		goto out_free_netdev;
-	}
-
-	priv->glb_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(priv->glb_base)) {
-		ret = PTR_ERR(priv->glb_base);
-		goto out_free_netdev;
-	}
-
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clk\n");
-		ret = -ENODEV;
-		goto out_free_netdev;
-	}
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(dev, "failed to enable clk %d\n", ret);
-		goto out_free_netdev;
-	}
-
-	priv->mac_rst = devm_reset_control_get(dev, "mac");
-	if (IS_ERR(priv->mac_rst)) {
-		ret = PTR_ERR(priv->mac_rst);
-		goto out_disable_clk;
-	}
-	hisi_femac_core_reset(priv);
-
-	priv->phy_rst = devm_reset_control_get(dev, "phy");
-	if (IS_ERR(priv->phy_rst)) {
-		priv->phy_rst = NULL;
-	} else {
-		ret = of_property_read_u32_array(node,
-						 PHY_RESET_DELAYS_PROPERTY,
-						 priv->phy_reset_delays,
-						 DELAYS_NUM);
-		if (ret)
-			goto out_disable_clk;
-		hisi_femac_phy_reset(priv);
-	}
-
-	ndev->netdev_ops = &hisi_femac_netdev_ops;
-
-	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
-	if (!phy) {
-		dev_err(dev, "connect to PHY failed!\n");
-		ret = -ENODEV;
-		goto out_disable_clk;
-	}
-
-	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",
-			   (unsigned long)phy->phy_id,
-			   phy_modes(phy->interface));
-
-	ret = of_get_ethdev_address(node, ndev);
-	if (ret) {
-		eth_hw_addr_random(ndev);
-		dev_warn(dev, "using random MAC address %pM\n",
-			 ndev->dev_addr);
-	}
-
-	ndev->watchdog_timeo = 6 * HZ;
-	ndev->priv_flags |= IFF_UNICAST_FLT;
-	ndev->ethtool_ops = &hisi_femac_ethtools_ops;
-	netif_napi_add_weight(ndev, &priv->napi, hisi_femac_poll,
-			      FEMAC_POLL_WEIGHT);
-
-	hisi_femac_port_init(priv);
-
-	ret = hisi_femac_init_tx_and_rx_queues(priv);
-	if (ret)
-		goto out_disconnect_phy;
-
-	ndev->irq = platform_get_irq(pdev, 0);
-	if (ndev->irq < 0) {
-		ret = ndev->irq;
-		goto out_disconnect_phy;
-	}
-
-	ret = devm_request_irq(dev, ndev->irq, hisi_femac_interrupt,
-			       IRQF_SHARED, pdev->name, ndev);
-	if (ret) {
-		dev_err(dev, "devm_request_irq %d failed!\n", ndev->irq);
-		goto out_disconnect_phy;
-	}
-
-	ret = register_netdev(ndev);
-	if (ret) {
-		dev_err(dev, "register_netdev failed!\n");
-		goto out_disconnect_phy;
-	}
-
-	return ret;
-
-out_disconnect_phy:
-	netif_napi_del(&priv->napi);
-	phy_disconnect(phy);
-out_disable_clk:
-	clk_disable_unprepare(priv->clk);
-out_free_netdev:
-	free_netdev(ndev);
-
-	return ret;
-}
-
-static void hisi_femac_drv_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct hisi_femac_priv *priv = netdev_priv(ndev);
-
-	netif_napi_del(&priv->napi);
-	unregister_netdev(ndev);
-
-	phy_disconnect(ndev->phydev);
-	clk_disable_unprepare(priv->clk);
-	free_netdev(ndev);
-}
-
-#ifdef CONFIG_PM
-static int hisi_femac_drv_suspend(struct platform_device *pdev,
-				  pm_message_t state)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct hisi_femac_priv *priv = netdev_priv(ndev);
-
-	disable_irq(ndev->irq);
-	if (netif_running(ndev)) {
-		hisi_femac_net_close(ndev);
-		netif_device_detach(ndev);
-	}
-
-	clk_disable_unprepare(priv->clk);
-
-	return 0;
-}
-
-static int hisi_femac_drv_resume(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct hisi_femac_priv *priv = netdev_priv(ndev);
-
-	clk_prepare_enable(priv->clk);
-	if (priv->phy_rst)
-		hisi_femac_phy_reset(priv);
-
-	if (netif_running(ndev)) {
-		hisi_femac_port_init(priv);
-		hisi_femac_net_open(ndev);
-		netif_device_attach(ndev);
-	}
-	enable_irq(ndev->irq);
-
-	return 0;
-}
-#endif
-
-static const struct of_device_id hisi_femac_match[] = {
-	{.compatible = "hisilicon,hisi-femac-v1",},
-	{.compatible = "hisilicon,hisi-femac-v2",},
-	{.compatible = "hisilicon,hi3516cv300-femac",},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, hisi_femac_match);
-
-static struct platform_driver hisi_femac_driver = {
-	.driver = {
-		.name = "hisi-femac",
-		.of_match_table = hisi_femac_match,
-	},
-	.probe = hisi_femac_drv_probe,
-	.remove = hisi_femac_drv_remove,
-#ifdef CONFIG_PM
-	.suspend = hisi_femac_drv_suspend,
-	.resume = hisi_femac_drv_resume,
-#endif
-};
-
-module_platform_driver(hisi_femac_driver);
-
-MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC driver");
-MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hisi-femac");
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index d44278f26fab..6f272fae4bb5 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -97,13 +97,6 @@ config MDIO_GPIO
 	  To compile this driver as a module, choose M here: the module
 	  will be called mdio-gpio.
 
-config MDIO_HISI_FEMAC
-	tristate "Hisilicon FEMAC MDIO bus controller"
-	depends on HAS_IOMEM && OF_MDIO
-	help
-	  This module provides a driver for the MDIO busses found in the
-	  Hisilicon SoC that have an Fast Ethernet MAC.
-
 config MDIO_I2C
 	tristate
 	depends on I2C
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 048586746026..e02c66a02545 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
 obj-$(CONFIG_MDIO_BITBANG)		+= mdio-bitbang.o
 obj-$(CONFIG_MDIO_CAVIUM)		+= mdio-cavium.o
 obj-$(CONFIG_MDIO_GPIO)			+= mdio-gpio.o
-obj-$(CONFIG_MDIO_HISI_FEMAC)		+= mdio-hisi-femac.o
 obj-$(CONFIG_MDIO_I2C)			+= mdio-i2c.o
 obj-$(CONFIG_MDIO_IPQ4019)		+= mdio-ipq4019.o
 obj-$(CONFIG_MDIO_IPQ8064)		+= mdio-ipq8064.o
diff --git a/drivers/net/mdio/mdio-hisi-femac.c b/drivers/net/mdio/mdio-hisi-femac.c
deleted file mode 100644
index d78a1dc36cfd..000000000000
--- a/drivers/net/mdio/mdio-hisi-femac.c
+++ /dev/null
@@ -1,150 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Hisilicon Fast Ethernet MDIO Bus Driver
- *
- * Copyright (c) 2016 HiSilicon Technologies Co., Ltd.
- */
-
-#include <linux/clk.h>
-#include <linux/iopoll.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_mdio.h>
-#include <linux/platform_device.h>
-
-#define MDIO_RWCTRL		0x00
-#define MDIO_RO_DATA		0x04
-#define MDIO_WRITE		BIT(13)
-#define MDIO_RW_FINISH		BIT(15)
-#define BIT_PHY_ADDR_OFFSET	8
-#define BIT_WR_DATA_OFFSET	16
-
-struct hisi_femac_mdio_data {
-	struct clk *clk;
-	void __iomem *membase;
-};
-
-static int hisi_femac_mdio_wait_ready(struct hisi_femac_mdio_data *data)
-{
-	u32 val;
-
-	return readl_poll_timeout(data->membase + MDIO_RWCTRL,
-				  val, val & MDIO_RW_FINISH, 20, 10000);
-}
-
-static int hisi_femac_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
-{
-	struct hisi_femac_mdio_data *data = bus->priv;
-	int ret;
-
-	ret = hisi_femac_mdio_wait_ready(data);
-	if (ret)
-		return ret;
-
-	writel((mii_id << BIT_PHY_ADDR_OFFSET) | regnum,
-	       data->membase + MDIO_RWCTRL);
-
-	ret = hisi_femac_mdio_wait_ready(data);
-	if (ret)
-		return ret;
-
-	return readl(data->membase + MDIO_RO_DATA) & 0xFFFF;
-}
-
-static int hisi_femac_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
-				 u16 value)
-{
-	struct hisi_femac_mdio_data *data = bus->priv;
-	int ret;
-
-	ret = hisi_femac_mdio_wait_ready(data);
-	if (ret)
-		return ret;
-
-	writel(MDIO_WRITE | (value << BIT_WR_DATA_OFFSET) |
-	       (mii_id << BIT_PHY_ADDR_OFFSET) | regnum,
-	       data->membase + MDIO_RWCTRL);
-
-	return hisi_femac_mdio_wait_ready(data);
-}
-
-static int hisi_femac_mdio_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct mii_bus *bus;
-	struct hisi_femac_mdio_data *data;
-	int ret;
-
-	bus = mdiobus_alloc_size(sizeof(*data));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "hisi_femac_mii_bus";
-	bus->read = &hisi_femac_mdio_read;
-	bus->write = &hisi_femac_mdio_write;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", pdev->name);
-	bus->parent = &pdev->dev;
-
-	data = bus->priv;
-	data->membase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->membase)) {
-		ret = PTR_ERR(data->membase);
-		goto err_out_free_mdiobus;
-	}
-
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		ret = PTR_ERR(data->clk);
-		goto err_out_free_mdiobus;
-	}
-
-	ret = clk_prepare_enable(data->clk);
-	if (ret)
-		goto err_out_free_mdiobus;
-
-	ret = of_mdiobus_register(bus, np);
-	if (ret)
-		goto err_out_disable_clk;
-
-	platform_set_drvdata(pdev, bus);
-
-	return 0;
-
-err_out_disable_clk:
-	clk_disable_unprepare(data->clk);
-err_out_free_mdiobus:
-	mdiobus_free(bus);
-	return ret;
-}
-
-static void hisi_femac_mdio_remove(struct platform_device *pdev)
-{
-	struct mii_bus *bus = platform_get_drvdata(pdev);
-	struct hisi_femac_mdio_data *data = bus->priv;
-
-	mdiobus_unregister(bus);
-	clk_disable_unprepare(data->clk);
-	mdiobus_free(bus);
-}
-
-static const struct of_device_id hisi_femac_mdio_dt_ids[] = {
-	{ .compatible = "hisilicon,hisi-femac-mdio" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, hisi_femac_mdio_dt_ids);
-
-static struct platform_driver hisi_femac_mdio_driver = {
-	.probe = hisi_femac_mdio_probe,
-	.remove = hisi_femac_mdio_remove,
-	.driver = {
-		.name = "hisi-femac-mdio",
-		.of_match_table = hisi_femac_mdio_dt_ids,
-	},
-};
-
-module_platform_driver(hisi_femac_mdio_driver);
-
-MODULE_DESCRIPTION("Hisilicon Fast Ethernet MAC MDIO interface driver");
-MODULE_AUTHOR("Dongpo Li <lidongpo@hisilicon.com>");
-MODULE_LICENSE("GPL");
-- 
2.53.0

