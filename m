Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E53B440F
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133116; cv=none; b=CNoaKjH0+u2Lml7WZDKCc5LROwXkppiGFvux+isuj6X/3OcxmgCYB6X7nU/ObnGpNcBv/u2ncznVuoSh3JtaT/YfRCEKw3/5IFpCzZIOfBsUi1O7Et3XhTljwo/8F9Xqs6V4gB9ue8+TIAuLm+zmfzL1WDBoVnIFz30sX7LFozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133116; c=relaxed/simple;
	bh=tAQVrdsyyJJ1/VnlrCyQBVjCC3hfP/5vQzBoldMena8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6vqv57XxvR0taMYJUrRJsPHWCvJpQOZHe+qU3ylOTrJhFEPttIS5pVGZnDbta4xKIe4Fmbu20jOgONsYffOvZeZfbAq3Irtf/YqoCi2iNDWncTVOAb1T014hkFGCVY5q/zEi0TuEOKep6K7JN8KVNpG12cnLhd1TwR8680g6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=heEqN4Ye; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="heEqN4Ye"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2e8b20a899fso25504075ad.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133114; x=1792737914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SflNjtxf0PkggpWCmTLlCNVOS69GChOXUbWcOkeOVE=;
        b=Hde1Y5DnNZ81lKTESwnkWlr1vTEOFXzzXyHRtyodvzqExySlsy2CzioxwzPcYnOIKk
         MyTXjcQlE8budAin9gHJeoOVU9JEIWoYdbb3LOAozF9CO7Z/3Pf6G40GpHnQV2aCIOMf
         Ds+IdH9x7Cs55RAUsLSlo5w2sypWwLs7J2k5KXUxAWPJ8Efe4VQmyp3gTmLkLDO041ch
         ktyr/4dzYF74oWNKRsezVhCwJaMlBDZxX21uo2zy9yAGJZ92SJ0cJxlcS8gOEbC+87kw
         5TR76OTfxHht59m5lXZpvehrNcAty5E11jnIur9s8DT7FzPPi7V+7qyqRnNk9avnVC6t
         ZgUg==
X-Gm-Message-State: AFq9FYIDArivdHpemomSrhVjjpq9ool/kPumP4iNR/yEPwnXRvx8wile
	yqXFWIxUeD840owGx7wLtCg9G70QsOIVfXbSA5eZ0uriD8SFLolzy5PlCplqrrVdP3xK1XaV5VW
	/CQjd0hgmvsTITAAbiTgWL9cRGEMePUOgdpuAaFselJ3lt650pTLUcM8C1VZScgNeE82QGbqV++
	eawrbtUrRcNOMkjRZwbH1cj10/MRvV1ErSbk3IVasoxPALDi3nFQaDLC+liua+NAuR6URp4/DcW
	+4xP5kaZeA=
X-Gm-Gg: AYBFou0+CAgWLsyjnxsY6yRppWeTVeYyvbLDbAoxVSla5HmQoWe0R8iZW267SLKlesf
	/KNSL4GS8RWJbiporXmbN5Vd/6Wh15lS4YUAhWsaVvHedrgLnH6G5gOCMQxude27Y6bPKu8DWf7
	cyapliHamQgfkr5dXk0ddUyD0m/mhJsAPgDmhvd/eXKM7usovhrnRiEpLGT5uwc/A/i4R38tFuR
	QHqvv+IITLsDm3E+mrRHQ9gIRCSA0vGPdK7Vd+I0FLUWwIXZIKr3NUXpJY7JB4S7aq8QQ3BF+AW
	dlh4pckpVHR03KFUDWrXjl/ydMDwYY/9Xb/l3SlOrafNImLGhDOM/BcnZJW5kJ4C8VTvIrEE+e0
	QutnpVuBzd3SG8Z9PRqPVe24Se9NJq74M9Nazc1rDWshxBIrbP3ZLZlMMoOkeY/GdvS70L9KFvu
	4Nhtz3ZUtTRoS9HX1G4lcNtokA7YBmhFUSivVRWA==
X-Received: by 2002:a17:903:b0d:b0:2dd:b6e7:ac1b with SMTP id d9443c01a7336-2e84280afafmr203586635ad.2.1792133114341;
        Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e97e7fd1e0sm233835ad.51.2026.10.15.23.45.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-147be78cd56so23721853c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133112; x=1792737912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SflNjtxf0PkggpWCmTLlCNVOS69GChOXUbWcOkeOVE=;
        b=heEqN4Yeo7gDbTpmHpaWsT18aq3vbuHXw8+F1RYvACVoseneQEstelsFXJ8p213c6l
         oY5Rrh0oDsJkzjsRDyB3XZcKAkiLj4wNudK6MqZ95WvIJx7grR2IPmcmOibwJihZqydd
         VYsC6C6HnSj6xZaEUz/IcUt2km20619MR36lY=
X-Received: by 2002:a05:701b:4306:20b0:154:e9d2:d741 with SMTP id a92af1059eb24-16a6187e53bmr27472103c88.8.1792133111975;
        Thu, 15 Oct 2026 23:45:11 -0700 (PDT)
X-Received: by 2002:a05:701b:4306:20b0:154:e9d2:d741 with SMTP id a92af1059eb24-16a6187e53bmr27472070c88.8.1792133111297;
        Thu, 15 Oct 2026 23:45:11 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:10 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v4 3/8] bnxt_en: Refactor RSS table check logic
Date: Thu, 15 Oct 2026 23:44:22 -0700
Message-ID: <20261016064427.496944-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016064427.496944-1-michael.chan@broadcom.com>
References: <20261016064427.496944-1-michael.chan@broadcom.com>
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
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2eb9fa21eae0..0556a9b60791 100644
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

