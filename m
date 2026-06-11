Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA61A267;
	Thu, 11 Jun 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148320; cv=none; b=qR9Y2Urc9msXbgbptRquuTFp4AE4UTDosVSmYVXd8Zb7QzpO1zb8FIfBsmYPldSvnsHXA2tmNHS9lf4+QOhSTFhSJoarQAs5g4ztEYNuoYBiphouAxU36YG8LUASHBlHYM2KDwywO0teeUirQSiOZt6YyqMSMn6eC1TSBunuQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148320; c=relaxed/simple;
	bh=EhsdBPp2h1ZhDg/c94hJR/1h327z7TAU1pIFnlP6elc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7cyd2wUjocj0AUADOEL5S95LkdPk96HO7V5Y58X7dkCFuDVM8bPpwss6x2AfumF79YuUPIjFEtnJGUMq8lPkmT6ICqiqdM9dnBp5bw/8TyAsngZKHp4vjl88G0FQu5+KSzFGXqnwdqAAtID78GZY7Ee8Kxg29vShURgDBQxJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Gkq/NPQX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Gkq/NPQX"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B3JTlB41578242, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781147970;
	bh=MJA5b7LDGyBXmm+5rSAaPLuXsCmdDh+aSannH+lnabA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Gkq/NPQXC6PKWv209VGzYy6V9GHPHN4pwALoPlvnolbJDW5QVWgOEH30WzaF0OAH2
	 zl9hNj1tm+OXI0FrbKYHoGkGprwqeFdRtdkySHhBcy9m7V9nopYQGeRi/urNudBghD
	 kBIoYlQ1gI60fV4bPr+laRe18G8OPnm+N0uZDfQgdXcGQKX31a0UYq1ywXYfyRfiMn
	 kOMhmZKw83xiE/7M/U27deNypNpNAwXAkmzv2CgoWgk6EBBFQMHWx4AUBZpgCAe6fv
	 WfrzwNKlQ5O+TOGPTj7ogtNNqiXnxXfYgSh0RPs7tuyhx26hsqjQ314Kdk+a4Ni6go
	 tRpnEphGH2KvQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B3JTlB41578242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 11:19:30 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 11:19:30 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 11:19:29 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 0/4] Add support for RTL8261C_CG
Date: Thu, 11 Jun 2026 11:18:35 +0800
Message-ID: <20260611031839.568-1-javen_xu@realsil.com.cn>
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

 drivers/net/phy/phy-c45.c              |  69 +++++
 drivers/net/phy/realtek/realtek_main.c | 396 +++++++++++++++++++++++++
 include/linux/phy.h                    |   1 +
 include/uapi/linux/mdio.h              |   3 +
 4 files changed, 469 insertions(+)

-- 
2.43.0

