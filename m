Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F535476CB
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922101; cv=none; b=G/JS+e7ugsaGb/J+ohi1AoowxY/ED+vtvZu+LoKD0Koe9XCymd5K1XQjKhZHMUMtE+XDUW32TcqHT3E7gWP89c7gewx+0Ln2U/V2dEj+7P59xhYIfNvRCA/6nO1MJnV/vd+yGMxDaiAYyWKWGegYIG/jvY7hrgfijdyAynrk3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922101; c=relaxed/simple;
	bh=9yo9xv6KxKaLJOPj8QN0fOXVqpQCRiX2rAK9W0phauE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxpCer1xeznFhPLTl72BCXv9ME9dr8JTviHQ8CIGFUko9Rf4tZohSjmftw50ZaV11UmovIJe5YH2fp05u0mwECYfOhHNln7XBT+MBhAtTcp2KKEyWmJfSGI7460bbHypEu/EXOmKOrWpx1ca2xvGRXCJIVB40c6+GdnSpNa1h4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=difUAyYI; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="difUAyYI"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-93e635220b9so238418585a.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922098; x=1792526898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbjWRwvBceXDUpKmVzvJBj3QPpFh+Fowktv6+6Nd1Uc=;
        b=TFmu726zXnXL7F+mmXu7Gh20+5uhdZSFsTUF8+hHcG/pQs2+UF2iOFPN+In7VmYgCV
         pbBko00a7IDHRrCfLrmlG3PPKC1pYDJPpPvzFNQnR8MCDyMsDJLndXPCN5P2B74abY3+
         qd7kWNe9yIZvCC06SFQBh57nC/nHra9Uto6wCDaMLWAhrgLLUsykqExvs7rzKlbYyUJw
         qCXimEhgpdqu5CXX/sBYWMC/57TNYDZmC0UAkhJTmDeGh4OW4STM0Ka5SbEujhwyZVxC
         W8yGNbT/qlcX+qo+k24VqZYAAKolX/NrujdIvCY6LkNIZ6Eoy7t2bOsb+Fh+5tG5KF7l
         Z2CA==
X-Gm-Message-State: AFq9FYKwxabBGHXiBi8mnqQRsxLoUqF628OMfVo23No5+oEoZGjShqzm
	ujVRU5yyWMdkBkbkIw+MUFMjCqjzUBJgzib1WDYV9gjLJaFuVBR2FflhrzBHTwgULsjc/amu67U
	d3b4fQLUQ1r1troWxqvqI0GcnHqq7InyjNZ7ocNp725POnm5ljXP/V5q9UMGv8iQB6BUnc9GYs/
	yi4mUdxGrkIXqFMxYP5fA1/1BVbBUUfCMl/XQbcYcBdlYLVFP1Ka1csEujYbc4+YcieEX+v4gPg
	J9tkI+IY1GHYIre1PzEX1M=
X-Gm-Gg: AYBFou3ui9AaGlrAbloG2ZKsleQvAOlsVTo9nU8btwpP0tIn5tDoU8AmNQnQaTGLAhk
	PhKPBv+sP5ckWzYJLOVMOEdYHoKYMAI1qrfVDucUN36lJmXsR1g7IvaOvCWe7js9siHIlSIid/i
	qnzD6SBlA4h5768EpNxF3oyhrqeou7I3DK0RpHIiarlQ1MTEL+0bzIGobjgzcUtjH1y7WcgrtDA
	QqwP0w9bel0MsXvhD17kXpBwzyk+e5dCGjFzq+GLF+GAIzD6++D3rgXi6FhxQBo8b8kz5NfM7mg
	4fwkBpvs2mWHpQR53qDja/HVWmkpYb4OIWLIkkKY2NYvQ3iXT2lrpGvsBDO9ycwHKDgmSWf1j51
	qjBPVV4QfU19+4gJEyueASkajaxUSGHXj1mzOqKqYdVOpvCx8031z8TSV8btoOlBXee7CfoL/gp
	Z5w+1HGB+wNHY4egXwZ8rU2x92XmBXDXYBhbFLX1ljATHu
X-Received: by 2002:a05:620a:468a:b0:93b:f6fe:e29d with SMTP id af79cd13be357-93ebd0cfc89mr2116324585a.2.1791922098554;
        Tue, 13 Oct 2026 13:08:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93ef4f37c2fsm84592885a.2.2026.10.13.13.08.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:08:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso7579480eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791922097; x=1792526897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbjWRwvBceXDUpKmVzvJBj3QPpFh+Fowktv6+6Nd1Uc=;
        b=difUAyYIU9liWYSp69jbFlT/W298cqV60pB/6sRpqEvyivtMwRwHsSg2fNoWytPE4+
         5JEkfrBh8NNRQTwn2SNbez0uutw6ZUN40P6dso8B8rZUoIdlSrL48cnioTgtg9HA4yNv
         QYSIlTIGX5+LU7LFyVcya+AnJx8KAQS960Src=
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id a92af1059eb24-16a5dcf5a62mr18926972c88.8.1791922096224;
        Tue, 13 Oct 2026 13:08:16 -0700 (PDT)
X-Received: by 2002:a05:701b:21db:b0:149:ef22:2fa2 with SMTP id a92af1059eb24-16a5dcf5a62mr18926890c88.8.1791922094795;
        Tue, 13 Oct 2026 13:08:14 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm39526585c88.11.2026.10.13.13.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:08:14 -0700 (PDT)
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
	Kumar Mudide <kumar.mudide@broadcom.com>,
	Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Subject: [PATCH net-next v3 3/5] bnge: add bnge_for_each_open_nq() iterator
Date: Wed, 14 Oct 2026 01:36:43 +0530
Message-ID: <20261013200645.1346299-4-bhargava.marreddy@broadcom.com>
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

Add BNGE_FIRST_OPEN_NQ and bnge_for_each_open_nq(), and use them in the
loops that will need to skip the NQ that is created at probe once it is
split out. The "open" NQs are the ones created in ndo_open() and
destroyed in ndo_stop(), i.e. all NQs from index BNGE_FIRST_OPEN_NQ on.
The loop that carves the bnge_napi instances out of the bn->bnapi
allocation in bnge_alloc_core() is converted as well; its allocation
size will be reduced by BNGE_FIRST_OPEN_NQ when the probe-time NQ moves
out of it.

The loops over the completion rings, over the per-NQ stats and ring
group state, and the interrupt disable/sync loops are intentionally
left alone, as they still cover all NQs. The latter must mask and
synchronize the IRQ of the probe-time NQ before its completion rings
are freed.

In bnge_hwrm_ring_free(), split the NQ free out of the completion ring
loop so that it can use the iterator, mirroring bnge_hwrm_ring_alloc().
This changes the order of the firmware commands: previously each NQ was
freed right after its own completion rings, now all completion rings
are freed first and all NQs after. Each completion ring is still freed
before the NQ it belongs to.

BNGE_FIRST_OPEN_NQ is 0 for now, i.e. every NQ is an open NQ, so the
macro expands to the loops it replaces. Apart from the firmware command
order above, no functional change.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Kumar Mudide <kumar.mudide@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  9 ++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 29 ++++++++++---------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index e76ba4e063bb..fdd8bca01440 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -238,6 +238,15 @@ struct bnge_dev {
 #define bnge_warn(bd, fmt, ...)	bnge_log(warn, bd, fmt, ##__VA_ARGS__)
 #define bnge_dbg(bd, fmt, ...)	bnge_log(dbg, bd, fmt, ##__VA_ARGS__)
 
+/* Index of the first NQ created in ndo_open() and destroyed in ndo_stop().
+ * NQs below it are created at probe and destroyed at remove. It starts at 0,
+ * i.e. all NQs are open NQs, until NQ0 moves to probe.
+ */
+#define BNGE_FIRST_OPEN_NQ	0
+
+#define bnge_for_each_open_nq(i, bd) \
+	for ((i) = BNGE_FIRST_OPEN_NQ; (i) < (bd)->nq_nr_rings; (i)++)
+
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
 {
 	return bd->flags & BNGE_EN_ROCE;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index f8f81f3f7cd9..0d98223cd703 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -548,7 +548,7 @@ static void bnge_free_nqs(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++)
+	bnge_for_each_open_nq(i, bd)
 		bnge_free_nq(bn, bn->bnapi[i]);
 }
 
@@ -557,7 +557,7 @@ static int bnge_alloc_nqs(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i, rc;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		rc = bnge_alloc_nq(bn, bn->bnapi[i]);
 		if (rc)
 			goto err_free_nqs;
@@ -565,7 +565,7 @@ static int bnge_alloc_nqs(struct bnge_net *bn)
 	return 0;
 
 err_free_nqs:
-	while (--i >= 0)
+	while (--i >= BNGE_FIRST_OPEN_NQ)
 		bnge_free_nq(bn, bn->bnapi[i]);
 	return rc;
 }
@@ -1249,10 +1249,11 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	bn->bnapi = bnapi;
 	bnapi += arr_size;
-	for (i = 0; i < bd->nq_nr_rings; i++, bnapi += size) {
+	bnge_for_each_open_nq(i, bd) {
 		bn->bnapi[i] = bnapi;
 		bn->bnapi[i]->index = i;
 		bn->bnapi[i]->bn = bn;
+		bnapi += size;
 	}
 
 	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
@@ -1970,7 +1971,7 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	int i, rc = 0;
 
 	agg_rings = !!(bnge_is_agg_reqd(bd));
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_ring_struct *ring = &bnapi->nq_ring.ring_struct;
 
@@ -2426,7 +2427,7 @@ static void bnge_enable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
 
@@ -2443,7 +2444,7 @@ static void bnge_disable_napi(struct bnge_net *bn)
 	if (test_and_set_bit(BNGE_STATE_NAPI_DISABLED, &bn->state))
 		return;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
 		napi_disable_locked(&bnapi->napi);
@@ -2456,7 +2457,7 @@ static void bnge_enable_napi(struct bnge_net *bn)
 	int i;
 
 	clear_bit(BNGE_STATE_NAPI_DISABLED, &bn->state);
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
 		bnapi->in_reset = false;
@@ -2609,7 +2610,9 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 
 		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
 			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
+	}
 
+	bnge_for_each_open_nq(i, bd) {
 		bnge_hwrm_nq_free(bn, bn->bnapi[i]);
 		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 	}
@@ -2622,7 +2625,7 @@ static void bnge_setup_msix(struct bnge_net *bn)
 	int len, i;
 
 	len = sizeof(bd->irq_tbl[0].name);
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		char *attr;
 
@@ -2707,7 +2710,7 @@ static void bnge_free_irq(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++)
+	bnge_for_each_open_nq(i, bd)
 		bnge_nq_free_irq(bn, bn->bnapi[i]);
 }
 
@@ -2721,7 +2724,7 @@ static int bnge_request_irq(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
 		return rc;
 	}
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		rc = bnge_nq_request_irq(bn, bn->bnapi[i]);
 		if (rc)
 			goto err_free_irq;
@@ -2840,7 +2843,7 @@ static void bnge_init_napi(struct bnge_net *bn)
 	struct bnge_napi *bnapi;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		bnapi = bn->bnapi[i];
 		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
 					     bnge_napi_poll, bnapi->index);
@@ -2857,7 +2860,7 @@ static void bnge_del_napi(struct bnge_net *bn)
 	for (i = 0; i < bd->tx_nr_rings; i++)
 		netif_queue_set_napi(bn->netdev, i, NETDEV_QUEUE_TYPE_TX, NULL);
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
 		__netif_napi_del_locked(&bnapi->napi);
-- 
2.47.3

