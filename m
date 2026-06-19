Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4724B28;
	Fri, 19 Jun 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781840422; cv=none; b=UsAK9xlWkOMP+XCkz4Dp77ds88mDbmIAPlRBRd4QE60xRtD40aTpuTnPZqTpOt/Bwe0/xo77ZAnfKn74NwM9wsUpNoFtvv1wDWNzr7AuyP8Kah1IDfK0mVdklqbshOrFUBsVmCOvcR0lpqOKb9aGhYw6KBFYKDqGgdvVuI9xtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781840422; c=relaxed/simple;
	bh=qMaEb/1jDyJe911fDcHgr8aVGZxyFXF2kI2bsFCdAyE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tzQa32ngDgAgDM7M/JpNBZUtS9n+q4muOL89Y6har10sN2YmGuu8+WCuhXpyOHFsdRg16IXfBj2p+O7m2jE3cDAj2m8XcJcRyeZOviWyhvM6+EOzoV1E9s8gysjtzYjmj9FdQsPtOzW4TbrPPIvAQxtpih4jfuMJfAn4uhkGu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1waQ5Z-0000000013b-0Wvt;
	Fri, 19 Jun 2026 03:40:17 +0000
Date: Fri, 19 Jun 2026 04:40:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: mxl862xx: fix use-after-free of DSA ports
 in crc_err_work
Message-ID: <5e55169926c02f2b914e5ada529d7453b943cda4.1781702256.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Upon an MDIO CRC error mxl862xx_crc_err_work_fn() walks the DSA ports
and closes the CPU port conduits:

	dsa_switch_for_each_cpu_port(dp, priv->ds)
		dev_close(dp->conduit);

mxl862xx_remove() unregisters the switch before cancelling this work:

	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
	cancel_delayed_work_sync(&priv->stats_work);
	dsa_unregister_switch(ds);
	mxl862xx_host_shutdown(priv);

dsa_unregister_switch() frees the dsa_port objects. If a CRC error
schedules the work during teardown it can run after the ports have been
freed and dereference freed memory.

Guard the port walk with MXL862XX_FLAG_WORK_STOPPED, which is already set
before dsa_unregister_switch(). DSA tears the ports down under
rtnl_lock(), so checking the flag under rtnl_lock() means the work either
runs before teardown and sees valid ports, or runs afterwards, observes
the flag and skips the walk. This mirrors the host_flood_work handler,
which skips torn-down ports under rtnl_lock().

Link: https://sashiko.dev/#/patchset/cover.1780968180.git.daniel%40makrotopia.org?part=2
Fixes: a319d0c8c8ce ("net: dsa: mxl862xx: add CRC for MDIO communication")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 882c5d960941..4acd216f7cc0 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -41,12 +41,13 @@ static void mxl862xx_crc_err_work_fn(struct work_struct *work)
 						  crc_err_work);
 	struct dsa_port *dp;
 
-	dev_warn(&priv->mdiodev->dev,
-		 "MDIO CRC error detected, shutting down all ports\n");
-
 	rtnl_lock();
-	dsa_switch_for_each_cpu_port(dp, priv->ds)
-		dev_close(dp->conduit);
+	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags)) {
+		dev_warn(&priv->mdiodev->dev,
+			 "MDIO CRC error detected, shutting down all ports\n");
+		dsa_switch_for_each_cpu_port(dp, priv->ds)
+			dev_close(dp->conduit);
+	}
 	rtnl_unlock();
 
 	clear_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags);
-- 
2.54.0
