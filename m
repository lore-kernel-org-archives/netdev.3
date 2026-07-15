Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B23624C2
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146359; cv=none; b=sF0TEGAewXhluueUEhxI+SBTAUhgr/3M3jWhtwLOay/ss7nD0rh67+os9CxkAzhrTePNJ9mz262ZT68ws1QQsY8igO5vFXGjfv4GN2z86fnIBP0nDu1hHQnlv0QZiZ4/Q/D9SpMD61nHPtxuYx2TfCJupCtZRoahsB7OT1aX6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146359; c=relaxed/simple;
	bh=NEU0IPZL/pI02ZDJrDSUS3AZAlWSDRSodxbiU0Ch/Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZpnzF5rsuiMnmQeEEVkKU8JH8SvP9HxCQEgljsrJKiZak0CbER6lYp2ZRqdthjVol1Dim4ffwrTYCZDdOX07jDy4kg17zzlvUDIrViN+QTAcx9JD1cxVT6EPTTjunxcTFEwcCW5tYsh571N3nCDcrfgXUbKQTept6dvidVWegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PY/w8xO0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PY/w8xO0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 80D624E40DEB;
	Wed, 15 Jul 2026 20:12:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BCA76035C;
	Wed, 15 Jul 2026 20:12:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6547A11BD050A;
	Wed, 15 Jul 2026 22:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784146351; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KkARUnXsNW6sRxzZNVM/+JYilzPkvtrqJXeA6qHePxM=;
	b=PY/w8xO0Vt/zWGUooVDVn457pjGt17dK3kBwRbmsLszgDhBUy+nJDbNUPhDPYHkvRuNonW
	KQDHRJAdseaYAQMmzZOVjWI/3XRwgvEBO6vMpQRSFvpWL0dwAHY63S0NFcIIirslOrVTrq
	Rb50aunF73nSmy886SiM9Kc/urczpSd/3Oe5XrdGEd8+TJYQpf+dhgLEACJmSNerfzUbun
	fl+zayYtpgRmhipjk0QEhRVO/u5UA+NoaxewJnQAmT9aadng4nFTGPHmWxUog06vKU1vhS
	Eo9nOb7zKYP5OxB2jOJzHQkMNN5qiNSDqa76UMaM7daktVdOZBFaFKxnmyKMbQ==
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
Subject: [PATCH net-next] net: phy: drop duplicated header include in mdio-device
Date: Wed, 15 Jul 2026 22:12:12 +0200
Message-ID: <20260715201213.206180-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

During a tree-wide gpio include cleanup, the linux/gpio.h include was
replaced with linux/gpio/consumer.h.

mdio-device.c was already including that header, resulting in a
duplicated inclusion. Let's drop it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Yet another small cleanup while looking at bus-scan improvements. If I
find more I'll group them in a dedicated cleanup series, but I'll likely
not look at this stuff in the coming days so I might as well send this
one now, sorry for the low-value churn...

 drivers/net/phy/mdio_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index a18263d5bb02..06151f207134 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -9,7 +9,6 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-- 
2.55.0

