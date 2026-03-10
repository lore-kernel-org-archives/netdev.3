Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4212314D08;
	Tue, 10 Mar 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163153; cv=none; b=ourzFSpVk+wez0eaa1GfsILlmc6500x2pLzoYqTV0NLleWR6gagTMNVxWw1jwxiVxcmO1LOsHVi5ICQzLiuRgDSgiArcDnZXtCAZGqP78GHUzL+Xd+k4/0Dw6yQjWl/ftI52J+NF4PRcrMx52fOUKs1nT09IqwU7exOhAnjRNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163153; c=relaxed/simple;
	bh=hLF9AXo3lnRxCyN0gi/H0Xuz7Ot4l/b2adjyOOaaEI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo4KgMDjbqQo+AIQtDwhVfQ5ZzeQErMwPoBQkQA3bhbAz9gWT4i0tytwOA0G3uXrC1dyDbkbfylkhkADV07YpKdICs/MDOj9egr7//gJkzJp7R9PXFsQKaw425CXkCBUHopxLFI8Rvej1sgvHylFbhI8QhXl74F5zfKEG4JqMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwf9qDw/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwf9qDw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45606C2BCB3;
	Tue, 10 Mar 2026 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773163153;
	bh=hLF9AXo3lnRxCyN0gi/H0Xuz7Ot4l/b2adjyOOaaEI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwf9qDw/MyxKklGxC1YMHWeNHNONf3PTOcwDD4Egre0SngpWtcsBvesiwLKTh50Mx
	 twUPpUQyBtpbZ9HFZd2z1eKEIzF2czgc+UvQqRIuCs53UI7vjAFJhfep22/GZC+c2D
	 DWhGCXdky/T/eSKNQGz/cuC053Mgz7Uf7b1K3Zh1eyPd4tSXCKVZiR8OaA7aOXRtn9
	 mc/hhN9BKI/c0ii/rKR6VidQ5QHZu2fpqyvMsM8vbZTGqsbdAuk/1OGcisp4Ua08LS
	 E53Qb8ui27LsD9n+MWnaC9ihLePi9a54xC2vEMsU+yUxyt21j0vau9OY4HAZWJ5/0j
	 z7vizcfy6LPlQ==
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
Subject: [PATCH net-next v3 05/10] net: macb: np4 doesn't need a usrio pointer
Date: Tue, 10 Mar 2026 17:17:12 +0000
Message-ID: <20260310-stubbed-passenger-30e7c6736c8f@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310-moneyless-dispense-7bce14b16388@spud>
References: <20260310-moneyless-dispense-7bce14b16388@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=785; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=F9UBzeUId/kao0gPpAeZyIh8nfmZqgwg0AfcGoyheCk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkbgnRnL/waZl51aLHuooOxwpu1ZV4f5ND/qXL4K/s11 ynlgs4HO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARpVBGhn3be72Xx19sM54R xsaVtjxmCluD96SI/ZkeecynY3bM+sHIcC2hKF/LUIFvZvyiR2pvzXz/i4XrpPvEdjAcqd7g+fE MIwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

USRIO is disabled on this platform, having a pointer to a usrio config
structure doesn't actually do anything other than look weird.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1f9e46cf7e1cb..414a8fa3f99d9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5349,7 +5349,6 @@ static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
-- 
2.51.0

