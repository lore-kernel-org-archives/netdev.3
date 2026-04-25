Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74551F1534
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076704; cv=none; b=j0th3aMT6VGOTsWG966sKoUtcMg/tZBO0ytnrAN6xETp/tcrfalV52+uZHClLuDnoDbxTONlBZxxjD85Ui7YYLeBwxfqBaCiaFJxJyYEdTKf4u7ZvX9grEmShgNJFl8Vb6oyBMfLee939gR7Tr/tsOdtOL3vjAM/7WJD0NtqYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076704; c=relaxed/simple;
	bh=QTNTbvBnSC5EltdyXHhC+I6ndxnglhMXh0Und1seaOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krA6/fNtG7WYquCp0vBSo+cRBQNT7piRE/3iS2bICWxMNWRJwT6Z+dCMmVs6EBkSdz/CXPR3EreXuKjAVDFTxzNPWMj5kg/f9+3bhTmvlof5iNaaHZkBu7jvlvh3+De/i8sCm1KtjdZGqQnakqJPPJz3K/3YKmtbnXAlNMES8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBRPuchh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBRPuchh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-362d9dd9a49so2642481a91.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076702; x=1777681502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mr9oFSsC133Mf1hRrHkDLNxZVk8eA36xlUlRpvwFcQ=;
        b=CBRPuchhYdZYzIvpOG1tcmhpJr0LOe6LO4Y+nWc+j52ZEK2GCg5znzBGIxg6uoFcjW
         41fl+o5gaExn0reO9/rOKOXIQIXqghV4NfwhqrBz9zEXNSxf2USNeiTXLaefw2OunKql
         sfmtWTBKsurLmMCS/y+8ey7ECBQQ9y24XvChp11EgUjen1CFFw4JIWFc+53OuspbrgRX
         VTKX/zF0aWqYFd1BKxH0yqAJ47eTyLtcvGdnsa4Z4/+SRl5FAwCtjLxiGQDwjGQA2nkB
         OxV3TDR7QWFGWIN+uwj8PhX8VyKEIexQuPm6/j7sVKtPlsIi7WdTKKALX359NHWbVgF4
         vKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076702; x=1777681502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Mr9oFSsC133Mf1hRrHkDLNxZVk8eA36xlUlRpvwFcQ=;
        b=O1uwx6Pk3vX2DpI894h126Qa0GrLgLWbTTq0NSUjKDTZS45H723k58tEYOgLxHi5Zt
         +hEv91hchrAoU/Qe7GyePhHQjGmC3yCwJNy7GSgl6Q5ASkDmXKc5S4cwz1xFtaTO7VWe
         hFgI8IDUG5KsLdsY8vTimeDVkDa0KnSvCZ7+iFlJxjGo6g3KWR992EvJMaSqbCELd66b
         hb67mhz25O7Sde2kLuKyyTTROKvZ7pIJ2dlinAXe9iGq61jLkiWLMVYc2bkavtDN9aYE
         /9BOdruhlJTr1bMikwmgPMelt6xVnS7oB3VRL3xvL98NPCLaOzcJO0OaxI7+4KmXB25v
         TLmA==
X-Gm-Message-State: AOJu0YzSYTkS8X01huE0hby55wrtNcxZPh+Y4jG3oc8xXRNsIVFggNOn
	eaok004Ce6knU4IW7rTIq83AJ1OhGSYBPwxpTTJe48+FTg3xYxhzKDIyi5GrHlbWmg1yAdxc7J6
	qYlKg2439rCnapgxBts7ATZ+msTZ6vBwAB/LubwtzdlzNOZS3rMUfidWkrtZN9Q6aZIhFyCYBd2
	3An7zo4FbVVuijsoW06KzO4EiHLZw7UidqZPoefdVwTSNrGQxIXP1LRs/S0pfTFBk=
X-Received: from pjh13.prod.google.com ([2002:a17:90b:3f8d:b0:35f:be31:1a85])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2892:b0:35d:a0b7:9608 with SMTP id 98e67ed59e1d1-361403e8a1bmr33217393a91.7.1777076701965;
 Fri, 24 Apr 2026 17:25:01 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:50 +0000
In-Reply-To: <20260425002450.163421-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-5-hramamurthy@google.com>
Subject: [PATCH net v2 4/4] gve: Make ethtool config changes synchronous
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

When modifying device features via ethtool, the driver queues the
carrier status update to its workqueue (gve_wq). This leads to a
short link-down state after running the ethtool command.

Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
`gve_queues_start()` to update the carrier status before returning to
the userspace.

This was discovered by drivers/net/ping.py selftest. The test calls
ping command right after an ethtool configuration, but the interface
could be down without this fix.

Cc: stable@vger.kernel.org
Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 1fec8e1e4821..2c461be12a75 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1424,6 +1424,33 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
 	priv->rx = NULL;
 }
 
+static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
+{
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	if (link_status == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_status) {
+		netdev_info(priv->dev, "Device link is up.\n");
+		netif_carrier_on(priv->dev);
+	} else {
+		netdev_info(priv->dev, "Device link is down.\n");
+		netif_carrier_off(priv->dev);
+	}
+}
+
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	gve_turnup(priv);
+	status = ioread32be(&priv->reg_bar0->device_status);
+	gve_handle_link_status(priv,
+			       GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1486,8 +1513,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1608,23 +1634,6 @@ static int gve_close(struct net_device *dev)
 	return 0;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
-{
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	if (link_status == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_status) {
-		netdev_info(priv->dev, "Device link is up.\n");
-		netif_carrier_on(priv->dev);
-	} else {
-		netdev_info(priv->dev, "Device link is down.\n");
-		netif_carrier_off(priv->dev);
-	}
-}
-
 static int gve_configure_rings_xdp(struct gve_priv *priv,
 				   u16 num_xdp_rings)
 {
@@ -2099,15 +2108,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	u32 status;
-
-	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
-- 
2.54.0.545.g6539524ca2-goog

