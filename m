Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955D3515F1
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257888; cv=none; b=EBClg85UGLP1swncRJdh+D9Ot2pa1WlAvYZVdnMgvViD7LnSVjx7ks9paooPBF74Jb/DM8Rg68rtiP32fXy4imnqHDXQ+D+ytnt/iZ3LD626s5E35oyBlWCJKK4lXKKf8Ih7Bw64ghcTGE0++bmoiEYoELc3IGUN5ZkDJr0Ac6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257888; c=relaxed/simple;
	bh=s+SJDHC4PikhkB0xzyjadUkSXp0uMtL60Mts4EJbjMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5UZPPxM0+8fABjjnrr5oLJdUaIkfeWtXrBimhc3h5UwPrd3YAr5rdboY7xgK+901tgUFN8OI0gE7VIS/sekkN3E3Ep/7iLhyEPDz8xPOxmTatqgb+bcwR69tgqCzSuAKPHZVxf42tvwDQbnPxevMmGFHiJMB0x6ov6D2ccZLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qpef2z13; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qpef2z13"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so1226487f8f.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257885; x=1790862685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9iLsnAODx2rF847XvroFh/ns6W9jfoyO6c4E8bJMN4=;
        b=Qpef2z132exD8StDQB6YGTwIatT32Snz49SPUn2E/tuq4hsuo/rDZ1P3H3aVhb3KrP
         2VklBRtoFpUb7ORwTsrUXOu80HumPY+iijeuu0nzUbW9DIkW0AFicirNUTxvg0oTsjHy
         c90m+jLgPHZo6IS+bpagcHNiA5LoTlQqxndj7VHqBLXu/XvYamWv2W1T1uGJlGesr2+Q
         joZEO+k7lQhDhcRkyUbnChOcgknUcOlf438lxmDj9Cdau9LpCOby7Ei2dMHICuQmBao4
         clbZPfunF9b/xZ2XBxw5+Z1ORElcG/K9RVoLzH6uICZ1pinTjcGhiiQ70SJ4B3KvF1ds
         pPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257885; x=1790862685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t9iLsnAODx2rF847XvroFh/ns6W9jfoyO6c4E8bJMN4=;
        b=aLPTSBrqUUumu6e5hTGjWz0q2ceZtVzEv/DxBm7yJyMopYK13xvAg9B12dRu5uAeqq
         hl6slT6jZfmjz40K2QRXsUtNSFQrTTGtwrBwxZnQg8yBB73e7Cj8VZHmMLkJn8RHp3e5
         g0mK/d+iu712zn09pECUfE5fSXb+xhI+RKNsFanjBhZSaI4kfghrAKZDPOD/xcfljbFY
         0s4q4FgfSq7chiI0gkVDwZcSyGfTJHqyuhQ/AuWu6tCooE+xVZeadGmvd/hSCRVPkV9X
         OvXuzX177rYAnF0OS42j+QtUakzjNpG9dy2/sTcy8W9sXLiorCLZdPRaJI7D0/gYtogI
         /OGg==
X-Gm-Message-State: AFuF++lUkxfmCV7D4XZcfsaHIuo4nYQdJk66Sl6Fsfj4HLWNN/M9vgdv
	n4DTVSNewtLzNfaze2QnKBdjE4Vbtj4yt7R45f1rRFF9Pc6n8jXk0vEAdX01qbbg
X-Gm-Gg: AYBFou1Gbdo8jkUWu6cRKJphee4clqr6Ujq0ceRyd2Afp/WYuQp0Y04/LguVCZdh0kE
	H9G/eRuCFW+69LUZ1iCrHOOHHqz6Uqu8TU87Tzmbsnf2IsLsN12lUiznmmDpsayPOFCLSWTxevF
	LMRx1FHd8P9UBTOl9IV4svUUbHtn+edWDQvQRuCUZ3r7PKRROcIv41Eh9s1f4+GHG0Zs+syRflR
	0vf3j+clKeixXOs5HFSFj+TPw8gE9QP6Qd/4qENFDoDAxZDMCq3rgtY51ddb7ws/vHDP3EhYa5O
	pmYXePXzAIuzSf5l/Ax4Q8CXmFEB49G/mpKelNF9cEcOSeQVJJAi1v2mp6eTpn4LBr87OGZp9db
	2gdvDkKCxBQzVaYPSB1ElAFu5IPBwVDl4+GIp7X1fFGkVhY+/bXt2hJ7IiU0rMiUI+/JdlkCV33
	sbnZIXz+IlR4kkcolf0EPX80n3yK1lRuozF2s5QDmngH683iSRYprUh2tpqLRV4L6w2Inzp7qGm
	Mx4t7adZ43hPr802cSmk81Z3SyXFCiv6sO45y2w
X-Received: by 2002:a5d:5d87:0:b0:482:fb60:2f0 with SMTP id ffacd0b85a97d-488716b2841mr5288900f8f.8.1790257884978;
        Thu, 24 Sep 2026 06:51:24 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889376sm12060660f8f.33.2026.09.24.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:51:24 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	daniel@iogearbox.net,
	andybnac@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v2 2/4] net: axienet: quiesce the TX path before axienet_stop() tears it down
Date: Thu, 24 Sep 2026 16:51:14 +0300
Message-ID: <20260924135116.185161-3-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260924135116.185161-1-maimon.sagi@gmail.com>
References: <20260924135116.185161-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the legacy DMA path axienet_stop() stops the DMA engine and frees the
TX descriptor ring with axienet_dma_bd_release(), but never stops the
transmit queue or waits for a transmit already in progress.

On the dev_close() path this is covered by the core:
dev_deactivate_many() has already quiesced the qdisc and waited for
in-flight transmits with synchronize_net().  axienet_suspend() instead
calls axienet_stop() directly.  Its netif_device_detach() only sets
__QUEUE_STATE_DRV_XOFF, without taking the transmit lock, so an
axienet_start_xmit() that was already running can still be writing a
descriptor into lp->tx_bd_v, or kicking XAXIDMA_TX_TDESC, while the
engine is reset and the ring is freed underneath it.

Call netif_tx_disable() once TX NAPI is disabled and the error work has
been flushed.  It takes each queue's transmit lock, so it waits for any
transmit in progress, and nothing can wake the queue afterwards: the
error work returns early once lp->stopping is set, and axienet_tx_poll()
can no longer run.

The dmaengine path is left as it is.  There the completion callback can
wake the queue until the channel has been terminated, so it would need a
different ordering.

Tested on an AXI Ethernet MAC behind a PCIe endpoint: traffic passes,
and after each of ten down/up cycles and five module reloads, all made
with traffic running and each running this path, traffic resumes and
nothing is logged.  Suspend was not exercised.

Fixes: a3de357b087e ("net: axiemac: add PM callbacks to support suspend/resume")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fb26d2e39fac..6d448d0b523d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1739,6 +1739,14 @@ static int axienet_stop(struct net_device *ndev)
 
 		napi_disable(&lp->napi_tx);
 		napi_disable(&lp->napi_rx);
+
+		/* Nothing can wake the queue now: the error work returns early
+		 * once lp->stopping is set, and TX NAPI is disabled.  Stop it and
+		 * wait out any transmit in progress before the ring goes away.
+		 * dev_close() has already done this, but axienet_suspend() calls
+		 * us directly.
+		 */
+		netif_tx_disable(ndev);
 	}
 
 	cancel_work_sync(&lp->rx_dim.work);
-- 
2.47.0

