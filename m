Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFE49AA34
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950518; cv=none; b=PaK9IeuaiMi+ldeReMUZCHZpz2Z1KsXQAcjOLWx5zm1klvk8q7WMbKSXV38mmc/aYRzLLhgEdst2OVAknkDAoe0C9xi86inSW5B1NHe9xiOYh3x0onk0XasnR1o+ibsJczRD8KadQaFq+JPRJPJuDEgmTqnWN7KwHPrQe7lw8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950518; c=relaxed/simple;
	bh=AqJmCi2YsY1ob22ZjpZjFyG+KYuMJSmhjQsCajXetDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o79aYFqfQyv5cchCQyWjAHzDTLswVa6uybJg/5/YptClGjFvhSn8+Ck4YsK0lf5xhG+655VmEtnmXIlYC0q6E8KOoyrqkcV29ZDO4eyNF8mVihGU1k+4h8d6yW3mcDxnjwz0DQXAMGUq/+UbSutdrqCTl2o4gzxQsVgqGk7yU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaVbaSVK; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaVbaSVK"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-98514b4115eso5078096241.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 07:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790950511; x=1791555311; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rkxAo9oG/0ZbXJycD1LiahxFQlljdG0HMtDwWXkYjP0=;
        b=kaVbaSVKWI7um4AhFcrEy3JycABdiubwC8UwJa44/wo7AKfJBUF5ZZpHgHrtL6z+2/
         SHmbrTsCF7utSefkJOk9fUDu245VDTz/rV7+vxlvN2e0MkqvBRheSDh44gZVlhwH48fF
         YefEGaf0cHOg/5EgN9DnirY2A9PrpbVngbpMEJGAytdBwJNeFGUPrDwvsIEadAYx3P+4
         0Fv7XJqH7EwmxqWU8Fo15FoydIDfmI5j0nG1hTO7cuEUJmz+1Y7PTHYboU26h9aw7TjK
         tCbIPbqQeW+rWlCOmIQKLJVpMUA4099ZGe3oHJPD7/Yg5i1Raf27XbZ7RTzDQx4geYHP
         AH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790950511; x=1791555311;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rkxAo9oG/0ZbXJycD1LiahxFQlljdG0HMtDwWXkYjP0=;
        b=bgNWgHEH7xidbTOdo+NjdFl85h2uT4sVKdiPX8zkXEnyVET3DvtrOHxMgCcgYyeBhY
         Crvvw/vYBlkqIMOvFm1DnXYraPhdd4RqxOCE56JYuDNw8cwRWsdNgv3oS5gSLEedIey3
         cTiX9gRv9KQ9O+Zp1CuNY4ZJz+OypovaEX484tdVhmbMXx61gredSvoRblVeD7XcXL/i
         ArEmR27ex6jB1tF6gRDQPjj3kY02TSBxf/3hjTjNZifGDvb8Me70mlO09emhvOlSiGdN
         mA8fb7dXrf0dFh/6clphnfqa02oRYpPE+/w5i2MMiM2we2u635Qeq2PUh5DqYd9cqNoM
         eE7w==
X-Gm-Message-State: AFq9FYLWjND7hStG5q3jgsYSvyaeh0eoVB8F8BnNxVM9tW3VjadLyQ2b
	Z9IXXzXgUv4T1a7QgGC/AwS3Vi4fCTTvFUe/PcfeEFL9yi1UehReuHgd
X-Gm-Gg: AYBFou1Bz17eUHx3AlVdXFhg4DepYisv8/lZlilmvA+2q6xAxgDWOuKWBZ2h4MJV5kq
	U3gsbqvHC8QR2QddxsBBHt6Y5OS9cH694WLNMNzW4umC9tsYEbmalO3H1sYPLxZ0u139Ozl48sL
	PjuUukAA+1+KRIHGsokWRdFkFEdAU/jJnDhdeKUZmvGiWDhQ6TBlVzMdSPLOvE869oo2HrkCWYZ
	/mD3FoCNOkru1Cprf4dTjT1v/+7vJY1zTHgvDj1xB0TnVOiiH9pDig0c+5xgcGfgxXgKwwYGa+w
	+QU/Iozw5gDiiI3D7aC6aqN8eMRLQ9HXTNONY3GrrX89EJxyJBZFXo9SxuKeCWb11of5NAiG/0c
	BcdeEnK9mZH666uWAS+W0YyuOh9sypemFQzNo+a/AjsYgFZHC9YHAnLqQYOmhVcu3dFnYvI7JG6
	grTci+jNMqA9JAgoqm+yA+SdZBR3sbtngs6a0wQYIFmYedD4Dm/ulCmZQEMy6PTFJKKjJEjv9Pb
	pzYevx1UQk=
X-Received: by 2002:a05:6102:334d:b0:7a7:198a:c2bc with SMTP id ada2fe7eead31-7c0f59ae4e7mr840164137.36.1790950510945;
        Fri, 02 Oct 2026 07:15:10 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.37.57.96])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0fdc62625sm2529395137.1.2026.10.02.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:15:10 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 02 Oct 2026 11:14:57 -0300
Subject: [PATCH net-next] net: dsa: realtek: rtl8365mb: define masks using
 BIT() and GENMASK()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-realtek_bit-v1-1-771fb0e39083@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGC8v2oC/yWMQQrCMBQFr1Le2kAaaaFeRUSS9FW/SpTkK4XSu
 5vqchhmFhRmYcGhWZD5kSLPVKHdNYhXny40MlaGs65vrXUm0z+U93MQNWHg0E2934+MqMUrc5L
 5dzsiUU3irDj9TXmHG6NuM6zrF8nh0BV5AAAA
X-Change-ID: 20261002-realtek_bit-b9e95f6a3dec
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.16.0

Refactor register bitmask definitions to use the standard BIT() and
GENMASK() macros instead of hardcoded hexadecimal values. This improves
code readability, reducing the chance of errors such as unintentional
gaps or overlaps.

Introduce RTL8365MB_PORT_MASK as an alias for GENMASK(10, 0) to replace
the repetitive 0x07FF values used across various port-related bitfields.

This is a pure refactoring patch; no functional changes are introduced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 168 ++++++++++++++++---------------
 drivers/net/dsa/realtek/rtl8365mb_vlan.c |   4 +-
 2 files changed, 87 insertions(+), 85 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 87ec924a0611..da06f952a053 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -132,32 +132,32 @@
 #define   RTL8365MB_MAGIC_VALUE		0x0249
 
 /* Chip reset register */
-#define RTL8365MB_CHIP_RESET_REG	0x1322
-#define RTL8365MB_CHIP_RESET_DW8051_MASK	0x0010
-#define RTL8365MB_CHIP_RESET_SW_MASK	0x0002
-#define RTL8365MB_CHIP_RESET_HW_MASK	0x0001
+#define RTL8365MB_CHIP_RESET_REG		0x1322
+#define RTL8365MB_CHIP_RESET_DW8051_MASK	BIT(4)
+#define RTL8365MB_CHIP_RESET_SW_MASK		BIT(1)
+#define RTL8365MB_CHIP_RESET_HW_MASK		BIT(0)
 
 /* Interrupt polarity register */
 #define RTL8365MB_INTR_POLARITY_REG	0x1100
-#define   RTL8365MB_INTR_POLARITY_MASK	0x0001
+#define   RTL8365MB_INTR_POLARITY_MASK	BIT(0)
 #define   RTL8365MB_INTR_POLARITY_HIGH	0
 #define   RTL8365MB_INTR_POLARITY_LOW	1
 
 /* Interrupt control/status register - enable/check specific interrupt types */
 #define RTL8365MB_INTR_CTRL_REG			0x1101
-#define RTL8365MB_INTR_STATUS_REG		0x1102
-#define   RTL8365MB_INTR_SLIENT_START_2_MASK	0x1000
-#define   RTL8365MB_INTR_SLIENT_START_MASK	0x0800
-#define   RTL8365MB_INTR_ACL_ACTION_MASK	0x0200
-#define   RTL8365MB_INTR_CABLE_DIAG_FIN_MASK	0x0100
-#define   RTL8365MB_INTR_INTERRUPT_8051_MASK	0x0080
-#define   RTL8365MB_INTR_LOOP_DETECTION_MASK	0x0040
-#define   RTL8365MB_INTR_GREEN_TIMER_MASK	0x0020
-#define   RTL8365MB_INTR_SPECIAL_CONGEST_MASK	0x0010
-#define   RTL8365MB_INTR_SPEED_CHANGE_MASK	0x0008
-#define   RTL8365MB_INTR_LEARN_OVER_MASK	0x0004
-#define   RTL8365MB_INTR_METER_EXCEEDED_MASK	0x0002
-#define   RTL8365MB_INTR_LINK_CHANGE_MASK	0x0001
+#define   RTL8365MB_INTR_STATUS_REG		0x1102
+#define   RTL8365MB_INTR_SLIENT_START_2_MASK	BIT(12)
+#define   RTL8365MB_INTR_SLIENT_START_MASK	BIT(11)
+#define   RTL8365MB_INTR_ACL_ACTION_MASK	BIT(9)
+#define   RTL8365MB_INTR_CABLE_DIAG_FIN_MASK	BIT(8)
+#define   RTL8365MB_INTR_INTERRUPT_8051_MASK	BIT(7)
+#define   RTL8365MB_INTR_LOOP_DETECTION_MASK	BIT(6)
+#define   RTL8365MB_INTR_GREEN_TIMER_MASK	BIT(5)
+#define   RTL8365MB_INTR_SPECIAL_CONGEST_MASK	BIT(4)
+#define   RTL8365MB_INTR_SPEED_CHANGE_MASK	BIT(3)
+#define   RTL8365MB_INTR_LEARN_OVER_MASK	BIT(2)
+#define   RTL8365MB_INTR_METER_EXCEEDED_MASK	BIT(1)
+#define   RTL8365MB_INTR_LINK_CHANGE_MASK	BIT(0)
 #define   RTL8365MB_INTR_ALL_MASK                      \
 		(RTL8365MB_INTR_SLIENT_START_2_MASK |  \
 		 RTL8365MB_INTR_SLIENT_START_MASK |    \
@@ -172,20 +172,22 @@
 		 RTL8365MB_INTR_METER_EXCEEDED_MASK |  \
 		 RTL8365MB_INTR_LINK_CHANGE_MASK)
 
+#define RTL8365MB_PORT_MASK			GENMASK(10, 0)
+
 /* Per-port interrupt type status registers */
 #define RTL8365MB_PORT_LINKDOWN_IND_REG		0x1106
-#define   RTL8365MB_PORT_LINKDOWN_IND_MASK	0x07FF
+#define   RTL8365MB_PORT_LINKDOWN_IND_MASK	RTL8365MB_PORT_MASK
 
 #define RTL8365MB_PORT_LINKUP_IND_REG		0x1107
-#define   RTL8365MB_PORT_LINKUP_IND_MASK	0x07FF
+#define   RTL8365MB_PORT_LINKUP_IND_MASK	RTL8365MB_PORT_MASK
 
 /* PHY indirect access registers */
 #define RTL8365MB_INDIRECT_ACCESS_CTRL_REG			0x1F00
-#define   RTL8365MB_INDIRECT_ACCESS_CTRL_RW_MASK		0x0002
-#define   RTL8365MB_INDIRECT_ACCESS_CTRL_RW_READ		0
-#define   RTL8365MB_INDIRECT_ACCESS_CTRL_RW_WRITE		1
-#define   RTL8365MB_INDIRECT_ACCESS_CTRL_CMD_MASK		0x0001
-#define   RTL8365MB_INDIRECT_ACCESS_CTRL_CMD_VALUE		1
+#define   RTL8365MB_INDIRECT_ACCESS_CTRL_RW_MASK		BIT(1)
+#define     RTL8365MB_INDIRECT_ACCESS_CTRL_RW_READ		0
+#define     RTL8365MB_INDIRECT_ACCESS_CTRL_RW_WRITE		1
+#define   RTL8365MB_INDIRECT_ACCESS_CTRL_CMD_MASK		BIT(0)
+#define     RTL8365MB_INDIRECT_ACCESS_CTRL_CMD_VALUE		1
 #define RTL8365MB_INDIRECT_ACCESS_STATUS_REG			0x1F01
 #define RTL8365MB_INDIRECT_ACCESS_ADDRESS_REG			0x1F02
 #define   RTL8365MB_INDIRECT_ACCESS_ADDRESS_OCPADR_5_1_MASK	GENMASK(4, 0)
@@ -197,8 +199,8 @@
 
 /* PHY OCP address prefix register */
 #define RTL8365MB_GPHY_OCP_MSB_0_REG			0x1D15
-#define   RTL8365MB_GPHY_OCP_MSB_0_CFG_CPU_OCPADR_MASK	0x0FC0
-#define RTL8365MB_PHY_OCP_ADDR_PREFIX_MASK		0xFC00
+#define   RTL8365MB_GPHY_OCP_MSB_0_CFG_CPU_OCPADR_MASK	GENMASK(11, 6)
+#define RTL8365MB_PHY_OCP_ADDR_PREFIX_MASK		GENMASK(15, 10)
 
 /* The full 16-bit OCP address is split across two registers: bits [15:10] are
  * the prefix (RTL8365MB_PHY_OCP_ADDR_PREFIX_MASK above), and bits [9:1] go into
@@ -252,8 +254,8 @@
 		 (_extint) == 1 ? RTL8365MB_EXT_RGMXF_REG1 : \
 		 (_extint) == 2 ? RTL8365MB_EXT_RGMXF_REG2 : \
 		 0x0)
-#define   RTL8365MB_EXT_RGMXF_RXDELAY_MASK	0x0007
-#define   RTL8365MB_EXT_RGMXF_TXDELAY_MASK	0x0008
+#define   RTL8365MB_EXT_RGMXF_RXDELAY_MASK	GENMASK(2, 0)
+#define   RTL8365MB_EXT_RGMXF_TXDELAY_MASK	BIT(3)
 
 /* External interface line rate bypass register - one bit per external
  * interface, indexed by the external port number with port 5 (the first
@@ -271,28 +273,28 @@
  */
 #define RTL8365MB_INGRESSBW_PORT6_RATE_CTRL0_REG	0x00CF
 #define RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_REG	0x00D0
-#define   RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK	0x0007
+#define   RTL8365MB_INGRESSBW_PORT6_RATE_CTRL1_MASK	GENMASK(2, 0)
 #define RTL8365MB_PORT6_EGRESSBW_CTRL0_REG		0x0398
 #define RTL8365MB_PORT6_EGRESSBW_CTRL1_REG		0x0399
-#define   RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK		0x0007
+#define   RTL8365MB_PORT6_EGRESSBW_CTRL1_MASK		GENMASK(2, 0)
 
 /* SerDes indirect access registers */
 #define RTL8365MB_SDS_INDACS_CMD_REG		0x6600
-#define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	0x0100
-#define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	0x0080
-#define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	0x0040
+#define   RTL8365MB_SDS_INDACS_CMD_BUSY_MASK	BIT(8)
+#define   RTL8365MB_SDS_INDACS_CMD_RUN_MASK	BIT(7)
+#define   RTL8365MB_SDS_INDACS_CMD_WR_MASK	BIT(6)
 #define RTL8365MB_SDS_INDACS_ADR_REG		0x6601
 #define RTL8365MB_SDS_INDACS_DATA_REG		0x6602
 
 /* SerDes miscellaneous configuration register */
 #define RTL8365MB_SDS_MISC_REG				0x1D11
-#define   RTL8365MB_SDS_MISC_SGMII_RXFC_MASK		0x4000
-#define   RTL8365MB_SDS_MISC_SGMII_TXFC_MASK		0x2000
-#define   RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK	0x0800
-#define   RTL8365MB_SDS_MISC_SGMII_FDUP_MASK		0x0400
-#define   RTL8365MB_SDS_MISC_SGMII_LINK_MASK		0x0200
-#define   RTL8365MB_SDS_MISC_SGMII_SPD_MASK		0x0180
-#define   RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	0x0040
+#define   RTL8365MB_SDS_MISC_SGMII_RXFC_MASK		BIT(14)
+#define   RTL8365MB_SDS_MISC_SGMII_TXFC_MASK		BIT(13)
+#define   RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK	BIT(11)
+#define   RTL8365MB_SDS_MISC_SGMII_FDUP_MASK		BIT(10)
+#define   RTL8365MB_SDS_MISC_SGMII_LINK_MASK		BIT(9)
+#define   RTL8365MB_SDS_MISC_SGMII_SPD_MASK		GENMASK(8, 7)
+#define   RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK	BIT(6)
 
 /* SerDes internal registers, accessed via the SDS_INDACS registers. The BMCR
  * data path reset holds BMCR_ANENABLE | BMCR_ISOLATE while toggling the
@@ -303,12 +305,12 @@
 #define   RTL8365MB_SDS_BMCR_DPRST_PHASE1	(BMCR_ANENABLE | BMCR_ISOLATE | 0x1)
 #define   RTL8365MB_SDS_BMCR_DPRST_PHASE2	(BMCR_ANENABLE | BMCR_ISOLATE | 0x3)
 #define RTL8365MB_SDS_REG_NWAY			0x0002
-#define   RTL8365MB_SDS_NWAY_EN_MASK		0x0200
-#define   RTL8365MB_SDS_NWAY_RESTART_MASK	0x0100
+#define   RTL8365MB_SDS_NWAY_EN_MASK		BIT(9)
+#define   RTL8365MB_SDS_NWAY_RESTART_MASK	BIT(8)
 #define RTL8365MB_SDS_REG_RESET			0x0003
 #define   RTL8365MB_SDS_RESET_DEASSERT		0x7106
 #define RTL8365MB_SDS_REG_LINK_STATUS		0x003d
-#define   RTL8365MB_SDS_LINK_STATUS_LINK_MASK	0x0010
+#define   RTL8365MB_SDS_LINK_STATUS_LINK_MASK	BIT(4)
 
 /* The embedded SerDes can only be muxed to external interface 1 (MAC8),
  * which is port 6.
@@ -335,7 +337,7 @@
  * the firmware would otherwise do.
  */
 #define RTL8365MB_MISC_CFG0_REG			0x130C
-#define   RTL8365MB_MISC_CFG0_DW8051_EN_MASK	0x0020
+#define   RTL8365MB_MISC_CFG0_DW8051_EN_MASK	BIT(5)
 
 /* External interface port speed values - used in DIGITAL_INTERFACE_FORCE */
 #define RTL8365MB_PORT_SPEED_10M	0
@@ -351,31 +353,31 @@
 		 (_extint) == 1 ? RTL8365MB_DIGITAL_INTERFACE_FORCE_REG1 : \
 		 (_extint) == 2 ? RTL8365MB_DIGITAL_INTERFACE_FORCE_REG2 : \
 		 0x0)
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK		0x1000
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_NWAY_MASK		0x0080
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK	0x0040
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK	0x0020
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK		0x0010
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK		0x0004
-#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK		0x0003
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_EN_MASK		BIT(12)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_NWAY_MASK		BIT(7)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_TXPAUSE_MASK	BIT(6)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_RXPAUSE_MASK	BIT(5)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_LINK_MASK		BIT(4)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_DUPLEX_MASK		BIT(2)
+#define   RTL8365MB_DIGITAL_INTERFACE_FORCE_SPEED_MASK		GENMASK(1, 0)
 
 /* CPU port mask register - controls which ports are treated as CPU ports */
 #define RTL8365MB_CPU_PORT_MASK_REG	0x1219
-#define   RTL8365MB_CPU_PORT_MASK_MASK	0x07FF
+#define   RTL8365MB_CPU_PORT_MASK_MASK	RTL8365MB_PORT_MASK
 
 /* CPU control register */
 #define RTL8365MB_CPU_CTRL_REG			0x121A
-#define   RTL8365MB_CPU_CTRL_TRAP_PORT_EXT_MASK	0x0400
-#define   RTL8365MB_CPU_CTRL_TAG_FORMAT_MASK	0x0200
-#define   RTL8365MB_CPU_CTRL_RXBYTECOUNT_MASK	0x0080
-#define   RTL8365MB_CPU_CTRL_TAG_POSITION_MASK	0x0040
-#define   RTL8365MB_CPU_CTRL_TRAP_PORT_MASK	0x0038
-#define   RTL8365MB_CPU_CTRL_INSERTMODE_MASK	0x0006
-#define   RTL8365MB_CPU_CTRL_EN_MASK		0x0001
+#define   RTL8365MB_CPU_CTRL_TRAP_PORT_EXT_MASK	BIT(10)
+#define   RTL8365MB_CPU_CTRL_TAG_FORMAT_MASK	BIT(9)
+#define   RTL8365MB_CPU_CTRL_RXBYTECOUNT_MASK	BIT(7)
+#define   RTL8365MB_CPU_CTRL_TAG_POSITION_MASK	BIT(6)
+#define   RTL8365MB_CPU_CTRL_TRAP_PORT_MASK	GENMASK(5, 3)
+#define   RTL8365MB_CPU_CTRL_INSERTMODE_MASK	GENMASK(2, 1)
+#define   RTL8365MB_CPU_CTRL_EN_MASK		BIT(0)
 
 /* Maximum packet length register */
 #define RTL8365MB_CFG0_MAX_LEN_REG	0x088C
-#define   RTL8365MB_CFG0_MAX_LEN_MASK	0x3FFF
+#define   RTL8365MB_CFG0_MAX_LEN_MASK	GENMASK(13, 0)
 #define RTL8365MB_CFG0_MAX_LEN_MAX	0x3FFF
 
 /* Port learning limit registers */
@@ -387,7 +389,7 @@
 #define RTL8365MB_PORT_ISOLATION_REG_BASE		0x08A2
 #define RTL8365MB_PORT_ISOLATION_REG(_physport) \
 		(RTL8365MB_PORT_ISOLATION_REG_BASE + (_physport))
-#define   RTL8365MB_PORT_ISOLATION_MASK			0x07FF
+#define   RTL8365MB_PORT_ISOLATION_MASK			RTL8365MB_PORT_MASK
 
 /* Extended filter ID registers - used to key forwarding database with IVL */
 #define RTL8365MB_EFID_MASK			GENMASK(2, 0)
@@ -407,16 +409,16 @@
 		(0x3 << RTL8365MB_MSTI_CTRL_PORT_STATE_OFFSET((_physport)))
 
 /* Unknown unicast DA flooding port mask */
-#define RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_REG		0x0890
-#define   RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_MASK		0x07FF
+#define RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_REG	0x0890
+#define   RTL8365MB_UNKNOWN_UNICAST_FLOODING_PMASK_MASK	RTL8365MB_PORT_MASK
 
 /* Unknown multicast DA flooding port mask */
-#define RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_REG		0x0891
-#define   RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_MASK	0x07FF
+#define RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_REG	  0x0891
+#define   RTL8365MB_UNKNOWN_MULTICAST_FLOODING_PMASK_MASK RTL8365MB_PORT_MASK
 
 /* Broadcast flooding port mask */
-#define RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_REG		0x0892
-#define   RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_MASK	0x07FF
+#define RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_REG	  0x0892
+#define   RTL8365MB_UNKNOWN_BROADCAST_FLOODING_PMASK_MASK RTL8365MB_PORT_MASK
 
 #define RTL8365MB_SUPPORTED_BRIDGE_FLAGS \
 	    (BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD)
@@ -425,19 +427,19 @@
 #define RTL8365MB_PORT_MISC_CFG_REG_BASE			0x000E
 #define RTL8365MB_PORT_MISC_CFG_REG(_p) \
 		(RTL8365MB_PORT_MISC_CFG_REG_BASE + ((_p) << 5))
-#define   RTL8365MB_PORT_MISC_CFG_SMALL_TAG_IPG_MASK		0x8000
-#define   RTL8365MB_PORT_MISC_CFG_TX_ITFSP_MODE_MASK		0x4000
-#define   RTL8365MB_PORT_MISC_CFG_FLOWCTRL_INDEP_MASK		0x2000
-#define   RTL8365MB_PORT_MISC_CFG_DOT1Q_REMARK_ENABLE_MASK	0x1000
-#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_FLOWCTRL_MASK	0x0800
-#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_IFG_MASK		0x0400
-#define   RTL8365MB_PORT_MISC_CFG_RX_SPC_MASK			0x0200
-#define   RTL8365MB_PORT_MISC_CFG_CRC_SKIP_MASK			0x0100
-#define   RTL8365MB_PORT_MISC_CFG_PKTGEN_TX_FIRST_MASK		0x0080
-#define   RTL8365MB_PORT_MISC_CFG_MAC_LOOPBACK_MASK		0x0040
+#define   RTL8365MB_PORT_MISC_CFG_SMALL_TAG_IPG_MASK		BIT(15)
+#define   RTL8365MB_PORT_MISC_CFG_TX_ITFSP_MODE_MASK		BIT(14)
+#define   RTL8365MB_PORT_MISC_CFG_FLOWCTRL_INDEP_MASK		BIT(13)
+#define   RTL8365MB_PORT_MISC_CFG_DOT1Q_REMARK_ENABLE_MASK	BIT(12)
+#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_FLOWCTRL_MASK	BIT(11)
+#define   RTL8365MB_PORT_MISC_CFG_INGRESSBW_IFG_MASK		BIT(10)
+#define   RTL8365MB_PORT_MISC_CFG_RX_SPC_MASK			BIT(9)
+#define   RTL8365MB_PORT_MISC_CFG_CRC_SKIP_MASK			BIT(8)
+#define   RTL8365MB_PORT_MISC_CFG_PKTGEN_TX_FIRST_MASK		BIT(7)
+#define   RTL8365MB_PORT_MISC_CFG_MAC_LOOPBACK_MASK		BIT(6)
 /* See &rtl8365mb_vlan_egress_mode */
-#define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		0x0030
-#define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	0x000F
+#define   RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK		GENMASK(5, 4)
+#define   RTL8365MB_PORT_MISC_CFG_CONGESTION_SUSTAIN_TIME_MASK	GENMASK(3, 0)
 
 /**
  * enum rtl8365mb_vlan_egress_mode - port VLAN egress mode
@@ -459,7 +461,7 @@ enum rtl8365mb_vlan_egress_mode {
 
 /* VLAN control register */
 #define RTL8365MB_VLAN_CTRL_REG			0x07A8
-#define   RTL8365MB_VLAN_CTRL_EN_MASK		0x0001
+#define   RTL8365MB_VLAN_CTRL_EN_MASK		BIT(0)
 
 /* VLAN ingress filter register */
 #define RTL8365MB_VLAN_INGRESS_REG				0x07A9
@@ -483,8 +485,8 @@ enum rtl8365mb_vlan_egress_mode {
 		(((RTL8365MB_MIB_ADDRESS_PORT_OFFSET) * (_p) + (_x)) >> 2)
 
 #define RTL8365MB_MIB_CTRL0_REG			0x1005
-#define   RTL8365MB_MIB_CTRL0_RESET_MASK	0x0002
-#define   RTL8365MB_MIB_CTRL0_BUSY_MASK		0x0001
+#define   RTL8365MB_MIB_CTRL0_RESET_MASK	BIT(1)
+#define   RTL8365MB_MIB_CTRL0_BUSY_MASK		BIT(0)
 
 /* The DSA callback .get_stats64 runs in atomic context, so we are not allowed
  * to block. On the other hand, accessing MIB counters absolutely requires us to
diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
index 64dd8d90a5ee..8d49ffadce92 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
@@ -106,8 +106,8 @@
 #define RTL8365MB_VLAN_PVID_CTRL_BASE			0x0700
 #define RTL8365MB_VLAN_PVID_CTRL_REG(_p) \
 		(RTL8365MB_VLAN_PVID_CTRL_BASE + ((_p) >> 1))
-#define   RTL8365MB_VLAN_PVID_CTRL_PORT0_MCIDX_MASK	0x001F
-#define   RTL8365MB_VLAN_PVID_CTRL_PORT1_MCIDX_MASK	0x1F00
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT0_MCIDX_MASK	GENMASK(4, 0)
+#define   RTL8365MB_VLAN_PVID_CTRL_PORT1_MCIDX_MASK	GENMASK(12, 8)
 #define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(_p) \
 		(((_p) & 1) << 3)
 #define   RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(_p) \

---
base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
change-id: 20261002-realtek_bit-b9e95f6a3dec

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>

