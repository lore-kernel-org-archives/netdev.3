Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423736;
	b=fCqC927HndDxQ0nMoVyva7yLjWPD1WPQUr7j1q+P7QeuKvzPocWGt6ClerTzXR7TP7tJ
	 EPJg3HGhWXlU0sijSpmGWCcYaKl0Mkmv87tLV96SE/NMJxYiKBKe76XWRgw3dQ3uHQU0I
	 jcrAKWKEil/mndPgd/kESsXXXZZYnflsCVn1bnLYADRYvCjg1E/M9VdMmf0BOX01rTq3F
	 WvMxHrp44uri+xWwVXvfXLmBHV0Q/jAeFd+B4Ed8rHalMvSZxUtKZO7474YVb47pcQYsP
	 1siCvQkYtJVbBx9uT+9+9QpM1DGbzweTyVG3eWUaWmcXywfiUkBz7LB6EOL5+2dgYzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423736;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=zwfLNPGciLDqgrHHkZD+nMXEbxgqL33UgUxrzeLCTCY=;
	b=b4AdyIr9bKRii/GcbH5trKZc4j+Zde1JixhDAC7tanmNtSEeJ0Cj69IJOrwpmUnVrTAh
	 UvBSeaRXAfVfz6wcukJ7yaiaSDuyg6ML8rEpmhE3gG6MVx9MbjoIOx9WqpSv/mKS7gmyD
	 azGf/PS05eF4GNdkcMDv9vc7FH8xul3vwFaIfwiYyt/p7vj60K+eP+WpfBZxRyJkzYVkR
	 5ggBeO3Xrk+/5DexRWrXaPFKho2C/8VSIIjb1dXRgl3bFh3M3d9KdZc0x/eyPHbFgToCa
	 8/0d9wHg8ZgMhSYuq/Gk4p0uyvt1HLkkW+X9zlQPs7DKeBg4/Gvo6wFeoCX/B8wv4IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FJAFzVG8;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801F606A332
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D801F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FJAFzVG8
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso2330390a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423735; x=1795028535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwfLNPGciLDqgrHHkZD+nMXEbxgqL33UgUxrzeLCTCY=;
        b=C8WERds27FoiEXRyc/qOBslFp2ZM91V4XahqzybW7E7p1cOT1Rm0ocLLInLwgicEWq
         SCOq8DQIfEcWLjdhy5txfp1kQRjmq0TNDb//DztdRA+SFBjlM0unEFIBH4fF0aJMiX2m
         jfMvvYmJ+jQ01owGRTJh2TBEkwBZWbKUI00kbqCQLmHDsH01nNPIQRnaEzbOc8uXMAQl
         Fbx4ZKkCLgNfBeRgiDdH1ipnf3rzR3/uoFeuTSEliwkL6RbqvtUM+tWrW+ZKq1rY9z3S
         Gzk1Ndd6L1+3+Jwj1N3PFtBrVbZxi3GuGjvEGlH3NYHH3nlKBSmdLbU2+L7XfiH6VAdv
         S6qA==
X-Gm-Message-State: APuU4Z+MQ1A8DN5/2DtPWCiVs2r5oa+/5NT+dJmyTA+xbaTBcouj6ngo
	OU1578pFssNAbrwkFI9+awhWvYp/ZoVkbfvb30HMHzJmOYajGp+VaCP6h5+r08Hsof8KNHoOcLq
	9BE8ZlSwuwu8dA5t49ciOXoyP0jVq1i6y0wxQhOP2qWt6zLo91ZQRwjwRqJicVrF9TD1WW2CMBT
	0SQRa3ZV74d17Y6yCUA3WzFXJzLWN7ITXDDoGrqtJbGJisg2ZH1Wa/+Lwjq0KBzvuiXsMFZhbp1
	lKlJmekfhapGHjzFg==
X-Gm-Gg: AYBFou1rQ/Xz8slsg8GNi9eh9lUNJVpOnggeuDeQfgUoMw1TSpeHNYAAbRje4Emnxj5
	FbK3EyEZBbsNhFZ2ioLB1rq+EdwnDkajHmYcxHZIZyC7rY/cjja2HjGnc8jL2VKVTTdZIIrkpwZ
	JccBGoqwaMZzavaLuUJ4GfVJstaz0YcHEXd3hBmz+qUorBvV25aNoXrU5WCQvv8N4QoFPJDIrv5
	HBX6n3bGTIs5TI2krVHnXWQImBo38tjYfsALLYPocQc5hzHoRZUSpcLacxf+Y0z0tpxww2Q5B7W
	vo3umGNDQE49m/ehoUlNKyM5OcSLC3B6hwKiR2y+QxjKWmzXw8UnOCLXrXkNYdxk0ReEA7l48Do
	7PeOI/2G65uv2gstLfrqf3smgfGzoS0o4frZ/s50/mj41Miu33vpAqR9hFpBmNx/g7WRyptzZQg
	bOU7i3NmeHthP52CcXekjz0NhGuVCFSlKpz2KOyoxUjA==
X-Received: by 2002:a17:90b:270c:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3b182f60ae1mr2882359a91.58.1794423735065;
        Wed, 11 Nov 2026 11:02:15 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197c125d0sm217623a91.1.2026.11.11.11.02.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:02:15 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36d1353fdcdso2449545eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794423733; x=1795028533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zwfLNPGciLDqgrHHkZD+nMXEbxgqL33UgUxrzeLCTCY=;
        b=FJAFzVG8D1VK+QBEb13kK/enyzpU8mvYq/H6Oc0Ztyc9OO6PNOB7TR2URpuvx4QCfF
         /PAN5A/QlkCqQn0E94Q4UoOX0u30L4TWFF49uH8TTHF/P1WQweWZfBpR4jKrlKn/9GC1
         uRZ73KkfQeaEzyu6JWppEZoiHsfJhm49FRngY=
X-Received: by 2002:a05:7300:6919:b0:36d:2b50:4eb9 with SMTP id 5a478bee46e88-37685e6b287mr5362216eec.25.1794423733087;
        Wed, 11 Nov 2026 11:02:13 -0800 (PST)
X-Received: by 2002:a05:7300:6919:b0:36d:2b50:4eb9 with SMTP id 5a478bee46e88-37685e6b287mr5362168eec.25.1794423732283;
        Wed, 11 Nov 2026 11:02:12 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm20860468eec.26.2026.11.11.11.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:02:11 -0800 (PST)
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
Subject: [PATCH net-next v4 3/5] bnge: add bnge_for_each_open_nq() iterator
Date: Wed, 11 Nov 2026 19:00:09 +0000
Message-ID: <20261111190011.53437-4-bhargava.marreddy@broadcom.com>
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

Add BNGE_FIRST_OPEN_NQ and bnge_for_each_open_nq(), and use them in the
loops that will need to skip the NQ that is created at probe once it is
split out. The "open" NQs are those whose IRQs and firmware rings are
created in ndo_open() and destroyed in ndo_stop(), i.e., all NQs from
index BNGE_FIRST_OPEN_NQ on.

The loops over the Completion Rings (CP rings), per-NQ stats, and NAPI
registration (init/del) are intentionally left alone to cover all NQs
(including NQ0), as NQ0's completion structures and NAPI registration
remain tied to open/stop. The bnapi allocation and NAPI enable/disable
loops are converted here; NQ0's NAPI enable/disable is handled
separately by a later patch in this series.

In bnge_hwrm_ring_free(), split the NQ free out of the completion ring
loop so that it can use the iterator, mirroring bnge_hwrm_ring_alloc().
This changes the order of the firmware commands: previously each NQ was
freed right after its own completion rings, now all completion rings
are freed first and all NQs after. Each completion ring is still freed
before the NQ it belongs to.

BNGE_FIRST_OPEN_NQ is 0 for now, i.e., every NQ is an open NQ, so the
macro expands to the loops it replaces. Apart from the firmware command
order above, no functional change.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Kumar Mudide <kumar.mudide@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  8 ++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 25 +++++++++++--------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index e76ba4e063bb..5cc08177ff86 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -238,6 +238,14 @@ struct bnge_dev {
 #define bnge_warn(bd, fmt, ...)	bnge_log(warn, bd, fmt, ##__VA_ARGS__)
 #define bnge_dbg(bd, fmt, ...)	bnge_log(dbg, bd, fmt, ##__VA_ARGS__)
 
+/* Index of the first NQ created in ndo_open() and destroyed in ndo_stop();
+ * lower NQs live from probe to remove.
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
index d95c3c1469da..197a9032bbeb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -549,7 +549,7 @@ static void bnge_free_nqs(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++)
+	bnge_for_each_open_nq(i, bd)
 		bnge_free_nq(bn, bn->bnapi[i]);
 }
 
@@ -563,7 +563,7 @@ static int bnge_alloc_nqs(struct bnge_net *bn)
 	 * so every NQ gets a distinct irq_tbl index.
 	 */
 	aux_msix = bnge_aux_get_msix(bd);
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		rc = bnge_alloc_nq(bn, bn->bnapi[i], aux_msix);
 		if (rc)
 			goto err_free_nqs;
@@ -571,7 +571,7 @@ static int bnge_alloc_nqs(struct bnge_net *bn)
 	return 0;
 
 err_free_nqs:
-	while (--i >= 0)
+	while (--i >= BNGE_FIRST_OPEN_NQ)
 		bnge_free_nq(bn, bn->bnapi[i]);
 	return rc;
 }
@@ -1255,10 +1255,11 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
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
@@ -1976,7 +1977,7 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 	int i, rc = 0;
 
 	agg_rings = !!(bnge_is_agg_reqd(bd));
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_ring_struct *ring = &bnapi->nq_ring.ring_struct;
 
@@ -2432,7 +2433,7 @@ static void bnge_enable_int(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
 
@@ -2449,7 +2450,7 @@ static void bnge_disable_napi(struct bnge_net *bn)
 	if (test_and_set_bit(BNGE_STATE_NAPI_DISABLED, &bn->state))
 		return;
 
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
 		napi_disable_locked(&bnapi->napi);
@@ -2462,7 +2463,7 @@ static void bnge_enable_napi(struct bnge_net *bn)
 	int i;
 
 	clear_bit(BNGE_STATE_NAPI_DISABLED, &bn->state);
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
 		bnapi->in_reset = false;
@@ -2615,7 +2616,9 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 
 		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
 			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
+	}
 
+	bnge_for_each_open_nq(i, bd) {
 		bnge_hwrm_nq_free(bn, bn->bnapi[i]);
 		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 	}
@@ -2628,7 +2631,7 @@ static void bnge_setup_msix(struct bnge_net *bn)
 	int len, i;
 
 	len = sizeof(bd->irq_tbl[0].name);
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		char *attr;
 
@@ -2713,7 +2716,7 @@ static void bnge_free_irq(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
-	for (i = 0; i < bd->nq_nr_rings; i++)
+	bnge_for_each_open_nq(i, bd)
 		bnge_nq_free_irq(bn, bn->bnapi[i]);
 }
 
@@ -2727,7 +2730,7 @@ static int bnge_request_irq(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
 		return rc;
 	}
-	for (i = 0; i < bd->nq_nr_rings; i++) {
+	bnge_for_each_open_nq(i, bd) {
 		rc = bnge_nq_request_irq(bn, bn->bnapi[i]);
 		if (rc)
 			goto err_free_irq;
-- 
2.47.3

