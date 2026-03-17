Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371937D131
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778971; cv=none; b=oCH/1tTVnUS/+WJ2nTwAnXKbiRG77waEy2ZCSUzs1BrjNJPh0qnsRDsQDcBZqUJeQ7Tf8Sz+KxNfhd7bnFQBdUa01n5Z4hCjt64aTqAeQMvYvTM2ksBsMN8vImOzhX2q4a0qvn3Gd6FMYJf7x+XEhausr5bAHPVOOn/EJVRla7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778971; c=relaxed/simple;
	bh=HiVVG/vNKLJEloYLCbzYvreoy9WJOYaL2h7Gk/KInhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8mpaZxR1DZmroOK+3wGnlRhyeR6Tn2bdpCTqELDmmZ8SHfZucupFc4Ti/MexjgAPHiC0OUcVROlR46eWBktQwGwFDPD6dmFbApUYDHN6CFxJXIiZU3ti50Vag1qJ0Nu/HEtbXvkyIGiA2uz69956WaPE9bEbN+BPZeJ2zYFy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=1AWIFe5K; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="1AWIFe5K"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 682B4A000A;
	Tue, 17 Mar 2026 21:22:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773778967; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=V7B7pNpsKtHSTOF1ITzQeUPmOGtJSu53Rrq8fzO4In8=;
	b=1AWIFe5KxcTSc2Igql4L5qFizdNVwzdRzTW0R/E8H8uGPd+dtldr9lvmPDE6YstjXFQ0yr
	vDCaMDiZO1g+KFBJdoBk97Uma5LHpyj7IPFo9jUhoBPB9n/8aIvg2j9d/1UE9TpmbUsDzm
	9Huz7jpMeASYnPSZE5SW/08Cp9rCizoOZahATSWVwoeU0uSrtyJW3lscnGyFApiiA0dSeg
	ykVEkJe7Rhx2FgqPk2yRG7ebGWqprUcgcY9MFwzE7IlxLOkz/rDKGf4+p6b1WLk/AYSOAu
	2dn/m5luAygXAfYc9yhGShcp5YJ36UNqKw/kLkUKQDpWEqGQktwCPysvrw1AGg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next] net: macb: propagate macb_open() failure in macb_set_ringparam()
Date: Tue, 17 Mar 2026 21:22:29 +0100
Message-ID: <20260317202229.193375-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

macb_set_ringparam() silently ignores macb_open() failure after
closing and reopening the interface, always returning 0. Propagate
the error so callers know the interface failed to come back up.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 83390dcc89e9..9957f5ae1752 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3754,7 +3754,7 @@ static int macb_set_ringparam(struct net_device *netdev,
 	bp->tx_ring_size = new_tx_size;
 
 	if (reset)
-		macb_open(bp->dev);
+		return macb_open(bp->dev);
 
 	return 0;
 }
-- 
2.51.0

