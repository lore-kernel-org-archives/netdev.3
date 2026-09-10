Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568E480DD4;
	Thu, 10 Sep 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046012; cv=none; b=cBTaBGbC2lbVhuNURxbZnsJPBdSdhZssM3sF7LWWNT2uuT47vEgbK1kaaUXkvD4Okwzxrca+musf/sTFO/yEBBDcRLQ5P+v79J82G1Iqn79XnXfbnaZEI1f06JMBka1Y8Ewf4BBvTJyGk+7cri4H0316GXPvfPQHm8urAFliJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046012; c=relaxed/simple;
	bh=hVg09I8YPb2nnYME/KJNCMWeRMZLNHy3ZsWJ1cBkN/E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d+RNdVMdiCmIAVfjZXNXiadLEd9c2POX4Yc5u2iseDnc3a9uh02qdYJvK+5Cm9LpaBQFvG/2rQxB6J4WZJK2/3SZuueR/zyGFyg7wVTI0ooM6Vxohz5h5qQ7bC+5eN3IRC06Tmt4MscCy+IN8Qomh625wNk7A5tiNwGobUElv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100)
	(envelope-from <daniel@makrotopia.org>)
	id 1x4eah-000000001ao-1b0W;
	Thu, 10 Sep 2026 13:13:23 +0000
Date: Thu, 10 Sep 2026 14:13:15 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: dsa: mxl862xx: disable the stats poll on teardown
Message-ID: <1eb6f7fc1789b67e4b11e3f4d5ff080d0b6f7cbb.1789045590.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

mxl862xx_setup() arms the stats poll before mxl862xx_setup_mdio(), and
nothing stops it until dsa_register_switch() has returned an error to
mxl862xx_probe(). DSA frees the dsa_port list before it returns, so a
poll that fires once .setup or a later step of dsa_tree_setup() has
failed walks freed ports. On shutdown the user ports stay registered,
and the WORK_STOPPED flag test in mxl862xx_get_stats64() is not atomic
with the cancel in mxl862xx_shutdown(), so a re-arm that read the flag
before it was set queues the poll after cancel_delayed_work_sync() has
returned.

Arm the poll once .setup has succeeded and stop it from a .teardown op,
which DSA calls on unregister and after a failed registration, in both
cases before it frees the ports. Use disable_delayed_work_sync() there
and in shutdown(): it drains a running poll as the cancel did and turns
every later attempt to queue the work into a no-op, so the re-arm
cannot bring the poll back. remove() and the probe error path only set
WORK_STOPPED, which crc_err_work tests before it walks the ports.

Fixes: a21d33a5265f ("net: dsa: mxl862xx: implement .get_stats64")
Assisted-by: LLM
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2:
 - arm the poll after .setup has succeeded and stop it from .teardown,
   before DSA frees the ports when registration fails (found by Sashiko
   AI review; Paolo Abeni suggested addressing it in the same patch)
 - the changelog names the get_stats64() re-arm as the one enqueue that
   can land after the cancel, as cancel_delayed_work_sync() keeps the
   work disabled while the poll's own re-arm runs (found by Sashiko AI
   review)
 - the comment above the get_stats64() re-arm keeps only its purpose
   (found by Sashiko AI review)

v1: https://lore.kernel.org/all/8b861014c836377afab0fdfb66a83fa017e5cd84.1788779062.git.daniel@makrotopia.org/

 drivers/net/dsa/mxl862xx/mxl862xx.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index cfa7e3e269a2..e05ad52cd297 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -685,10 +685,22 @@ static int mxl862xx_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	ret = mxl862xx_setup_mdio(ds);
+	if (ret)
+		return ret;
+
 	schedule_delayed_work(&priv->stats_work,
 			      MXL862XX_STATS_POLL_INTERVAL);
 
-	return mxl862xx_setup_mdio(ds);
+	return 0;
+}
+
+static void mxl862xx_teardown(struct dsa_switch *ds)
+{
+	struct mxl862xx_priv *priv = ds->priv;
+
+	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
+	disable_delayed_work_sync(&priv->stats_work);
 }
 
 static int mxl862xx_port_state(struct dsa_switch *ds, int port, bool enable)
@@ -2047,9 +2059,7 @@ static void mxl862xx_get_stats64(struct dsa_switch *ds, int port,
 
 	spin_unlock_bh(&priv->ports[port].stats_lock);
 
-	/* Trigger a fresh poll so the next read sees up-to-date counters.
-	 * No-op if the work is already pending, running, or teardown started.
-	 */
+	/* Trigger a fresh poll so the next read sees up-to-date counters. */
 	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
 		schedule_delayed_work(&priv->stats_work, 0);
 }
@@ -2057,6 +2067,7 @@ static void mxl862xx_get_stats64(struct dsa_switch *ds, int port,
 static const struct dsa_switch_ops mxl862xx_switch_ops = {
 	.get_tag_protocol = mxl862xx_get_tag_protocol,
 	.setup = mxl862xx_setup,
+	.teardown = mxl862xx_teardown,
 	.port_setup = mxl862xx_port_setup,
 	.port_teardown = mxl862xx_port_teardown,
 	.phylink_get_caps = mxl862xx_phylink_get_caps,
@@ -2131,7 +2142,6 @@ static int mxl862xx_probe(struct mdio_device *mdiodev)
 	err = dsa_register_switch(ds);
 	if (err) {
 		set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-		cancel_delayed_work_sync(&priv->stats_work);
 		mxl862xx_host_shutdown(priv);
 		for (i = 0; i < MXL862XX_MAX_PORTS; i++)
 			cancel_work_sync(&priv->ports[i].host_flood_work);
@@ -2152,7 +2162,6 @@ static void mxl862xx_remove(struct mdio_device *mdiodev)
 	priv = ds->priv;
 
 	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-	cancel_delayed_work_sync(&priv->stats_work);
 
 	dsa_unregister_switch(ds);
 
@@ -2181,7 +2190,7 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
 	dsa_switch_shutdown(ds);
 
 	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
-	cancel_delayed_work_sync(&priv->stats_work);
+	disable_delayed_work_sync(&priv->stats_work);
 
 	mxl862xx_host_shutdown(priv);
 

base-commit: 7addb4e5ef1702704914b47bca3f706ef96c1589
-- 
2.55.0
