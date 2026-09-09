Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440C47798E;
	Wed,  9 Sep 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988942; cv=none; b=NKrmQ8CD1xPi1rme9qIkcVp73O+OpG70kstehADSFhvXT1qWD2OO0PkvV5ZhG6EsaaHWqBGruBgRt8lOCeToywewGccz/qtA0iH9Llc6jWgy9S8ShfzMGfZA5r9sh0AwrO2EexG5v3KE4wWe7XcOVE05TGQQvoP6wWlc33+S0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988942; c=relaxed/simple;
	bh=YRIlxvS7MbdfMoxh9ZQGOSB8CUJEv8piJA94swXkbi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ovPZdnaeU8UrzsOD6jgEY+MW8uGa2wM8cnE6rTTkQJFHTvZs6SobJb6pDmIYGXmu1gzSZ3+h9b6moY4/BaVJVogWBGo1xL3T1WZz8ue73x1n4J0/w08wZg/AUW8XKtIvxPXQpdjC79oHK/1OW7p8MnA6SA+UXfVBYWkvoi8RyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=Bt+7iyb+; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="Bt+7iyb+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF102408FC6;
	Wed,  9 Sep 2026 23:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788988936; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=hx6CJv34VPpHOsWGs8nGvEjuuxvYGp2ezi0uE9qZA9A=;
	b=Bt+7iyb+00Vu8uQDiQEQXmXDPDgH65AIR7cxu4TOr1zcf9DpkPdJiLvU/cbr8utfnwR9XI
	ZfeMzzSLH3syNNnyyvr89mY/qQjb/tPDWQ8FQLcv1Rbt0krD7miBvr2moG0A2jEhEKd1xz
	VmcXegxxXviNfQpj/pjcPRRNlBCjp0lU+V/acLFueVOgQ3p5KIUOsjAh2pv0X7NXkNQoru
	WYh498/Pj6bt9HCN+9XfQvs8hz78qHnskQStuLBOTgPDaIOA68mJUDUPTv6HlALkIbEgyE
	DpjtO5ncA8AQkmLo9cLQQIGc8GdMtJXWUgU3w6nggaTMFW9hwvFdIOy66KwFWg==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	vadim.fedorenko@linux.dev,
	maxime.chevallier@bootlin.com,
	dong100@mucse.com,
	wangruikang@iscas.ac.cn,
	25181214217@stu.xidian.edu.cn,
	hkallweit1@gmail.com,
	han.junyang@zte.com.cn,
	xuanzhuo@linux.alibaba.com,
	enelsonmoore@gmail.com,
	jes@trained-monkey.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH net-next 0/2] net: econet: add EcoNet EN751221 ethernet driver
Date: Wed,  9 Sep 2026 21:21:44 +0000
Message-Id: <20260909212146.3184077-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 SoC has an Ethernet device with two ports and two
DMA engines (internally called "QDMA" because they handle both QoS and
DMA). It is fairly similar to the MediaTek and Airoha drivers, but
distinct enough that attempts to attach to those did not prove
fruitful. This ethernet device shows up in the chips based on the
EN751221 die, and also in the EN7528 chip with minor differences.

This ethernet device also has a "packet processing engine" similar to
that of the MediaTek eth driver, but that is not supported in this
driver.

This driver has been used as an OpenWrt package for about 6 months but
was not contributed until now because there was no DSA switch support
for these devices.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>

Caleb James DeLisle (2):
  dt-bindings: net: econet: add EN751221 ethernet
  net: econet: add EcoNet EN751221 ethernet driver

 .../bindings/net/econet,en751221-eth.yaml     |  127 ++
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/econet/Kconfig           |   20 +
 drivers/net/ethernet/econet/Makefile          |    7 +
 drivers/net/ethernet/econet/econet_eth.c      |  334 ++++
 drivers/net/ethernet/econet/econet_eth.h      |  231 +++
 .../net/ethernet/econet/econet_eth_debug.c    |  617 +++++++
 drivers/net/ethernet/econet/econet_port.c     |  473 +++++
 drivers/net/ethernet/econet/econet_qdma.c     | 1209 +++++++++++++
 drivers/net/ethernet/econet/gdm_regs.h        | 1514 +++++++++++++++++
 drivers/net/ethernet/econet/qdma_desc.h       |  677 ++++++++
 drivers/net/ethernet/econet/qdma_regs.h       | 1243 ++++++++++++++
 14 files changed, 6461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/econet,en751221-eth.yaml
 create mode 100644 drivers/net/ethernet/econet/Kconfig
 create mode 100644 drivers/net/ethernet/econet/Makefile
 create mode 100644 drivers/net/ethernet/econet/econet_eth.c
 create mode 100644 drivers/net/ethernet/econet/econet_eth.h
 create mode 100644 drivers/net/ethernet/econet/econet_eth_debug.c
 create mode 100644 drivers/net/ethernet/econet/econet_port.c
 create mode 100644 drivers/net/ethernet/econet/econet_qdma.c
 create mode 100644 drivers/net/ethernet/econet/gdm_regs.h
 create mode 100644 drivers/net/ethernet/econet/qdma_desc.h
 create mode 100644 drivers/net/ethernet/econet/qdma_regs.h

-- 
2.39.5

