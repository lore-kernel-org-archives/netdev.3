Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FF346E75;
	Tue,  9 Jun 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970929; cv=none; b=njGsKlShlUvwm8b7O1snUivUCBRS20Uo3KCU4lX68tDqWhTgjQSnNaIvRvt28r+PfoJQNCeNUVQ5mZdD3p2d3iUAyV/KF27mLK4qDZjzOihLHP2fxbVOT0M2KiuF2dCdS1OG4gYkASbh/hIu9DGAZzKyAlTdxULi+uPOuq5si54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970929; c=relaxed/simple;
	bh=4bEZbwNr96N8q8ruYinI3Xxo9B2GJ3hy71B/uj7qA0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nTND9Jzx1nYY1YDzNURH1XOvGdN8p9oxFOgyuczsDwKsuF5XfYiw9YtsLiSC5bVEZxD7iTcGXCgu77C39DCZelep4ZUwS3Q440DLRJ4Xrhyr76BPQM2DHNrkLgfFYPs5IKQS4+WQoCRBd8oJ4CxR7GlNg4CGVlq4Jo1AScRfQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=KOV7gisL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="KOV7gisL"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65927VbG44078006, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780970852;
	bh=iAuAcHyW9ngdN8p/ip5z8PrWS/Tb9Pesd6bn8uLu4ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KOV7gisLIpHQKyS0XdoVLtdKE1pYqHMEJBWq55Lf0sIlBVmb7JlvJLlzTEUFY1G9i
	 PPd2V6IiTZEsvURcRelHd2nz2VmGzFlN8pXM8fE6sGTiH+A5RQ/v/LP0UVvstzb121
	 1eHwSxkHEUROMtB1P56xWgEYNB8qHoT+oLGPSKhnJl/zcM+WfLgKFENBqJ70u/mqOb
	 H+9arRIonMzPzBuiW7762Knr//qPCg1L5zISbDLEVHFu3GJ4GlkQHEnxPsGIR4TFWE
	 swkJwAT82bnTODd/dbtMgLlbqvc8akakL35yFFayxlfYiiBuFWa0cmX8p6jS4L8MHi
	 kzl2XBjSCikww==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65927VbG44078006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 10:07:32 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Jun 2026 10:07:31 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Jun 2026 10:07:31 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 0/4] Add support for RTL8261C_CG
Date: Tue, 9 Jun 2026 10:07:23 +0800
Message-ID: <20260609020727.1152-1-javen_xu@realsil.com.cn>
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
  net: phy: c45: add genphy_c45_soft_reset()
  net: phy: c45: add genphy_c45_config_master_slave()
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C_CG

 drivers/net/phy/phy-c45.c              |  64 ++++
 drivers/net/phy/realtek/realtek_main.c | 406 +++++++++++++++++++++++++
 include/linux/phy.h                    |   2 +
 include/uapi/linux/mdio.h              |   3 +
 4 files changed, 475 insertions(+)

-- 
2.43.0

