Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530B3DAAD3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910500; cv=none; b=czK5HF7tWFaVCgYX1f5yr0k1Jt8SZO7uACTK9xC2J3Z1BqDpqypyqytP6zTz/3a/+WItSk76QK2hjhr5g1AIGb6I6JbHpa4er8+r4+IKZtzq4Dpu8Obv2/t6HBApVHGkdveMgsGxfs2llQERdT1siPUxRMlK5WIyGWcPlVqKOQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910500; c=relaxed/simple;
	bh=jz7VOXg8+vJgAswswMcmPiDtW9tfDCfp8I2K5/IiUTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aBAwnThsgPHo+Ppw1kpcQfPCN8DOnaLNtcTs7qFx4n9puST/Vn/SSnxu0ACCzotq1KW+CDsuzL5upGDA1J2RgY0Z9N2wnLhxVRAeoEPfjmWoJckgVD33FPin5576Oi9tNzCsF7y+EsDAlpOL1dG2YzuNno91aMRxlIYPyvOqanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qO/cR3UL; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qO/cR3UL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785910496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JvtmsW312t3lOHS9DioW1sd/M06pHI/YuQDEfr70LvI=;
	b=qO/cR3ULfuCUVX7iLrmf7Og1Vza/sBmm/CF2K8Vt0/9VCh/oXDwergyBU5nGpgmYDciGMY
	CcAbqcqSWV2gc5lcJ0fYYt9JLSoEsQuaDD0VnzUbCjWLojlS0Fq/L+pUcB4G5IItqzp2e6
	We917c2RoRe+8NHMwX8Q2cZZuEs24dw=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] net: mvneta_bm: fix gen_pool_free address for BPPI
Date: Wed,  5 Aug 2026 14:14:38 +0800
Message-Id: <20260805061438.955717-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

gen_pool_free() expects the virtual address returned by
gen_pool_dma_alloc(), not the physical address. Passing phys can miss
the chunk and trigger BUG() on remove or probe rollback.

Fixes: dc35a10f68d3 ("net: mvneta: bm: add support for hardware buffer management")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/marvell/mvneta_bm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 6bb380494919..2a114a69a0ab 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -389,7 +389,7 @@ static int mvneta_bm_get_sram(struct device_node *dn,
 
 static void mvneta_bm_put_sram(struct mvneta_bm *priv)
 {
-	gen_pool_free(priv->bppi_pool, priv->bppi_phys_addr,
+	gen_pool_free(priv->bppi_pool, (unsigned long)priv->bppi_virt_addr,
 		      MVNETA_BM_BPPI_SIZE);
 }
 
-- 
2.25.1

