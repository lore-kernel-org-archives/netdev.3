Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D099351C25;
	Wed, 22 Jul 2026 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687730; cv=none; b=Pn+E2JbDV3kcW6YThCfEgKkFcx5ucmQqwRvhSTherqbCHqDoOPCmZv7CgnT1nlRL4nTET5Qnuukuz0dwJQRjEIIp+nGUYmV+NlmfgQ5J0rSiNMRdsFROhGwT5EsFyHXNn6JfWvKveEQu5YYWXAaIgr75BWGUaDaODMU+rOW1/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687730; c=relaxed/simple;
	bh=nEBIWhsRd7DUnwhuWaWYFRgwdBlgzX9HTG3EXXqR8K0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WSjOJYnXmD1Jqpd1Pvs1thubIGuZxst7jJTZIyazcl/uGMRT5zgMQXjkitdseKMkl4FkTyZFkSXHBatU3PNWm8xSlibAIkNu+DsU+r3ELd06q/nlBP+7Pu+0e+qrD97k6ZAQj9XncoJ6Dfwik3BdRq3QG7W0Urj94JNgNQgaKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=iLQuCmuz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="iLQuCmuz"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66M2T8S803599459, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784687349;
	bh=krwd9GvxQjs7YTKiKwvh/UNJkP5pJSCE0uhs52jMm4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=iLQuCmuzBO3AijoSZjmokuwLdsa8mjN3SAKTcGtHnPiyt4+GWDp2ZlCMFBJpUX9+i
	 7q9jRnpwGcZxTElr2M+HjIQfMr4/asVk56liNh3yceL39aPAGq3nuj5W3jgx86kpsd
	 IhrDCJ6SJ8dJhJZSQtbB5xKM826NJJiL3STIQHocHzNTgk49iaH+nHjdxAZi+T+eVA
	 kM80SWBj6GiuPJyy2rJwLj0BD2tKPnbudPhZrQU+93RTgJBKevGZdJkADTPZcAR+M4
	 rJD5aFOTk6BlV4g9a5rkHFRM2TZQruLw8IKS2RYHXo2av5XbTRXhgJYZdIxCAANtWM
	 8rAJreoQUy3RQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66M2T8S803599459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 10:29:08 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Jul 2026 10:29:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Jul 2026 10:29:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 0/7] r8169: add support for phylink
Date: Wed, 22 Jul 2026 10:28:59 +0800
Message-ID: <20260722022906.271-1-javen_xu@realsil.com.cn>
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
 drivers/net/phy/phylink.c                 | 171 ++++--
 drivers/net/phy/realtek/realtek_main.c    |  54 --
 include/linux/phylink.h                   |   2 +
 include/net/phy/realtek_phy.h             |   7 -
 6 files changed, 653 insertions(+), 256 deletions(-)
 delete mode 100644 include/net/phy/realtek_phy.h

-- 
2.43.0

