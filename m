Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09C63EFD05;
	Tue, 21 Jul 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600758; cv=none; b=oj4vlmYXE80HdaR8NkeMPqiH7d0F2TjQ6u5qukXhdbungYygt2Qm+tpxjvRRv4Rj/HDywUgHjeRFQ2mfC/1LwHg7bYdNGr3Zcq8O27mwBsmOMWGNhdw1m0RbAWYg19q4EbtXwQ3z/5AKBCrDlb40y4E2S0HizGvHLJa3w1JYOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600758; c=relaxed/simple;
	bh=8ROPugeQIxJAkhQWU+rI2R0qwrCbPe/o6bAacSI3V4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U0zoqm4qtzMg73aLavbZE520p7f/dG3WdlpXFTBdxFuxbHWyw11c1MksQuGnq6fCUBrBHbALv+nVv/J4I9WVVMG/bW60eof8LZXPxCRxZ3kaE6t0a6q4BT4SazisjoGESCLkULPuk9krJkEufu3ip5VGd9lFVcXX0d5v/axvKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WzjYLsNb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="WzjYLsNb"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L2OC1W02860135, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784600654;
	bh=hXtUSmPeTkKfmE0Aucw2E0uvY+m51XuaFs/QLa6v/UI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=WzjYLsNbe8TuiQr/aoUCYzuasmmckIya3Y+PJ0NOGmSFj1Ixmzi2wemBp2VGALDsC
	 htp3ZPZJMf+OPJv7nQVKJtvRIezb+HiuWjJKoYMT8hywF+yCagceRmTb7rd90ISDg+
	 75y7GQ3Z7CWcqGKYW+69cvDIc1WV0sYRpLX+tYDDkWf8Sro4gBaWCI03tk0ZWlGXZ1
	 3CqSHSN/jwHf70V0prJQSKESnrYS0elkTsPhR0fL6A4Ymcn7+x63JF8RyQ9wBVjwGu
	 qyUjIw7Ksa/z2vFQfFB96lM3dCKCgeTujMbhAc9x5ZWcIkTgLSLfsySeHjmz6h+ZhD
	 mB+bKNSLI+DXQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L2OC1W02860135
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 10:24:13 +0800
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
Subject: [PATCH net-next v10 0/5] Add support for RTL8261
Date: Tue, 21 Jul 2026 10:24:05 +0800
Message-ID: <20260721022410.1391-1-javen_xu@realsil.com.cn>
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

Add support for RTL8261C/D and add support for loading firmware.

Javen Xu (5):
  net: phy: c45: add genphy_c45_pma_soft_reset()
  net: phy: c45: add setup and read master/slave helpers
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C_CG
  net: phy: realtek: add support for RTL8261D

 drivers/net/phy/phy-c45.c              | 125 ++++++++
 drivers/net/phy/realtek/realtek_main.c | 411 +++++++++++++++++++++++++
 include/linux/phy.h                    |   1 +
 include/uapi/linux/mdio.h              |   5 +
 4 files changed, 542 insertions(+)

-- 
2.43.0

