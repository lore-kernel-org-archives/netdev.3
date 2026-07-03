Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444138E120;
	Fri,  3 Jul 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070732; cv=none; b=g/UYXV1P8IiOLu2WQiBtuY+/Myg6B2dxd6XNkfTsHN+MmRzlmsb4soub6rZt5VxsGCGlVqYH4TmupHju2+Ty98AbsBbwLwKCLzrl2ZuJBwYIt6McoxuI9v7Mm07MZuRDKufhy9YxNsSaKBnoG8vwJB6pOLCfFmFIv4nOVnQFcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070732; c=relaxed/simple;
	bh=AMNcVldHhbtCjDV4TeCPhPS8bFu+mwotBhkjwYC4mNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XiID3UofHz7f58FVUultPS44EQioatRNaDxOlgtk4k5AVcjF+7C1l9NEtHydHQ3ZC/+1gU2KEBUh6bPOzh3tx2gFRjkAMEp5R+0GZKrp3k9ivwvMl1eEWkmUUYHS+i74HUMmxQ4SGZcBnux8V3Oqds9DeSgvMM/D4Afm/2l+8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=WzO1QHKf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="WzO1QHKf"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6639P2As82572103, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783070703;
	bh=NGTR4TxbkBKsTGvbY0NdviHMnQlD3vmMH5lCVJwMg6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=WzO1QHKf9xPM4KnenZZJ/ihQC6BGzOjYm5bb4RLqohcqiSTKxmtdzwePAZAEJWq9k
	 TwOaM8tbAGTqAu2Xxm4AxPHolj5nixb5EigjThkoSLVXMNzKPRNoeZUVsDd+wkUQ//
	 izQDGLlJDiWWuPjU7OJZYbAcqAF8UiZPZ8jKBjW/fdLLLwgHY9ZPFmugwDE1aPbM/z
	 EZve7eU/o8Qj7GF7dAUpROfRulSn83qD1l0z2OCap27dMgDFDq49h08oJv8tx71ser
	 gbbCIwG2+rQjMBCxGMGp6eb418pXlaXQwZMljFnDEqiyb7N0tTcYS8SKtMFVVjfteL
	 j2hMYBbUIx4Uw==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6639P2As82572103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 17:25:02 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 17:25:01 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 17:25:01 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 0/6] r8169: add support for phylink
Date: Fri, 3 Jul 2026 17:24:53 +0800
Message-ID: <20260703092459.1124-1-javen_xu@realsil.com.cn>
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

This series patch adds support for phylink. RTL8116af is a fiber mode
card, link status and speed can not be read from standard phy reg. So
we read link status and speed from serdes reg by pcs. So as RTL8127atf.

Javen Xu (6):
  r8169: add speed in private struct
  r8169: add support for phylink
  r8169: add support for RTL8116af
  r8169: add ltr support for RTL8117 series
  r8169: fix RTL8116af can not enter s0idle and c10
  r8169: add phylink support for RTL8127atf

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 619 +++++++++++++++++-----
 drivers/net/phy/realtek/realtek_main.c    |  53 --
 include/net/phy/realtek_phy.h             |   7 -
 4 files changed, 479 insertions(+), 201 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0

