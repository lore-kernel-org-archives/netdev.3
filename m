Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3237B02D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371390; cv=none; b=akB2DTcXfTR/ez9xEnFXxyLjY5flhOiNg4a0UUvBpW4w3Wg57lmPN5iDc/QjRoj7aqOaGEGv/AbV8i71P90jsqiDhCff/1ZUMB/CJb079y+xjNPInXIoggCkQ1GTDfSb34w5ubWROgCkxLv9N/bwsF7+eCh8y7mWd9AzKWrRcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371390; c=relaxed/simple;
	bh=biZsx2Bnu9KsJd1BzfwIzSBKMqjNhGlw4cKL10cV89E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQKwInt6CT6v5okDtdo5e6QNOCkyBF+hWr22YmTrrx9QxZHCdXYGr090shS+8Qtfn+AOlZ8tYxbTH2zD6PF6WSABpx83hm+0c4k3+sqvOY1efBSciEeIhnq8g8WGCsvrFlzKXqayUxF41s0oARHhLGr1qke3YqBSlzs5mmCmzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWlJgJWT; arc=none smtp.client-ip=95.215.58.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWlJgJWT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=biZsx2Bnu9KsJd1BzfwIzSBKMqjNhGlw4cKL10cV89E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371385; v=1; x=1786976185;
 b=FWlJgJWT3pZBPSjAx/2IHyV5SPmr9BwmvmHv8eB4sz0GbkubtuH/LILhATmpNEbuGgm00mtn
 uMOZl0VS34dX2+sk1uYP3FgzhBp0IjtrZY4HjJc/t9qlt5ydULhcjFiGtSca4uJ7a2tnckDsfGf
 KwJu+ucdttqOVfKjJXQOHXNU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by mta10.migadu.com with ESMTPS id f161e80d93ea2720;
	Mon, 10 Aug 2026 14:16:25 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
From: xuanqiang.luo@linux.dev
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
	luoxuanqiang@kylinos.cn,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: [PATCH net v5 4/4] net: phy: dp83640: fix per-bus clock lifetime
Date: Mon, 10 Aug 2026 22:15:11 +0800
Message-ID: <20260810141511.73204-5-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
References: <20260810141511.73204-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <xuanqiang.luo@linux.dev>

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
Signed-off-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>
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

