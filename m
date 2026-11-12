Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794519591;
	b=vLhGIOlUDyZLtTSna0rKfMIx8UvdhkVWPW7raVdIV37ETIKvlaGkCrvF0LCRsEf2ToHg
	 760TMnOldjwBWDqspKEWoHoEst5EyFDBvN0J6/l5hoK0JrSVN+NkPAZl1ccgL91au2vSk
	 VjfeDmg8Yr9gId+m0vZnYuG3TXN3A8Ni+D7YvjAHQIpR298p7MyM25HqY0VSWl4L0IRSP
	 PI9WxHlzRcpRw9syr0tDx+GhuIigGQSvhMVOmHbG5VtUeL8qqM4409qL91hF4j+AEGEs7
	 XLNB0QhsCl15ET/+b66fRo2yv6jvE43bpUsEGg41gIR3wv1bq5zMdo5z0pVIE1aGMOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794519591;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=5NMoOR0sdo7CgbVWGSxVCziMzV8yq95ZiIFRjgRJiTc=;
	b=Bhp/1xUh8sAJGkTR4LilIhHC+hoKbGDqDCDlmDr77GC55y1eu1EHchdIQy1X7ILRzN1H
	 Q9B+nOjS0QahgJ7C+fKcdONjG8hQU9Dij4rjfCtTF02Y+bwT6GoJ+nAk1mt0DBIP/7mI4
	 13Kljep4THIbGfyaYy0WKSSdHgiMPdXpjSmrCKxe0CuXAhcdqgVLFT+jJ59oy+pIup5yT
	 qTtRbpFvxpvNPEWAiuRf7FCeZWVcxPpvjWhn2gwkflHtE89kT3fj4P5irM2ZPhUTKbT5o
	 t3pl30gnu5Gryv5jjRICD+pNYwSfJHRIvpmnzwL7w6em/BlI8y1wRXz1uEVX5XhGjmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHu1dy7F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A0606A33A;
	Thu, 12 Nov 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHu1dy7F
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794519591;
	b=ymZqpTOAK6Cz9clicYPl5R85D0XGvMSE/u7CzHUQiq1ZseRXbIkWQYU7Nj7MQrKoky7Y
	 /CSKozhsEmUonsbti5P8vmgj1K2kudHEM6v1YkrvbKHbwvSlSmLXDMPsUCiPFlc7DQWG6
	 goAeEzWugyoEXBEDiFJN5LWyGgnCO5XRvaKA7udupq6qQSz66mGEuJn8ml/+Tl8jhPeMY
	 OqJzV6WlwesvSpwFbawGL2D2SdsR4O9cBaNdzBHQnXhOqXHPfj7QZ9HL2kMx5F2Lk+a88
	 ALlCDIm6clZ3uFCBIfqpBdqPaWpopyJsRvZJqOPTNhOnuiz5dQu544C5siumOpcRBkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794519591;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=5NMoOR0sdo7CgbVWGSxVCziMzV8yq95ZiIFRjgRJiTc=;
	b=XbZRCa4l1+eWBjOcCOeslrHRzHLGvM80T9L+/P8tsw8gvLjFRVXjvo/Q2MnYiANsXGn9
	 JD8yuxx69zayIyMqO296kmlYqIdV+Jdfgr7Du15mBNXZaU/tQE+DMEAZ7CsFJrtL5lkPm
	 4NvdO+i1ZXcwV4XI0M6/B4UPwl39QwNj3ftlKo2BvWlpOHEhpC8p/sh4OXDsS9F2TkG2R
	 u7n+68cAEtKcy+U88FhUtSeTeGZb6EOFpM+ZKtJqh3nWLeT7YaTypIdz4/eSwl1HclfL6
	 x/j5thVS2PdKnGbFDvxrw0HBVVCprI9tOS9zNrOK05YXHBZponVMjpJGoNYSMAsnUjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 09A851F000C5;
	Thu, 12 Nov 2026 21:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794519591;
	bh=5NMoOR0sdo7CgbVWGSxVCziMzV8yq95ZiIFRjgRJiTc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=mHu1dy7FZp62nABTTlUBcauL0vtvsrtbi8gq4gChL1RljDFN0XcBIJMS8YpfPCxfY
	 r70oxJg6iA+2ZlKdnpR1fc3z7sDN97vB9v23037X4fb1gzHTtrD9IXdfasBBTkEaPj
	 xG3s6D9gjZnW+/3HMQqivTVpIX8BSZfARumvJLMjL5uYHgaVk7ZD3adNUV/rxontw8
	 Tp9loSK0nFKd9+dBFRPmR0LWG8Ivupj8CTsn2cdIxek15gxubM+c0bUbwkOxjArSeF
	 4VzVhvJpgaBTrLaOTHN2mAJY/5WGoRry0gUWaJ3dQFswrmu3Tlq0NuPjtTanca4Jtr
	 eStx5W6RcLC5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 550674750F;
	Thu, 12 Nov 2026 21:39:49 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Subject: [PATCH net-next v3 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Date: Thu, 12 Nov 2026 16:39:39 -0500
Message-Id: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIABwy9moC/23NwRKCIBQF0F9xWEcjoIat+o+mBeLTKMMGiGgc/
 z2kFjW1vPPePXdCFowCi7bZhAx4ZdWoY2CrDMmj0D1g1caMaE4rQnKKL2HAvb2TELABCw6zjZC
 cVQ0jHaBYuxroVEjkHun4oCE4dHhd7K05gXSLuPwelXWjeaR1T1LjPVT8DnmCc1wyzuqmKyXns
 HMwCHFet+CT7+mnwP8INApFJUkr8prxmn0J8zw/AeTpEAMPAQAA
X-Change-ID: 20261102-mxl-gsw1xx-reset-37ac836b31fe
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794519588; l=2698;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=PzNRMlJ8hydRxArSVgRXqNp71nKnYMNDOQPUVvecNEo=;
 b=a/6ZOcXYhMZ8lCx79LgPFkxA+8lKA+mZAtP7QE5uKXknU76dDCX18N1XMKnYkf7oYfnTzmVp6
 oTxqcQLpZM+AECGw5uA5OCyfE5A2zIyUSjwGOhHfhaMPLdEEqsMV3YX
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
Changes in v3:
- Patch 1: say in the slew-rate descriptions that, without the
  properties, a reset through reset-gpios leaves the power-on defaults.
  Rob's Ack is kept: reset-gpios itself is unchanged.
- Patch 2: say the same in the commit message, and wrap a line over 80
  columns.
- Cc Philipp Zabel for the reset controller API.
- Link to v2: https://patch.msgid.link/20261108-mxl-gsw1xx-reset-v2-0-46c1da093893@telaak.dev

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

 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  | 12 ++++++++--
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                | 26 ++++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                |  4 ++++
 3 files changed, 40 insertions(+), 2 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261102-mxl-gsw1xx-reset-37ac836b31fe

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>


