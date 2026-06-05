Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB42F5313
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621272; cv=none; b=FDF1Y616HJiXZwIZcz4uU9X8UovrL40T+xHidkb4cGK1BTHYmzs3qvFdehjjxjqOx8UIIFQZBWb+vCV9OFnMja01A40xaiTBVII5C0bvcaEZokTK/AWGcAauJ0xNSm6tXqGDLYN+f+QmpI0WSV4EaP6nSALlXz7nvst0dv7tLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621272; c=relaxed/simple;
	bh=rWJMdH+guxvVRg/fYfPqNZhV8vkxgoYK2GCfMJpBrRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toCzmN0HLGk5Bi6awiodiJ/JgJxPSKVtNjzA/MGMNhYOtUf5bPpTT1TnMi+Y/wjjnGmtnSs8ko9KWyUSHeGMqRJfJ6/1KRi6q4uf+Shj+J5HoY2dVmEuHZNvlPURqPaErzvAq0kRIgyvfFyROFomgglWKn6LZxyYisqTxEfy/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=hsqAdUk3; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="hsqAdUk3"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4863a7dac63so743815b6e.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780621250; x=1781226050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJZ0RqgIk8/DP02YY4aEMI6Gbsvdjs3yNWLkzeFClOw=;
        b=hsqAdUk3g0d8hX8GwxQMCFxWfR5jrXZTsrL+A5s1cWD0QycxMcDyH1YILlMcuJJjpP
         22zvT/jDunMY5iftF2R03vk3YUgCS2FUitNn+9iIG5B2qFwbPOjwdMOFlbv5OkasBIpW
         3z44NuIu3+zijT769bbC9L5/wfQKLOIEkanKhysKMwOTGV3gd61oa949rKcU7SJ7lQ/0
         8JGG+CNVRUUIu25eaWL7IzFGKmeE6em+wFG3qJJG6h2XGourhmlZq257M+JPyMh8YjOM
         QZXv81SzWB57ryPMbtBMPXdCInLf+qn7IFOYPJEoEC1i3uHCbFQ5xBkXsr7MXt5xqJYk
         6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780621250; x=1781226050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lJZ0RqgIk8/DP02YY4aEMI6Gbsvdjs3yNWLkzeFClOw=;
        b=alHk54JXV+uETea1rKuALpl2upSwV3YF952f5PLfXN+GKqgBLZpt+jwuZZT1eY7SKt
         oYmo/qNrsbq9PFcc8PSkdYlfzu3smponwwZ4hZMke+HystYXUZxUYFVlTj+THG/dFEv6
         zaHgXABa9ToRuaoMHJC2FlNM1PCXmPMtW4Zasr9HzEqZfO9zgs7+oxWr/rz78q/ryw9T
         INIxp1o1Kw3pmrs/Hr1JqmJZr/AwudXdlhfnhCjQXUwnfGErrrh0huahj7oz637UYNn6
         y01ZUAAlzhFGLNoAse4zeT7StvQ72x+PDzNMAIznmdAd0ythIObCr/loZ+DLGZRR1Aa0
         RoBg==
X-Forwarded-Encrypted: i=1; AFNElJ8Vu6R2tlNXoS0+rSIAgI1lB/ogL2w3ObxW52gXVugdiSYTDo9FpnSOgS7Cda+ZjE7cNS4vfY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyloBFEQk2bTVbUuNJz1I8plqujsO9L/dRIw7t2UMq/C/9etyi2
	b6PQpCRKg6/ad1DIUtIy74rlKNQxtrjNxQaA5Y/ENA0csfxufatGi0hmpaNPiZfT/kU=
X-Gm-Gg: Acq92OE/fejJKPkinYGHFf51h0Cn0zhEcsnC69Y0V9hS0NLkl5GLwBwWLdnZ6QkYMRV
	hD+M/3UWDTWGcwaLzMdEfN1ufXi70/9AbeHS1R8rspARxAZte+6RepoE3eddB4HEBFdvFMaRheo
	Rax7ZflQm9xaWBj59ebr81EuglbtR5yBD2gng9L8E4Dee4h8BLvkBCZGpPpTLrDUG4Cq5xvRWrh
	zBEe5pdqpogG7CtfL2xCVvyZcwOBvUorsOLlZ+PFDPUSC+B7oQQMRscd5wm9TH+IgrMvpyoTCPl
	BhCkJDTn43e7SlVzZCOS6gurZzA6jQdTMpmShS9vYJUObkFh2BCINfhk/JLpFv1+MmzwKT7wgRS
	Nci7YlTI6KySWcvWDi3n8tFssQhT4Lya0TEEH5u1DnFBDZ8iguYtYvBoOiA9YrZGPes2N7OmUM2
	alSUVmphw/bHM1XiqJnZPcKyYFi5SXpYb9oPVJJQ==
X-Received: by 2002:a05:6808:d4d:b0:485:4601:9c84 with SMTP id 5614622812f47-4868de44d92mr853906b6e.29.1780621250160;
        Thu, 04 Jun 2026 18:00:50 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b6ec694sm5544631b6e.5.2026.06.04.18.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:00:49 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	brgl@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: Daniel Thompson <daniel@riscstar.com>,
	elder@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	a0987203069@gmail.com,
	alexandre.torgue@foss.st.com,
	ast@kernel.org,
	boon.khai.ng@altera.com,
	chenchuangyu@xiaomi.com,
	chenhuacai@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	hkallweit1@gmail.com,
	inochiama@gmail.com,
	john.fastabend@gmail.com,
	julianbraha@gmail.com,
	livelycarpet87@gmail.com,
	mcoquelin.stm32@gmail.com,
	me@ziyao.cc,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	richardcochran@gmail.com,
	rohan.g.thomas@altera.com,
	sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	weishangjuan@eswincomputing.com,
	wens@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 07/14] net: stmmac: dwxgmac2: Add multi MSI interrupt mode
Date: Thu,  4 Jun 2026 20:00:14 -0500
Message-ID: <20260605010022.968612-8-elder@riscstar.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605010022.968612-1-elder@riscstar.com>
References: <20260605010022.968612-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently there are no XGMAC platforms integrated using the multi MSI
interrupt mode. In other words no existing driver sets both
DWMAC_CORE_XGMAC and STMMAC_FLAG_MULTI_MSI_EN.

In order to support systems that do enable both options (such as the
Toshiba TC9564 whose driver is currently being developed) we need to
add logic to the XGMAC DMA callbacks. Happily we can simply
replicate similar code from GMAC4. Let's do that!

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b03..9b0b5cc619556 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -320,6 +320,8 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define XGMAC_INTM_MASK			GENMASK(13, 12)
+#define XGMAC_INTM_MODE1		0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_RD_OSR_LMT		GENMASK(21, 16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df3..a84601ac32153 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,14 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	value = readl(ioaddr + XGMAC_DMA_MODE);
+
+	if (dma_cfg->multi_msi_en)
+		value = u32_replace_bits(value, XGMAC_INTM_MODE1,
+					 XGMAC_INTM_MASK);
+
+	writel(value, ioaddr + XGMAC_DMA_MODE);
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
-- 
2.51.0

