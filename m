Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CB47B420
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519145; cv=none; b=E/5idAf73NdpBzoOT8+54KydeAlmP732l6PS2Yq8FVv2ND/1el1v0DVfBZN4HypftGQyHCo+6NRofrYCfjTfa6t+8g5sQAHYr8CwpJdqzI8VM4LHKFgef7eUERsUWWSc3x2DKEA78xHi8dDjrYIvXBkbVf2o5dQKdTiiYfegV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519145; c=relaxed/simple;
	bh=NCEZsl84HHiKcZvDUyy2UoV9CL6yoj9KYOuoXiClFsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDYnJxeWPCHDfzykPZfQu+9jAD1sR/de+edaQszkz98hLnoaKAYwqTlDY8v4jKznBKUhplMqP9WGIt6xoRW2QtOJxQqSWPDyq2a+LJd/PnP7ZITVTU04BZqZsTAUZTY630ALwFE9Sw3F7AerQRCHxjXaf3At8CVdqfOu/jocOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EHLe9DdO; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EHLe9DdO"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so882559e0c.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519142; x=1789123942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MGbG+t89gZz/Gg0XOe1OiNev2BX7ANIyZVE4l7ZKwg=;
        b=fssRjpR/mJl+kRxWuZ/Uw1VvopTwlqojKoEuwLHolxfEH/dAo5ubRtKXhbHkMIsusA
         lHQ2fysuRoGIE3RfvO2qRsdk7cjby0QsmJPdV/wrkWTy7av4xav7f/A3peOIy8AfAFaY
         mna64T3VNuxWzWjUqHmQRnNuHi7yNxZrhYFgfsm+yz5QRnbBbV3th2IQjcxr+q8HT7RV
         JdlPTyugfqoG9pdixurh9FGL6DB7ksktzZx36sIlJHtAWn7dQRb5f4RmRMxsTOduItOu
         6fzD/eqqhpRk4g+IrOEySuRNTsFQXGAetY43EZkIsYBKrd8YMo5s9nfiBzcVbyUX+k3G
         RzQg==
X-Gm-Message-State: AFuF++nyT6RWyFaTRk9jUuLc1l2W0rmhssC8NTmkDNKIPPaXZ1tX4ib7
	CRD+vQcDebBvJTCQLHewN5aSjHnZmyOovuIQkuk2S9u6PWUakHS5ZvbOjA3xtJWpXdDbxk0T+5U
	ckLCCAndehLW8jbG3NsLSUimekEv+CeHc1ApdB4Kg5YoTp5dFa4HdeDUhOJaa59hLa5bYQc7yh4
	0ZzJmSG+qqW/ntWTxgcqVyCr34Jfb2PwCshzlaXy58XqTYVM0pbK4sL0gMSCb9L2KMkr3EV57rU
	7cRrf+rHt9R
X-Gm-Gg: AYBFou3fuJcqDkKT6n20yB7jxIDfmSVp11XoRVWq1OzhTXZfzYuOcTWyL8hAKnZEjF0
	cSjAbMWwgti9iGIQvQHfoM5sZ1o6skKhOQeOdVeyvpM50JvNQ4lnzIgS+JTbEnQolTMRgVixMYt
	1UpHYnRxlUO6TpjROR4GzMp1a80/DighVA5vCH6Fb4ymXz0YZfa+LYQ/1wcQePaoR7sWzgxztcG
	ixDHTd6f5zlA/2AyLDtpb/VuYKvYsCVLVLzc5e9jqFk/pIiKDBe6/GiXdNrH1+QNdyi/0eECztB
	PNGB95DKnKpbJNhqWkX6EIv/2S0AYRqQpPGfiSQdrxeDrG/gRCzxF/NBAtlTIHYAYNDoDUeD8ag
	VBnBGeg9oPd7hywj4Gu875l3KpX3d70KnslXjPrNUeLfeTdQjfFERcbaRLixpEAgVczoINWHcBv
	JSJCQ+wrI3Lh/0Uyjn9e+M90d40PazTCd1ZEKe
X-Received: by 2002:a05:6122:3a0a:b0:5c7:9947:5ceb with SMTP id 71dfb90a1353d-5c7ed3796d6mr2470085e0c.0.1788519142112;
        Fri, 04 Sep 2026 03:52:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c7ebf6adbdsm1104377e0c.0.2026.09.04.03.52.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 03:52:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so1380020a91.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788519140; x=1789123940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MGbG+t89gZz/Gg0XOe1OiNev2BX7ANIyZVE4l7ZKwg=;
        b=EHLe9DdOmjnIuG515OuVErJVuRjQ4M+KgMJJpKv6/FlAz0yrQReTvOlyNtxN6amB0g
         tZvP9sJXALKFS78GBRZ9nmKkKkovSvH0CP+361wUbdKD/byGyJoOQDRa8NAw//6GV5Hi
         4Mi+C1EFaGnKlOkzphlb9RFbD5dthZLfSpqus=
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr8637708a91.16.1788519140374;
        Fri, 04 Sep 2026 03:52:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-39b261d0d83mr8637631a91.16.1788519139909;
        Fri, 04 Sep 2026 03:52:19 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d0asm6171170eec.8.2026.09.04.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:52:19 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Sachin Holla <sachin.holla@broadcom.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH 03/15] bnge: reserve TX/completion rings for the RoCE MPC channel
Date: Fri,  4 Sep 2026 03:43:11 -0700
Message-ID: <20260904104328.763768-4-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260904104328.763768-1-siva.kallam@broadcom.com>
References: <20260904104328.763768-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sachin Holla <sachin.holla@broadcom.com>

When RoCE is enabled, the bng_re driver allocates its own TX/CQ rings
for the MPC control channel out of the same per-function FW ring pool.
Enhanced bnge_reserve_rings() to account for this extra ring count to
avoid pool overflow while allocating netdev rings.

Signed-off-by: Sachin Holla <sachin.holla@broadcom.com>
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
index 4711dd4945ff..9dfb22b7c7c7 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.c
@@ -110,9 +110,24 @@ static u16 bnge_nqs_demand(struct bnge_dev *bd)
 	return bd->nq_nr_rings + bnge_aux_get_msix(bd);
 }
 
+static u16 bnge_tx_rings_demand(struct bnge_dev *bd)
+{
+	u16 tx_rings = bd->tx_nr_rings;
+
+	if (bnge_is_roce_en(bd))
+		tx_rings += 1; /* For MPC TX ring */
+
+	return tx_rings;
+}
+
 static u16 bnge_cprs_demand(struct bnge_dev *bd)
 {
-	return bd->tx_nr_rings + bd->rx_nr_rings;
+	u16 cprs = bd->tx_nr_rings + bd->rx_nr_rings;
+
+	if (bnge_is_roce_en(bd))
+		cprs += 1; /* For MPC CQ ring */
+
+	return cprs;
 }
 
 static u16 bnge_get_avail_msix(struct bnge_dev *bd, int num)
@@ -250,7 +265,7 @@ static bool bnge_need_reserve_rings(struct bnge_dev *bd)
 	u16 nqs = bnge_nqs_demand(bd);
 	u16 vnic;
 
-	if (hw_resc->resv_tx_rings != bd->tx_nr_rings)
+	if (hw_resc->resv_tx_rings != bnge_tx_rings_demand(bd))
 		return true;
 
 	vnic = bnge_get_total_vnics(bd, rx);
@@ -275,6 +290,7 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	u16 nq = bd->nq_nr_rings;
 	u16 aux_msix = 0;
 	bool sh = false;
+	u16 tx_demand;
 	u16 tx_cp;
 	int rc;
 
@@ -293,11 +309,12 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 		hwr.nq = bnge_nqs_demand(bd);
 	}
 
-	hwr.tx = bd->tx_nr_rings;
+	tx_demand = bnge_tx_rings_demand(bd);
+	hwr.tx = tx_demand;
 	hwr.rx = bd->rx_nr_rings;
 	if (bd->flags & BNGE_EN_SHARED_CHNL)
 		sh = true;
-	hwr.cmpl = hwr.rx + hwr.tx;
+	hwr.cmpl = bnge_cprs_demand(bd);
 
 	hwr.vnic = bnge_get_total_vnics(bd, hwr.rx);
 
@@ -327,6 +344,13 @@ int bnge_reserve_rings(struct bnge_dev *bd)
 	if (hwr.stat > bnge_aux_get_stat_ctxs(bd))
 		hwr.stat -= bnge_aux_get_stat_ctxs(bd);
 	hwr.nq = min_t(u16, hwr.nq, hwr.stat);
+	/* Drop MPC TX ring from L2 TX ring count; it is owned by RoCE driver */
+	if (bnge_is_roce_en(bd)) {
+		if (hwr.tx >= tx_demand)
+			hwr.tx -= 1;
+		else
+			return -ENOMEM;
+	}
 
 	/* Adjust the rings */
 	rc = bnge_adjust_rings(bd, &rx_rings, &hwr.tx, hwr.nq, sh);
-- 
2.43.5

