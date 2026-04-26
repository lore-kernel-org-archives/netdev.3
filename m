Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0F4A0C
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240162; cv=none; b=dDpIv7kyAGBdstAZ4t6jPbTO93ZtoKSM/mYy0hs3g86jkCdpIRzczvfpQmr9YeXkCdeE3UBjTJbz8oFAIcd/LO03J5E7rw/qX0xMBbi/0upVxqdrlFSezqWH8pczlmWijhsh4CJsfA8oIjVPX6JFKnG6+5vnREBHapBNg1oTm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240162; c=relaxed/simple;
	bh=hqc/CK0y2YVF3dMMJiIgh0dUs3rUUbZBVUb0oTGFGbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3D79XhXA7nTla8CsUhatvmffkqWUYZM+x+KoYqCyMjVvMWzfavsghvLxtB4cZ63Vu1OWgK9xg1v662A7EFLlOLORVNIss/pbNp6/XGg3uHYUOt704VbEyf4dLQVQtKoFi7yfr8w2ba8R/LRfIC6nY/pOww93gPFR3InLcOyo4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=MzOhzEeX; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="MzOhzEeX"
Received: (wp-smtpd smtp.wp.pl 23436 invoked from network); 26 Apr 2026 23:49:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1777240151; bh=wNiG3vmaZvmJc/Ed24L3ke+xWsq9YoBhZy8VatvB0CY=;
          h=From:To:Cc:Subject;
          b=MzOhzEeX0WBcWZhX5JGkOt/ze9j2PrSpXwWk8+I6idbLvFY59mr/S0KAPo9IYd8eI
           5X3iDJzMR2ag+YP97YlWQN4S57HwM71TTnVS5rt60X4fdgajMCR2JJdXSbU1kxA6s9
           TUKYebkCYqzDvswpHHypuu2eylRQaY8dqjQ6l7G9empyiuQM9xBsZs9JkCvtXp9moE
           E5EihUC/hu7z/lZay+h+4hoxDOhsSlf/iP5c294toQPr/5VaVNLLTblK6MYSXeycUg
           0HnqVVcjyAT4hPY6RkA2hoOwQT1dDStY1Pj0UZAwp7fr/lhd7jNnbVxbk6PcsobdSn
           XD0C/O1ssB/5A==
Received: from 83.24.138.167.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.138.167])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew+netdev@lunn.ch>; 26 Apr 2026 23:49:11 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hayeswang@realtek.com,
	hsu.chih.kai@realtek.com,
	kees@kernel.org,
	mail@birger-koblitz.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
Date: Sun, 26 Apr 2026 23:49:00 +0200
Message-ID: <20260426214909.3426105-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 596669f7ac28c279c4a913887e3b90b9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8YMk]                               

The TRENDnet TUC-ET2G V2.0 is an RTL8156B based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 7337bf1b7d6a..1ace1d2398c9 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10138,6 +10138,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
+	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02c) },
 	{}
 };
 
-- 
2.53.0

