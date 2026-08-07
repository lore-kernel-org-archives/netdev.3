Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C338399000
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086546; cv=none; b=CAjNbwlEdZ7hrCFrelDMwYMbMZbnCYm/RUXr1rvueN28C8gNZZ9qXNQXRonanLZcw+DhmCZj5/L5mA2iWBe8q8f+0+TSGuEJfUA0pdefMVT0/f+2AdAh80sZiUy1Y8MMbIJmwwBG2+7xrWTAKSnqsS3SeiJMTLzt3DJPHNzB4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086546; c=relaxed/simple;
	bh=p/lOo7fut2fm6cmNkKM9wLHQcGokfIxxbSei92MHOgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeJZT1g/8URQks+2aIWKlwIYKdmlMqDgtLvlN1BOtppjjE66LtfGDup3i96bQP6Lqp13e2DPfjEC3E5sigMxa+G/wPXkBK6zuNGSaQLhAVoNakcudD14RTEle0m3yqgGLMzDyHjjuwfwl8xa+ITfGBLigY+CD/GTzVJeiQtqo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C3yhdPc4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C3yhdPc4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786086542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYNQmdyhRPJm1UuHAKLTqDigAKhSqWJP9viGO1sTZZ0=;
	b=C3yhdPc4b5RJvfbgg4BiUCyyF16N8k6pALJ98RH2bwgqhR60G9Q9LjHKlILrrDkJsSgGuq
	ZvSv51kHSMtelk44RU2B15oNnGJghiHsTzkxUWcXuWJ+Z2lPlQA+LNP/r71UZo3IW8hnlz
	/GqhToIfIffHvncMNujpOKUXJNQ7nek=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org,
	andrew@lunn.ch,
	kuba@kernel.org,
	richardcochran@gmail.com,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v4 4/4] net: phy: dp83640: fix per-bus clock lifetime
Date: Fri,  7 Aug 2026 15:07:29 +0800
Message-ID: <20260807070729.12545-5-xuanqiang.luo@linux.dev>
In-Reply-To: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
References: <20260807070729.12545-1-xuanqiang.luo@linux.dev>
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

Use the PHY package infrastructure for the per-bus clock. The package
table is scoped to each MII bus and holds the shared object until the
last joined PHY leaves. Serialize the one-time clock initialization with
the package lock because phy_package_probe_once() elects an initializer
but does not wait for initialization to finish.

Manage both the package reference and the per-PHY state with devres.
This is needed because dp83640_probe() may succeed before later PHY core
initialization fails, and the driver remove callback is not called for
that failure. Register the per-PHY cleanup action after the package
reference so probe unwinding first unregisters the PTP clock or removes
the PHY from the clock list, then releases the shared clock. Let devres
run the same action on normal driver detach.

Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/dp83640.c | 172 ++++++++++++++------------------------
 drivers/ptp/Kconfig       |   1 +
 2 files changed, 65 insertions(+), 108 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 7aa5cf0a7bb03..543f63eac9caf 100644
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
@@ -208,10 +206,6 @@ static void dp83640_gpio_defaults(struct ptp_pin_desc *pd)
 	}
 }
 
-/* a list of clocks and a mutex to protect it */
-static LIST_HEAD(phyter_clocks);
-static DEFINE_MUTEX(phyter_clocks_lock);
-
 static void rx_timestamp_work(struct work_struct *work);
 
 /* extended register access functions */
@@ -955,10 +949,8 @@ static void decode_status_frame(struct dp83640_private *dp83640,
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
@@ -982,10 +974,6 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 	clock->caps.verify	= ptp_dp83640_verify;
 	/* Initialize the runtime pin configuration from gpio_tab. */
 	dp83640_gpio_defaults(clock->caps.pin_config);
-	/*
-	 * Get a reference to this bus instance.
-	 */
-	get_device(&bus->dev);
 }
 
 static int choose_this_phy(struct dp83640_clock *clock,
@@ -1000,51 +988,6 @@ static int choose_this_phy(struct dp83640_clock *clock,
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
@@ -1392,22 +1335,70 @@ static int dp83640_ts_info(struct mii_timestamper *mii_ts,
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
+	phy_package_lock(phydev);
+	if (phy_package_probe_once(phydev))
+		dp83640_clock_init(clock);
+	phy_package_unlock(phydev);
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
@@ -1444,7 +1435,13 @@ static int dp83640_probe(struct phy_device *phydev)
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
@@ -1455,60 +1452,19 @@ static int dp83640_probe(struct phy_device *phydev)
 	phydev->priv = NULL;
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
 
-- 
2.43.0

