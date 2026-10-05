Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860A47DD7C
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202721; cv=none; b=mkEMeupZ0lnyY5py53hDT8yKPYHuYWw5+uzO6B6LoGyijcJsD+4559WGWJqZ3UF/BaAThk90txnZyuJ7/KUfcgxxGe7Ua8QL5xMuR/1IWE7LqYG3Ga+t31wD4NGV5NJF5Ta4Fy7zP4QfvrRdQscyNQ57XXV6CennVyJqpqO/1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202721; c=relaxed/simple;
	bh=/LIJEt6ejiM4yERzOT0rN7VVwt8hL8mUZVByIZk08+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3XTn3uEasOMiyQdnRdmuZBMzifdeVJlpZettlTK7OiJA25ghZEOzu1ppljTkmqbPhvivt3+TZe+Aa/6inEga5BfX4lu0o4HO351OxZWMnniX/6h+W4GGZyDnstZrMQ2c/+0LK/x2howx48udd2olaIL6k7EXpOnWymdlxKJtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SCaHe6Rc; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SCaHe6Rc"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-8ae9bc9a2fcso4385717b3.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202719; x=1791807519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W16N+IdCORWhF5gZqUbJpJO3Io4bveWZ57iIEGn649w=;
        b=YPx7tSFciVM3BAtw5DWMSobbbI/9GKLudVQCzZ01RhBZaQdixO+J3KNI/4Gnq1sish
         lv2YKsgr6EeHG0RBugUEbUG/+o1ohHfbYAQ9re8fa28EfJ1UABEa4jcHgXKQ1IhIMEre
         rRHaj4tyZN2OlT/HpyJtkzHMqf/vyMtcM6Bgj5L+YIVmw+1wlnEwMuBtx4pvSFvsGTEE
         7Sk8EMgOnQA9TP2/Gla1MtDAK4ZagUDSICUvQf1R8ioHNVnFr7yRQGiigzqeY9gCn1vG
         aJv0irEYDX2TfJMvOO1A63hS51P3GRUB7khgSaz6HQCldrcyVGDli7dkHUKt6EkilJ31
         LOEg==
X-Gm-Message-State: AFq9FYIEx8eCL6ZlsVyBlZppkooIMXXA1ZUQkgMbFpsZ2NQxu7iYtkCB
	8+xdeaqLwYRD0vjxZLR943UnB5UtQPcPmrHVIMKKTajVbjj3WiDFL/KxMLeDxJnlYSGWiD+Mnre
	nN2HsLtwrjO4E0nM5yLupTa4D1WqJ+fVCp5258qLUcy6lh+dWPTUSZqfXduji+c/LgFabBBRvnN
	0qMJKdqiJiI5IBgeHbWNiR5oWbIQ+O/0pKzJ2GUx+r4+6xOKQLGB/aJyEAo/zvOECCejMg2Qgaw
	zl3EjLle6ErnzVC5Q==
X-Gm-Gg: AYBFou0tWobVJowUIoWuLNOgpSUL03cVgc7Om14/tpR3buPi27dPPHotkqDi6hnKnLj
	4exuXZ1DYaxOEDN2zumOlcZ0d0sBz/eDst1vrizJuJhLGYPQV/c1qI/35ZV48O1+EYOZt5cb7yR
	B2AOYkDPXYJDZHIEQakfWp7ieoxAWb07WCMP771bWfyW8H2N2O13cB0JLDM9SFj2N6hukn0VNLt
	JzEDqVEw8AMcYgkwP+nsMuLUFIC9zfgQL35aU7Qb9w3j+yc6oYET5Ox7qvgvoRRyYw8uRT2Nrmt
	XrVmPTHmOaQj77/DdMgT3F2xD+Sg0L3G7zX1qE330088aXkvvjCgzNNgPE4ZGvjTkDWAk1zjOEH
	tnr2gjxPYBW1n2otK3pP/+Cqa9oC7C+q27TP3E98pahVB6qyHzrG9bRozfnzdmlwNdzd9O4M3sj
	KmwLKY6wCsb4ushYsGvIdpeElMR+GtZUwMlAUlmnmcBBN3
X-Received: by 2002:a05:690e:1384:b0:677:c330:507a with SMTP id 956f58d0204a3-677c33052a3mr2082220d50.10.1791202719220;
        Mon, 05 Oct 2026 05:18:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-677c1bc375csm1244219d50.30.2026.10.05.05.18.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:18:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso2361879eec.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 05:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791202718; x=1791807518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W16N+IdCORWhF5gZqUbJpJO3Io4bveWZ57iIEGn649w=;
        b=SCaHe6RcFeIw21SZFCyPxxrbckzaIQ6AjbHwhlyzc4dAlRG79SMUPhusUd/7OM0Ydl
         4VYVyvd12Xpqfpb0Punuv6/ZepK9t4uV5UpzMMcnKKkynJN+OLsOUzB6v/TNLl3JoC0X
         wk5ECw2KKhC4GtqR+IH1MnE1LeqiCP7U9NRT4=
X-Received: by 2002:a05:693c:894b:20b0:351:2f0a:cb2a with SMTP id 5a478bee46e88-3512f0acda4mr3139202eec.2.1791202717975;
        Mon, 05 Oct 2026 05:18:37 -0700 (PDT)
X-Received: by 2002:a05:693c:894b:20b0:351:2f0a:cb2a with SMTP id 5a478bee46e88-3512f0acda4mr3139181eec.2.1791202717100;
        Mon, 05 Oct 2026 05:18:37 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272ceb02sm25687542eec.25.2026.10.05.05.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:18:36 -0700 (PDT)
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
Subject: [PATCH net 1/4] bnge: fix NULL deref in bnge_alloc_core() on failure
Date: Mon,  5 Oct 2026 17:47:01 +0530
Message-ID: <20261005121704.227866-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
References: <20261005121704.227866-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

bnge_alloc_core() previously jumped to a single error label that called
bnge_free_core() to unwind. However, bnge_free_core() assumes a fully
initialized state and dereferences rx/tx ring arrays unconditionally.
If ring allocations fail early, this causes a near-NULL dereference.

Introduce a standard goto ladder to unwind only the resources that were
successfully allocated, preventing NULL dereferences.

Fixes: 0259379037ca ("bng_en: Add initial support for RX and TX rings")
Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Reviewed-by: Ramakrishna Koduri <ramakrishna.koduri@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 46 ++++++++++++++-----
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..bf101eded3bf 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1243,7 +1243,7 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
 	if (!bn->rx_ring)
-		goto err_free_core;
+		goto err_free_bnapi;
 
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
@@ -1258,12 +1258,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	bn->tx_ring = kzalloc_objs(struct bnge_tx_ring_info, bd->tx_nr_rings);
 	if (!bn->tx_ring)
-		goto err_free_core;
+		goto err_free_rx_ring;
 
 	bn->tx_ring_map = kcalloc(bd->tx_nr_rings, sizeof(u16),
 				  GFP_KERNEL);
 	if (!bn->tx_ring_map)
-		goto err_free_core;
+		goto err_free_tx_ring;
 
 	if (bd->flags & BNGE_EN_SHARED_CHNL)
 		j = 0;
@@ -1289,42 +1289,64 @@ static int bnge_alloc_core(struct bnge_net *bn)
 
 	rc = bnge_alloc_ring_stats(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_tx_ring_map;
 
 	bnge_init_stats(bn);
 
 	rc = bnge_alloc_vnics(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_ring_stats;
 
 	rc = bnge_alloc_nq_arrays(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_vnics;
 
 	bnge_init_ring_struct(bn);
 
 	rc = bnge_alloc_rx_rings(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_nq_arrays;
 
 	rc = bnge_alloc_tx_rings(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_rx_rings;
 
 	rc = bnge_alloc_nq_tree(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_tx_rings;
 
 	bn->vnic_info[BNGE_VNIC_DEFAULT].flags |= BNGE_VNIC_RSS_FLAG |
 						  BNGE_VNIC_MCAST_FLAG |
 						  BNGE_VNIC_UCAST_FLAG;
 	rc = bnge_alloc_vnic_attributes(bn);
 	if (rc)
-		goto err_free_core;
+		goto err_free_nq_tree;
 	return 0;
 
-err_free_core:
-	bnge_free_core(bn);
+err_free_nq_tree:
+	bnge_free_nq_tree(bn);
+err_free_tx_rings:
+	bnge_free_tx_rings(bn);
+err_free_rx_rings:
+	bnge_free_rx_rings(bn);
+err_free_nq_arrays:
+	bnge_free_nq_arrays(bn);
+err_free_vnics:
+	bnge_free_vnics(bn);
+err_free_ring_stats:
+	bnge_free_ring_stats(bn);
+err_free_tx_ring_map:
+	kfree(bn->tx_ring_map);
+	bn->tx_ring_map = NULL;
+err_free_tx_ring:
+	kfree(bn->tx_ring);
+	bn->tx_ring = NULL;
+err_free_rx_ring:
+	kfree(bn->rx_ring);
+	bn->rx_ring = NULL;
+err_free_bnapi:
+	kfree(bn->bnapi);
+	bn->bnapi = NULL;
 	return rc;
 }
 
-- 
2.47.3

