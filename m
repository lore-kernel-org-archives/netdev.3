Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71E39524E;
	Mon,  7 Sep 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815394; cv=none; b=WVc2tekr3ZPb4Iw2UC+XGxt6upjciGInKoYpb33cTKC4PwQIHvfKTW9Y8wiCCJ0EyRSFv9qs2y/7U3JFgaJoofqsdaj7ydr8499RGcuQ++tqB1n4YRNyXfnomM4mD1zqsFWX0N5rcmvvfq5OEQ93ChK62WpSO7BcJpOgiakkr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815394; c=relaxed/simple;
	bh=a7YW5hjZh0TwOLgIvOZqet/j8ia0E5sW4qQD/ASq7yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpm0w2hy4MWy7EYUrk9XXCG1F7xJb9LcgBe8qNSUgNUj2oDrwzjkcxCoytedXyyNO+GcfPncxSWhZLlfunXO5RjeRrUs0MY6ZjHScHewEgzPswLPOWov517mPdfA6HV4EuJrK3mH0aO/CxuVy8G6Bw6TUbuZKy7mJG8sizMpTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YNlPjlF3; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YNlPjlF3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8DA6A9062;
	Mon,  7 Sep 2026 23:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788815381; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rOA2BdjPpZaSYssObVM1j9wz484oV9GgefpfGULJRvQ=;
	b=YNlPjlF33l+4IElz/mze1Eu9LtctOkRi8akU4QdYNrLdL7xF1JFm9/JnK1+kZZkHHy+//n
	X4rUYVafpr8xzNO2SFNx6Tj/eOX5nxnjeyMbDlGwsh2uFvbX9OKF65K7B/pTKjnmzMlgjI
	EQh2+ih2XHWJoHzuDf7c+iJWGGSQeIAjSAENsd9i6xr7KZ24sruOLmctB54OSTu2Qc3rjg
	iqX6ZdC1y3ht7ICG506sCnNFsMXHVb30zPr3BZCBpQQSIyMQokQlS+W+1/wK5YowS+RyNV
	cctD0L9ZF/KiuwZP1VfEtWQnv7AU1t7pLT3uz4e1nbZTjPLwduIUq9PrBhlSwA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	atenart@kernel.org,
	o.rempel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 1/2] net: macb: destroy the phylink instance on the probe error path
Date: Mon,  7 Sep 2026 23:08:55 +0200
Message-ID: <20260907210856.1673589-2-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907210856.1673589-1-nb@tipi-net.de>
References: <20260907210856.1673589-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

macb_mii_init() creates a phylink instance on both of its success paths,
but the probe unwind frees the netdev without destroying it, so a failing
macb_alloc_tieoff() or register_netdev() leaks the instance.

Destroy it at err_out_unregister_mdio, which is only reachable once
macb_mii_init() has succeeded, so bp->phylink is valid there.

Fixes: 7897b071ac3b ("net: macb: convert to phylink")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8469df0d89c3..bba7246e1dbd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5980,6 +5980,7 @@ static int macb_probe(struct platform_device *pdev)
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 	}
+	phylink_destroy(bp->phylink);
 
 err_out_phy_exit:
 	phy_exit(bp->phy);
-- 
2.53.0

