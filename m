Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0343644A4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103761; cv=none; b=hWRL7u4pddp2Y0lJMsQxLNcwXQ6tmjeuBvBkl/jbqTnlE+nw177Xy5NeIYMCd0cFmAZ49eKVrkOy+f+QN0G83iuMfqvAP8nc1NNu+vB1wHiQk/LdO59LvajzTxUaESbtezmLFzhVn19suyDZBWUDRtB2f2tRf+5UGmAgp4h0QI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103761; c=relaxed/simple;
	bh=9YK74OMuQiXNj33zdk7QfZsvxeMUHOPJx7WC/OWjphg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bkv/TIleONBufrub+0pfcxvsm4hlH9h3xUSD8HZn0Cx3lZnqdr9ocs0hyYXRfS7pLliyfUWwln83B6dAvQan9FnHXFUgCSo/j0ALQTUg+kyg32GFRIpvzSCt/tE9j/GOBuYeWsRQ9kd0Y+/cWIF+ohC+TpfH/N4qxnu5uCDl4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NvM3t5gr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NvM3t5gr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1DBB04E40DC8;
	Wed, 15 Jul 2026 08:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6CA66035C;
	Wed, 15 Jul 2026 08:22:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA34B11BD3B92;
	Wed, 15 Jul 2026 10:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784103756; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aKJHnvHKwGCjOMlr7Xx+YG00VQLcEkHWleH86LDTmu0=;
	b=NvM3t5griK3ozXCxJdU42MGYXwMereDOPvBMg1h+KUkZ2vjhG4di137sONpw/6OlaB5yt6
	GI50w3nmSuuPdzkO6p+A0aWm1FrzgqBfdj/LHl/Zx4aRp+8IVEuHYxYkSpDEQf9Nu9ww9d
	REZGJX9FIV/MXG1fPv0VnNgMTm1+j2Ty27fmT8qMO6hF/8a7xXaKX6y7qAsUvVN1wo73dF
	HpjrdGur6cD+9uP1ldeO7XcvcmZbRMx2EMNu3jZlITKSzNjhs6c5SojzHnM6xZBGJOk4b9
	9asgIdkGmna539iyGZ3QZQ6jh9viyzEtYjj/Ei18Dzu4iv6/8V22hbdURYtfjw==
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
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next v2 1/2] net: mdio: Kconfig: Group mdio controller drivers in a submenu
Date: Wed, 15 Jul 2026 10:22:24 +0200
Message-ID: <20260715082226.51481-2-maxime.chevallier@bootlin.com>
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

Currently, all inidivual drivers for MDIO bus controllers are directly
listed under Device drivers -> Network device support. Let's group them
altogether in a submenu, while keeping the dependency on PHYLIB.

No intended functional change besides the menuconfig ordering.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/mdio/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index e57121019153..b845f1c17843 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -3,7 +3,8 @@
 # MDIO Layer Configuration
 #
 
-if PHYLIB
+menu "MDIO controller drivers"
+	depends on PHYLIB
 
 config FWNODE_MDIO
 	def_tristate (ACPI || OF) || COMPILE_TEST
@@ -288,5 +289,4 @@ config MDIO_BUS_MUX_MMIOREG
 
 	  Currently, only 8/16/32 bits registers are supported.
 
-
-endif
+endmenu
-- 
2.55.0

