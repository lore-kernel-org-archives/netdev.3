Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB594BB5D4
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949467; cv=none; b=pVzskjQ7ckcBYDsf8BJbSsXuCTY0x8ZnIhYmd+KdmlPhJ2ivNqqk38iIuWsX6dRkcqnrZxRQGZvQzPieAY22gJz9mDYmaSqA9SUDx6dNBM+zfEbxzwGI4qOiw9COJwzyB+aYUsoZvtnfIJToBaSsb8u1Rvg3Md/dMUUAJcS9Fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949467; c=relaxed/simple;
	bh=+i6VElqpiAm4ADwgZ3RXMCVldfiQiiZgh6SfyG7dy0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXaOx0WAXVKBgt3wy+ZXx+GYv/qxZk1FMrn66wavAlo4eTYH31okBegWmICzXCI3zbtgfgQQFWYa9+zDVHtbng8WQ6Tn1Nsy5p6eFRg5aX0cP2tIlU+J1BwOnRsETRlkP29cKc0eTbwUWtYW58cMZeoYY2lulGYLBU2iYlUxU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=lATSuIK7; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="lATSuIK7"
Received: from polimar.tail4f75e6.ts.net ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id CdlZxDen1LUMUCdlaxwrBy; Fri, 02 Oct 2026 15:57:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790949459; bh=+i6VElqpiAm4ADwgZ3RXMCVldfiQiiZgh6SfyG7dy0c=;
	h=From:To:Subject:Date:MIME-Version;
	b=lATSuIK76+Vm5XjGsTqVMbCKXpn2OFH8TdMrkaj1rNeeMIRv8r0B49X2ll6tSU9AX
	 vQlrk21KRMlLym4YYLSjHgqB8BUzK2ZFn6TpF76U+vFEutDMZu9TT6O+uZmDLrgkym
	 nNHHxbZZoHT0SpdfMVMGf2l5RoXZykFLtqFraUsMvaK3OmEcXB2aILz3hs9qOAuxXA
	 du7Da9PeBlTw7cN1vQ5hAhlFpBwWK+FHKU+Mc5F9N4qxvGyAsOOwxhyPxAzJAks0uo
	 7Ni3j554M8mRs8KMwyc/0oEvRYsolaRWUy+8bfp2OpGISQCQiIiarnG9bQPfWjYR41
	 Wrv3dAJPQRgHg==
From: Rodolfo Giometti <giometti@enneenne.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH net-next 0/2] net: dsa: microchip: let the board state its reset timing
Date: Fri,  2 Oct 2026 15:55:40 +0200
Message-ID: <20261002135542.359756-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEW1Yj8i3zhIjVzqiH5/fOMLH9cxuuPtIsrqzceN+Lma+S/NNovw7sZ/lCUX6xoepm5qAAjwIauvAlYtPtJlp5Lyafpje5W49a5rUlrdIa8LQkLe483K
 e6uqJ6If8ScgsNigVHFG19S6N5PnboyDEECtS4dXsyjgeE0QblHTYdJ65IsOtaYdBi/I47MdDMb9udSwqnOGHyN9pz6xqnuaZY+o/DnG9kGLMGWZK8EOeWka
 HIOBmx2E5/WjBwRqz3KmhS0NYL1P2mmg8nEns6pCC0TEONywr/HCaXgAalzJgLwrT4E+tgu6TCUAk8XsVUfAxKQoi0RD8D3yLfa4LPaHoOuzTORiEZO0Wyst
 hd68Z/2b6QtWbhq7HFmnRJljrVcfCzNYywePMX8+xQjQA2ns+BhUQqQuonYoTWV5K2+WfuzuCPrRBz+D4Y0gVEZ5+k2w6R1mQUuoqKTehbxoPS1bn1xv5gK2
 6EY2+A/BY3OuQtB1sc0a2NfMJJzmaAR5PcQ7cZXbYvCYgn46CcbbjgVWkYTzqdXiw160inXLxhPT7iTGxg2xhvljXueFka/c93us7mXGSCZBYNgMjADUNyhJ
 CQmv6+ELlVkX77e1ou+32T5vdM1+mM5d4mSCRkj6hmRtdXB4fyET29724ysva01N0Y3BuulliFFQohhN+7oo09K+

ksz_switch_register() waits a fixed 100ms after releasing the reset
line before it reads the chip ID. That figure comes from commit
1c45ba93d34c ("net: dsa: microchip: Adjust reset release timing to match
reference reset circuit"), which derives it from the reset circuit the
datasheet recommends: about 95ms for a 10k pull-up and a 10uF
capacitor. It is the timing of a reference board, and on one of our
boards it turns out to be too short.

The board is an i.MX93 with a KSZ9897 on LPSPI6 at 500kHz. Every boot
ended with

  ksz-switch spi0.0: unsupported switch detected ffffff00)

and no user ports, while a second board of the same family running the
very same image came up fine.

The bus is not at fault. With the switch already out of reset, reading
the chip ID through spidev on the failing board returns the expected
0x00989700, at the same speed and mode the driver uses. What differs is
how soon the part is ready. Driving the reset line by hand and polling
the chip ID every 11ms gives, on the failing board:

  reset asserted for 10ms  ->  answers 95-120ms after the rising edge
  reset asserted for  1s   ->  answers    ~160ms after the rising edge

So a probe that reads at 100ms is at best a coin flip there, and never
succeeds when the part comes out of a long reset. The board that works
is simply on the right side of the same margin, which is why one image
behaves differently on two boards.

Since this is a property of the board rather than of the driver, take
the delays from the device tree instead of hardcoding them, reusing
reset-assert-us and reset-deassert-us, which already carry exactly this
meaning for MDIO devices. The defaults keep the current behaviour, so
boards that do not set them are unaffected.

Tested on both boards with a 6.18-based NXP kernel, powered up from
cold, with the failing one given reset-deassert-us = <250000>. It now
detects the switch at every boot, and the one that already worked is
unchanged: same detection, no SPI errors or timeouts. On both, the
probe lands ~150ms later than before, which is the added wait showing
up where it should. On net-next the series was built, not run on
hardware.

Rodolfo Giometti (2):
  dt-bindings: net: dsa: microchip: add reset timing properties
  net: dsa: microchip: take the reset timings from the device tree

 .../bindings/net/dsa/microchip,ksz.yaml       | 12 +++++++++++
 drivers/net/dsa/microchip/ksz_common.c        | 20 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)


base-commit: 071876fd50482a68603a9460d80dd6dd58827ee1
-- 
2.43.0

