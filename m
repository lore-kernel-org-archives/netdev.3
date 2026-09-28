Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A7353A7E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569202; cv=none; b=StcSqfcOyAI3F5IA5K4N20sljdOj1oMDZ3DPrTVRDCdQv6SOB7heHbqRvAHVqfYV5WS+/su8BNSNUNuvI+d2B5jFC82zhfzf6fAC/ysJhTw93fmKGIUe24EXs8DQbE+EP0ihu+VZfCyQ/48K0GVB/tDbuvGklukuHJNTc3JvPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569202; c=relaxed/simple;
	bh=CipVWgwTorTJivtuz8caJZ6huTVxK3MMgoeAy0mE1j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+c4DiisJNyr825CxS4vM74LqONG5nMxCZx8btebZS0BAlOzkdQhqOU3gd4n10pw2RqMKQxmIAzjTHNfQNzpenS4zUlcBgnYlpnVIDZXdOftuft47aDh6hIqRPaR12hEsFGzEDIxIm/8CGaeXS4lFjiKgaFwrVdL8NfACSJxm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eFkPqKbv; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eFkPqKbv"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5ce65316337so594801e0c.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569199; x=1791173999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9JkWSYti/zNdKPw8C7SYXGmJlunLqfk8puwe0HKmHU=;
        b=SmTQ84J4Abz2pue1wzOl4wuG7Fy6i/brhhcflBQLsBpihMsSY8wnlf2ffLckdDWIAY
         A5dSi6eHrDVcIoKXcGR56kct/8B6sYEhMSWpzR0eo4HtSgN0fqcnox8zTR/Oj8ly48Ea
         xd+Rt70ojyiIvFw0Gmqzh1EaEOm+WDGNQ3skGZOhXEzePjJkF00vMv+qXHYy6cCXxI8+
         vjkPuaU/Yn52ghHR0Wo2MBc2Bw3/WEIoJe7Pb0MOaP1HOEGUXILvak4gSPPwi63E7Aez
         C6U3vDChcg+X2IZz/YipCWZaXgZCW5Kp1MZMSSChwGcDK+JKbTe6kPKQYAAClfhvuQpk
         8GmA==
X-Gm-Message-State: AFq9FYIp1vxwVCbUlMC6Db8uHf9p6MlrM6/Ydunv7ZBuhfpu2W+mIn9A
	vvshNbFGSovvnE04M0VbcBUT0eqqsg5LqeJsklBMYCpSt0RwkYt7uC5/QKKIvV0M5O+sDiG9MrL
	En21jDZ+xsF5D9uMCfM/ky1344lmZGNn+qoGvP97MY8HjDq7ROag64uAMbAp1gzR8mmEBf5T6fb
	KjltKSYrwUpFdoLqaMPCRv4+vdjvEDjph3HrWom26Z7K9RVJMEsUoZVgTNZ7JxQG9ceVC2VF24s
	EJ99POhsLY=
X-Gm-Gg: AYBFou1sYeenHnMikPXnHEaXYUYjcTaSMRfe4LTJWElPg+jVLkmgP2yvhWrGD4dMlLg
	jaG5ar/WFI8ZugQ8lSCr23b73Xr2EMeocWc2hZXZjby7J5OFEt6F0W0U9wWowYoCfTGNnpmE5UR
	mX8vboLGdfmGICZAf2+OvyjecM9hwyY1kZAqAhPyUyTWNVLVQ87akoL2AFKRx2OGQg9qXL8URT7
	bEqqLXcm2CNRT1euFt9Aw+dTqKi6AOpBO5AtZFOvZvsE/rv1R+W/WwmH9FW2d1WqJ82lMUZifLl
	i2ixuRg3biMBvhVB8iuXpE6c0m2qnCJI/1fDMPCGbNPFFvVnuQE+OobjgOPOrj6mCB5J9J8HG9w
	GzkEmzwPHNcxwopIHC7Jikv47HxDhTMwEB241pbgf0yxFe12oj+GtAeI2w1ttIF0LzIaSZy2ROp
	8A/3JIr3KMuQY0k8ueqFFDcbLQE1w8zGGqexr+0g==
X-Received: by 2002:a05:6122:553:b0:5cf:a94c:ca61 with SMTP id 71dfb90a1353d-5cfa94ccd6emr831597e0c.7.1790569199302;
        Sun, 27 Sep 2026 21:19:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5cde2c05cd4sm1389382e0c.2.2026.09.27.21.19.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:19:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso538763c88.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569198; x=1791173998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9JkWSYti/zNdKPw8C7SYXGmJlunLqfk8puwe0HKmHU=;
        b=eFkPqKbv+CWAEgZvmxdimSF2dB4M/B3xVJlGiyIWTvgK3FFonQHIaG4OgxCQ2EBHGC
         2VgMQLIhEZtFhwfn/+i7IyHSRk98XLGERX85IqKibrAWwntENCXXlVnPiKe1JiCx3aYz
         PmIOkV+Bw+HvEEcDZjX9D439e2Gfok1MXKdCk=
X-Received: by 2002:a05:7022:3704:b0:143:8865:cc7 with SMTP id a92af1059eb24-146ceb548b1mr7914896c88.21.1790569198066;
        Sun, 27 Sep 2026 21:19:58 -0700 (PDT)
X-Received: by 2002:a05:7022:3704:b0:143:8865:cc7 with SMTP id a92af1059eb24-146ceb548b1mr7914854c88.21.1790569197371;
        Sun, 27 Sep 2026 21:19:57 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:56 -0700 (PDT)
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
Subject: [PATCH net v2 5/9] bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
Date: Sun, 27 Sep 2026 21:17:08 -0700
Message-ID: <20260928041712.3467803-6-michael.chan@broadcom.com>
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
index aa40d5fd05da..bf902da945cb 100644
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

