Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DEF472549;
	Fri, 21 Aug 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306880; cv=none; b=konmnogaVwqnmZ72Fd7wNb1H/X3VewJRpUAP5UQwBTLHvQyO3zqf+RiLsQXocIHWUjWTNV7Lixl+kFSYWd5ZTFu5g5OyIWs6kBzWwq1XLXrXnrxD64N39eeQqS9l1hUXSFcimuafgL5n848TfyyojAu2lmdWyUvvwsTfb8YplO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306880; c=relaxed/simple;
	bh=hJkNhPE8XwUHueyPCgfu/7kCwFh8TN0rhALTl0S5YwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7OgF6ovMol4WYJjq6ZhKfxJBu3WeuIFqKmbGDXkQe0OLIwQmQEz9s+FV7EdEU2KgXng3f+1t7wda7CjUVqgoLan5PTxgSjSoYt15UtFQ9K2Qyl4WPh7AVuGSma9Jj8erGIjEp0VNt0+2Scwd1IHJPpNvH5T6RepRMK42OOmC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF74A1F00AC4;
	Fri, 21 Aug 2026 10:07:44 +0000 (UTC)
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
Subject: [PATCH net-next 2/3] net: mdio: mux-meson-g12a: Make sure clk_init_data is fully initialized
Date: Fri, 21 Aug 2026 12:07:31 +0200
Message-ID: <ae6cfac64d3983801b9baa2abb30bf09c3d7ce3b.1787240118.git.geert+renesas@glider.be>
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
 drivers/net/mdio/mdio-mux-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-g12a.c b/drivers/net/mdio/mdio-mux-meson-g12a.c
index 08d6a6c93fb8bf02..e6c9ef3641afa27e 100644
--- a/drivers/net/mdio/mdio-mux-meson-g12a.c
+++ b/drivers/net/mdio/mdio-mux-meson-g12a.c
@@ -223,7 +223,7 @@ static int g12a_ephy_glue_clk_register(struct device *dev)
 {
 	struct g12a_mdio_mux *priv = dev_get_drvdata(dev);
 	const char *parent_names[PLL_MUX_NUM_PARENT];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct g12a_ephy_pll *pll;
 	struct clk_mux *mux;
 	struct clk *clk;
-- 
2.43.0

