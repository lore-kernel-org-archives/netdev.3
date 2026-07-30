Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4B3B6BE8;
	Thu, 30 Jul 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394588; cv=none; b=H57hoyeXYW0l7wfv5e55tPyI8rji0asDCkwFsCzEwM6fJF76ralluqPRSFkJQq53wtm9xV4ML8aZSPxjnmlmRUa2q1TMuKThffULSDD+3iygR5jZf3WGnj+7PZVr/VdWT1OKCgX0wCSKxkuDsrWS7XAFZU8uxIe8+d/XPqBxTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394588; c=relaxed/simple;
	bh=BBtoel71lTWTz6rbGg1nuTqTxXdHVAxv5De5lO1id9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mk7x34QiGLzClCTl0+TJwcLGS/pZhQiOHMgCtBSZxtUEejuqF2USDt62F9kRRke5W7j+S7bt1D1Qn1//WHqhryD6a4mFmrkRq87Dpyy/8cO5tbqLrxHh42M7JCEqE9lUMnXPsLRHYaEwfUSHDjXj2tQmpZZ+/Lf/1EG2+WXsiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=G+Htuygp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="G+Htuygp"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66U6oGdW51003586, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785394217;
	bh=SOfUTSNmF6cJnRHBzfXP2O7VzYOhI8gOvlPooLUwlvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=G+HtuygpxVnlS6Nt0qhe0e31SOZ/PGz1oRhZoPJ1epUTvEBm4B2c0Bw55YZfVyNrH
	 2zXbLeKokAFvwulgi2nBnDAlGgqryLkhOF1FYeQJnVcjV7DxZgDg+eF9DKiF6ucYRf
	 HVOpetoS3sE2Oz/lZBJiH082bbyO5aMwqb0BBWTzvrdDcCh9a89lGrMAFIUW/z36x5
	 G/vHi4AYgzqn/cD31udxn0bFGfW7mmeEnQ3eW9VbDd0u8R79AzIQgTL8dydVEJpvh3
	 z9CErrtXZkIoKISPu2Yaa3a8hUq5/ppnen/ymjIZU2O8H95Q8coSD/py/tf8ie+nPF
	 cuz7JRQGmqRgw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66U6oGdW51003586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 14:50:16 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 30 Jul 2026 14:50:16 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Thu, 30 Jul 2026 14:50:16 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 0/7] r8169: add support for phylink
Date: Thu, 30 Jul 2026 14:50:07 +0800
Message-ID: <20260730065014.883-1-javen_xu@realsil.com.cn>
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
 drivers/net/ethernet/realtek/r8169_main.c | 671 +++++++++++++++++-----
 drivers/net/phy/phylink.c                 | 171 ++++--
 drivers/net/phy/realtek/realtek_main.c    |  54 --
 include/linux/phylink.h                   |   2 +
 include/net/phy/realtek_phy.h             |   7 -
 6 files changed, 651 insertions(+), 256 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0

