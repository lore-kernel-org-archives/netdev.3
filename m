Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B503955E5;
	Thu,  4 Jun 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558973; cv=none; b=hOE3okLHcyJCz3HTF1WahSIq1Ay35YSmnXDFrqWtGgWnWwo96tv7ViDruq7k8PNniDh8kE4mrxzQYUw3y5L+XCHbBs2en3Hm3MsptSEbOEbtFgPqiQJIHGxqrfPyD+gNpJphKsoIkq4TQ8PSQ5Vu0g3nzmM1/hYcYVfs1kPRcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558973; c=relaxed/simple;
	bh=jGAbSILmb6EfViDelDlDM1I8NqnL8HczozyAIvB5A3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jn0LY4pgVot6UtmkUJR2U1qPaGTHbTDEvUjujCG/z+PyyM8Jdo4UgblN9A05S0BOolMbG3KjeM16v1Z8QsTG+8tOlwE71j1DStNQfX3aY0WdM7mtDoCwCUoY4SBeS2sTnaYIWjOTQxGU68W6sIHuz32BvEiyabx11JVU2XBEVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=hHB8kcGY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="hHB8kcGY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6547gBosD206040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780558932;
	bh=DmuTz0krACy9ZU2THuPe6WqtsTGaJIu7LXhPcxFOLy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=hHB8kcGYxfiIoxeI+t5Hbc17Xf6NqbI7xHdlA75UcuhkfaO2B/2fBJGple7PCA1i+
	 BT6XPoKVSsVsEDYfY2Osq/2aSXTiBXHVi1GE8/CzifKZ8+cujHJHk3n07JKIK0Cere
	 yL0scxOXfpTJUrcvIICwmimOQ2/TOqZ92GV8wm5aYCwWqWw7kZkMvPo2LfGzNzYj4+
	 1u67UvTi4Z33zpdMfr5bS+Sc3q7ww6UQ/SnWiOSHCLuWh9/A23x1RnTR6zg6wrq38p
	 u0FGVBGqk9o4MrSNIqqKA4gcn/1YbV6hx2AxgCULjL5RkPlVxzNpbLq/WZ9K8OTGth
	 IvwK6QiwoS6Zg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6547gBosD206040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 15:42:11 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Jun 2026 15:42:11 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Jun 2026 15:42:11 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 0/4] Add support for RTL8261C_CG
Date: Thu, 4 Jun 2026 15:42:05 +0800
Message-ID: <20260604074209.93-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261C_CG and add support for loading firmware.

Javen Xu (4):
  net: phy: phy-c45: add genphy_c45_soft_reset()
  net: phy: phy-c45: add genphy_c45_config_master_slave()
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C

 drivers/net/phy/phy-c45.c              |  54 ++++
 drivers/net/phy/realtek/realtek_main.c | 408 +++++++++++++++++++++++++
 include/linux/phy.h                    |   2 +
 include/uapi/linux/mdio.h              |   2 +
 4 files changed, 466 insertions(+)

-- 
2.43.0

