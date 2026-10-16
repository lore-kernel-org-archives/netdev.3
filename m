Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B03B585D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133122; cv=none; b=SN2y4POHMN+46o/gJUBRuea4PGTZ8FBOU1g3W5bTceBKRaE7Whk0P7bp6O1RFrC/mPbxyb4RX8EMYSaZEuBuRFIV9guJq8eXM5Lklr34FGyOqsqH/uRIGbxa2h6V4Ddm9pHeiJcNmyTZWa4SUvfdDoOakURPa/N0v4kEKoKLg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133122; c=relaxed/simple;
	bh=WtyKC+YlinOH/xAK5X5lH3kaH3jsYVkUsRoHNw0NC9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNYU6sY+f8VzGMAmN8L4Pf3Vo80qdohBF0Dpa80JGnyIVQKCgl04zEDQCVmwm2MDdGLPy6j6aZPkrJbuIiAzDbgaRb4Wh7vqhNZKzyMCFVBRow4+E2jjIoBoSs7bE4PRKTQ/OeI8iGG8hNTz6lgFS1HPgAiv0mrBjOiUsjWZUCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BbHRAnaZ; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BbHRAnaZ"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1649145a91.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133119; x=1792737919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oUjoWLiQmRCDBeKYryuVFvGXjoGYVp0+qJlz7d5EoRE=;
        b=qAr5KrwWMVw1k+Mjmfy5VQTwx56MFRZN8TKkgdCXWImaXleaSIJww5IG9vyu2bJW2N
         7IrdSJDUMmORJv6MVQsAJPcotT8a9RiNa5XWYV3dYCla6eYgiPOM00aWOsVYxxvro9CS
         PW+hONezJ5doe5i6e3tFxddHFjY3o4OMLID2fIWtN7lzzAQkY0zoG+0wPx20RA4jukXu
         YJFEZmHxQSwYZrCvqnK78WLJojni28byUx5yGRYdq7OiPiEVjQ9b6Gme5FaJ2zG2Ov24
         lee7f1dp9KUfCCUhImhuXpaU2UjceMQ8/fkJSFjfU6Alkj9ym7oWDQSA8XHW2xm3OUTg
         RQ3Q==
X-Gm-Message-State: AFq9FYJMUw4FDKyovXI6nJ/zo8+cWPWkZNUSlSdEKNGzmqXVc+NU7+e2
	V6hPe8P4equ5nmUxYxa5WGZYu7McnZiZsJfCxOp4vGlFATcPuyOnICwvFW6diRST3L1D71cVhSL
	y96NX4cpEJqnwb0UuhrVgnzAJ0V3wfpcbXhuQ0T6+ye4W1zXxL9FI3jMku0bxF/CWoi9pRiz+TU
	kv+PbV8qui7qrK24GeR1FrmmVvdxBapbyAG8S5rIDnj5MedstQdWjG4CBHdJFVo6isuMojNCVpv
	eHge0md/6k=
X-Gm-Gg: AYBFou3Y/3CR4jqqsfC7foF3wj7cLkzGhU8ioL3Nea8NitSp+kWkGUr6Pa6oCH78LQA
	nQXGxiHJ3pjx3tL7MfbDQUKusB9vGUzxVLBFrQrT7S+TjWRT3L5cjtVKBp/GGYdERfIOQmngEvH
	MiViQKP3VXqFpz+8JfatV/x2XhAifePILRS+C70SLUifblvD4my9DdDtEE4dn7Uj3MmCTpFCCHY
	eO0fAYniCUdBc2iiLoMfFLPeTQflpth4k7w1sDSEmHQY+SnfPwqzUvNhxcCoG1MnfwwlONOK/tj
	zj9HPwEtKkL0DQhPdKmbb2/HvVnMdwTf9BaZNfY03dMc9Z18HzPdkL0IBa1CxSAdDAM9vpuJsBn
	prKMqiM+XMK8ukhdcMcd4BRHsBhVmoO0g1ZmTTdnYTWK4Pi9lDOBkbbXd8uT2GpfW8z0+1MFjp7
	SZn0UVIxsZ6TzGKyj+8TKx7eG+Z9T84MuN8MxKtQ==
X-Received: by 2002:a17:90b:1d4f:b0:3a8:699f:959d with SMTP id 98e67ed59e1d1-3ab3a955988mr18098180a91.31.1792133118852;
        Thu, 15 Oct 2026 23:45:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbe52f4cesm1282888a91.3.2026.10.15.23.45.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso2968817eec.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133117; x=1792737917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUjoWLiQmRCDBeKYryuVFvGXjoGYVp0+qJlz7d5EoRE=;
        b=BbHRAnaZNKUhmKGycW+BMPpwLkurBw8+1BodMVRScZTebiMv7GiGW/bfq+pKArI5ub
         w8mKIoYCPLdCSJroAmYUQ3kJBNLzsrkJFAp2BFIGRPt8mhL88A6oBAD2qYKUkKz+01nL
         HmoFxnpNKeHhRXAp1TyJydPVA3zxLTFgLoStw=
X-Received: by 2002:a05:701b:260c:b0:144:f85a:a188 with SMTP id a92af1059eb24-16a56ab4575mr25819329c88.2.1792133116798;
        Thu, 15 Oct 2026 23:45:16 -0700 (PDT)
X-Received: by 2002:a05:701b:260c:b0:144:f85a:a188 with SMTP id a92af1059eb24-16a56ab4575mr25819265c88.2.1792133115474;
        Thu, 15 Oct 2026 23:45:15 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:14 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 5/8] bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
Date: Thu, 15 Oct 2026 23:44:24 -0700
Message-ID: <20261016064427.496944-6-michael.chan@broadcom.com>
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
index 4cc6ffeb56f6..e5d2c65a6b6f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14116,10 +14116,11 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
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
@@ -14146,8 +14147,12 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
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
@@ -14170,7 +14175,7 @@ static int bnxt_set_features(struct net_device *dev, netdev_features_t features)
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

