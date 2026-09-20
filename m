Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19253DA5B3
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789886107; cv=none; b=qYPh+5Qq7VR+JglOTMvxK+++bxOuqLDbbqXsdB/tzx1cXN5zCDDsxrGEExN8WuOYlSO9Qj51+jq64qhmRiajcUETQGzsEkJucm0Ib3JI1CR9b7MBOWQ12UPPz1mMruz+KLc5K63S8SCdvwUTr7O6JOxx5fdqvka3k8m9dp4f59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789886107; c=relaxed/simple;
	bh=BkjCl9PTzmvibgyTAzSEgHagAdnS6n+z9kSRa9z/IJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ0hT3WuRI3F1Q5+Jh0ye9Lzp+Vnlk6t33/04jxgc5l//qnwwPGQbNb98NSQ7s1KkSLADFvpEP9ZkjxMqZsBi2gWyxfQMr59yv61/2CuFytzeTUExOWp9JUeNgjVcDMfo1hClTCuae+HpzpoxqPkAeP3fqjDe2aJ6119+wldx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4HWaiaH; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4HWaiaH"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86dd69a1b15so668117b3a.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789886104; x=1790490904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1mSNs6gpwDbZo1OHe4Pclodm2onA21KdKi2Jq9VQVaA=;
        b=Y4HWaiaHdhc8jyGzDCHbftM0vp1Eq2jjWDXJWgw6Gj2c0E2BA9S88ygsYF14DrZIy4
         ACZ8jlQjKDp2VFR0dR7Jy9jAIYwS7qEZk4YZbiWHi5Za+EJt110hZWt7R7Ucc0Pg/CV5
         VISeGOJmJ4qzVDjLVDPhZNQdhF5YkVH2CPoO+xTg6URDlOhlaaHc/aAO2SKHFQ9JWAV/
         163TEahcNmQeF76vlgxZ/XvJb1MzJueJqMjQ7FjIfqBFJs0pwmrmPggGImWLrj3UOEEY
         l3SdQoIMthJVVwY8iLho0EZ2JJ/OwgF8pNUY5u5zfjrNGIuP95GxoFq/Esok1qON6zPa
         b9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789886104; x=1790490904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1mSNs6gpwDbZo1OHe4Pclodm2onA21KdKi2Jq9VQVaA=;
        b=iaX6HNouUgIpIPRidAGJA5d7ezbJJ9pMpgfIwXptTtZFCB5qDMzLO6rEDchW2tJxzv
         iefSlvOk55cDDMDMd2PGekIE84dZkOvExtFeFoCsykFhmCPQIrHnQGH57KbH2Xn124sX
         juZz6/NylvNBbpCT3LAF7ZMc5gqPl01c5eXSYheMT6wdThSgxPWZS3rrAR5N1m8dBjCE
         D4g5jz16mh0+SfHLuU7rfKx23s2QVlMIGxEe9mSnuw6xv8QgD+5/BG08EY5pAEMgQ1wL
         VeuoW2C9HvEo3ildl02YeD7v+pPFLKFEvEsEhO+7Niidcoug2oHGTL63JNKCQXsvqtf9
         hgNA==
X-Gm-Message-State: AFuF++lBNhgMnlJJ5RufL/OaKAMEt7Bu7TLb9c+DFGuTR42o0pvMly4p
	xa6sMclnvj5iVNUmvoGUocOTuozIIYl6BLm+weutf7e1v7ez8qC/5gNj1ZqWY8IX6iJwRg==
X-Gm-Gg: AYBFou0wtoAwMV/ee26hU/O7yYGrwsaCv7gloxFZX7Y0DU+Z886qz72rhEzw62DnSuW
	GekH6Nm+MtAQ0EtPFsKm47cFkNK2bjgzeJLFbUorLcyzVmgzmZutkfQHmUdTA4I9zuRWqmun0GY
	ENrLlJgwdhZx+sUKfDxNktnEm5946kF2Bl5SwUU72Pwi93uDa8OlyKuv2U3FhqGEhp5KSFPohWV
	aGQZAB9aJTiBNO15QW5Ceqwv6oR+adYYVeh92Yhbh+8JNV26owLqM9/BSxK2IxIfZuU/cJAB7Gg
	mkp1Fd9Fz/uZu4drNQeSy2GPfR+QvzkN+cAsU82MHyusUQkXJ9ERcb6mk3IcPfQwlq+w07D6/D6
	ZKW4+59IzsbkKnXm2TnBY3zcd/AwXn2o+GRqMtQTya8ql8dfqCR7UEIAAH3UCw3hF9xJIzhcMyG
	DfZFaqO6XG/OoSKCvJ0Z4g1z3Zt5rCb0pHLKAgGIo5ffXuNIbSJ4JVfmwgdLUFhuINm9BU/AjuM
	dshP4eOrKSNZqSIIYP3ZFftlFStavu3Fe8=
X-Received: by 2002:a05:6a00:3a0d:b0:878:3704:e0ee with SMTP id d2e1a72fcca58-8783704f6efmr2520416b3a.20.1789886104157;
        Sat, 19 Sep 2026 23:35:04 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a8dfe20dsm1711604b3a.19.2026.09.19.23.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 23:35:03 -0700 (PDT)
From: Dongliang Qin <cccccccccccc777777@gmail.com>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Dongliang Qin <cccccccccccc777777@gmail.com>
Subject: [PATCH net] rds: ib: Clear the sg list when mapping an MR fails
Date: Sun, 20 Sep 2026 14:34:49 +0800
Message-ID: <20260920063449.1594203-1-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_ib_map_frmr() stores the caller's scatterlist in the MR before DMA
mapping and registration can fail. On failure, __rds_rdma_map() unpins
the pages and frees the scatterlist, but rds_ib_free_frmr() can still
return the MR to the pool with the stale pointer set.

This leaves the pool with a dangling scatterlist and can lead to local
privilege escalation. KASAN detects the resulting use-after-free when the
MR is later torn down:

BUG: KASAN: slab-use-after-free in __rds_ib_teardown_mr
Read of size 8

Call Trace:
 __rds_ib_teardown_mr
 rds_ib_unreg_frmr
 rds_ib_flush_mr_pool
 rds_ib_flush_mrs
 rds_free_mr
 rds_setsockopt

Clear the scatterlist fields before returning an error so the caller
retains sole ownership of the scatterlist and its pinned pages. Route a
zero-length DMA mapping through the same cleanup path, and skip unmap
when no mapping was created.

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Cc: stable@vger.kernel.org
Signed-off-by: Dongliang Qin <cccccccccccc777777@gmail.com>
---
 net/rds/ib_frmr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index bd8611911..fea387952 100644
--- a/net/rds/ib_frmr.c
+++ b/net/rds/ib_frmr.c
@@ -213,7 +213,8 @@ static int rds_ib_map_frmr(struct rds_ib_device *rds_ibdev,
 					 DMA_BIDIRECTIONAL);
 	if (unlikely(!ibmr->sg_dma_len)) {
 		pr_warn("RDS/IB: %s failed!\n", __func__);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unmap;
 	}
 
 	frmr->sg_byte_len = 0;
@@ -261,9 +262,13 @@ static int rds_ib_map_frmr(struct rds_ib_device *rds_ibdev,
 	return ret;
 
 out_unmap:
-	ib_dma_unmap_sg(rds_ibdev->dev, ibmr->sg, ibmr->sg_len,
-			DMA_BIDIRECTIONAL);
-	ibmr->sg_dma_len = 0;
+	if (ibmr->sg_dma_len) {
+		ib_dma_unmap_sg(rds_ibdev->dev, ibmr->sg, ibmr->sg_len,
+				DMA_BIDIRECTIONAL);
+		ibmr->sg_dma_len = 0;
+	}
+	ibmr->sg = NULL;
+	ibmr->sg_len = 0;
 	return ret;
 }
 
-- 
2.43.0

