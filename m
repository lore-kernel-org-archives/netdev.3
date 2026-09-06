Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC034B1A3;
	Sun,  6 Sep 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788708715; cv=none; b=EAaqli9G3Qc20yoWMMREDylAF4r2GSxAEqYrFPaBDn8HdQxr3aU0ImokHPWyxhkbxcyKhTpo1OQsFhcpL1I0dgdzVFXNMjbUNYBRFLxwKpDELEUeeR8e4L6lKWbla/ecYGdlIDL4t3J5fQunLqEfCYuQnhaFGRQeVeitXBGg1BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788708715; c=relaxed/simple;
	bh=qszTxD9hwOH6ZwSU8LuqVb0fQe6/Uose6JALSkNvyeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jN6b+3gnXjrbDNGHUSP4quPyi1WmoBW6PAm37xXTGqROuESPh0ycy3bqzcEwqcZ1juaVUE8djjVXUPerj29hcHCEW+dppAXHi6onn4rYF4jMmPdY1dIEeervgwGJTdqYLE10FQ/B+fT7Fcf+nmZrXmfUIiBbl0GNm3Vz+4UNJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=i9gAS3LB; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="i9gAS3LB"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 5F0D3E83952;
	Sun, 06 Sep 2026 17:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1788708710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnrgME3345SjzlmVa4gF5D1UU17DNJls4cjw0wkDHcA=;
	b=i9gAS3LBsMkJDm+X/sIwgkcWRpR8k5x44f3eABbR9drZIHEh4E5qcT/3etK+F9CjDUW2I0
	OZrPGOh9D125sGEZdFMoXmE8cmUvpRyvWvcUtvZVLrrDoKuSsGhmGC+gWqcGEBU2RJLftB
	/jNxjCjShZoC6Kd8asmJscThA0qftKhidKOCBmouxU3STc+0MT6XoeOV+Ilz8AMRm9gjIg
	M9VdfGm0xXTCbKceG9+Jp9JQZVbfdcIjwmeiz4+0W2NYsLheraKS1d2jUIP8i3CrYAo09h
	hV5oe1P0ew+VPYowESAZpm5nKjLQy++0tJFNcIcxhJfGosiG7CrttID591isBg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 7vc8dVwUbajL; Sun,  6 Sep 2026 17:31:50 +0200 (CEST)
Received: from p14sgen5.lan (p578611d6.dip0.t-ipconnect.de [87.134.17.214])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 06 Sep 2026 17:31:49 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v6 5/5] net: phy: release phydev->psec from phy_device_remove() again
Date: Sun,  6 Sep 2026 17:31:02 +0200
Message-ID: <20260906153102.959217-6-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260906153102.959217-1-github@szelinsky.de>
References: <20260906153102.959217-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
hook" deferred the final pse_control_put() of phydev->psec from
phy_device_remove() to phy_device_release(), so it would run only after
the PSE_UNREGISTERED notifier walk had dropped its bus-iterator reference
on the phy. But bus_for_each_dev() only reaches phys still on the
mdio_bus_type klist: a phy that has been device_del()'d yet is still
pinned (e.g. by an attached netdev) is invisible to the walk, so
phy_pse_detach_one() never clears its phydev->psec. Its deferred put then
runs after pse_controller_unregister() -> pse_release_pis() has freed
pcdev->pi[], and __pse_control_release() dereferences the freed array:
use-after-free.

Put phydev->psec back in phy_device_remove(), before device_del(), so
the detach is synchronous and ordered ahead of the phy leaving the bus;
it can no longer outlive the PSE controller. "net: phy: use a dedicated
mutex instead of rtnl for PSE control attach" replaced rtnl with
pse_phy_lock() for the attach/detach, so this put can take that same lock
without the rtnl recursion that originally motivated the deferral, and it
serialises against the notifier walk: whichever runs first clears
phydev->psec, the other sees NULL.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/phy/phy_device.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index e8d894bbfa7a..bb120045c406 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -223,19 +223,8 @@ static void phy_mdio_device_free(struct mdio_device *mdiodev)
 
 static void phy_device_release(struct device *dev)
 {
-	struct phy_device *phydev = to_phy_device(dev);
-
-	/* bus_for_each_dev() holds get_device() across each iteration
-	 * step, deferring this release callback until any in-flight PSE
-	 * notifier walk has advanced past this phy. pse_control_put()
-	 * takes pse_list_mutex, so this path must run in sleepable
-	 * context.
-	 */
-	might_sleep();
-	pse_control_put(phydev->psec);
-
 	fwnode_handle_put(dev->fwnode);
-	kfree(phydev);
+	kfree(to_phy_device(dev));
 }
 
 static void phy_mdio_device_remove(struct mdio_device *mdiodev)
@@ -1265,6 +1254,16 @@ EXPORT_SYMBOL(phy_device_register);
 void phy_device_remove(struct phy_device *phydev)
 {
 	unregister_mii_timestamper(phydev->mii_ts);
+
+	/* Detach synchronously, before the phy leaves the bus, so the put cannot
+	 * outlive the PSE controller (an off-bus but still-pinned phy is missed by
+	 * the PSE_UNREGISTERED walk). pse_phy_lock() serialises against that walk.
+	 */
+	pse_phy_lock();
+	pse_control_put(phydev->psec);
+	phydev->psec = NULL;
+	pse_phy_unlock();
+
 	device_del(&phydev->mdio.dev);
 
 	/* Assert the reset signal */
-- 
2.43.0

