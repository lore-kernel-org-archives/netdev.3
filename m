Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3263DC85B
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913787; cv=none; b=fOYbDdgPVQiGZPACMBXl0f1P/6dJWUPNwryet5L/wDoJ32B3YQOcxWf115hlplOWT/7oZ8qnevshCKhcLrrq+Xvm1U/Av0Ws8dLi206G01Iva6NJGBSpdcUKPcdsYbdDDlFNQ34IDJzhCDnOkSeWwCnySgh1G1jfhOAnkLvYGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913787; c=relaxed/simple;
	bh=Zv6/lKdm2tI3sp9/ByOrepg/RYpUpIYOqgCI6gpKBDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGAFTr7cbUrJs03YmhYXaH7mFQTfnGnPENPqC5y4q/ycKScjnu92XA0CpGYCQHNL023SMARtFTM8yMbBWcVABl4tGYCSbIfGaysuMp+oXKYkJ02FBKoiEfxGm4a/2aL8lTRdpkSvTjPkL7qXB/x4uhkGhYUr08+r/NaB04pOQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxTdSOrE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxTdSOrE"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47362928f65so503328f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785913784; x=1786518584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AB188XGB4sbY3JcvO+RtPjAq1fA2l4207oGcIEuttd0=;
        b=nxTdSOrE4Yw4wR0b0xAUW19TdwJYvfb278sOFTPV5ieO09L8iNooEmnFVBnZkpJTPJ
         dWQk89yhEZdq+FB24LBXy2ohACkDHYaFajAa01oqChCynIjIpZfyQJ8us/pDPgW6+G1t
         /o9JwtJ/2in7r7w8U2cFDRlBKxZhEsR0icVJoe3+MSarRtfz+4SrHZo4vNDMXhZixTT5
         9W8KxNNz2gnFqY0ddaBGnBOwynsiWO85MqVFgQPYlN+2CY4vad5L7VQBspFlrUkPHjlM
         7vWImym+xcHMumSweW9U0KF1SCoSSXNkxeO9vwTGMSvrDDe4zm2PxEjydjsagalGCswi
         BVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913784; x=1786518584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AB188XGB4sbY3JcvO+RtPjAq1fA2l4207oGcIEuttd0=;
        b=P7cNx9nU/3OdQwBscoJg9BF9Tj1i7zf85IdWlkhXjCurZON18ljKNqR0ChjJzivPM4
         HT7RGhZWhkgIiTWBphcf7ASP4imRix+c1kwUQ00y0nfbtTrNkXBuKyTYAD4ejhs9qP/L
         aKb/IdjdfQF+Nxs7g5n8GAaU6wu4LqD2VOFO92GrND+cC6sa6oBA4ocXPXr7h0/QacPx
         QAUqp6Whc5+Opwu4l8Pt+Xi9AmI+kQQXUNisjKFYKe0z8ezJqCBENaBniiWeGj54EJsM
         zaGl7D0Rv1PzUh2CTZhEZFXl52AUJHMOUGWNCiK1yBgGWaRctQ/iU+PNFKQfCLs7jnXK
         oDVA==
X-Gm-Message-State: AOJu0Ywp3rsM5Sq7h5SIj8JDmiqhAvDZ1CRExwJ4tSHgNbcjOgqZO727
	QSN6Sl63v29ryS7pBb0ctJSOyn2E4NzdIHNXDOF5OB1Ncbn08T+5l1OfvJZz4iuY
X-Gm-Gg: AR+sD12BHx2pEw0m5xbOyys9dca67RCCqFuIqEL+eCvh9IJfOKGMNJFTV3XfC/I+Ypv
	xo1FvWRhWv1bdYIOCDE9w2uL7I3mTvlyC2RQySggU6c2gLgOL1m/PSLT784kfrXN3uV4q9wRUQP
	Hos0F2MgZEMmOWAOrmPvCL8ymfPrGTDP+aUqVVOUZYMqLLzHwqGpFfYP/LPXFCj9BV7OiPIkuaJ
	0O9KbVQjoudZecIqrHAXrPkWmcuZs0QuEstzsqg61QAhbsC2SS91Y7iRArPFEsvNLfNVaLf8tWZ
	c278YACckh2Lhuyqrx57zglk1IPnWIe2tXMYVZytPGMiaszqjMIC5IeseqQOrv3E23qPCN6pUR4
	MNvyOhUACwyPiz/mnK0kiV5p9JC4wzMVt+t2fHnZC3JfRz+cVgP77M9kF5qy3cr8Wqcb3xbXwjl
	O1maCiZ9O35ihjZWkZ1YRWPIt1VaJR5b93gwxcuryvWikfyKZOMEcvIEzAXfi26GYtaQ==
X-Received: by 2002:a05:600c:138a:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-4994e714d8fmr46447075e9.6.1785913783962;
        Wed, 05 Aug 2026 00:09:43 -0700 (PDT)
Received: from fedora ([46.205.219.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e4c32e0sm35567225e9.0.2026.08.05.00.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:09:43 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org,
	win847@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH] net: airoha: npu: use coherent DMA for mailbox messages
Date: Wed,  5 Aug 2026 09:08:51 +0200
Message-ID: <20260805070851.2885888-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox
buffer") switched airoha_npu_send_msg() to DMA_BIDIRECTIONAL so
non-coherent CPUs invalidate caches before reading NPU GET responses.

On EN7581 + MT7996 that change regresses probe: the mailbox completes
successfully, but WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0 and
mt76 never binds NPU offload. Healthy boards report 0.1111.

Mailbox messages are tiny and already copied by the caller. Bounce
through dma_alloc_coherent() so the CPU observes the NPU-written
response without relying on streaming DMA direction.

Verified on Quantum Fiber W1700K (EN7581 + MT7996).

Fixes: 6f884eb87a79 ("net: airoha: Fix DMA direction for NPU mailbox buffer")
Assisted-by: Cursor:composer-2
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b679bed952de..d2f6c9c084b8 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -166,12 +166,21 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	u16 core = 0; /* FIXME */
 	u32 val, offset = core << 4;
 	dma_addr_t dma_addr;
+	void *dma_buf;
 	int ret;
 
-	dma_addr = dma_map_single(npu->dev, p, size, DMA_BIDIRECTIONAL);
-	ret = dma_mapping_error(npu->dev, dma_addr);
-	if (ret)
-		return ret;
+	/*
+	 * Mailbox payloads are small and bidirectional (CPU sets the
+	 * request, NPU writes the response). Streaming DMA_BIDIRECTIONAL
+	 * mapping regresses EN7581+MT7996: MBOX reports success but
+	 * WLAN_FUNC_GET_WAIT_NPU_VERSION still reads as 0.0. Use a
+	 * coherent bounce buffer so the CPU always sees the NPU response.
+	 */
+	dma_buf = dma_alloc_coherent(npu->dev, size, &dma_addr, GFP_ATOMIC);
+	if (!dma_buf)
+		return -ENOMEM;
+
+	memcpy(dma_buf, p, size);
 
 	spin_lock_bh(&npu->cores[core].lock);
 
@@ -191,7 +200,9 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 
 	spin_unlock_bh(&npu->cores[core].lock);
 
-	dma_unmap_single(npu->dev, dma_addr, size, DMA_BIDIRECTIONAL);
+	if (!ret)
+		memcpy(p, dma_buf, size);
+	dma_free_coherent(npu->dev, size, dma_buf, dma_addr);
 
 	return ret;
 }
-- 
2.55.0

