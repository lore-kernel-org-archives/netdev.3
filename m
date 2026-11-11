Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423751;
	b=w6ol1bUNayuETi47XgI04iszQ9iPX8mV+sMr1IjZiCSASle+APZWZtNt0S1xpNx6/AFp
	 8+fva8uNYSY0/DtSAqJquGp9lszZgUKUdMx+z5p+mWxLzHJYP2SPeXSLS4tcDCMPOQRPJ
	 6HRKBNdTBjFIrkAEJdrmeX7JHYi1ECDIMJQ+yc8X5aoOMw0Hao2FgT2SeR2a4H1yurkcX
	 MGocP6IHsJp+y0SgqBSvRFId0aMdTOrS+NGJPSf2dTVlBL/QhqYx0pcFSotwBZLSvXeOn
	 d9rHl5cCLPahAJgaf3PBza6LWzBnfPb5GodpNVEGbTHpN189e6q5HHB1BzN5xEO3QJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423751;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=ORXVHoLST+8nnzDhnCIslN8O872hpo6jy/vFtRV+T+4=;
	b=vvDV+aNj0kqoVnizSSMUT79LiXCKK3eInpHpPsqb3oshWr2KlfMtwUEFcw8vp85l1puL
	 7qmNcUFR6Ej1DYXEOmYwJhJsOEGy1exzS6ljH2l4fJz37VCd6n1/GmqjNEh75PgYuCsCe
	 U53mePHExH/+pQqNqyGA6j6NxLxs3bllQLqYaWaT7BLijOzWaY0iU5ZOTteKW7QwC0Hdj
	 0Uxp2Rcvebjn6xttjbPQ/k7NUm1Q1hCdftfOd0adjDG4YENbYoF01zaH2/pGZaXx4VVR7
	 JwM1aAjhSCp1tek9pBBh+XMiJS/GPUwpkmcDZ7ohB8Q8yj+qP4XuepmCStcQVQvHrvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MwpYjzIs;
	arc=none smtp.remote-ip=74.125.82.225
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64A606A894
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF64A606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MwpYjzIs
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-36dbde64409so7052239eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423749; x=1795028549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORXVHoLST+8nnzDhnCIslN8O872hpo6jy/vFtRV+T+4=;
        b=MgU+JYuPi4TYuovrP0ckt5/gCbqp4xszr2McxQRyAlj4WTdXAWPeP5W7OnOgUbWGL+
         QRcZKaUMnwMDbxOZWQOig/zz4tGmd2AvTylRVPguldVoP6Mm4YPrDHIERVt3seOSkgbw
         cd0hzajH9dypLfKrU78Eo83PQTBbSPhpO1lpT3CyCNv2+pDFRaxFY/gJjf/J2qvqOyyi
         tj1++2Nyiw+tI9PMlKq7hZy97UDyXujMLEeqT+Zh9SArnLsORaQ/RHFih2a0fLj8GeDY
         JednITe/sAuXVoPbeQJXLDFuZ7Xu1KC3ieBHX/a3vHJ2HSwBWLBnmDQ8KPMbfVsMMpGt
         sbxA==
X-Gm-Message-State: APuU4Z/Al0y04XJ19rsjsq3XIY80VA+DProqCQLpt+wsBDQ8sl7jr4Vu
	98CxRU281ok60y70inFPe0ceum0N9OEuG6ru9TM2fAtS0dWlKbVmyfamqzcpnSycxMxb1JY99BB
	O6elpK8YCLvLrwexS8s2sT0/31A7Pfp1oLlP8e/7l7sXiU5z2SrnixJbYzfPanOQ6H50tRHSf0F
	w9fRYUYDZqYG1FennKSATIF1KFfvnCLimC6pI32dOze0sIveaoJzZwya2Cz30z7Iqk16Vxombr7
	4gdoxyJ3g3oLxxFvA==
X-Gm-Gg: AYBFou1joiplYB2q1mMy7TyGKSYr7fjusqx8cU6lA8BXWLUG7WbJkslRijGwDBOzofT
	J0EofbHNiaCmUgXuv3cimvhQA21mxy9WEp8yOAUILiwTgRTRxMTI5gzG96/8OIv3UDmtrkkcFRT
	XzBFg6MhCUaXhI3E1SRxm0Pgt2UtvwQzre1miTLEkoEhN2dY3GHQ/OrNf9sLklyHn0QUgcq70YW
	E/WcgXg/ift8KZ1eETtgBadJrNMPp49IN4NxiFQP3i+U/qKn9N4tCvleNhj2rv6UGnZRWy/qbzd
	ZeOutYsr8DiUK/g9NiX54Zl9YnWgc5qW4bx+E6vdwjsp9O0iGZYo8bPlrrYlfUGnERxWXbWbJQr
	kJRQLXWNffjZiJSUiAO3v7bH1o6ndnaBXkpqmNdw5wceFfT4f3zgYyMEh/WgEAgoTdqqw6SS+UO
	BzfuTR1E5A4a4fiuLMOFAii+KtcCh0MMOj5miFn1n7jQ==
X-Received: by 2002:a05:7300:8a19:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-376854b7fbamr3526684eec.8.1794423748195;
        Wed, 11 Nov 2026 11:02:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3751d9f02a4sm65744eec.3.2026.11.11.11.02.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:02:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so4894779eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794423746; x=1795028546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ORXVHoLST+8nnzDhnCIslN8O872hpo6jy/vFtRV+T+4=;
        b=MwpYjzIs1POJdKvVWnrOXu27eNsIBp1fIU2ZevbvKwRcbWWQzEGAd7//ajEw+npMsX
         eMZyEPYFl+uFQ0F6eqMqMx97ASVFNOmnrAngjJQQyioeE5WklpPdGtKavBM6kaVXZK0+
         F9HFLVac4AGc3BVXy08jQAZbH279K3+OIFOSc=
X-Received: by 2002:a05:693c:68c1:b0:34e:9923:e372 with SMTP id 5a478bee46e88-37686469cf1mr3916020eec.29.1794423745935;
        Wed, 11 Nov 2026 11:02:25 -0800 (PST)
X-Received: by 2002:a05:693c:68c1:b0:34e:9923:e372 with SMTP id 5a478bee46e88-37686469cf1mr3915980eec.29.1794423745104;
        Wed, 11 Nov 2026 11:02:25 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm20860468eec.26.2026.11.11.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:02:24 -0800 (PST)
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
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>,
	Rahul Gupta <rahul-rg.gupta@broadcom.com>
Subject: [PATCH net-next v4 5/5] bnge: create NQ0 during probe and keep it active across open/close
Date: Wed, 11 Nov 2026 19:00:11 +0000
Message-ID: <20261111190011.53437-6-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
References: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Unlike the other NQs, NQ0 is not only a datapath queue. Besides Rx/Tx
completions it also delivers firmware async events (including link
events) and HWRM command completions. It is currently created in
ndo_open() and destroyed in ndo_stop(), so none of these non-datapath
events are received while the interface is down.

Create NQ0 once at probe and keep it, together with its MSI-X vector,
until remove. NAPI is not kept around: as for every other NQ, NQ0's NAPI
exists only between ndo_open() and ndo_stop(). A dedicated async-only
vector would avoid sharing but would cost one MSI-X per function, taking
it away from the Rx/Tx queues, so NQ0's vector is shared instead.

The vector's handler serves NQ0 in one of two ways, selected by the new
BNGE_STATE_NQ0_NAPI bit:

  - NAPI mode (interface up): the handler schedules NQ0's NAPI, which
    handles Rx/Tx, async and HWRM events.

  - Worker mode (interface down): there is no NAPI instance, so the
    handler queues nq0_work. The worker runs bnge_nq0_poll(), which
    handles async events and HWRM completions, discards completion
    notifications for CQs (none exist while down) and re-arms the NQ.

The mode changes only in open and stop, with NQ0's IRQ disabled and
nq0_work cancelled, so one context consumes NQ0 at a time. Unread
notifications for the destroyed rings are dropped before NAPI is
re-enabled, so bnge_napi_poll() needs no bounds check on the CQ handle.

nq0_work runs on a dedicated ordered workqueue, nq0_wq.

Async events received while the interface is down are queued to
sp_task, which ignores them until open. This patch only makes NQ0
persistent across open/close; acting on events received while down is
left for later. Link and module status are read again at the end of
open, so no state is lost.

NQ0 always uses irq_tbl[0], independent of the aux (RoCE) vector count.

User-visible and behavioral changes:

  - NQ0's vector is named <pci_name>-nq0 and remains requested while the
    interface is down. It no longer appears as <ifname>-TxRx-0 (or
    <ifname>-rx-0) in /proc/interrupts. Other vectors keep their names.
  - BNGE_FIRST_OPEN_NQ becomes 1, so aux (RoCE) vectors start at
    irq_tbl[1], and the ring_idx handed to the RoCE driver shifts
    accordingly.
  - The async event completion ring is configured once at probe rather
    than on every open. If NQ0 or this configuration fails, probe now
    fails; previously a configuration failure only logged a warning
    during open.

This relies on firmware keeping NQ0 and the async event completion ring
configured across FUNC_DRV_IF_CHANGE down/up.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 214 ++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   5 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  53 +++++
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   3 +
 5 files changed, 266 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 5f7147baaf83..64c792b278ad 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -238,12 +238,14 @@ struct bnge_dev {
 #define bnge_warn(bd, fmt, ...)	bnge_log(warn, bd, fmt, ##__VA_ARGS__)
 #define bnge_dbg(bd, fmt, ...)	bnge_log(dbg, bd, fmt, ##__VA_ARGS__)
 
-/* Index of the first NQ created in ndo_open() and destroyed in ndo_stop();
- * lower NQs live from probe to remove.
+/* Index of the first NQ created in ndo_open() and destroyed in ndo_stop().
+ * NQ0 (index 0) lives from probe to remove and is managed by
+ * bnge_nq0_init()/uninit() and the nq0 handoff helpers; therefore,
+ * bnge_for_each_open_nq() skips it.
  *
- * irq_tbl order: probe-time NQs, aux (RoCE) vectors, open-time NQs.
+ * irq_tbl order: NQ0, aux (RoCE) vectors, open-time NQs.
  */
-#define BNGE_FIRST_OPEN_NQ	0
+#define BNGE_FIRST_OPEN_NQ	1
 
 #define bnge_for_each_open_nq(i, bd) \
 	for ((i) = BNGE_FIRST_OPEN_NQ; (i) < (bd)->nq_nr_rings; (i)++)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 400ada1023ed..ab917c0f81b1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1215,10 +1215,20 @@ static int bnge_init_ring_grps(struct bnge_net *bn)
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
@@ -1235,6 +1245,7 @@ static void bnge_free_core(struct bnge_net *bn)
 	bn->tx_ring = NULL;
 	kfree(bn->rx_ring);
 	bn->rx_ring = NULL;
+	bnge_nq0_clear_rings(bn);
 	kfree(bn->bnapi);
 	bn->bnapi = NULL;
 }
@@ -1249,12 +1260,15 @@ static int bnge_alloc_core(struct bnge_net *bn)
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
@@ -1366,6 +1380,7 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	kfree(bn->rx_ring);
 	bn->rx_ring = NULL;
 err_free_bnapi:
+	bnge_nq0_clear_rings(bn);
 	kfree(bn->bnapi);
 	bn->bnapi = NULL;
 	return rc;
@@ -1979,18 +1994,12 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
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
@@ -2433,6 +2442,7 @@ static void bnge_enable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	/* NQ0 is armed by bnge_nq0_wq_to_napi() */
 	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
@@ -2695,7 +2705,6 @@ static int bnge_nq_request_irq(struct bnge_net *bn, struct bnge_napi *bnapi)
 	if (rc)
 		return rc;
 
-	netif_napi_set_irq_locked(&bnapi->napi, irq->vector);
 	irq->requested = 1;
 
 	if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -2850,9 +2859,14 @@ static void bnge_init_napi(struct bnge_net *bn)
 	int i;
 
 	for (i = 0; i < bd->nq_nr_rings; i++) {
+		int map_idx;
+
 		bnapi = bn->bnapi[i];
+		map_idx = bnapi->nq_ring.ring_struct.map_idx;
 		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
 					     bnge_napi_poll, bnapi->index);
+		netif_napi_set_irq_locked(&bnapi->napi,
+					  bd->irq_tbl[map_idx].vector);
 	}
 }
 
@@ -2876,6 +2890,86 @@ static void bnge_del_napi(struct bnge_net *bn)
 	synchronize_net();
 }
 
+static int bnge_nq0_init(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	struct bnge_irq *irq;
+	int rc;
+
+	/* NQ0 helpers hard-code NQ index 0 */
+	BUILD_BUG_ON(BNGE_FIRST_OPEN_NQ != 1);
+
+	bnapi = kzalloc_obj(*bnapi);
+	if (!bnapi)
+		return -ENOMEM;
+
+	bnapi->bn = bn;
+	bnapi->index = 0;
+	bn->nq0 = bnapi;
+	nqr = &bnapi->nq_ring;
+
+	/* NQ0 always sits at irq_tbl[0], independent of the aux vector count.
+	 * Its ring size is fixed here; a later change to bn->cp_* must
+	 * re-create NQ0.
+	 */
+	rc = bnge_alloc_nq(bn, bnapi, 0);
+	if (rc)
+		goto err_free_bnapi;
+
+	irq = &bd->irq_tbl[nqr->ring_struct.map_idx];
+	irq->handler = bnge_nq0_msix;
+	snprintf(irq->name, sizeof(irq->name), "%s-nq0", pci_name(bd->pdev));
+
+	rc = bnge_nq_request_irq(bn, bnapi);
+	if (rc)
+		goto err_free_nq;
+
+	rc = bnge_hwrm_nq_alloc(bn, bnapi);
+	if (rc)
+		goto err_free_irq;
+
+	rc = bnge_hwrm_set_async_event_cr(bd, nqr->ring_struct.fw_ring_id);
+	if (rc) {
+		bnge_err(bd, "Failed to set async event completion ring: %d\n",
+			 rc);
+		goto err_free_hwrm;
+	}
+
+	/* BNGE_STATE_NQ0_NAPI is clear, so from here on the ISR queues
+	 * nq0_work. nq0_wq must already exist.
+	 * This is the first arm, so keep it last: the unwind above does not
+	 * cancel nq0_work.
+	 */
+	BNGE_DB_NQ_ARM(bd, &nqr->nq_db, nqr->nq_raw_cons);
+	return 0;
+
+err_free_hwrm:
+	bnge_hwrm_nq_free(bn, bnapi);
+err_free_irq:
+	bnge_nq_free_irq(bn, bnapi);
+err_free_nq:
+	bnge_free_nq(bn, bnapi);
+err_free_bnapi:
+	kfree(bnapi);
+	bn->nq0 = NULL;
+	return rc;
+}
+
+static void bnge_nq0_uninit(struct bnge_net *bn)
+{
+	struct bnge_napi *bnapi = bn->nq0;
+
+	bnge_nq_free_irq(bn, bnapi);
+	cancel_work_sync(&bn->nq0_work);
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
@@ -2963,11 +3057,32 @@ static int bnge_hwrm_if_change(struct bnge_dev *bd, bool up)
 	return bnge_hwrm_req_send(bd, req);
 }
 
+/* Hand NQ0 from nq0_work to NAPI. The caller keeps NQ0's IRQ disabled; it is
+ * re-enabled here.
+ */
+static void bnge_nq0_wq_to_napi(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr = &bn->nq0->nq_ring;
+	struct bnge_napi *bnapi = bn->nq0;
+	struct bnge_dev *bd = bn->bd;
+
+	bnapi->in_reset = false;
+	bnapi->tx_fault = 0;
+	napi_enable_locked(&bnapi->napi);
+	set_bit(BNGE_STATE_NQ0_NAPI, &bn->state);
+	BNGE_DB_NQ_ARM(bd, &nqr->nq_db, nqr->nq_raw_cons);
+	enable_irq(bd->irq_tbl[nqr->ring_struct.map_idx].vector);
+}
+
 static int bnge_open_core(struct bnge_net *bn)
 {
+	struct bnge_nq_ring_info *nqr0 = &bn->nq0->nq_ring;
 	struct bnge_dev *bd = bn->bd;
+	unsigned int vector0;
 	int rc;
 
+	vector0 = bd->irq_tbl[nqr0->ring_struct.map_idx].vector;
+
 	netif_carrier_off(bn->netdev);
 
 	rc = bnge_hwrm_if_change(bd, true);
@@ -2982,10 +3097,19 @@ static int bnge_open_core(struct bnge_net *bn)
 		goto err_if_change;
 	}
 
+	disable_irq(vector0);
+	cancel_work_sync(&bn->nq0_work);
+
+	/* Clear sp_event bits left by events seen while down. Nothing can set
+	 * them here: NQ0's IRQ is off, nq0_work is cancelled and the timer is
+	 * stopped. Link state is read again at the end of open.
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
@@ -3017,6 +3141,7 @@ static int bnge_open_core(struct bnge_net *bn)
 	set_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
 
 	bnge_enable_int(bn);
+	bnge_nq0_wq_to_napi(bn);
 
 	bnge_tx_enable(bn);
 
@@ -3032,6 +3157,10 @@ static int bnge_open_core(struct bnge_net *bn)
 err_del_napi:
 	bnge_del_napi(bn);
 	bnge_free_core(bn);
+err_nq0_resume:
+	/* Drop CQ notifications left by the failed bring-up; re-arms NQ0 */
+	bnge_nq0_poll(bn);
+	enable_irq(vector0);
 err_if_change:
 	bnge_hwrm_if_change(bd, false);
 	return rc;
@@ -3233,6 +3362,36 @@ static void bnge_save_ring_stats(struct bnge_net *bn)
 	}
 }
 
+/* Hand NQ0 from NAPI to nq0_work. Call with the netdev lock held, after the
+ * rings were destroyed in FW (bnge_shutdown_nic()). The IRQ is off while NQ0
+ * changes hands and is re-enabled last, so the ISR queues nq0_work from then
+ * on.
+ */
+static void bnge_nq0_napi_to_wq(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr = &bn->nq0->nq_ring;
+	struct bnge_napi *bnapi = bn->nq0;
+	struct bnge_dev *bd = bn->bd;
+	unsigned int vector;
+
+	vector = bd->irq_tbl[nqr->ring_struct.map_idx].vector;
+
+	disable_irq(vector);
+	napi_disable_locked(&bnapi->napi);
+	/* bnge_napi_poll() may still be writing the doorbell after
+	 * napi_complete_done()
+	 */
+	synchronize_net();
+	/* Nothing should be pending; cancel so bnge_nq0_poll() below cannot
+	 * overlap the worker
+	 */
+	cancel_work_sync(&bn->nq0_work);
+	clear_bit(BNGE_STATE_NQ0_NAPI, &bn->state);
+	/* Drop CQ notifications left by the destroyed rings; re-arms NQ0 */
+	bnge_nq0_poll(bn);
+	enable_irq(vector);
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -3243,6 +3402,8 @@ static void bnge_close_core(struct bnge_net *bn)
 
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
+
+	bnge_nq0_napi_to_wq(bn);
 	bnge_disable_napi(bn);
 
 	/* Save ring stats before shutdown */
@@ -3265,7 +3426,6 @@ static int bnge_close(struct net_device *dev)
 	bnge_close_core(bn);
 	bnge_hwrm_shutdown_link(bn->bd);
 	bnge_hwrm_if_change(bn->bd, false);
-	bn->sp_event = 0;
 
 	return 0;
 }
@@ -3567,6 +3727,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 		netif_set_tso_max_segs(netdev, bd->tso_max_segs);
 
 	INIT_WORK(&bn->sp_task, bnge_sp_task);
+	INIT_WORK(&bn->nq0_work, bnge_nq0_work);
 	timer_setup(&bn->timer, bnge_timer, 0);
 	bn->current_interval = BNGE_TIMER_INTERVAL;
 
@@ -3578,6 +3739,14 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 		goto err_netdev;
 	}
 
+	bn->nq0_wq = alloc_ordered_workqueue("bnge_nq0_wq-%s", WQ_MEM_RECLAIM,
+					     dev_name(bd->dev));
+	if (!bn->nq0_wq) {
+		netdev_err(netdev, "Unable to create NQ0 workqueue.\n");
+		rc = -ENOMEM;
+		goto err_free_workq;
+	}
+
 	bn->rx_ring_size = BNGE_DEFAULT_RX_RING_SIZE;
 	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
 	bn->rx_dir = DMA_FROM_DEVICE;
@@ -3591,24 +3760,35 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 
 	rc = bnge_probe_phy(bn, true);
 	if (rc)
-		goto err_free_workq;
+		goto err_free_nq0_wq;
 
 	rc = bnge_alloc_port_stats(bn);
 	if (rc)
-		goto err_free_workq;
+		goto err_free_nq0_wq;
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
+err_free_nq0_wq:
+	destroy_workqueue(bn->nq0_wq);
 err_free_workq:
 	destroy_workqueue(bn->bnge_pf_wq);
 err_netdev:
@@ -3626,6 +3806,10 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
 	unregister_netdev(netdev);
 
+	/* NQ0 can queue sp_task; destroy it before the timer and workqueue */
+	bnge_nq0_uninit(bn);
+	destroy_workqueue(bn->nq0_wq);
+
 	timer_shutdown_sync(&bn->timer);
 	cancel_work_sync(&bn->sp_task);
 	bn->sp_event = 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 476b5bab96fe..8c300f2fb5f3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -266,6 +266,7 @@ struct bnge_stats_mem {
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
 	BNGE_STATE_STATS_ENABLE,
+	BNGE_STATE_NQ0_NAPI,
 };
 
 #define BNGE_TIMER_INTERVAL	HZ
@@ -315,6 +316,8 @@ struct bnge_net {
 	u32			hash_seed;
 	u64			toeplitz_prefix;
 
+	/* Lives from probe to remove. bnapi[0] points to it. */
+	struct bnge_napi		*nq0;
 	struct bnge_napi		**bnapi;
 
 	struct bnge_rx_ring_info	*rx_ring;
@@ -350,7 +353,9 @@ struct bnge_net {
 	unsigned int		current_interval;
 	struct timer_list	timer;
 	struct workqueue_struct *bnge_pf_wq;
+	struct workqueue_struct *nq0_wq;
 	struct work_struct	sp_task;
+	struct work_struct	nq0_work;
 	unsigned long		sp_event;
 
 	struct bnge_ethtool_link_info	eth_link_info;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 2f382514c6ea..265a780a11ed 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -45,6 +45,21 @@ irqreturn_t bnge_msix(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+/* NQ0 outlives ndo_stop(). While the interface is up it is polled by NAPI
+ * like any other NQ; while it is down it has no NAPI and nq0_work services it.
+ */
+irqreturn_t bnge_nq0_msix(int irq, void *dev_instance)
+{
+	struct bnge_napi *bnapi = dev_instance;
+	struct bnge_net *bn = bnapi->bn;
+
+	if (test_bit(BNGE_STATE_NQ0_NAPI, &bn->state))
+		return bnge_msix(irq, dev_instance);
+
+	queue_work(bn->nq0_wq, &bn->nq0_work);
+	return IRQ_HANDLED;
+}
+
 static struct rx_agg_cmp *bnge_get_tpa_agg(struct bnge_net *bn,
 					   struct bnge_rx_ring_info *rxr,
 					   u16 agg_id, u16 curr)
@@ -1396,6 +1411,44 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
+/* Poll NQ0 without NAPI: handle its own events, drop notifications for CQs
+ * that no longer exist, and re-arm it.
+ */
+void bnge_nq0_poll(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr = &bn->nq0->nq_ring;
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
+	BNGE_DB_NQ_ARM(bn->bd, &nqr->nq_db, raw_cons);
+}
+
+void bnge_nq0_work(struct work_struct *work)
+{
+	bnge_nq0_poll(container_of(work, struct bnge_net, nq0_work));
+}
+
 static u16 bnge_xmit_get_cfa_action(struct sk_buff *skb)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
index bd0aa6c221a4..3db6809499ba 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
@@ -120,6 +120,9 @@ irqreturn_t bnge_msix(int irq, void *dev_instance);
 netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev);
 void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
 int bnge_napi_poll(struct napi_struct *napi, int budget);
+irqreturn_t bnge_nq0_msix(int irq, void *dev_instance);
+void bnge_nq0_poll(struct bnge_net *bn);
+void bnge_nq0_work(struct work_struct *work);
 netdev_features_t bnge_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
-- 
2.47.3

