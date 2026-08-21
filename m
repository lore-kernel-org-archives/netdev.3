Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC446470135;
	Fri, 21 Aug 2026 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306880; cv=none; b=KGHari++msDbHj4fL3FPLT6ByLhkz0s5qa0I4xVLee+jbLh06+wkv6qSs/0YuCN8ktorRUvRF3EnnJq0MkCBKZtWJTB4u7csKKXMy3KERhjoP64dXJzWhDEylGbh5nA+y7Z4iYvayq62pcam6RarUsP/TuTSwP0n5mbkHHqIoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306880; c=relaxed/simple;
	bh=P0NZG29jHDFsMDX7HwIGYcCCAN5fv9yzWrBqrhiQCRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuvnlZFti+7g6w1Qb0oJeOMGKJ/+A/t5LGKRQAg1mOHRJn4yU8BXgvC6Z1fvEb6Dp89mOjUYhOBty440LC5Op0zANEsfE401jl3GIOZf0cBudbqdW/CULqB5xIcJ/PIP/hnPXlINtQ9tlZE3v6LWxmkf9teyn/yMGZfwvLu6kCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25511F00A3A;
	Fri, 21 Aug 2026 10:07:40 +0000 (UTC)
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
Subject: [PATCH net-next 1/3] net: macb: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:07:30 +0200
Message-ID: <00772e2fb1f8433a5d6c47dbd28cb4149495e1ab.1787240118.git.geert+renesas@glider.be>
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
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1476bce77f34d2a5..319e43098f57ed7b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5376,7 +5376,7 @@ static int fu540_c000_clk_init(struct platform_device *pdev, struct clk **pclk,
 			       struct clk **hclk, struct clk **tx_clk,
 			       struct clk **rx_clk, struct clk **tsu_clk)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int err = 0;
 
 	err = macb_clk_init_dflt(pdev, pclk, hclk, tx_clk, rx_clk, tsu_clk);
-- 
2.43.0

