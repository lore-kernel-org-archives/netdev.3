Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508305;
	b=17pwVrGdgJGqhoIiTRpi5vi/fCZlz0R7AdY2RqytYeVQF94Ay5Jty2u4EyTuPNwVWbz0
	 IzYD/AB+WaF1k647RWv9S7hoifIbjH6za4YJzpeDbAcX6+87nDbMG2t+DI3xiJTDrFEoQ
	 4skeeA8y5uMEPj4wMLveJwszeiXW+jHLaTrZQrMYY6w4WGSf4HLGvzbcbBk9F78XaVPRo
	 z9BPJh9xNvqfZA7LqD5CMjAk8Mpa0HsR033xpG/ZfYHIvLMZSUNdEnTkWbbeqHi17vEis
	 lRpDKq47icZH745PhvqmWynq9BQ5v0YPbvxdqHdFQ5mZG7Tq0T+Vez9ygUTd/2Mzj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508305;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=28+LnlCRAvjMNnWFEtfBXa2DgYOE3LxqM/Us2XEafcE=;
	b=Dl7L2mCIaSNO3I2wFR+IG3LJsEqDd6KZJHtmkKkekoL4FCEHdB32sOVIQUjgcVwZnshh
	 n+zKejyX90JOpaXYNqWfWcNPwJwo/ZhRC2rJmWIxb4mCmkzzBT70+0jpEFCgeGoABFyCX
	 bh/Q1SS489cPeoGYTn37RIS2QBJQziORjMP6uHnrS7uhX88HVfj8t9xts1NHrX/XbTBKR
	 qwUtsfZ5GS+JkEwUt3AYbfp8SLxyAcuk1LaNdgo62tJE+nAMeD4SpzTqS9oI4RSnFqBgc
	 lD6GT0RqA5ZnPrp/chjd274hcF4MfU1DpNnpnFV7zf8OREqAfWN230xyWjU/XWHmIug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=M8V5ZhLd;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED024606A32D;
	Tue, 20 Oct 2026 14:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED024606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=M8V5ZhLd
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BC16A1628;
	Tue, 20 Oct 2026 16:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792508303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=28+LnlCRAvjMNnWFEtfBXa2DgYOE3LxqM/Us2XEafcE=;
	b=M8V5ZhLdLP3LvMwiq4WLC8waJafgH/ggE9IV/fUO9k72p7paoT7bTW8OLj17qkl/LXO2RP
	17J+nJu+eccJY9EvE1yZfYHNQUtSEApxWrv7fUhmTfHef+iNHGnqDahBTAYv7cts7Gy/XW
	EPiTa680zH0/pHpnif0QtJSlO+yEQG/SrZat5kXyieek22X2PdI0H/EqJyJ+DM4iuIKTKw
	uRpySKyZWbR4d09zbWBOFXYemrdDoEmeqFdf5JGdlOaR2GM8PRWF0/aVPd45P5od+9oFts
	Vw6I2JZj/Zp/Dp6nbabbMLssI+ztUdpfbkJPtExxVDOxak4uzyYj/+8eCP6fYA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:58:11 +0200
Subject: [PATCH 3/3] ARM: dts: bcm2711: give the GENET MDIO controller its
 clock
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
Message-Id: <20261020-devel-bcm2711-gisb-clk-v1-3-a1728724d0f8@tipi-net.de>
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

The MDC of the GENET MDIO controller comes from the GISB clock.
Describe it, so mdio-bcm-unimac can get the real 200 MHz from
clk_get_rate() instead of assuming the 250 MHz of the STB chips, and
can put bounds on when an MDIO write completes for PTP.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index 5e3b4bb393967..82b38551d55cf 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -597,6 +597,7 @@ genet_mdio: mdio@e14 {
 				compatible = "brcm,genet-mdio-v5";
 				reg = <0xe14 0x8>;
 				reg-names = "mdio";
+				clocks = <&clocks BCM2711_CLOCK_GISB>;
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
 			};

-- 
2.53.0

