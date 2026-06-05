Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32A41930F;
	Fri,  5 Jun 2026 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655974; cv=none; b=p50+o67nZIY5Sq6yWhYttWdVoCX6XebLAbxprlcqNxfuh0pGRLHt8DxBlwmkJ7DgS+gtTquinWYuObm/4tDsTy9PsN3H/9N6YLX6YsqJasU0W1PL/4KUANqIyijWswLsuKtxGl0imD9Lvm0uomF7XOYMNHgboEF8/ChxCVWJE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655974; c=relaxed/simple;
	bh=PNHEQykTpWJiL6zhkXZxV+SBGhpefqJmmacMUI6stJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQPmsxSwU92w1jweUpSoCBdQ3jkFXQwCmuvNe7K74V91z5QjwStoT1MjCeYPouihLAwgJ0hOpA9x3+IxmllfXGOjAPpFW7N6O2rFeWROKljST/3x0XWupE2+zdCpKiillRMXTAolg4jcXJOs6AsJBleMfWPO/DgSt/lYYluWWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=pGUYkdQ2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="pGUYkdQ2"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 655Ad8eC51324199, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780655948;
	bh=0H0ftnvD0UwP3dO94aToBIm/Z7vVgP3c3FipG+e+Vpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=pGUYkdQ2zsISncQk3tjzRvGbzTnAwZ/NmY5/ksjhOxNLXVi87rPuCIRIA/vcqlBi1
	 j9QzYMfZjPjCeqUf1mSpptX0DeboSZNZL9tSrQ457ASZmeEuTLikWOPYp18l/dawUT
	 Gz5OEAmIc7TA+7trfgvbCKOaBedLq41T3LnOSFsXw1teXkA/woLD4RxfyqYmHc2e3+
	 jo6gs66Cxh3sh4/kaYSPsbLcIrVYwRRRX1Z1GJtfSfLCSfzfaOABfGgu6rXmV78VaQ
	 myHaK83VUqlPNUQVaqAwWovJZavG0kMF9pSIo0mojU69s874KnP3k6AbEIlmXIQrIO
	 c1Va+HdWaELDA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 655Ad8eC51324199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 18:39:08 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 18:39:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Jun 2026 18:39:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/6] add support for phylink
Date: Fri, 5 Jun 2026 18:38:59 +0800
Message-ID: <20260605103906.1445-1-javen_xu@realsil.com.cn>
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
we read link status and speed from serdes reg by pcs. We have not changed
the loading process of RTL8127atf.

Javen Xu (6):
  r8169: add current_speed in private struct
  r8169: add support for phylink
  r8169: decoupling tp->phydev
  r8169: add support for RTL8116af
  r8169: add ltr support for RTL8116af
  r8169: fix RTL8116af can not enter s0idle and c10

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 447 +++++++++++++++++-----
 2 files changed, 346 insertions(+), 102 deletions(-)

-- 
2.43.0

