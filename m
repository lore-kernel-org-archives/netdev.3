Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A03FB7D4;
	Wed, 25 Mar 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456172; cv=none; b=lpWSkMwJx9NhOU+ccnDvlC3IFCnOaDwaEBB/cM0n4KjMnbJLQ8+LMaMPJU79ua4T8RWKgwmpaUNUKbDxPe599yB/cgbls2SOe2c878jE4Q6BdjPvNZEwp0rUKp7SDhDZAFmK+z5oXLiWbYHJhzLsTjPKlkNTEi+Zyi21AC15cco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456172; c=relaxed/simple;
	bh=MCaDxoDiVDGdtO65h0jv11dtwY7d5m9e6N7qyqE+O5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfeuM7MeNOl0Rg7iA3XVpQuI6LvLTmCs98bL/e/wzk2vjiny0gtdzmmmjM8x3AfKU6IRKnWJo7FXDPrvPFEyTXj4TFJOkYGLPZBvhPdPXx/xdGuSV6Q5mN0kv/iDbYWSKJ+D8uEjAG9avgVBvu09ZDTZPLIBYL5hU5u2p8vQSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw3YZeNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw3YZeNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF43C19423;
	Wed, 25 Mar 2026 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456171;
	bh=MCaDxoDiVDGdtO65h0jv11dtwY7d5m9e6N7qyqE+O5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sw3YZeNRAlld5uS8I1piZg3WRSBgcQg+Hj5TzOdmBqklhlTgd0Z8WxcaRcctPNR4T
	 YtgWw9WeQVKjptA/Pw5dt7LW68xH9Npol2pIXqbazM8498WyHZSpzu1Rb4ebSmUV5b
	 yoXfOzJ1hAkNpeF00MtW9osNv6yWMigBvez09IrVlRk+MgkqcrsCSFAx+K5qL9ZsKm
	 XgZNgbWq28IifnjluiW2wqX+UfORUtaSonvokMGWso6NUcEOSlumL2UrUxSwcOJ5dg
	 tfccuLqhCBe6mcQxqpb+kWtSPLMeP832t9LkDdCefPg/yu6HDwsWKfwKst6YFsXeMr
	 KHkNbH47VoSkw==
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
Subject: [PATCH net-next v5 07/14] net: macb: add mpfs specific usrio configuration
Date: Wed, 25 Mar 2026 16:28:11 +0000
Message-ID: <20260325-excavate-jester-798e7cfe02b5@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Szw1FnKs8om3BmObDQ4lrRqwtQtqKNPlW7gKJuQIDEo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM1ar3yeudJx0t3wogYZTYN76RGRDNL5yTyv1jdNk l8l/smlo5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNJ2cPIsJjrt6rrA/Yb1QKJ 3xISmVcvfq2/Mj1+a8KC2B+njV1X2DH8Dy7OP/XBZ9PLWkV7jw+nXk66aNZ4bv/fx3opt74fE3c 24QUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On mpfs the driver needs to make sure the tsu clock source is not the
fabric, as this requires that the hardware is in Timer Adjust mode,
which is not compatible with the linux driver trying to control the
hardware. It is unlikely that this will be set, as the peripheral is
reset during probe, but if the resets are not provided in devicetree
it's probable that this bit is set incorrectly, as U-Boot's macb driver
has the same issue with using usrio settings for at91 platforms as the
default.

Fixes: 8aad66aa59be5 ("net: macb: add polarfire soc reset support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1bdbe66b05590..8e5305f9a7545 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -788,6 +788,7 @@
 #define MACB_CAPS_EEE				BIT(25)
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
+#define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(28)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1229,6 +1230,7 @@ struct macb_usrio_config {
 	u32 refclk;
 	u32 clken;
 	u32 hdfctlen;
+	u32 tsu_source;
 	bool refclk_default_external;
 };
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a1f8a6d9554fb..4e5967e6ffbe5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4921,6 +4921,9 @@ static int macb_init_dflt(struct platform_device *pdev)
 				val |= bp->usrio->refclk;
 		}
 
+		if (bp->caps & MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE)
+			val |= bp->usrio->tsu_source;
+
 		macb_or_gem_writel(bp, USRIO, val);
 	}
 
@@ -5524,6 +5527,10 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.clken = MACB_BIT(CLKEN),
 };
 
+static const struct macb_usrio_config mpfs_usrio = {
+	.tsu_source = 0,
+};
+
 static const struct macb_usrio_config sama7g5_gem_usrio = {
 	.mii = 0,
 	.rmii = 1,
@@ -5637,10 +5644,11 @@ static const struct macb_config zynq_config = {
 static const struct macb_config mpfs_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
-	.usrio = &at91_default_usrio,
+	.usrio = &mpfs_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
-- 
2.53.0

