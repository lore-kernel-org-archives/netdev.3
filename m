Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2673A4F23
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516368; cv=none; b=VohLMhzDw6MNATzJke+LrX9k/CBeTYTBb4X9/C0q5uz7DdEv3M/uvfS+GCzOtNWTf7krWZjF7Thmy2RLx+B0TjyQnAY7WCpjDHvQowwF2hXHlzzF/9IJuFz+BTHqMHFcK8+LtvcCrhl7VbktVh/H74e19rIVGb2wL9vOyNud3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516368; c=relaxed/simple;
	bh=x2sGPgqWN79edUANLPfEhllBmV9Q6haVRZV/M37GAdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kz2DxqUgju4u6JIUruwLeYs+Iin8kD7sVXcvDYr32U6MF/vQzSfi53wGfur5VS6VtpJaGvVgQf0Gkn1SvE00ahMr1jtoJ/3PcOlpu6S80UMUIoMcp0PdVtV3j/YJ1fQ3JvWK4oxShNGcwi0LjFNLv5AN57C1w7WN7LsDVaFqJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rifixzz+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rifixzz+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778516364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1qEw1gjQ+vGjLBvP3Y3UGcXh4mPsTOticFAyfRlcngA=;
	b=Rifixzz+XS12fyYBLM5YHJkXmSpsE4EL1d9yNDiU+UYcGhGez82mb5N48/x2zq5VVt19Ka
	FRxfvkyB8hCZP+7p8LM9GP3dfZLIePcv7iRsx09g3CLMPA+pN+r2MqPq/GX5P9zsmv2hll
	qDJPbJb6s/WHWF0jTrtVPHkDNFLKBlk=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net v2] ptp: ocp: fix resource freeing order
Date: Mon, 11 May 2026 16:18:38 +0000
Message-ID: <20260511161838.1413499-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable
events") added a call to ptp_disable_all_events() which changes the
configuration of pins if they support EXTTS events. In ptp_ocp_detach()
pins resources are freed before ptp_clock_unregister() and it leads to
use-after-free during driver removal. Fix it by changing the order of
free/unregister calls.

Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
v1 -> v2:

* on v1 sashiko mentioned that some IRQs may fire after bp->ptp freed.
  it looks like a false positive, because ptp_clock_unregister() will
  explicitly disable all EXTTS channels before destroying ptp_clock
  structure. But there is a possibility of timestampers being active
  without PTP_PF_EXTTS function set. It can be done through sysfs files
  and it will change pins configuration directly, but can only be done
  for TS1..TS4. Disable them explicitly after detaching sysfs files.
---

 drivers/ptp/ptp_ocp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index beacc2ffb166..c03db15838ce 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4867,6 +4867,18 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	timer_delete_sync(&bp->watchdog);
+	/* Disable interrupts on all timestampers */
+	if (bp->ts1)
+		ptp_ocp_ts_enable(bp->ts1, 0, false)
+	if (bp->ts2)
+		ptp_ocp_ts_enable(bp->ts2, 0, false)
+	if (bp->ts3)
+		ptp_ocp_ts_enable(bp->ts3, 0, false)
+	if (bp->ts4)
+		ptp_ocp_ts_enable(bp->ts4, 0, false)
+	if (bp->ptp)
+		ptp_clock_unregister(bp->ptp);
+	kfree(bp->ptp_info.pin_config);
 	ptp_ocp_unregister_ext(bp->ts0);
 	ptp_ocp_unregister_ext(bp->ts1);
 	ptp_ocp_unregister_ext(bp->ts2);
@@ -4884,9 +4896,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 		clk_hw_unregister_fixed_rate(bp->i2c_clk);
 	if (bp->n_irqs)
 		pci_free_irq_vectors(bp->pdev);
-	if (bp->ptp)
-		ptp_clock_unregister(bp->ptp);
-	kfree(bp->ptp_info.pin_config);
 	device_unregister(&bp->dev);
 }
 
-- 
2.47.3

