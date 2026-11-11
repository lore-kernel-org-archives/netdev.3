Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423725;
	b=WQxI4SAbu3w9bh/BuEt12bu08z8jiQbyDj13GOquV33e2kc3o1Mfv7xAo2DscBlYtO+/
	 HFNleLEkICvtjVBHypKzDx66m/hUnO65f5H/6b4gXy2/xBW14NxvlHNpLN/y6doATb1n0
	 WwyZzNII9G3isVGk4M+FrKI6bKjvhsdrKMN41PgcmuHgIgyfDPXo6dsnrTcM5SxONLkbV
	 6iSV6giSizkspdpA/Us2ScWqHMUDrOwjsvYwafj7vxwNNCZUGwony/CKFscNY+6mQr4yc
	 KCuS+oTba//tFjmqlnADcD057hFWncTRFPYMbgcKM0kvvhlVUFBtWlGcifbjgrkROkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423725;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=3F4fvy7pR5JySBIIeLV6EJkprBWoCpKbk4kI746JJ9Y=;
	b=me6q1owZFnFXrq+Uq/ZNjQlhCz+6LErXB1wVKK3/RqS2h/zawcKsMGba/UYzzhjR6e/k
	 F9UiksA5Zhq4ylIkT9+VZj3c4bR87MEm0g00QA1psIzvlXfrw45ZfJP7jY3aUDJVwxwA6
	 27JLCKNZ7v6QgHqwaM/7JEikSITONhy28M/XYujkohUaFNBvrZceXk+K8R9P3Y4grg1/H
	 r6l+TgO/rAJgv0cfAYT8VeJnP12yVdLZGBtnGX+MCBwGBKkgGiIbmHKRmd3z58S4/y4br
	 Nsh09EpIppVg5cPuJWmNEzVucrGxr2wJ5D6nmZ2yYSkRfQpO/zfjmuYyoAwOEjVLY8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cRFqEL9A;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE555606A893
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE555606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cRFqEL9A
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdd9e925075so597579a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423724; x=1795028524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3F4fvy7pR5JySBIIeLV6EJkprBWoCpKbk4kI746JJ9Y=;
        b=2XsuhyaGTeyoUHJXBRhj3EwiFVEq3u3AGoQJifKi8WPl7ev6A39nZXlJtPy5hUM0EE
         HP7yrAPDbcalf1viiof2UARjUY3PSg1PPmA+xZDGDBy6NFwMhxQ5p/ZeJdhhcP7IBs1h
         rbYSsSLDJ4D/h2+sZRfC1NnG63X4fYiVib0xor9Hwaz8V8AJ6CQxC7k0UZQoBsVkCW/q
         vt7vTq8gimoy0zthL7FJTmNWUdcw1hydKaodKgP3Q8D/wGGgBsZZ3/oZGN+RuZexFTTi
         1KRGTtfE8gEHyDwix097hnwU4JEGw+FR8dg25scoKxggwIYgeHvlOZcB5OyFpsvuyzzj
         v+Rg==
X-Gm-Message-State: APuU4Z/E70ly6OyJuQbm++JZ26Zj18HSxTtDmOfokmItSMfqu+fs6yOW
	urXe/qszi5ir3eWB6o00D7KyyZjoC2ZqmmCVg3YLrywchA/pBhPSqrjeo7B3fQlgDdUYXk69xY4
	o3hGsPkEJyw6OKCfFjRrfTF4ccRF5croxRA7DGbXpoRYVOkqSYujI20WGYQH+Efb3iR//N8jZGI
	IbKjqJcy9yFfnswDx9Ai3DEGd0lmPUzmO+luz8G2fFXYgXJVVXZUshfU2HyXJaqpNBKq7cNR/Uw
	hdsObWp/NdbogZ3yw==
X-Gm-Gg: AYBFou2D9RTrvcPwrSZfGoRcHtcZ5EVZ4zyu8PVRE5i3Rwx1CyeEDX2Y6EgZ+qCq000
	TAkFEzD8j2zhfCucVtAphdboDcwo1kE4IY9G1wQQlflW+Z8X0tnpa0gTeOJ2zNyPZuic4/tmIOa
	6CNFwjGbCWtYF5NIo0eqxUJe3HqOOz9nl8hpAY9qvR+o77u8xGOx4xcuCsiUV764rFSwj+4Vr/p
	giMHoaWhJxJFSLKIXz5dV048o0guCiLuaNqsJJjqXS4LnmkIYefxBLcK/Gwy6f137ndC9wCtqLr
	o/zgtffghpCBbrNvmhv3nQa+w7m3KbII0PK2egsTE71zkIi3e45Osvol6W+fEXw6OSbooVc+DWo
	GEVTRTtwK7MXmkuvu1uwJMGielrkbrFF256zMDmxz+3LbCaOCgrvSYw3k0+l0neZX6oeh3QKd1X
	pZYtERgTqBHvzburc0HFLkVE8C1JRsBcd0Gt8UNkwgug==
X-Received: by 2002:a17:90b:1c02:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3b182eabbd9mr3358149a91.22.1794423724107;
        Wed, 11 Nov 2026 11:02:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b181ffc52csm973011a91.1.2026.11.11.11.02.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:02:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-37628596fc9so486705eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794423722; x=1795028522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3F4fvy7pR5JySBIIeLV6EJkprBWoCpKbk4kI746JJ9Y=;
        b=cRFqEL9Aewf9jq7IipLQjbPo34NrSXAY4PgZ+zequsfmHsN0NoeWGWv7C5YkwQUKlm
         XSkV9XQk67WjT7cL0/Yq+jWXTgfeCy53MRiwBjSrWvXkVK6ufK8/fFX31yDG/iAi3oVW
         kUMuFjXBTetmYNWdPAkNrrFxwBFlnkS/dC4/g=
X-Received: by 2002:a05:7300:fd05:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-37685a88bb0mr4804444eec.9.1794423721356;
        Wed, 11 Nov 2026 11:02:01 -0800 (PST)
X-Received: by 2002:a05:7300:fd05:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-37685a88bb0mr4804345eec.9.1794423720135;
        Wed, 11 Nov 2026 11:02:00 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm20860468eec.26.2026.11.11.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:01:59 -0800 (PST)
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
Subject: [PATCH net-next v4 1/5] bnge: factor out per-NQ alloc/free helpers
Date: Wed, 11 Nov 2026 19:00:07 +0000
Message-ID: <20261111190011.53437-2-bhargava.marreddy@broadcom.com>
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

The descriptor array, ring memory, firmware ring and IRQ of an NQ are
allocated and released inside loops over all NQs, and the NQ ring memory
is set up with the completion rings.

Factor the per-NQ parts out into bnge_alloc_nq()/bnge_free_nq(),
bnge_hwrm_nq_alloc()/bnge_hwrm_nq_free() and
bnge_nq_request_irq()/bnge_nq_free_irq() so a single NQ can be created
and destroyed independently of the others. Rename
bnge_{alloc,free}_nq_arrays() to bnge_{alloc,free}_nqs().

The NQ ring_mem setup, ring allocation and fw_ring_id initialization
move into bnge_alloc_nq(), so the NQ ring memory is allocated with the
NQ descriptor arrays rather than with the completion rings. The
fw_ring_id initialization thus moves from bnge_init_nic(), which runs
on every open, to bnge_alloc_core(), which also runs on every open.
The IRQ map index is also set there; the value is unchanged. The aux
vector count it depends on is sampled once in bnge_alloc_nqs() and passed
to bnge_alloc_nq(), so every NQ of one allocation gets a distinct irq_tbl
index even if RoCE is disabled concurrently. The affinity hint is now
derived from bnapi->index, which equals the loop index used before. The
error path of bnge_alloc_nqs() now unwinds only the NQs allocated so far.

Also rename bnge_{alloc,free,init}_nq_tree() to
bnge_{alloc,free,init}_cp_rings(), since they no longer touch the NQ
itself, only the completion rings hanging off it.

One behavioral difference: bnge_hwrm_ring_free() now resets
grp_info[i].nq_fw_ring_id to INVALID_HW_RING_ID for every NQ, not only
for the NQs that had a valid firmware ring ID. Otherwise there is no
functional change.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 290 ++++++++++--------
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |  10 -
 2 files changed, 169 insertions(+), 131 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 25f844e6f6d3..04f5aa75f70e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -503,61 +503,95 @@ static int bnge_alloc_cp_desc_arr(struct bnge_cp_ring_info *cpr, int n)
 	return -ENOMEM;
 }
 
-static void bnge_free_nq_arrays(struct bnge_net *bn)
+static void bnge_free_nq(struct bnge_net *bn, struct bnge_napi *bnapi)
 {
-	struct bnge_dev *bd = bn->bd;
-	int i;
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
-		struct bnge_napi *bnapi = bn->bnapi[i];
+	bnge_free_ring(bn->bd, &nqr->ring_struct.ring_mem);
+	bnge_free_nq_desc_arr(nqr);
+}
+
+static int bnge_alloc_nq(struct bnge_net *bn, struct bnge_napi *bnapi,
+			 u16 aux_msix)
+{
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	struct bnge_ring_mem_info *rmem;
+	struct bnge_ring_struct *ring;
+	int rc;
+
+	ring = &nqr->ring_struct;
+	rmem = &ring->ring_mem;
 
-		bnge_free_nq_desc_arr(&bnapi->nq_ring);
+	rc = bnge_alloc_nq_desc_arr(nqr, bn->cp_nr_pages);
+	if (rc)
+		return rc;
+
+	nqr->bnapi = bnapi;
+	rmem->nr_pages = bn->cp_nr_pages;
+	rmem->page_size = HW_CMPD_RING_SIZE;
+	rmem->pg_arr = (void **)nqr->desc_ring;
+	rmem->dma_arr = nqr->desc_mapping;
+	rmem->vmem_size = 0;
+	rmem->flags = BNGE_RMEM_RING_PTE_FLAG;
+	rc = bnge_alloc_ring(bn->bd, rmem);
+	if (rc) {
+		bnge_free_nq_desc_arr(nqr);
+		return rc;
 	}
+
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+	ring->map_idx = aux_msix + bnapi->index;
+	return 0;
 }
 
-static int bnge_alloc_nq_arrays(struct bnge_net *bn)
+static void bnge_free_nqs(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++)
+		bnge_free_nq(bn, bn->bnapi[i]);
+}
+
+static int bnge_alloc_nqs(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	u16 aux_msix;
 	int i, rc;
 
+	/* RoCE can be disabled concurrently; sample the aux vector count once
+	 * so every NQ gets a distinct irq_tbl index.
+	 */
+	aux_msix = bnge_aux_get_msix(bd);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		struct bnge_napi *bnapi = bn->bnapi[i];
-
-		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
+		rc = bnge_alloc_nq(bn, bn->bnapi[i], aux_msix);
 		if (rc)
-			goto err_free_nq_arrays;
+			goto err_free_nqs;
 	}
 	return 0;
 
-err_free_nq_arrays:
-	bnge_free_nq_arrays(bn);
+err_free_nqs:
+	while (--i >= 0)
+		bnge_free_nq(bn, bn->bnapi[i]);
 	return rc;
 }
 
-static void bnge_free_nq_tree(struct bnge_net *bn)
+static void bnge_free_cp_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		struct bnge_napi *bnapi = bn->bnapi[i];
-		struct bnge_nq_ring_info *nqr;
-		struct bnge_ring_struct *ring;
+		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		int j;
 
-		nqr = &bnapi->nq_ring;
-		ring = &nqr->ring_struct;
-
-		bnge_free_ring(bd, &ring->ring_mem);
-
 		if (!nqr->cp_ring_arr)
 			continue;
 
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
 
-			ring = &cpr->ring_struct;
-			bnge_free_ring(bd, &ring->ring_mem);
+			bnge_free_ring(bd, &cpr->ring_struct.ring_mem);
 			bnge_free_cp_desc_arr(cpr);
 		}
 		kfree(nqr->cp_ring_arr);
@@ -594,31 +628,21 @@ static int alloc_one_cp_ring(struct bnge_net *bn,
 	return rc;
 }
 
-static int bnge_alloc_nq_tree(struct bnge_net *bn)
+static int bnge_alloc_cp_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
-	int i, j, ulp_msix, rc;
+	int i, j, rc;
 	int tcs = 1;
 
-	ulp_msix = bnge_aux_get_msix(bd);
 	for (i = 0, j = 0; i < bd->nq_nr_rings; i++) {
 		bool sh = !!(bd->flags & BNGE_EN_SHARED_CHNL);
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
 		struct bnge_cp_ring_info *cpr;
-		struct bnge_ring_struct *ring;
 		int cp_count = 0, k;
 		int rx = 0, tx = 0;
 
 		nqr = &bnapi->nq_ring;
-		nqr->bnapi = bnapi;
-		ring = &nqr->ring_struct;
-
-		rc = bnge_alloc_ring(bd, &ring->ring_mem);
-		if (rc)
-			goto err_free_nq_tree;
-
-		ring->map_idx = ulp_msix + i;
 
 		if (i < bd->rx_nr_rings) {
 			cp_count++;
@@ -634,7 +658,7 @@ static int bnge_alloc_nq_tree(struct bnge_net *bn)
 		nqr->cp_ring_arr = kzalloc_objs(*cpr, cp_count);
 		if (!nqr->cp_ring_arr) {
 			rc = -ENOMEM;
-			goto err_free_nq_tree;
+			goto err_free_cp_rings;
 		}
 
 		nqr->cp_ring_count = cp_count;
@@ -643,7 +667,7 @@ static int bnge_alloc_nq_tree(struct bnge_net *bn)
 			cpr = &nqr->cp_ring_arr[k];
 			rc = alloc_one_cp_ring(bn, cpr);
 			if (rc)
-				goto err_free_nq_tree;
+				goto err_free_cp_rings;
 
 			cpr->bnapi = bnapi;
 			cpr->cp_idx = k;
@@ -663,8 +687,8 @@ static int bnge_alloc_nq_tree(struct bnge_net *bn)
 	}
 	return 0;
 
-err_free_nq_tree:
-	bnge_free_nq_tree(bn);
+err_free_cp_rings:
+	bnge_free_cp_rings(bn);
 	return rc;
 }
 
@@ -1200,8 +1224,8 @@ static void bnge_free_core(struct bnge_net *bn)
 	bnge_free_vnic_attributes(bn);
 	bnge_free_tx_rings(bn);
 	bnge_free_rx_rings(bn);
-	bnge_free_nq_tree(bn);
-	bnge_free_nq_arrays(bn);
+	bnge_free_cp_rings(bn);
+	bnge_free_nqs(bn);
 	bnge_free_ring_stats(bn);
 	bnge_free_ring_grps(bn);
 	bnge_free_vnics(bn);
@@ -1232,13 +1256,9 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	bn->bnapi = bnapi;
 	bnapi += arr_size;
 	for (i = 0; i < bd->nq_nr_rings; i++, bnapi += size) {
-		struct bnge_nq_ring_info *nqr;
-
 		bn->bnapi[i] = bnapi;
 		bn->bnapi[i]->index = i;
 		bn->bnapi[i]->bn = bn;
-		nqr = &bn->bnapi[i]->nq_ring;
-		nqr->ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
 	}
 
 	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
@@ -1297,7 +1317,7 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	if (rc)
 		goto err_free_ring_stats;
 
-	rc = bnge_alloc_nq_arrays(bn);
+	rc = bnge_alloc_nqs(bn);
 	if (rc)
 		goto err_free_vnics;
 
@@ -1305,13 +1325,13 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	rc = bnge_alloc_rx_rings(bn);
 	if (rc)
-		goto err_free_nq_arrays;
+		goto err_free_nqs;
 
 	rc = bnge_alloc_tx_rings(bn);
 	if (rc)
 		goto err_free_rx_rings;
 
-	rc = bnge_alloc_nq_tree(bn);
+	rc = bnge_alloc_cp_rings(bn);
 	if (rc)
 		goto err_free_tx_rings;
 
@@ -1320,17 +1340,17 @@ static int bnge_alloc_core(struct bnge_net *bn)
 						  BNGE_VNIC_UCAST_FLAG;
 	rc = bnge_alloc_vnic_attributes(bn);
 	if (rc)
-		goto err_free_nq_tree;
+		goto err_free_cp_rings;
 	return 0;
 
-err_free_nq_tree:
-	bnge_free_nq_tree(bn);
+err_free_cp_rings:
+	bnge_free_cp_rings(bn);
 err_free_tx_rings:
 	bnge_free_tx_rings(bn);
 err_free_rx_rings:
 	bnge_free_rx_rings(bn);
-err_free_nq_arrays:
-	bnge_free_nq_arrays(bn);
+err_free_nqs:
+	bnge_free_nqs(bn);
 err_free_vnics:
 	bnge_free_vnics(bn);
 err_free_ring_stats:
@@ -1389,21 +1409,18 @@ static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
 	return nqr->ring_struct.map_idx;
 }
 
-static void bnge_init_nq_tree(struct bnge_net *bn)
+static void bnge_init_cp_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i, j;
 
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
-		struct bnge_ring_struct *ring = &nqr->ring_struct;
 
-		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
 
-			ring = &cpr->ring_struct;
-			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+			cpr->ring_struct.fw_ring_id = INVALID_HW_RING_ID_32BIT;
 		}
 	}
 }
@@ -1914,6 +1931,44 @@ static int bnge_hwrm_rx_ring_alloc(struct bnge_net *bn,
 	return 0;
 }
 
+static int bnge_hwrm_nq_alloc(struct bnge_net *bn, struct bnge_napi *bnapi)
+{
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	u32 type = HWRM_RING_ALLOC_NQ;
+	struct bnge_ring_struct *ring;
+	unsigned int vector;
+	u32 map_idx;
+	int rc;
+
+	ring = &nqr->ring_struct;
+	map_idx = ring->map_idx;
+
+	vector = bn->bd->irq_tbl[map_idx].vector;
+	disable_irq_nosync(vector);
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc) {
+		enable_irq(vector);
+		return rc;
+	}
+	bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	enable_irq(vector);
+
+	return 0;
+}
+
+static void bnge_hwrm_nq_free(struct bnge_net *bn, struct bnge_napi *bnapi)
+{
+	struct bnge_ring_struct *ring = &bnapi->nq_ring.ring_struct;
+
+	if (ring->fw_ring_id == INVALID_HW_RING_ID_32BIT)
+		return;
+
+	hwrm_ring_free_send_msg(bn, ring, RING_FREE_REQ_RING_TYPE_NQ,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+}
+
 static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1923,22 +1978,11 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	agg_rings = !!(bnge_is_agg_reqd(bd));
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
-		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
-		struct bnge_ring_struct *ring = &nqr->ring_struct;
-		u32 type = HWRM_RING_ALLOC_NQ;
-		u32 map_idx = ring->map_idx;
-		unsigned int vector;
+		struct bnge_ring_struct *ring = &bnapi->nq_ring.ring_struct;
 
-		vector = bd->irq_tbl[map_idx].vector;
-		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
-		if (rc) {
-			enable_irq(vector);
+		rc = bnge_hwrm_nq_alloc(bn, bnapi);
+		if (rc)
 			goto err_out;
-		}
-		bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
-		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
-		enable_irq(vector);
 		bn->grp_info[i].nq_fw_ring_id = (u16)ring->fw_ring_id;
 
 		if (!i) {
@@ -2566,23 +2610,14 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 	bnge_disable_int_sync(bn);
 
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		struct bnge_napi *bnapi = bn->bnapi[i];
-		struct bnge_nq_ring_info *nqr;
-		struct bnge_ring_struct *ring;
+		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		int j;
 
-		nqr = &bnapi->nq_ring;
 		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
 			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
 
-		ring = &nqr->ring_struct;
-		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
-			hwrm_ring_free_send_msg(bn, ring,
-						RING_FREE_REQ_RING_TYPE_NQ,
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
-			bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
-		}
+		bnge_hwrm_nq_free(bn, bn->bnapi[i]);
+		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 	}
 }
 
@@ -2627,27 +2662,60 @@ static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 	bnge_hwrm_stat_ctx_free(bn);
 }
 
-static void bnge_free_irq(struct bnge_net *bn)
+static void bnge_nq_free_irq(struct bnge_net *bn, struct bnge_napi *bnapi)
 {
+	int map_idx = bnapi->nq_ring.ring_struct.map_idx;
+	struct bnge_irq *irq = &bn->bd->irq_tbl[map_idx];
+
+	if (irq->requested) {
+		if (irq->have_cpumask) {
+			irq_set_affinity_hint(irq->vector, NULL);
+			free_cpumask_var(irq->cpu_mask);
+			irq->have_cpumask = 0;
+		}
+		free_irq(irq->vector, bnapi);
+	}
+
+	irq->requested = 0;
+}
+
+static int bnge_nq_request_irq(struct bnge_net *bn, struct bnge_napi *bnapi)
+{
+	int map_idx = bnapi->nq_ring.ring_struct.map_idx;
 	struct bnge_dev *bd = bn->bd;
 	struct bnge_irq *irq;
-	int i;
+	int rc;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
-		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+	irq = &bd->irq_tbl[map_idx];
 
-		irq = &bd->irq_tbl[map_idx];
-		if (irq->requested) {
-			if (irq->have_cpumask) {
-				irq_set_affinity_hint(irq->vector, NULL);
-				free_cpumask_var(irq->cpu_mask);
-				irq->have_cpumask = 0;
-			}
-			free_irq(irq->vector, bn->bnapi[i]);
-		}
+	rc = request_irq(irq->vector, irq->handler, 0, irq->name, bnapi);
+	if (rc)
+		return rc;
+
+	netif_napi_set_irq_locked(&bnapi->napi, irq->vector);
+	irq->requested = 1;
+
+	if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
+		int numa_node = dev_to_node(&bd->pdev->dev);
 
-		irq->requested = 0;
+		irq->have_cpumask = 1;
+		cpumask_set_cpu(cpumask_local_spread(bnapi->index, numa_node),
+				irq->cpu_mask);
+		if (irq_set_affinity_hint(irq->vector, irq->cpu_mask))
+			netdev_warn(bn->netdev,
+				    "Set affinity failed, IRQ = %d\n",
+				    irq->vector);
 	}
+	return 0;
+}
+
+static void bnge_free_irq(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++)
+		bnge_nq_free_irq(bn, bn->bnapi[i]);
 }
 
 static int bnge_request_irq(struct bnge_net *bn)
@@ -2661,29 +2729,9 @@ static int bnge_request_irq(struct bnge_net *bn)
 		return rc;
 	}
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		int map_idx = bnge_cp_num_to_irq_num(bn, i);
-		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
-
-		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
-				 bn->bnapi[i]);
+		rc = bnge_nq_request_irq(bn, bn->bnapi[i]);
 		if (rc)
 			goto err_free_irq;
-
-		netif_napi_set_irq_locked(&bn->bnapi[i]->napi, irq->vector);
-		irq->requested = 1;
-
-		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
-			int numa_node = dev_to_node(&bd->pdev->dev);
-
-			irq->have_cpumask = 1;
-			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
-					irq->cpu_mask);
-			if (irq_set_affinity_hint(irq->vector, irq->cpu_mask)) {
-				netdev_warn(bn->netdev,
-					    "Set affinity failed, IRQ = %d\n",
-					    irq->vector);
-			}
-		}
 	}
 	return 0;
 
@@ -2830,7 +2878,7 @@ static int bnge_init_nic(struct bnge_net *bn)
 {
 	int rc;
 
-	bnge_init_nq_tree(bn);
+	bnge_init_cp_rings(bn);
 
 	bnge_init_rx_rings(bn);
 	rc = bnge_alloc_rx_ring_pair_bufs(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index b066ee887a09..bbae84b4157e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -431,20 +431,10 @@ void bnge_init_ring_struct(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_ring_mem_info *rmem;
-		struct bnge_nq_ring_info *nqr;
 		struct bnge_rx_ring_info *rxr;
 		struct bnge_tx_ring_info *txr;
 		struct bnge_ring_struct *ring;
 
-		nqr = &bnapi->nq_ring;
-		ring = &nqr->ring_struct;
-		rmem = &ring->ring_mem;
-		rmem->nr_pages = bn->cp_nr_pages;
-		rmem->page_size = HW_CMPD_RING_SIZE;
-		rmem->pg_arr = (void **)nqr->desc_ring;
-		rmem->dma_arr = nqr->desc_mapping;
-		rmem->vmem_size = 0;
-
 		rxr = bnapi->rx_ring;
 		if (!rxr)
 			goto skip_rx;
-- 
2.47.3

