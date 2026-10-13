Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E0552954
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924337; cv=none; b=umRrQycqhKZAVgQ6Q7WkvtViLO6qAY7fCO4sFbnqa/j8AOgm5gnYAugpYeB0E5aPPpe2DiiukqUQf8Z7MxUpxomI4NACV6hcOvQfn4jJR6Kqotm8pOLNjQojtMPugmiGmHeoD4GmkSnrnU1dUpQ/cSEQx5JQ712Uyv+NVrvlCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924337; c=relaxed/simple;
	bh=RbKEQ9Ao6sfM8uo8Xav6MW10A4+TnfLMYt6FY1stsN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stVMHcZArEhrU7Fl5lxBanDjOWHc4Od5uQrmFdOlKtjLrOvHhVaHDz+Cj8MSgUwwhJe66X8AjmNZ+dyAXv8hZRn5ZrAQ/HjWhrKgGZaFA+c7b4poGPUY14GPni6Ihl2//Qmu18+e7fJBokDvzV1NTO4UOfZB7BPQ+QkIOTgl13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fiAR+DyT; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fiAR+DyT"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2e608cd460eso18213735ad.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924335; x=1792529135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fn6fAIq7HU354S7iJBpqt1EqT6IYIhNvzY1GRRTqbFI=;
        b=Km/crlpCTJMht8hjoEfk/iB3g2mnvBu1AryELXowmcY12qc66Wz6gMzgfrnBzq2YeL
         GYh4dHseINO056CxRgye/k8STxcifNaZxBwlUJjWfqos2lRMie0mdGI7BuXatZZPN2zj
         EW89BtySaAjgkvMukL1WKCbeFMDKyfi+2dM0Y0pKrl8X4VbckKSmhfu5EeBLc1UzyW6Q
         9valSXm05JNV88kkQ6ELsoj2DPW9DIBEKKUh/NlAsUFz6JdHARhB2YoL3Qi4sGIvCd8k
         pEC6/1jIzuNFxN4DijoO/PHhnRCXI+qa/sKYN5ck5gJHqg11VxV3TL3Wau58BJtA5AHR
         Sp1A==
X-Gm-Message-State: AFq9FYLBenRE46bqz8gbh8xkKaO3aceR3bAJhcagDf12mXoLEvPPNgEV
	eM/qVfvijPe/zy4iLll4a5/0ls2IJmkoKcI3JVG+hJcC6UwfChnMYo4vAtrGrCH5EW+Jvem59Gd
	B1KdVGY1oEwTeZ/ZbAmUBtfFlatco7pUzmPcgCaFTUHsX94EXoZEsYXKeqw1eov4w+hYajDMyz0
	jBOTSCzDIkAL/20vmIR2r4nqXQQ1R/OOTX7P0ZTXCqFLW4pvGmyk3Pie6ODNFyeY4WazM6UxV2K
	43h8b7OQtko2G+k
X-Gm-Gg: AYBFou2pCwurT3s881NhCQwNVzUwJGROcveWlBPmVI6CblXiH0z8e9LX7f2zrImWAHV
	YjyWEeH5GmodAIp88eIcoZGzFN8luhpooljwXSLXhMOzEdiHh2942qt1kQ7CcPyow2Fqoxk6Eh3
	Q9tEy3mJGNb32ILStIyzEvFQNkgeQ4zrmYmCMz+k0Yw4vEh0VMnkIopxECFCSGnlRqNlIytEh2z
	TQyZIQL6JHpgNFolCGitHa3B2Cmk8roAXPkCEIe373EW2aQWVf4ZtLCor53n6PM9xSHkWBpZUYU
	Wc1bC4Ll8QRPh/9819YOR47jL3404KuUPW89/ki6Vmb62spDgH+SSwYGkzxHn8USS2aUL2unQQ+
	12xngCSwuJfgYHbiDFv3iODVfLoh1dTPVadMVO3+u4jF/59yvZHUWDMtDoD6EzTBEL/Kw4iz6yl
	n22FVvlKmIMJCXcwydwF8RTbsSimfpfOtJiQHl9phSPXk=
X-Received: by 2002:a17:90a:da85:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3ac1c767e3fmr4444554a91.27.1791924334943;
        Tue, 13 Oct 2026 13:45:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac677967fcsm43013a91.2.2026.10.13.13.45.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:45:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5351f1b26e6so51920941cf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791924331; x=1792529131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fn6fAIq7HU354S7iJBpqt1EqT6IYIhNvzY1GRRTqbFI=;
        b=fiAR+DyT9EdSGFqGe/wz+Wz+LmoDsj1d4vJz5ZhJD/Y7+XM4Px4lMjm7mR7/Xc3eBa
         AQN/i40Uu47QPDGrbBXkPDeJWx0f+fz/igeL9m3AXDvpmVrbGpUYclto8lpwb6RIl0QB
         ziqqhsPX2K/DZQsYZVo9RVSmLIfmIBjxh2am0=
X-Received: by 2002:a05:622a:4c08:b0:535:f3e:745e with SMTP id d75a77b69052e-5359fae3fcbmr231779901cf.20.1791924331217;
        Tue, 13 Oct 2026 13:45:31 -0700 (PDT)
X-Received: by 2002:a05:622a:4c08:b0:535:f3e:745e with SMTP id d75a77b69052e-5359fae3fcbmr231779361cf.20.1791924330705;
        Tue, 13 Oct 2026 13:45:30 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535f4eee7bcsm15879231cf.30.2026.10.13.13.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:45:30 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 RESEND 2/6] net: bcmasp: unmap previous DMA mappings on TX map failure
Date: Tue, 13 Oct 2026 13:44:35 -0700
Message-Id: <20261013204439.3494046-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When mapping an skb with fragments for transmission in bcmasp_xmit(),
if mapping fails on fragment i > 0, the error handler calls
bcmasp_clean_txcb() for previous iterations j < i. However,
bcmasp_clean_txcb() only zeroes the control block fields without
unmapping the DMA buffers, leaking the DMA mappings allocated for the
head and earlier fragments.

Call dma_unmap_single() before calling bcmasp_clean_txcb() in the error
cleanup loop.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index f2176ef3a127..9ad5a982542f 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -285,6 +285,11 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 			intf->mib.tx_dma_failed++;
 			spb_index = intf->tx_spb_index;
 			for (j = 0; j < i; j++) {
+				txcb = &intf->tx_cbs[spb_index];
+				dma_unmap_single(kdev,
+						 dma_unmap_addr(txcb, dma_addr),
+						 dma_unmap_len(txcb, dma_len),
+						 DMA_TO_DEVICE);
 				bcmasp_clean_txcb(intf, spb_index);
 				spb_index = incr_ring(spb_index,
 						      DESC_RING_COUNT);
-- 
2.34.1

