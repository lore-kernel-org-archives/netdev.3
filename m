Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B54772B9;
	Fri, 21 Aug 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306884; cv=none; b=o7DkmjS6jaADIK/oybOuuMbbAJGZNg7WLY6s6qm6YcL1pvjURwMwD9ODHVcPqo24wQvQUkR0io27nOx/bYs7utylczNth+8/lvNSvUCqzFFQKdM2868K5sG8+vUhQ0Q1Y6S4g5oyjkCYJixBqYY2tlFXJ1uW5ymve/j60SUXBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306884; c=relaxed/simple;
	bh=txaoWzXPUdTRaKEnmk21eay68feRqKagejyTggR89s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJ8vIL6rQcZuaN2h8fAVMS2gV3mT193/JAx49tElNKjX4tAnS8D+1v4MqdiMqHxvKvoX/eAnkxhwtKyBWfGnQ+rYa4uP1/w8RXXIF5Srb3ankjk9JIDtl8HpzBao20SC6kG770WP/8CaY/xSxmaf08vtps7vQiGAl6khCodXdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A865D1F00A3E;
	Fri, 21 Aug 2026 10:07:48 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next 3/3] net: phy: air_en8811h: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:07:32 +0200
Message-ID: <ebafac1803ee032ebd544a6ec5a1608c5630d81a.1787240118.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787240118.git.geert+renesas@glider.be>
References: <cover.1787240118.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data structure contains several mutually-exclusive members
for different methods to specify the possible parents of a clock,
prompting drivers to initialize only the members they need.  However,
not initializing all members may cause subtle issues, which are only
exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
enabled.

Make sure all members are fully initialized, to avoid such bugs, and to
prevent future breakage when converting drivers to a different method
for specifying the parents.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/net/phy/air_en8811h.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index edd49c193e476838..d1ab8744288bba0c 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -932,7 +932,7 @@ static const struct clk_ops an8811hb_clk_ops = {
 
 static int an8811hb_clk_provider_setup(struct device *dev, struct clk_hw *hw)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_COMMON_CLK))
@@ -1031,7 +1031,7 @@ static const struct clk_ops en8811h_clk_ops = {
 
 static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_COMMON_CLK))
-- 
2.43.0

