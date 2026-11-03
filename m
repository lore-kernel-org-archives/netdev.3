Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743367;
	b=bQGt0Xd0vo0YDD611n/p6UXmedPi2MkmcJdEioDwygf9fk3SG3qydzPgq9HXhLXO1JcK
	 OjNNJS9S54ZY7J6FxldCg7Z8T2dotGCGR0w75BOm2yZ8Os7ED4ITeGOjJC5Zop4Fl3hcB
	 i3gXSfdutj9lm+V70r3tN4jkTqmOPxa5qWljvEFi727X8L2SBSl7qerpw2c63RSs01wp7
	 fKOpfxdqK9sDevyQDJcd2ccNlekAjKGuoExTqXJFnRBQfzER2HHxGSsw0c3HAq2suZoXx
	 IuryQ+gglfYp0XET3tyTpbHLbYy8WLIYu0/dBFmd4gvqw6Bb4TpT5IvynP9Exqypi7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=pfTQZUhvMoygh95zUq+ELn8B+IYgyKM7Ym/tW4gbk48=;
	b=yRZPHwf32TxJc80ENSiZDrdNPNSONVO0hQsd2W0ILx6GtBAcPTS5ChB038Hm3ErZZvKq
	 hdZhA9faxL7GQUNg3LNT5FW6IA+0qhNp6XouZofa6JVSRxJd2v1QXiYMQTuTDblLIMMf+
	 32O/831DtduhB/c8nrdoA6+ly49S+/x958/xhMGZc2axJIm6vMvW5iN1PMP07pvkC6Cpu
	 dR2axlPWH61nb2/bcCsgYh5qTkVFe+qkgc5ds8JiUTlVVddtg3fwStwoH1GuMmlIWZq/n
	 2uygui3vKwX3ZV6n35OxChdrtEviKV/dSRD+WoiUBf+W9CT67yFEtqfQ6E73I0monbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=bOy7w88X;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2F606A33F;
	Tue,  3 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DB2F606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=bOy7w88X
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C908BE836CB;
	Tue, 03 Nov 2026 23:02:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793743359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfTQZUhvMoygh95zUq+ELn8B+IYgyKM7Ym/tW4gbk48=;
	b=bOy7w88XD6gDRz8r6X1QD2wkmTE0mBl0GLtvuChA8kK6B86yl83D/6xj0kjVRVTD6w/grp
	+0qlBFwdzF21zqmCfN154TzAtyf7fUO/SWZtD2FW4iXQm59tZDImxWyD/yC2hy8iV50k/x
	LxCQ17brLFl6dWxJKsWBApHMWnt4BWMk+xaOj9q7OJGx03i1darmHImnCf8NYEy3Qt4yxq
	TVHV/qF436/tubej0/XLuYkYmvqJjD0XJ1t+mRtZA5sg4H31ENKntMsgwJgCurPYu5WiTz
	/Of0rcKl8xVda4T3xHNpQFloA6PE4YyKgCFH8sqPzOxgYHIRcsWYUGCnK807XA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id DM58S3isSraI; Tue,  3 Nov 2026 23:02:39 +0100 (CET)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 03 Nov 2026 23:02:39 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v3 05/14] net: pse-pd: do not reach a freed PHY from the notification worker
Date: Tue,  3 Nov 2026 23:02:08 +0100
Message-ID: <20261103220217.1131971-6-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103220217.1131971-1-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The notification worker holds a reference on the pse_control, but not
on the PHY that psec->attached_phydev points to. If the PHY is removed
while the worker runs, the pse_control survives and the worker reads the
freed PHY. The same happens without a race when two PHYs share one PI:
attached_phydev keeps pointing at the first PHY after it is removed.

pse_control_put() unlinks and frees a pse_control under pse_list_mutex,
and phy_device_remove() calls it before the PHY is freed. So instead of
taking a reference, let the worker look the pse_control up and use
attached_phydev under pse_list_mutex. This nests pse_list_mutex inside
rtnl; nothing under pse_list_mutex takes rtnl.

For a PI shared by two PHYs there is no single netdev to report to, so
clear attached_phydev when a second PHY takes the pse_control, and warn.
Events for that PI are then no longer reported, even after one PHY goes
away. Failing the second PHY instead would fail its whole MDIO bus.

Triggered in QEMU (arm64, KASAN) with a test-only PSE controller:
removing a PHY while the worker waits for rtnl, and removing one of
two PHYs on a shared PI, both give

  BUG: KASAN: slab-use-after-free in pse_send_ntf_worker+0x2b0/0x2bc

With this patch both are gone.

Fixes: fc0e6db30941 ("net: pse-pd: Add support for reporting events")
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 44 ++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index eab7e25f2039..af9eb2979270 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -238,24 +238,22 @@ static int of_load_pse_pis(struct pse_controller_dev *pcdev)
  * @pcdev: a pointer to the PSE
  * @id: index of the PSE control
  *
- * Return: pse_control pointer or NULL. The device returned has had a
- *	   reference added and the pointer is safe until the user calls
- *	   pse_control_put() to indicate they have finished with it.
+ * Must be called with pse_list_mutex held. No reference is taken: the
+ * pointer is only valid until pse_list_mutex is released.
+ *
+ * Return: pse_control pointer or NULL.
  */
 static struct pse_control *
 pse_control_find_by_id(struct pse_controller_dev *pcdev, int id)
 {
 	struct pse_control *psec;
 
-	mutex_lock(&pse_list_mutex);
+	lockdep_assert_held(&pse_list_mutex);
+
 	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
-		if (psec->id == id) {
-			kref_get(&psec->refcnt);
-			mutex_unlock(&pse_list_mutex);
+		if (psec->id == id)
 			return psec;
-		}
 	}
-	mutex_unlock(&pse_list_mutex);
 	return NULL;
 }
 
@@ -268,6 +266,7 @@ pse_control_find_by_id(struct pse_controller_dev *pcdev, int id)
 static struct net_device *pse_control_get_netdev(struct pse_control *psec)
 {
 	ASSERT_RTNL();
+	lockdep_assert_held(&pse_list_mutex);
 
 	if (!psec || !psec->attached_phydev)
 		return NULL;
@@ -1015,13 +1014,23 @@ static void pse_send_ntf_worker(struct work_struct *work)
 		struct net_device *netdev;
 		struct pse_control *psec;
 
-		psec = pse_control_find_by_id(pcdev, ntf.id);
+		/* If attached_phydev is set, it names the only PHY that
+		 * holds this pse_control: a second PHY on the same PI
+		 * clears it in pse_control_get_internal(). That PHY's
+		 * pse_control_put() unlinks and frees the pse_control under
+		 * pse_list_mutex before the PHY itself can be freed. Holding
+		 * the mutex across the lookup and the attached_phydev
+		 * dereference therefore keeps the PHY alive, which a
+		 * reference on the pse_control alone would not.
+		 */
 		rtnl_lock();
+		mutex_lock(&pse_list_mutex);
+		psec = pse_control_find_by_id(pcdev, ntf.id);
 		netdev = pse_control_get_netdev(psec);
 		if (netdev)
 			ethnl_pse_send_ntf(netdev, ntf.notifs);
+		mutex_unlock(&pse_list_mutex);
 		rtnl_unlock();
-		pse_control_put(psec);
 	}
 }
 
@@ -1412,6 +1421,19 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 
 	list_for_each_entry(psec, &pcdev->pse_control_head, list) {
 		if (psec->id == index) {
+			/* attached_phydev can only name one PHY. If a second
+			 * one shares the PI, either may be removed first and
+			 * leave it pointing at a freed phy_device, so stop
+			 * reporting events for this PI instead.
+			 */
+			if (psec->attached_phydev &&
+			    psec->attached_phydev != phydev) {
+				dev_warn(pcdev->dev,
+					 "PI %u shared by several PHYs, not reporting its events\n",
+					 index);
+				psec->attached_phydev = NULL;
+			}
+
 			kref_get(&psec->refcnt);
 			return psec;
 		}
-- 
2.43.0

