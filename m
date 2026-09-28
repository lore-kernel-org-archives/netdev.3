Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AA353A7E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569199; cv=none; b=iHPCKi4pP+GHnSyZJrP1meQ77ablkn8Bv46uE6PrnuIHsdPBTEjsymD2lK0mneTCQYGxJMOSh4MPGurzrxJ5HRmc+ZQ2SLzLeP/2aP9C1I2cCIgBvyoIXL5Q5Lz+uaWTWvFHHDSyqMy7B9MeEgwN/CjZ+6aD0l3C7j1ijFOCueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569199; c=relaxed/simple;
	bh=fb66B+Pb1XqclODuR5EHdj+45SRkYOaYfvmYDm8Pm4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bxpn6s4WY9HY6VvPTpyj1NXiY3M86BVGCHzRQLBSlA8sS8fiV+ZtPquYgjHVT8ckh8c+fdzm2MJ8vKjohk51A4l8ynbrXbujs8IYekRfImNCNq96WqcEikCCW5unnDhGyCAjr0S5CAfw/TgKP1Jmnf37x74/A7QB8d9iXvBeR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FN9EJQec; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FN9EJQec"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-8a74bce4692so2289027b3.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569196; x=1791173996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w1jkQ5lCnO/wYe3OtF81GgoxSz+pFCaT7NWyYcFjAjk=;
        b=oxEM90cAfjVmTcaxAowD75HFN2eLaWw2Avb/ErhQNf90bCGGc280zR8OYQ6+jeFVx5
         CLoYs5jtJIJUhJ5fNzV4SNeZjiTYs1dlL6t2CqEsXjXnyLDKSKeYM6g8fvFUBc+iX+Ez
         H9NjJm24y19lfK/A+/Efct07LdP99kmhEeXjKHCbUryW6VYeak8BtOjlRVGFIx+roet3
         tf3wsUv+EVJSc1Oe57YlsL8Ne7e11rFIKx17V7MudPduAQ/xyIp9youhB1gNIo10gt7W
         +AErpYOFp1U+pgmI+ElEQAQZt9Ntlt1c9QIQRrcB5iI+szrh7fJ81sUG4LXCRxSZA04N
         U6Kg==
X-Gm-Message-State: AFq9FYKXLLEDgwNvaRBmD42GPi0TR6wJPRIxkFrTzKuDPZNXCkaqVZ2J
	nElytR1yQw4sBp76ypM/dsbnuAXJSr6mALo5iYOPqQVcqAaTzaDtgY7OMBSXJEz4MnUrCgxQx3/
	AMxyp06/tj/spYMBitaPAj5rf/XuDmzeKB2E2/JVnvLLt9wcNBT+I2+KsZhxIPCn5kn4OWZusHe
	ezmLIl6tm5++auzUV2RIuz0Cc7eqlzTYUftEh91SlNb1JjnxtJNV3Hk0xE3rMZnfSQcJoAAwkts
	+L+60M7ADE=
X-Gm-Gg: AYBFou2HJap6cgk8/pLx5KZG0dYkSN0mK9I5iJEP7rvJWQktyCp5xFtnI3OMwE4UnJw
	bNNQUzywXzNN7Bb0cxw6hO9PxyODQ3L3ElY2uNmiCq7S1Xc4TdThA+yZitA7PZj2RfRhUPzNpQ4
	SA/nBfGyFqzhnq4Wq1NPj+XiPxPAaVRDXYdQ1sckk2cTBkZ00f3EEOBTUY8LWsq8UnKoAzbjWuH
	EZsUCRoGPaTopZXzwDD7HOJkTgFhFvu4+iNmErHKwxyAL38LJK0frkoVJ7V5yCejdArK6vTZbfj
	BRsT3t64pa1hJDrZ/+fopO9HYvKLJkzmp8kHXq1aWkDrK/wufGqclMwGiRNsIMcZwM0Lh84PB3g
	R3kMcDEkC9prTW+6OWWVfhPU0thq/Ssq4vKgd63lIjaioEuPjCybGeQhYQmF9pEiH14LeR2Xr1X
	BxiYDCDeE2s75GI2SW5IwcXHRhRPG8ojP8T/Y=
X-Received: by 2002:a05:690e:14c7:b0:674:1b32:69d4 with SMTP id 956f58d0204a3-6741b32a1c1mr2475644d50.19.1790569196489;
        Sun, 27 Sep 2026 21:19:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6740eef1c31sm1247810d50.10.2026.09.27.21.19.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:19:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30f1b904861so3901353eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569194; x=1791173994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1jkQ5lCnO/wYe3OtF81GgoxSz+pFCaT7NWyYcFjAjk=;
        b=FN9EJQec5aQOfbddjAS1P8PrzmwkzHV3zSEidxbt0tCC/27Aobt93L1wB/Wf4khyb6
         DQ9O1EFM1ENiV7hWy40QXvuYYWFk4LySobApydg7/30fLFZAd1Fze2DNi+Xj783Hhq7C
         8QzTXvOmUfTrcrb2FwohoJu+Uub19XAJtQJNc=
X-Received: by 2002:a05:701b:4344:b0:144:fc5b:2121 with SMTP id a92af1059eb24-146ce67fa31mr8595909c88.17.1790569194386;
        Sun, 27 Sep 2026 21:19:54 -0700 (PDT)
X-Received: by 2002:a05:701b:4344:b0:144:fc5b:2121 with SMTP id a92af1059eb24-146ce67fa31mr8595882c88.17.1790569193704;
        Sun, 27 Sep 2026 21:19:53 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:52 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to
Subject: [PATCH net v2 3/9] bnxt_en: Refactor RSS table check logic
Date: Sun, 27 Sep 2026 21:17:06 -0700
Message-ID: <20260928041712.3467803-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928041712.3467803-1-michael.chan@broadcom.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
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
index c34360f1e004..f83f4c8e994f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8169,6 +8169,20 @@ static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
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
@@ -8258,12 +8272,7 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
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

