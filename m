Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08972435EE9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785506; cv=none; b=n1LaN/qBOOUHcU3il75YNPiKXnPW7g4SwpJ0UDligSJCvyi0/JODn2K9e3M9VSSgQ2oH4aO1V6tzxdDPqHTxFvuOAG8R/eJrWSlRyxgavPw/ZdB9kew+G0mX/EQxKZlTKBJUXrq9llO9Lxa4MJqeEWBvT8A2hdHzIBAXha7aP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785506; c=relaxed/simple;
	bh=/ARwURb6a7VMCDkPAD5QhDVRtXxsungKbzhzeyLVaOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqWf7U5ujyRtaVZ2PQYdCX8sLcDwY4TYM7qKjmeUhPhMT9mKNsHru12mk72Gol0fMQ9xLnD3iBgsEy/i9tl+byJvOkyDJcLzly1LKlIemV/ZMnnZ0ccOS8CDX6GQhnp/kA89Ix+0JOGfphq8YLKTnUtARq1282yiH/Rth3ZKCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0XpCJfl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0XpCJfl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7EB1F00A3D;
	Mon,  3 Aug 2026 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785504;
	bh=qE/YXiDW4dBGytcb8JKK0Gr3dm0GRK/1VxYyruLkXa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m0XpCJflcIbVf3dSGqjjAmAPQPZCUrpLS2lsIZzZONjqckHg0j6VJx1VVYoryX69u
	 Hxr8z9HzzrWJ9P419DLcueiiETiHK2aLt+FQHrDazZgxZyrA0XxZD4M0nSiFd/omz7
	 hgyXWrNdg9MVAjd0KEn4mM0BL9yyPdbxN8T2mQUqFONwsadM3Tp2Gz9yCdqTiGGY13
	 d0lhePjQhvIGTJj8GjMHlMIi9OHbFuaxLiRzz8HemnCYZY0v9xeyNHM7JQGp8CGNw1
	 7KvTdGDXIspsRMH2+YqSMzcqfMqlOte88U6FA0nFkcpl+dklhndf4Zl471msdkI7zK
	 1VgyKXGxuQjZQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	manoj.panicker2@amd.com,
	somnath.kotur@broadcom.com,
	andrew.gospodarek@broadcom.com,
	wei.huang2@amd.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/4] eth: bnxt: keep the aRFS rmap updated when TPH is enabled
Date: Mon,  3 Aug 2026 12:31:33 -0700
Message-ID: <20260803193135.2030368-3-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803193135.2030368-1-kuba@kernel.org>
References: <20260803193135.2030368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPH support must have broken aRFS in bnxt. IRQ can only have one
notifier, so installing the TPH notifier is overriding the one implicitly
installed by irq_cpu_rmap_add().

Make sure we call cpu_rmap_update() from the TPH notifier.

We need to be careful with the ordering and not free the rmap
until we unregistered the notifier. Note that moving the rmap
freeing after the early return in bnxt_free_irq() is fine -
there's no path that could leave rmap with irq_tbl being NULL.

Fixes: c214410c47d6 ("bnxt_en: Add TPH support in BNXT driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4a2a44ffe669..47bea6d8ee3e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11774,6 +11774,16 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 
 	irq = container_of(notify, struct bnxt_irq, affinity_notify);
 
+#ifdef CONFIG_RFS_ACCEL
+	if (irq->bp->dev->rx_cpu_rmap && irq->ring_nr < irq->bp->rx_nr_rings) {
+		err = cpu_rmap_update(irq->bp->dev->rx_cpu_rmap, irq->ring_nr,
+				      mask);
+		if (err)
+			netdev_warn(irq->bp->dev,
+				    "aRFS rmap update failed: %d\n", err);
+	}
+#endif
+
 	if (!irq->bp->tph_mode)
 		return;
 
@@ -11847,10 +11857,6 @@ static void bnxt_free_irq(struct bnxt *bp)
 	struct bnxt_irq *irq;
 	int i;
 
-#ifdef CONFIG_RFS_ACCEL
-	free_irq_cpu_rmap(bp->dev->rx_cpu_rmap);
-	bp->dev->rx_cpu_rmap = NULL;
-#endif
 	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
@@ -11876,6 +11882,11 @@ static void bnxt_free_irq(struct bnxt *bp)
 	/* Disable TPH support */
 	pcie_disable_tph(bp->pdev);
 	bp->tph_mode = 0;
+
+#ifdef CONFIG_RFS_ACCEL
+	free_irq_cpu_rmap(bp->dev->rx_cpu_rmap);
+	bp->dev->rx_cpu_rmap = NULL;
+#endif
 }
 
 static int bnxt_request_irq(struct bnxt *bp)
-- 
2.55.0

