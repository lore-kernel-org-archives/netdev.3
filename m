Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360B2737E3
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440275; cv=none; b=E+sxV9RucZKzQf5EV7q40R3vGhoI8dw986d30MWv8t/OKdaBE440LitB291GEzaAX4v3DAX6nscTm6VjxhXh14mMyVyVyDG9hU7Y07YilpJOLwTpIvrOB+y/h+69J1LzyRnL38Gz7jXG0KknmoiWEZoYrKwoSRyNKDELn+44etU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440275; c=relaxed/simple;
	bh=lig8eQIJT/YsmcN/8Cz5lLnyu/fmd5QKPODFHyG+1q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKGEnLfVFvH3Y6RD0j8+WauTagmzDnckeBnSSajzLE024j0ibmRX7eLDUT8UFK9j/aOBb/QXKdDPHbqvvlnjoEk497Nd4g2EZUohX1xws8jkUmdcQZT0zgEDAh5BkXNxktsykjyfxEy7bZXsO/o695fZeNa/u9S5f+348DdQ6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KgtzccoR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KgtzccoR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774440271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hT0uXBQF1/fOCxYPN3rGjScizPcptYIyLDnB3lOnOjg=;
	b=KgtzccoRt8ZAjwlydpo305iE1JbzAbZqaHjfpnMKlbLQOitw1Cx8aEMvSWPkhIeMitxUpr
	lI2c0jdT4mSm69+8hMFdaji76rgvxeLznIFDTEFvCHoP5+o8m09aXWjFRKYmar1fgzTP9j
	Dw+1O7RBpWreSSzcWYWI1rMYdhKB1N4=
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
Subject: [PATCH] ptp: ocp: fix resource freeing order
Date: Wed, 25 Mar 2026 12:05:10 +0000
Message-ID: <20260325120510.34481-1-vadim.fedorenko@linux.dev>
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
 drivers/ptp/ptp_ocp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index d88ab2f86b1b..16fd4804fc6a 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4558,6 +4558,9 @@ ptp_ocp_detach(struct ptp_ocp *bp)
 	ptp_ocp_detach_sysfs(bp);
 	ptp_ocp_attr_group_del(bp);
 	timer_delete_sync(&bp->watchdog);
+	if (bp->ptp)
+		ptp_clock_unregister(bp->ptp);
+	kfree(bp->ptp_info.pin_config);
 	ptp_ocp_unregister_ext(bp->ts0);
 	ptp_ocp_unregister_ext(bp->ts1);
 	ptp_ocp_unregister_ext(bp->ts2);
@@ -4575,9 +4578,6 @@ ptp_ocp_detach(struct ptp_ocp *bp)
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

