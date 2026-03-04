Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BA3A9DA3
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621704; cv=none; b=MOJNN+TrTSto6vDst06wWo2zpeRLO+y0FBTJrutapTIUphE1iLnrCA9oaov4DPVa6RM3fVD/N/kuvw0gnb29GG20wDF3jeboS4m8MCHAyGJdq5uGCkcPKvvJc9I50+e1f1zRwyuVUrt0M+ldedC+Jig8Tu8zMzVLL3cnnCCR8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621704; c=relaxed/simple;
	bh=ztJ+QIXAnrCzfpHnYgFOKtfbzcPLI56oHFl8ou/EIto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOqPONGiUtwoV7MpBzF2vNjecwVjmlSXB1cKLDpxPnlnnYRbqY3CpuN33eQLVhLbtgrjwTKC85v5Cg6NxpAuqJEXlH9GZEK6XtWd90J+5QFtLJ+4Yv3G9KCur6STvMVU47tU3d/9Kz0sfcJC8HaaMKQ1+0qM+aRkMqSHTSuUxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vUwvXJw0; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="vUwvXJw0"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6605A5617;
	Wed,  4 Mar 2026 11:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1772621699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gVUxjZuvxm50Z8B2U31kIE9VFuknW2s9ZIqlu84Z5Lk=;
	b=vUwvXJw07rB6Fx++uJHtRkgikRC9Or2ta5dKQDUxjUTWSnwWmufvpRynVqUzzB80YpeNS2
	GwCvxLcT+x9g8u2BuBF0/c0YGCwHVJcGzm2hbgvorHzcjZox/QFwp5ArfGNOXNVOK74PA7
	0GcFGe/Nnnjmi5T19zfqxgRIFZXrmfRVfMSvC2W52v/0Wl9TMFSs5ZWHBk0yVelY3nIyH8
	j32bG7Y7tAEr0qFoFx3uggrwbPMn/4BGjmQVjUumQIz1jUJDl/uOB9wQqiMc5lKkhvAxf6
	f/b4H29wI1iUko2vZhr4fno1TKleDeMd4q4jj/KoTF6sqAC1luPGkhXHbmdFPQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	phil@raspberrypi.com,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v6 5/5] net: cadence: macb: enable EEE for Mobileye EyeQ5
Date: Wed,  4 Mar 2026 11:54:32 +0100
Message-ID: <20260304105432.631186-6-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304105432.631186-1-nb@tipi-net.de>
References: <20260304105432.631186-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Set MACB_CAPS_EEE for the Mobileye EyeQ5 GEM instance. EEE has been
verified on EyeQ5 hardware using a loopback setup with ethtool
--show-eee confirming EEE active on both ends at 100baseT/Full and
1000baseT/Full.

Tested-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5933a5042bc8..3dcae4d5f74c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5526,7 +5526,7 @@ static const struct macb_config versal_config = {
 static const struct macb_config eyeq5_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_NO_LSO,
+		MACB_CAPS_NO_LSO | MACB_CAPS_EEE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = eyeq5_init,
-- 
2.51.0

