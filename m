Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE031A07F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461378; cv=none; b=c+bn2vluuZZ37dJTJn0d8UIQawN8QDY5njYRFGvuQ6OmoHPPe14eOMAuW9LRBgP1XM0vsgoMXheCkPfj9ZhFQDVv2nZLuCYoqqNSQix8PzMxFvfBxIQraeogNOm20Ba2ok22Ia7KJLUtECIsQSk5hN8jaOty6iNNPisqh+RJOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461378; c=relaxed/simple;
	bh=rBm0w1WFPPpR5x3y+WY6yo2zNfQfDqZnQiDnLwFAjFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA4BxlhyVe7aMGxujGp2bUN5M5m5CmGyr/xLQdSYPnFw0Vz4A4UXKRLliuANSbO1ui1N7dXYJy8DVgLcBL2sj6dH3IadwBYP2hO1HCTCNWr3ZI0Hzw/IFjqNJXck77ZPNc8tMDOMjKJGa5w2UzUQDCaWRWtqOaIgvAQjGSEeun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ADARmAxk; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ADARmAxk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786461373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDD1NOAC/DKf+JtwmDmXQYDbyoCz5WfdF66bRWsrwco=;
	b=ADARmAxkni2q/X42vcJwEuruiPTjO0yynLk3R7VJS0deuIg0A0vPmF5sLpdcvA1fLx58yA
	4H8L5n4lQLCubBX1kO/OR/SjkQyBWDA/jczEHIDW6wtL+CuUQCbjWXXoPC8eFKciWNruCk
	DG1Xl+QqMwsRQsM9RHVmUvv8sUuymHQ=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v6 4/4] net: phy: dp83640: fix per-bus clock lifetime
Date: Tue, 11 Aug 2026 23:13:45 +0800
Message-ID: <20260811151345.73582-5-xuanqiang.luo@linux.dev>
In-Reply-To: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
References: <20260811151345.73582-1-xuanqiang.luo@linux.dev>
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

dp83640_clock_get_bus() publishes a newly allocated clock before the
driver allocates its per-PHY data and registers the PTP clock. If either
operation fails, no PHY is bound and the remove callback cannot release
the clock, leaking the clock and the MII bus device reference.

The remove path can also free a clock after dropping clock_lock. A
concurrent probe may already have found the clock under
phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire
a freed mutex and access the freed clock.

Use the PHY package infrastructure for the per-bus clock. PHY packages
are tracked per MII bus, and the driver uses BROADCAST_ADDR as the
package key so the DP83640 PHYs on the same bus share the same clock
storage. Call phy_package_join() during probe and phy_package_leave() on
probe errors and in remove.

Serialize the one-time clock initialization with the package lock because
phy_package_probe_once() elects an initializer but does not wait for
initialization to finish.

Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/dp83640.c | 112 +++++++++-----------------------------
 drivers/ptp/Kconfig       |   1 +
 2 files changed, 28 insertions(+), 85 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 7aa5cf0a7bb03..6867e7c6f3b7e 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -21,6 +21,7 @@
 #include <linux/ptp_clock_kernel.h>
 
 #include "dp83640_reg.h"
+#include "phylib.h"
 
 #define DP83640_PHY_ID	0x20005ce1
 #define PAGESEL		0x13
@@ -128,10 +129,6 @@ struct dp83640_private {
 };
 
 struct dp83640_clock {
-	/* keeps the instance in the 'phyter_clocks' list */
-	struct list_head list;
-	/* we create one clock instance per MII bus */
-	struct mii_bus *bus;
 	/* protects extended registers from concurrent access */
 	struct mutex extreg_lock;
 	/* remembers which page was last selected */
@@ -208,10 +205,6 @@ static void dp83640_gpio_defaults(struct ptp_pin_desc *pd)
 	}
 }
 
-/* a list of clocks and a mutex to protect it */
-static LIST_HEAD(phyter_clocks);
-static DEFINE_MUTEX(phyter_clocks_lock);
-
 static void rx_timestamp_work(struct work_struct *work);
 
 /* extended register access functions */
@@ -955,10 +948,8 @@ static void decode_status_frame(struct dp83640_private *dp83640,
 	}
 }
 
-static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
+static void dp83640_clock_init(struct dp83640_clock *clock)
 {
-	INIT_LIST_HEAD(&clock->list);
-	clock->bus = bus;
 	mutex_init(&clock->extreg_lock);
 	mutex_init(&clock->clock_lock);
 	INIT_LIST_HEAD(&clock->phylist);
@@ -982,10 +973,6 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 	clock->caps.verify	= ptp_dp83640_verify;
 	/* Initialize the runtime pin configuration from gpio_tab. */
 	dp83640_gpio_defaults(clock->caps.pin_config);
-	/*
-	 * Get a reference to this bus instance.
-	 */
-	get_device(&bus->dev);
 }
 
 static int choose_this_phy(struct dp83640_clock *clock,
@@ -1000,51 +987,6 @@ static int choose_this_phy(struct dp83640_clock *clock,
 	return 0;
 }
 
-static struct dp83640_clock *dp83640_clock_get(struct dp83640_clock *clock)
-{
-	if (clock)
-		mutex_lock(&clock->clock_lock);
-	return clock;
-}
-
-/*
- * Look up and lock a clock by bus instance.
- * If there is no clock for this bus, then create it first.
- */
-static struct dp83640_clock *dp83640_clock_get_bus(struct mii_bus *bus)
-{
-	struct dp83640_clock *clock = NULL, *tmp;
-	struct list_head *this;
-
-	mutex_lock(&phyter_clocks_lock);
-
-	list_for_each(this, &phyter_clocks) {
-		tmp = list_entry(this, struct dp83640_clock, list);
-		if (tmp->bus == bus) {
-			clock = tmp;
-			break;
-		}
-	}
-	if (clock)
-		goto out;
-
-	clock = kzalloc_obj(struct dp83640_clock);
-	if (!clock)
-		goto out;
-
-	dp83640_clock_init(clock, bus);
-	list_add_tail(&clock->list, &phyter_clocks);
-out:
-	mutex_unlock(&phyter_clocks_lock);
-
-	return dp83640_clock_get(clock);
-}
-
-static void dp83640_clock_put(struct dp83640_clock *clock)
-{
-	mutex_unlock(&clock->clock_lock);
-}
-
 static int dp83640_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -1394,20 +1336,31 @@ static int dp83640_ts_info(struct mii_timestamper *mii_ts,
 
 static int dp83640_probe(struct phy_device *phydev)
 {
-	struct dp83640_clock *clock;
 	struct dp83640_private *dp83640;
-	int err = -ENOMEM, i;
+	struct dp83640_clock *clock;
+	int err, i;
 
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return 0;
 
-	clock = dp83640_clock_get_bus(phydev->mdio.bus);
-	if (!clock)
-		goto no_clock;
+	err = phy_package_join(phydev, BROADCAST_ADDR, sizeof(*clock));
+	if (err)
+		return err;
+
+	clock = phy_package_get_priv(phydev);
+	/* Ensure other PHY probes wait for shared clock initialization. */
+	phy_package_lock(phydev);
+	if (phy_package_probe_once(phydev))
+		dp83640_clock_init(clock);
+	phy_package_unlock(phydev);
+
+	mutex_lock(&clock->clock_lock);
 
 	dp83640 = kzalloc_obj(struct dp83640_private);
-	if (!dp83640)
+	if (!dp83640) {
+		err = -ENOMEM;
 		goto no_memory;
+	}
 
 	dp83640->phydev = phydev;
 	dp83640->mii_ts.rxtstamp = dp83640_rxtstamp;
@@ -1444,7 +1397,8 @@ static int dp83640_probe(struct phy_device *phydev)
 	} else
 		list_add_tail(&dp83640->list, &clock->phylist);
 
-	dp83640_clock_put(clock);
+	mutex_unlock(&clock->clock_lock);
+
 	return 0;
 
 no_register:
@@ -1455,8 +1409,8 @@ static int dp83640_probe(struct phy_device *phydev)
 	phydev->priv = NULL;
 	kfree(dp83640);
 no_memory:
-	dp83640_clock_put(clock);
-no_clock:
+	mutex_unlock(&clock->clock_lock);
+	phy_package_leave(phydev);
 	return err;
 }
 
@@ -1465,7 +1419,6 @@ static void dp83640_remove(struct phy_device *phydev)
 	struct dp83640_clock *clock;
 	struct list_head *this, *next;
 	struct dp83640_private *tmp, *dp83640 = phydev->priv;
-	bool remove_clock = false;
 
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return;
@@ -1478,7 +1431,8 @@ static void dp83640_remove(struct phy_device *phydev)
 	skb_queue_purge(&dp83640->rx_queue);
 	skb_queue_purge(&dp83640->tx_queue);
 
-	clock = dp83640_clock_get(dp83640->clock);
+	clock = dp83640->clock;
+	mutex_lock(&clock->clock_lock);
 
 	if (dp83640 == clock->chosen) {
 		ptp_clock_unregister(clock->ptp_clock);
@@ -1493,22 +1447,10 @@ static void dp83640_remove(struct phy_device *phydev)
 		}
 	}
 
-	if (!clock->chosen && list_empty(&clock->phylist))
-		remove_clock = true;
-
-	dp83640_clock_put(clock);
+	mutex_unlock(&clock->clock_lock);
 	kfree(dp83640);
 
-	if (remove_clock) {
-		mutex_lock(&phyter_clocks_lock);
-		list_del(&clock->list);
-		mutex_unlock(&phyter_clocks_lock);
-
-		mutex_destroy(&clock->extreg_lock);
-		mutex_destroy(&clock->clock_lock);
-		put_device(&clock->bus->dev);
-		kfree(clock);
-	}
+	phy_package_leave(phydev);
 }
 
 static struct phy_driver dp83640_driver[] = {
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index b93640ca08b72..feb50f8cc406a 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -78,6 +78,7 @@ config DP83640_PHY
 	depends on PHYLIB
 	depends on PTP_1588_CLOCK
 	select CRC32
+	select PHY_PACKAGE
 	help
 	  Supports the DP83640 PHYTER with IEEE 1588 features.
 
-- 
2.43.0

