Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992474A2065
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290295; cv=none; b=tkYRko93ypX4hC5esdB/bOdWhs6zFFnWsGarugj7RoKxi8zgU85Sdw6Kx3I15F1FS6qPxSJniFyv2IdBZqRi2d2wWd2XvtSGh7pFy1+/+usUqJLBDrrCFteuX+e+KT0jqnYuJ8apn/uXh3yQPbnMLZvg+MwSRt8Jy0LfrCDdXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290295; c=relaxed/simple;
	bh=N/tCHeYqR6Ax1LGbE9004IWszWIiHPljP/W/diJ1iHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KphNzHRkevM1fg2iS4yA+AVO6MBPRkQT8FB8YA/AeB3ztkhzWM8vOKoU9T6REq5ko8VoccaDmObj9J81dqIEQk57750B5zHeRN1W/VO36ug4ZwdyVtonsU6J6y/qNo3FfpuMolYJ8sqg1eI8J8LKL75HtlqoB4iWEngSN9214uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LyYJhfKb; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LyYJhfKb"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso187721a91.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290293; x=1788895093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XV4iTp1dLb8Uvgeqz0AL8wZ3RxxmiSYklSPq0glGVL4=;
        b=RHJh3BmRHyXUbSJ/MiL/cHSvMZp5brlrgrmFbaUFkfY59bxzjDPgrn6mCeCwQs1RS7
         pC1wOgE6W5Xi2KRa6Regu7cJt5FrS0rnRPYX2wK+M/ODf1iT/uaDmCHz7J9YTs3dVEJB
         PZjnbx0K8r0cNPmXfQ20ub8BaJcJnVuIzxi+qJr88NvSCFEktm2HjcJNAjFPnpnu1UFd
         HnX4ipqDIQoQ5q7PVlYGGXl4EPT14aK3tzf83cft2cHPIWQe44R26MtusaOmIv1+5U6T
         qeEND3zRgibqjB4HjbcKfepjHX6WotO3H0xAp+4D538Mx7JHq9bBFtIGptMeA3jtBChl
         WfEA==
X-Gm-Message-State: AFuF++nLzrPOt2oE34Pye7R9vuVD8l3X4jTr8uco/cWc5XztfVb0p9Vs
	f0Gol743M4QfHrMbL+6Vf1DD0Sd4Uawds72OCMHKjSyoRZmmS8Z+/u+S33SYOmH+4T7HTAwiqi3
	W3Vi9q1Y4FmDtak77zulAlwnDtNz1Fr44nkQ43BElWVswdrDIBjxaqpK9SkbMyYonQebuYak5V6
	6c6/mdrbUl420lPtAdO+hB/zDDPB9RJp64+KD3zw3/RmtQb/L10B1yPaku7oT+swp6s2QDIwtam
	MjhlyfG62387oBwvQ==
X-Gm-Gg: AYBFou3wi+yf88kuMSySaxdJdQqUfJG+/uydGd/6r1W+lo5wJDSMkSN53GDjV/YVZ1b
	ICBCs1fvSxgtsKGhIaK9BHda/L1cBFeRfq7Y2ye2PoappTSArrUr+uDWaN9n0DcwD+Dhj8fWq9b
	iT7QI581gxDw7Rqp7Ucua3fuzcisvTvjwKUoqvmppx3sGepq2P54+k9OQJk6vtcnCbwqI1lQaUv
	cWIjcjIfxuoed7qeH8To2STpyuHNUUtBnyn4wvSOs0pmWym87oG0WX8VrNXyy7bxvjgbL+UGo11
	dTQcHxlqFQQjKdMxEqynTvlwi2MJ92HsR0NyqbiiEfRI0dG+acneGZUzFchCQn49WxOf1a/LaBH
	TydE4ly+PGXZnMbLaS716DVSxPeZQfQvEyfLIp3FWfC389UvArBATVja7L2cr1WLOFnDuN+QVcH
	H8lXVu/gcKlhbpnhCqMrkfqpr85LiGUDaPN2mYhZw+Rg==
X-Received: by 2002:a17:90b:3e43:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-396d0f67646mr56809262a91.12.1788290292626;
        Tue, 01 Sep 2026 12:18:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39ae0f429e8sm209963a91.2.2026.09.01.12.18.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso208786a91.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290291; x=1788895091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XV4iTp1dLb8Uvgeqz0AL8wZ3RxxmiSYklSPq0glGVL4=;
        b=LyYJhfKbu5pbUiGpoFvfMMEDQS5cMYyptd42JFZY6boLz0XaZZBLH84dG59aaxtWHE
         KQAq2WSNbqJU2I9RvOqJdT7vLrb+jNWDW28TuBJdPI0tEnVncTfyqSUukQj67KHZBJ5G
         RFG+ABRI9yU9A7YBtVIIlZhOJbWDFoXYeH0i0=
X-Received: by 2002:a17:90b:1811:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-398e86bcf08mr22289972a91.20.1788290290917;
        Tue, 01 Sep 2026 12:18:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-398e86bcf08mr22289890a91.20.1788290290346;
        Tue, 01 Sep 2026 12:18:10 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:09 -0700 (PDT)
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
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [PATCH net-next 1/7] bnge: Extract bnapi allocation and cleanup into helpers
Date: Wed,  2 Sep 2026 00:47:22 +0530
Message-ID: <20260901191728.643212-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Factor bn->bnapi allocation and free logic out of bnge_{alloc,free}_core()
into new bnge_{alloc,free}_bnapi_mem() helpers.

This is a pure refactor with no functional changes, preparing the driver to
move bnapi allocation out of the open/close path.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..dbadbf76a3a9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1195,6 +1195,12 @@ static int bnge_init_ring_grps(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_free_bnapi_mem(struct bnge_net *bn)
+{
+	kfree(bn->bnapi);
+	bn->bnapi = NULL;
+}
+
 static void bnge_free_core(struct bnge_net *bn)
 {
 	bnge_free_vnic_attributes(bn);
@@ -1211,15 +1217,13 @@ static void bnge_free_core(struct bnge_net *bn)
 	bn->tx_ring = NULL;
 	kfree(bn->rx_ring);
 	bn->rx_ring = NULL;
-	kfree(bn->bnapi);
-	bn->bnapi = NULL;
+	bnge_free_bnapi_mem(bn);
 }
 
-static int bnge_alloc_core(struct bnge_net *bn)
+static int bnge_alloc_bnapi_mem(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
-	int i, j, size, arr_size;
-	int rc = -ENOMEM;
+	int i, size, arr_size;
 	void *bnapi;
 
 	arr_size = L1_CACHE_ALIGN(sizeof(struct bnge_napi *) *
@@ -1227,7 +1231,7 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
 	bnapi = kzalloc(arr_size + size * bd->nq_nr_rings, GFP_KERNEL);
 	if (!bnapi)
-		return rc;
+		return -ENOMEM;
 
 	bn->bnapi = bnapi;
 	bnapi += arr_size;
@@ -1241,6 +1245,19 @@ static int bnge_alloc_core(struct bnge_net *bn)
 		nqr->ring_struct.ring_mem.flags = BNGE_RMEM_RING_PTE_FLAG;
 	}
 
+	return 0;
+}
+
+static int bnge_alloc_core(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j, rc;
+
+	rc = bnge_alloc_bnapi_mem(bn);
+	if (rc)
+		return rc;
+
+	rc = -ENOMEM;
 	bn->rx_ring = kzalloc_objs(struct bnge_rx_ring_info, bd->rx_nr_rings);
 	if (!bn->rx_ring)
 		goto err_free_core;
-- 
2.47.3

