Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF33BA253
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200828; cv=none; b=Eyg+JDbItRY9Ku8Oib0ymh7tAqo58naSHtcYXXY0myC0aA7Zg92g7yVODnEa1XG0sOUCt/3dp3jcRHXJBG7ePqyFtzBwWye43S8oLbLnJqAExfPF4T5VWN+mI4/ppoIvsu2yBRKSvq840a23qkF1Y1FiNOMOiDUi3w6/Fg+PSmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200828; c=relaxed/simple;
	bh=EXUbPBa7rv7rs1r8YW/fmhj7HW1HR6AkwNyGcZQYoYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrWSSUh+DlxKbUKZRznPsmZFhNRmYIaGXjbKwK1Ah0EsAiK5q7ZaItl0jzeyfLyTBa+dbVcJSC9xVfOEeCUun2rbmugLl7JzwlubV3xXSqTasXQbzf8OlLPOoMN7oVZKNjttkDu2D8f1xy/C5vVMLC6lAeCtN17lETtKmV8vU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdXRDIyJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdXRDIyJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84347ad88edso4537770b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 00:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782200824; x=1782805624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOXvZJIgT1xf7y6r5/ilxE6ikYQEvsUFg4mACphcji4=;
        b=XdXRDIyJHEjxfZsAzZHVsRNjQDJuhfJ6nqme5Hljet4p5LFK2JgXNAhHynqoWKJrOO
         jgyZK2tOUYnfcRNjfXi6sPN5ebMas5SkokjFJ2yU289jm9XmuIKWxSEY1Pjcjkf0tfXz
         u+PsqneDllE+fMeF8675v2Aa3XSLAHseZDxvf3mWXmCCP4oIOTlSf34UZ/wmGqrWA3fu
         OSNiCJCI6paaWKCcRe918BymPzzY6toOHWL192tjqfDww5/oEP2FubhdQk6/nVevrKqD
         TzZsnsHDhtFw0IMF6OPYQH/rYpYsAbi/T6ZGQC648FWk5D2/dPIWwDpTpiCDsKf2qgPo
         +tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782200824; x=1782805624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOXvZJIgT1xf7y6r5/ilxE6ikYQEvsUFg4mACphcji4=;
        b=NN0+a25g8qkWW5rEnvgy12dLONNsrzfskiEt2veW4itWk7wm8ImsHul2+iwpPPCrI+
         M8ottkJkGJl3F8x9WO+iAHv7gGW46BKyRB0wRGIMX9+h6eyj+TBVhwpFGGMTLthLxoN2
         p8+jchHD86ElsgGbCMhq8SmVfkPhg2PN+HfWgycRYbAUUkkCMOgaHkQQa/k5QK4Umodp
         LUkkX3UcZ5dNQPFnMtPCpHcHGpcR86Wc4UCPWjDqwWzbOa4OAtiDDRczScNT0Eo/1yxq
         iNyPisiaXYhdry36+cZlZIdFi3vh9cMRywm1awjXsCVUFy1llOrA15lMoOCh0EhjYS5a
         96sg==
X-Gm-Message-State: AOJu0YzSnr2CjUncN8uu8QZ4mKSUHITyjnOCdTyeEuDz+oDhWYUT9iX/
	Rw1ZN6DKJV+qTspb77mhWgssOXtOMpbt3UYV1z1xu3l8cduUqwRbl0Jg
X-Gm-Gg: AfdE7clC44yNodwzNtTuYhTyMdFfA5KayCTx2bqte/6ol+JKheq9LJT3LcW7iub4kwa
	CYmg8cP6DLypzFzUBZhgiGer4EImjpVb+/nIXzO3BtEx9+TPgYDwkDTE4cpQhJs2XCG2ll6coPz
	rcPP/u2TzIWQrCQe+N2059px9S7eAANb5JCU9Et5gnx9XAzXe9ttAxkNVIUIhaeusxpo65z7nvI
	sXlPP1jZFS3XtZH2FqYcuGRRP6Xwl9dopTjhkF+r8vx/FB9Qex045pbtEDV8o6DppDLQT0NVLKu
	H9DhAWVoqi0ia8yiDJtGl+vrTk3xEPXGjJ597EkmjgXqznto3z4AVxIvDIVpWvM2TOukjv3T4wP
	pKqkHWmOdfJqSmsNYNpYrHiPB6qQSPZwidya9evD5H+slxwObKAy7F3lSpgbz2/O5pTaVTyCpTJ
	0ksipgV+hMC0w=
X-Received: by 2002:a05:6a00:3e21:b0:841:69e4:f21b with SMTP id d2e1a72fcca58-845508d3c1fmr18398996b3a.39.1782200823739;
        Tue, 23 Jun 2026 00:47:03 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564d8f1a1sm11063117b3a.18.2026.06.23.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 00:47:03 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yixun Lan <dlan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net v2 2/2] net: stmmac: dwmac-spacemit: Fix wrong irq definition
Date: Tue, 23 Jun 2026 15:46:35 +0800
Message-ID: <20260623074637.503864-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623074637.503864-1-inochiama@gmail.com>
References: <20260623074637.503864-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current irq definition of the wake irq and the lpi irq
is wrong, replace them with the right number and name.

Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
index 3bfb6d49be6c..322bdf167a4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
@@ -22,8 +22,8 @@
 #define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
 #define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
 #define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
-#define CTRL_WAKE_IRQ_EN		BIT(9)
-#define CTRL_PHY_IRQ_EN			BIT(12)
+#define CTRL_LPI_IRQ_EN			BIT(9)
+#define CTRL_WAKE_IRQ_EN		BIT(12)
 
 /* dline register bits */
 #define RGMII_RX_DLINE_EN		BIT(0)
-- 
2.54.0

