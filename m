Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386393;
	b=s0lAMOWbnmufQjgTvAxFScrHlMyJoKeWU/WGpPauzwBE6hv45rICXAwg3lyOti0VOrCZ
	 QAA7hx8vP4Ola/MeIHm52HTjgNPVcOEIsWRoL3Uf3qur8fcdDyxA77ilXu6LOE0axJmeK
	 /++7Uk+eFq4S/UGTQI9Pg+iICStSyU7g3+QMg2Zol+Np77ROGjGnQisSX8w4JVQqvTgUd
	 ArNUzKxvPv+qkMpJUgyiMyTaIF1oOhViqbPMf7aU1s6FLrDfo3KLc0OwM6adABdh31eqe
	 0fhgpOC7Qf/IT4r/I+5Y0ez8FfSnfAV2uthU8GG2Eq3tOt9LIquqqK7WhA12ii5XYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386393;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=fP8MJ1yQvKzCPp0zBrwHpFmlaviKV6CNJLuWV4zub+k=;
	b=KI+i8+jagxhGYOw3fRB1hr+IBKU8yzM/xpi1CeGdIHU526cl1QUG48HPo04RlCR3oBWW
	 F/w6w5EqvHs2sUydbzKr0OkP7sZXuKwdB9A3j87P+OdTAiOycscXCrAw79dwadlJ7G9ZB
	 ZIaM+6H1GGC5M/OCOF8361BcoZP7272uTAEQ2yNKRbPmX3SdMb23N9ZHrO5K2ahxT6fgE
	 KHqBLxQL3TDyz70zDlp9eFtcQW2hM6bTtUwz7epspctGNya0l/BqQbI7ygVCrOQRbOhNQ
	 IN9XhGNPDxe8AS0bnT3E36+WTWBHy5FfJRsxCVgBusSGvwOO3wQIWT+9lOMqGDbyXVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=AicdrOXZ;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270D606A31C;
	Wed, 11 Nov 2026 08:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C270D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=AicdrOXZ
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AB8cGmoD2277995, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794386297;
	bh=fP8MJ1yQvKzCPp0zBrwHpFmlaviKV6CNJLuWV4zub+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=AicdrOXZZN03i8p9T3v1bhk0QEilmsd1VJevAyhjgUW9Rdn/Oacydb89eQI9CN1zU
	 nv7mHR1dKJ7aDN5KFWLyi+z2bZ2F98SW2k++5Z0O5UpoBCP0k6OKY+3zDlHlsa7zlq
	 h/2ZS7dtoqtUqNCh7xYpc9CQB+5L4TXEakUKGaowZLvtxKys/6PEi0mNGG07q1Y8kp
	 SEH4+PJf1S/w1fW0hnI4WkxBDHKf24OFt4aOOfCMklDjq8AfdY8kPO+xnwum5q672h
	 q0KM8YINL+byW2YQgjraLYZJMar7N/I0ub1hxjWr4gHSu/ziS9Vpdqi4uKoqtv3Av+
	 YEhU66GqYfGqw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AB8cGmoD2277995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Nov 2026 16:38:17 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 16:38:16 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 11 Nov 2026 16:38:16 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 0/2] net: phy: realtek: add PTP support for RTL8127a
Date: Wed, 11 Nov 2026 16:38:05 +0800
Message-ID: <20261111083807.1529-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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

From: Javen Xu <javen_xu@realsil.com.cn>

The PTP block of RTL8127a lives in its internal PHY (RTL8261C), so this
series adds PTP support to the Realtek PHY driver instead of r8169.

Changes in v2:
- Move the PTP support from r8169 to the Realtek PHY driver
- Drop the r8169 PHY OCP access patch, use phy_read_mmd()/phy_write_mmd()
- Drop PPS support, only minimal PTP support is added

Javen Xu (2):
  net: phy: realtek: add PTP clock support for RTL8127A internal PHY
  net: phy: realtek: add hardware timestamping for RTL8127A internal PHY

 drivers/net/phy/realtek/Kconfig        |  11 +
 drivers/net/phy/realtek/Makefile       |   1 +
 drivers/net/phy/realtek/realtek.h      |  20 +
 drivers/net/phy/realtek/realtek_main.c |  19 +-
 drivers/net/phy/realtek/realtek_ptp.c  | 719 +++++++++++++++++++++++++
 5 files changed, 769 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/realtek/realtek_ptp.c

-- 
2.43.0

