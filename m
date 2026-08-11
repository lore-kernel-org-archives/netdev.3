Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65703A6F06
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461365; cv=none; b=f4WIk0Mz0cLrOYLo8TE+l+fXb7zl+COjN/iBNPm5X/YaK4DRwQOzBz8H7L7Y5jvDjnAOQUtnUWM/2rh5FcDNfXBZeXX9kaJX3LCUu/deqV19mRzQDkjUOzPVHw9h2KQgB74ai9W7BTtXnRi5DFBSc9oPM0Q1p2Cv6IzpGiDYNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461365; c=relaxed/simple;
	bh=N706Y4MophgWTeLLL3zPBR8QbS/5vowTLwOAJJnkuq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwBkCawHFkm1ROCqJgLTl1HI5j0FUx98s4x8k98Stn88hKPZVyGyuK+5YzWH3h02Naa7F6TqvjQYzZrlI2OfSMSB/6T1mZ31b3ylFjJ2Fq32BAYSlr6Ruvnyk2JtwxzfhE9EpnV9eqnRxBDAzGzzu5LaX+stb3t6EE2d+KKH9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZeVy5CF6; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZeVy5CF6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786461361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbEz198D1Higdiz52lV/LGwAqZHQdAV/6JVi/qGzaMk=;
	b=ZeVy5CF6Exa5Y21J+1sGsTSt6zZSOcDo/BC1EkSIZb54eIZn0rKkpEumwswCSRClToi7Ap
	8XToxzqMHBrDGJVyo/jGl0uhtn1c53GXyETKoNhWdkbB8SU/ADIm2u7wYuSvz0qSLpoJfM
	LP8udqCAS6UDFwHKQivirSvQlxsYupY=
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
Subject: [PATCH net v6 2/4] net: phy: dp83640: embed pin configuration in clock
Date: Tue, 11 Aug 2026 23:13:43 +0800
Message-ID: <20260811151345.73582-3-xuanqiang.luo@linux.dev>
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

