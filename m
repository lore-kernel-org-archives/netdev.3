Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CB3CCFB2
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103762; cv=none; b=QuBGdHSppzyz61tAP0MVr/yqPh1CC9icjrhY1ht1U5iPsTnCBvFU4NQoM245CeFpPEKqAVY7lFGRawXpYCqoFc71Y+sa+3fkYctSG19Os4bw0Bv7jppMxQx674ELoDIn7V+hp8R183JIczBpaN/a+WRET3Uk3MFt8rq3sYhZ3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103762; c=relaxed/simple;
	bh=ktFuO0K4BRMufBgCFW3FSyjKmoVlq4Oy0HKNqgrR3BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kz/TC9jOF1pNiy6+axhMV5A9lgC/V6Z2vNNSbcT7SDhs98Ke8SZFzekBjrjUWa5FGI3Qx0FYq5LA3+MDnm2uCLdAuNqfb0ZTpvPGw1gAJjBTvv+I/a+ex58XIoRHB8H4VtqfWEBcFsuZmkCvzpNE01DE8z3cFzIO9JEv23ujgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ooop0d2Q; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ooop0d2Q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 335A61A0FF6
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:22:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 082706035C;
	Wed, 15 Jul 2026 08:22:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4BB811BD3BAB;
	Wed, 15 Jul 2026 10:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784103758; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lVSXTHPA9BCVBWuL1VniyMxTovKtTzksJP/weX52iX4=;
	b=ooop0d2Q+wZxQuwl2TR3SzlhtkyNKroQmERJXWbjoeB+EycW3v4utnQl6DUd86XLv0FR50
	+hHiD5Y6ZXturXjqb3ZqtBDnSuRh+GJX39ip9nOx1fuMiviW1TDnPyWJfpN7/4pyFuMzJP
	GR4XKG8nkpwUwCze3VEbQr6mhNZRF3CMHSs5TAY9tk4mK7b28Cb9s6Ftsd5lwFwmV+4KwR
	n8d3QAdmzER+k+ltR0xMTfEwhfLeAs1OOkKrK8C2kjyu9e9s6E2cEg17QKapFWc9SrN3G7
	qgOr9RrTsuNkBJlK2KNr9wfPYFDteGMEsr3FsXIQaMDcDtJMEKHprbR/jcUnKQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 2/2] net: mdio: Kconfig: Group mdio multiplexers in a submenu
Date: Wed, 15 Jul 2026 10:22:25 +0200
Message-ID: <20260715082226.51481-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
References: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Move all MDIO muxes under the "MDIO controller drivers" submenu.

This doesn't change any dependency for KConfig options and is
purely cosmetic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/mdio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index b845f1c17843..a05229838cb4 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -199,7 +199,7 @@ config MDIO_THUNDER
 	  ThunderX SoCs when the MDIO bus device appears as a PCI
 	  device.
 
-comment "MDIO Multiplexers"
+menu "MDIO Multiplexers"
 
 config MDIO_BUS_MUX
 	tristate
@@ -290,3 +290,4 @@ config MDIO_BUS_MUX_MMIOREG
 	  Currently, only 8/16/32 bits registers are supported.
 
 endmenu
+endmenu
-- 
2.55.0

