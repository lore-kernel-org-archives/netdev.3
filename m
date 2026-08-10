Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1673F39E2
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371365; cv=none; b=eWsGtJ2ubP3e/z1v6HkyRleLhwAB6rhTPnv8Izs59beyJF3Hit7xErnkfOsZYyYoEWJnbweC9QyfSWV/bkMms93yrrpHxq6FoWCfmyf/+P2toFJjvYCXn3ZVIQcZ0wq6X+6doJg3iHwxLKMzBtY1jUCgXd4xlfue6bOc+FYBjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371365; c=relaxed/simple;
	bh=N706Y4MophgWTeLLL3zPBR8QbS/5vowTLwOAJJnkuq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PARPfd4u0cpMUsdtWiWl1rUtwRmi+DqtEM/kaOl+lptQgErCA5+Fj+DM29BvlIyYerBPqWolVOiVocyNTEP6IBCsc7iFSYicEaYyJ2YE+5l0o46F5P3TDm+EIX5wpGVovuEWVQTY3b9r+euoEDC00SizSDwr+ttlw0gqeE68t2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YKxr1HVo; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YKxr1HVo"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N706Y4MophgWTeLLL3zPBR8QbS/5vowTLwOAJJnkuq4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371361; v=1; x=1786976161;
 b=YKxr1HVoTe41C2EUt0LYsrDRIHomIvy46bHPmlzh84SIV2/V6GQ799Pqbl6KRA3NTZc9npwl
 RMl04HvrGg2A2CtMDRV60VRltItdEMhaSCoURVKt+8HrTCmyVzJ8RDkiTKV2M7ScL8Q81sTifH/
 uqh0fthePudldw2PIdIBNJNU=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (116.128.244.171)
	by mta10.migadu.com with ESMTPS id b8c5e1a140bdbd97;
	Mon, 10 Aug 2026 14:16:01 +0000
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
	luoxuanqiang@kylinos.cn
Subject: [PATCH net v5 2/4] net: phy: dp83640: embed pin configuration in clock
Date: Mon, 10 Aug 2026 22:15:09 +0800
Message-ID: <20260810141511.73204-3-xuanqiang.luo@linux.dev>
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

The DP83640 has a fixed number of PTP pins, and its pin configuration
has the same lifetime as the per-bus clock. Allocating the configuration
separately adds an allocation failure path and requires a separate free.

Embed the pin configuration in struct dp83640_clock and point the PTP
clock information at the embedded array. This changes only the storage;
the pin functions remain configurable at runtime. It also allows all
per-bus clock storage to be managed as one allocation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/phy/dp83640.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 98472abdd3920..ba39d30b74705 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -146,6 +146,8 @@ struct dp83640_clock {
 	struct list_head phylist;
 	/* reference to our PTP hardware clock */
 	struct ptp_clock *ptp_clock;
+	/* protected by the PTP core pin configuration lock */
+	struct ptp_pin_desc pin_config[DP83640_N_PINS];
 };
 
 /* globals */
@@ -960,6 +962,7 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 	mutex_init(&clock->extreg_lock);
 	mutex_init(&clock->clock_lock);
 	INIT_LIST_HEAD(&clock->phylist);
+	clock->caps.pin_config = clock->pin_config;
 	clock->caps.owner = THIS_MODULE;
 	sprintf(clock->caps.name, "dp83640 timer");
 	clock->caps.max_adj	= 1953124;
@@ -977,9 +980,7 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
 	clock->caps.settime64	= ptp_dp83640_settime;
 	clock->caps.enable	= ptp_dp83640_enable;
 	clock->caps.verify	= ptp_dp83640_verify;
-	/*
-	 * Convert the module param defaults into a dynamic pin configuration.
-	 */
+	/* Initialize the runtime pin configuration from gpio_tab. */
 	dp83640_gpio_defaults(clock->caps.pin_config);
 	/*
 	 * Get a reference to this bus instance.
@@ -1031,13 +1032,6 @@ static struct dp83640_clock *dp83640_clock_get_bus(struct mii_bus *bus)
 	if (!clock)
 		goto out;
 
-	clock->caps.pin_config = kzalloc_objs(struct ptp_pin_desc,
-					      DP83640_N_PINS);
-	if (!clock->caps.pin_config) {
-		kfree(clock);
-		clock = NULL;
-		goto out;
-	}
 	dp83640_clock_init(clock, bus);
 	list_add_tail(&clock->list, &phyter_clocks);
 out:
@@ -1509,7 +1503,6 @@ static void dp83640_remove(struct phy_device *phydev)
 		mutex_destroy(&clock->extreg_lock);
 		mutex_destroy(&clock->clock_lock);
 		put_device(&clock->bus->dev);
-		kfree(clock->caps.pin_config);
 		kfree(clock);
 	}
 }
-- 
2.43.0

