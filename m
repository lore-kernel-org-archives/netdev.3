Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3F4BE443
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066753; cv=none; b=g3aHdmW2zc2SIPdQUVmExJxEQUcM4vIo5sR3kDQFwObQgkOXrPj2jdvAcwS+22c8kxy6gIsgn2zRiCbUSjCQMChPK1e4kkMboF/k1LoeXoujfCx8kpqd12CUfImGb/kHYqaddm5934wqxcR6k3Ol2jG8ZfaKoobe4cFjytd6vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066753; c=relaxed/simple;
	bh=j4e5CMHH6Qy3yGv7hPDaN6nbYX4fg3B648nSU610qaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSfLY+5r7ecqSeH0aP357Dr9Pzj476QPvg/Ahd2JBIanAdkbXX/aWdmJEbKnRP1VKf4sse9SCchmffOMG3bi8PKXajJaNXu6RhV1Io3xkWRE53Dh2CYDitv+UJaJBXEr5/waeCyZ5D0leAf6zhqy8dPMhuPfEmCTpzcn/swDXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=InWddhV1; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="InWddhV1"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so2317751a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066751; x=1792671551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pAA3M36W1ZDabCba0TYx3EwBtZTYKmGhEXj5INi2E/M=;
        b=j0TpLSlUEGoExTP+5oQMKLkFGSAGJu0ETtnsO9A25gpkDaoC24cqexLemwMa8BBFYC
         budbR+B46+lzUGziYlcrd197nMppPCyjQnz4uqNFlLBYL/3Wv7ZIkuHTJfjMBkHazjX0
         UAW4573/aZToqMshP2czBY+7XerqJri3D3KTADG8XGtn7as0QPt9P2ExY1N26z5gAkPy
         Ho5LY/1cCGMV+GisCH4oXdF4ek3vY2ZgH2b7mN9PDVGbA9gAyd7GPncO43f1tjLjY8nO
         4amM75WcMksg27GUU6mYu2xKtskMBwsLZhFZEgOIw3sjKTpVE+o2vqZOHuXj7sCATebB
         rQJA==
X-Gm-Message-State: AFq9FYLe7Cv2aNsz0jurRR0eK8Rfm082uK3z/yy4OYLMZyASIt/Cq8V9
	mR7LVmXVx2bXYfDrPdPm7Zm2i/vd9IZOBCJG+QZjTo4c6YnKv/pcZlbp9Yc5xWPMDJSh6BRYrpb
	L2w5fA1nfaBbm6XBczBgtgDv0G9VaIShIP4a9jtY2dFJcqbHkha07JIAr15SQxlY+K0dxTfRRmP
	GHupUdVkCd0bWfGrB4ohUTdv/ECFGiYP/3Ypr3kfuUoZik6iygP55lNwkktSShEwLlsuK2ykuyf
	0RSQM4mcQ==
X-Gm-Gg: AYBFou0hIR3ogFXL724ravdoMGzh6mh+225dDcn77XxOVS0Rci/oDJZWJuTmNOjyJoy
	t8Dwy9P9n3qKri8U7zVKbgQw0sv6NKf4CLCgRRKKou07/QFnb9QwfIlOBjc0yUNh7d/Kaj6loNg
	tt5OJvSB71VBxzz/nhjPD+Lq0H18OcBI4BnBfXXJkg+5X9bs22SOSuSFWE9rZRIBqOYv7ZPPl5i
	XO1TIrOpKf8ahuYbrRmxDzzdx/gq3M9beWPx+X+qqWfZXYtfls7pKc39Op0+rrpOej73q7UJRuM
	8WGvDNMPXVSLdRBpgv01OyNZXY3WmmZudDu/n6swE+2LeI91+uXYYt9PFUTVXSsWUpqeNBdQAN2
	C6xfABE+SdV5iDW87tRv7I1A67yC0955xV6i93x59SCwA8doIaNVvfeIR6IJ+c+vLm/LTbOo9EK
	QdQZN/Uf5pakhdCZ8+Qs++W8bhOteNndEpHChm
X-Received: by 2002:a17:90b:52d0:b0:3ac:9f00:3bc8 with SMTP id 98e67ed59e1d1-3ac9f003c6cmr1537168a91.36.1792066751153;
        Thu, 15 Oct 2026 05:19:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac9376c7casm526690a91.2.2026.10.15.05.19.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:19:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35d4538fd74so5896352eec.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792066749; x=1792671549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAA3M36W1ZDabCba0TYx3EwBtZTYKmGhEXj5INi2E/M=;
        b=InWddhV1C8z5DLvPa2rmamw/G7qCSjor05YgJ0fr6ij9cNzc2IsRd+9M8lYsYlxUNB
         l+pvFuJgkymWtEwpmD7ta3aZ8TB0zrhStqmRcO++8tCfpZxJlpfMRor8BIVbbfhPgXZq
         tnsamN5kvqXCCkFgH717WM7bQQSUBTlmxVtjk=
X-Received: by 2002:a05:693c:4145:20b0:342:810b:9554 with SMTP id 5a478bee46e88-3537e0f5bb2mr27900515eec.32.1792066748798;
        Thu, 15 Oct 2026 05:19:08 -0700 (PDT)
X-Received: by 2002:a05:693c:4145:20b0:342:810b:9554 with SMTP id 5a478bee46e88-3537e0f5bb2mr27900463eec.32.1792066747974;
        Thu, 15 Oct 2026 05:19:07 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm64496032eec.26.2026.10.15.05.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:19:07 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net v2 2/2] bnge: fix RSS table sizing for large RX ring counts
Date: Thu, 15 Oct 2026 17:48:47 +0530
Message-ID: <20261015121847.1933308-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
References: <20261015121847.1933308-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Dharmender Garg <dharmender.garg@broadcom.com>

bnge_adjust_pow_two() adds one block before rounding up to a power of
two only when the quotient is 0 or 1. A larger quotient that is
already a power of two is returned unchanged, so 129-192 RX rings
get a 128-entry RSS indirection table and 257-320 rings a 256-entry
one. The rings above the table size never receive default RSS traffic.
bnxt_calc_nr_ring_pages() always adds one, which is correct.

Make bnge_adjust_pow_two() always add one block before rounding up.
The same helper also sized the ring pages; to keep the ring size
calculation unchanged, move that to a separate bnge_calc_nr_ring_pages()
helper that retains the original rounding.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 10 +++++-----
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h   | 11 +++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..ecba8aff3052 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3339,8 +3339,8 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 		}
 		agg_ring_size = ring_size * agg_factor;
 
-		bn->rx_agg_nr_pages = bnge_adjust_pow_two(agg_ring_size,
-							  RX_DESC_CNT);
+		bn->rx_agg_nr_pages = bnge_calc_nr_ring_pages(agg_ring_size,
+							      RX_DESC_CNT);
 		if (bn->rx_agg_nr_pages > MAX_RX_AGG_PAGES) {
 			u32 tmp = agg_ring_size;
 
@@ -3363,11 +3363,11 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	bn->rx_buf_use_size = rx_size;
 	bn->rx_buf_size = rx_space;
 
-	bn->rx_nr_pages = bnge_adjust_pow_two(ring_size, RX_DESC_CNT);
+	bn->rx_nr_pages = bnge_calc_nr_ring_pages(ring_size, RX_DESC_CNT);
 	bn->rx_ring_mask = (bn->rx_nr_pages * RX_DESC_CNT) - 1;
 
 	ring_size = bn->tx_ring_size;
-	bn->tx_nr_pages = bnge_adjust_pow_two(ring_size, TX_DESC_CNT);
+	bn->tx_nr_pages = bnge_calc_nr_ring_pages(ring_size, TX_DESC_CNT);
 	bn->tx_ring_mask = (bn->tx_nr_pages * TX_DESC_CNT) - 1;
 
 	max_rx_cmpl = bn->rx_ring_size;
@@ -3377,7 +3377,7 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	ring_size = max_rx_cmpl * 2 + agg_ring_size + bn->tx_ring_size;
 	bn->cp_ring_size = ring_size;
 
-	bn->cp_nr_pages = bnge_adjust_pow_two(ring_size, CP_DESC_CNT);
+	bn->cp_nr_pages = bnge_calc_nr_ring_pages(ring_size, CP_DESC_CNT);
 	if (bn->cp_nr_pages > MAX_CP_PAGES) {
 		bn->cp_nr_pages = MAX_CP_PAGES;
 		bn->cp_ring_size = MAX_CP_PAGES * CP_DESC_CNT - 1;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index b62a634669f6..58462524939f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -81,6 +81,17 @@ bnge_adjust_pow_two(u32 total_ent, u16 ent_per_blk)
 {
 	u32 blks = total_ent / ent_per_blk;
 
+	if (!blks)
+		return 1;
+
+	return roundup_pow_of_two(blks + 1);
+}
+
+static inline u32
+bnge_calc_nr_ring_pages(u32 total_ent, u16 ent_per_blk)
+{
+	u32 blks = total_ent / ent_per_blk;
+
 	if (blks == 0 || blks == 1)
 		return ++blks;
 
-- 
2.52.0

