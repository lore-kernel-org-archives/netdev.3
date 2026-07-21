Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09233EF0D7;
	Tue, 21 Jul 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600759; cv=none; b=itRGhSBAXLe+nJ9D2gp9rwwqR+C5GGBMQx9RYKbnyixFV+qE4NtryS91UtgC4tRnCXGYlD5J7rz3ZIKeBc4aODt9YRxyVceuZ3TaGZZN3DdJoi/iBOQrGGscIM56MH9J2/rRN6Noel75ptKUtw/nyNs29ZWeO1M8nY7akldPaRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600759; c=relaxed/simple;
	bh=c31mTF0K49t/Y0JhvbJFnbo3aD+WysmD+s/f/tNmCeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwIEDOR3dmevGV66tNIU8GOCdWMU+1GUuLLcM8Q8QugldULholus5axYSxp4+aVJ6LEZe+QagB+ao3/SlmZGXz+qE1CwrG3NjTR6T/ag7TTyn6D+KDcEzYzFLq+y0p10LUZB5g0Sl8xbGov6vtD24MFEzy6ikWRvNqItsva2kRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=J54Son3R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="J54Son3R"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L2OE1W02860135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784600654;
	bh=6h9XZLScA2E9IJpQtIbrAmqsjKEXdNHLdX2ckQK90Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=J54Son3RVloln7t0Dv8gGo9g9dT9QTlPEn3I2URyYLLMrtkNGOWYuy/MQKFVmX0WM
	 SETIKGIgC3g1LiA26qy5YtZYXeNVNCJOyHqZ40oJT6uUtVjcvN1LM834xkDv4TyjUh
	 9BEEjMU8R8FmfbRwxX2DeOu2IqgzR1kKLRaCJXzpcUMUgvEOVVrFPWM4SmQmq1fvj0
	 4dG6NbLiRYc7E6yBS6o9zBdbXhRYDAUbQw63ORRZ1F2HZI/rwUof8MCXDu6ba/Kvdv
	 034lHcYunb8Xbf1Cliot1elduRV08xfh/nCIioQGqjUW4vEBkJ/88UX3fcN/bIZZdN
	 O7wPj9JOZJNog==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L2OE1W02860135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 10:24:14 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:24:12 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 10:24:12 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 1/5] net: phy: c45: add genphy_c45_pma_soft_reset()
Date: Tue, 21 Jul 2026 10:24:06 +0800
Message-ID: <20260721022410.1391-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260721022410.1391-1-javen_xu@realsil.com.cn>
References: <20260721022410.1391-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add a generic Clause 45 software reset helper. The helper sets the reset
bit in the PMA/PMD control register and waits until the bit is cleared by
hardware.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes, new file

Changes in v3:
 - re-order function according to the order in phy-c45.c

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - increase timeout to 600ms

Changes in v7:
 - no changes

Changes in v8:
 - no changes

Changes in v9:
 - rename genphy_c45_soft_reset to genphy_c45_pma_soft_reset

Changes in v10:
 - no change. Netdev queue overflown. Resend.
---
 drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 126951741428..c1f817a59739 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -384,6 +384,28 @@ int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_check_and_restart_aneg);
 
+/**
+ * genphy_c45_pma_soft_reset - software reset the PHY via Clause 45 PMA/PMD control register
+ * @phydev: target phy_device struct
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int genphy_c45_pma_soft_reset(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+			       MDIO_CTRL1_RESET);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
+					 MDIO_CTRL1, val,
+					 !(val & MDIO_CTRL1_RESET),
+					 5000, 600000, true);
+}
+EXPORT_SYMBOL_GPL(genphy_c45_pma_soft_reset);
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index beff1d6fcc7c..57cf9ac3524d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2314,6 +2314,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
+int genphy_c45_pma_soft_reset(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
-- 
2.43.0

