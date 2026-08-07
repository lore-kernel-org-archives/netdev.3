Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F413932F9
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086528; cv=none; b=Qwo06NgYk8vXUXRkABL0rKstzYTA1ik2RXXquRkkkwjdGnNv85gYsvO3tIYmXNpHbruyds1jQJXQAfmQlXCPvmgnp+4JD9cfsV1pJd9v/+sk+AHc3lVIWeCTg4ZW3iGrcQ7pvr6d338suLkXVquByN6NjQabVXuTX2uqETWFfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086528; c=relaxed/simple;
	bh=UDxfKlXWS6AGDSXCggOIOuTEHSRuYY0PHUm0Maa7lLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSF1KObStgu8grIS5EWynAuzNMH7CYjs14AZEmxpphs6lpWrue826cthxYgmwpspnNbCaSTuP4L9bvntPvbfTxxQGChzKyuPP68DDt0eNHaVQaZbM8Gq9kCkhfeYMAdnWAi4t5TsFmfOhaoN/z5Xq2f9wNRv1A/jRt4VZFSNMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fib4l5DE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fib4l5DE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786086524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWBEQhV45A1dUkcD94IGAxvuSjGcAUESNIWDGFPsEpc=;
	b=Fib4l5DE+LMcric5rtczAQ7Ptv44tsh5Wj3KBPlYkKuCuXj968h4gtrowXFfxeVnaTah46
	pX1kF3WZ7BgZXs7etsA3iHul2OlRtGcObVQtQC6o105YZrDk8BJizdCaS16llMOIp5iC1d
	ZyElT/EFXCLcVzM++2PD1+OYPKriR0g=
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
Subject: [PATCH net v4 2/4] net: phy: dp83640: embed pin configuration in clock
Date: Fri,  7 Aug 2026 15:07:27 +0800
Message-ID: <20260807070729.12545-3-xuanqiang.luo@linux.dev>
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

The DP83640 has a fixed number of PTP pins, and its pin configuration
has the same lifetime as the per-bus clock. Allocating the configuration
separately adds an allocation failure path and requires a separate free.

Embed the pin configuration in struct dp83640_clock and point the PTP
clock information at the embedded array. This changes only the storage;
the pin functions remain configurable at runtime. It also allows all
per-bus clock storage to be managed as one allocation.

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

