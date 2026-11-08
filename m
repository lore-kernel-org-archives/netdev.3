Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794178814;
	b=oflLno98X03TKO3NBIxFxLrcz0R7G1v6/fB1Ccu9OGZ94VmfOFkFFs7ZzjL655maVu74
	 FU2cOQnOIUqjsYV4SFOQ/Q34D3XKnD/r03TDqE1kq6S9qBqbYSc0Jt6E6AYy/7KSi1az8
	 n0LKukTmYdLa018ddEnXhuSSOt/5bgybS2AEvfZjyC4m28PlUulLIHGFeuCkuhPm37XCm
	 Z46MZ5nwe9uDxtM2Uf+4dNqluTKJrvg3fjryjzrRIJFyhBFSiuM7dxsYODzyIgM4+rGze
	 H2l0Qwike2V2yHDbeA2lG1tdIyzFZ7unesIE2KDgyezfpywGeLmZTZRNK6Jgd9pADGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178814;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=bMP7j68x3PMM1IBkF2dBr6dlucgKTFleWZgyG10h8LI=;
	b=RAYC6njrLDFs6gsybZDRjZbnXt+6OPvic5nDxBo64XGUsTT1orCsTz4dMnCcgZFULp4L
	 bbtVgjIRwtFF3FiaABdgfvEifmhpG/NBb1MbYqo6gYWDhr+KfnDebI7mjqM5QHbISbUez
	 JM31Rqedj+rnzPyKY6c5bW20ct3v0F7BGNDBMA/zjWqynJZoAm3DiZQeQt5GvWZoBVXY1
	 5TOrwnvPxNnal+EXmObopeP3GOq5L9ABEBAhaQ9zvd1nMWeX09Pb9W7vivZeAoaqQ2+Ab
	 QwmFgLAoMeyLxkNi6xYx4j/eXtYSwfb42wmpWRE26eKZRRWuJQsqN0yNTWrd2mgp4Ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH1hjCrg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C5606A326;
	Sun,  8 Nov 2026 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH1hjCrg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794178813;
	b=jcxRdo5/3YqRBFVs113EhetbiVv6qLgvEcl9fT7Ab2RTq0DNGQVmVmfgk9/cIxnqogY2
	 OwNKg9ESUNcAsjeIhJrEXeb42dEhT2KJNjYXraMDRgPvMvqaC7liHXnRbnzf2sR6zkcVN
	 YX0yFt5FSnlzsQuzuMASW2yhQhmiVahvRINyw5+4qsGuh9mfgfT+J0oF0jCz0Iy9Jv4MY
	 CWsD+C61X6Yo2e+V32EwcpuRiyZ3gM/HJCrhiczmPNiW5TZXFLHO/Xsj0AUpouJmOYOFb
	 kpEgELCSUZ0GQU0uh3vYSRixMZaSI+x9aVUic8fh/p1KWaQcn1at8Wat+0QTQPt4o9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794178813;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=bMP7j68x3PMM1IBkF2dBr6dlucgKTFleWZgyG10h8LI=;
	b=DM1Vl19v7fQmWhCSK8m3AwPowX9GFR1UaCO2lBO4D5IdxRv4GNgBJUeawZ068oV7wqvX
	 vX7qKPS1L453blxAzE6oNb1etUph4biwIWGNIyZGOto2zB6AKxvktNIiJ2tjCU2rZBbNv
	 soOhaOMwPfaVrKFcDV2VsnRbc4j8pGGUdCrlrffueYfR1e3fLN+7oQtrMU5TyrxvyeVgS
	 KLVsL0plyY8EdLEpqV5yPj6KUebeWIc91VzYSjQYb1p2TPdVE1zX57ATdilRFI1o88CRC
	 f0Y39OtOQAQr5zYQBABFdb2ZoFsnsJ/H2VG57w8B5/TjQzpKuDqr4v9R+RzqYbH+Ixw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2419B1F008A2;
	Sun,  8 Nov 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178813;
	bh=bMP7j68x3PMM1IBkF2dBr6dlucgKTFleWZgyG10h8LI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BH1hjCrgwrba9ntU2mT9kLaq9X2l4h+X4+ROtjo9YTisWDjcNuWIRAEEdSAC2+xYb
	 wXfMdg7cHshSQSoNM5eY68b1BKnOqJXykph4bBt9hazOO+wZXM7/BhA77GFiWeaYMy
	 cocoKNbcWmSlIcC1elCaglvBIlbecM0ILiFRr15SqktAuQzRNIEEUDNfyFdQnLVoGG
	 QX5qannepa//8Mirj8dOw2uNbJJio5gp4zrexbcX/VOKeEHpAfo1gAUMZ3se4fHn7z
	 0Mxt/Utj+9QGcWo5vRbqP80QYmiNNjHZe3jbPQB1N6rWNyptkbGtX4l5IofbvujsSN
	 jShJdTUtGMKcg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A1D9D48153;
	Sun,  8 Nov 2026 23:00:11 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Subject: [PATCH net-next v2 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Date: Sun, 08 Nov 2026 17:59:49 -0500
Message-Id: <20261108-mxl-gsw1xx-reset-v2-0-46c1da093893@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIAOb+8GoC/2WNwRKCIBRFf8V562gE0qhV/9G4QHwqpdgAEY3jv
 4fWruWde889Mzi0Gh2csxksBu30ZFJguwxUL02HRDcpA8tZSWnOyBgH0rkXjZFYdOgJP0oleFl
 z2iIk7GGx1XG7vIJJA4PRQ/Vt3LO+ofLr47rttfOTfW/2QDfiJzr8iwIlOSm44Ke6LZQQePE4S
 HnfNxigWpblA9vgvMPNAAAA
X-Change-ID: 20261102-mxl-gsw1xx-reset-37ac836b31fe
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794178811; l=2239;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=f7rumqhBXVUbXmTQZIshRAFnkK32CNzOSjjgSSKpiR8=;
 b=QPAUW8a6ugRpkrJXJB0dpgxYkTIc00FbTxffLAyGFvXNzMo0+oOzQN6D7pmH7oGNVdOW5byIQ
 9vzvn8KKZvODJte0VI1bitiTyaXrXpToT4D8bLxZliyOTdg7afkj0KT
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev

The GSW1xx driver never resets the switch, and the MDIO core does not
handle reset-gpios for non-PHY devices, so the driver works with whatever
the bootloader configured. On the GL.iNet GL-SFT1200 (Siflower SF19A2890 +
GSW150) the bootloader leaves the internal PHYs one MDIO address too high,
and the WAN port has no PHY.

Patch 1 allows reset-gpios in the binding for the standalone switches.
Patch 2 pulses it at probe.

This is separate from commit 82e2c7db0830 ("net: dsa: mxl-gsw1xx: force
internal PHYs into a known reset state"), which only programs the PHY
bits of RST_REQ. On this board that commit is applied, and the PHYs still
sit at the shifted addresses; only a hardware reset of the switch moves
them back.

Tested on a GL.iNet GL-SFT1200 (Intel GSW150 / PEB7084 at SMI address
0x1f, reset on an active-low SoC GPIO), on v7.4-rc1 with
CONFIG_RESET_GPIO=y: after a warm reboot and after a cold power-on, all
three ports find their PHYs at addresses 0 to 2 and link at 1 Gbit/s.
Without the patch, port 0 fails with -ENODEV after every boot.

There is no in-tree user yet: the GL-SFT1200's device tree is under
review on linux-mips without the switch, which follows once the SoC's
GMAC is supported.

---
Changes in v2:
- Use the reset controller API, so reset-gpios goes through reset-gpio,
  instead of driving the GPIO from the driver (Daniel).
- Use the vendor driver's reset timing, 250 ms asserted and 1 s before
  the first access. v1 gave 2 ms and 100 ms as the vendor's, which they
  are not.
- Patch 1: add Rob's Ack.
- Link to v1: https://patch.msgid.link/20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev

---
Joseph Telaak (2):
      dt-bindings: net: dsa: lantiq,gswip: add reset-gpios
      net: dsa: mxl-gsw1xx: reset the switch through reset-gpios

 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  |  6 ++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                | 25 ++++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                |  4 ++++
 3 files changed, 35 insertions(+)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261102-mxl-gsw1xx-reset-37ac836b31fe

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>


