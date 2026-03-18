Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE893BED06;
	Wed, 18 Mar 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851916; cv=none; b=BVjUV2iM4+5DT+V9DzMyx75cb1U20en2H20ODaDIYwDL34qmLWGomgZSY1s759yW4IPxOpYm1NEm3n9QqweBwVDxmq+lHDYRG0IlmdBDKlvq99Ply0jKM+TG5Eg6oGd4elnkV/BmyeDRhiSBYcC+YNQHjgcKQmx/CLQbqRKwjQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851916; c=relaxed/simple;
	bh=l0HWcNcVkVo9YLSrRqspDdP84/kdc2LHA5rpvVoVGqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/Tpt1qlHWCk3r0Xt+dexFaC7P/yZQdODdE7UmG8uyUoY7C0Xjq+ra7TfkdDKnONXssIsoMu7wAc1V56lgyob6hGlAFO/zCCe1bNvCRH5BOjJdTiSJtaN7gmEjjgf6zt6JNogumZ+3uOrOHzdwAjBiX/9lfuzT+Rj6zAu255d4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkLHLtID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkLHLtID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE1C2BCAF;
	Wed, 18 Mar 2026 16:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851916;
	bh=l0HWcNcVkVo9YLSrRqspDdP84/kdc2LHA5rpvVoVGqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkLHLtIDUQIcR2f35rUx0ynntzvhUqWnX0VejtaIQfCBp4uwxqQ1L2gf0dpXF6/Nn
	 tdtHZHVK/kSEZidI+iHSEtDrAr6jOKAtyqiglrDAXxosW+Y8GM4pJVK+5uE122EztP
	 VbowwyDnuUwuiuGl+ePXAURXYRyxLk1aRZLijSNvbnXRn0lKyhqUswGOZDaNlvyoxi
	 FNOU51U0197+BQJB3uW87xqZpwxdva29it6s701LUCrH6sAOIRhsUjT+ccW60PHT4P
	 T/lnJyPZAIZAnpjcdc0PqTOtByr5xiqQYAl5/hW1vJSvjCOwFmKwmatgO7toRd7zx1
	 Z/4yzhyu5yRGw==
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
	Ryan.Wanner@microchip.com
Subject: [PATCH net-next v4 08/13] net: macb: clean up tsu clk rate acquisition
Date: Wed, 18 Mar 2026 16:37:39 +0000
Message-ID: <20260318-doable-precise-3952562ac964@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=pBzsAzv0f5XjXC1axq0Olq90oNiYo0A1zmrCQdWDjrw=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rlzaPCHYT3DXL+nzPRp1L578ODU9dFqEkpHUg7pZW 3+6iEmqdpSyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiQWyMDL/SrsSz9T8oc/Lc 7HJvY+iMe7WfxMV09uQYTFhvHvfwrxUjwzPZqDVn0o66VF1PSZJJeO+9pSupqnWDfOfCl4461s8 u8QIA
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
index 6b37598ac57cd..38e75c2e097bf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3527,16 +3527,14 @@ static unsigned int gem_get_tsu_rate(struct macb *bp)
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
2.51.0

