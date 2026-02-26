Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383582E2679;
	Thu, 26 Feb 2026 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103855; cv=none; b=k6cWAFs3fSo3f5ecmlHGNTm57DImTzjarXNQx+72BQpNxhG8TvnM0jrf2aZxmEWbYjNxeLtaz1za6oOYhmktWoAUb3DiHIeoyeVGJ0zHah0/EAeaKeQC55UN75/6CwKu3aji2OEpytCDqT1oQNMUDIa1Bxw2Z+wHzrFue3zs6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103855; c=relaxed/simple;
	bh=i7L/N76H8SB0KejhBMqYjBa0HiXaFQo6XPzbFFF6+Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5kPwr7Ex79VWkAVhZem+R5jEgGgG+zBdkcTh9q0SOoS6qVuDXfWZTxApV2voBXnIR1zijaLTMQBC5BAHLJqyhvs7UXW1zX5Fj77/wXd/ahvx/XEsc2XX0QkYnuC6kCvT1JFrk62J2zRcKMssMnaIrMHkJ1Qpy1Cjgd5PFAcAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlfX5CKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlfX5CKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72316C116C6;
	Thu, 26 Feb 2026 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103854;
	bh=i7L/N76H8SB0KejhBMqYjBa0HiXaFQo6XPzbFFF6+Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlfX5CKcvedHtyZUcXQLbYGcbh4Rf+Os8zmh368uAo0M/wtRV8FRZyM90hSKvWFFR
	 zmf7U245riwqe3Tp1jWRR+0wIpKTocJkDse9WjCdDjdaxUIse1VK909/nawqFtFJvz
	 pF88dKuKoBPeawBscU5pV9xSzrw0zE5Be/kZfog4k5DlLfsDlvRrMv3TsrXR9qb9Rb
	 iV6efiqsdYGSnI5zwkiJ+Hl723Wai8eC9gtQfY9HvfwLOx5LXvDng+Kaqngs4M2Ln2
	 GvltaQzcmZRIBsLrs8I18HJAFzNuaLKd03PqT1/p5tb2zzWj7J56Wizg+Shsc4wl8e
	 8X7XZCgHvGi9g==
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
Subject: [PATCH net-next v2 6/8] net: macb: add mpfs specific usrio configuration
Date: Thu, 26 Feb 2026 11:03:21 +0000
Message-ID: <20260226-undergo-aim-acae5e1ce48c@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226-snowshoe-amusable-6716d4ddea11@spud>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2699; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=y91dFQ2ZoMKWlp5ZpGzJrrZ9hbr9du1y0KV8vMwT6Rg=; b=kA0DAAoWeLQxh6CCYtIByyZiAGmgKHijYtkcyQ1V8ITW/d/e2iNn8sIMpKNOvHc9RmD+w+r05 Yh1BAAWCgAdFiEEYduOhBqv/ES4Q4zteLQxh6CCYtIFAmmgKHgACgkQeLQxh6CCYtLmGQD/ch58 9M29LIDrXKybkOm8p34mRdO86b1FvCtbIpjX+a0BALqqJgAbgptyFPM3NL4rQVEjgVxqBOdTrkz ftJgIhYkC
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

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8cb0b3778ee9e..04961658a21c2 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -780,6 +780,7 @@
 #define MACB_CAPS_RSC				BIT(23)
 #define MACB_CAPS_NO_LSO			BIT(24)
 #define MACB_CAPS_USRIO_HAS_MII			BIT(25)
+#define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(25)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1212,6 +1213,7 @@ struct macb_usrio_config {
 	u32 rgmii;
 	u32 refclk;
 	u32 hdfctlen;
+	u32 tsu_source;
 };
 
 struct macb_config {
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fa55e6e7036f2..ca141f8935d48 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4626,6 +4626,9 @@ static int macb_init(struct platform_device *pdev)
 		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
 			val |= bp->usrio->refclk;
 
+		if (bp->caps & MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE)
+			val |= bp->usrio->tsu_source;
+
 		macb_or_gem_writel(bp, USRIO, val);
 	}
 
@@ -5220,6 +5223,10 @@ static const struct macb_usrio_config at91_default_usrio = {
 	.refclk = MACB_BIT(CLKEN),
 };
 
+static const struct macb_usrio_config mpfs_usrio = {
+	.tsu_source = 0,
+};
+
 static const struct macb_usrio_config sama7g5_usrio = {
 	.mii = 0,
 	.rmii = 1,
@@ -5343,11 +5350,12 @@ static const struct macb_config zynq_config = {
 static const struct macb_config mpfs_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP,
+		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-	.usrio = &at91_default_usrio,
+	.usrio = &mpfs_usrio,
 	.max_tx_length = 4040, /* Cadence Erratum 1686 */
 	.jumbo_max_len = 4040,
 };
-- 
2.51.0

