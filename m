Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6B3644CA
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314253; cv=none; b=OyLV96qdCyM42gjZau/6oD0qMscVwFDSmsjEo2qKjn23dJCSxJEDrORPcPYT6WDS/aEZF4KGPcvWZwOPcZunRuOzEMhjxK9P7W9cA8z0E6snsj0vr5ZFBRBqUV/77y2cZGt8/zjGJsGzMF+VCC87BJIxk6TjddSjYbg6zDT75xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314253; c=relaxed/simple;
	bh=gccopKJo6AMNY10hGDCTCtkumpeREXXBiisLLwf1er4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjnDpzdYeR0Re9KXNdJUrE0ShwXwLRNYQxLrbewJ2LFz95Ek4oez9eCazpbcWFo1KQ3rns+Kt9L32G2IRUqJxDomepnqEFTWRGORedh5HcKxX+gkcLluiPRALB9ExI/O+oB2l3m51rKBikKfKCAyhS3lbwe/lxsojN2UpCIykDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=TTXXe5Xu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="TTXXe5Xu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d9201076b3so5671235ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 18:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314241; x=1788919041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wimfaoY+1kK1sxo3NPrBDMOhhGsT7Wm36ytAjDSTIU=;
        b=TTXXe5XuttfR+yczz59mBqblBnFMovbkhBNBNs2hUIzuscgXSpmhjGT+ulevxYL98Z
         MpDOIZf3SEURftEF98mP/Qy6Lw5steBzYsHOUV0iJD1MtYsmrrX7+eVERc8o6tMBXoIG
         T0E9GrLaFVED2X1JGEI5iMCe0sgZ/udgE6OIqYejugYS/ORNSlDav4EIl3pYwxbdy8JK
         sW+tgob18UM8zkfroNZLZieT/R+0LH2yY/iFGiMO4vrCRys6k8Gj1HPJ17Il5z0hb7Mo
         zviVK7aKWDK0htuxC0pVpd4M47+ZYWtaDGJ0Tr9xT8u1lmRpCEGWOcb8gu3iq19ayH5F
         RtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314241; x=1788919041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wimfaoY+1kK1sxo3NPrBDMOhhGsT7Wm36ytAjDSTIU=;
        b=kniRldCuO1PblCjnGVMQ9qjXdDKhUzUow2e7IfT3Yj/jGcu5KLXmR8BuqGp4QHNZbq
         W2hqdTy621dvPlnZbA/7KxekQS0FwAnh5YvnnHmiiW1R1DiRXCALn8KWZ5OZ87oFTAT6
         JGdxxf+NdKR8XPoKIzehdmep4dSHVyGuxdsN8cXsRatm/5g7T/XaN1buuV36PddNawYV
         WpCLVOBhC9PFN9ABH4oCsZ9GCPYsKXEadwvD/SBsjDWGsse7lOCkDoi65bherJFJV9qo
         Rqd5/Gt3qeReRMgvB/zqNgnX5H/OMurof5QLxrszjgWavN22XE56Av8Ba9DKxtLxk/hf
         9Jzw==
X-Gm-Message-State: AFuF++mtiRhSKAKV/3ty5NiLF2tELUcj1ts+Ap4Ub0F0OTUun1XZeSho
	/u1gV7aSJ/4rWufa+geLQVStjROYj31jElEbjjjn5DuZaEILy2BdkAGW/TbztyUaRA7tRCgxJ/6
	goTyfs8c=
X-Gm-Gg: AYBFou2YHDrU6bfUt8tR8cbRjSMnuItUFmMc6FFZtB9YHUnhtvTSX0K/ZdkAnRz+kBt
	RXqYNfSQ8ah+ldpVEEDf7+6AjPQH0XXJwsNgg9zZQjrgl30CRdVyBLKHyrwyziWxnk4n1lnPgor
	rAAfVd8rYwH+DS+w7jtb2hY22QQMywLj5Bqx8Y3A+kFKdotLyHvP2Fq61vEtiDhfcqn4d3hFcLT
	jvGriP+iZOtmaWl2CID5GqgYsQtRfz/NlJCdlEFDp/K8ooqlXAxojMejGHbblZbqWwLLkDEceCQ
	OuJCk5vdl//NWUua01Lxq4rZGkHKiBo+KRvwYaXwU/bmMYiGWtBOFRig3UUQBkA6ttnL90kQVXU
	82PIlY2tfyNbVD5N/c2UkTI1TSwyS3HGmBZEZO3VkUGuUAIPyw3by9baQbc8PnNqD1CwNheOiq2
	SDNLgUgUfnf7StpCaWTmrn4i2d2b8umeA6GZL8oxN1zNk3YXtcLrr8
X-Received: by 2002:a17:902:e544:b0:2d8:d4d1:313a with SMTP id d9443c01a7336-2daec77411emr18790655ad.17.1788314241319;
        Tue, 01 Sep 2026 18:57:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd488d18sm5198245ad.45.2026.09.01.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:20 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>,
	Eddie Wai <eddie.wai@broadcom.com>,
	Jeffrey Huang <huangjw@broadcom.com>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 5/6] bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
Date: Tue,  1 Sep 2026 18:56:48 -0700
Message-ID: <20260902015652.2421609-6-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_init_rx_rings() returns an error when bnxt_alloc_one_rx_ring()
fails, but bnxt_init_nic() discards that return value and calls
bnxt_init_chip(), which enables TPA.

If an allocation fails, this could leave rxr->rx_tpa[] partially zeroed
and TPA would be enabled over an array with zeroed entries. This would
lead to a zeroed DMA address being handed out if the agg_idx is
translated to a SW index at a zeroed entry.

Fix this by propagating the error out of bnxt_init_nic(). Both callers
already check its return value and unwind with bnxt_free_skbs() and
bnxt_free_mem(), which tolerate a partially initialized RX ring.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a8e5fdfcdf59..d2943de1b62a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11341,8 +11341,13 @@ static int bnxt_shutdown_nic(struct bnxt *bp, bool irq_re_init)
 
 static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 {
+	int rc;
+
 	bnxt_init_cp_rings(bp);
-	bnxt_init_rx_rings(bp);
+	rc = bnxt_init_rx_rings(bp);
+	if (rc)
+		return rc;
+
 	bnxt_init_tx_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
-- 
2.53.0-Meta

