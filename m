Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2F3976A4;
	Tue,  7 Jul 2026 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416164; cv=none; b=XXngXf04BJSW/FvUgFm0litxZgtjj2X0kq3dLdhet5hpglyO4DtN0BFnO8h02UxyEpEO8R+AyMw44YVo7nbMD0LBpsCQXbk+moHb3R9qTQHxyXt1/VaqH5Nv/xcT5qLnCB4aKSey75Frdz5CObJ3nasxmUG8y+aBN3HdZk3P/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416164; c=relaxed/simple;
	bh=g90/hc+bGcc19tZiH/8O+YCG73xwj3PTDSVhtPmCtK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hh5Lbnxj6IBerzbtLVf6JXTHbEFtlVY5HX1ERBYPNPoJpGf2MRZy0+s+94wzA+xyf+BndXebYFHu1oUE7V1lX3+0GD0zXf9D7TuSRJp+K8GNOjt6leEtHAckC2jd3oV2iesV+cJgLuzgjlW4RrxUC9jnyHuU5mIhyl8TimJxIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=LfKTwhYV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="LfKTwhYV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679GcouE1361138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783415799;
	bh=NqmJATtYQ3e7mMUwDYI9nvd6QFKJ1fMq8pqPKj3AOIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=LfKTwhYVRQCfMpwzLRTZLNjWvrWSk11FsZBcG6San/K5d/RUNab+EYH3Wfq8lmAbf
	 mXCgLRwP8974Pz2d53JoGe+sgtajW5QyH8XmMGc8fbLrFBWfjctFcEpLNmKRllfIY3
	 1RWysYer+Tj7DdfRnuuDvJol/Fsvt/cMfjnPTRy8n2n3GXG+DnTFNi12vEd6ifAdC2
	 Oy6Q4IDJA8T8mQxojKolMQrJRzCnRWGyPGRJTZ95uzmA2Q5p6aUL8lQ47OfVC7wbUw
	 O4FnzQkLhOaCKMR4EZcTuXlL3GcbE8m30hoLRkn2TDfEmjnJWT4L8H14GRNs9ggbmR
	 hYPRH2SE6VAQA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679GcouE1361138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jul 2026 17:16:39 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:16:38 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:16:38 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 0/8] r8169: add support for phylink
Date: Tue, 7 Jul 2026 17:16:28 +0800
Message-ID: <20260707091637.371-1-javen_xu@realsil.com.cn>
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

Javen Xu (8):
  r8169: add speed in private struct
  net: phy: phylink: add helper to modify pause
  r8169: add support for phylink
  r8169: add support for RTL8116af
  r8169: add ltr support for RTL8117 series
  r8169: fix RTL8116af can not enter s0idle and c10
  r8169: add phylink support for RTL8127atf
  r8169: add 1g support for RTL8127atf

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 658 +++++++++++++++++-----
 drivers/net/phy/phylink.c                 |  66 +++
 drivers/net/phy/realtek/realtek_main.c    |  54 --
 include/linux/phylink.h                   |   2 +
 include/net/phy/realtek_phy.h             |   7 -
 6 files changed, 585 insertions(+), 203 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0

