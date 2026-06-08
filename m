Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADD3A873C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952287; cv=none; b=FcDOImREJ58JOhu/x66c1SQHC9wyjb5zZ11plzO0oUCQrITpxQfLy/K2tziZxDuf/fdZSBxiucVsOM/4ET0uXtFGXstcvrE8dSl6f9JMCGa/og2NpxkihaRkX3wH5QId/Ulo40u/42cRXlE/a5fj0wUWmjEF3GT4rEP81T3ElDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952287; c=relaxed/simple;
	bh=xusiV+58yhYXd0TIdeOS6L6TQO1R1egJtOD0784EK3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEQFAkfh2UjMeFN/E6h557kiy9J41nTZ2y6nrQJ6IAZJFQg11JEyqOMRIRjqNBqzSlnORdFpwx6uzJ89evvEXYEGZKMdJ8myeHnTaMadIOM7H7r8OO+4i8+YCn8f/Tc2zgB/UX4PdFZ0zYzSHj/3iVWK/KvUAI0w86GQs0YwGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elRxAke6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elRxAke6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so13741755e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952284; x=1781557084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTQ1KaXLSBsahBxfVlFwG1v0to183HWN/l7wPZfkMLE=;
        b=elRxAke6h1gDxOQ4muoYilbVbnwCntbvWdYTJF4lNUV/fJI3eDSDu+pKvnfa6ltRh5
         CPLRQYdFIfIDJurVEqcJytDZrU+uDycn1jxOtIpHhWD6MUQVtIBcn779duzJj4RJzHrr
         eqTjbw+q2xF/VSiwmOKi+KeXaaA9YF7LaEdQ4JqgmT0/MglinE6n7GlRS/a68Cc3qUpG
         lL8whf+voCHBAvptpBUYWaB8PShI4o/eDLiO/59V/qRe/2k9/VC0KnZk84QOB9RjG2Is
         0LxY/CeZ9a17GNzOHAV4xnQMn15Dnp5hDrYMHOdMzvFiZs5dMVJ+aX2g5hsysc2wIVtO
         Ecjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952284; x=1781557084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTQ1KaXLSBsahBxfVlFwG1v0to183HWN/l7wPZfkMLE=;
        b=B/BScU5syNPrTaSKvpvk301NUBggMyB5YDB/a6lUA7Yv1pEMp2Z869XCxNZu5uZcn1
         DtBCVsdgLj3riYQRpVNrZrXs2dTLcZtYZz8wS2Z9pGNX4DY9KvL5CyGVZOzfzszIQZpe
         YP7iogNAe6TXewFgN4iqhyzKbfzoeLUmXpKlPJl/VK7ORwYAo/lnzseqdibdvqP2v8o5
         Z2PZXLDMtZtoUZnf9VGMEV9dtHroKDQfBLfyoJSlUfS/pD+fAzoAVSDYNwSWjr04xq8r
         uSJzUubFA1jt5omFVxbe+YxZLtlywenKZzePjvaE3cBvq0mKc4LK7ylJIOBp++ZOcjA8
         mV/Q==
X-Gm-Message-State: AOJu0YxezKSbwCYk+vQIqgs/CAqgqUAiDEvUEB6JyfmFzoITj+jI+k/5
	/CyG4aV1Zk9W3dVp+yU3nfzHzeXQPuH5bO5ALwM5R0cE9fViOezXdwY/
X-Gm-Gg: Acq92OF8KMc6IXGh0AgbKZUJ0s4hcTBn/B2Nyy2AIihvcwrLRfjGKVjf9QecVCefwEw
	3qRsUezAXo1MkeqT4I4P9//0yktTKBBgJxUr4VYBdYskrrWTDicFkOdZ3jlAQNtvnVqhp71s/D5
	jV8/ApBQqjCP0dpOMx1GIjfXoK36giy/ZrxKFTW2lvflO+U6sktiV0AUdVnIC2lB7QQiIdwgZ6/
	1YRe4cZIr8EF/zSZrmUp+MuKwresUmkWR7Suh0FCBhKSDQlefq3TUeVN6KLb8SRE22lc9aPFSpZ
	A31OzxcVX1NzKO2Pd4F8clWoKpO918vZp6F9gAE1UHfze28o8sv6d2eZSfSaPu4j6cfZfK1/bty
	msFp6PSofpu6bXg7MV8lanTB9jQkxo0e0X3U9wjBmy172mvLIiP/dZ83JTs6I4culSIT6LEBjqJ
	a5nIExMUPAcNb4cTYoz9Y5srK9qqSk5wYOm+H5
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr278543935e9.27.1780952283959;
        Mon, 08 Jun 2026 13:58:03 -0700 (PDT)
Received: from builder ([2001:9e8:f105:6a16:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d4891csm231011875e9.1.2026.06.08.13.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:58:03 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next 0/2] net: pse-pd: add Realtek/Broadcom PSE MCU support
Date: Mon,  8 Jun 2026 20:57:55 +0000
Message-ID: <20260608205758.1830521-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a PSE-PD driver for the microcontroller (MCU) that fronts
the PSE silicon on a range of managed switches, together with its DT
binding.

Hardware model
==============

These boards do not expose the PSE chips to the host directly. A small
microcontroller sits on an I2C/SMBus or UART bus and manages one or more PSE
chips behind it; the host CPU only ever talks to that MCU, using a fixed
12-byte request/response protocol with a trailing checksum. The PSE silicon
never appears on the bus.

The same protocol family is used by MCUs fronting Realtek PSE chips
(RTL8238B, RTL8239, RTL8239C) and Broadcom PSE chips (BCM59111, BCM59121),
diverging in opcode numbering and a few response layouts. The driver
abstracts that behind a per-dialect opcode table and parser hooks, selected
by the compatible. The specific PSE chip behind the MCU is detected at
runtime and only influences per-chip constants (power scaling and the
per-port cap).

Why the compatible names the protocol, not the chip
===================================================

The compatibles are "realtek,pse-mcu-rtk" and "realtek,pse-mcu-bcm". This is
a deliberate choice and the part most likely to raise questions, so the
reasoning up front.

The node names the protocol dialect, not a part:

  - The DT node describes the MCU, not a PSE chip: the PSE chips are behind
    the MCU and never appear on the bus, so naming the node after one (e.g.
    "realtek,rtl8239") would describe hardware that isn't at that address.

  - The PSE chips are, in principle, usable without this MCU (host-driven
    directly) - different hardware with a different programming model that
    would warrant its own binding. Claiming the PSE-chip compatibles here
    would collide with that.

  - Naming the MCU silicon is equally wrong: these are ordinary
    general-purpose microcontrollers (GigaDevice, Nuvoton, ...) that vary
    across boards and are not dedicated to this application.

  - What is fixed, and all the driver needs at DT-parse time, is the
    protocol dialect, so the compatible encodes exactly that. The two
    dialects share one protocol family and one binding, kept in a single
    "realtek" vendor namespace because this MCU front-end is found almost
    exclusively on Realtek-based switches; a "-rtk"/"-bcm" suffix selects
    the dialect. This follows the "google,cros-ec-*" pattern: a compatible
    for a firmware/protocol interface implemented by varying
    microcontrollers.

One compatible per dialect spans both transports:

  - The 12-byte wire protocol is identical over I2C/SMBus and UART; only the
    plumbing differs (SMBus vs native framing on I2C, baud rate on UART),
    and the transport is already expressed structurally by the node's parent
    bus (i2c@... vs serial@...). A "-i2c"/"-uart" suffix would only
    duplicate that, for a protocol that does not change across transports.

  - This is the multi-transport model used by e.g. "bosch,bmi160" (one
    compatible, separate i2c and spi drivers binding it), rather than the
    cros-ec model of per-transport compatibles - cros-ec splits because its
    on-wire framing genuinely differs per bus, which is not the case here.

The binding documents both points as well.

Testing
=======

 - Linksys LGS328MPCv2  (RTL8238B, I2C)
 - Zyxel GS1900-10HP A1 (BCM59121, UART)
 - Zyxel GS1900-10HP B1 (RTL8238B, UART)
 - Zyxel XMG1915-10EP   (RTL8239C, UART)
 - Zyxel XS1930-12HP    (RTL8239, SMBus)

---
Jonas Jelonek (2):
  dt-bindings: net: pse-pd: add bindings for Realtek/Broadcom PSE MCU
  net: pse-pd: add Realtek/Broadcom PSE MCU driver

 .../bindings/net/pse-pd/realtek,pse-mcu.yaml  |  154 +++
 MAINTAINERS                                   |    7 +
 drivers/net/pse-pd/Kconfig                    |   28 +
 drivers/net/pse-pd/Makefile                   |    3 +
 drivers/net/pse-pd/realtek-pse-core.c         | 1002 +++++++++++++++++
 drivers/net/pse-pd/realtek-pse-i2c.c          |  164 +++
 drivers/net/pse-pd/realtek-pse-uart.c         |  147 +++
 drivers/net/pse-pd/realtek-pse.h              |   70 ++
 8 files changed, 1575 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse.h


base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
-- 
2.51.0

