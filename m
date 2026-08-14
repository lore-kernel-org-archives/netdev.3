Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7132143D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670143; cv=none; b=W2lns4b/oUoHnXgU4sBSSr7idiu4BJ9TLlObuENdOuZnMupmKvETRPoWjGl72hXMvuSYp0s7xhb6Fi4M6xPVwKhAGIo/JKkBMqFoHItHXur3pXOql5HCuuTL/U/djpv0RKitbPGHN4TYIBLlEVrPMe9d1UXCcta3ft0GWiAqADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670143; c=relaxed/simple;
	bh=SXUPdxPTDZc4HnKD0Zk9Z6mqUhdu0czMIdY86JUcqHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjnk8czADbh+RZf7Z9/Ae0g/6iR4Vz077jQfIPNQUudzubcM79daEzDrx2lSLCjRcdyn+FPym65LZebd3VbnXF+PlbuCl7etLa4WxqDQ/aRCMC4au7DpKzYNe/KCTr5u81XBwSVYaoThNCjdpRwAOGmFsUZv3k2dWpkKRxQ7iMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GnMCr6d5; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GnMCr6d5"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so482930b3a.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670141; x=1787274941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJ/IoKEgFFx8EFbs+Y6vP+6q0YJIwuDeB3WzhyOt9jU=;
        b=I6zhedYmd8mV2Z1pdYD1rlbIXJQ7v5bCeonS/wD6jBCaqWQBQlCfVUqAhqhaOroxhb
         pHkenqmHeh+qOVHxhbDhlZYS/1mvCmGY4moP4cIP0XSFoJQLMGCaym84BCvdBwEVfk7m
         tURWxmga2T4FaCGG3pch9c8CQnDi/mZqIVEnYqlkxYxCBuj1lzr3OrIESxjUgnDJtrpK
         S0kyIJdZs2V8fLEg/n/QJvhQMRMLmFVwckGdf/1f/FopKCe3tDVj6+Yz3WN/LTlxFobo
         mpN6wSdhP5hslxspUTE59PoIIN04IxPnp96/mGToXmSOGEuFrnU2iYxo/Em1Gf4NdbGM
         QWvA==
X-Gm-Message-State: AOJu0YyRfGg5pf9pBlGnJQs863GcDFlLxkP1Zow9MSYVkZQVY3cXB18K
	KErVYHfwZvBtShSfle/wdxHKXIqZ395ZjYL6ZBqpsYj2R04LCWMxBD4NEhncjkWIHFePBg4Yiur
	40j8vnGBKJDwsIf3Rv7FtZe94kQ669Kwm8PUIPufW82zsuEWLXlDQl3Z/HetD2ULOW8CrdOM06e
	889vDa72ciqIpHMCothHgNJ3ZqrEXZClMOPosV1fm7GbqdgZmeOgiN4GfGm2xfl8lh/o9V0iSe5
	liVjn1vNA==
X-Gm-Gg: AR+sD120yhw2iMoc87cr/NCUKXQ7FC/mfR1l6d2wJXYQLe9Rd33yh1cqp+o6dtuXk/7
	CEJR9vjM2ryXaebnfFITkmEbVNIcn0bPmnBfL7Ti4Xxd8ZddwSkroCVJblb+/86jtmxSQIOn4So
	pJofpcQW0HWNvHt7c+1dt7i0VrYWBucA81XMANrlpPkzDMgSgvJv5wXYWu/P29jQMnGn06PKjPB
	77Uw5XD2P/qhaP+udrP1seRni2q+SZ+da8euZYtCOVWFJSkg6rTtS01JUC3vIRi/AzJ/0AxhMX2
	AC9FAiuXeo1sImDHGRi3VabWRKdgeiE4e70CaOnYkMefIQGSyQwsraIQwyN3SnS+6St8TBHgWv6
	GftDnxRlcH62SHI3WJQZifniK53aJyd8gvhELQVILTSwbOjfe9zuK/ZLFmp20Qn4sRF44VUdVTb
	KAvx52ED1aqVwjC5bHr2CpHWz9WkMddNY=
X-Received: by 2002:a05:6a00:14cd:b0:84e:1a9d:d879 with SMTP id d2e1a72fcca58-84fde32a11emr2072149b3a.28.1786670140842;
        Thu, 13 Aug 2026 18:15:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbef6edd16dsm786806a12.9.2026.08.13.18.15.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so618875a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670139; x=1787274939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJ/IoKEgFFx8EFbs+Y6vP+6q0YJIwuDeB3WzhyOt9jU=;
        b=GnMCr6d5Cr4y0+vmZxODNOvmLU08HJa5zYR/jx0/X8QPifLuKPNs5p8em6Zg1/Miys
         6IhReD4oTibvM3eTBVUIu70cJRsea3cX96qIjf9JNF9+CIrIgZrcg5mdqMpKzxX/fhUY
         32so2Tv3+p4zidgYtpjsJp71w8pIMRKWTD3vY=
X-Received: by 2002:a05:6a21:3389:b0:3c4:36ef:3dc9 with SMTP id adf61e73a8af0-3cc71d1e1d5mr2029207637.17.1786670139161;
        Thu, 13 Aug 2026 18:15:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:3389:b0:3c4:36ef:3dc9 with SMTP id adf61e73a8af0-3cc71d1e1d5mr2029158637.17.1786670138711;
        Thu, 13 Aug 2026 18:15:38 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:15:38 -0700 (PDT)
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
Subject: [PATCH net-next 11/11] bnge: add cpu_rmap support for IRQ affinity
Date: Fri, 14 Aug 2026 06:44:35 +0530
Message-ID: <20260814011435.194631-12-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When CONFIG_RFS_ACCEL is enabled, allocate and populate a cpu_rmap
for the RX IRQ vectors so that the kernel's aRFS infrastructure can
correctly map flows to the RX queues serviced by the nearest CPU.
This ensures that NTUPLE rules created by the kernel steer packets
to the optimal queue based on CPU/IRQ affinity.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index fc752fe879b6..48de88924a7f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -18,6 +18,7 @@
 #include <net/ip.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
+#include <linux/cpu_rmap.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -2432,10 +2433,23 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
 	struct bnge_dev *bd = bn->bd;
+	int rc;
 
 	bnge_setup_msix(bn);
 
-	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	rc = netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	if (rc)
+		return rc;
+
+#ifdef CONFIG_RFS_ACCEL
+	if (bn->priv_flags & BNGE_NET_EN_NTUPLE) {
+		dev->rx_cpu_rmap = alloc_irq_cpu_rmap(bd->rx_nr_rings);
+		if (!dev->rx_cpu_rmap)
+			return -ENOMEM;
+	}
+#endif
+
+	return rc;
 }
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
@@ -2451,6 +2465,11 @@ static void bnge_free_irq(struct bnge_net *bn)
 	struct bnge_irq *irq;
 	int i;
 
+#ifdef CONFIG_RFS_ACCEL
+	free_irq_cpu_rmap(bn->netdev->rx_cpu_rmap);
+	bn->netdev->rx_cpu_rmap = NULL;
+#endif
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 
@@ -2470,6 +2489,7 @@ static void bnge_free_irq(struct bnge_net *bn)
 
 static int bnge_request_irq(struct bnge_net *bn)
 {
+	struct cpu_rmap *rmap = NULL;
 	struct bnge_dev *bd = bn->bd;
 	int i, rc;
 
@@ -2478,10 +2498,23 @@ static int bnge_request_irq(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
 		return rc;
 	}
+
+#ifdef CONFIG_RFS_ACCEL
+	rmap = bn->netdev->rx_cpu_rmap;
+#endif
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
 
+		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
+		    rmap && bn->bnapi[i]->rx_ring) {
+			rc = irq_cpu_rmap_add(rmap, irq->vector);
+			if (rc)
+				netdev_warn(bn->netdev,
+					    "failed adding irq rmap for ring %d\n", i);
+		}
+
 		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
 				 bn->bnapi[i]);
 		if (rc)
-- 
2.47.1

