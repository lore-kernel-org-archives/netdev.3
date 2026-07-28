Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977483F3280;
	Tue, 28 Jul 2026 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223920; cv=none; b=FSMyg9lsNAOCXAtOYhOJ2oxZhDhDUlyJhIziBRSmsf+Ovl0KUTKGRcrwF+AVm21I49/wbM7lZz5BJHr3IbYKikYKxXr0jrI3NCkFrAMUXlnX8v0oORZfPWH/tSG2Czjgt7r3VAx8Gyv+m24AmJzl8AWwC/d9aVpMWa0vOTkWM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223920; c=relaxed/simple;
	bh=q194MhLTcwKEQlnDdqs/9cQVFyXHQ/NIed/6dLPrwpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erSu9CWwieU/baRdlkprP1uFhgw0XmzoLGuMlqqAP8GGBEiMS74zXs1rk97yv56kpyS8HM3zvPr6C6/OXFY935qdzU6xaVXmmp6xOZJ2QNIuujStEGUxBQ0PFCILyo59Nq5O5nWOVe/eLAltK+HBKEs2XiIuCDTnP78cXARhWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=p7pK7gR7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="p7pK7gR7"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66S7V8JM03681100, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785223869;
	bh=tCT9NH2wlqBwFS/ugw6uRBABi99MljBaQtzzvnWdwwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=p7pK7gR716FJn7TeV1qRZfZMomqtOrUn1PX8La1cClSdpck6sRX7qP81pXtn8rVVM
	 VMqYv+1vCVG61EpP1mbh2TeUdUJfko5voaOjRAc0kkklnVueWTjbEY9fq/GveQMBSY
	 hD5LnZwIvMbnn6X16T9AZenCPEDHnBuT1ywQ4fT4JfmyZiyTRprAxaOXfHYodPrIAz
	 K186UYZh6D8rjYlDjO47D7QOlRGh7nupt5Jdn/L6lZ1UHUtNwOLib3nDhd5Eoqy6Sx
	 vJ2b781acnSeKsTqMlloF8XRRuHV1h+Hi63WIdfpDq8rPpmX5ZSubrZkwNSOtWX9CO
	 PHAzMHxR50F2w==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66S7V8JM03681100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 15:31:08 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 15:31:09 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Jul 2026 15:31:09 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v11 1/5] net: phy: c45: add genphy_c45_pma_soft_reset()
Date: Tue, 28 Jul 2026 15:31:02 +0800
Message-ID: <20260728073106.1515-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260728073106.1515-1-javen_xu@realsil.com.cn>
References: <20260728073106.1515-1-javen_xu@realsil.com.cn>
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

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
 - no changes. Netdev queue overflown. Resend.

Changes in v11:
 - no changes.
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
index 11092c3175b3..5f8d65868e0f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2317,6 +2317,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
+int genphy_c45_pma_soft_reset(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
-- 
2.43.0

