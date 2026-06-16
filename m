Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B432438FF3
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611608; cv=none; b=brk7CDlf1bTZyKZKYhYYgveaGPa8rlkD+8Rufpn/8dJAf0bdTPRry0EmHaZr2ccyHJAG7+NEk4x0ovwGxMrnBInMj+Tz1Mi0NZ2StSZ/XcvWJr5rxBPLHvRTbBEsZLA2gia1uRvuApEl9ApAc0xmda+uA0I+qvJCOC/yt6H/pDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611608; c=relaxed/simple;
	bh=80ZInHziV8Gs9xEqmz39yHYVHtv4rhthychWXJiyWDw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ONWKBWCu2862gpruhuzK8ZWZaO+Bn0hwz5W08Lqxdg3XlY9JNKnAm/h4yeOOLJC3WfaxvptcFs7P9Cpo5Chp2EgKi2nXr+nW8ZtEsRjGjWU1NMM5OnqCVccpBZCR/jArnFLZ2F2LgYcB5XUNTAlAIwkK+TFqoHqEqBHXGytW0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IudcmXSo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IudcmXSo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf20f6be6bso32664535ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781611607; x=1782216407; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mnBr3tjwuDiPitMGmjjZXJEZ7evFYqDmAUAvxZYdi0=;
        b=IudcmXSow5bCDPGB3y6eL1kz2oX2TAd+uT316IO/YUsVjYGzYaLLGPx6Pe47WfKnbK
         8trK7Pkd5dKOMCFToUCsUiS1YNdD5yxg/bB4Kf3lhv6w8mrJ9eYmEpWsXF9hWklStAkT
         RNk+WwjAxMcjYYnhGWVbmo1SHVl4hoku0nvHKZqIJI0NTXC1IcOiq65n6ehW42xHcgsx
         PYn+Wziyje1enh0e1AOtVxFmja36w6cDnIKQJP41dLfhreQVgxtq3/g09rJ1oZms1yrf
         nzSLwbirc3BKFlxfbrsP3Sv8B/RspEEfyYuSkXNPyFls4/SbEMSPyEkmHZVGYGYqolXW
         pG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611607; x=1782216407;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mnBr3tjwuDiPitMGmjjZXJEZ7evFYqDmAUAvxZYdi0=;
        b=lofCya+osj83CWCr6/5OefcoVGVw2NUanZN1iYvCK6EnXTYzIeT7xsrpuitUG8PMKM
         l+XXPuTAYBR2V0TYexs6v8bm3xVLaGxtrL8+KMfb9tXXbWC3Puytw887dlSx/s8S5zUc
         cM2ZFkxFH1PcEj3jGRJp24c+Xvy5iQLotPergb4WDRpbSjsLygacPPUcGlHMxtq6FQsX
         u7H6kLpnzZ9JpZgW3JunAapnFTqjovLddaFJBKzIO5d+xPph/sIRpBGEWMP4UIbtyJQg
         Vwm1RLNVQmr9a78wDSsrcJuPLoiTojH8MS0oEwI3TMSX0bv9VDI95MQcI4Lhr14Xt3bb
         oJ7A==
X-Gm-Message-State: AOJu0Yziw4RPDWigYWCUOOoz42+y9+oZ5gtredm562qiRxDG2H8j6Iny
	gZMLQjB8+A+cvcpAKR4hlXyyHH3PhMTmBPLWNrYPNU3SYXVXOm1c/XMZWZ7lWhg6J4CbRg==
X-Gm-Gg: Acq92OFJNUCNi37a/A1MinT46SHQyBKw/yF3MuPG62a38yrJvk/H+GRkcpL5DSZ5Q3n
	1wiNuw0QwItrpujfzT8EOAHrDx6/51M8yQ8RlcZxaKhwQvWJ3EawMOhYWDsY//A8QnDVkcu9S7P
	zUR4KwTJBSgT5h/yCX0E5UFjaVATLExXglPpZgeDMBCKQGPHlFD15qK7m6o2KJvxcG7su20bjWu
	h+VcjuNnbpxldjRpJdtLtVs6xMlxWalDvyWeejiQnjUTZs525YS6ncLmnLQ6lvDzaA0Z20GSKU/
	Tf8kBX/DBVV2kLEczonjxKT+wdTkjmwDLWF345I1BFoDJu94HrkjlsClFiaN8+R2GzBB2Rkfh/C
	6tP+qY91V2nIECxyYHPierQWUQvseR07sUvPfX9yBX6WIfm7xwmmqTG4uPyaOHzwsGrpyKhkpPP
	r29SoHyH3B5K5XUZAI
X-Received: by 2002:a17:902:f549:b0:2c6:96f3:96a6 with SMTP id d9443c01a7336-2c69a1d15f8mr33933655ad.37.1781611606918;
        Tue, 16 Jun 2026 05:06:46 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328abe7bsm126562735ad.49.2026.06.16.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:06:46 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2] [net] net: airoha: Clean up RX queues in airoha_dev_stop
Date: Tue, 16 Jun 2026 18:50:48 +0800
Message-ID: <178161160256.2165161.14322392784449633554@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

When the last port is stopped, airoha_dev_stop() clears TX queues
but neglects to clean up RX queues. This can lead to:
- RX ring buffer descriptors remaining valid after device close
- Potential DMA synchronization issues on device reopen
- Risk of use-after-free if pages are freed while DMA is still active

Add cleanup loop for RX queues to mirror the TX queue cleanup,
ensuring symmetric resource management.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..9ca5bbf64d 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1771,6 +1771,13 @@ static int airoha_dev_stop(struct net_device *dev)
 
 			airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
 		}
+
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			if (!qdma->q_rx[i].ndesc)
+				continue;
+
+			airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
+		}
 	}
 
 	return 0;
-- 
2.51.0


