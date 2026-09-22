Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48C38423B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055079; cv=none; b=q1dakWDdYrDoV0vgP12zvwfNnjEVs78clvcNhKgfcUgdQQ1TKO2GDF2ghiWF0Ck9yWJ18vwfrvJ1OOdI2KrBbIXcNWydI7AL1POsWJJE7sI4mzCA1QhKLcFyAxRO4Y48XcstWeBpJKkEXSoof0+L1tnIq7FK6jgYFVWCKYESz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055079; c=relaxed/simple;
	bh=DthHjt8Elvy2J18eyHf7QbP7ZPdK2aXm9aR+ZcvlR/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POqmuoC1mbVqGTg+8E/LXUxsqyzuo34aWaWZgvQUuQYvaanOGXo+OA0RUg1QE0CMR4TTxrYZ0xhD3YJ2Lyld2kuIN/LCvwMRcwv46BV/mZhhB0w0vZuI2PpdRbjFtjtwuTUTnhKAycr01Wc95WAZ7mOQajjB3Rmq0ALPttc+Ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E3TzpNTv; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E3TzpNTv"
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-4827cc09f20so385027fac.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055074; x=1790659874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhqzrfgSCVnm44xvZ8EipJaXe2pVIyUoOZLXecc8Sj4=;
        b=ZLmXplrZb50dWxL/pDBY5PqBVQp50Sb5EzvijLUFS38EqsIm2z3lGdkZRO+2Az4OAT
         UXQ8ZpuiKYjyt7rO020ENnnV0nneaf20O45/pfV52o0b4vTUdVsmdi0xd4xGfC2UUkKC
         2JaRVD9u5nkAwlE8SwmhJLnuvc9ISyYyvy45SOwJ32frzN/V8x7H83uFNAoDPSb/2iJp
         aHyaeWcEOYqniNvA3kMO0pMxE2twGQUQJLlee+beyhzPR6lY9J38BpYeu5sTDhxXpdA4
         AMWc1DuZAfIanGOVanIk2sMRjldmJtbMuZ0ol1GcoElyKwFFbA/wZhzY/pYhFte5fn8N
         FtcQ==
X-Gm-Message-State: AFuF++nZ+CUA1NPjfa15hS6lBfCgzUssuUUjtTvTQBdVmclyiQbX7kw5
	ARbFGBICg7nbq6JdhbBL6+pPfCaI1/JX4vjMlHuxqt13XZMLdV5GnvjPUlEqJY3uLUcAwlNDOoe
	1ZHAsIFvrgqfWXZP76UMwP67hr457L7dLZU63RE08q5B2SLTFPPtEv1s2mm+lXvyoNOpQp6curo
	7ogVE/MYG/p+UUIrpSpsCn6fTRdf+yvz/AabdajVnEq+vTz2mKLQZQDqXhbki0IU0PapyBkoNi/
	owa7M/DqReqnhWXDw==
X-Gm-Gg: AYBFou2xgcKIlXDSroTPvoyIamCWhPhi1S1TA6GnTUGZSl5/PedfH8w+guD9SDB6l4H
	RIxiYxWVb3iVY2luPKVzUfF/S9j6st+G3qHzCL9PpDcIjEYeANxu5v7WfM+t/d+Nm7zgxWK5apT
	s4f6KEVf2eAP/+GYJ0p54/HA/TXIeTcVuOv+AI3J0MihcLjQe+84Vql4KJzv46a2XdJq7Puql0G
	ZDTtyeIF36SLZsz9pZmZ7bpe0SsDVKyxxCGfLkKT98tB6tO4WT+VPuNL+rlEqgtHGHoRhDpAg2M
	/BuWVKkm7hss/Pt+JtC7G1mWu6TwRewFRjDJKv3GQMwYxqauUm24K9LQ9t7KH+rLWZa/Eo5DRiz
	E708aZ1fTG0aLj5DasB+sWDcyxexKp7tUTws+bZhRao0xzIJqZ0JHcn648rG3ENm0eu5FXd7F5E
	Q60xj9Twqz+p1z0dn78LacMRZFNAmpu8DhNjYk+CDZ4/jG
X-Received: by 2002:a05:6871:14f:b0:462:ef7d:2a4c with SMTP id 586e51a60fabf-48fe3d43c3cmr145709fac.8.1790055073752;
        Mon, 21 Sep 2026 22:31:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-48fc47f8cbbsm34497fac.8.2026.09.21.22.31.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:31:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e18af9f48so754052a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055072; x=1790659872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhqzrfgSCVnm44xvZ8EipJaXe2pVIyUoOZLXecc8Sj4=;
        b=E3TzpNTv8HSb+UhBi2I8qE8Hq25t/CSFyW6mP4+L4THypfm+W2BeQiC+syNTUZM5vN
         WaALgrho+qzsnNmJCQrAWykgQkRe7IedneIAfqKJYQSdEtTCkU/Eft3d7ISP8irWkSqm
         HC3iJOZXhpH9OlL2js0nL8oJW3YwIUTtVALLQ=
X-Received: by 2002:a17:90b:3d89:b0:3a0:25f0:d897 with SMTP id 98e67ed59e1d1-3a073236bb6mr35725a91.46.1790055071739;
        Mon, 21 Sep 2026 22:31:11 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:3a0:25f0:d897 with SMTP id 98e67ed59e1d1-3a073236bb6mr35706a91.46.1790055071238;
        Mon, 21 Sep 2026 22:31:11 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:31:09 -0700 (PDT)
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
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH net-next v2 6/6] bnge: Create NQ0 during probe and keep active across open/close
Date: Tue, 22 Sep 2026 10:59:04 +0530
Message-ID: <20260922052904.59237-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
References: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Set up NQ0 during probe and free it at remove. Skip NQ0 in open/close
ring, IRQ, and NAPI helpers once BNGE_NAPI_NQ0 is set.

bnge_reinit_nq0() re-creates NQ0 on open if its MSI-X vector no longer
matches the aux device's current reservation.

Also guard bnge_napi_poll() against stale completions for rings freed by
bnge_free_nq_tree().

Since NQ0 now needs its own MSI-X vector, fix bnge_alloc_irqs() to
require "aux_msix + min" vectors instead of just "aux_msix".

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 255 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   3 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  15 ++
 4 files changed, 261 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 1c12282d7e88..c19b51221fa8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -26,6 +26,10 @@
 #include "bnge_rmem.h"
 #include "bnge_txrx.h"
 
+static void bnge_free_nq0(struct bnge_net *bn, bool locked);
+static int bnge_setup_nq0(struct bnge_net *bn, bool locked);
+static int bnge_reinit_nq0(struct bnge_net *bn);
+
 #define BNGE_RING_TO_TC_OFF(bd, tx)	\
 	((tx) % (bd)->tx_nr_rings_per_tc)
 
@@ -527,6 +531,9 @@ static void bnge_free_nq_arrays(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		bnge_free_nq_desc_arr(&bnapi->nq_ring);
 	}
 }
@@ -539,6 +546,9 @@ static int bnge_alloc_nq_arrays(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
 		if (rc)
 			goto err_free_nq_arrays;
@@ -564,7 +574,8 @@ static void bnge_free_nq_tree(struct bnge_net *bn)
 		nqr = &bnapi->nq_ring;
 		ring = &nqr->ring_struct;
 
-		bnge_free_ring(bd, &ring->ring_mem);
+		if (!BNGE_NQ0_NAPI(bnapi))
+			bnge_free_ring(bd, &ring->ring_mem);
 
 		if (!nqr->cp_ring_arr)
 			continue;
@@ -664,11 +675,13 @@ static int bnge_alloc_nq_tree(struct bnge_net *bn)
 		nqr->bnapi = bnapi;
 		ring = &nqr->ring_struct;
 
-		rc = bnge_alloc_ring(bd, &ring->ring_mem);
-		if (rc)
-			goto err_free_nq_tree;
+		if (!BNGE_NQ0_NAPI(bnapi)) {
+			rc = bnge_alloc_ring(bd, &ring->ring_mem);
+			if (rc)
+				goto err_free_nq_tree;
 
-		ring->map_idx = ulp_msix + i;
+			ring->map_idx = ulp_msix + i;
+		}
 
 		if (i < bd->rx_nr_rings) {
 			cp_count++;
@@ -1252,6 +1265,10 @@ static int bnge_init_ring_grps(struct bnge_net *bn, bool irq_re_init)
 		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].rx_fw_ring_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
+
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
 		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 	}
 
@@ -1270,6 +1287,9 @@ static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
 	int i, size, arr_size;
 	void *bnapi;
 
+	if (!bd->nq_nr_rings)
+		return -ENOMEM;
+
 	arr_size = L1_CACHE_ALIGN(sizeof(struct bnge_napi *) *
 			bd->nq_nr_rings);
 	size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
@@ -1407,6 +1427,10 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_core;
 
+	rc = bnge_reinit_nq0(bn);
+	if (rc)
+		goto err_free_core;
+
 	bnge_quiesce_nq0(bn);
 	rc = bnge_alloc_nq_tree(bn);
 	if (rc)
@@ -1455,8 +1479,11 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		struct bnge_ring_struct *ring = &nqr->ring_struct;
 
-		nqr->nq_raw_cons = 0;
-		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+		if (!BNGE_NQ0_NAPI(bn->bnapi[i])) {
+			nqr->nq_raw_cons = 0;
+			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+		}
+
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
 
@@ -1983,6 +2010,9 @@ static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
 	u32 map_idx;
 	int rc;
 
+	if (BNGE_NQ0_NAPI(bnapi))
+		return 0;
+
 	nqr = &bnapi->nq_ring;
 	ring = &nqr->ring_struct;
 	map_idx = ring->map_idx;
@@ -2007,6 +2037,171 @@ static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
 	return 0;
 }
 
+static void bnge_free_nq0(struct bnge_net *bn, bool locked)
+{
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	struct bnge_irq *irq;
+
+	if (!bn->bnapi)
+		return;
+
+	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	if (!BNGE_NQ0_NAPI(bnapi))
+		return;
+
+	nqr = &bnapi->nq_ring;
+	ring = &nqr->ring_struct;
+	irq = &bd->irq_tbl[ring->map_idx];
+
+	if (locked)
+		napi_disable_locked(&bnapi->napi);
+	else
+		napi_disable(&bnapi->napi);
+
+	synchronize_irq(irq->vector);
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+
+	if (irq->have_cpumask) {
+		irq_set_affinity_hint(irq->vector, NULL);
+		free_cpumask_var(irq->cpu_mask);
+		irq->have_cpumask = 0;
+	}
+	free_irq(irq->vector, bnapi);
+	irq->requested = 0;
+
+	if (locked)
+		__netif_napi_del_locked(&bnapi->napi);
+	else
+		netif_napi_del(&bnapi->napi);
+
+	synchronize_net();
+
+	hwrm_ring_free_send_msg(bn, ring,
+				RING_FREE_REQ_RING_TYPE_NQ,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	if (bn->grp_info)
+		bn->grp_info[0].nq_fw_ring_id = INVALID_HW_RING_ID;
+
+	clear_bit(BNGE_NAPI_QUIESCED, &bnapi->flags);
+	clear_bit(BNGE_NAPI_NQ0, &bnapi->flags);
+
+	bnge_free_ring(bd, &ring->ring_mem);
+	bnge_free_nq_desc_arr(nqr);
+}
+
+static int bnge_setup_nq0(struct bnge_net *bn, bool locked)
+{
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	struct bnge_irq *irq;
+	int map_idx, rc;
+
+	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	if (BNGE_NQ0_NAPI(bnapi))
+		return 0;
+
+	nqr = &bnapi->nq_ring;
+	ring = &nqr->ring_struct;
+	rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
+	if (rc)
+		return -ENOMEM;
+
+	nqr->nq_raw_cons = 0;
+	bnge_init_nq_ring_struct(bn, nqr);
+	rc = bnge_alloc_ring(bd, &ring->ring_mem);
+	if (rc)
+		goto err_free_nq_desc_arr;
+
+	map_idx = bnge_aux_get_msix(bd);
+	ring->map_idx = map_idx;
+	irq = &bd->irq_tbl[map_idx];
+	irq->handler = bnge_msix;
+
+	if (locked)
+		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
+					     bnge_napi_poll, bnapi->index);
+	else
+		netif_napi_add_config(bn->netdev, &bnapi->napi,
+				      bnge_napi_poll, bnapi->index);
+
+	snprintf(irq->name, sizeof(bd->irq_tbl[0].name), "%s-%s-%d", "bnge",
+		 "nq", map_idx);
+	rc = request_irq(irq->vector, irq->handler, 0, irq->name, bnapi);
+	if (rc)
+		goto err_del_napi;
+
+	if (locked)
+		netif_napi_set_irq_locked(&bnapi->napi, irq->vector);
+	else
+		netif_napi_set_irq(&bnapi->napi, irq->vector);
+	irq->requested = 1;
+
+	if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
+		int numa_node = dev_to_node(&bd->pdev->dev);
+		int cpu = cpumask_local_spread(BNGE_NQ0_NAPI_IDX, numa_node);
+
+		irq->have_cpumask = 1;
+		cpumask_set_cpu(cpu, irq->cpu_mask);
+		if (irq_set_affinity_hint(irq->vector, irq->cpu_mask)) {
+			netdev_warn(bn->netdev,
+				    "Set affinity failed, IRQ = %d\n",
+				    irq->vector);
+		}
+	}
+
+	rc = bnge_hwrm_nq_ring_alloc(bn, BNGE_NQ0_NAPI_IDX);
+	if (rc)
+		goto err_free_irq;
+
+	if (locked)
+		napi_enable_locked(&bnapi->napi);
+	else
+		napi_enable(&bnapi->napi);
+
+	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+
+	set_bit(BNGE_NAPI_NQ0, &bnapi->flags);
+
+	return 0;
+
+err_free_irq:
+	if (irq->have_cpumask) {
+		irq_set_affinity_hint(irq->vector, NULL);
+		free_cpumask_var(irq->cpu_mask);
+		irq->have_cpumask = 0;
+	}
+	free_irq(irq->vector, bnapi);
+	irq->requested = 0;
+err_del_napi:
+	if (locked)
+		__netif_napi_del_locked(&bnapi->napi);
+	else
+		netif_napi_del(&bnapi->napi);
+	bnge_free_ring(bd, &ring->ring_mem);
+err_free_nq_desc_arr:
+	bnge_free_nq_desc_arr(nqr);
+	return rc;
+}
+
+static int bnge_reinit_nq0(struct bnge_net *bn)
+{
+	struct bnge_napi *bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	struct bnge_dev *bd = bn->bd;
+
+	if (BNGE_NQ0_NAPI(bnapi) &&
+	    bnapi->nq_ring.ring_struct.map_idx == bnge_aux_get_msix(bd))
+		return 0;
+
+	bnge_free_nq0(bn, true);
+	return bnge_setup_nq0(bn, true);
+}
+
 static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2419,6 +2614,9 @@ static void bnge_disable_int(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr;
 		struct bnge_ring_struct *ring;
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		nqr = &bnapi->nq_ring;
 		ring = &nqr->ring_struct;
 
@@ -2434,8 +2632,12 @@ static void bnge_disable_int_sync(struct bnge_net *bn)
 
 	bnge_disable_int(bn);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+		int map_idx;
 
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
+		map_idx = bnge_cp_num_to_irq_num(bn, i);
 		synchronize_irq(bd->irq_tbl[map_idx].vector);
 	}
 }
@@ -2449,6 +2651,9 @@ static void bnge_enable_int(struct bnge_net *bn)
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		nqr = &bnapi->nq_ring;
 		bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
 	}
@@ -2465,6 +2670,8 @@ static void bnge_disable_napi(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
 		napi_disable_locked(&bnapi->napi);
 	}
 }
@@ -2481,6 +2688,8 @@ static void bnge_enable_napi(struct bnge_net *bn)
 		bnapi->in_reset = false;
 		bnapi->tx_fault = 0;
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
 		napi_enable_locked(&bnapi->napi);
 	}
 }
@@ -2629,6 +2838,9 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
 			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		ring = &nqr->ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
 			hwrm_ring_free_send_msg(bn, ring,
@@ -2690,6 +2902,9 @@ static void bnge_free_irq(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
 		irq = &bd->irq_tbl[map_idx];
 		if (irq->requested) {
 			if (irq->have_cpumask) {
@@ -2718,6 +2933,9 @@ static int bnge_request_irq(struct bnge_net *bn)
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
 
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
 		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
 				 bn->bnapi[i]);
 		if (rc)
@@ -2732,12 +2950,10 @@ static int bnge_request_irq(struct bnge_net *bn)
 			irq->have_cpumask = 1;
 			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
 					irq->cpu_mask);
-			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
-			if (rc) {
+			if (irq_set_affinity_hint(irq->vector, irq->cpu_mask)) {
 				netdev_warn(bn->netdev,
 					    "Set affinity failed, IRQ = %d\n",
 					    irq->vector);
-				goto err_free_irq;
 			}
 		}
 	}
@@ -2857,6 +3073,10 @@ static void bnge_init_napi(struct bnge_net *bn)
 
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		bnapi = bn->bnapi[i];
+
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
 					     bnge_napi_poll, bnapi->index);
 	}
@@ -2875,6 +3095,9 @@ static void bnge_del_napi(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		__netif_napi_del_locked(&bnapi->napi);
 	}
 
@@ -3610,14 +3833,20 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	if (rc)
 		goto err_free_bnapi_mem;
 
+	rc = bnge_setup_nq0(bn, false);
+	if (rc)
+		goto err_free_ring_grps;
+
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
-		goto err_free_ring_grps;
+		goto err_free_nq0;
 	}
 
 	return 0;
 
+err_free_nq0:
+	bnge_free_nq0(bn, false);
 err_free_ring_grps:
 	bnge_free_ring_grps(bn);
 err_free_bnapi_mem:
@@ -3640,6 +3869,8 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
 	unregister_netdev(netdev);
 
+	bnge_free_nq0(bn, false);
+
 	timer_shutdown_sync(&bn->timer);
 	cancel_work_sync(&bn->sp_task);
 	bn->sp_event = 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 4711dd4945ff..7c26943c5cb3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -382,7 +382,7 @@ int bnge_alloc_irqs(struct bnge_dev *bd)
 	irqs_demand = pci_alloc_irq_vectors(bd->pdev, min, irqs_demand,
 					    PCI_IRQ_MSIX);
 	aux_msix = bnge_aux_get_msix(bd);
-	if (irqs_demand < 0 || irqs_demand < aux_msix) {
+	if (irqs_demand < 0 || irqs_demand < aux_msix + min) {
 		rc = -ENODEV;
 		goto err_free_irqs;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index e0ddb2800c54..22fd4eeb3213 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -450,7 +450,8 @@ void bnge_init_ring_struct(struct bnge_net *bn)
 		struct bnge_tx_ring_info *txr;
 		struct bnge_ring_struct *ring;
 
-		bnge_init_nq_ring_struct(bn, &bnapi->nq_ring);
+		if (!BNGE_NQ0_NAPI(bnapi))
+			bnge_init_nq_ring_struct(bn, &bnapi->nq_ring);
 
 		rxr = bnapi->rx_ring;
 		if (!rxr)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 7d45e057f2e8..dcec6fdced30 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1375,6 +1375,21 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 				break;
 
 			idx = BNGE_NQ_HDL_IDX(idx);
+
+			/* NQ0 keeps running while administratively down to
+			 * process async events, but its cp_ring_arr is torn
+			 * down (and cp_ring_count zeroed) by
+			 * bnge_free_nq_tree() while down. Guard against a
+			 * stray/late CQ notification arriving in that state
+			 * instead of dereferencing a freed or out-of-range
+			 * cp_ring_arr.
+			 */
+			if (unlikely(!nqr->cp_ring_arr ||
+				     idx >= nqr->cp_ring_count)) {
+				raw_cons = NEXT_RAW_CMP(raw_cons);
+				continue;
+			}
+
 			cpr = &nqr->cp_ring_arr[idx];
 			cpr->had_nqe_notify = 1;
 			cpr->toggle = NQE_CN_TOGGLE(type);
-- 
2.47.3

