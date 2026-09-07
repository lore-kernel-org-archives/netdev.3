Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0538D01E;
	Mon,  7 Sep 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781221; cv=none; b=Hhy3va2lMXIMjMqrf8B4fDyXjn8sddG0ZUFs1QKbeTBTzZBgYSkuyyxbczyp9WIHbL0+jvhT/tHVCq2JV65UEoauNNiIvNaizTkVl/3Z1T7jEbuUtzcTcBrqDXQvvpgSuu4wHfdfFfuChD/rYqKprOP0YUk0LP/0Ysg5TztR2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781221; c=relaxed/simple;
	bh=tltbt1A3Nc5D17pIot5qXqiTroidEzrGrcV64s1B+U4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fYY5YVxTTw8t01Pe8QCDq96t1NBwxjNYlwvSe9DYvs1OklHQL1XnfwSBlW586+WJya/FXACxkzNagUwGUnj7oynKZ6axCvXPoLhZe1M3JX9x2Cf0EaXBeRPpCavY/E3PHyn3+CJ/XrIZUnI3CF6Essa8qCdGoJsGRa29RjnHa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x3Xhm-000000002Os-4BZl;
	Mon, 07 Sep 2026 11:40:07 +0000
Date: Mon, 7 Sep 2026 12:40:00 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: mxl862xx: disable the stats poll on teardown
Message-ID: <8b861014c836377afab0fdfb66a83fa017e5cd84.1788779062.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The WORK_STOPPED flag test in mxl862xx_get_stats64() and in the stats
poll's own re-arm is not atomic with the cancel in remove(), shutdown()
and the probe error path. A re-arm that read the flag before it was set
queues the work after cancel_delayed_work_sync() has returned, and the
poll then walks the port list while dsa_unregister_switch() frees it, or
runs against the devres-freed priv once remove() has returned.

Disable the work instead of cancelling it. disable_delayed_work_sync()
drains a running poll just as the cancel did, and every later attempt to
queue the work is a no-op, so neither re-arm can bring the poll back.

Fixes: a21d33a5265f ("net: dsa: mxl862xx: implement .get_stats64")
Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Found by the Sashiko AI reviews of v11 and v12 of the mxl862xx devlink
flash series, where a first attempt to close this race by reordering
remove() only moved the window.

---
 drivers/net/dsa/mxl862xx/mxl862xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index cfa7e3e269a2..a31ebbe451e0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -2131,7 +2131,7 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 	err = dsa_register_switch(ds);
 	if (err) {
 		set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-		cancel_delayed_work_sync(&priv->stats_work);
+		disable_delayed_work_sync(&priv->stats_work);
 		mxl862xx_host_shutdown(priv);
 		for (i = 0; i < MXL862XX_MAX_PORTS; i++)
 			cancel_work_sync(&priv->ports[i].host_flood_work);
@@ -2152,7 +2152,7 @@ static void mxl862xx_remove(struct mdio_device *mdiodev)
 	priv = ds->priv;
 
 	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-	cancel_delayed_work_sync(&priv->stats_work);
+	disable_delayed_work_sync(&priv->stats_work);
 
 	dsa_unregister_switch(ds);
 
@@ -2181,7 +2181,7 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 	dsa_switch_shutdown(ds);
 
 	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-	cancel_delayed_work_sync(&priv->stats_work);
+	disable_delayed_work_sync(&priv->stats_work);
 
 	mxl862xx_host_shutdown(priv);
 

base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
-- 
2.55.0
