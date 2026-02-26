Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878E314B6B;
	Thu, 26 Feb 2026 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772103838; cv=none; b=iFk7kgEyOHcU6DC853UicEEGqIG9DRIFtgkqTGK0107gPApE7OmytWG89AmaLpOfyoIisyoyuHtuXbTf5+F22fuvR15OrG0kKfV4vwje0N4HzyyZ7fbJeO+BpqheDvUvcJHEWkC16jwkWTw5CaH8eP1/OfjnjQX02T8lTZzR9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772103838; c=relaxed/simple;
	bh=gCnpueCUTyu07waHpq7nu6PTRZfJXR3EGhkw9ZM+/bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rebWwsZn/42R8uB6JHFtnY4xAv3xsp3/IavwIpG+M17h72SJNzTup8jrl3Tg1QN39HG9lSK76iYIGwQdnXWoAKgh9sQl7guHUSd20k7Z69A3RC9+Aeuw+d/PDfnPF4QmY5gad4QCWTIaoDuE6FiFuve5/euvjXbqsEq3QjIgh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsouwWvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsouwWvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A557C19423;
	Thu, 26 Feb 2026 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772103837;
	bh=gCnpueCUTyu07waHpq7nu6PTRZfJXR3EGhkw9ZM+/bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsouwWvobVKDxezQCD+XbTxcM+ndewpB+KFiy78v15I9+SCwrRXK+3nDJ1JcFXsdn
	 gda+mhuyzdEta0JkEl47xVy5nII0q4LeF0yxIVzfT/MkxLwV9QDUGRlVeNQs1Efrok
	 QPkxW5XhkCiHDvQ5sZ5Tz7ErecxmP1M64nPOuKhMqeeuIyF2RD/dqO6XgUamgGfB2/
	 mmFFSusZ6awJhrXAONd7HpV5crDNzg/Pdzbx8rtaEUacDZWYlv9BldaL40ngskDk3N
	 V3rkMu46GQx60ut+9GynTCeMxDUToKi5nCvT4irRGYUSLMe5tzfJ/iRvrUuREHz7pV
	 k+7IC11hUM/JQ==
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
Subject: [PATCH net-next v2 3/8] net: macb: np4 doesn't need a usrio pointer
Date: Thu, 26 Feb 2026 11:03:18 +0000
Message-ID: <20260226-penny-steersman-639cb0817c7c@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260226-snowshoe-amusable-6716d4ddea11@spud>
References: <20260226-snowshoe-amusable-6716d4ddea11@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4mwnK4Cru/aMA40im7P98cvEdQM5//cBujdDVwQ8uN0=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkLNMrfHPrcabRzr2xCx87Vyp5a6SVrumXj/2na1Imeb phmV320o5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABN5/ZThn2Gh0rzsEuavHqfU VRN9pu1/EG/nWueS1/7n+Fw7ZkPFfob//ikyS5ieXDmu2KDwJXfTb/+ZARaiYneXqqYXn38hzOT GDgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

USRIO is disabled on this platform, having a pointer to a usrio config
structure doesn't actually do anything other than look weird.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 778d2115f66fc..ddbb0c327b303 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5315,7 +5315,7 @@ static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &at91_default_usrio,
+	.usrio = NULL,
 };
 
 static const struct macb_config zynqmp_config = {
-- 
2.51.0

