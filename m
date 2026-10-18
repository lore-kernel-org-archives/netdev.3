Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BD44C65C;
	Sun, 18 Oct 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311812; cv=none; b=a/NKvTeY7TijCMohi6nmm7FUWHLa0nQVdHQyJi4hvif7hhro1l6cXd1eTf4HRdmlkYerhbA6OtGmdEOjdUhcogZlbrCaTAS+T2zJamSlFjJ9xL+KgjFGv48aSnPgAEnf5h9R7M7wDQUI6YxjCy8mwzvjOR0fhf2cc2dADRijdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311812; c=relaxed/simple;
	bh=vpFRz9H9DErjcP/Ow9slPCX9jKa1X1nWSAqsvJW1AsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuAkn8otIVZB9H+0IQe0dTgPdLMgOAbXy1JCdcGiN/bVBkaTK0esgg/s6y2j5yiyeIl7NdLnuMT+Zt1j9zx8XaYhxRDEtn8Z3auRrkA1Wc3YM8SgFNcDkjNPfBLH5vFh+yIViR0gvy0PjmdHRu73rSP1+isj8wrrG8iPX86kun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=HiJkquQO; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="HiJkquQO"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 3BA96E83961;
	Sun, 18 Oct 2026 10:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792311808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH80DEF1KRqV74bKoPbKxH4F/ryu9Wa5A7nbGrLtt0c=;
	b=HiJkquQO3F9BcYCJ2d7XTF48aV0IrpCuLsoeTjoBQBFLdjxAcpsS3pdC/vRqY82Fpx6505
	kQUtzF061juh1Tn0L9DJKzVoh5CAFhu3312zk9J9sNsFaw8tiA/ZviGr1XI03WqHrhd9/B
	SdIZWMvz2OenO0p5wcN2ResuT1dtIb1f4Qp6XJvnpbjrZZPCRzeltqVH5O8OE/T4hGkuGl
	8jdenmPbKtB29N36O1AbzSV+tDj58UxYSPvK1Q3M+YALkNiL9rK/HA6ard6zKyitLGcIVQ
	lwQxM9HXWiPUHSuVVc88fNlnM6Y2chupKgv/Mbl3jAgUz0aYGuOsiBAWcAxoQg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id SHM9o0tbKkJX; Sun, 18 Oct 2026 10:23:28 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 10:23:27 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net 04/10] net: pse-pd: do not reach a freed PHY from the notification worker
Date: Sun, 18 Oct 2026 10:23:07 +0200
Message-ID: <20261018082314.48950-5-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018082314.48950-1-github@szelinsky.de>
References: <20261018082314.48950-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Fixes: fa2f0454174c ("net: pse-pd: Introduce attached_phydev to pse control")
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/net/pse-pd/pse_core.c | 42 ++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 65a41c517b35..336f00d82b5f 100644
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
@@ -1020,13 +1019,21 @@ static void pse_send_ntf_worker(struct work_struct *work)
 		struct net_device *netdev;
 		struct pse_control *psec;
 
-		psec = pse_control_find_by_id(pcdev, ntf.id);
+		/* A pse_control is only on the list while the PHY it was
+		 * handed to holds it: the PHY's pse_control_put() unlinks
+		 * and frees it under pse_list_mutex before the PHY itself
+		 * can be freed. Holding the mutex across the lookup and the
+		 * attached_phydev dereference therefore keeps the PHY alive,
+		 * which a reference on the pse_control alone would not.
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
 
@@ -1417,6 +1424,19 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 
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

