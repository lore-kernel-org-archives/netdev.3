Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08264F3EDB
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842953; cv=none; b=NElZ03WAIMEHB9WCva0IzpvYMN5YHFDv4kpz9gbaNY/g4NX6U+WmPrggS6vJOWDfiROoNHnrxm9fGe6hb5C/JAGqELzoQR8Zmuq+r3TgTpaupRArs9D8kgPCSCxtwx8BQ02BejnNN8pDgFEEscvMwyr1bta1eeZqYDBoA7PThQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842953; c=relaxed/simple;
	bh=P+IBvxlSBzTXJvfpf5wpSgDEbJNuFaq8BVvmuPMuU78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0Pz1KkXeVOZpmmv53fikN8uHkAv0vm5qCZQdBJLH8EBPH4PbUx6JAfJsZZ4Gah0PO7Tyh9rPke7EfNNOEN46S4mVeCAOqO7o2ZExpaeibM8PvEMTV/tHbS4W/SaI4R9i8d0ZHm6WzhMvkRQUXpXitAFPxNGlB6ZWg5QF7mn31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U6cljwku; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U6cljwku"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1804152a91.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842951; x=1792447751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2s9EEi3szXRHiAOelghIEUtcnzaiEQuTsk+UXvm48k=;
        b=X1WMMZ56pFj7NF/bccTqaklB77wGy2bOH2ya5LrtnAuczyh5ruBP8pXFriX1PN2TTe
         aWLt/Lc88luf9jXXrIonvei8xsOTSvgkbuf5oaaroeXyUZkoVYVAkVCPRw1RsR8v72/z
         FaP8nKIBwxOa14WYI0hJcKNnNCbbitzyDM1DbK8oXnHMir0UZBA+BSEhD0K1hePYvCKh
         GfBDli3X8JarDHxskfYvsjD1QOWBDgVbIK1Vpx6/9OITQy5RO5GifEvK5iOCZ6zvmqCf
         2SW7FIvTJ8xS58Qk4R6wjYap3nVwVPIv6ij8pO3xb0HYQaSjyUAeniBszCCvNa9YiEgu
         TIQg==
X-Gm-Message-State: AFq9FYJS5fnTKqM8GPbQcFvsyX4ZxJvK9dBWmBt6c5bcmSxXRT/crE4I
	UaIxTOyJglRxC9QxryzeTGghYbNsySsPOUUFCI3BMc5WknO4V6tdWfF9TTrDK0Q8hHHh8NgRqmN
	7+0MHp+KRk54qJOYSZBK5XQ4t6gFTN7KXi4//GS9llAbJj0WaiWvDL1u4xnRHFJm0RU0BbSKEf7
	LHTqu1DX6exUxPo9wX30yzRc6FguUKK6auVd0m7UkailsD9FEyA9zlDdvHcGHqYtPsmRTjNoNow
	plp2LCRjQ0=
X-Gm-Gg: AYBFou0LS1zVhWtE6nROzY6QS+3aCPFUyLztKnBHMp1FW6018TKg7uxRPZXr0hfdQuh
	iP5qlTWxsT1AiA/78eV/RV7AdSWkAjmUKT6CS7u+Ridfn8OeFsinOR4oAxkzbdkTjv+ZDNF8LYJ
	DPdF8QolSIRppAiKZ6ghP9/4s1Ded5WtGt5y9oB/Rb40Il7c9pJuXzYOKECk+KYZn+XCpEJTVNY
	UKzBiQK8KMDNkHN2pyAy+Vy/bVTF8LhzCiAXiPKWALt/+Bpk8yHIfGSp4QT0zKhjsEoGQROVscq
	uhtHmNm4erWrSrIZknQON2oUZn5vbg26/atlrqvcTgBZyYI2uQ9GlNJL/R53xjOhAparEN+mhap
	aU710Zs0hzL/no4EpOLbCYuZY4laMuVfQTBO0TSrBte++1OwmxiZAndl1KvOaoT8ZLDZUhtPSof
	TOsJzanWWJW0QskV0T2QS3O6EiaGm73wb7QhZlQg==
X-Received: by 2002:a17:90a:ec8c:b0:3ab:24b2:9016 with SMTP id 98e67ed59e1d1-3ab3a9a8d8dmr10018469a91.25.1791842951136;
        Mon, 12 Oct 2026 15:09:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab39694701sm3054938a91.4.2026.10.12.15.09.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35a4d2e39acso5526398eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842949; x=1792447749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2s9EEi3szXRHiAOelghIEUtcnzaiEQuTsk+UXvm48k=;
        b=U6cljwku4nLvpeG90X/yci16uf1+gpQeiauv4xGcwkDzfMFPVogXWKwWPfIeOjFoc1
         C3Vq/oytRV/O+w6Ht12L12CCvRZGZFjaNL1CQtbG1AobTvR5qaBROCPG6xiSsUNj4q0W
         U0hJhNKApxOtqybpLZVno6OtlOp0h87rcJBqE=
X-Received: by 2002:a05:701b:450a:10b0:151:bbe4:b6ab with SMTP id a92af1059eb24-16a5ed3d9bcmr14310489c88.17.1791842949107;
        Mon, 12 Oct 2026 15:09:09 -0700 (PDT)
X-Received: by 2002:a05:701b:450a:10b0:151:bbe4:b6ab with SMTP id a92af1059eb24-16a5ed3d9bcmr14310450c88.17.1791842948315;
        Mon, 12 Oct 2026 15:09:08 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:07 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 3/7] bnxt_en: Refactor RSS table check logic
Date: Mon, 12 Oct 2026 15:08:23 -0700
Message-ID: <20261012220827.340998-4-michael.chan@broadcom.com>
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

We have logic to see if we need to reset the user configured RSS
table for the default RSS context if the RX rings have changed
in __bnxt_reserve_rings().  Refactor this code into a helper that
will be used by other callers later in the patch series.  There is
no change in behavior.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d23b40b0cb92..1c38e15fbe7e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8168,6 +8168,20 @@ static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
+/* Check to see if we need to reset the user configured RSS table
+ * (default RSS context) because of change in RX rings from
+ * old_rx to new_rx.
+ */
+static void bnxt_check_rss_tbl_lost(struct bnxt *bp, int old_rx, int new_rx)
+{
+	if (netif_is_rxfh_configured(bp->dev) &&
+	    (bnxt_get_nr_rss_ctxs(bp, old_rx) !=
+	     bnxt_get_nr_rss_ctxs(bp, new_rx) ||
+	     bnxt_get_max_rss_ring(bp) >= new_rx)) {
+		ethtool_rxfh_indir_lost(bp->dev);
+	}
+}
+
 static int bnxt_get_avail_msix(struct bnxt *bp, int num);
 
 static int __bnxt_reserve_rings(struct bnxt *bp)
@@ -8257,12 +8271,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (rx_rings != bp->rx_nr_rings) {
 		netdev_warn(bp->dev, "Able to reserve only %d out of %d requested RX rings\n",
 			    rx_rings, bp->rx_nr_rings);
-		if (netif_is_rxfh_configured(bp->dev) &&
-		    (bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) !=
-		     bnxt_get_nr_rss_ctxs(bp, rx_rings) ||
-		     bnxt_get_max_rss_ring(bp) >= rx_rings)) {
-			ethtool_rxfh_indir_lost(bp->dev);
-		}
+		bnxt_check_rss_tbl_lost(bp, bp->rx_nr_rings, rx_rings);
 	}
 	bp->rx_nr_rings = rx_rings;
 	bp->cp_nr_rings = hwr.cp;
-- 
2.51.0

