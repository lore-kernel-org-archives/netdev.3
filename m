Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516387;
	b=IYZEhE7P06TIrPrqq2rsEhlA19OHKsnZzv04eB4p7Bi0G0U/jfEafqXZMA2pfSvNcxTp
	 TwoQcMU5jqA156bPitFtubV8oKrtKZe9gCdV/GE0JEfIu9zLsbgNNUgO1UsYvI0JjrOeF
	 7yfaSePypEvLScj9qyiuAD+vrTRz1ATmuXmGtNkqS408jKHv8/a09yhYWpcMkGxouSBpe
	 ZdfyfczyFpljaB8baJFemlaQBF8yKg423NpigwAX2Wd9bKOO8+5m1jlyLg6NBEmzxNRMh
	 KL7Um/WoBryYjrcfC0PTrXKuFQgZrB7z8hDsbdNXjHHyF4WBJSA011+IhWB7E+/NnIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=i0B6FKQTqCem+z0psQ9tl4LqgOvKQwE8q+glxM8Gg0I=;
	b=YfoUVq6FYDlNSLV1M5h/0GCPidva1yQ2avJhXzExPkBCdREf/10YqOLob4XEemEsN0MF
	 ecVaaXnCuF9FUbLEAdpvMHhHhMIJZDh7cY2OTuotB+E8T9tHCBNRPjW+U2JFqvPb7ZlDm
	 h3e2I7REJ+Sy99JdCfXnMRAeGATXV5VyU6s/qJGpPBxesTdlrDyHcfFP7KmC7RXvDvm/T
	 Cs+iiPIc/SAMkZALYm9eY/r6hG5jDpmFX69Q8WTQfbpHz6slcru5gkkvep8VgYHt1TsBe
	 S60Ffjkr2nsLiKTTxnv73GQxptpy1v2o8kN+2/g1xyTkwXe8hUvEVphThV31VFJXakQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AIOZ3ymY;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682960A261A;
	Tue, 20 Oct 2026 17:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0682960A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=AIOZ3ymY
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id E6925E83374;
	Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792516384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0B6FKQTqCem+z0psQ9tl4LqgOvKQwE8q+glxM8Gg0I=;
	b=AIOZ3ymYhnoiH61VB0ViRJaE+hzCkNVpotGf2u97ZB5v2U7i/sb8WgcxKgt1BN+77AN7wN
	rCjsA/A0F/q7qcajyef8ksh5k2p4vh6JXIU4jFzbHQwejB0jXzKypvbO3sQ5ZDwIsom6zR
	pssBAkp2ZTw7TEXpXKM9xon7zj8l0YOCIafx+6NSD+UuvcnCVOjPHWuiF7DvV5qHXGOSHC
	0yzUTPmwe3UoWBlrxFN+l69dJLe3CPRVl74DW2IK5s5cXR3hwIsoTi5pdi7GzUHsH4Uh/I
	9+quU0ZwdT9yPNkgzJ6lDvaMLSkNr994jL9n1Iqu0brOCek4aK4+aunDu/4F1w==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id XhMsj1HP6odX; Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 19:13:04 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net v2 05/14] net: pse-pd: do not reach a freed PHY from the notification worker
Date: Tue, 20 Oct 2026 19:12:40 +0200
Message-ID: <20261020171249.853085-6-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020171249.853085-1-github@szelinsky.de>
References: <20261020171249.853085-1-github@szelinsky.de>
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

