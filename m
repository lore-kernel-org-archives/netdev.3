Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB994CA784;
	Mon, 28 Sep 2026 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602902; cv=none; b=q54Vkagob8RX7kW7X5gtUcxKm5kWuuxkqycky4jAdgEwkpQVDQfN3PCDgKuKA9XVnHdAZWEydA7La41N8d5i7FLhdHhsn1V1lSLlPkGowYpPHEoNFIiZdhGtqUNFxbLoh+fzVUoimht9cx2nRwT+qft34oE0kGGrYHFYq33J50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602902; c=relaxed/simple;
	bh=AthA+8Ih4jPqncPMHLSgLMbntn50lmsUZJQWCLmT7N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVOyypOINJsVolijYRKRbIarHZIrGD/YBhayEFt85PzC1Xw5HQyS0h59X51q5wSlBwtiHUpHOPJ0VyYwVoQP/awVvtan1L0Q/4/A7VG1CJzcivoXWT9o63KI6OkaZWEM8wsav+MhWp0lrZb3Vccbfrq9I02pB+2x7za8zvF831Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Eh9qIy7b; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Eh9qIy7b"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f432;
	Mon, 28 Sep 2026 21:41:31 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: sgoutham@marvell.com,
	rkannoth@marvell.com
Cc: gakula@marvell.com,
	sbhatta@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net] net: octeontx2-af: quiesce devlink health work on teardown
Date: Mon, 28 Sep 2026 21:41:29 +0800
Message-ID: <20260928134129.145-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e83fcc3003a1kunmf0cfc4ff2001d6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHk8YVh9JHUxOGEJCSR4YTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Eh9qIy7bvJjzNVaM5YxB1dabClpl4Y9rLXwBSmSTMykkEt+sPt3AfH/1OE5ZQV1qMcUH0qYAJtBeYLNcekrFqYH7qYDFB4FUk0ht3Qsi+xtCkiOqP1JvydFOa5s+hqftKGvLSzKKMl1qSBO/2jR7oQCxko+eys3Z+uJgo86SMCQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=pjGT083KUyWFa++TGcgBN2RpwxjRH99IIs5nznarpY8=;
	h=date:mime-version:subject:message-id:from;

NPA and NIX interrupt handlers queue health-reporting work whose
containers are freed by rvu_health_reporters_destroy(). Interrupt
unregistration does not drain queued work. In addition, each reporter
setup creates a workqueue in the same field, leaking the NPA queue and
leaving no teardown handle for work queued on it.

Initialize work before later allocations can fail, share one workqueue,
unregister each set of interrupts, and cancel its work before freeing
the reporters. Destroy the shared workqueue once both reporter sets are
gone.

Fixes: f1168d1e207c ("octeontx2-af: Add devlink health reporters for NPA")
Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 .../marvell/octeontx2/af/rvu_devlink.c        | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index d63c3d33775a..c7c7230dc588 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -505,6 +505,11 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 		return -ENOMEM;
 
 	rvu_reporters->nix_event_ctx = nix_event_context;
+	INIT_WORK(&rvu_reporters->intr_work, rvu_nix_intr_work);
+	INIT_WORK(&rvu_reporters->gen_work, rvu_nix_gen_work);
+	INIT_WORK(&rvu_reporters->err_work, rvu_nix_err_work);
+	INIT_WORK(&rvu_reporters->ras_work, rvu_nix_ras_work);
+
 	rvu_reporters->rvu_hw_nix_intr_reporter =
 		devlink_health_reporter_create(rvu_dl->dl,
 					       &rvu_hw_nix_intr_reporter_ops,
@@ -545,15 +550,11 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 		return PTR_ERR(rvu_reporters->rvu_hw_nix_ras_reporter);
 	}
 
-	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
+	if (!rvu_dl->devlink_wq)
+		rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&rvu_reporters->intr_work, rvu_nix_intr_work);
-	INIT_WORK(&rvu_reporters->gen_work, rvu_nix_gen_work);
-	INIT_WORK(&rvu_reporters->err_work, rvu_nix_err_work);
-	INIT_WORK(&rvu_reporters->ras_work, rvu_nix_ras_work);
-
 	return 0;
 }
 
@@ -582,6 +583,13 @@ static void rvu_nix_health_reporters_destroy(struct rvu_devlink *rvu_dl)
 
 	if (!nix_reporters->rvu_hw_nix_ras_reporter)
 		return;
+
+	rvu_nix_unregister_interrupts(rvu);
+	cancel_work_sync(&nix_reporters->intr_work);
+	cancel_work_sync(&nix_reporters->gen_work);
+	cancel_work_sync(&nix_reporters->err_work);
+	cancel_work_sync(&nix_reporters->ras_work);
+
 	if (!IS_ERR_OR_NULL(nix_reporters->rvu_hw_nix_intr_reporter))
 		devlink_health_reporter_destroy(nix_reporters->rvu_hw_nix_intr_reporter);
 
@@ -594,7 +602,6 @@ static void rvu_nix_health_reporters_destroy(struct rvu_devlink *rvu_dl)
 	if (!IS_ERR_OR_NULL(nix_reporters->rvu_hw_nix_ras_reporter))
 		devlink_health_reporter_destroy(nix_reporters->rvu_hw_nix_ras_reporter);
 
-	rvu_nix_unregister_interrupts(rvu);
 	kfree(rvu_dl->rvu_nix_health_reporter->nix_event_ctx);
 	kfree(rvu_dl->rvu_nix_health_reporter);
 }
@@ -1059,6 +1066,11 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 		return -ENOMEM;
 
 	rvu_reporters->npa_event_ctx = npa_event_context;
+	INIT_WORK(&rvu_reporters->intr_work, rvu_npa_intr_work);
+	INIT_WORK(&rvu_reporters->err_work, rvu_npa_err_work);
+	INIT_WORK(&rvu_reporters->gen_work, rvu_npa_gen_work);
+	INIT_WORK(&rvu_reporters->ras_work, rvu_npa_ras_work);
+
 	rvu_reporters->rvu_hw_npa_intr_reporter =
 		devlink_health_reporter_create(rvu_dl->dl,
 					       &rvu_hw_npa_intr_reporter_ops,
@@ -1099,15 +1111,11 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 		return PTR_ERR(rvu_reporters->rvu_hw_npa_ras_reporter);
 	}
 
-	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
+	if (!rvu_dl->devlink_wq)
+		rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
 		return -ENOMEM;
 
-	INIT_WORK(&rvu_reporters->intr_work, rvu_npa_intr_work);
-	INIT_WORK(&rvu_reporters->err_work, rvu_npa_err_work);
-	INIT_WORK(&rvu_reporters->gen_work, rvu_npa_gen_work);
-	INIT_WORK(&rvu_reporters->ras_work, rvu_npa_ras_work);
-
 	return 0;
 }
 
@@ -1136,6 +1144,13 @@ static void rvu_npa_health_reporters_destroy(struct rvu_devlink *rvu_dl)
 
 	if (!npa_reporters->rvu_hw_npa_ras_reporter)
 		return;
+
+	rvu_npa_unregister_interrupts(rvu);
+	cancel_work_sync(&npa_reporters->intr_work);
+	cancel_work_sync(&npa_reporters->gen_work);
+	cancel_work_sync(&npa_reporters->err_work);
+	cancel_work_sync(&npa_reporters->ras_work);
+
 	if (!IS_ERR_OR_NULL(npa_reporters->rvu_hw_npa_intr_reporter))
 		devlink_health_reporter_destroy(npa_reporters->rvu_hw_npa_intr_reporter);
 
@@ -1148,7 +1163,6 @@ static void rvu_npa_health_reporters_destroy(struct rvu_devlink *rvu_dl)
 	if (!IS_ERR_OR_NULL(npa_reporters->rvu_hw_npa_ras_reporter))
 		devlink_health_reporter_destroy(npa_reporters->rvu_hw_npa_ras_reporter);
 
-	rvu_npa_unregister_interrupts(rvu);
 	kfree(rvu_dl->rvu_npa_health_reporter->npa_event_ctx);
 	kfree(rvu_dl->rvu_npa_health_reporter);
 }
@@ -1176,6 +1190,10 @@ static void rvu_health_reporters_destroy(struct rvu *rvu)
 	rvu_dl = rvu->rvu_dl;
 	rvu_npa_health_reporters_destroy(rvu_dl);
 	rvu_nix_health_reporters_destroy(rvu_dl);
+	if (rvu_dl->devlink_wq) {
+		destroy_workqueue(rvu_dl->devlink_wq);
+		rvu_dl->devlink_wq = NULL;
+	}
 }
 
 /* Devlink Params APIs */
-- 
2.50.1.windows.1

