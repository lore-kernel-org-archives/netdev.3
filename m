Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508303;
	b=oKyoFHsdWo0qTR9VIcLbhIZ89GGbtEP7M5q0fz3AK/5yCDgpTZFoLSYaFMhywHwRAEW/
	 sjMMsm1STRnMaS1RhjQbvj0rFPrjG+dFW9C+2v6vLrjfdQnSf27kIQH+3Q+cS1NgGcPcV
	 GatE05bsD6hk8iWV6+st4A2SumpqLKhM2pErbIshJuaKB/SS+vEAR4wD5sbQXrYuROjL3
	 NFKrIorhC4ASJzlqiMXe44dCvCmZ3DhsBfFTESV2M3dnBpQFKlHbAQBAUQisXtBRGtoqP
	 JhzUb3198DZ4a3aRQXA+GXJcAbioNGcyzH+1g8wldJHK9rsCmrYdr03Ws4aDu6Upf2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508303;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=ztv0HJ8l22RRsNhgDD2bkXEQ2puahy2KotEJnS3/Ydg=;
	b=5AEd2lEsBRtZ6xQyGBAoRxNDpETDOQ+5x3zSpfkUaxYAAP7sVkFGVQeZ/iAw90bivj8Q
	 2gpXhwY2IXpoG5eslisz68nq5/OhwK8wPG3hnfG/tcmBAmSBiQEbowccxkF5aKDQvy5M1
	 W4zu04dmXjzsR9vb2Y9eyRwfWGCv3woh+q3gPdftM6qFPbTwgOYpS2lFm2iqM+qox1niN
	 ycp5d0ifBeN7qEPP3GzsZe4kH95BgnVMkjLZnUnqZNMSoLdqKE/dc/6vRkZN7Etanj6Qb
	 vH24PPmFV9ULf/J0fV9RVGH/N4gK9k9ovh6PiF3CuOd0oZlywKxNKBHA0eEDCO37XrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=XUfQyvgt;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC09606A319;
	Tue, 20 Oct 2026 14:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBC09606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=XUfQyvgt
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20F43A02DC;
	Tue, 20 Oct 2026 16:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792508300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ztv0HJ8l22RRsNhgDD2bkXEQ2puahy2KotEJnS3/Ydg=;
	b=XUfQyvgtMIFS9NUybNkk3G15CGBu9TocD6/t68NAvHfY8yTD5ZDTrcJiQLAuLdnoVTkwh7
	9J5snnKJFFnYJSqDvuBX4QvV70VO0spX6/DmcmUvXkVLZWyZlHDcH6/RezGHwz9IhB6CTq
	k5kxCDLLIt03//O5Pc0hqQiQywk/IxWUbo5d3RJ0+zV7FvGDFL44ypsGTQLZ8EZRKY8DYK
	0yw91bL1OB1H+VChen/EriIIeMXiAaAv31wteLNr2VU5v4tmAwhv/ytsk7f8KYSc3RTNfI
	WM0672a3sMi1Srp2n8KiKKyIcnCcXUdfNCA0fxqJrjKreYo9IFbre7jreAopww==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 0/3] clk: bcm2835: describe the BCM2711 GISB clock for the
 GENET MDIO controller
Date: Tue, 20 Oct 2026 16:58:08 +0200
Message-Id: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CQAxG4VchXduETgxeXsW4mCk/WEU0UyQmh
 Hd31OW3OGchRzY4HauFMmZze4wFsqlIL3HswdYWU6hDI7UEbjFj4KT3sBPh3jyxDjfWbg9EOei
 2iVTiZ0Zn79/4dP7bX+kKnb43WtcPNgwxmnoAAAA=
X-Change-ID: 20261012-devel-bcm2711-gisb-clk-cf8eea19c46a
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

The timestamped MDIO write series [1] needs the reference clock the
GENET MDIO controller divides its MDC from. On BCM2711 that clock is
not described anywhere, so 5/5 of that series hardcodes 200 MHz behind
a compatible match, and mdio-bcm-unimac's clock-frequency handling
assumes the 250 MHz of the STB chips.

On BCM2711 the MDC is derived from the CPRMAN generator at 0x1d8, which
the firmware calls gisb and has always run at 200 MHz (PLLD_PER 750 MHz
/ 3.75). Changing that divider at runtime moves the MDIO busy time by
the same ratio, see [2], and Phil confirmed it from the
Raspberry Pi side. GISB is the register bus of the STB peripherals,
which is where the driver's 250 MHz default comes from.

This adds a clock id, the generator in clk-bcm2835 (critical, the
firmware enables it and nothing in Linux owns it) and a clocks property
on the mdio node, like Stefan did for EMMC2.

No functional change by itself. The driver only looks the clock up
with [1], and only for the timestamp bounds. Making
unimac_mdio_clk_set() use the real rate is a follow-up, as that moves
the Pi 400, whose clock-frequency = <1950000> currently lands at
1.56 MHz instead of 1.95. The limit is a level shifter on that board,
so the follow-up keeps it at 1.56 MHz.

Patches 1 and 2 are for the clk tree, patch 3 for Florian once the
header is in. dtbs_check clean, booted on a CM4: clk_summary shows
gisb at 200 MHz under plld_per, eth0 comes up as before.

[1] https://lore.kernel.org/netdev/20261009143506.2507607-1-jjc@jclark.com/
[2] https://lore.kernel.org/netdev/60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de/

---
Nicolai Buchwitz (3):
      dt-bindings: clock: bcm2835: add the BCM2711 GISB clock
      clk: bcm2835: register the BCM2711 GISB clock
      ARM: dts: bcm2711: give the GENET MDIO controller its clock

 arch/arm/boot/dts/broadcom/bcm2711.dtsi |  1 +
 drivers/clk/bcm/clk-bcm2835.c           | 16 ++++++++++++++++
 include/dt-bindings/clock/bcm2835.h     |  1 +
 3 files changed, 18 insertions(+)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20261012-devel-bcm2711-gisb-clk-cf8eea19c46a

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

