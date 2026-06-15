Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440830CD95;
	Mon, 15 Jun 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526278; cv=none; b=s9yHaf1KX4PEZoGuGgw6iwpDuhay5wssJExF2Du/fZtXjsZqbcloSU0l1ZtuojH11kiwrFNFeDLl1I5pm/eKjqatEt9xYuTcOyQXGFsb04vhk5iydi1nadVkdkMXtTk6Zrs/QQfmfmSINnSSCjyXwLu1ywesmroOPbYo4lwOBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526278; c=relaxed/simple;
	bh=U/229aDPygbK2f1IV17WG591ys3SZgvnwqf40Huk/S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mNzldLES75E1b8F5IPV3kpEoIkne7+VZ5ABzvv056ppriJFCBx0jrE7CGsFPW6Bt2vxLekHSPRzjaPkN8+O3lD62sfinrYlLX41WgWEuOSvv1HCNCKCsd014XTi2EynwnQvI5tN/j1IJC3aaj0MLGnwZPAyW3Fp1g/FZtEUuk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgOIGL66; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgOIGL66"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8A06C2BCB4;
	Mon, 15 Jun 2026 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781526277;
	bh=U/229aDPygbK2f1IV17WG591ys3SZgvnwqf40Huk/S4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cgOIGL66GyRBFJh3ulPaHZzu78hTw6TEYU6zpzYlFLH+jneSK4MkPh947qRSB2FGU
	 +WI1F1oaqYUC1AXk75ofb4AqueS8n/7AuTWsiu7Ys+ZgvxhUpo8Q//2m1I2OrzI7Rc
	 dHjMfDCaSvuYsFHQ9OZStUb+IFsXB/ADwF60Cn7OY9MLpESB/VOxfmqXUUQ+ceAVM8
	 7Wie0pC5LqdHPaBp0/jUo3FmOkrpwbCDEbt0cuOokWSzHnA79+6gmC19vmMQ/+eVdv
	 FcWoVe1rY+N7YWSKbM9oSG/AqaQ+BT28p99z23QdNjRa7mm9n3Dg0kCdaUACxRAjs3
	 alhzsG5fgAY+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC8CD98DE;
	Mon, 15 Jun 2026 12:24:37 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Mon, 15 Jun 2026 20:24:17 +0800
Subject: [PATCH] net: stmmac: loongson1: Use dev_err_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-dwmac-loongson1-v1-1-cbcf5bc01d9b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPDuL2oC/x3MQQqAIBBA0avIrBPUSKirRIvS0QZKQ6EC8e5Jy
 7f4v0DGRJhhYgUS3pQphgbZMTD7Gjxyss2ghNJCC8Xtc66GHzEGn2OQfEC5jdaZ3mgFrboSOnr
 /47zU+gHKAVm4YQAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781526276; l=1168;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=2fl2OBxWH3wOcozENxrt6hZZsu8wzA6vdfleIZixEow=;
 b=/xcmeOq0CIVKL1BbVMNLoT/ceXxJcS0hTcnCvEZ6XK0jr4a/anBT54fyJswBJHk++djVHtRXn
 tJKVWnD0mutDflarcg2J1w0kDRCds4G4jYe4E9akQGFn9N6xspemEK7
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

Use dev_err_probe() for the missing match data case to simplify
error handling.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
index de9aba756aac..ec34adb63f61 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -176,10 +176,8 @@ static int ls1x_dwmac_probe(struct platform_device *pdev)
 				     "Unable to find syscon\n");
 
 	data = of_device_get_match_data(&pdev->dev);
-	if (!data) {
-		dev_err(&pdev->dev, "No of match data provided\n");
-		return -EINVAL;
-	}
+	if (!data)
+		return dev_err_probe(&pdev->dev, -EINVAL, "No of match data provided\n");
 
 	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
 	if (!dwmac)

---
base-commit: ec039126b7fac4e3af35ebccaa7c6f9b6875ba81
change-id: 20260602-dwmac-loongson1-5e1b9dfc3c62

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>


