Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB813C197C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159705; cv=none; b=lLqSvl0Ew360AWyFA2zzMQxc/LAHalJMnkH30fP7ti3jjuSzzHGTtf5nYbgQI0M7B2cyKZ/lvqOsj2Ja1BGGyvmTs1HG22OpLgBQTTFcjEwVKmyLgW1cltofhe0DqWB+qCN8hcRu0MxouWvxR3qvENsprmBaiO6HR/KqBPQ72TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159705; c=relaxed/simple;
	bh=BqMT1Z/SAeiSyOw4qEaGqm10PUw+ISI4RslbrWgZv2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSQxyaUcp3c/AmDCOuwgZmLL7nO13EuvXBVFtMZENSDkt0WsT5hTg2XMD5/TkLlgOxTwCPKC3s4gXcPfYVXLpHavs1bk/j2iiHRK2XgNSvrZUwCiEj7IZIoqrD0RPCyb97wa+vXM9rJJ3hYQYu6zcKdYZ5hsankEaiaZOCMqoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bztAEhcL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bztAEhcL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A9D931A18E6;
	Mon, 31 Aug 2026 07:01:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A187601E1;
	Mon, 31 Aug 2026 07:01:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6740411C78A4C;
	Mon, 31 Aug 2026 09:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788159694; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=JWMWw4FwzjGvX2iKfmXe0I6b/+rjNzreNT87o090rWg=;
	b=bztAEhcLXhBf7yPrZ53OqQWY5eOwhfChK2LTsEpMAAKE3aW4Ue3q3IdTeBZAef5EpzqJhI
	3xsdyqW0Vc57YV3l6mEcNbaSqqR+cJFKkO3goduKhFp3FAn0JORT2BD2pfo0tGP5mvGRz/
	8TFkuddjS5Xylc0ZzYeSR6xnvOBgOSBCrBNV8jg1DQwQgJyDy9nNZv8XHQnlafh8EWBnWU
	hHPVRdY3pRWmUZzfRgPsyoflMrwDGCrusYzkENAGt6Qx8G8hKovtaacz3iveNI1X8U75cH
	mY/YT8Ji+9lDO0zTzHLARuce2jX9H02nP0xPUdaHTUonY/FdvXfTUs0lljSmZA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/2] net: stmmac: dwmac4: Auto-discover UC filter size
Date: Mon, 31 Aug 2026 09:01:18 +0200
Message-ID: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Following my attempts to get clean ethtool selftests runs on stmmac [1],
several issues were found with the unicast filtering.

[1]: https://lore.kernel.org/netdev/20260827134004.45ffb57e@kernel.org/

This lead to the discovery that on dwmac4 platforms, the unicast filter
size is always falling back to the default value of 1 entry. On older
variants, the size comes from devicetree.

With a single-entry filter, we directly fallback to unicast promisc as
soon as any entry is added in the dev->uc list.

dwmac4 exposes through the HW_Features0 register the actual size of the
unicast filter, which is made of 3 banks (details in patch 2). Let's use
this feature to grab the filter size.

Results on actual hardware :

 - imx8mp   : goes from 1 entry to 64
 - stm32mp1 : goes from 1 entry to 4
 - jh7110   : goes from 1 entry to 9
 - yt6801   : still 1 single entry, on extra implemented in HW

Maxime Chevallier (2):
  net: stmmac: dwmac4: Read the UC filter size from hardware
    capabilities
  net: stmmac: dwmac4: Use the full perfect filter ability for UC filter

 drivers/net/ethernet/stmicro/stmmac/common.h  |  5 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  6 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 60 +++++++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 39 ++++++++++++
 5 files changed, 99 insertions(+), 13 deletions(-)

-- 
2.55.0

