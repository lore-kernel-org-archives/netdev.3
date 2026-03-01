Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490EA2C21F2;
	Sun,  1 Mar 2026 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330030; cv=none; b=doylR8jUOjKuMe/goi0sGS1Qj8P/4+TumBO4fRg6i8eZZpO0qzbpsv61XgPvoCB0CjmIOCGgtinK09btUUXwTN7Ykku894UQ5rhsc6HmGsSVj9xIG/8tQdvx3BrROLtc2ZShmme25WUXnOfpF5oWAY+EVEHfovO0ndB1YlLb2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330030; c=relaxed/simple;
	bh=tU83mg14wxZWjnXUfKEv83yCfZxM4LKLY9c1OLpO47s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ2DX3sLDPvrI6ntuo05zp62s9iKApcrkahQ33vamsLLme+YXeqXRJYOB7pahlRf42OuvzDoBdc2MafRZaAPMnBqFCWz+GUPdg6gWDSZEV4ah3JoBfxIHTisUJk1ir36LBS0AUudA6W/p8TTRFhJB2s2itAzwJzE8qwHCTlATuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuZHyJ/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuZHyJ/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5075AC19421;
	Sun,  1 Mar 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330030;
	bh=tU83mg14wxZWjnXUfKEv83yCfZxM4LKLY9c1OLpO47s=;
	h=From:To:Cc:Subject:Date:From;
	b=AuZHyJ/O0ZH83wVGBBRSQC/rcyKAOvUJ6aTj/uS2UUiUA1zuB+ZwE+d+EfNNMuOtb
	 1/meZ14tea/eUGpS/il8UTrDSrmLt56MXZ4nmfamksX3Kflo18vIN7+bl5R+PG7gB0
	 I3uj5IKsVHNjbTrrzZxcTaTQIbGFwPsOPvwTpdUd7V/TFFJjxVo3UP7zURvwZZpcO7
	 ZDHDxN/g2eleDcJMv2Q9VerPPh88ulfcgnx8t0kYFnTjYQukCS5mnBnRL4j3OLZNPs
	 WhPS/3CPsa5kv2+9bLhyfM6NTe/q72rWKP4C0sdWlPN7IBhvSRLulaz6dcocIRxuUo
	 eAqIL4j3ItS4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@kernel.org
Cc: Hongliang Wang <wanghongliang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: FAILED: Patch "net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:47 -0500
Message-ID: <20260301015348.1720657-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e1aa5ef892fb4fa9014a25e87b64b97347919d37 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@loongson.cn>
Date: Tue, 3 Feb 2026 14:29:01 +0800
Subject: [PATCH] net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz

Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
Loongson STMMAC use 125MHz clocks and need 62 freq division to within
2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
to 100-150MHz, otherwise some PHYs may link fail.

Cc: stable@vger.kernel.org
Fixes: 30bba69d7db40e7 ("stmmac: pci: Add dwmac support for Loongson")
Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://patch.msgid.link/20260203062901.2158236-1-chenhuacai@loongson.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 107a7c84ace80..c05e3e7a539cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -91,8 +91,8 @@ static void loongson_default_data(struct pci_dev *pdev,
 	/* Get bus_id, this can be overwritten later */
 	plat->bus_id = pci_dev_id(pdev);
 
-	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
-	plat->clk_csr = STMMAC_CSR_20_35M;
+	/* clk_csr_i = 100-150MHz & MDC = clk_csr_i/62 */
+	plat->clk_csr = STMMAC_CSR_100_150M;
 	plat->core_type = DWMAC_CORE_GMAC;
 	plat->force_sf_dma_mode = 1;
 
-- 
2.51.0




