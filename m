Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB240B6DC;
	Wed,  3 Jun 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=Q5mn03sYjCg+LzqGF5Pwkh7tjXA49/K0wzUA0ywqs+j0oIg78FndxbakDSKRsuJrmzfOeNio+uChce2WxCtftZCQMz8Tt51D/HqMXYdvX1ESrv2B+By8NKaHevGpCFiqKnRRt8gM+UkNaAFIvXv16W3KMYRnC/+DwHY2JpZWKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=ImCdehpsW+CSd6wqR798R/oMBtK0Q3OlfSY2u1RHHLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NpaHUBv43EOnMNnDiKC70P2DHawQ3FSD9Rz0id/LmE/Qu5q7aAQR6/p7zb8qRJEwhFP8L9z8GHKEkROJmr6E76v6XXHDib3JlyTJGmRy7D768WHDTcXsFV2v6WhVtkjexN5TH7pbONI8q7YEavHijR9+QHB+zN/fFP52I/cdp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XRSppAaY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XRSppAaY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xI0213643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469959;
	bh=/KEaKqyxdusPu1ymUfX5D9sP+tOQq7VEKGlj8VLoDxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XRSppAaYsjsQyT1I1M1LSrZnDZCA2VTapVviFSH8Rh/6rrMPo6TYnBqENvTYl1Ehe
	 eO3dzI4EImWTSLpQzFMcUjtssdq8cjpBwJSVwoTLXklFUPVi38eF39S/rGhLfZ7n6d
	 xgAPUA8yCpoc6BFj2gnXStYXidkT+oglIluJJ6ijPazANPloxpj7LIttNtWDXEPaO3
	 ElfWBNTHhcRUknzUJCDGJQcWTNS3WHpbeir32C0pqZJ1fQSSqj/BCBZL8a/DAohRg4
	 nhAeygCz01sYWd/S23EA/WLkFR2PdhpKP+BUxg4C0u0OkqiuBb+gHCvLCqcXRlQH8z
	 Bmgbci9MUBGsg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xI0213643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:18 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:18 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:18 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/5] r8169: fix RTL8116AF low power and link readiness issues
Date: Wed, 3 Jun 2026 14:59:11 +0800
Message-ID: <20260603065916.334-1-javen_xu@realsil.com.cn>
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

This series fixes several RTL8116AF issues in r8169.

RTL8116af operate in a SFP mode where the standard PHY register path does not
provide all required information for normal phylib. In this mode, the driver
needs a dummy PHY ID so that phylib can attach to a dummy Realtek PHY driver,
while selected standard PHY registers are handled through the SerDes register.
And RTL8116af is a multi-function card, all the function should be set to d3hot
and enable aspm to ensure that system can enter C10 and s0ix power saving state,
including invisble function 2 to 7.

Javen Xu (5):
  net: phy: realtek: add support for dummy phy
  r8169: move funcitons forward
  r8169: fix RTL8116af readiness bug
  r8169: add ltr support for RTL8116af
  r8169: fix RTL8116af can not enter s0idle and c10

 drivers/net/ethernet/realtek/r8169_main.c | 217 ++++++++++++++++------
 drivers/net/phy/realtek/realtek_main.c    |  54 ++++++
 include/net/phy/realtek_phy.h             |   1 +
 3 files changed, 214 insertions(+), 58 deletions(-)

-- 
2.43.0

