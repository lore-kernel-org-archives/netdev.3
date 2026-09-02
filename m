Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FE407563;
	Wed,  2 Sep 2026 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338848; cv=none; b=HNPOUxcqpri3xUsvZxmzLEWw7mRntzsSAqruwhmmxZ473E48vG1fKS3hokGygEwh1V63wqRACrBKNU542XdJ2i/u8eSpqJm3rklV4P72qcv0XXJd+G5GXeF0lJvn477qVHtTXG0EsnnlsMM78AWXv+ZrjkYhNC/gVqMgGwh9Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338848; c=relaxed/simple;
	bh=FJztA2dI//Yj90jhc8DfU7N4OGjw/VMslofrOnrUU2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZwzNRRusWD4AMCLTPrIRxXzIIsuqCraAe4kld8T01XhVc/RkKQ0d2TY2fgHdTlG9QCF32TfoxXb9dwXSU2DmeZSPQJgQJpCIRMV/24+BGwO7jExBPSPCtp+meRuPbollOLI3zWsMDGxsMKJFmaAX7T5BhgbWmFeO1Crt5ljJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=aU0cUdZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ocNdCL5P; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="aU0cUdZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ocNdCL5P"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 76114EC00C7;
	Wed,  2 Sep 2026 04:47:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 04:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338846;
	 x=1788425246; bh=eHUolKWoGc53KCB8pHoRUBfxoy8S27gEX2vWdwF1i7Q=; b=
	aU0cUdZV4hmRZMS3nCnsl7KnBDlCWheywKZmgsfOL2oe3TP8W64TmVLNE/ArtRVl
	mS6KrbjiL1ALrIVc4lHgKdm4jxp0QLYSo1KwlCX+YFWHcfUfYeEcHYS3Rm3T/AZX
	V+QClo+oxwFiJyEBdtBGjp3PzUUwv9CDQ+uU6aV5rgBo/DiwdduUGT1aG9BBsojK
	LFMbXPIr1+NFI3BCniO4rxeHp6EU1Pqt+oedbhbZTBZrpG0qJTiSW0cuS/5hrtc6
	7yIDUGLsAhhMGcPYCiq+OZF1dTepq1wC6Wkx7owagzX/IFeOPSRyUTTRLDjqdogS
	OXh4isKWjTVcOVdu6qIBRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338846; x=
	1788425246; bh=eHUolKWoGc53KCB8pHoRUBfxoy8S27gEX2vWdwF1i7Q=; b=o
	cNdCL5PdAuwv3xehju1mcDwcw4GFm8N2buRCKV64lp0HZVr087dYw6er/8JZsk7T
	sbnL/BGk/sQgL9XDjBgAloHNOzQqhqieIFz9pSxFLjNn0Lee1h47LihwD8GD4JYK
	u4oqtfS2MIwv9eloFjbKq6pl27Yff/fHwa3SngjX+Kq77K89o602wQN/uwULBlRy
	zk4V0OkaLYzcLPYvX4a7Vbp6r6jioNZiNjXYvw3S3nvUTbmyf/cJ5nMka1uOjEYo
	6ntOaO2dX4m0Ds+rS+tgfeWrnejctvvqGJyIAku4MspGeCQEPrRPXFGlz3zXRgpb
	JDmcW9yS5zaM76VKvysCg==
X-ME-Sender: <xms:nuKXarxM1JmDMHiMg2gKZ64Pq1tjvi5SgP-7udHKz4p_emTvZk9fkw>
    <xme:nuKXaoyzREzVrnpzMM7VhO-mEDqSLQVX2AJy_W9llQpNyUroJslz8CfqgMALEt11u
    TAyDqA_nxPH3escEp7SXDP6qmRwJRtbMhUzPWJZFeSLTLH5osxT_1IH>
X-ME-Received: <xmr:nuKXatrRuoGpkVxYMqkaQW_5JZrjraZr-oPBlJ2gZiM-uKFcb5IX1TShMPhZKGGzs6Lo7rJpwgbsBrgO5oS4Jy2zD72BSdo>
X-ME-Proxy-Cause: dmFkZTErXYyCsZzfm92YrYcrxv1EBH+3gGzXCytSVYtChsjw1I8nxza/1mVbG06NescpYI
    ijrlhm4QUzIjE1Ta52G1XvMSZ4UmT02/e9XVdS0BTzqvoykuwFxy/egHwAHuIK5TsZWqyr
    6u3rd2F6xKDzPh6I7UI5M2Oxx4x87Ag2ZZpCVRRu8f911TqF5Cy2xNLpzpgkOb8q9nX6ps
    mmiA5czZc27unSRsWpixJ3qrm7f3jL54dMR58K8niQduWDuh5XpAPG0F+2ZvDE1zMXgnik
    DNhL5F/TPATp8CRF168TAMl5+ifcCsryg5QvKT3wCd71cG9Vzl3KCg/O1spMcDB+VjotKG
    GRlYkMdfqmte5NcmCXsIr2CONWQrVU+J8TcU3q5/sHrKICYlgzk5zHcN4zq3vYXhKeSggT
    7beR10IMF3tSlbp4zbz7CYIkLU9o8NtPKsLd4c70x06RUaR7Q0PUic6Po6lu1chSn5C/lT
    qeiYfVRD22sl+e2MAaF93kUyJorxvFnE6F2IFt9kiSzybhv8vUpUobINXz7S3+PSzwpNgs
    KAXX+z56nG5Sm+NzLy4khN7C/LN9A7PneVCrk04R/H4awAuQ27VVbFaYZa+gnWFR4ZTMf2
    G2KFe6edQ6CcRJGEjiN6TgAorxTDHwKq4Qa7Dbix6h06mc+2FzGvoZBLuR2Q
X-ME-Proxy: <xmx:nuKXajn1wzFQX0OoRiUKZXUAUcoFfdQARH3WWbf7UqJbCcANqspJpw>
    <xmx:nuKXauxVQ8G71owVKVusxV2Pr2Ojz-guw3WMRsw8kW_BTDUKkmoUrw>
    <xmx:nuKXag2nE7xT4VdOx8n0Tvhp_cIZsh2nevnPN6X-xUVe08KtYtxhqg>
    <xmx:nuKXaiAsUxdQ5wD6Xa4PcWHCb1iX1W6NaSH_NFu--tdBFDo-doDo-w>
    <xmx:nuKXaiI7jc4CGLHgrNNA-Dgl5ZKdN68TshhI5ICxIHbZ6DhIUmckveZQ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:25 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v3 04/10] net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
Date: Wed,  2 Sep 2026 10:46:57 +0200
Message-ID: <20260902084703.3228504-5-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is no need to explicitly pass the struct platform_device pointer
to ravb_ptp_init(), it can retrieve it directly from the private data
structure.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 3ee4c6108189..aa45f5466001 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1163,7 +1163,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
 
 void ravb_ptp_interrupt(struct net_device *ndev);
-void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev);
+void ravb_ptp_init(struct net_device *ndev);
 void ravb_ptp_stop(struct net_device *ndev);
 
 #endif	/* #ifndef __RAVB_H__ */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2d0022a4f85c..e44d065f77cc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -713,7 +713,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
-		ravb_ptp_init(ndev, priv->pdev);
+		ravb_ptp_init(ndev);
 
 	return 0;
 }
@@ -1968,7 +1968,7 @@ static int ravb_open(struct net_device *ndev)
 
 	/* Initialise PTP Clock driver */
 	if (info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
+		ravb_ptp_init(ndev);
 
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 157fb78209c7..f70b616ac847 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -313,7 +313,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
-void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
+void ravb_ptp_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct ptp_clock *clock;
@@ -338,7 +338,7 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
 	if (IS_ERR(clock)) {
 		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
 		clock = NULL;
-- 
2.55.0

