Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214939;
	b=o/5j3lgRtbSYnVx3fOjGL1YOTHzj9dWYlkZz0k3VNzo81JoWH9nOShY4kUQ4p02G1dyh
	 WZ9V+BV5CIETuURJDbYQFpXgo865D1XOPx4hdGrv74tzFMmQnCvlZH2fhzmWG1CSgdOcb
	 rk5BjevvIXJDAv6CUDE922D7i8Voc/zNvXq909NUW/ZNi+0PIV4V+I5PuNP2zlahJ8yOH
	 QcMGrgwRkeslyFubL7D5iSNL4kSlbIQHqH0I+gPwUkA6jGo2KxgkKkGHf66kbFdTe/A93
	 KfQfWmvPmRM8WIYB9dC1KAmc4BzdqmNH4eDW6mwIbW+vZ6hqzA5TFIYYbaZSEdcQ0KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214939;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OiIrkS/FrAToZga2pBkKoTHUFOwCRHo9qPdA54f6cRM=;
	b=LzClvdd9qPwXhdnN7AcPuAxq/glBcBgt9URQtqHOpGCQ8tn+XdKncMEBJIsm+062lbKk
	 neSESEqz8fgB8TA9SABitEw1VQMuuT0qIVb31q61/2H5Tmaf88gcRwxAiFTGtyAawdUhO
	 1PsRnO5otx1RJUpd7E92KILqe8r6aRLYLjivsJw7DB1wl/A/APB06ZFJYwAOIK5sLKkLG
	 AswgQQredfqjN3gaBDEGRTxVKW84erQz4QNYlfab6ijo/T3y3qjvy+ldGgo/GxSQHyRI/
	 iyXl3fCXl20y9FqvRQam7JE0RgYv3h1cyUiTaKETxVPi0GzaXysuqViySIFbAujDtnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DHeaPKvm;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BDlmyxmm;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E971606A322;
	Mon,  9 Nov 2026 09:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E971606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DHeaPKvm;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=BDlmyxmm
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96Bt8A3169891;
	Mon, 9 Nov 2026 04:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=OiIrkS/FrAToZga2pBkKoTHUFOwCRHo9qPdA54f6cRM=; b=DHeaPKv
	mYD47HlwksfZuJOPtIjYruhhojIp/nmwMI2nkskXarPYPZqO+ALHl8EVsNvCYkDY
	bTL/a7hKfD52KlQmejSTxXUekhWiB3D3CB344LrcQdII0YQOBhA4X4rtOrgK+bPo
	3P3JATB4noDjZ5s5EqwOwZhzMIP3SORr8uEs3qPQCOMOCwVUsL+vOsXe312JHdGZ
	wrJi1d+7lrM6kYEzXb3GVKPHagM4MKEI49lL8v01LPsbveGR1W01bhtBtrqP5kfn
	5K4OwFeUKruha6Zz4egtT+1680PLCtX18ynxbUOmxOZ/hLN4VQBOIasl61yjAshx
	RGcb4WULJvIjMzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OiIrk
	S/FrAToZga2pBkKoTHUFOwCRHo9qPdA54f6cRM=; b=BDlmyxmm3wDkFla7rc5Gh
	uejHM/k/w2hTY+jRB8cnjNV9YIucG/jxINS1eVus1sZ7QIBNgR0uGg8oIMls8nFz
	hS0NkeBADlyj7LyCDlK8dKPBbtGpuFGC3FYCupfqiWy3afj+OVQDrUtShHav46ey
	nDOa34sw1/Rrce20OuMxnn5sFESSrHFLG2t9N8Xn9TVtbhtRuDkYrx6tK7Iq7zKb
	/j/xw4LdNeCwmqfbEmaEUttIn8qhHWc1iVAfboJGm6tD9Kmxq+Qnmj/U9N017vsM
	CfUcYicMvVAA23HEZ7t77nqMR2KTgpA1JqEGDZqu5ZEO5wm72Zc10mBvD+LIOUad
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ht1s7a94s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 04:02:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A9921Cw045802
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 04:02:01 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 04:02:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 04:02:01 -0500
Received: from HYB-6AVb5If9qTU.ad.analog.com (HYB-6AVb5If9qTU.ad.analog.com [10.135.4.41])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A98xreM024796;
	Mon, 9 Nov 2026 04:01:54 -0500
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
CC: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
        Ciprian Regus
	<ciprian.regus@analog.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iustin
 Stolniceanu <iustin.stolniceanu@analog.com>
Subject: [PATCH net-next v2 7/7] net: ethernet: adi: adin1110: Add OA TC6 protocol support for ADIN1110
Date: Mon, 9 Nov 2026 10:59:52 +0200
Message-ID: <20261109085952.105331-8-iustin.stolniceanu@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-1-iustin.stolniceanu@analog.com>
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
X-Authority-Analysis: v=2.4 cv=c4A+0h9l c=1 sm=1 tr=0 ts=6af18c0b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=vS59efpLlZnIYc5Nq3wA:9
X-Proofpoint-GUID: 0W2QT0cRuShxmTQWx0CyCPH0aZ2Wu8No
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfXwdoNYjvHApom
 qtnuEW6UOdMpEerdeDpzgnkHl7UUJB4DdjIZGuaZ4UxYRohkUIIV7W8IO4/bY3tG5AoePI1AMpQ
 zYO1mwWRFbLrSXNrU3IwFk3hmwC1l43zYBrfqD58WVvjrUCOoQg0/PzAyYmzQ4Fc5PAVDxp7F2g
 6eCKddvbvqbaSWL08bxMohzmrvQlYyNp105RFgloBP0Ho3xBkmOreMhme7f/bAPLc5Dj5YWBnzn
 Ic/yU4TO488W1ouKj+yuCVvBRT+b0HLfPJkrq0/tJE9hNzE91yqMT0ogibBvYoO0ieNSg7jy3Zh
 FENiOR2PsqfA0fD87ydntVzofU7eN5KxX4HhV9cayRwJmIRDAQ1jWExYR/4ZflnMOnm/0VfPodv
 mVP0t4yOwmuRNwF4HA0bvns+9oS1ZCPo0SiH3BXtAqF42VsxBs4kiL2UiI7e6CI4YifnKD5phty
 f507wOYXkN2OrdY6ibg==
X-Proofpoint-ORIG-GUID: 0W2QT0cRuShxmTQWx0CyCPH0aZ2Wu8No
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX1ndomixwQllS
 2pl3Eo6vCJ1wy3TayKj4zEGwmAemUzMTopy8SJ07LMzjwq/t9XDsJb4Mv9AdooZ3TaMvjHnED42
 P1oSGU9BIBihayj1bMB3aLD9c7Wb+O1K/zyQJ88UE9OK5fbC0ylZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090035

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

The MAC filter is not programmed with the unicast and multicast address
lists, so accept all multicast frames when the multicast list is not
empty, and do not set IFF_UNICAST_FLT. The core then enables promiscuous
mode for secondary unicast addresses.

The ADIN2111 is not supported in OPEN Alliance TC6 mode yet, and probe
fails with -ENODEV.

No register reports the selected protocol, so the driver relies on
adi,spi-oa-tc6 matching the board strapping. If the first OA TC6 control
transfer gets no valid reply, or the PHY ID does not match, probe fails
with -ENODEV and a message pointing at the strap and the property. The
generic SPI path now does the same on a PHY ID mismatch, instead of
returning -EIO.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Co-developed-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Signed-off-by: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
---
 drivers/net/ethernet/adi/Kconfig    |   1 +
 drivers/net/ethernet/adi/adin1110.c | 206 +++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 4 deletions(-)

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
index 53fac3dc8be6..3f054565acb0 100644
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
@@ -881,6 +920,27 @@ static void adin1110_set_rx_mode(struct net_device *dev)
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
+	/* The multicast list isn't programmed into the MAC filter, so accept
+	 * all multicast when it is not empty.
+	 */
+	if (!netdev_hw_addr_list_empty(mc))
+		port_priv->flags |= IFF_ALLMULTI;
+	ret = adin1110_setup_rx_mode(port_priv);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
 static int adin1110_net_open(struct net_device *net_dev)
 {
 	struct adin1110_port_priv *port_priv = netdev_priv(net_dev);
@@ -938,6 +998,31 @@ static int adin1110_net_open(struct net_device *net_dev)
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
@@ -961,6 +1046,14 @@ static int adin1110_net_stop(struct net_device *net_dev)
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
@@ -1006,6 +1099,18 @@ static netdev_tx_t adin1110_start_xmit(struct sk_buff *skb, struct net_device *d
 	return netdev_ret;
 }
 
+static netdev_tx_t adin1110_start_xmit_tc6(struct sk_buff *skb, struct net_device *dev)
+{
+	struct adin1110_port_priv *port_priv = netdev_priv(dev);
+
+	if (skb_put_padto(skb, ETH_ZLEN)) {
+		DEV_STATS_INC(dev, tx_dropped);
+		return NETDEV_TX_OK;
+	}
+
+	return oa_tc6_start_xmit(port_priv->tc6, skb);
+}
+
 static void adin1110_ndo_get_stats64(struct net_device *dev,
 				     struct rtnl_link_stats64 *storage)
 {
@@ -1056,6 +1161,16 @@ static const struct net_device_ops adin1110_netdev_ops = {
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
@@ -1115,14 +1230,89 @@ static int adin1110_check_spi(struct adin1110_priv *priv)
 		return ret;
 
 	if (val != priv->cfg->phy_id_val) {
-		dev_err(&priv->spidev->dev, "PHY ID expected: %x, read: %x\n",
+		dev_err(&priv->spidev->dev,
+			"PHY ID expected: %x, read: %x, check the SPI_CFG1 strap and adi,spi-oa-tc6\n",
 			priv->cfg->phy_id_val, val);
-		return -EIO;
+		return -ENODEV;
 	}
 
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
+	u32 val;
+	int ret;
+
+	dev = &priv->spidev->dev;
+
+	if (priv->cfg->id == ADIN2111_MAC)
+		return dev_err_probe(dev, -ENODEV,
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
+	quirks.hwreset_settle_us = 50000;
+	quirks.softreset_settle_us = 10000;
+
+	port_priv->tc6 = oa_tc6_init(priv->spidev, netdev, &quirks);
+	if (PTR_ERR_OR_ZERO(port_priv->tc6) == -EPROTO)
+		return dev_err_probe(dev, -ENODEV,
+				     "no OA TC6 reply, check the SPI_CFG1 strap and adi,spi-oa-tc6\n");
+	if (IS_ERR(port_priv->tc6))
+		return PTR_ERR(port_priv->tc6);
+
+	priv->read_reg = adin1110_read_reg_tc6;
+	priv->write_reg = adin1110_write_reg_tc6;
+
+	ret = devm_add_action_or_reset(dev, adin1110_oa_tc6_remove, port_priv->tc6);
+	if (ret)
+		return ret;
+
+	ret = adin1110_read_reg(priv, ADIN1110_PHY_ID, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val != priv->cfg->phy_id_val)
+		return dev_err_probe(dev, -ENODEV, "PHY ID expected: %x, read: %x\n",
+				     priv->cfg->phy_id_val, val);
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
+	netdev->netns_immutable = true;
+
+	return devm_register_netdev(dev, netdev);
+}
+
 static int adin1110_hw_forwarding(struct adin1110_priv *priv, bool enable)
 {
 	int ret;
@@ -1649,6 +1839,7 @@ static int adin1110_probe(struct spi_device *spi)
 	const struct spi_device_id *dev_id = spi_get_device_id(spi);
 	struct device *dev = &spi->dev;
 	struct adin1110_priv *priv;
+	bool oa_tc6_protocol;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(struct adin1110_priv), GFP_KERNEL);
@@ -1663,11 +1854,18 @@ static int adin1110_probe(struct spi_device *spi)
 	mutex_init(&priv->lock);
 	spin_lock_init(&priv->state_lock);
 
+	oa_tc6_protocol = device_property_read_bool(dev, "adi,spi-oa-tc6");
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
-- 
2.43.0

