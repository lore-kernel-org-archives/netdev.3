Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4433D51A;
	Thu,  4 Jun 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565309; cv=none; b=Qc00JJnFAGHCftB7gx3Tz+qNhq/b/yI9E5Wp0d4TGalmuVa7Lu/Ajksg94plVbJ5Z5OzhL3KFSgvvNJgQ79fstLsUPE+4u2grhYdg584tF1OTajcQGtwycvUJFxXm36qz4VHRA4u2JiKh7XlM2eTIq0D5AJUsuAawYTZNz/bQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565309; c=relaxed/simple;
	bh=4lcZmXXAIs5xCW0g8bp8hPpzij7y+vApybuIUh4gFy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNdqKion/t4kIR7dzl5rrYHIGopy/jdBFkc0u1naWvIIsKp76BPcwJ+5sGFnlnlPgACdgD8rcaFLMqDgU7E4HhkJSmg++cQVIEEelG4jhHQS92KDia/Gj600CBcCft1zLjWd66A6hqdyHK/4j/NLN7WEqY9fCorQgUTeg75kDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RnM6vwu9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RnM6vwu9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0A5EF1A0663;
	Thu,  4 Jun 2026 09:28:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1AB05FEF7;
	Thu,  4 Jun 2026 09:28:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5D05106A157A;
	Thu,  4 Jun 2026 11:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780565304; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9fk2Di8TzdytoF3ZfFdEtnPwG5rt6VhXi2K9+A9IUC4=;
	b=RnM6vwu9oyFvwfZxoLlJ7WQuSmATL8ZERNamCVeggaBMmZ6qY4p7wGDzv4CrDtmrZc5qsB
	Bm3LLOlSxxZa/U62TNly8KssrvtXwaNpprF3SjIQk3i1eLZQMOcSLEJujUd/stClEdU0CZ
	gHTR5dZ5u4TomjFbgJJ9IlDSEUSLuNtzP/ACnQBIMWlaDQljmrZqGyi3eIbw6Su16w0UVj
	yjsd67ukGqb5XP4klFhdLUmDx0XnbbkvnWoAzTAw4mnFE5a9sA6DxxoW1p8KB4K4XC2uWW
	i00kYBBoirAs4P6AsIrsjB/4Sc1Ot+RiwXxq3nLtcKaxyB1PrDT3n16Cu49V1g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net v3 0/4] net: phy: some cleanups following phy_port SFP
Date: Thu,  4 Jun 2026 11:28:14 +0200
Message-ID: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

While posting the v11 of phy_port netlink, sashiko found some
pre-existing issues, and following the tentative fix, Nicolai found
some more :)

This is V3, with a re-ordering of the port/sfp cleanup, as well as a new
patch (patch 3) that also reorders the phy_remove() path.

V3 :
 - Re-order port cleanup and sfp cleanup
 - patch 3 is new
 - Fix typo wich -> which
 - Add Nicolai's revies

V2 : https://lore.kernel.org/r/20260601084029.815461-1-maxime.chevallier@bootlin.com
 - Add port cleanup - Nicolai
 - Don't probe SFP for genphy drivers - sashiko

V1 : https://lore.kernel.org/r/20260530072706.3167745-1-maxime.chevallier@bootlin.com

Maxime Chevallier (4):
  net: phy: clean the sfp upstream if phy probing fails
  net: phy: remove phy ports upon probe failure
  net: phy: Clean the phy_ports after unregistering the downstream SFP
    bus
  net: phy: don't try to setup PHY-driven SFP cages when using genphy

 drivers/net/phy/phy_device.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.54.0

