Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B073FB07D;
	Wed, 25 Mar 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456166; cv=none; b=Ea4DjJkuqOz2tQ3z3F8Ln7zKizZuexKlKv9xkIWm1ztE8hjuuZ+1fJsg7eCzv+dVlZ+iPelbhUt3rAJSMlhVKoT6DSQKxNceTXhA/emzUSBcsS0h+wO545+DN85DCz1AIIR9Vo1LBFd8ZNiygHnrCnwjjkeS98dYkSU2sMROE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456166; c=relaxed/simple;
	bh=Sn9HaRfi1ZPnZhiBsOsyXdj1yYXuqAPKpgTQlpo/qxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJRF06nGAR92K/yEUKAnjPdYxm6rAEsiIbyNnLU44Yz+tbFj5SSPez6pr5xaPZevQjY+xLKq1SB621Q2X0oGEvoQnCfcdMewIYq8ZDn5PpehVP7Xt/iMSJKa4nTAQPdSTb+U3aLeUn5VbB/WolMc419A8Pm0kEIrz5/EqBSpVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyZoEQh/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyZoEQh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093EFC4CEF7;
	Wed, 25 Mar 2026 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456165;
	bh=Sn9HaRfi1ZPnZhiBsOsyXdj1yYXuqAPKpgTQlpo/qxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyZoEQh/MqFa3DZ7+PBz0skpBv9yN2/LxiWlHj1mnnnoqAuI2xmuYuMD4TRoK0XDd
	 5GrknwmTirExjtxscjBos+YON8HbteB1NtpcnKWrnjtIqffbnG0V0dbEgudgHzh2zI
	 afEVe65mHfMQob+6Dmo2x/Bhn3KE34LhXEAtu3R50skaCT/cePUMeuq75PtUaocGsp
	 NNtBGm8y1ARXKWHNYWD4zkDqOKhuoKgD3BdiZStjcw3dTQI4/1wYizlIWlK1wECCqW
	 xoNrN97U5mcc8s4MxdjMxWWsGMxLID5OBYBi3+My8s+myPseqWX64S9dxmKvYdoiT8
	 bAwLyOUSiBitA==
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
Subject: [PATCH net-next v5 06/14] net: macb: np4 doesn't need a usrio pointer
Date: Wed, 25 Mar 2026 16:28:10 +0000
Message-ID: <20260325-passover-rimless-73c19c67d94b@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=786; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=LNJYyIg9j07IeOpXCUTvA6g7fWFWRRaU24pBhU1Ggbo=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM0e9xb8ujNFYPOCJczHZu58rnjXTq+cZ2uhjXnIr xCteRFFHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjInF8Mf0Wlu1eycMSezr3Z X3H9Yfa2gILboiqTztYF51dekv57R5WR4YNGisCduWsunay3/VjE/sbvvIG5sO/ln5EPRBWdO3Q l2AE=
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
index a436521460683..a1f8a6d9554fb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5613,7 +5613,6 @@ static const struct macb_config emac_config = {
 
 static const struct macb_config np4_config = {
 	.caps = MACB_CAPS_USRIO_DISABLED,
-	.usrio = &at91_default_usrio,
 };
 
 static const struct macb_config zynqmp_config = {
-- 
2.53.0

