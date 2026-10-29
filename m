Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308601;
	b=dmHtEcgAcxvyOdM33TpaA4OjB1bH05m0DaUPdWEArJw7NEGPHHooSpeXAfWgyHsHQxZs
	 gfSkauJTGbbaql/IqzZWxhnyujiWpng8ZQMVjKfPslrr8JrLDA/IO4FVQGiBdFiyc0MZ3
	 ISsciuYJCx+4JsTJNB0oCPdFGba2+prWkCSJZQ5uECqqKdc7UP1vUBGDnogtYxQ56YFbc
	 IRy/MGCH0NmbjoS9dRWAgmLk41Bt+p20KwxWpD6f37PGOEcWxBZnVukUqmhJh401fbITT
	 DwJZTXJAdyq3cxrRXglko2W5QD8sjCD+jcUKmoCXPVKuIqLlrXj6jhfmIoleqN0RrpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=c4c2nOdbkSKpVO12N7+ZMENm5FqMe9Q2TS5BEIMNko4=;
	b=X5g6DXsKBMfjE2wZtq5JSIr77VOEOJEmLCsH7jU+8xY15mXoRYOjjHmRMZ8dF+JX53zn
	 C6H+WyRu2uUNcPV2oeoXsGIqy1OWiidsq1W8ZW9XWgZRQYbltYayv63Kg5j1HTCP3p5hJ
	 BiXXAJ41gY3kCrzaQzqv2yJvlKImHFYQMRb/sKcsa/QmkTqvHEuSVBT3xoEZ/TSRdK1h9
	 efbBMzQeBtsVsHW1V2jBDq7odxdMz13UvuHHahKLpX0SFCZ8c3wj+ilmXKclO3ax5tCMs
	 gB6apPB40lIoV/y73/qt4e4uQII1Azt6+M1TyDXOmU1YDnHtFDFKKt8WJRAbjiYCbQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hPKpqtQi;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48024606A323
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48024606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hPKpqtQi
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so50401a91.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793308600; x=1793913400; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4c2nOdbkSKpVO12N7+ZMENm5FqMe9Q2TS5BEIMNko4=;
        b=hPKpqtQiQr5Mndc+Bml/2/+JkqvFNN0XrBEl+OVgvsuwxoSCXZ/O70tKIMCXItsVeM
         f6wdWbFIEi6ymWbt1mM7JryfJCcJ5hrPQCoK3QU9NLAoHkHPIdjXiSvJz6n+DF5wj/aP
         jikn4DWnD72yN7JsmZtE2ooZfk2THCrgwlp0u6LqODFD03HjpqUhXoofBlgsUVkbjkaG
         DRSPd/GsM931N8kQ69Haa199TeD6eBYr6EWEV7MAAXgGnc+qpdA7QFiRwEX4MpxFHV0R
         5yrT+IuMiR6B0CiVk6F1Qe6LTIh7DyYKfyzomhwTX/3lHy6SBKyrLXGaJ6QWziCVysEY
         S9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308600; x=1793913400;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4c2nOdbkSKpVO12N7+ZMENm5FqMe9Q2TS5BEIMNko4=;
        b=XlLuwdhrrP7W9WcYLWb+lZbiITqSvgQLtgxKQsrfJUeOYvjfiuF1QNapIl3sf7v3hy
         xNDTVxvj0yusRUArSF57cCE3gmiiF00b4+hWPFlYvyc51+OuhousllJdUj8PW+vSFmkc
         ON6B69fc8mVNdNxMk0fBCC5y4KBpXQu0gUDDyc0cg92g0iNntqfh7JMKLqRokn4PaMMX
         +Eh+ZilcePOcU4s/vw5KFonTfsGIhWy37OYJ36gkohJdz6fcFHMll/r6k9Q9AUkRJUD6
         wxDQsx7sQ/OwB9o+REUu4KxmSbBiJ3kec5dTYDrjX8BevtUNDIu4ByIBkEWz9YkhCLGJ
         sM8A==
X-Gm-Message-State: AFq9FYKKk9DBASx2kb9+C0LiKf9ChsEGdwOPYYKDz0+okYIe0FRJ3fho
	JYzEgdxH/37nrKJ13oK2IuYdnRtsOk+sqElSTbqP+yCLDWg70UJJnu29DJsatPrIG8hNC2Usi0W
	qCXIiEsSRY8sFHMCaYq+i7pX3tmrhwgrL1trPgN+j2t6183SDobQdC079ItE/Z3eMdcGAB/VuoZ
	tFGvlEhYtdex63OGoAEK8689o1jyBr63G2kdK00sJC40qxp5bTMAU6HTuyxAAaIHU=
X-Received: from pgly20.prod.google.com ([2002:a63:1814:0:b0:cd8:4bbf:f9e0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:180d:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3ae8985edbfmr146770a91.66.1793308600149;
 Thu, 29 Oct 2026 14:16:40 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:16:34 +0000
In-Reply-To: <20261029211634.2232784-1-hramamurthy@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029211634.2232784-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029211634.2232784-5-hramamurthy@google.com>
Subject: [PATCH net v4 4/4] gve: Fix link flap after ethtool ops
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	jordanrhee@google.com, willemb@google.com, przemyslaw.kitszel@intel.com, 
	nktgrg@google.com, maolson@google.com, jacob.e.keller@intel.com, 
	pkaligineedi@google.com, yangchun@google.com, patricion@google.com, 
	awogbemila@google.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pin-yen Lin <treapking@google.com>

When modifying device features via ethtool, GVE causes a short link-down
after the ethtool command completes, which can break scripts that use
the network interface right after the ethtool command.

This issue was discovered and actually triggered by the
drivers/net/ping.py selftest. Modifying checksum offload features via
ethtool caused a transient carrier drop ("Lost carrier", DHCP lease lost),
causing the immediate ping invocation to fail.

Fix it by calling gve_turnup_and_check_status() in gve_queues_start()
instead of deferring the link status update to the service task, so the
carrier status is updated synchronously before returning to userspace.

Take netdev_lock() around the link status update in gve_service_task(),
so that it is serialized with the synchronous update. All other callers
of gve_handle_link_status() already hold the instance lock.

This change was tested using the DQO RDA queue format.

Cc: stable@vger.kernel.org
Fixes: 3b7cc73628ff ("gve: Use link status register to report link status")
Signed-off-by: Pin-yen Lin <treapking@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---

Changes in v4:
- Take netdev_lock() around the link status update in
  gve_service_task() to serialize it with gve_queues_start() (Sashiko)

Changes in v3:
- Retitled from "gve: Make ethtool config changes synchronous"
- Fix the Fixes tag
- Refined the commit message

 drivers/net/ethernet/google/gve/gve_main.c | 70 ++++++++++++----------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b5e2f39a903c..bc7d7c41948c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/sch_generic.h>
 #include <net/xdp_sock_drv.h>
@@ -1431,6 +1432,37 @@ static void gve_queues_stop(struct gve_priv *priv)
 	gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
 }
 
+static void gve_handle_link_status(struct gve_priv *priv)
+{
+	bool link_up;
+
+	netdev_assert_locked(priv->dev);
+
+	if (!gve_get_napi_enabled(priv))
+		return;
+
+	link_up = READ_ONCE(priv->link_up);
+	if (link_up == netif_carrier_ok(priv->dev))
+		return;
+
+	if (link_up) {
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
+	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
+
+	gve_turnup(priv);
+	ops->report_link_status(priv);
+	gve_handle_link_status(priv);
+}
+
 /* The passed-in queue memory is stored into priv and the queues are made live.
  * No memory is allocated. Passed-in memory is freed on errors.
  */
@@ -1494,8 +1526,7 @@ static int gve_queues_start(struct gve_priv *priv,
 			  round_jiffies(jiffies +
 				msecs_to_jiffies(priv->stats_report_timer_period)));
 
-	gve_turnup(priv);
-	queue_work(priv->gve_wq, &priv->service_task);
+	gve_turnup_and_check_status(priv);
 	priv->interface_up_cnt++;
 	return 0;
 
@@ -1570,26 +1601,6 @@ static int gve_close(struct net_device *dev)
 	return err;
 }
 
-static void gve_handle_link_status(struct gve_priv *priv)
-{
-	bool link_up;
-
-	if (!gve_get_napi_enabled(priv))
-		return;
-
-	link_up = READ_ONCE(priv->link_up);
-	if (link_up == netif_carrier_ok(priv->dev))
-		return;
-
-	if (link_up) {
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
@@ -2064,15 +2075,6 @@ static void gve_turnup(struct gve_priv *priv)
 	gve_set_napi_enabled(priv);
 }
 
-static void gve_turnup_and_check_status(struct gve_priv *priv)
-{
-	const struct gve_ctrl_ops *ops = priv->ctrl_ops;
-
-	gve_turnup(priv);
-	ops->report_link_status(priv);
-	gve_handle_link_status(priv);
-}
-
 static struct gve_notify_block *gve_get_tx_notify_block(struct gve_priv *priv,
 							unsigned int txqueue)
 {
@@ -2406,8 +2408,14 @@ static void gve_service_task(struct work_struct *work)
 	gve_handle_status(priv, status);
 
 	gve_handle_reset(priv);
+
+	/* Serialize with the synchronous link status updates, which all run
+	 * under the netdev instance lock.
+	 */
+	netdev_lock(priv->dev);
 	ops->report_link_status(priv);
 	gve_handle_link_status(priv);
+	netdev_unlock(priv->dev);
 }
 
 static void gve_set_netdev_xdp_features(struct gve_priv *priv)
-- 
2.56.0.313.g2479322e68-goog

