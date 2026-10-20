Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508304;
	b=ygEttaZUzpqGut2KJXan13Gw0lFAvy4FiXRG+G3+KsO7G+wQNiBlUlH5ibXRnotW0by7
	 3GI2y5FNGssdGxlYYEcmfb/z5C7K8ANv+m+lgK05qQvQvB35nnmDEKx92l/wyf2z3xdOP
	 J92NBQLWxLC39UzSFw7PcKP6OaMh2i51viBCB5CHPWz24J/6eK4xVB0J6upUCSJD7dIjQ
	 5/OpXtnCMmGE4DrsDJ0b21k1avMRwip3tCmt9/ZW4u/4dzG9lNq1dv/D/gCnJoomVc5iP
	 iw7HWOg8iyDI/rYSgovzoMev/8EXqovlR90GnjSWJi/iTfXLurkHjbVc+/bUp7/Ciag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508304;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=7MjKdc7i9F9fJcY1kYTnN/FTIKL2c56vf1h9vXuC9lY=;
	b=kKOHIYJC1hnJebLA9P9lX+E6qRUA4kVxbUuBOGQsdWonw/9K8tnGnrLTy6twl2jblxEh
	 lWtiennwIy5NCQc+sSggoGLPMYOijKiS0jbmOYGSyTjOrlTDtrRAZ74m6asV/7fm9C0xq
	 xURgW9/J+Xx2xatY8gFlkuZdJAxagOC4gu6JQYIr6vw3Hr85qQ9/dGgdBow0Ri4FEuxj1
	 HvGT9lwsDNtE8HFpE2mhrf6mIG/ioyY76AOpEzCkWvf3I20pquW1N79AuKJNRQ+bgV6ry
	 iA9JnIICCVRTwtpA2mHAeYKGVdIub2yMwn5ki4pe0TnEx5WWLWdiCeJXLNnR+tWqXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=oyVTA7cy;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8360A2609;
	Tue, 20 Oct 2026 14:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C8360A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=oyVTA7cy
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95E08A1625;
	Tue, 20 Oct 2026 16:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792508302; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7MjKdc7i9F9fJcY1kYTnN/FTIKL2c56vf1h9vXuC9lY=;
	b=oyVTA7cy9CHMLVVA9gkpW/4/enFIkJAtc7cohzo0PBdZDxatBae79TL22w1Mb//Gf3hbKo
	AwFgFTURY2JbxipA8eu+v+iLlz92bnKcbm4f+EPf6YqZpgRjGCIVBxd7BsFncudDF/DMzS
	hoyHBLo4OoiCtvUloMx7uqqzb9e7F2JLRR4EetWYCTCYIik9hNQtq0srpi33vo8Be4t7Z0
	j38k3jWowk3JeqIaaQGMCyCEEqIblE+b0T540S16XrbGejVMcFXp177+Nu7PwMrsCa1Pmx
	YAJxXXC7jg5ruamm0yy6BQEmvQXfeTT7gf5PF+Sw1GzHqQvdcWdErQ+zq9SmwA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:58:10 +0200
Subject: [PATCH 2/3] clk: bcm2835: register the BCM2711 GISB clock
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-devel-bcm2711-gisb-clk-v1-2-a1728724d0f8@tipi-net.de>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Stefan Wahren <wahrenst@gmx.net>, Phil Elwell <phil@raspberrypi.com>, 
 netdev@vger.kernel.org, James Clark <jjc@jclark.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The generator at CM offset 0x1d8 is not in any documentation I could
find, but the firmware calls it gisb and runs it at 200 MHz off
PLLD_PER with a 3.75 divider. GISB is the register bus of the STB
peripherals, and on BCM2711 the GENET MDIO controller clocks its MDC
from it. mdio-bcm-unimac wants that rate to work out the MDC period.

Mark it critical. The firmware enables it at boot and nothing in Linux
owns it, so it must never be gated.

Checked on a Raspberry Pi CM4 by moving the divider at runtime, the
MDIO busy time follows it.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/clk/bcm/clk-bcm2835.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 118df86d717c6..bc1de20c7e00e 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -117,6 +117,8 @@
 #define CM_EMMCDIV		0x1c4
 #define CM_EMMC2CTL		0x1d0
 #define CM_EMMC2DIV		0x1d4
+#define CM_GISBCTL		0x1d8
+#define CM_GISBDIV		0x1dc
 
 /* General bits for the CM_*CTL regs */
 # define CM_ENABLE			BIT(4)
@@ -2097,6 +2099,20 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.frac_bits = 8,
 		.tcnt_mux = 42),
 
+	/*
+	 * GISB clock (only available for BCM2711): the STB peripheral
+	 * register bus, set up by the firmware. The GENET MDIO controller
+	 * derives its MDC from it.
+	 */
+	[BCM2711_CLOCK_GISB]	= REGISTER_PER_CLK(
+		SOC_BCM2711,
+		.name = "gisb",
+		.ctl_reg = CM_GISBCTL,
+		.div_reg = CM_GISBDIV,
+		.int_bits = 4,
+		.frac_bits = 8,
+		.flags = CLK_IS_CRITICAL),
+
 	/* General purpose (GPIO) clocks */
 	[BCM2835_CLOCK_GP0]	= REGISTER_PER_CLK(
 		SOC_ALL,

-- 
2.53.0

