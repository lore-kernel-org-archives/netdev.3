Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869878;
	b=ove+6/Ay0Ff2eQIfFrbDYTdYWYjdFoam7pKsDUi4XPA51lIoSYJLpKxNGMl/19p7d94B
	 1W3mabu0CPHh5iWNQccXJ29lt5NGekJrFxwDnJhMrmeKLkjzSaw8WfrvlIZ6QBihDCuPt
	 hCoUgl5SK23Y4IgHsgsvGuFyhDHDxQ1SvTWP9WaloZ7v628eAU6tW5DXoJUlwEi6ypFjt
	 T2VcaQr4XbFICOVKgOPAH+WnRf+/dtgAzpFc81Bv57XeDels4P9ZXFCYWUf/ipE6oYgdu
	 hf8EWOu+g/u4GL7ga53SRGfTSBmXCWBq+9WGuxIy6RYOY33Apbc/oO/sJhHk8PBuiKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869878;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Efbomni5FaxQHZdenx6VDnwExzQwrJdXuRlq+gsLE7U=;
	b=aL7386v4B7t4UrEokXU7l/VpN7CQNYWZbYROZK9fLehts4cduXxZTbQDKkOKiTntsN6a
	 Ef5bxnKq5W9hSw31fMYDp0bAQU2K16s6HZZFGAyOt1YoyCSKUoGssB9pvkisNdj/OqOy6
	 ncDeyNxHdKndtsmEHaAWvogEEyvykw8V+w6PTPlPDTXt2OKuywOeBC9SnXkDibUnl3hUk
	 o8G9MnyCDZW0gTDtn+uxMZfTj4uKMivi0FretE6jcxvGKRyvsERIh9PcCSZMwAtlMVLfY
	 h1u5jFKJPg9UjdEDUk0NbHSh+f6LMgz+KUvvbFVs45TZ8+HVNJY2aEE8OJf4sz4KeAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fTFhFNIr;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB31606A337
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB31606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fTFhFNIr
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc758830601so1152747a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869877; x=1794474677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Efbomni5FaxQHZdenx6VDnwExzQwrJdXuRlq+gsLE7U=;
        b=C6UU1PMb4ukGUWWSqXBlXSKy1LqVri7pCwW5EeUskRYxswu5/Dpi9frDOUwPF6vOAa
         jwFSFRodP+rXH+DuOOiB8nyDgkC/wamLNzZPRozo3vEau2ykRe5bdw/hybFKHl7B71ID
         q54bC33dLPdxv/hDEOYui2iAeQvIha5FtikyCEGnbPj7RIepWQbqLf51gg92M6R1oS10
         Z8sNE1tO0uuT7XE/YzzKReodzFY440fmj1yCTzEoF9z40hYaVe/3SAYIHMgWaA72/r8y
         6+EuKFQ0LGoGKCdgP5TSD9XvPrNk0WVQMl0GYKKvjtw2iLUnW7uY/qPFeF7MicniENgy
         2CHg==
X-Gm-Message-State: APuU4Z/aQ6QIiMkeIvh9AaQZPGfmna+m9zlU8+02cyXmU8b5z8cdU4LU
	akflouRnLQL5ZUxoXnT8k2vx3rnYH40AYlcmmy95r9n6KHpSt8hRSNPLETNWXm0SoCp7jnHlqLS
	hM6GEjygA+q/uEuIH6UPHP+sPdCLL+p8bZLNLjsQrZjzQVMKJYgDjiUG6lwxSXptBgKNaUMFhnt
	gXluzO8EJsQI35UxgNuXbBN7a0iDS+jGXB/hI53M/DvU00snILwYYdFDxj1GjXqflVcXZznfpSl
	yrsyOkysVm7
X-Gm-Gg: AYBFou3LNRfQ2ka7GkC6e4NjBNR/vQzPrlCAbbrHWYG7CgGyyOH/71YvQ1noNhwFuKO
	tQi4dPrs+sGdo0iglddq73/cV+6eLyq9C/dJn1K5kL+yZp82SQ50sRpoF5A48J2WxjOKh80ij92
	MShBKNFWqcMJTefUigCO5cXnkyfLTpxiZ9QOu9VX1lRqoULua35VDgpO5nayXT8HbLElxDtSn8k
	aWUdbbD6SmyfvKzoy+drq5g1LxrmY4iFyzjiB3FlBWubV+BqNuFMVbGwRYc0UT74jwh7tkik5fW
	Kn/2D0UQI/cTD0zooMZyNrf+TwARt3OCHd+VHACdmRgnoDGZEzX75+QetZB/iOguP/39y4z/FNN
	syqVQo3A63r5KL0yPAoIt/hxfce7tdQGVLfpzOqxvMVAmhsZMMjVKT+Gn/YNbyU1J85Mipm44ib
	CeG8b4t8Dievwsag1FGsp9+ln0rVWx7QKW0w==
X-Received: by 2002:a17:90b:224f:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3ae8983cf4emr17525542a91.53.1793869877080;
        Thu, 05 Nov 2026 01:11:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b324c46esm1567246a91.3.2026.11.05.01.11.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:11:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-54af6c38092so23704491cf.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793869876; x=1794474676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Efbomni5FaxQHZdenx6VDnwExzQwrJdXuRlq+gsLE7U=;
        b=fTFhFNIrbaeJsoGhzpELfgfxjzUeFGExlp6EMmgQOXi3pcp6zdnKlDwfh+vu7WZYfU
         2ITQLCKhtXBeakj23XWP60P7LaJ9RY/p+GpwglzgLfh0REIsWsYdBwZIt3isIanLE4rv
         PM6FRU0T4cqaO4d+lSBtGU3DQ3AEuY5WSuohQ=
X-Received: by 2002:a05:622a:4d08:b0:537:a19e:5561 with SMTP id d75a77b69052e-542b6d5eb2emr306536151cf.43.1793869875756;
        Thu, 05 Nov 2026 01:11:15 -0800 (PST)
X-Received: by 2002:a05:622a:4d08:b0:537:a19e:5561 with SMTP id d75a77b69052e-542b6d5eb2emr306535821cf.43.1793869875156;
        Thu, 05 Nov 2026 01:11:15 -0800 (PST)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm47298591cf.6.2026.11.05.01.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:11:14 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	dharmender.garg@broadcom.com,
	sachin.holla@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Saswati Das <saswati.das@broadcom.com>
Subject: [net-next v3 3/3] bnge: Reserve ring resources for upcoming RoCE MPC support
Date: Thu,  5 Nov 2026 01:01:54 -0800
Message-ID: <20261105090154.1293846-4-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261105090154.1293846-1-siva.kallam@broadcom.com>
References: <20261105090154.1293846-1-siva.kallam@broadcom.com>
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

From: Sachin Holla <sachin.holla@broadcom.com>

Reserve one additional TX ring and one additional completion ring
per RoCE-enabled function for forthcoming RoCE MPC support.

Reduce the L2 ring limits before adding MPC resources to the firmware
reservation demand. Exclude MPC resources from firmware grants before
adjusting L2 counts, allowing partial grants that leave sufficient
resources for L2 and MPC.

The corresponding RoCE MPC allocation and use will follow in a
separate RDMA patch series. Until then, these reservations remain
unused and reduce the resources available to L2.

Disable RoCE before selecting default resources when the reported ring
limits cannot accommodate MPC and minimum L2 operation, preserving
the L2 ring budget on resource-constrained functions.

Rebuild the default RSS indirection table when the effective L2 RX
queue count changes, even if the firmware RX grant remains unchanged.
Initialize the table after successful default-ring setup so a failed
reservation followed by a successful retry cannot skip initialization.

Signed-off-by: Sachin Holla <sachin.holla@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Saswati Das <saswati.das@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  9 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  3 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 56 +++++++++++++++++--
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 68b74eb2c3a2..c5d51b8ee9d1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -312,6 +312,15 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	max_irqs = bnge_get_max_irq(pdev);
 	bnge_set_max_func_irqs(bd, max_irqs);
 
+	/* Preserve L2 operation if the additional MPC rings cannot fit. */
+	if (bnge_is_roce_en(bd) &&
+	    (bd->hw_resc.max_tx_rings <= 1 ||
+	     bd->hw_resc.max_cp_rings <= 2)) {
+		dev_warn(bd->dev,
+			 "Not enough rings for RoCE MPC, disabling RoCE\n");
+		bd->flags &= ~BNGE_EN_ROCE;
+	}
+
 	bnge_aux_init_dflt_config(bd);
 
 	rc = bnge_net_init_dflt_config(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 651c5e783516..01547311add8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -441,7 +441,8 @@ static int bnge_hwrm_get_rings(struct bnge_dev *bd)
 	tx = hw_resc->resv_tx_rings;
 	if (bnge_is_agg_reqd(bd))
 		rx >>= 1;
-	if (cp < (rx + tx)) {
+	/* RoCE ring counts are adjusted after excluding MPC resources. */
+	if (!bnge_is_roce_en(bd) && cp < (rx + tx)) {
 		rc = bnge_fix_rings_count(&rx, &tx, cp, false);
 		if (rc)
 			goto get_rings_exit;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 65ef34536e36..90185482da33 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -110,9 +110,24 @@ static u16 bnge_nqs_demand(struct bnge_dev *bd)
 	return bd->nq_nr_rings + bnge_aux_get_msix(bd);
 }
 
+static u16 bnge_tx_rings_demand(struct bnge_dev *bd)
+{
+	u16 tx_rings = bd->tx_nr_rings;
+
+	if (bnge_is_roce_en(bd))
+		tx_rings += 1; /* For MPC TX ring */
+
+	return tx_rings;
+}
+
 static u16 bnge_cprs_demand(struct bnge_dev *bd)
 {
-	return bd->tx_nr_rings + bd->rx_nr_rings;
+	u16 cprs = bd->tx_nr_rings + bd->rx_nr_rings;
+
+	if (bnge_is_roce_en(bd))
+		cprs += 1; /* For MPC CQ ring */
+
+	return cprs;
 }
 
 static u16 bnge_get_avail_msix(struct bnge_dev *bd, int num)
@@ -251,7 +266,7 @@ static bool bnge_need_reserve_rings(struct bnge_dev *bd)
 	u16 nqs = bnge_nqs_demand(bd);
 	u16 vnic;
 
-	if (hw_resc->resv_tx_rings != bd->tx_nr_rings)
+	if (hw_resc->resv_tx_rings != bnge_tx_rings_demand(bd))
 		return true;
 
 	vnic = bnge_get_total_vnics(bd, rx);
@@ -271,8 +286,8 @@ static bool bnge_need_reserve_rings(struct bnge_dev *bd)
 int bnge_reserve_rings(struct bnge_dev *bd)
 {
 	u16 aux_dflt_msix = bnge_aux_get_dflt_msix(bd);
+	u16 rx_rings, old_rx_rings, old_rx_nr_rings;
 	struct bnge_hw_rings hwr = {0};
-	u16 rx_rings, old_rx_rings;
 	u16 nq = bd->nq_nr_rings;
 	u16 aux_msix = 0;
 	bool sh = false;
@@ -294,11 +309,11 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 		hwr.nq = bnge_nqs_demand(bd);
 	}
 
-	hwr.tx = bd->tx_nr_rings;
+	hwr.tx = bnge_tx_rings_demand(bd);
 	hwr.rx = bd->rx_nr_rings;
 	if (bd->flags & BNGE_EN_SHARED_CHNL)
 		sh = true;
-	hwr.cmpl = hwr.rx + hwr.tx;
+	hwr.cmpl = bnge_cprs_demand(bd);
 
 	hwr.vnic = bnge_get_total_vnics(bd, hwr.rx);
 
@@ -308,6 +323,7 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	hwr.rss_ctx = bnge_rss_ctxs_in_use(bd, &hwr);
 	hwr.stat = bnge_func_stat_ctxs_demand(bd);
 	old_rx_rings = bd->hw_resc.resv_rx_rings;
+	old_rx_nr_rings = bd->rx_nr_rings;
 
 	rc = bnge_hwrm_reserve_rings(bd, &hwr);
 	if (rc)
@@ -315,6 +331,14 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 
 	bnge_copy_reserved_rings(bd, &hwr);
 
+	/* Exclude the MPC reservation before adjusting the L2 rings. */
+	if (bnge_is_roce_en(bd)) {
+		if (hwr.tx <= 1 || hwr.cmpl <= 2)
+			return -ENOMEM;
+		hwr.tx--;
+		hwr.cmpl--;
+	}
+
 	rx_rings = hwr.rx;
 	if (bnge_is_agg_reqd(bd)) {
 		if (hwr.rx >= 2)
@@ -330,12 +354,19 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	hwr.nq = min_t(u16, hwr.nq, hwr.stat);
 
 	/* Adjust the rings */
+	rc = bnge_fix_rings_count(&rx_rings, &hwr.tx, hwr.cmpl, false);
+	if (rc)
+		return rc;
 	rc = bnge_adjust_rings(bd, &rx_rings, &hwr.tx, hwr.nq, sh);
+	if (rc)
+		return rc;
 	if (bnge_is_agg_reqd(bd))
 		hwr.rx = rx_rings << 1;
 	tx_cp = hwr.tx;
 	hwr.nq = sh ? max_t(u16, tx_cp, rx_rings) : tx_cp + rx_rings;
 	bd->tx_nr_rings = hwr.tx;
+	if (!bd->num_tc)
+		bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
 
 	if (rx_rings != bd->rx_nr_rings)
 		dev_warn(bd->dev, "RX rings resv reduced to %d than earlier %d requested\n",
@@ -347,7 +378,8 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	if (!bnge_rings_ok(&hwr))
 		return -ENOMEM;
 
-	if (old_rx_rings != bd->hw_resc.resv_rx_rings)
+	if (old_rx_rings != bd->hw_resc.resv_rx_rings ||
+	    old_rx_nr_rings != bd->rx_nr_rings)
 		bnge_set_dflt_rss_indir_tbl(bd);
 
 	if (!bnge_aux_registered(bd)) {
@@ -452,6 +484,17 @@ static void _bnge_get_max_rings(struct bnge_dev *bd, u16 *max_rx,
 
 	max_cp = bnge_get_max_func_cp_rings(bd);
 
+	/* Leave one TX ring and one completion ring for RoCE MPC. */
+	if (bnge_is_roce_en(bd)) {
+		if (*max_tx <= 1 || max_cp <= 2) {
+			*max_rx = 0;
+			*max_tx = 0;
+			return;
+		}
+		(*max_tx)--;
+		max_cp--;
+	}
+
 	/* Fix RX and TX rings according to number of CPs available */
 	rc = bnge_fix_rings_count(max_rx, max_tx, max_cp, false);
 	if (rc) {
@@ -595,6 +638,7 @@ int bnge_net_init_dflt_config(struct bnge_dev *bd)
 	if (rc)
 		goto err_free_tbl;
 
+	bnge_set_dflt_rss_indir_tbl(bd);
 	hw_resc = &bd->hw_resc;
 	bd->max_fltr = hw_resc->max_rx_em_flows + hw_resc->max_rx_wm_flows +
 		       BNGE_L2_FLTR_MAX_FLTR;
-- 
2.43.5

