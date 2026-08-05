Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28753E1D08
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914940; cv=none; b=D2USTOcyOgAl4DaY1840wOYVlpifyG/+kUT4a9LHg8rH6E1/cu7/CXCwr3RfzOnpSOjPafKE2eatweInDhiYojQOgNFYG123BeYyrxErtr95/pPPKN+QiFi1x3WYB5JDI4kj+ROXuQZDQPV+gi8Kd6tXZ1s/0F/zFfoXMW8rVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914940; c=relaxed/simple;
	bh=6Z64QtoPvEL49zOB2PfWDrjahW4bgg5z3+Y4Cj9/+gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2JIenZGqxsjh0VL0K/GU5AApxrrOLzIgiJKZKsCuo94xiut3O69Xved6EImGVu2ZnRyho1rX542+CZH/XdamE/clVMKrE1DDoajI57iMOOuI4eeIIweJsyXXIKu5YidKQPh8CXkEsMQBYz0NpzGn0IfoYCogaZW0QqRqUsnyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nDnVdU6C; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nDnVdU6C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785914935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DCUgXXnaBPEhryrPmBJzJb/IO9VFQAZWqQ63V0RKrlU=;
	b=nDnVdU6CGeJsxX4H9UDKqeqt3amdJQ757fy1jV3CD5Q826SfPmrSLtB5h9TkR9VMsa1loH
	Ao8Ogj2hTEAh+wIJoFr1yZ18mcz1P9vIG3xa+W+VUzqYGs9c7MqhS8AV+M5emGcwOSJO+I
	sgETCJprmxYX1XMWTFL1dZJ+YBIik1c=
From: xuanqiang.luo@linux.dev
To: kuba@kernel.org,
	andrew@lunn.ch,
	richardcochran@gmail.com,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v3] net: phy: dp83640: fix per-bus clock lifetime
Date: Wed,  5 Aug 2026 15:27:25 +0800
Message-ID: <20260805072725.169431-1-xuanqiang.luo@linux.dev>
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
the clock, leaking the clock, its pin configuration, and the MII bus
device reference.

The remove path can also free a clock after dropping clock_lock. A
concurrent probe may already have found the clock under
phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire
a freed mutex and access the freed clock.

Use the PHY package infrastructure for the per-bus clock. The package
table is scoped to each MII bus and holds the shared object until the
last joined PHY leaves. Serialize the one-time clock initialization with
the bus shared lock because phy_package_probe_once() elects an
initializer but does not wait for initialization to finish.

Manage both the package reference and the per-PHY state with devres.
This is needed because dp83640_probe() may succeed before later PHY core
initialization fails, and the driver remove callback is not called for
that failure. Register the per-PHY cleanup action after the package
reference so probe unwinding first unregisters the PTP clock or removes
the PHY from the clock list, then releases the shared clock. Let devres
run the same action on normal driver detach.

Embed the pin configuration in the package private data so the final
package leave releases all clock storage.

Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
Changes:
v3:
  - Drop the Suggested-by tag. (Jakub Kicinski.)
  - Set err to -ENOMEM on the kzalloc_obj() failure path. (Sashiko.)
  - Let devres handle cleanup on driver detach instead of explicitly
    releasing the action from .remove(). (Jakub Kicinski.)

v2: https://lore.kernel.org/all/20260730064451.32261-1-xuanqiang.luo@linux.dev/
  - Replace the driver-local clock list and kref with the PHY package API.
    (Jakub Kicinski.)
  - Use devres to avoid leaking the new package reference on later PHY core
    initialization failures.
  - Embed the pin configuration in the package private data to simplify
    lifetime management.

v1: https://lore.kernel.org/all/20260724023532.14583-1-xuanqiang.luo@linux.dev/

 drivers/net/phy/dp83640.c | 190 ++++++++++++++------------------------
 drivers/ptp/Kconfig       |   1 +
 2 files changed, 72 insertions(+), 119 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 98472abdd3920..7bd130f7794fa 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/crc32.h>
+#include <linux/device/devres.h>
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -21,6 +22,7 @@
 #include <linux/ptp_clock_kernel.h>
 
 #include "dp83640_reg.h"
+#include "phylib.h"
 
 #define DP83640_PHY_ID	0x20005ce1
 #define PAGESEL		0x13
@@ -128,10 +130,6 @@ struct dp83640_private {
 };
 
 struct dp83640_clock {
-	/* keeps the instance in the 'phyter_clocks' list */
-	struct list_head list;
-	/* we create one clock instance per MII bus */
-	struct mii_bus *bus;
 	/* protects extended registers from concurrent access */
 	struct mutex extreg_lock;
 	/* remembers which page was last selected */
@@ -146,6 +144,7 @@ struct dp83640_clock {
 	struct list_head phylist;
 	/* reference to our PTP hardware clock */
 	struct ptp_clock *ptp_clock;
+	struct ptp_pin_desc pin_config[DP83640_N_PINS];
 };
 
 /* globals */
@@ -206,10 +205,6 @@ static void dp83640_gpio_defaults(struct ptp_pin_desc *pd)
 	}
 }
 
-/* a list of clocks and a mutex to protect it */
-static LIST_HEAD(phyter_clocks);
-static DEFINE_MUTEX(phyter_clocks_lock);
-
 static void rx_timestamp_work(struct work_struct *work);
 
 /* extended register access functions */
@@ -953,13 +948,12 @@ static void decode_status_frame(struct dp83640_private *dp83640,
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
+	clock->caps.pin_config = clock->pin_config;
 	clock->caps.owner = THIS_MODULE;
 	sprintf(clock->caps.name, "dp83640 timer");
 	clock->caps.max_adj	= 1953124;
@@ -977,14 +971,8 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 	clock->caps.settime64	= ptp_dp83640_settime;
 	clock->caps.enable	= ptp_dp83640_enable;
 	clock->caps.verify	= ptp_dp83640_verify;
-	/*
-	 * Convert the module param defaults into a dynamic pin configuration.
-	 */
+	/* Convert the module param defaults into the pin configuration. */
 	dp83640_gpio_defaults(clock->caps.pin_config);
-	/*
-	 * Get a reference to this bus instance.
-	 */
-	get_device(&bus->dev);
 }
 
 static int choose_this_phy(struct dp83640_clock *clock,
@@ -999,58 +987,6 @@ static int choose_this_phy(struct dp83640_clock *clock,
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
-	clock->caps.pin_config = kzalloc_objs(struct ptp_pin_desc,
-					      DP83640_N_PINS);
-	if (!clock->caps.pin_config) {
-		kfree(clock);
-		clock = NULL;
-		goto out;
-	}
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
@@ -1398,22 +1334,70 @@ static int dp83640_ts_info(struct mii_timestamper *mii_ts,
 	return 0;
 }
 
-static int dp83640_probe(struct phy_device *phydev)
+static void dp83640_phy_release(void *data)
 {
+	struct dp83640_private *dp83640 = data;
+	struct dp83640_private *tmp;
+	struct list_head *this, *next;
 	struct dp83640_clock *clock;
+	struct phy_device *phydev;
+
+	clock = dp83640->clock;
+	phydev = dp83640->phydev;
+	phydev->mii_ts = NULL;
+	cancel_delayed_work_sync(&dp83640->ts_work);
+	skb_queue_purge(&dp83640->rx_queue);
+	skb_queue_purge(&dp83640->tx_queue);
+
+	mutex_lock(&clock->clock_lock);
+	if (dp83640 == clock->chosen) {
+		ptp_clock_unregister(clock->ptp_clock);
+		clock->ptp_clock = NULL;
+		clock->chosen = NULL;
+	} else {
+		list_for_each_safe(this, next, &clock->phylist) {
+			tmp = list_entry(this, struct dp83640_private, list);
+			if (tmp == dp83640) {
+				list_del_init(&tmp->list);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&clock->clock_lock);
+
+	phydev->default_timestamp = false;
+	phydev->priv = NULL;
+	kfree(dp83640);
+}
+
+static int dp83640_probe(struct phy_device *phydev)
+{
 	struct dp83640_private *dp83640;
-	int err = -ENOMEM, i;
+	struct dp83640_clock *clock;
+	int err, i;
 
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return 0;
 
-	clock = dp83640_clock_get_bus(phydev->mdio.bus);
-	if (!clock)
+	err = devm_phy_package_join(&phydev->mdio.dev, phydev,
+				    BROADCAST_ADDR, sizeof(*clock));
+	if (err)
 		goto no_clock;
 
+	clock = phy_package_get_priv(phydev);
+	/* Ensure other PHY probes wait for shared clock initialization. */
+	mutex_lock(&phydev->mdio.bus->shared_lock);
+	if (phy_package_probe_once(phydev))
+		dp83640_clock_init(clock);
+	mutex_unlock(&phydev->mdio.bus->shared_lock);
+
+	mutex_lock(&clock->clock_lock);
+
 	dp83640 = kzalloc_obj(struct dp83640_private);
-	if (!dp83640)
+	if (!dp83640) {
+		err = -ENOMEM;
 		goto no_memory;
+	}
 
 	dp83640->phydev = phydev;
 	dp83640->mii_ts.rxtstamp = dp83640_rxtstamp;
@@ -1450,68 +1434,36 @@ static int dp83640_probe(struct phy_device *phydev)
 	} else
 		list_add_tail(&dp83640->list, &clock->phylist);
 
-	dp83640_clock_put(clock);
+	mutex_unlock(&clock->clock_lock);
+
+	err = devm_add_action_or_reset(&phydev->mdio.dev,
+				       dp83640_phy_release, dp83640);
+	if (err)
+		return err;
+
 	return 0;
 
 no_register:
 	clock->chosen = NULL;
+	clock->ptp_clock = NULL;
+	phydev->default_timestamp = false;
+	phydev->mii_ts = NULL;
+	phydev->priv = NULL;
 	kfree(dp83640);
 no_memory:
-	dp83640_clock_put(clock);
+	mutex_unlock(&clock->clock_lock);
 no_clock:
 	return err;
 }
 
 static void dp83640_remove(struct phy_device *phydev)
 {
-	struct dp83640_clock *clock;
-	struct list_head *this, *next;
-	struct dp83640_private *tmp, *dp83640 = phydev->priv;
-	bool remove_clock = false;
-
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return;
 
 	phydev->mii_ts = NULL;
 
 	enable_status_frames(phydev, false);
-	cancel_delayed_work_sync(&dp83640->ts_work);
-
-	skb_queue_purge(&dp83640->rx_queue);
-	skb_queue_purge(&dp83640->tx_queue);
-
-	clock = dp83640_clock_get(dp83640->clock);
-
-	if (dp83640 == clock->chosen) {
-		ptp_clock_unregister(clock->ptp_clock);
-		clock->chosen = NULL;
-	} else {
-		list_for_each_safe(this, next, &clock->phylist) {
-			tmp = list_entry(this, struct dp83640_private, list);
-			if (tmp == dp83640) {
-				list_del_init(&tmp->list);
-				break;
-			}
-		}
-	}
-
-	if (!clock->chosen && list_empty(&clock->phylist))
-		remove_clock = true;
-
-	dp83640_clock_put(clock);
-	kfree(dp83640);
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
 
