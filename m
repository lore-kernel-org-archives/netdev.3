Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462791;
	b=mlhD7lPqvZmBAEOmDVL8O4YnHI/GzJSRxr8KGA/Tg3MJdhm6YNN0Bw4U5P2BR13gWHT/
	 rGVqEzxmQpPEcIJCW0XRWLph5uxBIM1I9oKTztvYS2YtX1S34QNw1pLP3tlEbiqx0I4fu
	 BclaNuU0J+y72Z+wa7JrYxKGFNpkkeuEUZnVlx4ckSXU1JuyprbyCR4okQZ8iEhkk+pTC
	 T+6/uBh87oEjcuAZOxDYCnIlhssoBFg44zp7yo88HucYKOIwPA0bl1rTGQXJ8ZI9hyTDV
	 z05b5nS7cXZhLG75PzfWPjulBYQJJT+0GRV7WfapftWYD2cq0YlhSYrPTBgRl5h2ioQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462791;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jHxkt+VW/Yg4M8TbLbSH15LAabPADEeBsRwkOoxm+pE=;
	b=P+6cOpMl0k1WsMY03+keEsZ8UMemSTcW5ENOsYKQc05dz/n1QjffR4iatbVmmDkYrlwc
	 DUXcIRRcNnn+zJCAPwM0ivqZoK0FFyt/EnkiRzzcYyTa+ofLR+TkFAbkoam2LmXpdKoUk
	 2TkgiwS0w10zH1eFLiZWcFcu0ec+b93lDzrrWrxSolJ1pg3Xwg4S3XN8AACbfX49iNEoa
	 4Pxu6vUqyo8YGe91JqS2eVRLS4/4HsMmni4Nztio9wIMlNvw3FijzvbeZw3rckPd8xakt
	 1t1tJJ9kXrWb+fvx6e0BAuFQojRBEvBaaw5EgSoN5h5n9LP4yaL5O3My38Njv3f3Cng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.5
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A563606A31B;
	Tue, 20 Oct 2026 02:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A563606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00962646-0.150831-0.839543;FP=9287370941133376690|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jlJBm82_1792462779;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlJBm82_1792462779 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 10:19:39 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com
Subject: [PATCH net-next v27 3/3] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Date: Tue, 20 Oct 2026 10:19:29 +0800
Message-Id: <20261020021929.3028490-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
References: <20261020021929.3028490-1-kyle.switch@motor-comm.com>
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

Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
motorcomm driver, using the phy_package helpers for the shared top
extended register space.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/phy/Kconfig     |    4 +-
 drivers/net/phy/motorcomm.c | 1926 ++++++++++++++++++++++++++++++++++-
 2 files changed, 1927 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 30e9d22c8d1a..04593a770e43 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -361,10 +361,12 @@ config MICROSEMI_PHY
 
 config MOTORCOMM_PHY
 	tristate "Motorcomm PHYs"
+	select PHY_PACKAGE
 	help
 	  Enables support for Motorcomm network PHYs.
 	  Currently supports YT85xx Gigabit Ethernet PHYs, YT861x PHYs
-	  integrated in YT921x switches, and YT8821 2.5Gbps PHYs.
+	  integrated in YT921x switches, YT8821 2.5Gbps PHYs and YT8824 4 * 2.5G
+	  PHYs.
 
 config NATIONAL_PHY
 	tristate "National Semiconductor PHYs"
diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 463e1ea3efc9..6628ebcca081 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,19 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8522/8531/8531S/861x/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/861x/8821/8824 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
+ * Author: Kyle <kyle.switch@motor-comm.com>
  */
 
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
+#include <linux/mdio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/property.h>
 
+#include "phylib.h"
+
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
 #define PHY_ID_YT8522		0x4f51e928
@@ -22,6 +28,7 @@
 /* Live captured from YT921x switch internal MDIO bus */
 #define PHY_ID_INT861X		0x01e04281
 #define PHY_ID_YT8821		0x4f51ea19
+#define PHY_ID_YT8824		0x4f51e8b8
 /* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
@@ -33,6 +40,18 @@
  *  ------------------------------------------------------------
  */
 
+/* YT8824 Register Overview
+ * UTP Register space	| SERDES Register space
+ *  ------------------------------------------------------------
+ * | UTP MII		| SERDES MII		|
+ * | UTP MMD		|			|
+ * | UTP Extended	| SERDES Extended	|
+ * | UTP Top Extended	| SERDES Top Extended	|
+ *  ------------------------------------------------------------
+ * |   Common Top Extended			|
+ *  ------------------------------------------------------------
+ */
+
 /* 0x10 ~ 0x15 , 0x1E and 0x1F are common MII registers of yt phy */
 
 /* Specific Function Control Register */
@@ -397,6 +416,226 @@
 #define YT8821_CHIP_MODE_AUTO_BX2500_SGMII	0
 #define YT8821_CHIP_MODE_FORCE_BX2500		1
 
+#define YT8824_RSSR_SPACE_MASK			BIT(0)
+#define YT8824_RSSR_SERDES_SPACE		(0x1)
+#define YT8824_RSSR_UTP_SPACE			(0x0)
+#define YT8824_SDS_CFG_MIN_PRE_MASK		GENMASK(3, 0)
+#define YT8824_SDS_EN_FILL_PRE			BIT(13)
+#define YT8824_SDS_TX_PRE_PADDING		(0x7)
+
+/* PHY8824 UTP init registers */
+#define YT8824_WRITE_PROTECT_CAL_REG		0x1
+#define YT8824_WRITE_PROTECT			BIT(0)
+#define YT8824_PLL_VCO_ATEMP_REG		0xa20e
+#define YT8824_PLL_VCO_SEL_CURRENT		GENMASK(7, 4)
+#define YT8824_PLL_VCO_SEL_CURRENT_B		0xb
+#define YT8824_PLL_PFD_CTRL_REG			0xa20a
+#define YT8824_PLL_VCO_ICOSTANT			GENMASK(9, 4)
+#define YT8824_PLL_VCO_ATEMP_1_REG		0xa20c
+#define YT8824_PLL_VCO_IPTAT			GENMASK(5, 0)
+#define YT8824_PLL_DAC_0_REG			0xa2b6
+#define YT8824_PLL_DAC_RST			BIT(10)
+#define YT8824_IF_CTRL_REG			0xa003
+#define YT8824_U0_U1_ENABLE_ODD_PREAMBLE	GENMASK(1, 0)
+#define YT8824_IDLE_CTRL_REG			0x3d0
+#define YT8824_IDLE_DETECT			BIT(9)
+#define YT8824_TRACE_GAIN_THR_REG		0x372
+#define YT8824_TRACE_LNG_GAIN_THR_2500		GENMASK(14, 8)
+#define YT8824_TRACE_MED_GAIN_THR_2500		GENMASK(6, 0)
+#define YT8824_PRM_LONG_REG			0x37C
+#define YT8824_PRM_LARGE_SLAVE_2500		GENMASK(10, 0)
+#define YT8824_PRM_SMALL_REG			0x388
+#define YT8824_PRM_SMALL_LNG_2500		GENMASK(10, 0)
+#define YT8824_FAST_RETRAIN_REG			0x359
+#define YT8824_LINK_FAIL_SIG			GENMASK(13, 8)
+#define YT8824_EN_GATE_CTRL_REG			0xc
+#define YT8824_EN_GATE_GMII_CLK			BIT(0)
+#define YT8824_DAC_CFG_REG			0xa2fa
+#define YT8824_POWER_SAVE			GENMASK(15, 0)
+#define YT8824_DAC_BIAS_CFG_REG			0x4e2
+#define YT8824_DAC_BIAS_CFG_2500		GENMASK(9, 5)
+#define YT8824_DAC_IMID_CFG_REG			0x47e
+#define YT8824_DAC_IMID_CH2			GENMASK(6, 0)
+#define YT8824_DAC_IMID_CH3			GENMASK(14, 8)
+#define YT8824_DAC_IMID_CFG1_REG		0x47f
+#define YT8824_DAC_IMID_CH0			GENMASK(6, 0)
+#define YT8824_DAC_IMID_CH1			GENMASK(14, 8)
+#define YT8824_DAC_IMSB_CFG_REG			0x480
+#define YT8824_DAC_IMSB_CH2			GENMASK(6, 0)
+#define YT8824_DAC_IMSB_CH3			GENMASK(14, 8)
+#define YT8824_DAC_IMSB_CFG1_REG		0x481
+#define YT8824_DAC_IMSB_CH0			GENMASK(6, 0)
+#define YT8824_DAC_IMSB_CH1			GENMASK(14, 8)
+#define YT8824_TRACE_LNG_GAIN_REG		0x336
+#define YT8824_TRACE_LNG_GAIN_THR		GENMASK(14, 8)
+#define YT8824_TRACE_MED_GAIN_REG		0x340
+#define YT8824_TRACE_MED_GAIN_THR		GENMASK(6, 0)
+#define YT8824_DAC_IMID_CH2_CH3_CFG_ORG_REG	0x46e
+#define YT8824_DAC_IMID_CH3_ORG			GENMASK(14, 8)
+#define YT8824_DAC_IMID_CH2_ORG			GENMASK(6, 0)
+#define YT8824_DAC_IMID_CH0_CH1_CFG_ORG_REG	0x46f
+#define YT8824_DAC_IMID_CH1_ORG			GENMASK(14, 8)
+#define YT8824_DAC_IMID_CH0_ORG			GENMASK(6, 0)
+#define YT8824_DAC_IMSB_CH2_CH3_CFG_ORG_REG	0x470
+#define YT8824_DAC_IMSB_CH3_ORG			GENMASK(14, 8)
+#define YT8824_DAC_IMSB_CH2_ORG			GENMASK(6, 0)
+#define YT8824_DAC_IMSB_CH0_CH1_CFG_ORG_REG	0x471
+#define YT8824_DAC_IMSB_CH1_ORG			GENMASK(14, 8)
+#define YT8824_DAC_IMSB_CH0_ORG			GENMASK(6, 0)
+#define YT8824_TRACE_LNG_GAIN_100_REG		0x030b
+#define YT8824_TRACE_LNG_GAIN_THR_100		GENMASK(14, 8)
+#define YT8824_TRACE_MED_GAIN_THR_100		GENMASK(6, 0)
+#define YT8824_CABLE_VSHT_REG			0x071f
+#define YT8824_CABLE_VSHT_THR_S			GENMASK(6, 0)
+#define YT8824_DAC_LPFIL_CH2_CH3_ADJ_REG	0x046b
+#define YT8824_DAC_LPFIL_ADJ_CH3_10		GENMASK(12, 8)
+#define YT8824_DAC_LPFIL_ADJ_CH2_10		GENMASK(4, 0)
+#define YT8824_DAC_LPFIL_CH0_CH1_ADJ_REG	0x046c
+#define YT8824_DAC_LPFIL_ADJ_CH1_10		GENMASK(12, 8)
+#define YT8824_DAC_LPFIL_ADJ_CH0_10		GENMASK(4, 0)
+#define YT8824_DAC_IMID_CFG_CH2_CH3_10_ORG	0x0466
+#define YT8824_DAC_IMID_CFG_CH3_10_ORG		GENMASK(14, 8)
+#define YT8824_DAC_IMID_CFG_CH2_10_ORG		GENMASK(6, 0)
+#define YT8824_DAC_IMID_CFG_CH0_CH1_10_ORG	0x0467
+#define YT8824_DAC_IMID_CFG_CH1_10_ORG		GENMASK(14, 8)
+#define YT8824_DAC_IMID_CFG_CH0_10_ORG		GENMASK(6, 0)
+#define YT8824_DAC_IMSB_CFG_CH2_CH3_10_ORG	0x0468
+#define YT8824_DAC_IMSB_CFG_CH3_10_ORG		GENMASK(14, 8)
+#define YT8824_DAC_IMSB_CFG_CH2_10_ORG		GENMASK(6, 0)
+#define YT8824_DAC_IMSB_CFG_CH0_CH1_10_ORG	0x0469
+#define YT8824_DAC_IMSB_CFG_CH1_10_ORG		GENMASK(14, 8)
+#define YT8824_DAC_IMSB_CFG_CH0_10_ORG		GENMASK(6, 0)
+#define YT8824_FFE_REG				0x034a
+#define YT8824_WAIT_TO_1000			GENMASK(15, 8)
+#define YT8824_FFE_SUM_THRES			GENMASK(2, 0)
+#define YT8824_EN_GATE_REG			0x00f8
+#define YT8824_EN_GATE_PHYDBG			BIT(10)
+#define YT8824_EN_GATE_BT1000			BIT(9)
+#define YT8824_CNT_REG				0x0059
+#define YT8824_CNT_ERR_AUTO			BIT(14)
+#define YT8824_PRM_LARGE_MASTER_REG		0x032c
+#define YT8824_PRM_LARGE_MASTER_1000		GENMASK(10, 0)
+#define YT8824_PRM_LARGE_SLAVE_REG		0x032d
+#define YT8824_PRM_LARGE_SLAVE_1000		GENMASK(10, 0)
+#define YT8824_SIG_GONE_REG			0x032e
+#define YT8824_SIG_GONE_THR_1000		GENMASK(7, 0)
+#define YT8824_EC_NX_TRAIN_COARSE_REG		0x0322
+#define YT8824_EC_NX_TRAIN_COARSE_TO_1000	GENMASK(7, 0)
+#define YT8824_VGA_IN_LPF2_CAP_REG		0x04d3
+#define YT8824_VGA_IN_LPF2_CAP_OTHER		GENMASK(7, 4)
+#define YT8824_VGA_IN_LPF1_CAP_REG		0x04d2
+#define YT8824_VGA_IN_LPF1_CAP_OTHER		GENMASK(7, 4)
+#define YT8824_LDPC_LFER_FAIL_REG		0x00c8
+#define YT8824_LDPC_FAIL_THR			GENMASK(15, 8)
+#define YT8824_LFER_FAIL_THR			GENMASK(7, 0)
+#define YT8824_FR_REQ_REG			0x00be
+#define YT8824_FR_REQ_THR			GENMASK(4, 0)
+#define YT8824_GN_MU_COARSE_REG			0x037a
+#define YT8824_PRM_SMALL_SHT_2500		GENMASK(10, 0)
+#define YT8824_DAC_AMP_ADJ_REG			0x0482
+#define YT8824_DAC_AMP_ADJ_CH3_PBO0_2500	GENMASK(15, 12)
+#define YT8824_DAC_AMP_ADJ_CH2_PBO0_2500	GENMASK(11, 8)
+#define YT8824_DAC_AMP_ADJ_CH1_PBO0_2500	GENMASK(7, 4)
+#define YT8824_DAC_AMP_ADJ_CH0_PBO0_2500	GENMASK(3, 0)
+#define YT8824_P0_DAC_BIAS_CAS_CH3_CH2_REG	0xa2d5
+#define YT8824_P0_DAC_BIAS_CAS_CFG_CH3		GENMASK(12, 8)
+#define YT8824_P0_DAC_BIAS_CAS_CFG_CH2		GENMASK(4, 0)
+#define YT8824_P0_DAC_BIAS_CAS_CH1_CH0_REG	0xa2d6
+#define YT8824_P0_DAC_BIAS_CAS_CFG_CH1		GENMASK(12, 8)
+#define YT8824_P0_DAC_BIAS_CAS_CFG_CH0		GENMASK(4, 0)
+#define YT8824_P1_DAC_BIAS_CAS_CH3_CH2_REG	0xa2d7
+#define YT8824_P1_DAC_BIAS_CAS_CFG_CH3		GENMASK(12, 8)
+#define YT8824_P1_DAC_BIAS_CAS_CFG_CH2		GENMASK(4, 0)
+#define YT8824_P1_DAC_BIAS_CAS_CH1_CH0_REG	0xa2d8
+#define YT8824_P1_DAC_BIAS_CAS_CFG_CH1		GENMASK(12, 8)
+#define YT8824_P1_DAC_BIAS_CAS_CFG_CH0		GENMASK(4, 0)
+#define YT8824_P01_PLL_EN_REG			0xa218
+#define YT8824_CSR_EFUSE_BYPASS_ANALOG_SECOND_RESET	BIT(6)
+#define YT8824_CSR_EFUSE_BYPASS_PLL_TXRX_RESET		BIT(5)
+#define YT8824_U0_CSR_RESET_REG			0xa01d
+#define YT8824_U0_CSR_RESETB_TX_CH0		BIT(3)
+#define YT8824_U0_CSR_RESETB_TX_CH1		BIT(2)
+#define YT8824_U0_CSR_RESETB_TX_CH2		BIT(1)
+#define YT8824_U0_CSR_RESETB_TX_CH3		BIT(0)
+#define YT8824_U1_CSR_RESET_REG			0xa01e
+#define YT8824_U1_CSR_RESETB_TX_CH0		BIT(3)
+#define YT8824_U1_CSR_RESETB_TX_CH1		BIT(2)
+#define YT8824_U1_CSR_RESETB_TX_CH2		BIT(1)
+#define YT8824_U1_CSR_RESETB_TX_CH3		BIT(0)
+/* External PHY8824 serdes init registers */
+#define YT8824_SERDES_PLL_CTRL1_REG		0xa13e
+#define YT8824_SERDES_PLL_CTRL2_REG		0xa13f
+#define YT8824_SERDES_PLL_CTRL3_REG		0xa140
+#define YT8824_WRITE_PROTECT_REG		0x4be
+#define YT8824_SERDES_REG_WR_PRT		BIT(2)
+#define YT8824_CSR_CTRL_REG			0x49f
+#define YT8824_CSR_PCS_GLB_RST_BYPASS		BIT(10)
+#define YT8824_CSR_SG_MODE_RST_BYPASS		BIT(9)
+#define YT8824_CSR_US_GLB_RESET_N		BIT(7)
+#define YT8824_CSR_PCS_BEF_TRAINING_DONE_RST_BYPASS	BIT(2)
+#define YT8824_CSR_PMA_CTRL_REG			0x4a9
+#define YT8824_CSR_WATCH_DOG_ALL_BYPASS		BIT(7)
+#define YT8824_CDR_CTRL_REG			0x406
+#define YT8824_CDR_MODE				BIT(11)
+#define YT8824_CSR_PLL_VCO_CTRL_REG		0x438
+#define YT8824_CSR_PLL_VCO_SEL_VCO2_CURRENT	GENMASK(15, 12)
+#define YT8824_CSR_PLL_VCO_ATEMP_R		GENMASK(2, 0)
+#define YT8824_CSR_PLL_DIVLDO_CTRL_REG		0x439
+#define YT8824_CSR_PLL_VCO_SEL_VCO2_RM_R	GENMASK(1, 0)
+#define YT8824_CSR_PLL_FBDIV_REG		0x043a
+#define YT8824_CSR_PLL_FBDIV_SYNC_SELB		BIT(1)
+#define YT8824_CSR_PLL_SPARE_CTRL_REG		0x042a
+#define YT8824_CSR_PLL_SPARE			GENMASK(15, 0)
+#define YT8824_CDR_MANUAL_REG			0x0491
+#define YT8824_VDAC_AMP_THR_LNG			GENMASK(6, 0)
+#define YT8824_TRAINING_CTRL_REG		0x0492
+#define YT8824_VDAC_AMP_THR_MED			GENMASK(14, 8)
+#define YT8824_VDAC_AMP_THR_SHT			GENMASK(7, 0)
+#define YT8824_EOM_CTRL_REG			0x0454
+#define YT8824_EOD_DURATION_SEL			GENMASK(11, 8)
+#define YT8824_EOD_VTH				GENMASK(6, 0)
+#define YT8824_PGA_GAIN_CTRL_REG		0x0497
+#define YT8824_CDR_OFFSET_ERR_WTH		GENMASK(14, 8)
+#define YT8824_PGA_GAIN_MAX			GENMASK(6, 4)
+#define YT8824_PGA_GAIN_INIT			GENMASK(2, 0)
+#define YT8824_EOD_CTRL_REG			0x04cd
+#define YT8824_EOD_ERR_CNT_THR			GENMASK(15, 0)
+#define YT8824_CSR_AFE_CTRL_REG			0x04af
+#define YT8824_CSR_AFE_VCM_CFG			GENMASK(10, 8)
+#define YT8824_CSR_AFE_MANUAL_CTRL_1P25G	BIT(4)
+#define YT8824_CSR_AFE_MANUAL_CTRL_3P125G	BIT(3)
+#define YT8824_CSR_AFE_MANUAL_CTRL_10P3125G	BIT(2)
+#define YT8824_DFE_CTRL_REG			0x048a
+#define YT8824_DFE_TAP_POLARITY			BIT(12)
+#define YT8824_DFE_IDAC_TUNE			GENMASK(11, 10)
+#define YT8824_CSR_CDR_CTRL_REG			0x0408
+#define YT8824_CSR_CDR_OFFSET_DATA		GENMASK(14, 8)
+#define YT8824_DFE_VDAC_CODE_REG		0x04d6
+#define YT8824_DFE_VDAC_CODE_THR			GENMASK(6, 0)
+#define YT8824_RX_SPARE_CTRL_REG		0x044f
+#define YT8824_RX_SPARE_REG			GENMASK(15, 0)
+#define YT8824_DFE_VDAC_CTRL_REG		0x048e
+#define YT8824_DFE_VDAC_TUNE			GENMASK(11, 10)
+#define YT8824_DFE_VDAC_SEL			GENMASK(9, 8)
+#define YT8824_CSR_TX_PRE_REG			0x000d
+#define YT8824_CSR_TX_PRE_SEL			GENMASK(4, 0)
+#define YT8824_CSR_AFE_CTRL1_REG		0x04b0
+#define YT8824_CSR_AFE_CTLE_BW			GENMASK(6, 4)
+#define YT8824_CSR_AFE_CTRL2_REG		0x04b1
+#define YT8824_CSR_AFE_PGA_BW			GENMASK(14, 12)
+#define YT8824_CSR_AFE_BUF_BW			GENMASK(6, 4)
+#define YT8824_CSR_DCC_CAL_CTRL_REG		0x0003
+#define YT8824_CUR_TX_SEQ			GENMASK(15, 12)
+#define YT8824_CUR_RX_SEQ			GENMASK(11, 8)
+#define YT8824_CALIB_SEQ_FINISH			BIT(1)
+#define YT8824_CALIB_SEQ_SW_RST			BIT(0)
+#define YT8824_RESTART_CAL_CTRL_REG		0x2000
+#define YT8824_DAC_TRIM_MAIN_CFG_REG		0x429
+#define YT8824_PLL_VCO_CFG_REG			0x441
+#define YT8824_TX_MUX_CH3_CH2_REG		0x42b
+#define YT8824_C1_COARSE_CFG_REG		0x4b4
+#define YT8824_FFE_CTRL_REG			0x4b5
+
 struct yt8521_priv {
 	/* combo_advertising is used for case of YT8521 in combo mode,
 	 * this means that yt8521 may work in utp or fiber mode which depends
@@ -415,6 +654,14 @@ struct yt8521_priv {
 	u8 reg_page;
 };
 
+struct yt8824_shared_priv {
+	phy_interface_t package_mode;
+	/* shared_lock used to UTPs operation isolation during swap reg space */
+	struct mutex shared_lock;
+	/* true once the package-wide SERDES init has been done */
+	bool sds_initialized;
+};
+
 /**
  * ytphy_read_ext() - read a PHY's extended register
  * @phydev: a pointer to a &struct phy_device
@@ -453,6 +700,70 @@ static int ytphy_read_ext_with_lock(struct phy_device *phydev, u16 regnum)
 	return ret;
 }
 
+/**
+ * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @regnum: register number to read
+ *
+ * Returns: the value of regnum reg or negative error code
+ */
+static int ytphy_read_top_ext(struct phy_device *phydev, u16 regnum)
+{
+	int ret;
+
+	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
+	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return __phy_package_read(phydev, 0, YTPHY_PAGE_DATA);
+}
+
+/**
+ * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @regnum: register number to write
+ * @val: register val to write
+ *
+ * Returns: 0 or negative error code
+ */
+static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
+			       u16 val)
+{
+	int ret;
+
+	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
+	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
+	if (ret < 0)
+		return ret;
+
+	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);
+}
+
+/**
+ * phy8824_page_write_with_lock() - write page for YT8824
+ * @phydev: a pointer to a &struct phy_device
+ * @page: reg page(YT8824_RSSR_SERDES_SPACE/YT8824_RSSR_UTP_SPACE).
+ *
+ * Returns: 0 or negative error code
+ */
+static int phy8824_page_write_with_lock(struct phy_device *phydev, int page)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (ret < 0)
+		goto err;
+	ret &= ~YT8824_RSSR_SPACE_MASK;
+	ret |= (page & YT8824_RSSR_SPACE_MASK);
+	ret = ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, ret);
+
+err:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 /**
  * ytphy_write_ext() - write a PHY's extended register
  * @phydev: a pointer to a &struct phy_device
@@ -649,6 +960,1156 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 	return phy_restore_page(phydev, old_page, ret);
 }
 
+/**
+ * yt8824_read_page() - read PHY8824 reg page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: current reg space of yt8824 (YT8824_RSSR_SERDES_SPACE/
+ * YT8824_RSSR_UTP_SPACE) or negative errno code
+ */
+static int yt8824_read_page(struct phy_device *phydev)
+{
+	int old_page;
+
+	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+
+	return old_page & YT8824_RSSR_SPACE_MASK;
+};
+
+/**
+ * yt8824_write_page() - write reg page
+ * @phydev: a pointer to a &struct phy_device
+ * @page: Reg page(YT8824_RSSR_SERDES_SPACE/YT8824_RSSR_UTP_SPACE) to write.
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_write_page(struct phy_device *phydev, int page)
+{
+	int old_page;
+	u16 data;
+
+	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
+	if (old_page < 0)
+		return old_page;
+	data = old_page & (~YT8824_RSSR_SPACE_MASK);
+	data |= page;
+
+	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);
+};
+
+/**
+ * yt8824_utp_set_template_test_mode() - config YT8824 UTP test mode.
+ * @phydev: a pointer to a &struct phy_device
+ * @test_mode: template test mode from normal, testmode1 to testmode7
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_set_template_test_mode(struct phy_device *phydev,
+					     u16 test_mode)
+{
+	int ret;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return genphy_c45_template_testmode(phydev, test_mode);
+}
+
+/**
+ * yt8824_sds_isolate_paged() - enable YT8824 serdes isolate.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_sds_isolate_paged(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int ret = 0;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_SERDES_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* enable sds isolate */
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_ISOLATE, BMCR_ISOLATE);
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_utp_softreset_paged() - config YT8824 UTP softreset.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_softreset_paged(struct phy_device *phydev)
+{
+	int ret = 0;
+	int val;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
+	if (ret < 0)
+		return ret;
+	/* wait until softreset done. */
+	return phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				     50000, 600000, true);
+}
+
+/**
+ * yt8824_sds_isolate_and_softreset_paged() - disable YT8824 serdes isolate
+ * and sds softreset.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_sds_isolate_and_softreset_paged(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int val = 0;
+	int ret = -1;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_SERDES_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* sds softreset and disable isolate */
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ISOLATE,
+			   BMCR_RESET & ~BMCR_ISOLATE);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* poll while still holding the lock */
+	ret = read_poll_timeout(__phy_read, val,
+				(val < 0) || !(val & BMCR_RESET), 50000, 600000,
+				true, phydev, MII_BMCR);
+	if (val < 0)
+		ret = val;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_restore_working_status() - called to do store working status
+ * @phydev: a pointer to a &struct phy_device
+ * @ret: operation's return code
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_restore_working_status(struct phy_device *phydev, int ret)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int r;
+
+	r = yt8824_utp_set_template_test_mode(phydev,
+					      MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	if (priv->package_mode != PHY_INTERFACE_MODE_INTERNAL) {
+		r = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret >= 0 && r < 0)
+			ret = r;
+	}
+
+	return ret;
+}
+
+/**
+ * yt8824_soft_reset() - called to do PHY software reset
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_soft_reset(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_1);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_NORMAL);
+		if (ret < 0)
+			goto retry;
+	} else {
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_1);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_sds_isolate_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_NORMAL);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	}
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+retry:
+	ret = yt8824_restore_working_status(phydev, ret);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_config_utp_init_paged() - config external phy8824 utp init
+ * @phydev: target phy_device struct
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_config_utp_init_paged(struct phy_device *phydev)
+{
+	int ctrl = 0;
+	int mask = 0;
+	int ret = 0;
+	int val = 0;
+	int r;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+	if (ret < 0)
+		goto err_restore;
+
+	/* write protecting */
+	mask = YT8824_WRITE_PROTECT;
+	ctrl = YT8824_WRITE_PROTECT;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_WRITE_PROTECT_CAL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* PLL calibration */
+	ctrl = FIELD_PREP(YT8824_PLL_VCO_SEL_CURRENT, 0xb);
+	mask = YT8824_PLL_VCO_SEL_CURRENT;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PLL_VCO_ATEMP_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PLL_VCO_ICOSTANT, 0xf);
+	mask = YT8824_PLL_VCO_ICOSTANT;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PLL_PFD_CTRL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PLL_VCO_IPTAT, 0xf);
+	mask = YT8824_PLL_VCO_IPTAT;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PLL_VCO_ATEMP_1_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PLL_DAC_RST, 0);
+	mask = YT8824_PLL_DAC_RST;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PLL_DAC_0_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PLL_DAC_RST, 1);
+	mask = YT8824_PLL_DAC_RST;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PLL_DAC_0_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* enable nibble */
+	ctrl = FIELD_PREP(YT8824_U0_U1_ENABLE_ODD_PREAMBLE, 3);
+	mask = YT8824_U0_U1_ENABLE_ODD_PREAMBLE;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_IF_CTRL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* idle err detect enable */
+	ctrl = YT8824_IDLE_DETECT;
+	mask = YT8824_IDLE_DETECT;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_IDLE_CTRL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 2.5G long cable performance */
+	ctrl = FIELD_PREP(YT8824_TRACE_LNG_GAIN_THR_2500, 0x50);
+	ctrl |= FIELD_PREP(YT8824_TRACE_MED_GAIN_THR_2500, 0x38);
+	mask = YT8824_TRACE_LNG_GAIN_THR_2500 |
+	       YT8824_TRACE_MED_GAIN_THR_2500;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_TRACE_GAIN_THR_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PRM_LARGE_SLAVE_2500, 0x68);
+	mask = YT8824_PRM_LARGE_SLAVE_2500;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PRM_LONG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PRM_SMALL_LNG_2500, 0xa0);
+	mask = YT8824_PRM_SMALL_LNG_2500;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_PRM_SMALL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized fast retrain */
+	ctrl = FIELD_PREP(YT8824_LINK_FAIL_SIG, 0x21);
+	mask = YT8824_LINK_FAIL_SIG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_FAST_RETRAIN_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_EN_GATE_GMII_CLK, 0);
+	mask = YT8824_EN_GATE_GMII_CLK;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_EN_GATE_CTRL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* 2.5G template tone */
+	ctrl = FIELD_PREP(YT8824_POWER_SAVE, 0x83);
+	mask = YT8824_POWER_SAVE;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_CFG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_BIAS_CFG_2500, 0xa);
+	mask = YT8824_DAC_BIAS_CFG_2500;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_BIAS_CFG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 2.5G template */
+	ctrl = FIELD_PREP(YT8824_DAC_IMID_CH2, 0x39);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CH3, 0x39);
+	mask = YT8824_DAC_IMID_CH2 | YT8824_DAC_IMID_CH3;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMID_CFG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMID_CH0, 0x39);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CH1, 0x39);
+	mask = YT8824_DAC_IMID_CH0 | YT8824_DAC_IMID_CH1;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMID_CFG1_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMSB_CH2, 0x39);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMSB_CH3, 0x39);
+	mask = YT8824_DAC_IMSB_CH2 | YT8824_DAC_IMSB_CH3;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMSB_CFG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMSB_CH0, 0x39);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMSB_CH1, 0x39);
+	mask = YT8824_DAC_IMSB_CH0 | YT8824_DAC_IMSB_CH1;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMSB_CFG1_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 1000M cable length threshold */
+	ctrl = FIELD_PREP(YT8824_TRACE_LNG_GAIN_THR, 0x2b);
+	mask = YT8824_TRACE_LNG_GAIN_THR;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_TRACE_LNG_GAIN_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_TRACE_MED_GAIN_THR, 0x1d);
+	mask = YT8824_TRACE_MED_GAIN_THR;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_TRACE_MED_GAIN_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* 100M template amplitude */
+	ctrl = FIELD_PREP(YT8824_DAC_IMID_CH3_ORG, 0x45);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CH2_ORG, 0x45);
+	mask = YT8824_DAC_IMID_CH3_ORG | YT8824_DAC_IMID_CH2_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMID_CH2_CH3_CFG_ORG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMID_CH1_ORG, 0x45);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CH0_ORG, 0x45);
+	mask = YT8824_DAC_IMID_CH1_ORG | YT8824_DAC_IMID_CH0_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMID_CH0_CH1_CFG_ORG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMSB_CH3_ORG, 0x45);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMSB_CH2_ORG, 0x45);
+	mask = YT8824_DAC_IMSB_CH2_ORG | YT8824_DAC_IMSB_CH3_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMSB_CH2_CH3_CFG_ORG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMSB_CH1_ORG, 0x45);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMSB_CH0_ORG, 0x45);
+	mask = YT8824_DAC_IMSB_CH1_ORG | YT8824_DAC_IMSB_CH0_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMSB_CH0_CH1_CFG_ORG_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 100M cable length threshold */
+	ctrl = FIELD_PREP(YT8824_TRACE_LNG_GAIN_THR_100, 0x2A);
+	ctrl |= FIELD_PREP(YT8824_TRACE_MED_GAIN_THR_100, 0x1D);
+	mask = YT8824_TRACE_LNG_GAIN_THR_100 | YT8824_TRACE_MED_GAIN_THR_100;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_TRACE_LNG_GAIN_100_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_CABLE_VSHT_THR_S, 0x36);
+	mask = YT8824_CABLE_VSHT_THR_S;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_CABLE_VSHT_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* 10M template amplitude */
+	ctrl = FIELD_PREP(YT8824_DAC_LPFIL_ADJ_CH3_10, 0x18);
+	ctrl |= FIELD_PREP(YT8824_DAC_LPFIL_ADJ_CH2_10, 0x18);
+	mask = YT8824_DAC_LPFIL_ADJ_CH3_10 | YT8824_DAC_LPFIL_ADJ_CH2_10;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_LPFIL_CH2_CH3_ADJ_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_LPFIL_ADJ_CH1_10, 0x18);
+	ctrl |= FIELD_PREP(YT8824_DAC_LPFIL_ADJ_CH0_10, 0x18);
+	mask = YT8824_DAC_LPFIL_ADJ_CH1_10 | YT8824_DAC_LPFIL_ADJ_CH0_10;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_LPFIL_CH0_CH1_ADJ_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized 10M cable length threshold */
+	ctrl = FIELD_PREP(YT8824_DAC_IMID_CFG_CH3_10_ORG, 0x6C);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CFG_CH2_10_ORG, 0x6C);
+	mask = YT8824_DAC_IMID_CFG_CH3_10_ORG | YT8824_DAC_IMID_CFG_CH2_10_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMID_CFG_CH2_CH3_10_ORG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_DAC_IMID_CFG_CH1_10_ORG, 0x6C);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMID_CFG_CH0_10_ORG, 0x6C);
+	mask = YT8824_DAC_IMID_CFG_CH1_10_ORG | YT8824_DAC_IMID_CFG_CH0_10_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMID_CFG_CH0_CH1_10_ORG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized DAC IMSB config for CH2/CH3 */
+	ctrl = FIELD_PREP(YT8824_DAC_IMSB_CFG_CH3_10_ORG, 0x6C);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMSB_CFG_CH2_10_ORG, 0x6C);
+	mask = YT8824_DAC_IMSB_CFG_CH3_10_ORG | YT8824_DAC_IMSB_CFG_CH2_10_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMSB_CFG_CH2_CH3_10_ORG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized DAC IMSB config for CH0/CH1 */
+	ctrl = FIELD_PREP(YT8824_DAC_IMSB_CFG_CH1_10_ORG, 0x6C);
+	ctrl |= FIELD_PREP(YT8824_DAC_IMSB_CFG_CH0_10_ORG, 0x6C);
+	mask = YT8824_DAC_IMSB_CFG_CH1_10_ORG | YT8824_DAC_IMSB_CFG_CH0_10_ORG;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_IMSB_CFG_CH0_CH1_10_ORG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimize utp 1000M performance */
+	ctrl = FIELD_PREP(YT8824_WAIT_TO_1000, 0xFF);
+	mask = YT8824_WAIT_TO_1000;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_FFE_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_EN_GATE_PHYDBG, 0);
+	ctrl |= FIELD_PREP(YT8824_EN_GATE_BT1000, 0);
+	mask = YT8824_EN_GATE_PHYDBG | YT8824_EN_GATE_BT1000;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_EN_GATE_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_CNT_ERR_AUTO, 1);
+	mask = YT8824_CNT_ERR_AUTO;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_CNT_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PRM_LARGE_MASTER_1000, 0x94);
+	mask = YT8824_PRM_LARGE_MASTER_1000;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_PRM_LARGE_MASTER_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PRM_LARGE_SLAVE_1000, 0x094);
+	mask = YT8824_PRM_LARGE_SLAVE_1000;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_PRM_LARGE_SLAVE_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_SIG_GONE_THR_1000, 0x08);
+	mask = YT8824_SIG_GONE_THR_1000;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_SIG_GONE_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_EC_NX_TRAIN_COARSE_TO_1000, 0x40);
+	mask = YT8824_EC_NX_TRAIN_COARSE_TO_1000;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_EC_NX_TRAIN_COARSE_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_VGA_IN_LPF2_CAP_OTHER, 0x2);
+	mask = YT8824_VGA_IN_LPF2_CAP_OTHER;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_VGA_IN_LPF2_CAP_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_VGA_IN_LPF1_CAP_OTHER, 0x2);
+	mask = YT8824_VGA_IN_LPF1_CAP_OTHER;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_VGA_IN_LPF1_CAP_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized EMC CS */
+	ctrl = FIELD_PREP(YT8824_LDPC_FAIL_THR, 0xFF);
+	ctrl |= FIELD_PREP(YT8824_LFER_FAIL_THR, 0xFF);
+	mask = YT8824_LDPC_FAIL_THR | YT8824_LFER_FAIL_THR;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_LDPC_LFER_FAIL_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_FR_REQ_THR, 0x06);
+	mask = YT8824_FR_REQ_THR;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_FR_REQ_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_PRM_SMALL_SHT_2500, 0x0FF);
+	mask = YT8824_PRM_SMALL_SHT_2500;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_GN_MU_COARSE_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	/* optimized EMC RE */
+	ctrl = FIELD_PREP(YT8824_DAC_AMP_ADJ_CH3_PBO0_2500, 0xF);
+	ctrl |= FIELD_PREP(YT8824_DAC_AMP_ADJ_CH2_PBO0_2500, 0xF);
+	ctrl |= FIELD_PREP(YT8824_DAC_AMP_ADJ_CH1_PBO0_2500, 0xF);
+	ctrl |= FIELD_PREP(YT8824_DAC_AMP_ADJ_CH0_PBO0_2500, 0xF);
+	mask = YT8824_DAC_AMP_ADJ_CH3_PBO0_2500 |
+	       YT8824_DAC_AMP_ADJ_CH2_PBO0_2500 |
+	       YT8824_DAC_AMP_ADJ_CH1_PBO0_2500 |
+	       YT8824_DAC_AMP_ADJ_CH0_PBO0_2500;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_DAC_AMP_ADJ_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_P0_DAC_BIAS_CAS_CFG_CH3, 0x1F);
+	ctrl |= FIELD_PREP(YT8824_P0_DAC_BIAS_CAS_CFG_CH2, 0x1F);
+	mask = YT8824_P0_DAC_BIAS_CAS_CFG_CH3 | YT8824_P0_DAC_BIAS_CAS_CFG_CH2;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_P0_DAC_BIAS_CAS_CH3_CH2_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_P0_DAC_BIAS_CAS_CFG_CH1, 0x1F);
+	ctrl |= FIELD_PREP(YT8824_P0_DAC_BIAS_CAS_CFG_CH0, 0x1F);
+	mask = YT8824_P0_DAC_BIAS_CAS_CFG_CH1 | YT8824_P0_DAC_BIAS_CAS_CFG_CH0;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_P0_DAC_BIAS_CAS_CH1_CH0_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_P1_DAC_BIAS_CAS_CFG_CH3, 0x1F);
+	ctrl |= FIELD_PREP(YT8824_P1_DAC_BIAS_CAS_CFG_CH2, 0x1F);
+	mask = YT8824_P1_DAC_BIAS_CAS_CFG_CH3 | YT8824_P1_DAC_BIAS_CAS_CFG_CH2;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_P1_DAC_BIAS_CAS_CH3_CH2_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_P1_DAC_BIAS_CAS_CFG_CH1, 0x1F);
+	ctrl |= FIELD_PREP(YT8824_P1_DAC_BIAS_CAS_CFG_CH0, 0x1F);
+	mask = YT8824_P1_DAC_BIAS_CAS_CFG_CH1 | YT8824_P1_DAC_BIAS_CAS_CFG_CH0;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_P1_DAC_BIAS_CAS_CH1_CH0_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_CSR_EFUSE_BYPASS_ANALOG_SECOND_RESET, 1);
+	ctrl |= FIELD_PREP(YT8824_CSR_EFUSE_BYPASS_PLL_TXRX_RESET, 1);
+	mask  = YT8824_CSR_EFUSE_BYPASS_ANALOG_SECOND_RESET |
+		YT8824_CSR_EFUSE_BYPASS_PLL_TXRX_RESET;
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8824_P01_PLL_EN_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH0, 0);
+	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH1, 0);
+	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH2, 0);
+	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH3, 0);
+	mask  = YT8824_U0_CSR_RESETB_TX_CH0 | YT8824_U0_CSR_RESETB_TX_CH1 |
+		YT8824_U0_CSR_RESETB_TX_CH2 | YT8824_U0_CSR_RESETB_TX_CH3;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U0_CSR_RESET_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH0, 0);
+	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH1, 0);
+	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH2, 0);
+	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH3, 0);
+	mask = YT8824_U1_CSR_RESETB_TX_CH0 | YT8824_U1_CSR_RESETB_TX_CH1 |
+	       YT8824_U1_CSR_RESETB_TX_CH2 | YT8824_U1_CSR_RESETB_TX_CH3;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U1_CSR_RESET_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH0, 1);
+	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH1, 1);
+	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH2, 1);
+	ctrl |= FIELD_PREP(YT8824_U0_CSR_RESETB_TX_CH3, 1);
+	mask = YT8824_U0_CSR_RESETB_TX_CH0 | YT8824_U0_CSR_RESETB_TX_CH1 |
+	       YT8824_U0_CSR_RESETB_TX_CH2 | YT8824_U0_CSR_RESETB_TX_CH3;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U0_CSR_RESET_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+
+	ctrl = FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH0, 1);
+	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH1, 1);
+	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH2, 1);
+	ctrl |= FIELD_PREP(YT8824_U1_CSR_RESETB_TX_CH3, 1);
+	mask = YT8824_U1_CSR_RESETB_TX_CH0 | YT8824_U1_CSR_RESETB_TX_CH1 |
+	       YT8824_U1_CSR_RESETB_TX_CH2 | YT8824_U1_CSR_RESETB_TX_CH3;
+	ret = ytphy_modify_ext_with_lock(phydev, YT8824_U1_CSR_RESET_REG,
+					 mask, ctrl);
+	if (ret < 0)
+		goto err_restore;
+	/* reset */
+	ret = genphy_c45_template_testmode(phydev, MDIO_PMA_10GBT_TESTMODE_1);
+	if (ret < 0)
+		goto err_restore_normal;
+
+	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE,
+			 BMCR_RESET | BMCR_ANENABLE);
+	if (ret < 0)
+		goto err_restore_normal;
+	ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				    50000, 600000, true);
+	if (ret < 0)
+		goto err_restore_normal;
+
+	ret = genphy_c45_template_testmode(phydev,
+					   MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret < 0)
+		goto err_restore_normal;
+	return 0;
+
+err_restore:
+	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	return ret;
+
+err_restore_normal:
+	r = genphy_c45_template_testmode(phydev,
+					 MDIO_PMA_10GBT_TESTMODE_NORMAL);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	r = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, 0);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	return ret;
+}
+
+/**
+ * yt8824_extern_sds_softreset() - config external phy8824 sds softrest
+ * @phydev: target phy_device struct
+ *
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_extern_sds_softreset(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int ret = -1;
+	int val = 0;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_SERDES_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* TX preamble padded to 8; RX IPG always > 8 */
+	ret = __phy_read(phydev, MII_RESV1);
+	if (ret < 0)
+		goto err_restore_page;
+	ret &= ~YT8824_SDS_CFG_MIN_PRE_MASK;
+	ret |= YT8824_SDS_TX_PRE_PADDING;
+	ret |= YT8824_SDS_EN_FILL_PRE;
+	ret = __phy_write(phydev, MII_RESV1, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = __phy_modify(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE,
+			   BMCR_RESET | BMCR_ANENABLE);
+	if (ret < 0)
+		goto err_restore_page;
+	/* poll while still holding the lock; __phy_read takes no lock */
+	ret = read_poll_timeout(__phy_read, val,
+				(val < 0) || !(val & BMCR_RESET), 50000, 600000,
+				true, phydev, MII_BMCR);
+	if (val < 0)
+		ret = val;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_extern_config_sds_init_paged() - config external phy8824 sds init
+ * @phydev: target phy_device struct
+ *
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_extern_config_sds_init_paged(struct phy_device *phydev)
+{
+	int old_page = YT8824_RSSR_UTP_SPACE;
+	int val_1, val_2, val_3, tmp;
+	int ctrl = 0;
+	int mask = 0;
+	int ret = -1;
+
+	old_page = phy_select_page(phydev, YT8824_RSSR_SERDES_SPACE);
+	if (old_page < 0)
+		goto err_restore_page;
+
+	/* read efuse */
+	ret = ytphy_read_top_ext(phydev, YT8824_SERDES_PLL_CTRL1_REG);
+	if (ret < 0)
+		goto err_restore_page;
+	else
+		val_1 = ret;
+
+	ret = ytphy_read_top_ext(phydev, YT8824_SERDES_PLL_CTRL2_REG);
+	if (ret < 0)
+		goto err_restore_page;
+	else
+		val_2 = ret;
+
+	ret = ytphy_read_top_ext(phydev, YT8824_SERDES_PLL_CTRL3_REG);
+	if (ret < 0)
+		goto err_restore_page;
+	else
+		val_3 = ret;
+
+	/* Serdes optimization */
+	ctrl = FIELD_PREP(YT8824_SERDES_REG_WR_PRT, 1);
+	mask = YT8824_SERDES_REG_WR_PRT;
+	ret = ytphy_modify_ext(phydev, YT8824_WRITE_PROTECT_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_PCS_GLB_RST_BYPASS, 1);
+	ctrl |= FIELD_PREP(YT8824_CSR_SG_MODE_RST_BYPASS, 1);
+	ctrl |= FIELD_PREP(YT8824_CSR_US_GLB_RESET_N, 0);
+	ctrl |= FIELD_PREP(YT8824_CSR_PCS_BEF_TRAINING_DONE_RST_BYPASS, 1);
+	mask = YT8824_CSR_PCS_GLB_RST_BYPASS | YT8824_CSR_SG_MODE_RST_BYPASS |
+	       YT8824_CSR_US_GLB_RESET_N |
+	       YT8824_CSR_PCS_BEF_TRAINING_DONE_RST_BYPASS;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_WATCH_DOG_ALL_BYPASS, 1);
+	mask = YT8824_CSR_WATCH_DOG_ALL_BYPASS;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_PMA_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* analog CDR */
+	ctrl = FIELD_PREP(YT8824_CDR_MODE, 1);
+	mask = YT8824_CDR_MODE;
+	ret = ytphy_modify_ext(phydev, YT8824_CDR_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized VCO */
+	ctrl = FIELD_PREP(YT8824_CSR_PLL_VCO_SEL_VCO2_CURRENT, 0x9);
+	ctrl |= FIELD_PREP(YT8824_CSR_PLL_VCO_ATEMP_R, 0x4);
+	mask = YT8824_CSR_PLL_VCO_SEL_VCO2_CURRENT | YT8824_CSR_PLL_VCO_ATEMP_R;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_PLL_VCO_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_PLL_VCO_SEL_VCO2_RM_R, 0x0);
+	mask = YT8824_CSR_PLL_VCO_SEL_VCO2_RM_R;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_PLL_DIVLDO_CTRL_REG,
+			       mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized PLL lock */
+	ret = ytphy_read_ext(phydev, YT8824_DAC_TRIM_MAIN_CFG_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(13) | BIT(12));
+	tmp = (val_1 & (BIT(7) | BIT(6))) >> 6;
+	ret |= (tmp << 12);
+	ret = ytphy_write_ext(phydev, YT8824_DAC_TRIM_MAIN_CFG_REG, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_read_ext(phydev, YT8824_PLL_VCO_CFG_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(1) | BIT(0));
+	tmp = (val_1 & (BIT(5) | BIT(4))) >> 4;
+	ret |= tmp;
+	ret = ytphy_write_ext(phydev, YT8824_PLL_VCO_CFG_REG, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_read_ext(phydev, YT8824_TX_MUX_CH3_CH2_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(13) | BIT(12));
+	tmp = (val_3 & (BIT(1) | BIT(0)));
+	ret |= (tmp << 12);
+	ret = ytphy_write_ext(phydev, YT8824_TX_MUX_CH3_CH2_REG, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_PLL_FBDIV_SYNC_SELB, 1);
+	mask = YT8824_CSR_PLL_FBDIV_SYNC_SELB;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_PLL_FBDIV_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_PLL_SPARE, 0xf070);
+	mask = YT8824_CSR_PLL_SPARE;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_PLL_SPARE_CTRL_REG,
+			       mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* cable length threshold */
+	ctrl = FIELD_PREP(YT8824_VDAC_AMP_THR_LNG, 0x7F);
+	mask = YT8824_VDAC_AMP_THR_LNG;
+	ret = ytphy_modify_ext(phydev, YT8824_CDR_MANUAL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_VDAC_AMP_THR_MED, 0x7F);
+	ctrl |= FIELD_PREP(YT8824_VDAC_AMP_THR_SHT, 0x7F);
+	mask = YT8824_VDAC_AMP_THR_MED | YT8824_VDAC_AMP_THR_SHT;
+	ret = ytphy_modify_ext(phydev, YT8824_TRAINING_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Serdes training threshold */
+	ctrl = FIELD_PREP(YT8824_EOD_DURATION_SEL, 0xF);
+	ctrl |= FIELD_PREP(YT8824_EOD_VTH, 0x14);
+	mask = YT8824_EOD_DURATION_SEL | YT8824_EOD_VTH;
+	ret = ytphy_modify_ext(phydev, YT8824_EOM_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CDR_OFFSET_ERR_WTH, 0x0A);
+	ctrl |= FIELD_PREP(YT8824_PGA_GAIN_MAX, 0x4);
+	ctrl |= FIELD_PREP(YT8824_PGA_GAIN_INIT, 0x4);
+	mask = YT8824_CDR_OFFSET_ERR_WTH | YT8824_PGA_GAIN_MAX |
+	       YT8824_PGA_GAIN_INIT;
+	ret = ytphy_modify_ext(phydev, YT8824_PGA_GAIN_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* digital eye diagram of SerDes */
+	ctrl = FIELD_PREP(YT8824_EOD_ERR_CNT_THR, 0x0000);
+	mask = YT8824_EOD_ERR_CNT_THR;
+	ret = ytphy_modify_ext(phydev, YT8824_EOD_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Serdes LDO */
+	ret = ytphy_read_ext(phydev, YT8824_FFE_CTRL_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(6) | BIT(5) | BIT(4));
+	tmp = (val_2 & (BIT(4) | BIT(3) | BIT(2))) >> 2;
+	ret |= (tmp << 4);
+	ret = ytphy_write_ext(phydev, YT8824_FFE_CTRL_REG, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_read_ext(phydev, YT8824_C1_COARSE_CFG_REG);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret &= ~(BIT(10) | BIT(9) | BIT(8));
+	tmp = (val_2 & (BIT(7) | BIT(6) | BIT(5))) >> 5;
+	ret |= (tmp << 8);
+	ret = ytphy_write_ext(phydev, YT8824_C1_COARSE_CFG_REG, ret);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized Serdes RX */
+	ctrl = FIELD_PREP(YT8824_CSR_AFE_VCM_CFG, 0x5);
+	ctrl |= FIELD_PREP(YT8824_CSR_AFE_MANUAL_CTRL_1P25G, 0);
+	ctrl |= FIELD_PREP(YT8824_CSR_AFE_MANUAL_CTRL_3P125G, 0);
+	mask = YT8824_CSR_AFE_VCM_CFG | YT8824_CSR_AFE_MANUAL_CTRL_1P25G |
+	       YT8824_CSR_AFE_MANUAL_CTRL_3P125G;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_AFE_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_DFE_TAP_POLARITY, 1);
+	ctrl |= FIELD_PREP(YT8824_DFE_IDAC_TUNE, 0x3);
+	mask = YT8824_DFE_TAP_POLARITY | YT8824_DFE_IDAC_TUNE;
+	ret = ytphy_modify_ext(phydev, YT8824_DFE_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_CDR_OFFSET_DATA, 0x7C);
+	mask = YT8824_CSR_CDR_OFFSET_DATA;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_CDR_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_DFE_VDAC_CODE_THR, 0x7F);
+	mask = YT8824_DFE_VDAC_CODE_THR;
+	ret = ytphy_modify_ext(phydev, YT8824_DFE_VDAC_CODE_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_RX_SPARE_REG, 0xff08);
+	mask = YT8824_RX_SPARE_REG;
+	ret = ytphy_modify_ext(phydev, YT8824_RX_SPARE_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* optimized Serdes TX */
+	ctrl = FIELD_PREP(YT8824_DFE_VDAC_TUNE, 0x1);
+	ctrl |= FIELD_PREP(YT8824_DFE_VDAC_SEL, 0x0);
+	mask = YT8824_DFE_VDAC_TUNE | YT8824_DFE_VDAC_SEL;
+	ret = ytphy_modify_ext(phydev, YT8824_DFE_VDAC_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_TX_PRE_SEL, 0x6);
+	mask = YT8824_CSR_TX_PRE_SEL;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_TX_PRE_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* Serdes manual config */
+	ctrl = FIELD_PREP(YT8824_CSR_AFE_CTLE_BW, 0x0);
+	mask = YT8824_CSR_AFE_CTLE_BW;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_AFE_CTRL1_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_AFE_PGA_BW, 0x7);
+	ctrl |= FIELD_PREP(YT8824_CSR_AFE_BUF_BW, 0x7);
+	mask = YT8824_CSR_AFE_PGA_BW | YT8824_CSR_AFE_BUF_BW;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_AFE_CTRL2_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_CSR_AFE_MANUAL_CTRL_10P3125G, 0x1);
+	mask = YT8824_CSR_AFE_MANUAL_CTRL_10P3125G;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_AFE_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* restart calibration */
+	ctrl = FIELD_PREP(YT8824_CUR_TX_SEQ, 0x5);
+	ctrl |= FIELD_PREP(YT8824_CUR_RX_SEQ, 0x6);
+	ctrl |= FIELD_PREP(YT8824_CALIB_SEQ_FINISH, 1);
+	ctrl |= FIELD_PREP(YT8824_CALIB_SEQ_SW_RST, 1);
+	mask = YT8824_CUR_TX_SEQ | YT8824_CUR_RX_SEQ |
+	       YT8824_CALIB_SEQ_FINISH | YT8824_CALIB_SEQ_SW_RST;
+	ret = ytphy_modify_ext(phydev, YT8824_CSR_DCC_CAL_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_VDAC_AMP_THR_MED, 0x7F);
+	ctrl |= FIELD_PREP(YT8824_VDAC_AMP_THR_SHT, 0xFF);
+	mask = YT8824_VDAC_AMP_THR_MED | YT8824_VDAC_AMP_THR_SHT;
+	ret = ytphy_modify_ext(phydev, YT8824_TRAINING_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ctrl = FIELD_PREP(YT8824_VDAC_AMP_THR_MED, 0x7F);
+	ctrl |= FIELD_PREP(YT8824_VDAC_AMP_THR_SHT, 0x7F);
+	mask = YT8824_VDAC_AMP_THR_MED | YT8824_VDAC_AMP_THR_SHT;
+	ret = ytphy_modify_ext(phydev, YT8824_TRAINING_CTRL_REG, mask, ctrl);
+	if (ret < 0)
+		goto err_restore_page;
+
+	/* restart to calibration */
+	ret = ytphy_write_ext(phydev, YT8824_RESTART_CAL_CTRL_REG, 0x0040);
+	if (ret < 0)
+		goto err_restore_page;
+
+	ret = ytphy_write_ext(phydev, YT8824_RESTART_CAL_CTRL_REG, 0x0);
+	if (ret < 0)
+		goto err_restore_page;
+
+err_restore_page:
+	return phy_restore_page(phydev, old_page, ret);
+}
+
+/**
+ * yt8824_config_init() - phy initializatioin
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_config_init(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		ret = yt8824_config_utp_init_paged(phydev);
+		if (ret < 0)
+			goto err;
+	} else {
+		if (!priv->sds_initialized) {
+			ret = yt8824_extern_config_sds_init_paged(phydev);
+			if (ret < 0)
+				goto err;
+			priv->sds_initialized = true;
+		}
+		/*
+		 * Configuring the MII registers of the SDS,
+		 * which are private to each channel.
+		 */
+		ret = yt8824_extern_sds_softreset(phydev);
+		if (ret < 0)
+			goto err;
+
+		ret = yt8824_config_utp_init_paged(phydev);
+		if (ret < 0)
+			goto err;
+	}
+	mutex_unlock(&priv->shared_lock);
+	ret = yt8824_soft_reset(phydev);
+
+	phydev_dbg(phydev, "%s done, phy addr: %d\n", __func__,
+		   phydev->mdio.addr);
+	return ret;
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
 static int yt8531_set_wol(struct phy_device *phydev,
 			  struct ethtool_wolinfo *wol)
 {
@@ -3240,6 +4701,450 @@ static int yt8821_resume(struct phy_device *phydev)
 	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
 }
 
+/**
+ * yt8824_get_features - read mmd register to get 2.5G capability
+ * @phydev: target phy_device struct
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_get_features(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err;
+	ret = yt8821_get_features(phydev);
+
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
+/**
+ * yt8824_aneg_done()  - check negotiation state.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: auto-negotiation complete status or negative errno code
+ */
+static int yt8824_aneg_done(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int auto_neg;
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err;
+
+	ret = phy_read(phydev, MII_BMSR);
+	if (ret < 0)
+		goto err;
+	mutex_unlock(&priv->shared_lock);
+	auto_neg = !!(ret & BMSR_ANEGCOMPLETE);
+
+	phydev_dbg(phydev, "%s, phy addr: %d, auto negotiation done: %d\n",
+		   __func__, phydev->mdio.addr, auto_neg);
+	return auto_neg;
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
+/**
+ * yt8824_read_status_paged() -  determines the speed and duplex of one page
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_read_status_paged(struct phy_device *phydev)
+{
+	int ret;
+	int val;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+		ret = genphy_c45_read_lpa(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!phydev->link) {
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+		if (phydev->autoneg == AUTONEG_ENABLE)
+			phy_resolve_aneg_pause(phydev);
+		return 0;
+	}
+
+	ret = phy_read(phydev, YTPHY_SPECIFIC_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	yt8821_adjust_status(phydev, val);
+
+	if (phydev->autoneg == AUTONEG_ENABLE)
+		phy_resolve_aneg_pause(phydev);
+
+	return 0;
+}
+
+/**
+ * yt8824_read_status() -  determines the negotiated speed and duplex
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_read_status(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = yt8824_read_status_paged(phydev);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_utp_power_on(): utp power on.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_power_on(struct phy_device *phydev)
+{
+	int ret = 0;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0x0);
+}
+
+/**
+ * yt8824_utp_power_down(): utp power down.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_utp_power_down(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+}
+
+/**
+ * yt8824_power_on()  - set utp power on.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * NOTE: need WA like softreset
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_power_on(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+	int r;
+
+	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_1);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_power_on(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_NORMAL);
+		if (ret < 0)
+			goto retry;
+	} else {
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_1);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_sds_isolate_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_power_on(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_NORMAL);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	}
+	return 0;
+
+retry:
+	/*
+	 * If the PHY up operation succeeds but the subsequent operation
+	 * fails, revert to the default state.
+	 */
+	r = yt8824_utp_power_down(phydev);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	ret = yt8824_restore_working_status(phydev, ret);
+	return ret;
+}
+
+/**
+ * yt8824_resume() - resume the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_resume(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = yt8824_power_on(phydev);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_power_down()  - set utp power down.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * NOTE: need WA like softreset
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_power_down(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+	int r;
+
+	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_1);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_power_down(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_NORMAL);
+		if (ret < 0)
+			goto retry;
+	} else {
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_1);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_sds_isolate_paged(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_power_down(phydev);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_utp_set_template_test_mode(phydev,
+							MDIO_PMA_10GBT_TESTMODE_NORMAL);
+		if (ret < 0)
+			goto retry;
+
+		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
+		if (ret < 0)
+			goto retry;
+	}
+	return 0;
+
+retry:
+	/*
+	 * If the PHY down operation succeeds but the subsequent operation
+	 * fails, revert to the default state.
+	 */
+	r = yt8824_utp_power_on(phydev);
+	if (ret >= 0 && r < 0)
+		ret = r;
+	ret = yt8824_restore_working_status(phydev, ret);
+	return ret;
+}
+
+/**
+ * yt8824_suspend() - suspend the hardware
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_suspend(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = yt8824_power_down(phydev);
+	mutex_unlock(&priv->shared_lock);
+
+	return ret;
+}
+
+/**
+ * yt8824_config_aneg() - config negotiation
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_config_aneg(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	int phy_ctrl = 0;
+	int ret;
+
+	mutex_lock(&priv->shared_lock);
+	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
+	if (ret < 0)
+		goto err;
+
+	/*
+	 * Only advertise 2.5G when autoneg is enabled, or when 2.5G is
+	 * explicitly forced.  When a different speed is forced, clear
+	 * ADV2_5G so a 2.5G-capable link partner cannot negotiate 2.5G.
+	 * __genphy_config_aneg() only rewrites the
+	 * clause 22 registers on the forced-speed path, so it will not
+	 * clear this bit.
+	 */
+	if ((phydev->autoneg == AUTONEG_ENABLE ||
+	     phydev->speed == SPEED_2500) &&
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
+	if (ret < 0)
+		goto err;
+
+	ret = __genphy_config_aneg(phydev, ret);
+
+err:
+	mutex_unlock(&priv->shared_lock);
+	return ret;
+}
+
+/**
+ * phy_mode_check() - check if mode names the PHY interface.
+ * @mode: PHY interface mode string
+ * @interface: PHY interface mode to compare against
+ *
+ * Return: true if @mode matches @interface, false otherwise.
+ */
+static bool phy_mode_check(const char *mode, int interface)
+{
+	return !strcasecmp(mode, phy_modes(interface));
+}
+
+/**
+ * yt8824_phy_package_probe_once()  - init phy package for phy8824.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_phy_package_probe_once(struct phy_device *phydev)
+{
+	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
+	struct device_node *np = phy_package_get_node(phydev);
+	const char *mode;
+
+	if (!priv || !np) {
+		phydev_err(phydev, "%s: missing shared priv or DT node\n",
+			   __func__);
+		return -EINVAL;
+	}
+	/* Initialise shared lock for YT8824 */
+	mutex_init(&priv->shared_lock);
+	priv->sds_initialized = false;
+	priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
+	if (!of_property_read_string(np, "motorcomm,package-mode",
+				     &mode)) {
+		if (phy_mode_check(mode, PHY_INTERFACE_MODE_INTERNAL)) {
+			priv->package_mode = PHY_INTERFACE_MODE_INTERNAL;
+		} else if (phy_mode_check(mode,
+					  PHY_INTERFACE_MODE_10G_QXGMII)) {
+			priv->package_mode = PHY_INTERFACE_MODE_10G_QXGMII;
+		} else {
+			phydev_err(phydev, "unsupported package-mode %s\n",
+				   mode);
+			return -EINVAL;
+		}
+	} else {
+		phydev_err(phydev, "missing package-mode in PHY package node.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * yt8824_probe() - phy8824 probe.
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt8824_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct yt8824_shared_priv *shared_priv;
+	int ret;
+
+	ret = devm_of_phy_package_join(dev, phydev, sizeof(*shared_priv));
+	if (ret)
+		return ret;
+
+	/* Ensure other PHY probes wait for shared mutex initialization. */
+	phy_package_lock(phydev);
+	if (phy_package_probe_once(phydev)) {
+		ret = yt8824_phy_package_probe_once(phydev);
+		if (ret) {
+			phy_package_unlock(phydev);
+			return ret;
+		}
+	}
+	phy_package_unlock(phydev);
+
+	return 0;
+}
+
 static struct phy_driver motorcomm_phy_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
@@ -3337,13 +5242,29 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend		= yt8821_suspend,
 		.resume			= yt8821_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8824),
+		.name = "YT8824 Quad Ports 2.5Gbps Ethernet",
+		.get_features = yt8824_get_features,
+		.read_page = yt8824_read_page,
+		.write_page = yt8824_write_page,
+		.probe = yt8824_probe,
+		.config_aneg = yt8824_config_aneg,
+		.aneg_done = yt8824_aneg_done,
+		.config_init = yt8824_config_init,
+		.read_status = yt8824_read_status,
+		.soft_reset = yt8824_soft_reset,
+		.suspend = yt8824_suspend,
+		.resume = yt8824_resume,
+	},
 };
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821/8824 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
+MODULE_AUTHOR("Kyle");
 MODULE_LICENSE("GPL");
 
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
@@ -3354,6 +5275,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_INT861X) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8824) },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

