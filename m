Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EDE332ECC;
	Thu, 26 Feb 2026 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103849; cv=none; b=t7aJzdkj3q0/0D3NuLXNdyJzWKDoe5r72REuGQKLcxB2ENN0zw264Y3DhY+dImHKLDT2YahI2ZD9zetMEctfEauRGSGbivgVPAjPI1ea/zgE52vmkcIsIPM2n9KIDTj8KT2mKuIUSU0PGo6unEkZ8yPtSW25gubasvVYluUJ/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103849; c=relaxed/simple;
	bh=eeYz6zI8m7LMZepqFrVEA7MQyer3DvTEMH8GCtn3pmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkjKabwNgCM6erDohXK6Z0i+8F8C8WJ/akBJxPaiPJ3+jCflE5Xjzx+ZJOuwWfrEhqi8EqRejxx6khc1GqOGyl8vzH/kol2A8YwkhCdbwB9CR2u/J894yAmGAKeBBxaFVyZz8OMmZV1m0eW7FIKr5kMM2z1MdcDnAbVs4GF0CZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoU8M3tb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoU8M3tb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC113C19422;
	Thu, 26 Feb 2026 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103849;
	bh=eeYz6zI8m7LMZepqFrVEA7MQyer3DvTEMH8GCtn3pmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoU8M3tbmKgO4ru/+HbIjF0dJZKZwCsfpCcEULrgHAHMfAjUrlbT2LbzzwQwo9PdQ
	 UkEy4TwZX73nGKnP57QUrzk0KOYyRNPjn2gKfnqWHPKTcBdV4jiO7CQMt36E22wRvF
	 9wa5NJESCGPU0+XBjAwl+ElS2KPvyBpby7qaSsENMtZpWk4wmmu/q0HX+CNLIJnScN
	 JgaAMx3mPIHo1s2XfBcwGnmkOcN4vYC5nwAPEjZ79tAExtDW9rskZbv/swUdJ2aveX
	 YbklJJh3/qTRXVCS0WUYgzLLPAuEOV0iXzqVQDxuFivrJ2XCRVbv/t0frp6pbIInxw
	 7gun6YIW9uoBA==
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
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 5/8] net: macb: timer adjust mode is not supported
Date: Thu, 26 Feb 2026 11:03:20 +0000
Message-ID: <20260226-dollop-maturing-9e3c83192ee5@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226-snowshoe-amusable-6716d4ddea11@spud>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=KRrduA/pCBBIY5BCiuiQyuvVljzb1F3SRIwOIkFLtvg=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkLNMqn1wXsTEopsHuprm2yJW2yfGLGgY3d109kRpRmm RzyaOruKGVhEONikBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwESev2NkmNoYsPpnlInajFud /66LMaZ+jl6rc+6A8owje/00lIofZzEyvLp65MGOr97211dU6AvLXD5TzzY94tSkFxt3sxVb5vD fYwYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The ptp portion of this driver controls the tsu's timer using the
controls for "increment mode", which is not compatible with the hardware
trying to control it via the gem_tsu_inc_ctrl and gem_tsu_ms inputs in
"timer adjust mode". Abort probe if the property signalling that the
relevant signals have been wired up is present.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ddbb0c327b303..fa55e6e7036f2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5535,6 +5535,12 @@ static int macb_probe(struct platform_device *pdev)
 
 	bp->usrio = macb_config->usrio;
 
+	if (of_property_read_bool(bp->pdev->dev.of_node, "cdns,timer-adjust") &&
+			IS_ENABLED(CONFIG_MACB_USE_HWSTAMP)) {
+		dev_err(&pdev->dev, "Timer adjust mode is not supported\n");
+		goto err_out_free_netdev;
+	}
+
 	/* By default we set to partial store and forward mode for zynqmp.
 	 * Disable if not set in devicetree.
 	 */
-- 
2.51.0

