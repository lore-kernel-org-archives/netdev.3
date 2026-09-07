Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8553EC83D;
	Mon,  7 Sep 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815394; cv=none; b=o/GeW/SKHZ/j5RwKtLPH8kpCpX50iubmK6sAlz9GSrRorlqtH5xA0gQUWaM1ZAXpWvo9v++N7Lzmcd/Ykr9+jZK4NhQNB8/ZmZzbDVJh0iwoxI1zHlgWQL0Vufm31+8e/zMusWKi9ACWHFbgrPezbu7CAm1gFaTqlOlVzSW7jNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815394; c=relaxed/simple;
	bh=Gtole8bpHJlN9kBgzU1UFFrRwCjYwTjo7ZyLnzUSuZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY6t9o7QFdNRFn5ps+J3x7OwXVuZKGZddiKXFgX1HweK268oJ5WzggoT0Ko+g43xlVB/aby/hWKKJ7xHMVPTVHC6xKxCiJ2+ZIb+cdDKzGchLRFxofjnyQy66Tw9hhF9z0tSNhwD3zCPa7I2s8MaU3SG+kyeUxMA7foDoqRDZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=rM8Z2QJQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="rM8Z2QJQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F943A9063;
	Mon,  7 Sep 2026 23:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788815382; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Oua79dA4L0N4jwd8kW5LCvsL72Y/KchIsEBtlJfQiWw=;
	b=rM8Z2QJQ9GFupdHMwuOegWLNZ2GZSiCNgLuQ2Vd9LezS0XPy86W1Gr4ka2OAMP33XBhnRz
	kjepYfKqU0jfYGP+Nl7C8L5IqU5BBJlNGskhVhpD8V9HTEeHUbjQZ3KZo2Im3gMsWHWzCy
	nbA7zYUtcfR6joQKALJDEdyowOhZeQ2zA4OlN//iAkONQbFg2Tg6FoAyWj871llM/fQaKz
	gv80xi+Ubk4JTZ662CKfLmd6WljVIQZ/XND7KErfPPnQAstiA0usnYKZtRmS7JRA8KIZYu
	beZlftxMYVcx3sqlNg+5EMjXNyaaKaVhntSgq7eW9+eG1bVspv2FhFRI8TSMLg==
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
Subject: [PATCH net 2/2] net: macb: put the "mdio" child node reference on success
Date: Mon,  7 Sep 2026 23:08:56 +0200
Message-ID: <20260907210856.1673589-3-nb@tipi-net.de>
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

macb_mii_init() holds the reference returned by of_get_child_by_name()
for macb_mdiobus_register() and drops it only on the error paths, so
every successful probe leaks a node reference. On a CM5, overlay
removal after four bind cycles reports

  OF: ERROR: memory leak, expected refcount 1 instead of 5

Drop the reference after registration, where __mdiobus_register() has
already taken its own for the lifetime of the bus.

Fixes: 8a6631f1cece ("net: macb: avoid redundant lookup for "mdio" child node in MDIO setup")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index bba7246e1dbd..b1dc5840d756 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1164,6 +1164,8 @@ static int macb_mii_init(struct macb *bp)
 	if (err)
 		goto err_out_unregister_bus;
 
+	of_node_put(mdio_np);
+
 	return 0;
 
 err_out_unregister_bus:
-- 
2.53.0

