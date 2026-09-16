Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D946AA81;
	Wed, 16 Sep 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546565; cv=none; b=KCBZffnJxgPZMuYy35OygyiHsGfmVPP6puRqQKSqbsO/M6tibHAZ9ES7f3rYLCy+WnGrssxvPOtlkyGG7hxBhO16RwbqJQ615I17ChR1M/lJqyA1zx/RMv1Ivju45Ky6kKw7sm/C9zZlh0YTWopPH8Msx0lsvbgrx/9rAvBcjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546565; c=relaxed/simple;
	bh=MF/2ddKAX3zZ4vbwMB+nwe+p3oImsQWjU2yXuBd3ST8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yi6hRpoD7m4d1Iu1Nhi9LHL0OqAapMCYRv+J6WQr8Nj2Q1jj/TrkmVH4TZwdwJs/5XPxYSWOe02zDokVSlO7TNQ6zf20RgAGOz+UPvP6XL1iaUc0LT8ePbwjo+mgfoA633fUXzJ7aZEjulr/iCJDh46bWDB26A/OU3dHFvH6zEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=KObtsL/W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="KObtsL/W"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68G8ElRT22223080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789546488;
	bh=kaLAI2WfPjlCATIfPataUac8Xi8UPddM62Yg/Qa9Lh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KObtsL/W+M4QKhLdLWjLw+i+M+L0KBZiPorLqfFWxdYTpQBTerwVaFv/acYPU9yMl
	 Ch11vsFeg0STiR0fCqPBDYsM+eVRE2mGQ8PbgBB5erYZzHnExVag8OQ7Z2So3D6lEL
	 8y3cFuHCEYiPnOzWjzHECxsu0UTCua40Tbt0p5sWaALjKA039PzBqFfiYxnoe5eb53
	 l7x31hNb07y+8Nlykd3tpdCxaQOOq6M1z+LNvmx/17TuggQduQrI604lNT7Fh4HzdH
	 eAIzlI4BWO5YLzDrsw72nts90BotzltEm04jSz32Rqij985oDgEYwYui2zECvwBSMk
	 TTfKCLI9pS3AQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68G8ElRT22223080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 16:14:48 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 16:14:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 16:14:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/3] net: phy: realtek: add support for RTL8261D_VM
Date: Wed, 16 Sep 2026 16:14:44 +0800
Message-ID: <20260916081444.497-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260916081444.497-1-javen_xu@realsil.com.cn>
References: <20260916081444.497-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261D_VM, its phy id is 0x001cc89a.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27051e2c7b5f..67199ef56c1a 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -258,6 +258,7 @@
 #define RTL_8261C				0x001cc890
 #define RTL_8261C_CG				0x001cc898
 #define RTL_8261CE_CG				0x001cc899
+#define RTL_8261D_VM				0x001cc89a
 
 #define RTL8261C_CE_MODEL		0x00
 #define RTL8261D_MODEL			0x81
@@ -3386,6 +3387,19 @@ static struct phy_driver realtek_drvs[] = {
 		.soft_reset		= genphy_c45_pma_soft_reset,
 		.suspend		= genphy_c45_pma_suspend,
 		.resume			= genphy_c45_pma_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(RTL_8261D_VM),
+		.name			= "Realtek RTL8261D_VM 10Gbps PHY",
+		.probe			= rtl8261x_probe,
+		.config_init		= rtl8261x_config_init,
+		.get_features		= rtl8261x_get_features,
+		.config_aneg		= rtl8261x_config_aneg,
+		.read_status		= rtl8261x_read_status,
+		.config_intr		= rtl8261x_config_intr,
+		.handle_interrupt	= rtl8261x_handle_interrupt,
+		.soft_reset		= genphy_c45_pma_soft_reset,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
 	},
 };
 
-- 
2.43.0

