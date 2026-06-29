Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3638F253;
	Mon, 29 Jun 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713432; cv=none; b=VUJYixH9IK3V28LAjvCFLtXvJtpfvA0qwWJkNzjOpjlgd/rKar/AGwX4zmlgP7n6FHL9QCQdIytZtAxFU8RD4JOmqUZ+LPGRXXhiOg6Amh7xZAaVxw6x+qXmsIgKbDw2KikCJQ2k4xDpLWVz++fm6UCghN4j2+MOrFFOd1FLOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713432; c=relaxed/simple;
	bh=eNCwT0R1R2JL7jCE3Ireexbrf2AFyZoX6gdTJc/4gK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XA+gX5f0lJnBACswql+N9qhdjWZjCTUehWUo8mwveRFCkiDY7RMklxEOzhHkM6Uw15TOP6V+z0tC0uguAx900B9wkLlu37bCl6Tq+uQi0NaHriERF3dfmzXURoZvzMyjatZr9q6M+1QaO2OlElWGbT1vpFE464th+dxihl59sKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=jdnipVr9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="jdnipVr9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T69XhH43467451, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782713374;
	bh=uf+q4zB0LKJ7ZMXBUXAMvCP6OiiDLKRKg4aK6ZULBYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jdnipVr9QQAdBFqo3as7w+KDmVQWKngGxfRC308KUy5WYqJvdB4CLrzEDAb0GKajh
	 TOs2v23m+MprhbiC1ZvsUyogJPkAQrl3MZ8I9IhmRhU/mWCTdjzJTP7vcccdZ2dzdQ
	 LFy1ovjMfXtlh+/AD1lcBf3CcIoj7Nc2zbu4HmM0ggpnCmCrIkncol4nqmBx2m1F9T
	 4yCYQKFloDbobM8DJ4VkrvUBBSdaPjyGwGsRyjPIhvNToKQSR5FyB1Yd9nIoyHp/sn
	 DbImwR8krBDF+rFCkdfRanje1dEiRqisXvHfcf67qn8rSBbO5o/xQdqImkAnJOYgor
	 j+hwAn5NW2Kww==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T69XhH43467451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:09:33 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:09:33 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:09:33 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 0/7] r8169: add support for phylink
Date: Mon, 29 Jun 2026 14:09:24 +0800
Message-ID: <20260629060931.1006-1-javen_xu@realsil.com.cn>
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
  r8169: create a virtual interrupt for linkchg
  r8169: add support for phylink
  r8169: add support for RTL8116af
  r8169: add ltr support for RTL8116af
  r8169: fix RTL8116af can not enter s0idle and c10
  r8169: add phylink support for RTL8127atf

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 657 +++++++++++++++++-----
 2 files changed, 517 insertions(+), 141 deletions(-)

-- 
2.43.0

