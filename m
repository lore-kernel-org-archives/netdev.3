Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AA549383
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922115; cv=none; b=Xu7G9M5qHR1hy6brYLx/pdsHVrU6V1Cb5T7/guqX0BfPdakcygkxJoaFsnsOcOW/sN0QZq/cqXE6hkfFnQS20M8FKuECJlv1BP0LA6V9Q/Xx5GI9eUvHI8gpulGBOhzeVWH6u1I6V4KSQQ5vEngdnPOY+w+Kyqke8c36KLWVxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922115; c=relaxed/simple;
	bh=nkCXaHyulsci4+25FlzL1lifaVujHsBgtU1uXH+HSjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdEP4y6tWt2vHhZ9CBxHaOCSI5ePHjPqcoQT8nFWQnkPc8Duvbxhsz5wQDu3ihH7sd2DQC3eRt7oNi0K7HD570WyZobtjhXKV0g3jRPNfmqqDLpAEhqft24t7L0NLu2OtwIprm8WcnB3A2IGEukREnUCwi8EoJZc4sVY+H536vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UyL9yyg8; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UyL9yyg8"
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-3514b90bb89so392099eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922110; x=1792526910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HPTAkjLklbTZeRakkGsbkrTRsLZf0cNlseZNQYjTzSM=;
        b=Rzsp0ZbFRDIwSH2Tj0DLpucwjUxDJA4jPyDh87i6UNP7Ep8p/7d8FUQ/IHh6g/pip2
         wrV/wDo5ONhrJ0DSSotf1ZMfuUmmuxzlaAVZydjRAQGL3ziSZZmUWOuLNx3fTwVye3lk
         piwyeeskB+NIiy5fhsPpNMap8YgCqWygidYO1/Bbs7Z+0Aj+gogAt9Yhflgc2xX2w+Pi
         PpXGFFt4+u0LPm2h/erCzNTd2IVzx8wmtd5ymj4HQ+RbNnoQeH+J9i/I82W0nDohOiYI
         RYv6MBJ801YXovoOueCQEqMhczmTAXhYDqk+qFwlMhsEMMFMxzBAtzPkVI8y2HaABqB2
         E2uA==
X-Gm-Message-State: AFq9FYLU9k23mT/H508KG1XKzRIBDW+zzO24PnxVHkgyUhw2xEQ1bQeX
	OdMbrUP9mcd6WsAJvQnMbzmo/s5aoP5cM2zO6PZ/y7RqwDkALvHrWg/EaC2zC1SJElW6Eba5nHs
	mVC0LdtmizFNkqW4sivKEB8tH6wAwnp1jqyilWvc3DT2oYOvMdyTbR5Ps2O7ECNLHQ5WzymRh10
	G1YlPoVE0zKYTfVqtdTC/Q69JTNslflTMuvo7sZjJGbcYntvFdcsgyTyjvd18DVaj4MK8XzhTPF
	06YFp2a9xRVOZ1++dxnjA4=
X-Gm-Gg: AYBFou17QvfJkEAe1ZDyN3WuPVZF3PgJQ6k9GSBPCLSl/E06NJSPXZll9ZooKzGs5eT
	RykUJYShzsdayaM92pv5zU4yk9x4mHRD509eqVojcVzhPlYgDRVR0U0y0BkRItrwk8DUM3i8XX6
	juAm4Krijufd04VO9ZTfrjTKZfA72TsOQ0YYsHQb/13azgFJ+HO285Pi/7kZJipwpJyQdw8wQFW
	buw5li9oY+DoD6azHoiOA2xUgqBLyeYIQocvncIvapThDGBuejdgNqLV8R4cuU4DsYDxTUp6c7z
	zGrf4jMGIPhnNFQXv/qCJqpN0swVoCPj2PvSqcdpraXwi9fu+uVVB4PKEp0ZB52WEt5l1ZGcXiR
	raAek85VHw0KcGIWFfsomtKlhnLaSxEOdoEKBAFZsXdvWo0kcNxUH+YM+n1pusxROtn3d1gjx8z
	UAtnuVU9SJF1hGWG4ejPQ1jB+c81R4DJ4f+Dv29FHd4PF0
X-Received: by 2002:a05:7301:70b:b0:356:23dd:3c72 with SMTP id 5a478bee46e88-35623dd574fmr15270327eec.4.1791922109219;
        Tue, 13 Oct 2026 13:08:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3537cad3285sm201979eec.12.2026.10.13.13.08.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:08:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso492761c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791922107; x=1792526907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HPTAkjLklbTZeRakkGsbkrTRsLZf0cNlseZNQYjTzSM=;
        b=UyL9yyg8eYfgtvO3im9r1zgPKyaza1nABspL2eahAyY6fijlz1gGz4RQ/a82xenh9s
         BAtM85Yb0jeqOhzNOpKXD06THA9M+BzmiqgVXOMnZWXs7dBYIhP9s7ZVaEaPQOzSkDoh
         E+MDPWFoLNb5MgXAv7uC0eYGiziBDZlMYggSI=
X-Received: by 2002:a05:701b:2910:b0:14a:a6dc:9ca6 with SMTP id a92af1059eb24-16a5888bf17mr16919538c88.3.1791922107119;
        Tue, 13 Oct 2026 13:08:27 -0700 (PDT)
X-Received: by 2002:a05:701b:2910:b0:14a:a6dc:9ca6 with SMTP id a92af1059eb24-16a5888bf17mr16919470c88.3.1791922105865;
        Tue, 13 Oct 2026 13:08:25 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm39526585c88.11.2026.10.13.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:08:25 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net-next v3 5/5] bnge: make NQ0 persistent across open/stop cycles
Date: Wed, 14 Oct 2026 01:36:45 +0530
Message-ID: <20261013200645.1346299-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
References: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

NQ0 is currently created in ndo_open(), so firmware async events are not
received while the interface is down. This change lets NQ0 receive async
events in the down state, but sp_task bails out unless BNGE_STATE_OPEN is
set. Down-state event processing is left to subsequent patches.

Focus this patch strictly on making NQ0 persistent across
ndo_stop/ndo_open cycles:

- probe:  Allocate NQ0, register its NAPI, request its IRQ, allocate
          the HWRM ring, configure it as the async event completion
          ring (a failure is only warned about, as before), then
          enable its NAPI and arm it.
- open:   Allocate/create NQ1..N and attach queue 0's RX/TX and completion
          rings to NQ0.
- close:  Destroy NQ1..N and detach rings from NQ0, leaving NQ0 to handle
          async events only.
- remove: Destroy NQ0 before the timer and workqueue, as NQ0 queues
          sp_task on async events.

NQ0's NAPI keeps running while the interface is down, so quiesce it
while the host ring structures (Rx, Tx, etc.) are allocated on open and
freed on close. Async events NQ0 receives while down are ignored by
sp_task, so open also clears sp_event while NQ0 is quiesced, and resumes
NQ0 only after BNGE_STATE_OPEN is set, together with the other NQs.
Introduce bnge_nq_drain() to drop pending NQEs on NQ0 once the completion
rings they refer to are gone, while still handling HWRM and async event
completions. Call it with NQ0's NAPI disabled.

For the same reason, bnge_napi_poll() now ignores a CQ notification whose
index is beyond the current completion ring count, instead of indexing
the freed cp_ring_arr.

Only the NQ, its IRQ and its NAPI persist. NQ0 is skipped, via
bnge_for_each_open_nq(), when enabling NQ interrupts, adding/deleting
and enabling/disabling NAPI, requesting/freeing IRQs, naming IRQs,
allocating/freeing NQ rings and the firmware NQ, and its firmware ring
ID is carried over in grp_info[0]. Its completion rings, cp_ring_arr and
stats remain per-open.

Give NQ0 a stable <pci_name>-nq0 IRQ name and retain the existing names
for NQs created during open. As a result, the vector serving queue 0 is
listed in /proc/interrupts under the <pci_name>-nq0 name instead of
<ifname>-TxRx-0, and stays requested while the interface is down.

Set BNGE_FIRST_OPEN_NQ to 1, shifting aux (RoCE) vectors to irq_tbl[1..]
as prepared by earlier patches.

The async event completion ring is now configured once at probe rather
than on every open. This relies on firmware keeping NQ0 allocated, and
the async event completion ring configured, across FUNC_DRV_IF_CHANGE
down/up. Recreating NQ0 after a firmware reset is not handled here.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  13 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 185 ++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  42 ++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   1 +
 5 files changed, 225 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 13452caa9081..950f40d69916 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -239,14 +239,15 @@ struct bnge_dev {
 #define bnge_dbg(bd, fmt, ...)	bnge_log(dbg, bd, fmt, ##__VA_ARGS__)
 
 /* Index of the first NQ created in ndo_open() and destroyed in ndo_stop().
- * NQs below it are created at probe and destroyed at remove. It starts at 0,
- * i.e. all NQs are open NQs, until NQ0 moves to probe.
+ * NQs below it are created at probe and destroyed at remove. Exactly one NQ,
+ * NQ0 (async events and queue 0), is created at probe.
  *
- * Layout of bd->irq_tbl: the NQs created at probe (none yet) come first,
- * then the aux (RoCE) vectors, then the NQs created in open. The ring_idx
- * the aux device receives is its irq_tbl index.
+ * Layout of bd->irq_tbl, with A = aux MSI-X count: NQ0 uses irq_tbl[0],
+ * the aux (RoCE) device irq_tbl[1..A], and the NQs created in open
+ * irq_tbl[A + 1..]. The ring_idx the aux device receives is its irq_tbl
+ * index.
  */
-#define BNGE_FIRST_OPEN_NQ	0
+#define BNGE_FIRST_OPEN_NQ	1
 
 #define bnge_for_each_open_nq(i, bd) \
 	for ((i) = BNGE_FIRST_OPEN_NQ; (i) < (bd)->nq_nr_rings; (i)++)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dc6cf3525034..c6649a2c5876 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1209,10 +1209,20 @@ static int bnge_init_ring_grps(struct bnge_net *bn)
 		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 	}
+	/* NQ0 stays allocated in FW across open/close */
+	bn->grp_info[0].nq_fw_ring_id =
+		(u16)bn->nq0->nq_ring.ring_struct.fw_ring_id;
 
 	return 0;
 }
 
+static void bnge_nq0_clear_rings(struct bnge_net *bn)
+{
+	bn->nq0->rx_ring = NULL;
+	memset(bn->nq0->tx_ring, 0, sizeof(bn->nq0->tx_ring));
+	bn->nq0->events = 0;
+}
+
 static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_vnic_attributes(bn);
@@ -1229,6 +1239,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bn->tx_ring = NULL;
 	kfree(bn->rx_ring);
 	bn->rx_ring = NULL;
+	bnge_nq0_clear_rings(bn);
 	kfree(bn->bnapi);
 	bn->bnapi = NULL;
 }
@@ -1243,12 +1254,15 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	arr_size = L1_CACHE_ALIGN(sizeof(struct bnge_napi *) *
 			bd->nq_nr_rings);
 	size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
-	bnapi = kzalloc(arr_size + size * bd->nq_nr_rings, GFP_KERNEL);
+	bnapi = kzalloc(arr_size +
+			size * (bd->nq_nr_rings - BNGE_FIRST_OPEN_NQ),
+			GFP_KERNEL);
 	if (!bnapi)
 		return rc;
 
 	bn->bnapi = bnapi;
 	bnapi += arr_size;
+	bn->bnapi[0] = bn->nq0;
 	bnge_for_each_open_nq(i, bd) {
 		bn->bnapi[i] = bnapi;
 		bn->bnapi[i]->index = i;
@@ -1360,6 +1374,7 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	kfree(bn->rx_ring);
 	bn->rx_ring = NULL;
 err_free_bnapi:
+	bnge_nq0_clear_rings(bn);
 	kfree(bn->bnapi);
 	bn->bnapi = NULL;
 	return rc;
@@ -1973,18 +1988,12 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	agg_rings = !!(bnge_is_agg_reqd(bd));
 	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
-		struct bnge_ring_struct *ring = &bnapi->nq_ring.ring_struct;
 
 		rc = bnge_hwrm_nq_alloc(bn, bnapi);
 		if (rc)
 			goto err_out;
-		bn->grp_info[i].nq_fw_ring_id = (u16)ring->fw_ring_id;
-
-		if (!i) {
-			rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
-			if (rc)
-				netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
-		}
+		bn->grp_info[i].nq_fw_ring_id =
+			(u16)bnapi->nq_ring.ring_struct.fw_ring_id;
 	}
 
 	for (i = 0; i < bd->tx_nr_rings; i++) {
@@ -2625,6 +2634,9 @@ static void bnge_setup_msix(struct bnge_net *bn)
 	int len, i;
 
 	len = sizeof(bd->irq_tbl[0].name);
+	/* NQ0 keeps the "<pci_name>-nq0" name set in bnge_nq0_init(). Only the
+	 * NQs created in open are named after the netdev here.
+	 */
 	bnge_for_each_open_nq(i, bd) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		char *attr;
@@ -2870,6 +2882,129 @@ static void bnge_del_napi(struct bnge_net *bn)
 	synchronize_net();
 }
 
+static void bnge_nq0_quiesce(struct bnge_net *bn)
+{
+	napi_disable_locked(&bn->nq0->napi);
+	/* Wait for RCU grace period after napi_disable_locked(): a poll can
+	 * still be arming the NQ doorbell after it clears NAPI_STATE_SCHED.
+	 */
+	synchronize_net();
+	bnge_db_nq(bn, &bn->nq0->nq_ring.nq_db, bn->nq0->nq_ring.nq_raw_cons);
+}
+
+static void bnge_nq0_resume(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr = &bn->nq0->nq_ring;
+
+	bn->nq0->in_reset = false;
+	bn->nq0->tx_fault = 0;
+	napi_enable_locked(&bn->nq0->napi);
+	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+}
+
+static int bnge_nq0_init(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	struct bnge_irq *irq;
+	int rc;
+
+	bnapi = kzalloc_obj(*bnapi);
+	if (!bnapi)
+		return -ENOMEM;
+
+	/* NQ0 helpers hard-code NQ index 0 */
+	BUILD_BUG_ON(BNGE_FIRST_OPEN_NQ != 1);
+
+	bnapi->bn = bn;
+	bnapi->index = 0;
+	bn->nq0 = bnapi;
+	nqr = &bnapi->nq_ring;
+
+	rc = bnge_alloc_nq(bn, bnapi);
+	if (rc)
+		goto err_free_bnapi;
+
+	irq = &bd->irq_tbl[nqr->ring_struct.map_idx];
+	irq->handler = bnge_msix;
+	snprintf(irq->name, sizeof(irq->name), "%s-nq0", pci_name(bd->pdev));
+
+	/* The netdev is not registered yet, but the *_locked() NAPI helpers
+	 * expect the instance lock to be held.
+	 */
+	netdev_lock(dev);
+	netif_napi_add_config_locked(dev, &bnapi->napi, bnge_napi_poll,
+				     bnapi->index);
+
+	rc = bnge_nq_request_irq(bn, bnapi);
+	if (rc)
+		goto err_del_napi;
+
+	rc = bnge_hwrm_nq_alloc(bn, bnapi);
+	if (rc)
+		goto err_free_irq;
+
+	rc = bnge_hwrm_set_async_event_cr(bd, nqr->ring_struct.fw_ring_id);
+	if (rc) {
+		bnge_err(bd, "Failed to set async event completion ring: %d\n",
+			 rc);
+		goto err_free_irq;
+	}
+
+	/* Enable NAPI only now that the NQ doorbell is set up, so an early
+	 * interrupt cannot make the poll arm an uninitialized doorbell.
+	 */
+	napi_enable_locked(&bnapi->napi);
+	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	netdev_unlock(dev);
+	return 0;
+
+err_free_irq:
+	bnge_nq_free_irq(bn, bnapi);
+	__netif_napi_del_locked(&bnapi->napi);
+	netdev_unlock(dev);
+	/* Same order as bnge_nq0_uninit(): no poll may touch the NQ once the
+	 * FW ring is freed.
+	 */
+	synchronize_net();
+	bnge_hwrm_nq_free(bn, bnapi);
+	bnge_free_nq(bn, bnapi);
+	goto err_free_bnapi;
+err_del_napi:
+	__netif_napi_del_locked(&bnapi->napi);
+	netdev_unlock(dev);
+	synchronize_net();
+	bnge_free_nq(bn, bnapi);
+err_free_bnapi:
+	kfree(bnapi);
+	bn->nq0 = NULL;
+	return rc;
+}
+
+static void bnge_nq0_uninit(struct bnge_net *bn)
+{
+	struct net_device *dev = bn->netdev;
+	struct bnge_napi *bnapi = bn->nq0;
+
+	netdev_lock(dev);
+	napi_disable_locked(&bnapi->napi);
+	bnge_nq_free_irq(bn, bnapi);
+	__netif_napi_del_locked(&bnapi->napi);
+	netdev_unlock(dev);
+	/* Wait for RCU grace period after removing the NAPI instance, and for
+	 * a poll that may still be arming the NQ doorbell, before destroying
+	 * the FW ring.
+	 */
+	synchronize_net();
+
+	bnge_hwrm_nq_free(bn, bnapi);
+	bnge_free_nq(bn, bnapi);
+	kfree(bnapi);
+	bn->nq0 = NULL;
+}
+
 static int bnge_init_nic(struct bnge_net *bn)
 {
 	int rc;
@@ -2976,10 +3111,17 @@ static int bnge_open_core(struct bnge_net *bn)
 		goto err_if_change;
 	}
 
+	bnge_nq0_quiesce(bn);
+
+	/* Drop async events NQ0 received while down. Its NAPI is quiesced, so
+	 * nothing can set bits concurrently.
+	 */
+	WRITE_ONCE(bn->sp_event, 0);
+
 	rc = bnge_alloc_core(bn);
 	if (rc) {
 		netdev_err(bn->netdev, "bnge_alloc_core err: %d\n", rc);
-		goto err_if_change;
+		goto err_nq0_resume;
 	}
 
 	bnge_init_napi(bn);
@@ -3011,6 +3153,8 @@ static int bnge_open_core(struct bnge_net *bn)
 	set_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
 
 	bnge_enable_int(bn);
+	/* Resume NQ0 with the other NQs, once BNGE_STATE_OPEN is set */
+	bnge_nq0_resume(bn);
 
 	bnge_tx_enable(bn);
 
@@ -3022,10 +3166,13 @@ static int bnge_open_core(struct bnge_net *bn)
 	return 0;
 
 err_free_irq:
+	bnge_nq_drain(bn, bn->nq0);
 	bnge_free_irq(bn);
 err_del_napi:
 	bnge_del_napi(bn);
 	bnge_free_core(bn);
+err_nq0_resume:
+	bnge_nq0_resume(bn);
 err_if_change:
 	bnge_hwrm_if_change(bd, false);
 	return rc;
@@ -3238,6 +3385,8 @@ static void bnge_close_core(struct bnge_net *bn)
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+	bnge_nq0_quiesce(bn);
+	bnge_nq_drain(bn, bn->nq0);
 
 	/* Save ring stats before shutdown */
 	spin_lock_bh(&bn->stats_lock);
@@ -3250,6 +3399,7 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_del_napi(bn);
 
 	bnge_free_core(bn);
+	bnge_nq0_resume(bn);
 }
 
 static int bnge_close(struct net_device *dev)
@@ -3259,7 +3409,6 @@ static int bnge_close(struct net_device *dev)
 	bnge_close_core(bn);
 	bnge_hwrm_shutdown_link(bn->bd);
 	bnge_hwrm_if_change(bn->bd, false);
-	bn->sp_event = 0;
 
 	return 0;
 }
@@ -3593,14 +3742,23 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	spin_lock_init(&bn->stats_lock);
 
 	netdev->request_ops_lock = true;
+
+	rc = bnge_nq0_init(bn);
+	if (rc) {
+		dev_err(bd->dev, "NQ0 init failed rc: %d\n", rc);
+		goto err_free_port_stats;
+	}
+
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
-		goto err_free_port_stats;
+		goto err_uninit_nq0;
 	}
 
 	return 0;
 
+err_uninit_nq0:
+	bnge_nq0_uninit(bn);
 err_free_port_stats:
 	bnge_free_port_stats(bn);
 err_free_workq:
@@ -3620,6 +3778,9 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
 	unregister_netdev(netdev);
 
+	/* NQ0 can queue sp_task; destroy it before the timer and workqueue */
+	bnge_nq0_uninit(bn);
+
 	timer_shutdown_sync(&bn->timer);
 	cancel_work_sync(&bn->sp_task);
 	bn->sp_event = 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 476b5bab96fe..118a2e4f5331 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -315,6 +315,8 @@ struct bnge_net {
 	u32			hash_seed;
 	u64			toeplitz_prefix;
 
+	/* Lives from probe to remove. bnapi[0] points to it. */
+	struct bnge_napi		*nq0;
 	struct bnge_napi		**bnapi;
 
 	struct bnge_rx_ring_info	*rx_ring;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 2f382514c6ea..9324ee889034 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1375,6 +1375,13 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 				break;
 
 			idx = BNGE_NQ_HDL_IDX(idx);
+			/* NQ0 outlives its completion rings: ignore a stale
+			 * notification for a CQ that no longer exists.
+			 */
+			if (unlikely(idx >= nqr->cp_ring_count)) {
+				raw_cons = NEXT_RAW_CMP(raw_cons);
+				continue;
+			}
 			cpr = &nqr->cp_ring_arr[idx];
 			cpr->had_nqe_notify = 1;
 			cpr->toggle = NQE_CN_TOGGLE(type);
@@ -1396,6 +1403,41 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+/* Consume pending NQ entries without polling the CP rings. The NQ's NAPI must
+ * be disabled (or quiesced) by the caller. HWRM events are handled, CQ
+ * notifications are dropped. cpr->had_nqe_notify is not reset, so the CP rings
+ * must be freed or re-initialised afterwards.
+ */
+void bnge_nq_drain(struct bnge_net *bn, struct bnge_napi *bnapi)
+{
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	u32 raw_cons = nqr->nq_raw_cons;
+
+	while (1) {
+		u32 cons = RING_CMP(bn, raw_cons);
+		struct nqe_cn *nqcmp;
+		u16 type;
+
+		nqcmp = &nqr->desc_ring[CP_RING(cons)][CP_IDX(cons)];
+		if (!NQ_CMP_VALID(bn, nqcmp, raw_cons))
+			break;
+
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+
+		type = le16_to_cpu(nqcmp->type);
+		if (NQE_CN_TYPE(type) != NQ_CN_TYPE_CQ_NOTIFICATION)
+			bnge_hwrm_handler(bn, (struct tx_cmp *)nqcmp);
+		raw_cons = NEXT_RAW_CMP(raw_cons);
+	}
+
+	nqr->has_more_work = 0;
+	nqr->nq_raw_cons = raw_cons;
+	BNGE_DB_NQ(bn->bd, &nqr->nq_db, raw_cons);
+}
+
 static u16 bnge_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index bd0aa6c221a4..5779b78fb6a2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -120,6 +120,7 @@ irqreturn_t bnge_msix(int irq, void *dev_instance);
 netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
+void bnge_nq_drain(struct bnge_net *bn, struct bnge_napi *bnapi);
 netdev_features_t bnge_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
-- 
2.47.3

