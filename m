Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3473C456B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161884; cv=none; b=JOfKZGSQ2cL368LIOEXDp6ZiGQ8AzVMan+llq+d+MjWCF/nQbV+skiJsSl8KTHQ37XQwX5on1tPVq9CrXTLuUm7eXrrOk19fzlxZkSZ0v0NfmVDxXj8FXt6PrQlBpTJR8Qvznpdqgpl+7WL49J5T5Pp0JZSq/ccg3SbCZBJkDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161884; c=relaxed/simple;
	bh=9YlL/UhFkdRaYV6hhe86UrffU65g2g4sokLPA3VkFYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MruC0MLSEsxTFsimNqOy0NW3kJgeRAbd8L5Kugq7gAuSK2YXWg0ZdV+D2+LEJBYXEyn2OQ4eFg27gwZDpqs2ZxKxjlG7I9ywwdlNHpjs7Cry7U/Fsgvl9i8Dq5SIoBa6WCdsDkvGfLPszMVlpTi0e1dvyZdpDHfZZ1KHSW9LFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wg5ZvIGS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wg5ZvIGS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6878A1A18ED;
	Mon, 31 Aug 2026 07:38:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 388C7601E1;
	Mon, 31 Aug 2026 07:38:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95F2E11C783B9;
	Mon, 31 Aug 2026 09:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788161879; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lroqDS7c7e/0FELjm//w6v7eePo37TDmc7OaHklp5WE=;
	b=Wg5ZvIGShM3L2YujurYgehbqzzT5lBci4/33AHw4PD2rrYmCRrXUbcQUc7fWGWyWVxn+Yn
	BmAjByh8eFFwPs3Uwp5ClciWyGTCQe3Qv+RyG3m5eHpYOOCr4xfHIBx1pgCI3zIYCWAdur
	vfCHKmwIOWhPVRfClHhz+JYKc3dFgvLpYm5d/rXS4spbIm1lFyhgIpSXvXxjG5LzZuTxtl
	IkgtTd4AEIZ+3xsrOer5auiJdDhSPk7aEVnQSyPCq/VpJIbVxEApLN4U97ZSrV1cyz05pg
	AOiv+F9kD7YFvml7JTSS8mVIlNG7TKrVRBui+PMRcVlvJmmYSB1oN4vq58obVA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Yao Zi <me@ziyao.cc>,
	Frank <Frank.Sae@motor-comm.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/3] net: phy: motorcomm: Enable analog frontend DAC on yt8531S
Date: Mon, 31 Aug 2026 09:37:42 +0200
Message-ID: <20260831073747.361482-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In the process of getting more stmmac boards to run tests on, I've
acquired a nice and inexpensive YT6801 PCIe card, that can do
10/100/1000BaseT. It uses stmmac's PCI variant dwmac-motorcomm, as well
as an integrated Motorcomm PHY (the YT8531S).

However while testing the card, I had link-up maybe once every 10
reboots, and no traffic whatsoever. Comparing with the out-of-tree
driver provided by Motorcomm, it was found that some Analog Frontend DAC
needs a clock to be enabled, and indeed it fixed the issue.

As I don't know much about this device, this series implements the DAC
CLK configuration in the YT8531S driver only for the integrated version,
that uses the GMII interface.

I split that into 3 commits, the first 2 are splitting-out the YT8521
and YT8531S config_init(). The third commit adds the DAC configuration.

This was tested on YT6801, which now reliably reports link up.

Maxime Chevallier (3):
  net: phy: motorcomm: Split yt8521_config_init() page management
  net: phy: motorcomm: Add a dedicated .config_init for YT8531S
  net: phy: motorcomm: Enable analog frontend on YT8531S

 drivers/net/phy/motorcomm.c | 76 ++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 22 deletions(-)

-- 
2.55.0

