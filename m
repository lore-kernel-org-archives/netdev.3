Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0F1E9B1A
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230934; cv=none; b=RYy4tlObdSxqzCcLjVkqKPgCrnVipvDEN74ve13FjHmqX67ZHk7Od6cvKTILU6K8Q2147B0IomdiZHQowVHxMeVPZtXtJHbompLS9uRJdVmnKplksc60rlFTC5OnX0MzdnGLvG4f1MHD5586opzakH4bwOkpiydgjvo6M6VuKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230934; c=relaxed/simple;
	bh=LsTVtm99Hmp1RiANouTdvFTGaEbE7Eich9RQfk9n81Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXQsseFRCPktgM7iLKox795SauZZpd93+lgk7OyuDAUxt8PkJyQMz9CQEt1Ecg/D0qpbVGfTLb8sHbE+gFlmhcXuM52OhTyLOWe3b6nSLT+f/BRDF/dr47+4tiznDwXc0InG9gO2wfnaMAeLuV1xetlyQL3n3/tlAk4UEWF6ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za; spf=none smtp.mailfrom=ffroot.co.za; dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b=cOibEu+x; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b="cOibEu+x"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1793791f8f.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20251104.gappssmtp.com; s=20251104; t=1787230930; x=1787835730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fozce2PiD8DgVzppXidr9Ihe7kZ4AQDOGf/RZkIXe4=;
        b=cOibEu+xVUfc32i9bxrbaJI4EYa7ygDzNvR6JB8z5aIGI2+xLYTQpi185Fo5PBC7qL
         4F8v62woQy/JZffopijheKkEppswetOhFtBoJDyvgaxHGNngj+oXERWlfE5PJ8KN1IXK
         vn7udwbbNdiTXTkhwcWENZg9rCgrmWM7scgivVo8rWdYtGAZBSNArp1z/pUN/mKWC7m2
         UAqC1IhFYl0PcECPf86Tps0cNGcwiNiRq9okBU8oIqGRZsJEhC75ckOYww1b6DNmbXq2
         MWu3wdRLogejQtaqtxBrdtSIzWRvat1bGucUBGGOAUQan+6EzW8JWlAz0kFH28zy4qNY
         7aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230930; x=1787835730;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8fozce2PiD8DgVzppXidr9Ihe7kZ4AQDOGf/RZkIXe4=;
        b=Yxp0RVrKdwHPiJp27e8eAVdz1erA+hxUI5bKq2ghY+GxAWfRseju6FffYovDU6Et99
         k3XWj6OQPHh2bIy/YYbSvUegGMB/kp8SHVPgu+Ojp1WJcgDGUg+bpUh5I7rRQwb3agke
         wCVCu6NTBiEDRDi3ikK5geTPuG9hejNF14YSJz0zJdSQJakm6Zy9jew1nCQWEUjtSM19
         8HtjofhEVROv0d6IQJV/c3OqePHxYjaDuKLxjghlaPanKMf/mXpE2VnvM7d0OdiAkEOE
         sd8opLNW/qeJGLYBIulwNiLQAFPAMuGC3QHf988Ra40MUWTKrthO26Z10DBlORtaV9a9
         dicQ==
X-Gm-Message-State: AFuF++lZgW6ziyHBY4n9PeDAuKkwhIHK+ypBc9h0s52vvy1p9iVHYBSt
	wSmNQFrxY5/zav2gnmjs6wG8plLdEY4wph9wWeQ7YGTrDb/t/WvYqwvPUvzkRJJjxxxBXREf8B9
	JFX7fpTg=
X-Gm-Gg: AR+sD10KnOj4unKmwEPgXPjlgLt4cR1BBmcGYDofH+IzYybAr/Nj8juCHGcSi16fviU
	iLxHwshKQux4IqmXRpLMDcjqWlwvMNnsQWSqvvsl7T4e6LED0pw05vd7IqV9/gVYyHAQhY8WHvs
	DWqhGN7k5JAqwW4bmyVFUoZkibZFBnWTZ8/XPNc+bBhRmI+gXsuH/Kt6ITIaPulVyzlYGkcsOsn
	ZuzXw4PRV975xK0GnowPaQvrS0h6quOKHEjzTt/oA7i/087QB7IwFvc0PGPPzxrJL/LG6b0iTqH
	InI244dQdUJJo8RTCSZqK/2G4y5rAECwjqU2faQbVB3R9Br6O1i/CH+wKKxqoy4szi6u6n6fTmu
	BbpPlSmohmTKUne1gVBjnWouIb6abXNdMAhHaq2nOZYUlX9HnsbBW6MJmjO+9pDmzshhkEre/rM
	DzVVrMMWE1bB6wfsUcrM3U/JiLY+k4x/7HzrY/dV3lD4BCwGKXU3AjlUkPA+GYEUZ2V/9dRL9US
	B+Dwdqht4mUiWlGJ6p6sgcE
X-Received: by 2002:a5d:5c83:0:b0:47f:ec8a:214f with SMTP id ffacd0b85a97d-482b1fd4d2amr23049090f8f.15.1787230930091;
        Thu, 20 Aug 2026 06:02:10 -0700 (PDT)
Received: from dev-ag.figment.co.za ([102.33.165.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b145153fsm13106433f8f.12.2026.08.20.06.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:02:08 -0700 (PDT)
From: Andrew Gaylard <ag@ffroot.co.za>
To: netdev@vger.kernel.org
Cc: wellslutw@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Gaylard <ag@ffroot.co.za>
Subject: [PATCH] net: sunplus: fix tx_poll spin_lock missing irqsave in NAPI context
Date: Thu, 20 Aug 2026 15:01:59 +0200
Message-ID: <20260820130159.1584806-1-ag@ffroot.co.za>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

spl2sw_tx_poll() runs in NAPI (softirq) context and acquires
comm->tx_lock with plain spin_lock(). The hardirq handler
spl2sw_ethernet_interrupt() acquires the same lock, so a hardirq on
the same CPU while the NAPI poll holds the lock would deadlock with
IRQs disabled. Use spin_lock_irqsave/spin_unlock_irqrestore.

Signed-off-by: Andrew Gaylard <ag@ffroot.co.za>
---
 drivers/net/ethernet/sunplus/spl2sw_int.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_int.c b/drivers/net/ethernet/sunplus/spl2sw_int.c
index a37c9a4c281f..7e07cd941434 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_int.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_int.c
@@ -147,7 +147,7 @@ int spl2sw_tx_poll(struct napi_struct *napi, int budget)
 	u32 cmd;
 	int i;
 
-	spin_lock(&comm->tx_lock);
+	spin_lock_irqsave(&comm->tx_lock, flags);
 
 	tx_done_pos = comm->tx_done_pos;
 	while (((tx_done_pos != comm->tx_pos) || (comm->tx_desc_full == 1)) && budget_left) {
@@ -196,7 +196,7 @@ int spl2sw_tx_poll(struct napi_struct *napi, int budget)
 				if (netif_queue_stopped(comm->ndev[i]))
 					netif_wake_queue(comm->ndev[i]);
 
-	spin_unlock(&comm->tx_lock);
+	spin_unlock_irqrestore(&comm->tx_lock, flags);
 
 	spin_lock_irqsave(&comm->int_mask_lock, flags);
 	mask = readl(comm->l2sw_reg_base + L2SW_SW_INT_MASK_0);
-- 
2.53.0

