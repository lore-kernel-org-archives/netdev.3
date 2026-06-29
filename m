Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943973905F0;
	Mon, 29 Jun 2026 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715748; cv=none; b=QggSUtZEWOBw/nc4gB3dGyrX9PL+N0Gk5Dj5K7DH/jxcTeaFZtsz9P1tXGgX1U56DDVF2yaZ89lqjo8S7Pa4bgwzb3r3n1WHFjL1UNiMU1eAkZLo+vZDKc3xmBqe9h9si+pMq3SFlRIhUQgcKAVUer06XhSoQ5TBHp1csmCiWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715748; c=relaxed/simple;
	bh=6KmcwiDyX99vO1BDNAwyvmb2o8Y6QQ68nKwKx+XzeiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qj5WADqfxyUNsWJTKD3PqQGwSCW42heaZQRBQYif8xUcVxJE1sJecILwRkMVbhECEkLUrXriTIaZKs6qAIpD0Lxak36X3caOZ+Rv+wBfdBFPz3PqscgFph647rZF0KS6JIMowagcYrNN+AXGxsWqd05sIXRU9Z1ZF5c7CHMd72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=JCywNqHV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="JCywNqHV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T6lKHl93483096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782715641;
	bh=NI3K/TqgCKTcmndsch8juEbFhwp4yoGxUCxMC1v0EWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JCywNqHVIXygmzydOGQQSN/GTCsZFsRCgrCEPDrmGW9Hd01s5cgG0Bm7qsoX11CzW
	 6+63H//PWHYd8fx6b8BZ+OXzs52/8QRMLOI1kG8Jxj3STETHckwkTeHB8agdI5G4VB
	 d48GltF52fiGy1ixKCZXca8SfNnjRIcZcsaAWUUvz+ZiE2JoS01AxcRRqMExTu4hNv
	 UchDHmjQqlK9R4fwL6CCbZqhVvhT/tcnIKi9YtKctnVgYoEqFabkcU2Wpa4qQ+rXIy
	 0rWNea/etKeKauIq9BNwtGeWSAwsIiLtH4XVxSMzxC7MXKVA6l3gUlK2ULIGdXm73N
	 kjBrsBFfPOlUg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T6lKHl93483096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:47:20 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:47:20 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:47:20 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, <nic_swsd@realtek.com>,
	Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 1/4] net: phy: c45: add genphy_c45_soft_reset()
Date: Mon, 29 Jun 2026 14:47:15 +0800
Message-ID: <20260629064718.1349-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260629064718.1349-1-javen_xu@realsil.com.cn>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
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
---
 drivers/net/phy/phy-c45.c | 22 ++++++++++++++++++++++
 include/linux/phy.h       |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 126951741428..60d044156a83 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -384,6 +384,28 @@ int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_check_and_restart_aneg);
 
+/**
+ * genphy_c45_soft_reset - software reset the PHY via Clause 45 PMA/PMD control register
+ * @phydev: target phy_device struct
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int genphy_c45_soft_reset(struct phy_device *phydev)
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
+EXPORT_SYMBOL_GPL(genphy_c45_soft_reset);
+
 /**
  * genphy_c45_aneg_done - return auto-negotiation complete status
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..25a66320df56 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2309,6 +2309,7 @@ int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
 int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool restart);
+int genphy_c45_soft_reset(struct phy_device *phydev);
 int genphy_c45_aneg_done(struct phy_device *phydev);
 int genphy_c45_read_link(struct phy_device *phydev);
 int genphy_c45_read_lpa(struct phy_device *phydev);
-- 
2.43.0

