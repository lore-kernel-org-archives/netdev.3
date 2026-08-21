Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9E19F137
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315607; cv=none; b=q23nsDSPYmjVQ4oz+DOBomP6qRdw/GLh8/eZUWhOjqz7kcNbvketQtASTh674gqsVw8GpN+qfylV4ZcsH+DGrmzefX/SQssyl79pK2RdR7q/Eyf9af1jNoRvVsPElr343cSNgIbmcemy5CYAHz6CMxvjUen03URga90f7h6YRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315607; c=relaxed/simple;
	bh=qWwV76eXl8pi9NZ1itpMyPueAYtNcqe/axydeitklGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4bRiMUcexGmMl0Nm9WAdJeRaYkWdZ8A08I0PKJoWHZXN5MZmE01G0aYNHWc5Z4mIS+DuAcU4DBAApGxWTVQAABMaBJXjKJd3MnUfVRpkO76A3pZoBt/gVKoqtPALgglnC4XWhlGcnua4KPVezjvmGvMzbzgT1kStO5r1SMBACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivjc4975; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivjc4975"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cca0c5799eso8119935ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315601; x=1787920401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/AXB9IQGSbDb13imfwWL/kXTtQeUapOU81HM4JBB/5w=;
        b=ivjc4975SoQw545ulJPyewVPDufA0w9A9lQVJM1aMPAGO5ub1bKTyOjyWlq0CgQ86T
         3Tw/YWZdddM00AoeAI9dHQwBaZSx2f01n7PAXWTqG5XkArs9S7MJKlCIwhL44R/VsWNC
         FhmhDuLCZOEp4sCdIKxdW4nVQaW9DQrjJ9np6HFi6MmF3+Pvf6Mq1DtpS3a9qEINEF3m
         Kip0bPIhruHUzMohafiJcHNw4RnTiNCdRuw/rcrKCkxGV70pugCUlOGOLdL4d/KsHNs1
         +4JYuePWs9WoPG12mwGkPWYpKVfVVgBl6/dr0m7rpuyh9RCE92sveZSmjEn/2jFhCZUS
         eRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315601; x=1787920401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/AXB9IQGSbDb13imfwWL/kXTtQeUapOU81HM4JBB/5w=;
        b=MyJndP2mugUQEFMxO44Q2rCs/zzym0Tw3Rq8TT82Sq7qMe9uVsKg2qqrGOYwpDjnO+
         HTXaI44jTImGfX0ff7fCzDvffLPcAPVcz6nwplLIaLnZbmyc4JxuBLlHh1NYrnK2TlJ9
         2hDl4ZX6kkSgXZr6wV0vvg0yFDGJyBsqUsXOZ2pulzTruGQvi6xDtESQ/e4SjR4iHsWK
         XCT6B9p5zCsihpVqLpetUYO2MtnwsrJRIr3o7AxhZP7874yFAdeOSXdi5RQjwlELI/gF
         pYddXDIy0cztuTDg9FZ43DkdRpS//jGiu+Z1dlGn+sIFOGZ957H8A2gUKNw1/JlSQ1Ko
         wN1A==
X-Gm-Message-State: AFuF++mj22JYh3QYUmyW/bnsYPiVqBYDkGzQVqfcSc3WgmGlOwfond6F
	kln3z2rnO/fbQDSAWKh5Ms0yCtSf6yuxMIVuu4YGPOWHeW0/Yji2A+RQ
X-Gm-Gg: AR+sD13GphNdMhL6dSY/WNe4OjNu94KRv/8alLAe4IxtaOY8DbCpu95Ue0TQjfATRdx
	Wk6aMf62cZ7zm61CGqyLp1dlYvZ1ecKPgIMUQNs9eNI9mB/YoawY18bFgPL951IP6/JLUwuOUYr
	yZ5zDqyA87FGWTkYH2r9C+16h4Ohzhbi4Ilqf3N4EUnfuNuOKbG/1EaodEHjqeUHA87M08zQU50
	azEPsjof+YOK+oYzj308ILWM4nSgcPDN3SadXC4huvnCsm28Ip0C0EykMGpMbFd8ola6b8+umla
	clsi9ZHcI6pYyY3FsqgeGC7kbbG7fSq9UvJVkyHR/0MdPK+1e3fxlDSBkZk95ZQpEnyC95sANaF
	isNAk5J7SsieydBTPVDOXFKTtngRKXQou66/LEjz2vuKIsI0YZfnKS2y2PY167BGIZITHMe9AOp
	sO6tDB9avOV9uYLMpnVhzSCXOWnGSLwIi53dK4QFKqK+BzKPei5wv3lutkn3CKXilugzZm8ZdL4
	Hm2mTzdR6wxiAHjWs6fv7JD7ffkuFL9YhYkJH75gRNScxNWWMWmuossSzJXcEwTlI0gkQ90Fmsg
	i19s
X-Received: by 2002:a17:902:f70e:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d64afd7c86mr130049755ad.11.1787315598800;
        Fri, 21 Aug 2026 05:33:18 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1d8sm18402285ad.52.2026.08.21.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:33:18 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net v4 3/3] net: xilinx: axienet: Fix IRQ error handling
Date: Fri, 21 Aug 2026 19:32:49 +0700
Message-ID: <20260821123249.41527-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821123249.41527-1-phucduc.bui@gmail.com>
References: <20260821123249.41527-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

irq_of_parse_and_map() returns 0 when parsing or mapping an IRQ fails,
while platform_get_irq() returns a negative error code on failure.
Handle both cases and preserve the original IRQ lookup errors instead
of returning -ENOMEM.

Fixes: 28ef9ebdb64c ("net: axienet: make use of axistream-connected attribute optional")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v4 : 
 - Add error handling for irq_of_parse_and_map()

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 3927ababf833..68b580191508 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2971,10 +2971,14 @@ static int axienet_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "could not map DMA regs\n");
 			return PTR_ERR(lp->dma_regs);
 		}
-		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
+		if (!lp->rx_irq || !lp->tx_irq) {
 			dev_err(&pdev->dev, "could not determine irqs\n");
 			return -ENOMEM;
 		}
+		if (lp->rx_irq < 0)
+			return lp->rx_irq;
+		if (lp->tx_irq < 0)
+			return lp->tx_irq;
 		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
 			return lp->eth_irq;
 
-- 
2.43.0

