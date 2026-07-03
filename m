Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E229D38B7D9;
	Fri,  3 Jul 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062908; cv=none; b=hzxgfyNKcGXuLkjvypCqctvbpLVvpXMXJ8INPwLILCCDiy0sppOTUeLlvDarWZ8D48NZIbaByU3hOaQhM88AheET7g+ITXNAkZytpQxlXZHVMey9N/jI3raRaHuIaCkjbIP/E8725AoE64Asn0pdIfXDloQvjHbinpWE3rRCiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062908; c=relaxed/simple;
	bh=T7TwC6I7F04pJ1LiNyj/ksTC5KZcDW80Vv5siEJTcqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BINySZ/hxX6Y9p6cpAJfjto/76TyGmRS/r9tpT3nLkyWlptJYttDdbIa/N7zpFw6q1YF4NU0DPjqJwgcGJSvgnue4gxK1htAdQkHRy7AANp6HUUjcg+4YE3rN9QIx+x5RhJ41DxtnBxshmSv7OAxMG+cmXiAcNXyChZUJmczDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=NaF7RUd2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="NaF7RUd2"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6637DXlR42503821, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783062813;
	bh=qTBnfNNVBQoyQDLB6p5atxzJLtTCh2IBAA9uId3jshY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NaF7RUd2T4FUIbobBAFoJHeKbiSejnKa0koiW97OgghI/fvtomUC9APidLQNpfPqs
	 SNbtVKnK4lUEMbIJCXDp4UkS/U58GT5EeLYMBkRVFo+W6tzqfgP48FERohZ6Xe7skQ
	 +IqrHWkd1v/lxmD8FcwtJIR+Du4eETpViQHX4jxmwWQUu1wASB/zF0SsimPto2e5tP
	 zc9KfGpBGQT2/8jhcs8Vt6dcfeLqXRK/ZZZBgQDAB1u2UoutSGs8MotbOZMDhabeXu
	 JkIFcIS5xUn4OKI2sp2kb239S2G5ZbAyDYk6tboz6wEE1abDGFgxOhYq3WIS+5/SRe
	 3pQ1+I5g+Aphg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6637DXlR42503821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 15:13:33 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 15:13:32 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 15:13:32 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v9 0/4] Add support for RTL8261C_CG
Date: Fri, 3 Jul 2026 15:13:26 +0800
Message-ID: <20260703071330.1707-1-javen_xu@realsil.com.cn>
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
  net: phy: c45: add genphy_c45_pma_soft_reset()
  net: phy: c45: add setup and read master/slave helpers
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C_CG

 drivers/net/phy/phy-c45.c              | 125 ++++++++
 drivers/net/phy/realtek/realtek_main.c | 406 +++++++++++++++++++++++++
 include/linux/phy.h                    |   1 +
 include/uapi/linux/mdio.h              |   5 +
 4 files changed, 537 insertions(+)

-- 
2.43.0

