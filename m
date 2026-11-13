Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565204;
	b=EogOexZbYBQJHz6FxAxhiQaMSdqEJg54fVAjhoqOd7c/VdLnKXWdXqwO8uv2gjq/I3Nd
	 2eRjFsmX3uUoDV47Du4Br2QqcQ7kdrD/JntbCRbSFxTgngYeiaVp6zS0FCRIFJcEzjDMu
	 cmrAqKvAJAU45kl6N1+uoNJHWCYY/tC8Js3xOksZudpthPvSz+kI2+81WtHTZZ7FiH9bK
	 6xjJALnfPHgqduHmKLUqbTfaiEW2LdZTqHD1aZsTxQBxHZZDEXctF1O8Sm0guZNB2x5cS
	 S3mj9eFbn9Yga31gLojbpcoSRouYvZohPvB5DitGH87qp7UdF89wapmlnH8KilFmB8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565204;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=EvM6xyY+uxZxS8Sqk7d7mHcuxUUAebFLqQRWU1uifsw=;
	b=T5G4rvvjsyLJ5mi+51Uut8oMfuD68hREndBlhKOcxL5eY5LrcYDoNpQvxz4CQTdD23RZ
	 rXsppB9N+4kyIvDWrhUZRwUeaJyakpBi1LcdA5osbTllSpVS8EF5c+nsqM3nk6MyiG5fI
	 B9jCfBVTERYtqOlpG7/c5F+xTCawLOg5PRVC83K5nWnFOCepSapzZe55EAaMXZ2cRB5fa
	 3goyqqNku/E5kkm2pEq9Jb/zMLEV9DY7MKOnCZSeUFNY8UCyX1Mn59lFfMkBzQ7bnrYAe
	 t0Sy++ADVIqz8S/A+mOv1dUujg2sghWpJY5BCGZdRoxN/6jbW+4sw5S/lJuhI2mmkmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="B39P3/FL";
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26B606A323;
	Fri, 13 Nov 2026 10:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB26B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=B39P3/FL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794565204; x=1826101204;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=FfCRFY7Bvm5aNhQnrCe5i/u9H45+lz5nsRsQwHL0hts=;
  b=B39P3/FL2CR/pJBU9wV6mm33E5EwLr2CUhlweXtd0A7ENuV0Hi+aZKnf
   +4GPcr8RzkFwoRCu0mF07X4KxvWbZa6t3LkKMYO1cDRMdNlNKRN5NdMat
   R4rZBqj4uEH8Z4a9J7wvoGDaxBTqsyqDXn2InacTT9/e9xwUiaIbG+t58
   ukHwAPb25acRQ7ol8qr3fuVc7V33PU3u9FvTgMxuZdeaxtyqkAtVHaOua
   7j19vupc3xrnyYUP40taRysfwp7y1vMgjq784iB68T/mPhsNui2cQ70zE
   FLF7tFkHUwQiE87jsiKLwEQnMpEh9rt2YOwOoLoNpit7F74Rdq0Wm7dEt
   A==;
X-CSE-ConnectionGUID: W7OuCreGQl6KJhtER0qbmA==
X-CSE-MsgGUID: Q3VH/kL3Qmm4lpxNFNWz3g==
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="66461920"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2026 03:20:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 03:20:02 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 03:19:59 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/4] net: lan969x: skew the core clock by 200 ppm
Date: Fri, 13 Nov 2026 11:19:39 +0100
Message-ID: <20261113-lan969x-core-skew-v1-0-b9b02b863d38@microchip.com>
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
X-B4-Tracking: v=1; b=H4sIADzk9moC/x3MQQqDMBBG4avIrDtgQiPoVaSLVP/YoTJKIjYQv
 HuDy2/xXqGEKEg0NIUiTkmyaYV5NDR9vC5gmavJtrYzrbW8eu27PvO0RXD64schOOMc/Px8g2q
 3RwTJ93MkxcGKfNDruv5AwtqGbQAAAA==
X-Change-ID: 20261022-lan969x-core-skew-ff5155ead4be
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Richard Cochran <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3

At its 328.125 MHz default, the lan969x core clock is too close to the
line clock frequencies for the high accuracy phase detectors to work as
intended, which degrades PTP accuracy. The core clock should therefore
be skewed about 200 ppm up. The PTP time of day (TOD) increment is
already set up for the skewed rate, but the driver leaves the core PLL
at its default, so the TOD and the clock that drives the scheduler run
200 ppm apart.

This series programs the core PLL to the skewed rate, and reworks the
PTP frequency adjustment to scale the nominal increment directly. It is
not a fix as such, but an improvement: nothing breaks at the default
rate, and this moves lan969x to the core clock configuration
recommended for PTP.

The difference can be seen with taprio: timestamping the frames released
by a schedule with a 1 ms cycle time shows the gates opening about every
1000.2 us instead of every 1000 us.

Patch 1 adds the CHIP_TOP registers and maps the target.

Patch 2 enables the switch core only after the core clock is
configured, so the PLL is not reprogrammed underneath a running queue
system.

Patch 3 programs the core PLL.

Patch 4 makes the PTP frequency adjustment scale the nominal increment
instead of using a separate one ppm table.

Tested on lan969x and sparx5.

---
Daniel Machon (4):
      net: lan969x: add the core PLL registers
      net: sparx5/lan969x: enable the switch core after clock setup
      net: lan969x: configure the core PLL
      net: sparx5/lan969x: scale the nominal TOD increment in adjfine

 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 123 ++++++++++++++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   7 ++
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   |  82 ++++++++++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c |  54 +--------
 5 files changed, 217 insertions(+), 50 deletions(-)
---
base-commit: 676f3aace662fbbc180b3898b190a372fa2a516b
change-id: 20261022-lan969x-core-skew-ff5155ead4be

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

