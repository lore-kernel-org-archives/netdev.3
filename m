Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9234CC294
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842957; cv=none; b=QDaIgc7Nvd3q2MvoGXXhlnCFBfUEeQqB7+/ZlkOI7ziwgpUIZOjjeCVjauQurkfC/BI2wxvbSkNZbugXpyTxc2OPCdi7RlKSpur2Wv6Xtws5SDnqO1DzM3IR7NuTK+92Ibb+u+ASTk8X/9t1L1v2URMZNr0y9+PM2AYSzcIhDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842957; c=relaxed/simple;
	bh=GBHEzsdjfF9UrUESv2/hHa+usNp7KA3kVjE7Qors1Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHDgRg9TuwYet1+P0EPSNr9xY1PN0yt23av5J3jlwidzjf3XL2ZWT01a/YDniCSGS2ErCXI743+X23AkSuosw4mhNtm5T3Pp55aJbQcIypqFxAdx8CRExyCRnoDJx5vglaNiZyrYgkQ4kdIuBIJkoZiBHWjIQH3FOF2BA0pXCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V7oBlDkN; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V7oBlDkN"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1483451a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842955; x=1792447755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFrMCGbUW0P9PFOQLa17SXS1CJ/Ku0drbwvs+O0fOAA=;
        b=mUD7O+++nF6g5GL5qwwvwHkVxA8dr2YxkTgNmmHLrgU7TYpVQbWiJG48Kk9cmPXcc5
         98QuwjBj74zlqKKU3/HsFs/atUC0QLNh2egr7tkJ2b0ug7Uku0tNO5N4Zdq6boSGNQ44
         9IO+0MbPZ45zSvEB20MJf1qeOLIl1mnjPAs5dqUks1TgQiQ5t3ScXgYopGtmrFVMLKIF
         ONMnsq11H3w6DALOXP9NrhtWgwrw+Dabktka3/RYnT5aSF5L/Xuu9G0nh4T/nbHmgeM5
         SnjeXivbgS+KVnNgtC947aSQ/RpmkIdTePBqRkX4bTJa5OAfXYLK5smH35zt52VtMegt
         2p7g==
X-Gm-Message-State: AFq9FYIJVwxNwB1TsyhftVXQWqbf4vXIQsW4G/zxphzFFigpyzaswfs+
	qnKZYpemdgRgLrTk7Ej7Il7shyTNK8GPaKrfsAj0P7UqoKCDDYskZSQuelm4ZGfQ9gAAR0q0hiL
	qRdm/SdXUIkK2GL0hZGLcw0QQ8qudIk5K3822TipmKq21P0tYMRUe/izzKMVDblLV0aDPsxdYYj
	6g8R1yjJ1WUUBcVXuu+khjuCvbl+DJSGyqALWzuG3Eejhd7+//44003xbhdAb+GSvBA+Xzi2o+j
	LzSB5v6NLE=
X-Gm-Gg: AYBFou0rKsx4MlSr2ywUe0m07mNIBy8FZie8mvq4UXPhfZcqVES8W+pxlahwSvdVmdo
	tBE635dYqNqmu6Ealt/BWc/EH8o0rZFgSsBu6UKbYFYEF1iBySlhqWOq2uo0rPqZgll7ZV2/Jng
	uhD8NReqxmPXGUI66C/BqzBI0b9KTFTA6hLc73gKKKHEdaEMQSME+JUoMpkIhd97/Q/aBVX8Tjm
	gI5kC9eFkEHBMwLhLUmByt/IxDf1novq6rISNOTdOnPto+iSKuP/jE2FMSLwqh5YqOO2RJCRZ/T
	PQnTBxMcujYYB8awbwVx4aaK5VHh0JtXzReNRmmu0PzB4wsiRGRkZmZZoWSRTOHNfObSZ8fZg9t
	p9f8LhI+OQwxgNPxOxWskDM/9oXrHkzADruLtG/ivIQo670QMiZcVD95L5YN0k6N3TKvlraFLI0
	DBt3oWJ0dSUNXZfxLzL+EtqY702WX+wlCm0J/Ytg==
X-Received: by 2002:a17:90b:5343:b0:3a8:c0cd:57fa with SMTP id 98e67ed59e1d1-3ab3a956d33mr9355732a91.11.1791842955064;
        Mon, 12 Oct 2026 15:09:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36def2dasm6507270a91.6.2026.10.12.15.09.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a4d2e39acso5526577eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842953; x=1792447753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFrMCGbUW0P9PFOQLa17SXS1CJ/Ku0drbwvs+O0fOAA=;
        b=V7oBlDkNnbxV/LmcwrI0SWzD6uzDCxp00/ulGThZVArJI+cLG7/CeayoYrWU+wE7iQ
         7mMxsWYhytHFbB0B0HH+kI0U7gjMz0pqpLOaXNtH8yn788EBKS7eqY6UPwQEmWjXTMa2
         NlE5i3I5D4hAmLnQ5EFMARcbYhfXL17E3sksE=
X-Received: by 2002:a05:701b:2411:b0:170:aeef:a170 with SMTP id a92af1059eb24-170aeefa475mr9339284c88.36.1791842952823;
        Mon, 12 Oct 2026 15:09:12 -0700 (PDT)
X-Received: by 2002:a05:701b:2411:b0:170:aeef:a170 with SMTP id a92af1059eb24-170aeefa475mr9339266c88.36.1791842952224;
        Mon, 12 Oct 2026 15:09:12 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:11 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 5/7] bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
Date: Mon, 12 Oct 2026 15:08:25 -0700
Message-ID: <20261012220827.340998-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012220827.340998-1-michael.chan@broadcom.com>
References: <20261012220827.340998-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When configuring LRO/GRO/HDS, a new set of RX Aggregation rings may be
required.  It is possible that the FW cannot grant the desired number
of Agg rings, causing the driver to reduce the number of ethtool
channels to adjust.  This means that the number of IRQs/NAPIs may
change and we must set irq_re_init to true to make that work.  Without
this patch, when the driver is eventually shutdown, some memory for the
unused NAPIs may never be freed properly if the rings have shrunk.

Fixes: 87c8f8496a05 ("bnxt_en: add support for tcp-data-split ethtool command")
Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 11 ++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 05e609adf6a3..2ada2bb8fd57 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14115,10 +14115,11 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 {
 	bool update_tpa = false, update_ntuple = false;
 	struct bnxt *bp = netdev_priv(dev);
+	bool irq_re_init = false;
 	u32 flags = bp->flags;
+	bool re_init = false;
 	u32 changes;
 	int rc = 0;
-	bool re_init = false;
 
 	bp->tx_wake_thresh = max_t(int, bp->tx_ring_size / 2,
 				   bnxt_min_tx_desc_cnt(bp, features));
@@ -14145,8 +14146,12 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 		update_tpa = true;
 		if ((bp->flags & BNXT_FLAG_TPA) == 0 ||
 		    (flags & BNXT_FLAG_TPA) == 0 ||
-		    (bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
+		    (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
 			re_init = true;
+			if (!(bp->flags & BNXT_FLAG_AGG_RINGS) &&
+			    (flags & BNXT_FLAG_AGG_RINGS))
+				irq_re_init = true;
+		}
 	}
 
 	if (changes & ~BNXT_FLAG_TPA)
@@ -14169,7 +14174,7 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
 			return bnxt_reinit_features(bp, true, false, flags, update_tpa);
 
 		if (re_init)
-			return bnxt_reinit_features(bp, false, false, flags, update_tpa);
+			return bnxt_reinit_features(bp, irq_re_init, false, flags, update_tpa);
 
 		if (update_tpa) {
 			bp->flags = flags;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 622e89587e5d..5c9e770960e6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -853,6 +853,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 {
 	u8 tcp_data_split = kernel_ering->tcp_data_split;
 	struct bnxt *bp = netdev_priv(dev);
+	bool irq_re_init = false;
 	u8 hds_config_mod;
 	int rc;
 
@@ -876,8 +877,13 @@ static int bnxt_set_ringparam(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (hds_config_mod &&
+	    tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    !(bp->flags & BNXT_FLAG_AGG_RINGS))
+		irq_re_init = true;
+
 	if (netif_running(dev))
-		bnxt_close_nic(bp, false, false);
+		bnxt_close_nic(bp, irq_re_init, false);
 
 	if (hds_config_mod) {
 		if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
@@ -891,7 +897,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev)) {
-		rc = bnxt_open_nic(bp, false, false);
+		rc = bnxt_open_nic(bp, irq_re_init, false);
 		if (rc)
 			return rc;
 	}
-- 
2.51.0

