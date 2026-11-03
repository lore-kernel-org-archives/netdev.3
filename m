Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722227;
	b=SJC4Mz/+kX3lybYFvAfmbWfNCgFGkcn3koVePLTrMqvWV1zJOk/iVkx2Bn9+9G6ruj0o
	 radW5kZLHAVs7vMMNiMWBS73U8IjFAO1gDD1AfKhSDuDHig4uFQVD+iuP6dD3YoZ6VBI4
	 5K6NNqXlgEuZiX6iamSvnL1dCYdnbvS2H5P5sKEl4M9QaVq4qdjMgZkYm3R8NYdAlh055
	 W+Xo6V9gW5yk2KGSdPEM4Bg30nrD/NicI91xhiDpsLJbT3cK6+Cfv9CSYMUjB/sO56WSK
	 98l7VMqI7q6juqZv6JRfRlfsXD5mpY8Zhje8fCPDPkATIrlzXVMXaBjJRtS/jkI7PtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722227;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=o3AtUaDDignDhemVJZmrs9RvFoTNS+PrlXslggB1GSc=;
	b=dqkZVi/1ALIlcVUMjh19KnxKQnylu0DTsOZwGBfqHOnT/gdYzsKU/DFqN3V78sElNn47
	 mFTxpER8W+LFmtmmXp5UlCB7Tw31HWv0EZ8Hn6kBfxEEBGoyPjinAWdyZtbS4oXnudjrh
	 QOzTlm2yNrEmLLm+1C3LYQ/OKydsGhRl+oftDm+ygJjuIPaZ/ASM29gvBwQ4nCoBke160
	 ZlDlocTzizY4hW4EQH0242MCmSDlwFatjlB9viKCwpkYkLuU5GBPTfPJFv/EluZsMkl/8
	 jULBSaUMlvexHfzmOa8IzicjZPcL00jZLAswQ3lyzlZVOdO8+KZokwObOkgQFSQ9mug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rx+67YcM;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JbZRI7Oy;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87598606A331;
	Tue,  3 Nov 2026 16:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87598606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=rx+67YcM;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JbZRI7Oy
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E75hN689031;
	Tue, 3 Nov 2026 11:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=o3AtUaDDignDhemVJZmrs9RvFoTNS+PrlXslggB1GSc=; b=rx+67Yc
	M56QuT/vMnjcSMWEOy3gDJwhlvoswlFU/+KnmfPzgvdX/N0t/mqpqBQlxNnCmQZt
	Wzu2RdG4xnGotBt8lqtj9QpNcGs5eAPBptOvckZIaCz7TmbJxLLGh8hq4B5m1C5y
	nupwYLl8WloVOhnThCV1OpLAl/jZgnI7C0K/cxQH35eMxDdyBrMsHOC6NI9QDuRH
	KmRWBHp31O6aC6OXjt6tZStYuSUIXiuOhhEdAGGMYK5Rmb9wZEL1ya6KuH92cFjZ
	38yK1iS+4fxBvbGYji2jzfRh9GlTroTthS/HJ9+ZH6GrDbI+cG+oftuNwgX5eq2S
	qu2p/2J8Y1JBqyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o3AtU
	aDDignDhemVJZmrs9RvFoTNS+PrlXslggB1GSc=; b=JbZRI7OyfshvFu7RNPXqp
	HWRHXGD7jyxZaE8/VUyw+4uJc5OHoYstVc0ljCGSZ03h4KQfOLWA0NeMbWBrlvhI
	hxzpNx6MAJR62GyNgcV4E1yWqsiN+rbJEs1tNAYN4WZ0Rf8iHQVwaP86a5DbecaC
	+oc1K9cCVEwFw7EYjv/3UawqqDM9QvpQKGG1NFNxxkXWzJJmSTpN0WTibPiMTypC
	/82nmSdjx5/J0i1RRZo9KlV1FYn/i8SAJuZgvGFJSqO4vgjClLBRQ7jMOnKcjbpt
	KLGp6JSeuLRtYVgbb4oR3sIkZ5lzpydPqEz4QfMein8Tw4U9odpbzAOoclOg4MCe
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqh160ptd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:10:14 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A3GAD1T003134
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Nov 2026 11:10:13 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 3 Nov 2026 11:10:12 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 3 Nov 2026 11:10:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 3 Nov 2026 11:10:12 -0500
Received: from HYB-6AVb5If9qTU.tail230d3d.ts.net (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A3G9KcQ032393;
	Tue, 3 Nov 2026 11:10:07 -0500
From: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next 4/5] net: ethernet: adi: adin1110: Add OA TC6 protocol support for ADIN1110
Date: Tue, 3 Nov 2026 18:09:17 +0200
Message-ID: <20261103160918.409701-5-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
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
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXzjySLauhd/jZ
 mQzyq6/R0cSCC0izVtRjB3RcgCM6PKxRgcIeV2FbOOSAZ1VctkoyPoOcRC6Cfr4D+PXMW89vPB7
 iAIbgxLGZcll8rzAN3cnQpWWMxhlAYt3+Urh921vhgsQ2FFvx542
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfXw3w7uEAdu/68
 +J4z7p1HKQ+bRhKfbrs9xWor8kIsIhqqQDqR6KjYZtOhL3Q+eNpDjZO0vLgG95jO3o2kJh99K7x
 EhyqIE5a1v86w23oNWw+vkG3SuIJokfExQp9NajdV7X6z5ju2GSYjs4mxXnBLRNO5go5N7WFfXE
 63SAXQE6s9A7J8QXX3+/dvp6LyrECOarppIA7quZuvC0q3pu4LcIlliQmsjyi/+Cd383aPh6ODw
 NUMVvLhgbjECc9TFNLjyyd/KcB/7Dv5PSj1B1/Ltyy9Yj7xr1w3dcgSWf8oubsHbXC1xyVgrMbU
 m7LmN6SV21Dw8OXJgKfobyWQhr1b1AwLQA2XrsyKajDLg3NgF1CJzd+DZSu9sDTE2jGwndupE+O
 Yk3e45+pGvA9WzuH1ySaFo32e2WxEyIShyT0asQyres2nNNJ+fFo2W70lhhmn/JhI6pBtwZk82L
 T0AWhdNAdEbqCx0wDZQ==
X-Proofpoint-ORIG-GUID: ikmDWVs1i8kxVapNaV8Gclj7swRBnB_g
X-Proofpoint-GUID: ikmDWVs1i8kxVapNaV8Gclj7swRBnB_g
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6aea0766 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=Mci-6iFgQkcKbKAaMZ8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

From: Ciprian Regus <ciprian.regus@analog.com>

The ADIN1110 and ADIN2111 support two SPI host interface protocols,
the generic SPI protocol and the OPEN Alliance TC6 protocol. The
protocol is selected by the state of the SPI_CFG1 pin, which the device
latches when it comes out of reset. The driver currently supports only
the generic SPI protocol.

Add support for the OPEN Alliance TC6 protocol on the ADIN1110, using
the oa_tc6 framework, when the adi,spi-oa-tc6 property is set. The
framework handles the data transfers and the MDIO bus. Register
accesses go through read_reg/write_reg callbacks, so the existing MAC
configuration code is shared by both protocols. The ADIN1110 specific
MAC registers are in MMS 1.

The framework does not append the FCS to transmitted frames, so set
CRC_APPEND in CONFIG2 to let the MAC append it. Also set the port state
to forwarding on open, as the generic SPI path does, otherwise the
broadcast and multicast filters drop all received frames.

The ADIN2111 is not supported in OPEN Alliance TC6 mode yet, and probe
fails with -EOPNOTSUPP.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Co-developed-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/ethernet/adi/Kconfig    |   1 +
 drivers/net/ethernet/adi/adin1110.c | 186 +++++++++++++++++++++++++++-
 include/linux/oa_tc6.h              |   1 +
 3 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
index bdb8ff7d15da..c35f68814c21 100644
--- a/drivers/net/ethernet/adi/Kconfig
+++ b/drivers/net/ethernet/adi/Kconfig
@@ -22,6 +22,7 @@ config ADIN1110
 	depends on SPI && NET_SWITCHDEV
 	select CRC8
 	select PHYLIB
+	select OA_TC6
 	help
 	  Say yes here to build support for Analog Devices ADIN1110
 	  Low Power 10BASE-T1L Ethernet MAC-PHY.
diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 53fac3dc8be6..d08b165bf7c4 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -19,6 +19,7 @@
 #include <linux/mii.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/oa_tc6.h>
 #include <linux/regulator/consumer.h>
 #include <linux/phy.h>
 #include <linux/property.h>
@@ -114,6 +115,8 @@
 #define ADIN_MAC_P2_ADDR_SLOT			3
 #define ADIN_MAC_FDB_ADDR_SLOT			4
 
+#define ADIN1110_MMS0_LIMIT			0x30
+
 DECLARE_CRC8_TABLE(adin1110_crc_table);
 
 enum adin1110_chips_id {
@@ -145,6 +148,7 @@ struct adin1110_port_priv {
 	u32				nr;
 	u32				state;
 	struct adin1110_cfg		*cfg;
+	struct oa_tc6			*tc6;
 };
 
 struct adin1110_priv {
@@ -161,6 +165,9 @@ struct adin1110_priv {
 	struct adin1110_port_priv	*ports[ADIN_MAC_MAX_PORTS];
 	char				mii_bus_name[MII_BUS_ID_SIZE];
 	u8				data[ADIN1110_MAX_BUFF] ____cacheline_aligned;
+
+	int (*read_reg)(struct adin1110_priv *priv, u16 reg, u32 *val);
+	int (*write_reg)(struct adin1110_priv *priv, u16 reg, u32 val);
 };
 
 struct adin1110_switchdev_event_work {
@@ -192,7 +199,18 @@ static u8 adin1110_crc_data(u8 *data, u32 len)
 	return crc8(adin1110_crc_table, data, len, 0);
 }
 
-static int adin1110_read_reg(struct adin1110_priv *priv, u16 reg, u32 *val)
+static int adin1110_read_reg_tc6(struct adin1110_priv *priv, u16 reg, u32 *val)
+{
+	struct adin1110_port_priv *port_priv = priv->ports[0];
+
+	if (reg >= ADIN1110_MMS0_LIMIT)
+		return oa_tc6_read_register_mms(port_priv->tc6, OA_TC6_MAC_MMS1,
+						 reg, val);
+
+	return oa_tc6_read_register(port_priv->tc6, reg, val);
+}
+
+static int adin1110_read_reg_generic_spi(struct adin1110_priv *priv, u16 reg, u32 *val)
 {
 	u32 header_len = ADIN1110_RD_HEADER_LEN;
 	u32 read_len = ADIN1110_REG_LEN;
@@ -240,7 +258,23 @@ static int adin1110_read_reg(struct adin1110_priv *priv, u16 reg, u32 *val)
 	return ret;
 }
 
-static int adin1110_write_reg(struct adin1110_priv *priv, u16 reg, u32 val)
+static int adin1110_read_reg(struct adin1110_priv *priv, u16 reg, u32 *val)
+{
+	return priv->read_reg(priv, reg, val);
+}
+
+static int adin1110_write_reg_tc6(struct adin1110_priv *priv, u16 reg, u32 val)
+{
+	struct adin1110_port_priv *port_priv = priv->ports[0];
+
+	if (reg >= ADIN1110_MMS0_LIMIT)
+		return oa_tc6_write_register_mms(port_priv->tc6, OA_TC6_MAC_MMS1,
+						  reg, val);
+
+	return oa_tc6_write_register(port_priv->tc6, reg, val);
+}
+
+static int adin1110_write_reg_generic_spi(struct adin1110_priv *priv, u16 reg, u32 val)
 {
 	u32 header_len = ADIN1110_WR_HEADER_LEN;
 	u32 write_len = ADIN1110_REG_LEN;
@@ -263,6 +297,11 @@ static int adin1110_write_reg(struct adin1110_priv *priv, u16 reg, u32 val)
 	return spi_write(priv->spidev, &priv->data[0], header_len + write_len);
 }
 
+static int adin1110_write_reg(struct adin1110_priv *priv, u16 reg, u32 val)
+{
+	return priv->write_reg(priv, reg, val);
+}
+
 static int adin1110_set_bits(struct adin1110_priv *priv, u16 reg,
 			     unsigned long mask, unsigned long val)
 {
@@ -881,6 +920,22 @@ static void adin1110_set_rx_mode(struct net_device *dev)
 	spin_unlock(&priv->state_lock);
 }
 
+static int adin1110_set_rx_mode_tc6(struct net_device *dev,
+				    struct netdev_hw_addr_list *uc,
+				    struct netdev_hw_addr_list *mc)
+{
+	struct adin1110_port_priv *port_priv = netdev_priv(dev);
+	struct adin1110_priv *priv = port_priv->priv;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	port_priv->flags = dev->flags;
+	ret = adin1110_setup_rx_mode(port_priv);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
 static int adin1110_net_open(struct net_device *net_dev)
 {
 	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
@@ -938,6 +993,31 @@ static int adin1110_net_open(struct net_device *net_dev)
 	return 0;
 }
 
+static int adin1110_net_open_tc6(struct net_device *net_dev)
+{
+	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
+	struct adin1110_priv *priv = port_priv->priv;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	/* Needed for the broadcast/multicast filters to forward to the host */
+	port_priv->state = BR_STATE_FORWARDING;
+
+	ret = adin1110_set_mac_address(net_dev, net_dev->dev_addr);
+	mutex_unlock(&priv->lock);
+	if (ret < 0) {
+		netdev_err(net_dev, "Could not set MAC address: %pM, %d\n",
+			   net_dev->dev_addr, ret);
+		return ret;
+	}
+
+	phy_start(net_dev->phydev);
+	netif_start_queue(net_dev);
+
+	return 0;
+}
+
 static int adin1110_net_stop(struct net_device *net_dev)
 {
 	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
@@ -961,6 +1041,14 @@ static int adin1110_net_stop(struct net_device *net_dev)
 	return 0;
 }
 
+static int adin1110_net_stop_tc6(struct net_device *net_dev)
+{
+	netif_stop_queue(net_dev);
+	phy_stop(net_dev->phydev);
+
+	return 0;
+}
+
 static void adin1110_tx_work(struct work_struct *work)
 {
 	struct adin1110_port_priv *port_priv;
@@ -1006,6 +1094,18 @@ static netdev_tx_t adin1110_start_xmit(struct sk_buff *skb, struct net_device *d
 	return netdev_ret;
 }
 
+static netdev_tx_t adin1110_start_xmit_tc6(struct sk_buff *skb, struct net_device *dev)
+{
+	struct adin1110_port_priv *port_priv = netdev_priv(dev);
+
+	if (skb_put_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	return oa_tc6_start_xmit(port_priv->tc6, skb);
+}
+
 static void adin1110_ndo_get_stats64(struct net_device *dev,
 				     struct rtnl_link_stats64 *storage)
 {
@@ -1056,6 +1156,16 @@ static const struct net_device_ops adin1110_netdev_ops = {
 	.ndo_get_phys_port_name	= adin1110_ndo_get_phys_port_name,
 };
 
+static const struct net_device_ops adin1110_tc6_netdev_ops = {
+	.ndo_open		= adin1110_net_open_tc6,
+	.ndo_stop		= adin1110_net_stop_tc6,
+	.ndo_eth_ioctl		= adin1110_ioctl,
+	.ndo_start_xmit		= adin1110_start_xmit_tc6,
+	.ndo_set_mac_address	= adin1110_ndo_set_mac_address,
+	.ndo_set_rx_mode_async	= adin1110_set_rx_mode_tc6,
+	.ndo_validate_addr	= eth_validate_addr,
+};
+
 static void adin1110_get_drvinfo(struct net_device *dev,
 				 struct ethtool_drvinfo *di)
 {
@@ -1123,6 +1233,69 @@ static int adin1110_check_spi(struct adin1110_priv *priv)
 	return 0;
 }
 
+static void adin1110_oa_tc6_remove(void *data)
+{
+	oa_tc6_exit(data);
+}
+
+static int adin1110_oa_tc6_probe(struct adin1110_priv *priv)
+{
+	struct adin1110_port_priv *port_priv;
+	struct oa_tc6_quirks quirks = {0};
+	struct net_device *netdev;
+	struct device *dev;
+	int ret;
+
+	dev = &priv->spidev->dev;
+
+	if (priv->cfg->id == ADIN2111_MAC)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "OA TC6 isn't supported for ADIN2111\n");
+
+	netdev = devm_alloc_etherdev(dev, sizeof(*port_priv));
+	if (!netdev)
+		return -ENOMEM;
+
+	port_priv = netdev_priv(netdev);
+	port_priv->netdev = netdev;
+	port_priv->priv = priv;
+	port_priv->cfg = priv->cfg;
+	port_priv->nr = 0;
+	priv->ports[0] = port_priv;
+	SET_NETDEV_DEV(netdev, dev);
+
+	quirks.reset_settle_us = 50000;
+
+	port_priv->tc6 = oa_tc6_init(priv->spidev, netdev, &quirks);
+	if (IS_ERR(port_priv->tc6))
+		return PTR_ERR(port_priv->tc6);
+
+	priv->read_reg = adin1110_read_reg_tc6;
+	priv->write_reg = adin1110_write_reg_tc6;
+
+	ret = devm_add_action_or_reset(dev, adin1110_oa_tc6_remove,
+				       port_priv->tc6);
+	if (ret)
+		return ret;
+
+	/* The OA TC6 framework doesn't append the FCS, let the MAC do it. */
+	ret = adin1110_set_bits(priv, ADIN1110_CONFIG2, ADIN1110_CRC_APPEND,
+				ADIN1110_CRC_APPEND);
+	if (ret < 0)
+		return ret;
+
+	if (device_get_ethdev_address(dev, netdev))
+		eth_hw_addr_random(netdev);
+
+	netdev->if_port = IF_PORT_10BASET;
+	netdev->netdev_ops = &adin1110_tc6_netdev_ops;
+	netdev->ethtool_ops = &adin1110_ethtool_ops;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->netns_immutable = true;
+
+	return devm_register_netdev(dev, netdev);
+}
+
 static int adin1110_hw_forwarding(struct adin1110_priv *priv, bool enable)
 {
 	int ret;
@@ -1649,6 +1822,7 @@ static int adin1110_probe(struct spi_device *spi)
 	const struct spi_device_id *dev_id = spi_get_device_id(spi);
 	struct device *dev = &spi->dev;
 	struct adin1110_priv *priv;
+	bool oa_tc6_protocol;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct adin1110_priv), GFP_KERNEL);
@@ -1663,11 +1837,19 @@ static int adin1110_probe(struct spi_device *spi)
 	mutex_init(&priv->lock);
 	spin_lock_init(&priv->state_lock);
 
+	oa_tc6_protocol = device_property_read_bool(dev, "adi,spi-oa-tc6");
+
+	if (oa_tc6_protocol)
+		return adin1110_oa_tc6_probe(priv);
+
 	/* use of CRC on control and data transactions is pin dependent */
 	priv->append_crc = device_property_read_bool(dev, "adi,spi-crc");
 	if (priv->append_crc)
 		crc8_populate_msb(adin1110_crc_table, 0x7);
 
+	priv->read_reg = adin1110_read_reg_generic_spi;
+	priv->write_reg = adin1110_write_reg_generic_spi;
+
 	ret = adin1110_check_spi(priv);
 	if (ret < 0) {
 		dev_err(dev, "Probe SPI Read check failed: %d\n", ret);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index e0627b99e569..2fd051e1c604 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -79,6 +79,7 @@
 #define OA_TC6_PHY_C45_AUTO_NEG_MMS5		5	/* MMD 7 */
 #define OA_TC6_PHY_C45_POWER_UNIT_MMS6		6	/* MMD 13 */
 
+struct mii_bus;
 struct oa_tc6;
 
 enum oa_tc6_quirk_flag {
-- 
2.43.0

