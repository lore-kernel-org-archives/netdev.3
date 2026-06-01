Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F642DA759;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330056; cv=none; b=TbFszqcRuR83hae2zdI1JCaicDU0BSSklmt9sXNz43qBgWB6+53Vq1dhFyZv9nHI40uwsWvW9EM7PKEeeG1EhhrhG5maiMimQ7cw3mpZLJdWl6vLA0b+NWcw4NZ+JGcnllbEP4Qt+ctXYVjCSHv3AdXyu65g1KCaGiQvwErXg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330056; c=relaxed/simple;
	bh=Kuc3RltHHer6tK/1tGijxQ7aT4nW9y3Cowo96YU98PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuIKznoxAYntztdwW5Pr5wkGbhpTEZ2xdma50pnj+6UAOAPD/4Ik5gBXzyQXRfzMqQU3FE5lWQbBHOjLTQX64JarU4heqk2mGeY54BSHXMB60ki5MJ7naY0bJjV9bDQnnU81dMkfuRGDPhEIn0oiOHizw9T6scY2GTGt9f1l4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfxyjZye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfxyjZye"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A27F1C2BCB8;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780330055;
	bh=Kuc3RltHHer6tK/1tGijxQ7aT4nW9y3Cowo96YU98PI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AfxyjZyektuiz2Q/SVtqNxMzXYJSxC6aSmxhbQg8YODoMTXn0ka0/Wxgtf4yZl4X5
	 +PrYWSYdDPf22d9t11F5eVwRDfyge/pRD4cRH17ONrfvIN9XhOBwPHPXqkEqJaT9G+
	 NlgW/N6LnxpGAzywCzXAL6A6Bnw0w+cn/vxaFg/uDGvy5E3SwhEvJGr9MvNVXpTuII
	 y1jwKeD5VU15qu1jNo1ypLtgVB23KXND9AiCsHdsckKX4talV+/Pefh08d+h/8mVlH
	 lR6q7xwaZMaVYaQlsGeg8Z2s1+zFJ3QqxDR+0XPHLrXI+MWt0jWABtvRDfXL9nxqp0
	 x/KI0uzODC80g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880DECD5BD1;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 01 Jun 2026 09:07:18 -0700
Subject: [PATCH net v3 1/2] net: ethernet: oa_tc6: Interrupt is active low,
 level triggered.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-level-trigger-v3-1-da73e7010532@onsemi.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
In-Reply-To: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780330051; l=994;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=PqRuuDbw4zLWSskW8G1FH424GyCxxpkBl/f2rNkAlbg=;
 b=qGXpWOEDACG/EIW3bVEn/p3fl4bx4qiapy453UbY4aGCkOdU/2LuQ5xi60yy22fYnE0nEZ/4k
 9YS5rBnV20YAKtBwalaGBnNDqAbQoQblWs99VomGhEiy4prdX7dwz0O
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

According OPEN Alliance 10BASET1x MAC-PHY Serial Interface
specification, interrupt is active low, level triggered.

Fixes: 2c6ce5354453 ("net: ethernet: oa_tc6: implement mac-phy interrupt")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 91a906a7918a..667faf155405 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1323,7 +1323,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
 	sched_set_fifo(tc6->spi_thread);
 
 	ret = devm_request_irq(&tc6->spi->dev, tc6->spi->irq, oa_tc6_macphy_isr,
-			       IRQF_TRIGGER_FALLING, dev_name(&tc6->spi->dev),
+			       IRQF_TRIGGER_LOW, dev_name(&tc6->spi->dev),
 			       tc6);
 	if (ret) {
 		dev_err(&tc6->spi->dev, "Failed to request macphy isr %d\n",

-- 
2.43.0


