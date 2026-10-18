Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4830C630
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289331; cv=none; b=bOFT2rwnOUxr869T9uOcXFchstA+pArapN5lRdG8hbyJ3w/SJIE61DdHVN/S4b0BG+CElEN2ibw3tdlcJUm1d+v17fMVkpbUYYY6kObdbVBSHO5PC9pNZ/Q4JhXqO1s522YuDjkehJ9GZXcssHMD4qtoLgCwzr3X7rtgSL4KCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289331; c=relaxed/simple;
	bh=6yk6rSQ2xuCcPa8aOjqz85Jek3V1FUDJxgzFLY6FT1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CInuVd3TOaLKmsZTwyhnIX/Y1724pZsviptmsvZyk8ys95hX9Xhe1Cbt7skcUCbK2iCx+4NsQfJU6bYE091Wz/GXVyqvCYTgNBtx5V0bITXQzISfjTPBTgfs355cDVw2tsznqUDGllSaHSHYxfucUHK8RPD5QBrsNTaoUwqF9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PunsL07F; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PunsL07F"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5361e313e63so11223591cf.3
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 19:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289329; x=1792894129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZ0g9Te0u3jHEEDvVwqU4VmlgImgFGlZj72Jg2wM5+4=;
        b=PunsL07Fr0briGkYEPHDqObem6i+Uq794JwGRyICFpPoQrPu8DdWC4dqXxqcNn5mDW
         XEES1jpOPIUaA2DwsHHxqAwTAZniqphE+LCtASVsO+VUFvFSh7F+wXrHsh7McBq3mlAo
         XU5mfiGMEvmMn1pn/20a7hZsJ6aqflFvBDSNRIMroCSx8rx9xDADYnK0EXt+gzEsRS6J
         10Dwasu51xKCqpf/u8W2osl847MLecNRHmxWsad8vKEvcNhT9HFOa1Sc7YKpYRmJAV0r
         Kb9TO/18fZb5EjAfdsuvVjnnd3ep/bpCbqV3qk1kqHkVFhM9OBBr4LhbXKJYZMpgImsJ
         kc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289329; x=1792894129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZ0g9Te0u3jHEEDvVwqU4VmlgImgFGlZj72Jg2wM5+4=;
        b=IdroCHIAGenOvb0gFS9mzxbMu0OCa053898EK7kMIxZEqCQHMwvtoDOqb6eRSCCBz+
         4UU7XuWhMDO8KOVoOTcdKOpw2a6yPHvW3EydES0TEwTJErSNMzL7YM0sfWV2UvYYyYwQ
         Pndj7h3G7vCs3V8GQPH+XNtuenVJU0VlfAFJBexhFyFjBjAAG4MQr1/7iImCa+gw3e5b
         EqlOf8n9Lqj3swP0LEgQlbtSc8ioSLAx20mv8c9c2l9Ei07RtalDgRGtiRctbNji4Kik
         BcQNwQyQmaNlRNm37iLHBv76TxfpLULvB6ja79bBWk+5rRnaRmbB5GRJqsYEv61U6fpL
         48Zw==
X-Gm-Message-State: AFq9FYKgGF9oiwCRbxSyFIMp3ex/BVuedewZWKVoSC/HrdNYYdhDfhm4
	unTh0OIxmKbqgHRuClSltl8pKu4+OxADP8xwY47eFpNOkU24rW3orU1iufq6IzA=
X-Gm-Gg: AYBFou1buYz6+JP/z+3seCjIuDolCTGfu9YhGLrN84LYMOijPRY6xcPNcO6btT5jbod
	VE9elV4HNxsWm9BmtP3ZD2Bcqso87Szx2ChnUX+dbMaAnTpXleFkEVQHM5UMudrr+X8XLPBtK9l
	yTD8W7PeATrje00KmCJLyLNatwraPvFm192HeR0sWJSGV997f4lCKuosOcS4RQ91maoqWIhYz6y
	RbJna67fiTwKHyTEHWX13AzLC1oVq1PHlHw5ikADoEzsWpKCNkxBGc9CpqMTR2eOIH4x5X5kFHy
	IxNxUOPL3Y8OVZx05LtkENwCoAmj0/de2VYix6xa+v7UqY7D3gz+VsdUqdxwAPYm5MsTKQw4Z4S
	0cVPmOVZXn1Sf0IJUPToSqkQeb4/2SdiUc2zdQVKuh7Fswrif1jmdGxiBy6i782ECQQUuxFnY3t
	Kty5UZAE9ECrg0YGd5Uqxnzr7Y15YRRLZv+G75mL0C15hkvRHj7cOT9GaGU2QutVYoPnZt9HTjL
	H1YdLfRLu4D0i/R6oQa4/7vwcZziXlI6Br/NsFl93KrdbUPeGXCQex+4gCDZw4MAhQmFZ7XEk3b
	oC34vLhCe+I+sNyqjPI0jSehFxUx
X-Received: by 2002:a05:622a:1349:b0:536:3950:5d7d with SMTP id d75a77b69052e-53645faa64bmr63867181cf.16.1792289328931;
        Sat, 17 Oct 2026 19:08:48 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa68f8esm61731291cf.29.2026.10.17.19.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:08:47 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com,
	daniel.machon@microchip.com
Subject: [PATCH net v3 1/2] net: nixge: free IRQs before killing the DMA error tasklet
Date: Sat, 17 Oct 2026 22:08:39 -0400
Message-ID: <20261018020840.3851552-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018020840.3851552-1-mhun512@gmail.com>
References: <20261018020840.3851552-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX and RX IRQ handlers can schedule dma_err_tasklet. Killing the
tasklet before freeing the IRQs leaves a window for either handler to
schedule it again. The tasklet can then access descriptors and TX skb
state after nixge_stop() releases them.

Free both IRQs before tasklet_kill() so the IRQ handlers have finished
and cannot queue further error recovery when the tasklet is drained.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff..8697a76 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -927,11 +927,12 @@ static int nixge_stop(struct net_device *ndev)
 	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
 
-	tasklet_kill(&priv->dma_err_tasklet);
-
+	/* Remove both producers before draining the error tasklet. */
 	free_irq(priv->tx_irq, ndev);
 	free_irq(priv->rx_irq, ndev);
 
+	tasklet_kill(&priv->dma_err_tasklet);
+
 	nixge_hw_dma_bd_release(ndev);
 
 	return 0;
-- 
2.53.0

