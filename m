Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3F521211
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898528; cv=none; b=La+LstziyJoMbEPeb3UKG6wgWkRZdWGqmpB3mPf5VXYSkYgjNFx3W47AtTTudYkbKpPX/LhjyAoRK9uCsxNXyuMv4sn0TwEgdJADqECDeWg4+aegZyEaB4ieOGE41q9JYRtFJVS1VaBQFJhdEN4TT3+N/sLqPTIfrNZrUmGRjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898528; c=relaxed/simple;
	bh=N6fefP2t7dBu0CANERrHDTr8v/TO1zFwnIvBIv/5Z7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rA5f0uPexLxGEZZhky35mPHuS/2DKbqjnVxTw1COqdd1jLaejYJXadtnUd3Zubg6afwNlkVvUT4NFVZ7rtFiRVUq/Z5ilOAtAt+HEO9zIzDpNxk3Dd1YjaHO+ZvANpL21cuVGxOvmff8MzrLZa1bFzKRU5FQJNxpPraov3ZyWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4wObMgz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4wObMgz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a17ce1dc00so6702285e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791898525; x=1792503325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4Fg/kGMgH93krXP0h6BlEw/WJdjeUSmyLtEuqzGKl0=;
        b=W4wObMgz1WJQADxnzLFgsSASC3G4WuM1CDKZAUWK40KjlVz3YocZfVF2Abtg+N+HR2
         o9w1McOdw36L7eUKRxsLlY6EYt3AxedxnzHF6qL+Q1g/SBj186iufamMVY6dHV/m2L+v
         VusAxHeQqzAWP/ER1FrSchu1cKzL1NOJxByDqwcgHxl/dYugrsJ97ETKsp83po6q6oh2
         8rDDiO9gfsre1QmdORxlg0Md71IZ6BGQaigCJpPuvVSgC08ZCLd4YRQ3lCX7qOY/qDCh
         3Pk4xpW1l2sx2wfZLPhNVoeL+ZcZ7hdC1dPuhKYGgcK6OUYjz9wG4Sb0iO0cHvslLr6G
         M5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791898525; x=1792503325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4Fg/kGMgH93krXP0h6BlEw/WJdjeUSmyLtEuqzGKl0=;
        b=bPoT6LU9s/jINKOQq72LO7ifHGEupbqTAV5oiiMH12DxDjRYV2y9Y0GK8MDctxoo88
         PwOTg1Z/44Dkj/9Epu2euH6LopNEPyresduCcFHaz0H9nn42Nc8nPkTOBdNVByNci2MW
         wkAaPmmbIeCWHm5OrfQXnM3kArVGOV8MTcdSp6/zhFYJn3Q83HgQ0cH+9zH5LvudH06g
         FtK98z87PPmBhq2PJmduXqcKq3dR32jP/gVbY6T97x3zAWaEB0unzkhUVrNkA5w48MuF
         xiL5wbUDcxaS1PsuWThNBuT6nrOWwNuFoBtMzGtocAmDWxFpDdaribW/fQL+e5Ubzs4X
         DTpg==
X-Forwarded-Encrypted: i=1; AKwUvBzmLeABLe0t2Bni8m+vbqNrKqVpujkyMtGOn0KMzP15YYop0apnu+Q0bVuDnwBwYe6ao79wK+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyMxEJP2w7YYa0G1pusjOwHVKC6r4i41NUfNh80ABsEo/kPK1p
	Ltuw8w+lDdwzlBiZZtFGEZr99u5kgykSh9lmprDBNq0iikSEHQ7whYQY
X-Gm-Gg: AYBFou0PDcPw+V2kwUwruEXlw9msiXTizADc6rNuWGPQJRS3j7LQdjs2YFUmx3iociP
	mNfIQDrvcSrm22fNJbmJUjGOTz1pyjpSSM2Jujd/kFQEgnIfaTIleeU1IsYhSJI9R0PLoOyxFlq
	UHqvUBcKcJeRFcFsU/XkF/3BxCs41fRIgHJFz4C+xqgZ6Jv75KQL3vkM/GKWg0IHWMzkGuBIgFD
	6wLwwst2NIAyXI/KGnmSIh9hnSwcMOrxX6QigDXmZ8dOJ6Gg0b4JRwhy442N1EGBtHZLl+3UcTm
	2iI3rJKFLTfygHcoX2ZbS0CpNMlfMmh0lr/NdboTWSsVmpdZdJqGzR3daY0MP2u854bPmYdBoRq
	aUSriLh3kRYkB3th44Gl0Sd5SNZUY1Uw8dwerIcWjc0b4sujIFPG6ZhjujoDhIgUlost/fIjj4r
	qr0hm+nxlTInOzNDOA7Rcvejg284uEmjoChrwDY1IrDbfpr6TSTSIS5w8AptYW992KsYuoG65Wn
	bWhjcF1JFDFWV6k9wCnUq2gONJ9Ku9czz/SilqXnDdm6wrs1ImdE/Robk9QMx7LV+s2ftwdVyZf
	LQ==
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr247111765e9.1.1791898525052;
        Tue, 13 Oct 2026 06:35:25 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a18c85009csm284480325e9.2.2026.10.13.06.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:35:24 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: korina: fix dma_unmap_single() length in korina_rx()
Date: Tue, 13 Oct 2026 15:23:11 +0200
Message-ID: <20261013132319.22253-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_map_single() is called with size KORINA_RBSIZE and
dma_unmap_single() is called with size pkt_len which might be smaller.
Therefore, parts of the buffer may stay mapped after dma_unmap_single()
is called, which leaks a resource and might leave exposed mapped memory
that might be eventually freed.

Change dma_unmap_single() length to KORINA_RBSIZE.

Fixes: 0fc96939a97f ("net: korina: Use DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/korina.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 891a94d89f4b..fac3d3d3e5d7 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -649,7 +649,7 @@ static int korina_rx(struct net_device *dev, int limit)
 
 		pkt_len = RCVPKT_LENGTH(devcs);
 		dma_unmap_single(lp->dmadev, lp->rx_skb_dma[lp->rx_next_done],
-				 pkt_len, DMA_FROM_DEVICE);
+				 KORINA_RBSIZE, DMA_FROM_DEVICE);
 
 		/* Do not count the CRC */
 		skb_put(skb, pkt_len - 4);
-- 
2.43.0

