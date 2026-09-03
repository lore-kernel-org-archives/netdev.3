Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908E305680;
	Thu,  3 Sep 2026 09:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426059; cv=none; b=PDXJRwHUhaB8VnhR5/3uybOgz2CNDMY2vMka4F+rJwqQfpMJ/fwSsPDYfdCuKlZGS00y0bF/Cty9jZ/8eYRQDkNHzcOKJEZ/r8poiryh0BcnJ+V8p8O0RijG2VR3REQ5aSm6SJDErctbJGGVeOwnJ3C/6lrolMnq5/walmCdNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426059; c=relaxed/simple;
	bh=Y5AIHhLS8iOxJqe2C41AIZfSByrag0bx0tv5L7x5ULk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcgzXtGQTA7sE+ei5BWqTvuqmWW+SusD8ec3RC8qG/XQ3RUW5hnd0sw3n8Lt6sgNrpkBiTrY9W0kUfIT5llUV3eBQmfwerbFk3wPpKARiNtzBzfg0qRJxmKlCI5GMlBTfxlPtCBMv5lMLDXaUBVd6fMDHH7067o0jJeSWImnhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7811F000E9;
	Thu,  3 Sep 2026 09:00:53 +0000 (UTC)
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
Subject: [PATCH net-next v2 2/3] net: mdio: mux-meson-g12a: Make sure clk_init_data is fully initialized
Date: Thu,  3 Sep 2026 11:00:40 +0200
Message-ID: <98e2b71c333fea0ed59bf615c818cb7b56e2f2b5.1788425654.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788425654.git.geert+renesas@glider.be>
References: <cover.1788425654.git.geert+renesas@glider.be>
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
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
Compile-tested only.

v2:
  - Add Reviewed-by.
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

