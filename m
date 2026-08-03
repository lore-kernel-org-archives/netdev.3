Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B87433E60
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785505; cv=none; b=lIfO6eCOBi3jaTCs1uzOQwdWfhpj/rCr9StUPqMdlLpiv1nOz3ccLlmXNZcxWXpGZHD70ia5JRQ8xx70e94JyMD7UJqhUemYrHB77pqLCDV3joznC5QHZ4PIO5GKKya9Hu1Deevq5Hz27v+vxO0hv/sMMqydmG2OBl9WcdAyFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785505; c=relaxed/simple;
	bh=14AtAdkHVcBucC+sWfvDehSa+iCUfa7DEcap7f2wdfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC4K5F4J49GdpOF/S4inqEdvKb3s8mA+hpP6DePo7KwP9Egf6WyL0Gw2z9m3QTn2qCKUdFLEuLF2dzqXA2ZjDEHEWEHAFwXrJI7oF6yRS7Fk1h+a32gJyUCCKP6cgPXR/5v8gcEtGfH9WHYrP2vRDRbmfi+bdBFpjIABD4ncjvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSi74QOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSi74QOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5170E1F00A3A;
	Mon,  3 Aug 2026 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785503;
	bh=S6JlkJQX+xluyWBVJEVoB8NcEMVCYADmYev4BFnOrbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SSi74QOfylwFKt1xlKaYTHgaWfTZ2lnLZdCEmuI34KWjQ9/67pyPVbCSdZ5vO1tDm
	 s2nyno7sx8hj6aGYp+Ho4PBawBGyi4orcOXpOcY6bAA9Q+gDs4GsKT0seNYURuKDTf
	 0/zVylH5j3HdGMol+O8NKxXkQm7DVxCXc7sNlNMxgPxIyi5UXlVbQU5syYsBZirka5
	 cPKmMZWn8HGVuCqjAVBTNRYs/oUS0DwqeiVTg9UUw2koevfetLJ01xh3RK0q+03w4v
	 fMfs9yeBhccooePo1BC4b4nM32iY8VYau1knVnDVDIgfmv1FOTg2HjG+zjf77pGDI8
	 yJUdLtSyBthLQ==
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
Subject: [PATCH net 1/4] eth: bnxt: cancel IRQ notifier before freeing affinity mask
Date: Mon,  3 Aug 2026 12:31:32 -0700
Message-ID: <20260803193135.2030368-2-kuba@kernel.org>
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

bnxt_irq_affinity_notify() copies into irq->cpu_mask.
Cancel the notifier before freeing irq->cpu_mask.

Fixes: c214410c47d6 ("bnxt_en: Add TPH support in BNXT driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7513618793da..4a2a44ffe669 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11859,14 +11859,14 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 		irq = &bp->irq_tbl[map_idx];
 		if (irq->requested) {
+			bnxt_release_irq_notifier(irq);
+
 			if (irq->have_cpumask) {
 				irq_update_affinity_hint(irq->vector, NULL);
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
 
-			bnxt_release_irq_notifier(irq);
-
 			free_irq(irq->vector, bp->bnapi[i]);
 		}
 
-- 
2.55.0

