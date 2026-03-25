Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C083F9F56;
	Wed, 25 Mar 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456183; cv=none; b=JoENjfGEIYJnRinLfbKz6LE9Inz0boQvSwQbTEisEXxDxmTb56ZQM2dX5sjbxhzafJsbF0piJT/VHv/fSKW021NXXGfAi8cSLSG5I+bg4No2DEfn2tCKgtV5Oe5/iBTdtkXFnwzvpu5F7Bs4G6aJ8ht0f1+MtQnoOWgs8Mec7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456183; c=relaxed/simple;
	bh=ZcOLtYKae+2Rnp55wBNFsnZiamfl2XYukwL2390q/wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbA4dcQr4hyNYkachgvVM8eM/7CA61DKv/pg5gKc3ZFYiVd8TMXIrg6Ean6u6Q+zTqFG8JH9GGSDqipmxFY+uV3SNq3bfhBX1/P09IEecwYf42GHjKyixRSnNHp1d1p+edoOSWuWqe+va3BtzJbZPfObQMS4bJkajv05nxpFXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFWY9/5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFWY9/5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97043C19423;
	Wed, 25 Mar 2026 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456183;
	bh=ZcOLtYKae+2Rnp55wBNFsnZiamfl2XYukwL2390q/wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFWY9/5dsndrjfbk/fjs64LRLg1pisMxM7P7TPkrZ+U4y41CIYPTq6+488nZZ2fTn
	 ApzzTvu3A20vz2lnxJN74G9IlOF2tsDDUqZeWcspwDEVKnATakD+nKFXXe1EdaTOQs
	 RESmmkhtNz01CaG7ybFWrK+yxc2mb3eE8R7XfG69uCtUnPiUUlPZoeFcvIcXbLSAqI
	 XjmoyuFixhIi+SMqpp8pZCfWehlBirF+5xl6B5Flx0kbxhl/kTSHASZ3igtP8eZSD3
	 jQDFxmGlEQvDLc2IJR5hXjlCf5FBRpUPcIHXD7jiA4gZEovnsPmjj5kid+4g74wkWP
	 Gm4FbttoWS3Yg==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 09/14] net: macb: clean up tsu clk rate acquisition
Date: Wed, 25 Mar 2026 16:28:13 +0000
Message-ID: <20260325-hazing-penniless-14ba803efbb6@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1kpPbARU/zhfeCpg9eoWhZjN9mLcjx7s+d9CyHanEvo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM3uVv9uXzfDNupG+jIH79Oz3R8ezfWZ2vlPSLF0n 3b1xtYdHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI/FdGhtZrJ7nDI9ymXrHf Ux629OeJP1veJeS90AgvF3w2qVGfTYLhf/Q9DoaXU99P/Meq9ot3n9lOs1D2b9s0vx4LFeO5NG9 lJisA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

tsu_clk is grabbed during probe, so doesn't need to be re-grabbed here.
pclk is mandatory, probe will fail if it is err/NULL, so there's no need
to check it here or have a !pclk 3rd arm. Simplify gem_get_tsu_rate() to
account for these facts.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 492abe1e33b3a..b28fb771e03ba 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3765,16 +3765,14 @@ static unsigned int gem_get_tsu_rate(struct macb *bp)
 	struct clk *tsu_clk;
 	unsigned int tsu_rate;
 
-	tsu_clk = devm_clk_get(&bp->pdev->dev, "tsu_clk");
-	if (!IS_ERR(tsu_clk))
-		tsu_rate = clk_get_rate(tsu_clk);
-	/* try pclk instead */
-	else if (!IS_ERR(bp->pclk)) {
+	if (!IS_ERR_OR_NULL(bp->tsu_clk)) {
+		tsu_rate = clk_get_rate(bp->tsu_clk);
+	} else {
 		tsu_clk = bp->pclk;
 		tsu_rate = clk_get_rate(tsu_clk);
 		dev_warn(&bp->pdev->dev, "devicetree missing tsu_clk, using pclk as fallback\n");
-	} else
-		return -ENOTSUPP;
+	}
+
 	return tsu_rate;
 }
 
-- 
2.53.0

