Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D892DFF04
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763464; cv=fail; b=L/5K8urYeZqr2KoZ5hIhqBg2LiIXAgnfMn8tXWSIzxPwbtGD0LV/IQAlZex7yF2o5iJcbvZ4J+QLXE6iwjRo6gZsG2lE1SvRrT39Qt/GftBfKoqoFhxh9W5cn/fro3xNr1WAo9uyOwgkTSopi5RSuAurU/ycEKnxt6WFBHelxjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763464; c=relaxed/simple;
	bh=ptoTFb3nMgVqkD7JDcywtZFZEG9+AbN3lFVI3LFza24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTIQJrmGGOZh3Xcbg1FPco0oSImCdlTPnsqCeHLjBD5N5ocZa+bSMnxo8lmNPuyHI5tTqtMZjrahm7DPLADgVyEEAgQ92/eo1sgLDgMebDByJlNBtqiuV5jw9xnK+4YEg5IvSAzBUZk78PYFrEJp94weCGg3WU6w+YLjUyJaLto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zw7gXV0/; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zw7gXV0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGm/OgrM6wRNJ09eywbexPseatY1wuLGcPcR/1UUX6dBGG1NIpH1P7/KhuO4KiGCCkunK/qO8pOYnWtnZ7T7K8JdYnWEk8B4nMU0ckseH4C0ziZKg4eatAZpzlFN2KEzzJEFmsdrbDq1Al76y5Ier/yN5t2BbSnGpzjthbLpZGgyJnQvRsKxeIqClYjp7j0Fc61fVenFP4JWy+Xy5CAlKF7xpQQu6DlVT3MK+ItZ156bDWtRiWJTmhRngK+H1Kg+d7ANe0UdqGmGKcdZW0Fjbh7VYOvzZtu2TUJ71U8M3+zMZm2mvtuXVabyqkaAEU91Oap92HP/o1C3u+U7O7Iccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTNtESMNiQzOYNPoBL+IZCHvCxwjBmmZtKhLVvtV1C8=;
 b=snGLM7TNs+3YcrSUBC59Q8CwstGr3R7CKL4weMF31tudteZZEDV7huSZKROdXp3vmnXc28q8a3Y4/l2ma50xOYnlRWNSwHJG/LaFCe9nJRzFO4DikeGfEt7bbvsIsGvLdE9X09VuKgfh62f3dJ++wGQq1NjeC6VA1XwzEP3Cusydv/zCXTL3nf9N/x3bJzHmcNC7T6jxXxkZuGpX94JFO/tn/xs+yBwC0ySLgn+YNkyh4KnQw8ktNckghMz5tSHXHDzCj652P6c5WNhU7FYBgXiIUWIcLQrwbJnq4oOzy6krNI7JMx6egWzWpUkCvMRu69O2Tr2nk+BVsJRU9brR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTNtESMNiQzOYNPoBL+IZCHvCxwjBmmZtKhLVvtV1C8=;
 b=zw7gXV0/D2pfmbMoctt1SnY9wcxlToxLCGCPivZF2zzCY0rVRD4CkMk0NDvMOtGXGiLKUcLjAHJGdzAiEKxRDRP7qvxaNy+0DOWErMXpYQhyTaZRew2iwzlwevAP5kenhUlRsP8To6BwDDW2umwwmtVB4LtiytdVvcbH/L+xrnY=
Received: from PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::24)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:04:19 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::a3) by PH7P220CA0095.outlook.office365.com
 (2603:10b6:510:32d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 20:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 20:04:19 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 15:04:18 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v2 2/2] pds_core: fix use-after-free on workqueue during remove
Date: Mon, 29 Jun 2026 20:03:58 +0000
Message-ID: <20260629200358.2626129-3-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629200358.2626129-1-nikhil.rao@amd.com>
References: <20260629200358.2626129-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e8c838-463e-4b96-1baa-08ded6199abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DWEJQqTdeed1gVxWxXfuIWzoQ/gD7Iy3I9MAO7MVaTp3A4PnHaxF0wap0RqtMLUYqiPupMx0u84N0/gQA2RYvUDZjeo9b0o//9MmAk7wQ51iSGW2tOcDnacCZBgAjI1Wvz8LzvfW1vbyPfeuHzJySW7r1WW/7GorRPQR8Wv8dL/vQmytX0tdYoaslF3jd8b3tYZDMUxOkgrq7furEL7HsNTYJ9VG44BdAZ2OyKberzqlVh+D6qrxyW4Ad6J3rAeu6G2HI+BmXbCpk6cADrNQ5hG06q/OPmnqf4SMYo7beiGOkZ1OWs7Ie9GohD9MbiyeGPxfelBKqfHw1JIOvKmqWW7QiDh05FcAVZ8dVo3SWRiu1S/nOjmuNumGq8A9GjRKPcnYkF7KDLTsLz1sGDjQviVfYkAQDd6B3AdgH/s6NBljHL0AyBRpabtKhzlWrPFrfKNLqYAXa2Oz8zwlxaGfFtd912DUyV/Rf2vocAJvP5I+T/2HZReLbaAaCdveovwcFySNtfBYnByXnyrsxCTwxz5x8thhMiTxghgvPvJJYD8xP3MwQO+NADieUZ79APLvGCzzyl9IQg7xh2RjyfumSXfh3fjSWMH59LIjU7C1r7/dl4tJOT2YudgdnHXPClYCw4YvPkV6pr1PIg/yey6+Tl1ejc97M50jjnYsKO7DHkm/w+u2cTM4dzPBHWBW8uU/uSz0YVB2m8x8FPIKil4igA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xP64nk4pdGCfkgCArmy7yGnvKretZaJPlcdJ1R5P0Sd62LPBzAbMpIsprcWDWQicaJwBHY9PDjNh46jqTWJ7Qw0BhpN0ZNPr7jWBjjVEXaH5c7jXMNI2A8Qe1vaKJIRYHDDTzWauqT5Ux1iPPvdpEqadGnvrZUSY+/cCyM043nwfXZQL6Z+WHh7MYj0htG4LHSPuG7IQpBF2YTmXF1vju09UQ0weqUGD3qu+EgX+0MgvgY7+TnfYQhnNy4FyQRR2hN6rli+0b1SnaM0sefdDSY3/1OJ5mxzAJKbZbLOf1SxwAWClWg/aBU3Q6jg9l4xeZSc7/eL4fTQVN/C2e3vygm+0tJu+V8T2kphBPY1cTYSH6yppplOwu46wMFLeSrMBzupbw6ZiWlUtblg/a3HDC/n3Elq2SRN94ZEfY139pUxR16PN7AHBUX8ziaKSQtre
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:04:19.1474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e8c838-463e-4b96-1baa-08ded6199abe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
is called. This ordering allows two paths to queue work on the
destroyed workqueue:

1. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the error
   path in pdsc_devcmd_locked() queues health_work.

2. A NotifyQ event can trigger the ISR and queue work before free_irq()
   is called in pdsc_teardown().

Fix problem 1 by moving destroy_workqueue() after pdsc_teardown(),
ensuring the workqueue exists when health_work may be queued during
teardown.

Fix problem 2 by adding cancel_work_sync() in pdsc_qcq_free() after
free_irq(). This ensures no new ISR can queue work, and any
already-queued work is drained before freeing the qcq. Work draining
during teardown may race with intx becoming invalid, so skip returning
interrupt credits if intx is no longer assigned.

Also change pdsc_core_uninit() to free adminqcq before notifyqcq,
since adminqcq's work accesses notifyqcq via pdsc_process_notifyq().
This ensures notifyqcq remains valid while adminqcq's work drains.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 15 +++++++++++----
 drivers/net/ethernet/amd/pds_core/core.c   | 14 ++++++++++----
 drivers/net/ethernet/amd/pds_core/main.c   |  5 +++--
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 097bb092bdb8..c0d9b7e6b8c3 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -77,6 +77,7 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	unsigned long irqflags;
 	int nq_work = 0;
 	int aq_work = 0;
+	int intx;
 
 	/* Don't process AdminQ when it's not up */
 	if (!pdsc_adminq_inc_if_up(pdsc)) {
@@ -121,10 +122,16 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	qcq->accum_work += aq_work;
 
 credits:
-	/* Return the interrupt credits, one for each completion */
-	pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
-			      nq_work + aq_work,
-			      PDS_CORE_INTR_CRED_REARM);
+	/* Return the interrupt credits, one for each completion.
+	 * Use READ_ONCE to get a single consistent copy of intx since it can
+	 * be set to PDS_CORE_INTR_INDEX_NOT_ASSIGNED concurrently during
+	 * teardown, and skip the credits if so.
+	 */
+	intx = READ_ONCE(qcq->intx);
+	if (intx != PDS_CORE_INTR_INDEX_NOT_ASSIGNED)
+		pds_core_intr_credits(&pdsc->intr_ctrl[intx],
+				      nq_work + aq_work,
+				      PDS_CORE_INTR_CRED_REARM);
 	refcount_dec(&pdsc->adminq_refcnt);
 }
 
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1074a022a52f..570c0cd7339e 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -110,7 +110,8 @@ static void pdsc_qcq_intr_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 		return;
 
 	pdsc_intr_free(pdsc, qcq->intx);
-	qcq->intx = PDS_CORE_INTR_INDEX_NOT_ASSIGNED;
+	/* Pairs with READ_ONCE in pdsc_process_adminq() */
+	WRITE_ONCE(qcq->intx, PDS_CORE_INTR_INDEX_NOT_ASSIGNED);
 }
 
 static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
@@ -145,6 +146,10 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 
 	pdsc_qcq_intr_free(pdsc, qcq);
 
+	/* Drain any work queued by ISR before it was freed above */
+	if (qcq->work.func)
+		cancel_work_sync(&qcq->work);
+
 	if (qcq->q_base)
 		dma_free_coherent(dev, qcq->q_size,
 				  qcq->q_base, qcq->q_base_pa);
@@ -304,8 +309,11 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int type, unsigned int index,
 
 static void pdsc_core_uninit(struct pdsc *pdsc)
 {
-	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
+	/* Free adminqcq first: its work accesses notifyqcq, so we must
+	 * disable its IRQ and drain its work before freeing notifyqcq.
+	 */
 	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
+	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
 
 	if (pdsc->kern_dbpage) {
 		iounmap(pdsc->kern_dbpage);
@@ -479,8 +487,6 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 {
 	if (!pdsc->pdev->is_virtfn)
 		pdsc_devcmd_reset(pdsc);
-	if (pdsc->adminqcq.work.func)
-		cancel_work_sync(&pdsc->adminqcq.work);
 
 	pci_clear_master(pdsc->pdev);
 
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 22db78343eb0..638b9c7a509d 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -435,8 +435,6 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
 
 		timer_shutdown_sync(&pdsc->wdtimer);
-		if (pdsc->wq)
-			destroy_workqueue(pdsc->wq);
 
 		mutex_lock(&pdsc->config_lock);
 		set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
@@ -444,6 +442,9 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pdsc_stop(pdsc);
 		pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
 		mutex_unlock(&pdsc->config_lock);
+
+		if (pdsc->wq)
+			destroy_workqueue(pdsc->wq);
 		mutex_destroy(&pdsc->config_lock);
 		mutex_destroy(&pdsc->devcmd_lock);
 
-- 
2.43.0

