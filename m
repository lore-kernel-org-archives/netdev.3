Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DD3F328F;
	Tue, 28 Jul 2026 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223920; cv=none; b=lAkOz3undrYjyERdd/7bQ80lA59oQjOd5MsC7gEQSj7+5XPl06kygOVvH2OIL78wLZf++K66fKTls/JkANqDg9KbLG5CPxy+1MKpHR++ZwoPS2ckueFEAAgQk5OqC3MYp/EjCQIguUWQyKtMSlGRLAnRbnya1X8tJKujRu67lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223920; c=relaxed/simple;
	bh=8ROPugeQIxJAkhQWU+rI2R0qwrCbPe/o6bAacSI3V4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p66k1VO+OL1ZuY2WOwXQjhm044iACC3yiW7J2gBIIcL2YCyHsrPYgVQS27B9gDV6uofz3KVmXW7n/d5TZcYQnNEpek/3QtzyCLFlCo8XO3HLy9K9byDSqsYz24OveS52Ce0x84jXW7KV5I67+oMEG1xdX/jtjtzfw40TuP/bV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=nneM6h8u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="nneM6h8u"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66S7V8tsC3681099, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785223868;
	bh=hXtUSmPeTkKfmE0Aucw2E0uvY+m51XuaFs/QLa6v/UI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=nneM6h8uGuxsslkB5nuvfeQn7L23BHDFiVpuvXXH81DEsrbiHjsHb7MQnSIf7+fRm
	 qcPundL9PGSccfo6Ypcyb9p1q83h77iRHhuxsAVPxxe2MXwumqoHvnoKm/hFMJyskB
	 QIxHrUyKC4NFV+XOhnLKk4QgbaYeLNNaJceOiNastef4paYHNjqvUNSb34s/XNiijS
	 DL9LoSOWSuE8YYb0WClrkU0GVz8JDAFu3geKBr+eaOp+bPRpVIeudnm889qM2qxQbK
	 TxuWkLHCRX5MwvaAw7zedzXMBIZM3/0edGY6G4zbMhEkXmGXBnppEGyiuKCjGUaG71
	 2NlOBMLYPAnTg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66S7V8tsC3681099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 15:31:08 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 15:31:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Jul 2026 15:31:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v11 0/5] Add support for RTL8261C/D
Date: Tue, 28 Jul 2026 15:31:01 +0800
Message-ID: <20260728073106.1515-1-javen_xu@realsil.com.cn>
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

