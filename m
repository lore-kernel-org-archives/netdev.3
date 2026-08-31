Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6B3AFD05;
	Mon, 31 Aug 2026 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155025; cv=none; b=Q8EBavPy51817J/UaKuS2QWqfJUxfZabDjqNMIHRc2fJyNwMTQXUGVv642MuvG7nDY674j5tBM9zjZMyJ0LLJJmfK+MVPegwkDH34y3uJaHxkzqGOBS+4gakP1iGnAhhXQ8Up6FFm46vTW5mUvuqqqt/8mJkfq90TAZHAdWpRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155025; c=relaxed/simple;
	bh=b/2g+e3OLdUc7E7theFsBI9h38B46SJT8W4mzdyrkmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X3okfzQoOCMsY+VaeopukeT4G7vX7OY/ns+mNL5qJUOSYZldoAJ06uL/m8/dd58Hd2jSbRFwpxgSrNymtVKC4QffYlaQLpTjbn0QRpg+mPWRFVo40h8HkGFJ15e5GzbQ+Kq4F0PpxXrGs8QpjBX0fwBpZA2nolAdYu6z2PJ+56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=TzrLeqFx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="TzrLeqFx"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5bo093479100, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154670;
	bh=28Epu+o01K6XXNZzCDOsehSCBiuceUvR1ip+VhnHcFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TzrLeqFxBg/uSpRSGMTLKNf4U4kBAYjA8qVewjku0p+btXiS5SFDqiZ0floHIML/i
	 06sz/bISJhdv0Xz8lQ0eHPg6+BMs53PQ0G53tpV1ysWKWI0CXBpgrSUTDMcHJSayed
	 +n6DggkC407aozLwologhcRavHx4xvtXT8PBA1RgEU44i5+5RU7Y7oIYN5Y8fudxyp
	 PmSxVxCZelrWM7GRcfb9Qay+JpVnXuY5eQBy5BW+y+f1DcYmu7R8tYhSWUSjltLCgh
	 ldpbpis8FW0C54cArhtEe2MH+azP7G8KEq+xCoyZIjeaBG7bmDafClam8NrMJHTY/b
	 6ZJICalEhYc0g==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5bo093479100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:37:50 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:37:50 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:37:50 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v9 0/7] r8169: add support for phylink
Date: Mon, 31 Aug 2026 13:37:38 +0800
Message-ID: <20260831053745.1197-1-javen_xu@realsil.com.cn>
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
 drivers/net/ethernet/realtek/r8169_main.c | 705 +++++++++++++++++-----
 drivers/net/phy/phylink.c                 | 171 ++++--
 drivers/net/phy/realtek/realtek_main.c    |  54 --
 include/linux/phylink.h                   |   2 +
 include/net/phy/realtek_phy.h             |   7 -
 6 files changed, 684 insertions(+), 257 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0

