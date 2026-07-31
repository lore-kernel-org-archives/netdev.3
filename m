Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9745DF5B
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525038; cv=none; b=MY5qi7BZ0F9OJTP0y2kP6BBVycAbVVm8jQaWAjoXn+fLdM8q/zQ8egBP7Veg0p94TrFoxr0hII7FWob5QEwcqQnEdQrwwJRSlOTih/Iy8/2xFOwkh9rMxTPg3ztuV/OIoxqaXN/ZIluhvengeLijnaf+2c4/O0BqXVMhVlU7HLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525038; c=relaxed/simple;
	bh=3D0PRG2pw+IRGOYXiQT/abMRNFFxWLmbIWtHr7pk3NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRiUeGRVyMUbFn4xr5osrSrkIwWl9f3nY8Mbk61Q/ktA7h01ZPlgQIy603LsZSR6usj6+tEm7to88MOYQLlF0ZKKD5Neqoak1luTpCt5YKdFsL0WZRdAvxeKmRuBRuUk15QqYfKJdRKqOXhlWN8l389TIwzGOVpExrhA/TVCE4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WDOq2+fR; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WDOq2+fR"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1099989a12.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525037; x=1786129837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oEk2+OUY5oJOZDpi8NZvehKST+JaGQEdTVOn/uvrFMY=;
        b=RE5bkBDjI+FdRPd19uTMAJ23WbOHIrslZJsWTo/gmQhUhxzG3f4rABtp8xYLEIptYT
         ZaVD8fPPTnl8MMeprQp7FNnZrQ689A5dN796LevIwKBetRjcmOScNGQ7/JoTvxAlxFaL
         ICAx7L1I8L0jc1mMFww6vieucB99VtYDz+Cevzcm/Y7o5LwiCrpXaIYbGIadLvO15QFV
         fHerzmbbSpJtnrn1l6xWMwr8LD8Mzc47PZI1dSwbqnKD+w5ZMErxM8MOcaF1zIyTWM7k
         6vlbzoevecoUsYtibSXbxOx/b58oE0vrW3wjnaemy2RHzF2Wo6cKOMgQ+k/dCdCs0+u6
         eh+g==
X-Gm-Message-State: AOJu0YzSYUb1ESDWNkZteu/RIPS/SVIjyThygMOAMz9ak3WZfLcffe8/
	7h4sz/R34/pRkv1Hs9gKYzKN1znXLblFQiIrj8C515tvxH7o8huWjVZAHaA7Pdb7yRS+vm0Tr+P
	cp0NmE15GXDB0h2J9CSoSiUzm5JuafCXL574JS8nj2pzHR2oTZjcw/F/CMIB4IHMyKtC0AFt42z
	Q2UFxVicOSHh8XqGbynQe5wWlBr4ugpJAsL2EOZ3SfX/g0xdr7qza3tYJFoujgRTJtznPoUJQbu
	ayfUEVBPUE=
X-Gm-Gg: AR+sD12DAqB2Gn0i/srokEzY90YPNJHm6eD20/vR2OzLv72TrGjtuxK7nS6aUIp4FDr
	KTjfrUviab3o1Sf5y7PqDX5vTI3tkFirHIdyQlBhxXndCFmzv94siybbVXwP+TF0W7wSaep2t1Q
	5h8sMFlbH8DfV6ycNbFUBICxdiZTo4PzaoBshlIJ4+w7+r8sgjURuEkQNCIJeP1FZn/7sl/XlPH
	Oxjzej/7zAyLckSYUDs4Xf3EL64RR3831CwlQ1lgS5eWivsietC6h1LnPpLphyEMntJgIJ+E7E6
	MX2hZBJzerbCbaRRklWQgC/6TUOyj7e2qDKDgrZzeNa3Sbgi96b/ICmzSp1v1N+LMTScSu9uZ10
	Oo+so6JXH4M+zo22ezgSovlp60pfpVC4A2LLYd3hNiHsgOZT3y/YbAOoJRn0ecKs5fBYl4nMjj1
	mnhsUl/pqazG11mvptryXVBh7ZVJP96vEktgo=
X-Received: by 2002:a05:6a20:7286:b0:3c3:7df6:536e with SMTP id adf61e73a8af0-3c92a95b9f0mr873223637.67.1785525036458;
        Fri, 31 Jul 2026 12:10:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe39eb86d4sm158329a12.10.2026.07.31.12.10.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 12:10:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so1809068a91.2
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785525034; x=1786129834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oEk2+OUY5oJOZDpi8NZvehKST+JaGQEdTVOn/uvrFMY=;
        b=WDOq2+fRIjj0AWx2WeQFeHCrW0xW5yFhknHvYV/dl0uhszdxKVPnTYlSidvy7gjMMu
         N1skVFfTfV/kxJFXdlILfcSUFod2sZIGZVCXEH2Utj/0EBprGQxB8EaOs9BgVOLHeZc0
         kdh6aZ577iibwDwVDKPTB3o0oB+9p75BaZez4=
X-Received: by 2002:a17:90a:f94d:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-38fbc401841mr911518a91.4.1785525034271;
        Fri, 31 Jul 2026 12:10:34 -0700 (PDT)
X-Received: by 2002:a17:90a:f94d:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-38fbc401841mr911489a91.4.1785525033772;
        Fri, 31 Jul 2026 12:10:33 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c1casm8667714eec.10.2026.07.31.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:10:30 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	Shravya KN <shravya.k-n@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 2/5] bnxt_en: Determine and store default RX ring in vnic structure
Date: Fri, 31 Jul 2026 12:09:34 -0700
Message-ID: <20260731190937.807270-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731190937.807270-1-michael.chan@broadcom.com>
References: <20260731190937.807270-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Shravya KN <shravya.k-n@broadcom.com>

Each VNIC has a default RX ring.  The purpose of the default RX ring
is to provide a destination for any packets that cannot be parsed by
the RSS logic.  Up until now, the default RX ring is always Ring 0.

We neglected to take care of this default RX ring when adding the
queue restart feature.  If ring 0 (default ring) is re-started, it
may now have a new FW ring ID after freeing the old one and
allocating a new one.  The VNIC now may have a stale default ring
and it may generate an internal exception.  This exception may
appear in dmesg:

FW reported unknown error type 10

The best way to resolve this issue is to use a more appropriate
ring for the default ring instead of always ring 0.  Ring 0 may not
even be in the RSS table, especially on a new RSS context.

This patch adds the logic to determine and store the proper default
RX ring for a VNIC.  For an RSS VNIC, the default ring is the lowest
ring number in the RSS table.  The next patch will add proper logic
to update the VNIC if the default ring changes after queue restart.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 33 +++++++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 48f4e38ad78d..ff098d959741 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6704,25 +6704,36 @@ int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 static void bnxt_fill_hw_rss_tbl(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
 	bool no_rss = !(vnic->flags & BNXT_VNIC_RSS_FLAG);
-	u16 i, j;
+	u16 i, j, min_j = bp->rx_nr_rings - 1;
 
 	if (!vnic->rss_table)
-		return;
+		goto skip_rss_tbl;
 
 	/* Fill the RSS indirection table with ring group ids */
 	for (i = 0, j = 0; i < HW_HASH_INDEX_SIZE; i++) {
 		if (!no_rss)
 			j = bp->rss_indir_tbl[i];
+		min_j = min(j, min_j);
 		vnic->rss_table[i] = cpu_to_le16(vnic->fw_grp_ids[j]);
 	}
+
+skip_rss_tbl:
+	if (vnic->rss_table && !no_rss)
+		vnic->default_rx_ring = min_j;
+	else if (vnic->flags & BNXT_VNIC_RFS_FLAG)
+		vnic->default_rx_ring = vnic->vnic_id - 1;
+	else if ((vnic->vnic_id == 1) && BNXT_CHIP_TYPE_NITRO_A0(bp))
+		vnic->default_rx_ring = bp->rx_nr_rings - 1;
+	else
+		vnic->default_rx_ring = 0;
 }
 
 static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 				    struct bnxt_vnic_info *vnic)
 {
+	u16 tbl_size, i, min_j = bp->rx_nr_rings - 1;
 	__le16 *ring_tbl = vnic->rss_table;
 	struct bnxt_rx_ring_info *rxr;
-	u16 tbl_size, i;
 
 	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
 
@@ -6735,6 +6746,7 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 			j = ethtool_rxfh_context_indir(vnic->rss_ctx)[i];
 		else
 			j = bp->rss_indir_tbl[i];
+		min_j = min(j, min_j);
 		rxr = &bp->rx_ring[j];
 
 		ring_id = rxr->rx_ring_struct.fw_ring_id;
@@ -6742,6 +6754,7 @@ static void bnxt_fill_hw_rss_tbl_p5(struct bnxt *bp,
 		ring_id = bnxt_cp_ring_for_rx(bp, rxr);
 		*ring_tbl++ = cpu_to_le16(ring_id);
 	}
+	vnic->default_rx_ring = min_j;
 }
 
 static void
@@ -6938,8 +6951,9 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 		return rc;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
-		struct bnxt_rx_ring_info *rxr = &bp->rx_ring[0];
+		struct bnxt_rx_ring_info *rxr;
 
+		rxr = &bp->rx_ring[vnic->default_rx_ring];
 		req->default_rx_ring_id =
 			cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
 		req->default_cmpl_ring_id =
@@ -6972,13 +6986,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 		req->cos_rule = cpu_to_le16(0xffff);
 	}
 
-	if (vnic->flags & BNXT_VNIC_RSS_FLAG)
-		ring = 0;
-	else if (vnic->flags & BNXT_VNIC_RFS_FLAG)
-		ring = vnic->vnic_id - 1;
-	else if ((vnic->vnic_id == 1) && BNXT_CHIP_TYPE_NITRO_A0(bp))
-		ring = bp->rx_nr_rings - 1;
-
+	ring = vnic->default_rx_ring;
 	grp_idx = bp->rx_ring[ring].bnapi->index;
 	req->dflt_ring_grp = cpu_to_le16(bp->grp_info[grp_idx].fw_grp_id);
 	req->lb_rule = cpu_to_le16(0xffff);
@@ -11171,6 +11179,9 @@ static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
 		return rc;
 	}
 
+	/* Setup the proper default RX ring */
+	bnxt_fill_hw_rss_tbl(bp, vnic);
+
 	rc = bnxt_hwrm_vnic_cfg(bp, vnic);
 	if (rc) {
 		netdev_err(bp->dev, "Cannot allocate special vnic for NS2 A0: %x\n",
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6335dfc14c98..44ea8fc7b766 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1334,6 +1334,7 @@ struct bnxt_vnic_info {
 #define BNXT_VNIC_RSSCTX_FLAG		0x40
 	struct ethtool_rxfh_context *rss_ctx;
 	u32		vnic_id;
+	u16		default_rx_ring;
 };
 
 struct bnxt_rss_ctx {
-- 
2.51.0

