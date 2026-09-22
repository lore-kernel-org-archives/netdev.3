Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082B369D7A
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055048; cv=none; b=fDDNAY4eLni1KNuLw+gPygWRpj9/4EnWn3M+5P8ZQ8A9IEPwYeqgZJt27o5XxPNCNLDbPWdHFvwUr8zTZJUoA8Jug4Nxb0AyEettDATxpjE1xyDFMbdCaX0C29HEr/4tsDq99ek+TofUej0n3ipEoYnBCfieLp3IYCDyRkI/pJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055048; c=relaxed/simple;
	bh=xuxYnRMr0gJHNE+YhHEeh99xU9e2M8kDtnKD3F7vd2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex4OGAjGMejjzf8JB4Dp4aNBSugNp58X8JZnvMdvohv/1IezigzzASdhUw6bjpECAn4ghcgjwSaKTcIc2aSQDzamKX0Gbt3//sNvG+rJh9hunHM555Bf9lsFysaFwXpa5z8wIPdqHud6IwGf4DMwp7WNnG7c0COYlMGgRSeCwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hXx1f6aI; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hXx1f6aI"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c84060045aso402080e0c.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055042; x=1790659842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRZ3B1Ko8/WCM77tME79PUcj2CiBKcaRJ7ZjElWoLfY=;
        b=ZkFgf5oqxYEe8LtqD2R5PAQ8HfmK1+l8rw8amKgztW0QuPzzM7SHq1CLOXxN8TVybH
         r/mqwt/+zyvaPkrJ8uDijWww9AKq4nICPmPYuXeF8L5m+7elgk9ePBl6mQatm49r5wWC
         T14Dna8Ix2uQ1bpDaflbesdD6h8pol0VQocc78fWh2r5zRYta2svUkqAhrWcFIJmj3N8
         ibsDjxMQhdVQzoLOoDABMs8ObR+NnjkMO33JqiGLbeQJJP39lF/Vo2AZzzzK72y3Go45
         ZcUK1r90OA7UrTfugxxkgvSBMIX0w5RW10uFmMf2SrKvvSQwbpVW/+LYKIx+MVk/eLbt
         5RgA==
X-Gm-Message-State: AFuF++m6yMyELr7FMuSbA9TVJpPNWhSIklo+xeO1mh8JZ2fk2yNGtlE3
	rkt5lJc6PWaCBjY4sKqbInJ0TSbd5YHsOMU162ugOlgUmQWOKelQUIBTMAb3gD5lnb0s+19aQC6
	inBpHNWosor/aT+JDy30+QoRvj9M1m/ML9yN+LX3Z2j6LfB0QugkSWSdMAfgQ5QFG3sfcmSVW3p
	tE0bOWgGDnDbgqaQS669DqpLhPPpz7STsEYcHtsaMae1uFMMJ4rRB5WcjlOB2U0miBTkiYZTIZw
	tuGeO0KOzxcRxvFYw==
X-Gm-Gg: AYBFou2illdI6dO7h2EwWlTxc7k9xJCl33nWroTbuHrep4SEwbbqlx52ITFvYXVuah0
	7aw614w1L1KKO/CAKUqsWrMULA43YUCU0uIlTdY80590kvLwLbYkO+0M5P7AIEsvga6iBL6I9vj
	25XYCJ82zUJI1bobK9pfVTKGN84Z13ejkRHVmc4gF6faXbKvMA9k01DZuZGg9xpSovvVGPlLsCT
	72R2hWxg4J6ImILoitv6uIjf5hChvQzio0mM00+EdZv0hk0Qs4++9o7/BDbCvyWHWTCmB86RPb4
	lsgmW4T+67pZ7WVHNG8zjQoom+egSmMS2BRhhI6aY77pO5+W3IoZfGD15VhXFhhpXhWXZ80rBHD
	ojNjNMeMOJFrikV28DPNZ3equ50FfCNG6HleaxO1lxho0usVigYieUl6KaD8+SxylrZrk+DelKC
	qjYDqZKnFqCbQnqVcyfWBVQc2ADuBLKVEywprC5xZWWQ==
X-Received: by 2002:a05:6122:3488:b0:5bd:cb34:1b70 with SMTP id 71dfb90a1353d-5c9b5885d0dmr7430010e0c.1.1790055042462;
        Mon, 21 Sep 2026 22:30:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c9e7c7fabbsm235889e0c.3.2026.09.21.22.30.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:30:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so12158114a91.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055041; x=1790659841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRZ3B1Ko8/WCM77tME79PUcj2CiBKcaRJ7ZjElWoLfY=;
        b=hXx1f6aIHcDMMQHE8rrNb3gKfRcSg/UQT/606ZNbsmRMTmSDDgsFBDj35dILHQMtS8
         1Wj5GZtvVjZpzxNOrLjaOL/CxaUehyVvNOQHzsFwV9iSnrPvpAPpGRv051Dd59NcQuwb
         YXrlTMM8Lqb07gPAD61j/poNGGTmjRQOfcTnk=
X-Received: by 2002:a17:90b:3143:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-3a07309d174mr70326a91.11.1790055040735;
        Mon, 21 Sep 2026 22:30:40 -0700 (PDT)
X-Received: by 2002:a17:90b:3143:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-3a07309d174mr70300a91.11.1790055040290;
        Mon, 21 Sep 2026 22:30:40 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:30:39 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/6] bnge: Extract bnapi allocation and cleanup into helpers
Date: Tue, 22 Sep 2026 10:58:59 +0530
Message-ID: <20260922052904.59237-2-bhargava.marreddy@broadcom.com>
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

Factor bn->bnapi allocation and free logic out of bnge_{alloc,free}_core()
into new bnge_{alloc,free}_bnapi_mem() helpers.

Prepare the driver to move bnapi allocation out of the open/close path,
and add NULL guards for rx_ring and tx_ring in core driver cleanup paths.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 38 ++++++++++++++++---
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..c1810a309888 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -825,6 +825,9 @@ static void bnge_free_tpa_info(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i, j;
 
+	if (!bn->rx_ring)
+		return;
+
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
 
@@ -881,6 +884,9 @@ static void bnge_free_rx_rings(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	if (!bn->rx_ring)
+		return;
+
 	bnge_free_tpa_info(bn);
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
@@ -1024,6 +1030,9 @@ static void bnge_free_tx_rings(struct bnge_net *bn)
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	if (!bn->tx_ring)
+		return;
+
 	for (i = 0; i < bd->tx_nr_rings; i++) {
 		struct bnge_tx_ring_info *txr = &bn->tx_ring[i];
 		struct bnge_ring_struct *ring;
@@ -1195,6 +1204,12 @@ static int bnge_init_ring_grps(struct bnge_net *bn)
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
@@ -1211,15 +1226,13 @@ static void bnge_free_core(struct bnge_net *bn)
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
@@ -1227,7 +1240,7 @@ static int bnge_alloc_core(struct bnge_net *bn)
 	size = L1_CACHE_ALIGN(sizeof(struct bnge_napi));
 	bnapi = kzalloc(arr_size + size * bd->nq_nr_rings, GFP_KERNEL);
 	if (!bnapi)
-		return rc;
+		return -ENOMEM;
 
 	bn->bnapi = bnapi;
 	bnapi += arr_size;
@@ -1241,6 +1254,19 @@ static int bnge_alloc_core(struct bnge_net *bn)
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

