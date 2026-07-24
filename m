Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7502D63F8
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860600; cv=none; b=aKLbIRXMvxFScquKRbeMK8sFZH10/oGp8cjVs9hbrJI/U1i6+gHPwMLzjdiMWGz0e8oUAn6mfCIUfNcyuTrMlxfKw8C9ncpWJwPr6VU9gjj9O8TndANKKN4nqm870v4/R6jH5QW82mZtS4li2UEmL/87VpxwLeykIh77yCOqz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860600; c=relaxed/simple;
	bh=Kx/YbZXSs3qwmiAR/Jjd2TIWrYYQT/6ID/wGRZ3xqvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5HwsR32umDIZwUimjsuPNGw1yk+kPRZnMjREmAjDR9PmM2uqty4Gvy0G2ymH0Rg/HaENBtscTJ/nr839T2VvHV3k3gKnMepfb3toOLVuCWFhM9PaQMcJvTcbeJzVuKubNyjgy4o3cnKFo2sM9xCQGvdtAaOQ9qnq9CbUwkYQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j/1e6BNo; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j/1e6BNo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784860596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NTtm61vFx78oNeTvvMMUcEAwV8JSAWWZ9JWmY50YV9I=;
	b=j/1e6BNopBnGwabIp2Xe0w3V2LVzmIkJyADPGGRF2F2pgnudml165t2gk3eFtjMY4k2mDP
	cUEbSDZAsG11tyB5oVVPQH/7CmEztKqhynqaYVC25xaXvkGM7TJdKliuJBzyzgieMUqcFp
	uhkRqr4RqAlwBs4NI+98hehjTXRCcFo=
From: xuanqiang.luo@linux.dev
To: richardcochran@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] net: phy: dp83640: fix per-bus clock lifetime
Date: Fri, 24 Jul 2026 10:35:32 +0800
Message-ID: <20260724023532.14583-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
removal handling") moved per-bus clock cleanup from module exit to the
remove path. This leaves two lifetime problems.

dp83640_clock_get_bus() publishes a newly allocated clock before
dp83640_probe() allocates its per-PHY private data and registers the PTP
clock. If either operation fails, no PHY is bound and no remove callback
will release the clock, leaking the clock, its pin configuration, and the
reference to the MII bus device.

The remove path can also free a clock after dropping clock_lock. A
concurrent lookup may already have found that clock under
phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire a
freed mutex and access the freed clock.

Use a kref to give each probing or successfully bound PHY a reference to
the per-bus clock. Acquire the reference under phyter_clocks_lock before
making the clock available to the caller, and drop it on probe failure or
when the PHY is removed. kref_put_mutex() serializes the last put with
lookups so that the release callback can remove the clock from the list
before freeing it. A lookup therefore either obtains a reference or cannot
find the clock.

Separate clock locking from the reference helpers so get and put have
their usual lifetime-management meaning.

Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/dp83640.c | 62 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 98472abdd3920..10587db95fb0b 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -10,6 +10,7 @@
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mii.h>
 #include <linux/module.h>
@@ -130,6 +131,8 @@ struct dp83640_private {
 struct dp83640_clock {
 	/* keeps the instance in the 'phyter_clocks' list */
 	struct list_head list;
+	/* tracks attached or probing PHYs */
+	struct kref kref;
 	/* we create one clock instance per MII bus */
 	struct mii_bus *bus;
 	/* protects extended registers from concurrent access */
@@ -956,6 +959,7 @@ static void decode_status_frame(struct dp83640_private *dp83640,
 static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 {
 	INIT_LIST_HEAD(&clock->list);
+	kref_init(&clock->kref);
 	clock->bus = bus;
 	mutex_init(&clock->extreg_lock);
 	mutex_init(&clock->clock_lock);
@@ -999,11 +1003,9 @@ static int choose_this_phy(struct dp83640_clock *clock,
 	return 0;
 }
 
-static struct dp83640_clock *dp83640_clock_get(struct dp83640_clock *clock)
+static void dp83640_clock_lock(struct dp83640_clock *clock)
 {
-	if (clock)
-		mutex_lock(&clock->clock_lock);
-	return clock;
+	mutex_lock(&clock->clock_lock);
 }
 
 /*
@@ -1021,6 +1023,7 @@ static struct dp83640_clock *dp83640_clock_get_bus(struct mii_bus *bus)
 		tmp = list_entry(this, struct dp83640_clock, list);
 		if (tmp->bus == bus) {
 			clock = tmp;
+			kref_get(&clock->kref);
 			break;
 		}
 	}
@@ -1043,14 +1046,38 @@ static struct dp83640_clock *dp83640_clock_get_bus(struct mii_bus *bus)
 out:
 	mutex_unlock(&phyter_clocks_lock);
 
-	return dp83640_clock_get(clock);
+	if (clock)
+		dp83640_clock_lock(clock);
+
+	return clock;
 }
 
-static void dp83640_clock_put(struct dp83640_clock *clock)
+static void dp83640_clock_unlock(struct dp83640_clock *clock)
 {
 	mutex_unlock(&clock->clock_lock);
 }
 
+static void dp83640_clock_release(struct kref *kref)
+{
+	struct dp83640_clock *clock =
+		container_of(kref, struct dp83640_clock, kref);
+
+	list_del(&clock->list);
+	mutex_unlock(&phyter_clocks_lock);
+
+	mutex_destroy(&clock->extreg_lock);
+	mutex_destroy(&clock->clock_lock);
+	put_device(&clock->bus->dev);
+	kfree(clock->caps.pin_config);
+	kfree(clock);
+}
+
+static void dp83640_clock_put(struct dp83640_clock *clock)
+{
+	kref_put_mutex(&clock->kref, dp83640_clock_release,
+		       &phyter_clocks_lock);
+}
+
 static int dp83640_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -1450,13 +1477,14 @@ static int dp83640_probe(struct phy_device *phydev)
 	} else
 		list_add_tail(&dp83640->list, &clock->phylist);
 
-	dp83640_clock_put(clock);
+	dp83640_clock_unlock(clock);
 	return 0;
 
 no_register:
 	clock->chosen = NULL;
 	kfree(dp83640);
 no_memory:
+	dp83640_clock_unlock(clock);
 	dp83640_clock_put(clock);
 no_clock:
 	return err;
@@ -1467,7 +1495,6 @@ static void dp83640_remove(struct phy_device *phydev)
 	struct dp83640_clock *clock;
 	struct list_head *this, *next;
 	struct dp83640_private *tmp, *dp83640 = phydev->priv;
-	bool remove_clock = false;
 
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return;
@@ -1480,7 +1507,8 @@ static void dp83640_remove(struct phy_device *phydev)
 	skb_queue_purge(&dp83640->rx_queue);
 	skb_queue_purge(&dp83640->tx_queue);
 
-	clock = dp83640_clock_get(dp83640->clock);
+	clock = dp83640->clock;
+	dp83640_clock_lock(clock);
 
 	if (dp83640 == clock->chosen) {
 		ptp_clock_unregister(clock->ptp_clock);
@@ -1495,23 +1523,9 @@ static void dp83640_remove(struct phy_device *phydev)
 		}
 	}
 
-	if (!clock->chosen && list_empty(&clock->phylist))
-		remove_clock = true;
-
+	dp83640_clock_unlock(clock);
 	dp83640_clock_put(clock);
 	kfree(dp83640);
-
-	if (remove_clock) {
-		mutex_lock(&phyter_clocks_lock);
-		list_del(&clock->list);
-		mutex_unlock(&phyter_clocks_lock);
-
-		mutex_destroy(&clock->extreg_lock);
-		mutex_destroy(&clock->clock_lock);
-		put_device(&clock->bus->dev);
-		kfree(clock->caps.pin_config);
-		kfree(clock);
-	}
 }
 
 static struct phy_driver dp83640_driver[] = {
-- 
2.43.0

