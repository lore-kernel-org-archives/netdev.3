Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A23EF659;
	Wed, 18 Mar 2026 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851927; cv=none; b=n2q19E8UqF5ExXd5gHMf2UCNa0tpma3nEf70cMGYvdZjaBhWvXbwlMLawPhk2v/gQs5AoS76MrvjWlNIhfJxAQRRL7Qv2sLfnq5SGhR9yYaQujF2NKIcWKZLmo2yLYL2DmwCqmyO1V6l+FjV3xBYyYOQcVr6WGKyUyULhJS7Mc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851927; c=relaxed/simple;
	bh=9DLc73kRovjX7PmKOfMC6v7DvLF8VkwF6ivlc5RlT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9dJFPyE3z3cEn66MIyLlL5OyTO+M0cH77kj6zQUh5tHZQrNuv0pVARG/bVaBoWVZZWoJSc1k/+9ZyXYexo+4/mPCbBmgkM8qoCScAbKjMlm4Anm9qvyjxm88NU++ai5ElQB7mSMhSGfU9OSR5auKggzGaWP87E5Nd/AfIXmZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIOHMbPJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIOHMbPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC3C19421;
	Wed, 18 Mar 2026 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773851927;
	bh=9DLc73kRovjX7PmKOfMC6v7DvLF8VkwF6ivlc5RlT3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIOHMbPJf94NLNUV9jBhDq41CqmoAepK1RX00vXTypZdd1Gf/FXdTqWm+vWLDl/Dc
	 z5HZrY53xhay2S8W2IlAc42Oprs3LMHYhN1SSKUmrLI1+Qtm/9frgSpmvy2NsH2uw3
	 HeUtp/DW4zBd/LAMS1FqxkwOnm/tmY2Sw8+jwQghQxKzIUmv6fa++lojdsEtg3/Xjy
	 lg0i3TCZ5CTPJWplenL3FZsND6BhFUW+OW/DdWh2qGd3hWlcESXSPOxysSu7XGBqz0
	 5WJU2rnPtXAd/v05vFNmVtOV/1M/OxHRzOgmeAulaENRNxEcw8u8QXvRhaCVlIJfU0
	 tONegjVjLtA8A==
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
Subject: [PATCH net-next v4 10/13] net: macb: timer adjust mode is not supported
Date: Wed, 18 Mar 2026 16:37:41 +0000
Message-ID: <20260318-armless-generic-9845d484aca1@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318-surpass-puzzle-f94b46aa8808@spud>
References: <20260318-surpass-puzzle-f94b46aa8808@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=OqQujPb90kYRx/KgLbRe0CGbTbZ7JG8YWaMugKJ3peY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJm7rlyK+v2e34jRK2GFxczui4m7r0TEORfH88Rvk5v+P OhXxxqPjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEby/D/9Km8GvK54x0bmxi OhdTdYFlt3b2B7XkFq4j57JfmAk83MXwh+f2hZZnh3OtsmtMv9vueLa9saIl62WFk/cDw6d+M+c EsgIA
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
 drivers/net/ethernet/cadence/macb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 38e75c2e097bf..3e0ab23e9b9b0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5577,6 +5577,13 @@ static int macb_probe(struct platform_device *pdev)
 
 	bp->usrio = macb_config->usrio;
 
+	if (of_property_read_bool(bp->pdev->dev.of_node, "cdns,timer-adjust") &&
+			IS_ENABLED(CONFIG_MACB_USE_HWSTAMP)) {
+		dev_err(&pdev->dev, "Timer adjust mode is not supported\n");
+		err = -EINVAL;
+		goto err_out_free_netdev;
+	}
+
 	/* By default we set to partial store and forward mode for zynqmp.
 	 * Disable if not set in devicetree.
 	 */
-- 
2.51.0

