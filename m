Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83836407572;
	Thu,  9 Jul 2026 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591745; cv=none; b=kkDfYGw7yFG6qeA/2G+4yCyPchVYqln0E92ensZ1yib8dBzrnUdc0Q6DAZMvSwTnnsDm5FYutO/7eMecE6eYO8GNIfsM4E72LyGnRxfwIf2uMs/Byra+isqcboMvItCLEyQ+48EdQ6I8iLQP/b7szlHxeaWcfXIFTS5A4T2s9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591745; c=relaxed/simple;
	bh=b2LM1DBpGPa87yNnInaMs3XraVNXEaoJ77Jl0uv5QpQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYSiDwV34/ZIOhaYOlati1+OVduLRLAsyWN5UJ+WgaEZDTqRr3JQfcGAwTE7STSiKnwHWHPW2wk4K6RGRo/4156SWjodI3iyRrL0cQiPAGCLz6nCxNNetDyLfHPQ0t/ScE4qUOagE+bMf9gO9w0h0nE9RbI/p2Pi8c7Ly7Z2OQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=NFppqISm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="NFppqISm"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 669A2mGqA2982778, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783591369;
	bh=Gm0XorlIeqAZWxxh0XB2NLHt31NlXXFC9cxnABxfQXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NFppqISmXQyJidfCY+PmgviPpCaftroR1DjPZZZIlvgh+XTx0poqtAULicykV0uE8
	 j6EPGkFswKpZvA4u04AUdku/W9Z4FM5kk5Fw6woeqVDjJGip9tId1nTn8K79B12L/r
	 f9gAjJ0P+Rla+5jakzO1CdeF+4zroqz4qx+Qk+mILsYCbwEGrcF01c3Y0svZ13RObI
	 Vf3knVcxG5CcqEDsu0qvACb8CXGB3eDBLzaNl+Ipu5UOoURMQJOsUU1llKhRkJdEeq
	 3Zrzl2Lsbc4pi0nFdUP3x9lH1pvx1gq9fpvrgsTsgelb9lqOmIKvEplUB1ICjt+Nnx
	 YfNzLtFeKX2Rg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 669A2mGqA2982778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 18:02:49 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 18:02:49 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Jul 2026 18:02:49 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v6 0/7] r8169: add support for phylink
Date: Thu, 9 Jul 2026 18:02:29 +0800
Message-ID: <20260709100237.541-1-javen_xu@realsil.com.cn>
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

Javen Xu (7):
  r8169: add speed in private struct
  net: phy: phylink: add helper to modify pause
  r8169: add support for phylink
  r8169: add support for RTL8116af
  r8169: add support for RTL8127atf
  r8169: add ltr support for RTL8117 series
  r8169: fix RTL8116af can not enter s0idle and c10

 drivers/net/ethernet/realtek/Kconfig      |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c | 673 +++++++++++++++++-----
 drivers/net/phy/phylink.c                 |  87 +++
 drivers/net/phy/realtek/realtek_main.c    |  54 --
 include/linux/phylink.h                   |   2 +
 include/net/phy/realtek_phy.h             |   7 -
 6 files changed, 619 insertions(+), 206 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0

