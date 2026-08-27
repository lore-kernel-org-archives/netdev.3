Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764335C6B8;
	Thu, 27 Aug 2026 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813984; cv=none; b=PvMclEO5MTJEwiu1OyWjVUkZPF9mez6yTwXZD64x+uJcLrUiB2+9HzIb0h5DCfTUSh4zI9vcfno4jeuc7/i5WNfGrL7oWzKINiHZqKeA8MGY40cNptRXb4e5jaJD2ZZs1FmLLoPjzGLjUHBRRDLO4BxWthZmG75Fm+XmAxv8mAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813984; c=relaxed/simple;
	bh=q85oY80k5hsSieR/SCyJogggg1sMRP0wX8NPJZXv1Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=de1lcV1mZa3gMQiEkA6XCMydqWUi7l9J/NLrNKvULqIcsSTNh8BzixNV1Aol3rVVvOTxKO4JgEb0lpYXtNpcJN5SPbA4mvYGfRypApTCnIdpr+hOj2hliqzC0swNF03GGicdGjnpzoWkyKd+LL3SUPRkaWH6Heplv/tS4qtyM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=t+WEZruY; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="t+WEZruY"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67DD01EFEDE;
	Thu, 27 Aug 2026 08:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787813979; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5hwNQZbr35E51JRvfCspS2gfC+TaA8bCUWMUgPLAd9I=;
	b=t+WEZruYobiAY3S7wUFZHxdzgajpWmyyQVN75SxIPJqlnPDIwGU/MTOhGGlqkAqLWiZTXx
	Z1ggF8scMlV/znyEmVz4UD/bqABqQuNJEcBj1dA3z/gZXMM0iTrRQQeH5Cw1meuXn+BZ4b
	PjEC5XdYRZaAENS0Huji6JrTaNFpkW3mO8DdnVXL9++ALikQmDthaP69OV+8XwJbQgMtjY
	nFevjgIhI/JVq/fOmyQOaEvQrQGJA06TeOIlHucte1HsC3JZNwga7gKQQ7JuFEIqXooqpE
	kj1nVlhEEVlT5RBju2h5GQAvypzqDrembpICiwHvJHcnNTsPdi0ablHuJwmbEA==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	daniel@makrotopia.org,
	naseefkm@gmail.com,
	joey@tinyisr.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2 net-next 0/2] net: phy: mediatek: add driver for EcoNet Fast Ethernet SoC PHYs
Date: Thu, 27 Aug 2026 06:59:28 +0000
Message-Id: <20260827065930.2618729-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for 10/100 builtin SoC PHYs identified as 03a2.9414 or
03a2.9412.

Changes since v1:
* Include 03a2.9412 and differentiate from MTK_GPHY_ID_MT7530 by checking
gigabit support.
* Switch to for loops that are easier to read
* Add ECONET_RETRIES and explanation of calibration re-tries
* Better explain the "master" PHY which is needed for calibration
* Fix incorrect reverse christmas trees
* v1: https://lore.kernel.org/netdev/20260825180421.1804729-1-cjd@cjdns.fr/

Caleb James DeLisle (2):
  net: phy: mediatek: differentiate MT7530 GE PHY from EcoNet FE PHY
  net: phy: mediatek: add driver for EcoNet Fast Ethernet SoC PHYs

 MAINTAINERS                              |   6 +
 drivers/net/phy/mediatek/Kconfig         |  18 +
 drivers/net/phy/mediatek/Makefile        |   1 +
 drivers/net/phy/mediatek/econet-fe-soc.c | 672 +++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge.c        |  14 +
 5 files changed, 711 insertions(+)
 create mode 100644 drivers/net/phy/mediatek/econet-fe-soc.c

-- 
2.39.5

