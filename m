Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF546D541;
	Thu,  3 Sep 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426054; cv=none; b=k04VlhsecBTBQKbWfIDZPy7ZrL61MrPRuCTRe5yeOReW2OdtBOCeQjkehgVKdZ77b/rq1VBz4kdWxMdRwuoHUnzN3tqLQQxsKKMgfvkNaJqif3bP0HPQYusngNmhRW2WlIMgr/nwWUv8dVNijSRBZ8u9fVKUGoGhlREWlu2q2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426054; c=relaxed/simple;
	bh=7SFF6+bDkyVBOQmIZhhbaq+s0DnpIzs7wUvGIntywK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CK7MAJdswKLSatxkDCUF6Az8YRW0PA9kkebiFfYT6gtI6EQylW5PlTRe9grauXhormGjwf0IYc6H106nyd5eXTBSCVAdr3zktglGD3GjvbQ0Dv+ORXl8lblGQ4hER4tXf3JIfqmnkjTUu9jYGxpC8i2jZIYpGQVQMaY7+IIKpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D221F00A3A;
	Thu,  3 Sep 2026 09:00:48 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Brian Masney <bmasney@redhat.com>
Subject: [PATCH net-next v2 1/3] net: macb: Make sure clk_init_data is fully initialized
Date: Thu,  3 Sep 2026 11:00:39 +0200
Message-ID: <62cfa62a8f39e0014d2fe9b30a668df20ace4a0c.1788425654.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788425654.git.geert+renesas@glider.be>
References: <cover.1788425654.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Compile-tested only.

v2:
  - Add Reviewed-by.
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 76ee4f5060335c4e..2e6a5e93d0cdd5d5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5375,7 +5375,7 @@ static int fu540_c000_clk_init(struct platform_device *pdev, struct clk **pclk,
 			       struct clk **hclk, struct clk **tx_clk,
 			       struct clk **rx_clk, struct clk **tsu_clk)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int err = 0;
 
 	err = macb_clk_init_dflt(pdev, pclk, hclk, tx_clk, rx_clk, tsu_clk);
-- 
2.43.0

