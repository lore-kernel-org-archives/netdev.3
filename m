Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1503B6347;
	Fri, 11 Sep 2026 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119984; cv=none; b=C58yEh3Iawwu8lB0PboOFea+uP04gc2SXMSShl4Khb8k0nV0bcqTByUx9twY0L2SNhBBo78GciJzqfzfrUwTvyyNHiVsh9LM42otbeeWqoyxkiPwt6ZWXYGVZ8KIDZk3aLFXyxDWhWKFUsIPwg8qj6EgVRbLHQj1F2t6BndrcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119984; c=relaxed/simple;
	bh=/g2RqwbdR1NRxF3RcvknAG0kcbst2SkXfi+Cset1UQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hMBXTOBs8dm3pSWGsVKSZZdJ0YJue2s33uGlVIM4AmNmBgzemtJMz/dMdCPhFLd12FA6wTyOSFTqvXPdn764nMR6qfiOgauav4M6kGM47c/PiGtwYdj+4cSr2guL7TlRm1ZXaA2NYPJAC9eiFaVkz++Fh1V7xVSVQNfU5n/1uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=KKOsLotT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="KKOsLotT"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68B9jT1412289443, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789119930;
	bh=Js7XufGh0qtkKbkYdUlm5LCmrkcB96Lng1sN8Q3WcNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=KKOsLotT1vYOxuytZbgn67doRvm+ScEUayxq0xDn8ZBuaRkdcTjVTAD1IIFrgYVt0
	 9t91v5DLN+KmCh6AJxF5GKHq76r4yvp7hkZugBDTbdVhjckvug5K7H+dk/ep9rZxcw
	 IcTJqLAGdb1osns/r6Zi72W7a6pVOqUqn9JYBVxr/uAmTmKjJdCXOKE8mkFYCshG0p
	 oHxivx/+8C3egwskekyGGX4S03XRUXlLBCSRcenzB2A0+MkD7i+yuydmboau4MIJlE
	 zuyaZ3TEMSva/MjIFxvbuAXGwcF1J4jkG+zAFclmcOw9E0fAo5KHrYecb4f32pVCwz
	 8AnlnRzW2cHJA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68B9jT1412289443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Sep 2026 17:45:29 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 11 Sep 2026 17:45:29 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 17:45:29 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2] net: phy: realtek: improve firmware write speed
Date: Fri, 11 Sep 2026 17:45:27 +0800
Message-ID: <20260911094527.1928-1-javen_xu@realsil.com.cn>
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

Firmware execution routine unconditionally uses phy_modify_mmd() for
all OP_WRITE entries which introduces an unnecessary read transaction
when updating an entire 16-bit register. So we optimize this by
checking bitmask boundaries. Use phy_write_mmd() directly to speed up
firmware loading process.

Benchmark number from tracing MDC/MDIO hardware transactions during
firmware loading process:
 - Unpatched: about 28,000 MDIO transactions
 - Patched: about 9,600 MDIO transactions
This results in an approx 65% reduction in MDIO traffic.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/realtek_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 27e31a799e2c..97b0b67b9900 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -548,8 +548,12 @@ static int rtl8261x_fw_execute_entry(struct phy_device *phydev,
 
 	switch (entry->type) {
 	case OP_WRITE:
-		ret = phy_modify_mmd(phydev, dev, addr,
-				     GENMASK(msb, lsb), (value << lsb) & GENMASK(msb, lsb));
+		if (msb != 15 || lsb != 0)
+			ret = phy_modify_mmd(phydev, dev, addr, GENMASK(msb, lsb),
+					     (value << lsb) & GENMASK(msb, lsb));
+		else
+			ret = phy_write_mmd(phydev, dev, addr, value);
+
 		if (ret)
 			return ret;
 		break;
-- 
2.43.0

