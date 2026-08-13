Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A53330B3F
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786594832; cv=none; b=TLjeBJ6dfug2lIBxrsK6ICzan9biT57MnaLjCQLXTuJm8Kv9hr/eET3QhziHTwOc3roP+x7vvSv/7IJhy4Py76d4FGPxcDgRKL1D95IEkPnMWyvwW4FGcm0KNBPIibrzPTH5TW9qlmuX7VZAksXA0iZphWSZUpZuDsTd2Gj5vqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786594832; c=relaxed/simple;
	bh=gXKfQPPtANNZHJUProhwbQDCYeFtL1eTSoCCjA+/SqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoYJ6sISguHOZtw+t/mvR0yGw3uuwCo3EVz+Zz+L8copr9ArKcFrZZHHzE3/SWdAvWlGbdsNDMhusrlGgXfKBrLH0u2C6j9mvyEtEuQ41dEcn4caaKqT829Sxb0aRmMgTr7vMUX5HIQxx+0exIDuKJzPNASNQ1aCbV/a/kH3ixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBIH6qsU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBIH6qsU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cca0c5799eso21097065ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786594830; x=1787199630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qvgR15Tx+UTRmIkTVdFC4whcGk/0e9sve+h3BkqQWSE=;
        b=SBIH6qsUr+cg0zVmlUClTwGkHH5SiptIZUucO0lWu3gltdHbYFhEadOxTHKKNK+JFr
         pVS/ArLGCe142EFjvw71LZt9opst/Pv0sof5796r8bQ2A5m2+U7zHQOZga1Ng4wtagSV
         daVpLudrbLVvMh21CWPLzEBeE8a16fJjHRHacpoeO9hxC9DqtxVE/TUjcddxhiEwMwZ7
         kH3DYUCjcraxdve5/gcNB/4hkg1andWk1fZeY+v5k9Wc0UhJITBsASrrDHJA2W/FS3W4
         GQxb9f9Hh7le3HjAPm9r3Nvbw/B6j9EMgTATJGf3wWFkqKKj751A2rZrF9WpJVhyFfCC
         HkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786594830; x=1787199630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvgR15Tx+UTRmIkTVdFC4whcGk/0e9sve+h3BkqQWSE=;
        b=LeGT2vRX4ExoEmrCsUbK7Pk78r1ChKVVcItbG0gOvqC5n0HvTJyhqkGnVpvitVhzt0
         QfB/CNkJFjlpX7hvHPdSjAneMYRQq1CaPPm+NukpYmj6rHcnemqH7YRURlWhsATc1iXB
         IuDjm61O6RWwcSCnoR0cBKmIdqHYSWnJJ8JWZVrN2MZLuYJDvyy0oXBtp2kX5tdGkg7/
         JwX9AGBA1BeSC7tB/ohDOXvVEw1RM3vG107i1Key51HdsICsvArCYVoFD3k1m1pOOj0T
         Tdk4OkFsH0dG/O1T766TrAMbUo6P+YXYRzncPc0feSDRvXbUD3ssdBmKn58oBIoDjuzT
         FPYg==
X-Forwarded-Encrypted: i=1; AHgh+RrBcE6w1ZmKEWGY4vpAx0rsSdCOaK9MGkMQxJfF29L/s/Bo0o+UiaN9Z3NAyoo1w7CSPRun2yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3goaf7NX+amCe2AaBAqHzva/tI1/NPb8QhqCE1/e+bbQH/V4
	LzZN1keR3ZxoSoSNaZTiIj8rEX9VxJJDhnk4JsfIJYm7RkBI6uDN+CEf
X-Gm-Gg: AR+sD13aKic23IQI+KPmHPKQtpmRdiNcW7GEBHCVTEDxmmVW313vXAU+bu+0N8TAVBZ
	EqIJOgR7mR8CxCm2tVbOj/Xv16mheJe3lc0R2uMDV+Tj0YlfggoTf0R/O+3/J2nQhmL5u7Zk6bk
	g0LefH14+daKGKXpMuA2eO5m8hjQBSgAK6cMzqVJ7Z5ziDCQPIZ2CUtR3ygbRX2RnebHzY9vb1y
	AaBbNriaz3a4dz1ms69uTvGppNZFxR7uyEDumUioriWgLzbWcLGyLLoioPCyQjMuOXHmoMWCY+o
	dJPvWokrZcg09hgOymDEPz8lq6b70vNpbaTjzKxR+UghrNY/nlCxnEzGHH9AFWNKX7OAbkoriGX
	HAmATXZDSwgUnwHsGw/BBHO/4sDKt36OmnZJbw+mk1enNK9dBaIJz6/AepC5euiA14koEO3dEmf
	EN5zoHOb+R2HS6h4eMVQDGz9PFuEVHWuC2MHky0+/3j4pgjwTVLNHI/DZ0GajueqbTx2YMthikm
	NaeWhkIpG1FZfXeeBsaoqDDeYqzgbymBv0ti0PXyOarEsUgbYDCwxyJF38GNVbpgFi6Z0As+WvT
	jJ1R
X-Received: by 2002:a17:90a:ec8f:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-3931e291d2dmr3936264a91.15.1786594830016;
        Wed, 12 Aug 2026 21:20:30 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cd468cesm1700084a91.7.2026.08.12.21.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:20:29 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 1/2] net: xilinx: axienet: Propagate errors from optional IRQ lookup
Date: Thu, 13 Aug 2026 11:20:11 +0700
Message-ID: <20260813042012.17631-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available, while other errors should be propagated.

Propagate all error codes returned by platform_get_irq_optional() other
than -ENXIO.

Another call to platform_get_irq_optional() in the same function already
handles the return value this way. Apply the same error handling to this
call site for consistency.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fcf517069d16..d23e9796725d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2957,12 +2957,16 @@ static int axienet_probe(struct platform_device *pdev)
 			lp->tx_irq = irq_of_parse_and_map(np, 0);
 			of_node_put(np);
 			lp->eth_irq = platform_get_irq_optional(pdev, 0);
+			if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
+				return lp->eth_irq;
 		} else {
 			/* Check for these resources directly on the Ethernet node. */
 			lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 			lp->rx_irq = platform_get_irq(pdev, 1);
 			lp->tx_irq = platform_get_irq(pdev, 0);
 			lp->eth_irq = platform_get_irq_optional(pdev, 2);
+			if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
+				return lp->eth_irq;
 		}
 		if (IS_ERR(lp->dma_regs)) {
 			dev_err(&pdev->dev, "could not map DMA regs\n");
-- 
2.43.0

