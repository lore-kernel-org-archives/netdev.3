Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4E19CCF5
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389891; cv=none; b=m1qOb8fYrwDMmTpK0UKAqHKT3LWkYxaLBiu791GisOEiMeuB93l84/70s8mbcUkUW98nm2SbbOeHSkRn+XXHorMHL7yZ0f23CxwpK9oE6qohjxBC2QTDo+bOIt+gSxdilYzDHbwca+juOSnt2fmxCIqyz8gaUm0a63DPhlwbfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389891; c=relaxed/simple;
	bh=ZoKS4HP8jTfUqvKjHQCOygjufJp7O7UXxSy9Xj+WYgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbEBGcS5LxKH6kzoeVUY7E2/t4SlOV5/XwWTAMQtw75KkIzli2TcUda59+ePF2BHzKnL9TzApxQi6TApo8Y2a0F0NWpHUGpAySQvPd5GWqbpoovtsg1NrEKKIRsRIEigfigTdhwK6JsGlNnp8TiQGjiQomWM+M/FBe4g8iDQPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOkIrzOx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOkIrzOx"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1263929f8f.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792389888; x=1792994688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQrs1A/lHyQmEHN3tDaDTbTCRAYkGfogMiGTVBwsan4=;
        b=gOkIrzOxoN4M/K3anAqO10bMOK5rqVz/YMCphbDCbp2MpmtXiJUdkrMajXml/tvRID
         6H/ZhDx2/OLneevo5f3fB5Cl3WkxU7BxArQO6wtGfXVSTuDyg59qXQYZGqjGJP//egdi
         0ldSCcB3aeF5k0qLoc9WWpMrY+p7wqEZBcOMtcXUMa8OQYHD1i1qZR0XedXiCAuvVAsM
         wf6oJfW4Kcs28YPp/roB4xxgwgYXD4YmFKe5W7m8rR9BpiJrvIOMnYKNYm3tKch3TtNe
         v9s179e0oWn2IQ0hroTtC3QvAGKHbUKG9PlbhomrcnIjLVYcQ7ijn03iqi8EGfkt0+8Y
         aiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792389888; x=1792994688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQrs1A/lHyQmEHN3tDaDTbTCRAYkGfogMiGTVBwsan4=;
        b=ZXhvwI/r13I/loZddv3gG7nNWEzGlZP6bhqpMXlsLRIZmCzKh2o2BqxH51aSX65Bgd
         0rl+YmmicuSRncfhZZIjrDhEptjYu1VXPJzfRpOLSAY4328R6IK9zfDi0jN124U1lKXj
         WC9QTr4r5u8W2kCMeoCRsjNE/ecTSAX4KWFSPM01h1dBS1zABWwJfP8XGt9wP03GCxJe
         igZT3ibK9OsFgmPLSPMwmZBUiksQsFZqnw6Rlflquxl9mr35VLsECr8FMlLdvjyJlk+B
         hBbuq616pBg1LbMG0clMwZz/KD6AAq/Q24HEcMLRpIGysK/J2O0dnRTTblKs6zK7Lgyy
         C7CQ==
X-Gm-Message-State: AFq9FYKhbh1gWB2H48N3YQ4VsIeJAtP6Zs/geAVZvvoJ1B/sfjE7cCME
	VhI/vX6N2VB9M4xDtD9ehdFf5MYPgLYEHCbZm5wITUsN5zVSZFq5sy47OVX/Ew==
X-Gm-Gg: AYBFou0vP3AZC8hzQqq676qhS49+wXuBfWB33EwlbVqwPZ5BMcPyS08dMtRofhxin79
	IyqKOUoJDjAfrGdIbOH7MJxxHvkyVIxYSCAv0OVXeO76E9xY6hfvAf5vBcFDGa2Sv2fLWgtCt7p
	t3cuhWeAisXzZJ+SOIRIN61Yu8zUwzQvaWK5VzePr25JJYfgDKN4Bc+S2zrYcbJHkld4hgCrX2i
	5IawtxCVtmOtX1VhDiVot2PztICINhcT+C7pA6DWmwym1I44p/baEn3tYkYzsUlw6vEInZfgRPY
	gaw/8F3uEhZ6fBPeThz2btZvR5fMJh3jX+5Y4TbnwrMvokMwwB8DgN3ZfBC253gu7YylI8s2lS5
	hsX9VNbejBS1dEfGmJrlCpPlL1PerOZw6ypEQ8DkbmN/NK/k64RDxfpnDAIrA3/5Lnqx8Yca28X
	GO2PvHB7dghH34B0+a/VavzFdmP7Wc0iPY2kd3KFob0r6kwnwXc0ji0kd43CVxB44fNJN4PpJHV
	WppW6FfxWsfyLvo3a/nGjsZYamgpoB4Nz4fL3P0Dxa7vdTUudvBu9OaYeN+lDueEE3kXfulTiec
	vgKzBQvJR9+oKNNpPy4Cp/CLKvFt/0YwWTsFKbya35P0okFb++UvTD+goVCdfiSULBoyOqaqQqX
	Q
X-Received: by 2002:a05:6000:ac4:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48e07f9e4b5mr10301709f8f.33.1792389888187;
        Sun, 18 Oct 2026 23:04:48 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de. [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfe4d2321sm24820878f8f.19.2026.10.18.23.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 23:04:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Keerthy <j-keerthy@ti.com>,
	Kevin Hao <haokexin@gmail.com>,
	Alexander Sverdlin <alex@sverdlin.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Date: Mon, 19 Oct 2026 08:04:30 +0200
Message-Id: <20261019060430.33254-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy CPSW driver registers its netdevs before requesting IRQs. If
a later IRQ request fails in dual-EMAC mode, the probe error path
unregisters only the primary netdev. Devres then calls free_netdev() on
the still-registered secondary netdev, triggering the reg_state BUG_ON.

Once registered, either interface can queue rx_mode_work through
dev_set_rx_mode(). The error path does not drain the work before devres
releases the netdev and its private data, allowing the worker to access
freed memory.

Use the same per-port cleanup for probe failure and remove. Unregister
each netdev whose reg_state is NETREG_REGISTERED, then drain its
rx_mode_work. The state check is needed because cpsw_probe_dual_emac()
stores the secondary pointer before register_netdev() succeeds.

The workqueue lifetime issue was found during an LLM-assisted review of
the 6.12.112-rc1 stable series. Inspecting the same path then exposed
the dual-EMAC cleanup bug.

An instrumented KASAN ARM kernel and a QEMU CPSW probe stub reproduced
both failures by forcing the TX IRQ request to return -EBUSY. Not tested
on real hardware.

Fixes: 070f9c658a59 ("net: ethernet: ti: cpsw: Push the request_irq function to the end of probe")
Fixes: 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback in a work queue")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2:
  - fold the two fixes into one patch (Jakub)
  - share registered-port cleanup between probe unwind and remove (Jakub)
  - check NETREG_REGISTERED instead of adding a local flag (Jakub)
  - add the requested discovery context (netdev bot)
  - rebase on net

v1: https://lore.kernel.org/netdev/cover.1791035789.git.kmehltretter@gmail.com/

Tested:
  - ARM W=1 cpsw.o builds with TI_CPSW=y and TI_CPSW=m
  - KASAN ARM runs with a QEMU CPSW probe stub. A test hook held
    rx_mode_work pending while the TX IRQ request failed with -EBUSY.
    Both failures reproduced without the combined fix; v2 completed
    single- and dual-EMAC cleanup without KASAN or BUG reports in two
    runs per mode.

 drivers/net/ethernet/ti/cpsw.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index aa3531e844e87..01296c0582bf0 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1524,6 +1524,23 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	return ret;
 }
 
+static void cpsw_unregister_ports(struct cpsw_common *cpsw)
+{
+	struct net_device *ndev;
+	struct cpsw_priv *priv;
+	int i;
+
+	for (i = 0; i < cpsw->data.slaves; i++) {
+		ndev = cpsw->slaves[i].ndev;
+		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
+			continue;
+
+		priv = netdev_priv(ndev);
+		unregister_netdev(ndev);
+		disable_work_sync(&priv->rx_mode_work);
+	}
+}
+
 static const struct of_device_id cpsw_of_mtable[] = {
 	{ .compatible = "ti,cpsw"},
 	{ .compatible = "ti,am335x-cpsw"},
@@ -1764,7 +1781,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	return 0;
 
 clean_unregister_netdev_ret:
-	unregister_netdev(ndev);
+	cpsw_unregister_ports(cpsw);
 clean_cpts:
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);
@@ -1779,9 +1796,7 @@ static int cpsw_probe(struct platform_device *pdev)
 static void cpsw_remove(struct platform_device *pdev)
 {
 	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
-	struct net_device *ndev;
-	struct cpsw_priv *priv;
-	int i, ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
@@ -1793,15 +1808,7 @@ static void cpsw_remove(struct platform_device *pdev)
 		return;
 	}
 
-	for (i = 0; i < cpsw->data.slaves; i++) {
-		ndev = cpsw->slaves[i].ndev;
-		if (!ndev)
-			continue;
-
-		priv = netdev_priv(ndev);
-		unregister_netdev(ndev);
-		disable_work_sync(&priv->rx_mode_work);
-	}
+	cpsw_unregister_ports(cpsw);
 
 	cpts_release(cpsw->cpts);
 	cpdma_ctlr_destroy(cpsw->dma);

base-commit: 7ec48f396a1d89532c0537bc38b408b8c31ee37f
-- 
2.39.5 (Apple Git-154)

