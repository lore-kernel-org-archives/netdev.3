Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462790;
	b=qsUYN/HzY0RD5xJHypANOHhFHPkpCgeSyXYdwHpmW5RFvr+lIO1LDWUHytjyh6xROz1/
	 ec5h9Khzmp4z7zUDbNt2kPs0I5EHarPaoubXQF6Ty0fg6XQaYqJJTiCmEW8zA7eCG2eht
	 Fx8XBxhkRrRvnr/FIwMm4J5/8NPv1Pj2iyy/cX2n5GJSBkSvp5yQhnOgerTInaz1o9LfN
	 g5yljcw5jKeIpBOmC+q1zEDHJe91aDolg3P9JLLV16I01qXkSjzUXpKwij4wsAPOSWjaX
	 HKyzTsuUlALC0yw5CKjAu/uCgYTL1TzQMxjNh2fcyPlHYGQxL9M9sDUTSn92QGDKnoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462790;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FjJQ/9cEanmkiGLkZSaT/cjzgc0H750DlzstsIHbwtw=;
	b=ptByQ8CUER9PCvvLY+HHNumTWk3Pi+C4aW4869OPQ3BndVicWMR58/oUBI/W3jd4GXD5
	 KlplGfpRYyZWVvIEVTUisjpW18XZS587UP0vndMsRAkjHSP4ZVgQ39lVk0YPCMJw6YZRt
	 pL1iFnUwpKK6r8HtX4A++m2fK4/W/DhLGpRqan2MYjpY4wjgqNPK4hYd2l/E6zkxX/5vR
	 ku6GZGl2bJPiMMtsHMOD2WU463zM3NFZ/Dsx3++v/JkElCfMo5XWbfD7TvoJ3yQm7PCnr
	 KYjQVoanb+O/dfm5RmPenlkpljlxQIGaYd8/caj5E6AhDCrIaz4s659OndeGJs5GCeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.148
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45F606A31C;
	Tue, 20 Oct 2026 02:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E45F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06745788|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.316453-0.0542113-0.629336;FP=13617245593967022006|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033022149254;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jlJBm7I_1792462778;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlJBm7I_1792462778 cluster:ay29)
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
Subject: [PATCH net-next v27 2/3] net: phy: Add support for Template Control register for PMA
Date: Tue, 20 Oct 2026 10:19:28 +0800
Message-Id: <20261020021929.3028490-3-kyle.switch@motor-comm.com>
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

Add support for the 10GBASE-T PMA Template Test Mode register
field, which allows selecting one of eight test modes (Normal and
TestMode1..TestMode7) used for PHY validation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/phy/phy-c45.c | 23 +++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 include/uapi/linux/mdio.h | 12 ++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 870920311f9a..c5f5753f7194 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1408,6 +1408,29 @@ int genphy_c45_fast_retrain(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_fast_retrain);
 
+/**
+ * genphy_c45_template_testmode - configure template testmode registers
+ * @phydev: target phy_device struct
+ * @test_mode: testmode includes Normal to Test mode 7
+ *
+ * Description: Set template testmode include Normal to Test mode 7
+ *
+ * Return: 0 on success, or a negative error code on failure (e.g. register
+ * read/write error).
+ */
+int genphy_c45_template_testmode(struct phy_device *phydev, u16 test_mode)
+{
+	u16 ctrl;
+
+	if (test_mode > MDIO_PMA_10GBT_TESTMODE_7)
+		return -EOPNOTSUPP;
+
+	ctrl = FIELD_PREP(MDIO_PMA_10GBT_TESTMODE_MASK, test_mode);
+	return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_10GBT_TESTMODE,
+			      MDIO_PMA_10GBT_TESTMODE_MASK, ctrl);
+}
+EXPORT_SYMBOL_GPL(genphy_c45_template_testmode);
+
 /**
  * genphy_c45_plca_get_cfg - get PLCA configuration from standard registers
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a5a419bc400e..81cb7f15bb72 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2359,6 +2359,7 @@ int genphy_c45_loopback(struct phy_device *phydev, bool enable, int speed);
 int genphy_c45_pma_resume(struct phy_device *phydev);
 int genphy_c45_pma_suspend(struct phy_device *phydev);
 int genphy_c45_fast_retrain(struct phy_device *phydev, bool enable);
+int genphy_c45_template_testmode(struct phy_device *phydev, u16 test_mode);
 int genphy_c45_plca_get_cfg(struct phy_device *phydev,
 			    struct phy_plca_cfg *plca_cfg);
 int genphy_c45_plca_set_cfg(struct phy_device *phydev,
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 06f4bc3c20c7..353ca13c64fc 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -63,6 +63,7 @@
 /* Media-dependent registers. */
 #define MDIO_PMA_10GBT_SWAPPOL	130	/* 10GBASE-T pair swap & polarity */
 #define MDIO_PMA_10GBT_TXPWR	131	/* 10GBASE-T TX power control */
+#define MDIO_PMA_10GBT_TESTMODE 132 /* Test mode control */
 #define MDIO_PMA_10GBT_SNR	133	/* 10GBASE-T SNR margin, lane A.
 					 * Lanes B-D are numbered 134-136. */
 #define MDIO_PMA_10GBR_FSRT_CSR	147	/* 10GBASE-R fast retrain status and control */
@@ -320,6 +321,17 @@
 /* PMA 10GBASE-R Fast Retrain status and control register. */
 #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
 
+/* PMA 10GBASE-T Template Test Mode Register*/
+#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */
+#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
+#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */
+#define MDIO_PMA_10GBT_TESTMODE_2 0x2 /* Template TestMode2 */
+#define MDIO_PMA_10GBT_TESTMODE_3 0x3 /* Template TestMode3 */
+#define MDIO_PMA_10GBT_TESTMODE_4 0x4 /* Template TestMode4 */
+#define MDIO_PMA_10GBT_TESTMODE_5 0x5 /* Template TestMode5 */
+#define MDIO_PMA_10GBT_TESTMODE_6 0x6 /* Template TestMode6 */
+#define MDIO_PMA_10GBT_TESTMODE_7 0x7 /* Template TestMode7 */
+
 /* PCS 10GBASE-R/-T status register 1. */
 #define MDIO_PCS_10GBRT_STAT1_BLKLK	0x0001	/* Block lock attained */
 
-- 
2.25.1

