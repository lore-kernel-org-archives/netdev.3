Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35037F736;
	Mon, 30 Mar 2026 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911154; cv=none; b=H8S6iiZvadbyOpPfOMv5z4SiZthIKe9RKuON7kT88gBV9CyTxVVF9VQtx/7vBMDFXdOKhI6x+518PNcfxZamelXf9DuX2e3sPaY9rEnCIrE9sDMl1c/Egn1I3JHEwcHeMTWnSxXIunmlhNEHdI50EdNvjISkzNW8d9tcrilVbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911154; c=relaxed/simple;
	bh=o8OyyX2grXJX0jlUdrhV0qM06ZvIoMA7c3HtCNj8Izg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CBUx1KvSV7LsqNXp1/cJ7OJaouNyjeoxySxHH8CRrvadYKQpdAE0GLnnlgKugI9M3faF7sEnyflOfG/GZO4PkCjQT4sBk1KNw84uSO1LiHRGdHB3WiWdwaxtgvghWFO5VEgG06lz4ot1ZPVVN/NIOlFgxEhyljw8l9iF0XHdmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w7LSv-000000000Zx-0Wfk;
	Mon, 30 Mar 2026 22:52:13 +0000
Date: Mon, 30 Mar 2026 23:52:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mxl862xx: cancel pending work on probe
 error
Message-ID: <3fd163f5bb88de426ca9847549f94b4296170ef0.1774911025.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Call mxl862xx_host_shutdown() in case dsa_register_switch() returns
an error, so any still pending crc_err_work get canceled.

Fixes: a319d0c8c8ce ("net: dsa: mxl862xx: add CRC for MDIO communication")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Note that this targets net-next despite having a Fixes:-tag because the
is still only in net-next.

 drivers/net/dsa/mxl862xx/mxl862xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index 78eef639628a0..af9b00b2d2c43 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -407,6 +407,7 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 	struct device *dev = &mdiodev->dev;
 	struct mxl862xx_priv *priv;
 	struct dsa_switch *ds;
+	int err;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -428,7 +429,11 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 
 	dev_set_drvdata(dev, ds);
 
-	return dsa_register_switch(ds);
+	err = dsa_register_switch(ds);
+	if (err)
+		mxl862xx_host_shutdown(priv);
+
+	return err;
 }
 
 static void mxl862xx_remove(struct mdio_device *mdiodev)
-- 
2.53.0
