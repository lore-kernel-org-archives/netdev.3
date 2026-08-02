Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62B196C7C
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685590; cv=none; b=INGFK8K2Lc8p/KdxdKaDNdaeCoULxLD5F3p3XwoKnDVIzOFjZe4F9wEs79xC9jbwe10eEDFSH0CtxGNPhS2HSmwU2lRp3oLzwEkLhqff+rY3IpJKQonQuI9a6GndjZB9YXQ0ch6uYtj71nCYB8ntn4A18A2RvJEincrfEd3361w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685590; c=relaxed/simple;
	bh=+jvAOF5SO3XqNwhCfQ0NZDjaKKztJGcQ5/Rywfk07Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nmocw8GCA56r/xOzQQFovIcIh9cMNqmw00oly+kdUnGqN6WyrSQKMJAcDGrIYKIbiqRrr+yUmHZRymnxt92BsQwpp0q5zCbw88s1TsKY+x5EJPh+3yHAC0vhBlDnQIivB+dUuLBBkLiwga6lK9qH2JX5cmJJuF+AZIsvszjEoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDr9yjWh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDr9yjWh"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso2182154a12.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785685587; x=1786290387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kbnrAvB6TS3MK29/B8lpsoG39eR5hWxmezJin1MS/dY=;
        b=sDr9yjWhsKeQY1txWWd/tHo+LXjUCXGNe+B15bh06Jzx77XCQcZoPacj/MLXU2r8BF
         qp2kGLCDUp2sd5UQCMv0zTgfHRc6e6R+qKc0cuZcfNr6Cxm+LKTGoWsylsD/xwFy1Hee
         ThJwno5M59GZG628WuCQuxoFk03SMZC8czkGZ/i4D92Uq/CY3ZWOV+Brd/jNZD0cEqzU
         inHSkEr5UCLXf8wlndPYx6S7SN8aoVTmYb5zcT0D+bVw1YNPJ8KjT3t5U5SocOnUAdL0
         atWEPiyhK8vJqbprWb6iK/dOssksGFrh66EH0Ixn3wMAgOUG7A/J6ShvO3kiqaQfNsp2
         5wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785685587; x=1786290387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kbnrAvB6TS3MK29/B8lpsoG39eR5hWxmezJin1MS/dY=;
        b=jfxb9kajAh1cU8WfU3ZrrBxer5eRQrP4Ue+/aWi1AXU3sQ4Q9bLzoNzzDE3YwqlVk5
         gIcI13QjNucBdPV0n9UbxxQ3jhX+ZfvB0OXk7QFYHkNyDo7Bg8QY/9z9fRWkqiuobIZ4
         rK4iJgyaWl5JWtfpKkDvgmzB5L1HZlyCgzXF766uHBq6kX/Zqtgz9xSVKvjaKubBPrXr
         5DPWrjlcbV3QxAqwW5xdhLx/sQUGreAg/ZkoEXNOhOXb1AF1k/PSE5Gt3h/Z6onuXffa
         q/IJvEZBEYNGXqFafyDSRchXwAv/GXij1wnAulo1foyTmVMJTGKiT8DS5xHlfrgkZnJq
         0myw==
X-Forwarded-Encrypted: i=1; AHgh+Rqd+UBf/uxX5pFhfVwxVVN0+f9fngtmcY9Pjz9IHE3fGorxRHZAdskdaCgMXdaF34+0Fl68z6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyI5ZXsw8OZH+tYqHoMfAw1O7baRpSusD8hZsCRX04C5ne1RGN
	MnGUEtvhx5jii2hcT966iQwNjx52HQ2dxDPaGjjdYNv/4bp0bodgLyVILsR3W+QQ
X-Gm-Gg: AR+sD121Vjec+kL+XIVyJ2QyRg2DrsIw4+ZHJvRw5aFiVGD9vyHtXglnce5CeWdHLzx
	//KC48IxaoMwf5NJe0wO2kxaIqKIGuiqe0tgtneAcbi7Uyj+KQHy1Fw/oylhNTlnkybfT8TgDrZ
	zqDzs2pnp9/fBGd72P67jLWb97m2N4t8hzT6oNDV6TEEOxdP4Tid+jHlK/H5A/vrPjEUrN/Ejo/
	pU7ZoyhAeiGIM3rxFNxliD1r43nAtiWPNMi8o3LsaLwAUoEUqBWcmonKKmLcOrxYr7LPI+pt8Ox
	AXiHn+5bBXBhoRSFWDiLktoIZNDWENuQTvB+4P4gR9VLz9NIPj6jhoDoh8RHq60mj0v+APggY8x
	oPNfjSEsJIaWIDodQU2xTmnlEhix9KlMAtZ890IGGKpdlIINIuTEgz1Leo5QYlP0SzQyhvEB+x3
	zmIdyEQbzCCYWg/ttHc2D6EycuOf7biSDVn6k6PHBJwIoEQ8s+A8YUkEggwwx7w2z1qUX4kHbzi
	g3n9pWFufRe1xDN6GFSwm4yTfvzyrLYQ6wKlNg=
X-Received: by 2002:a05:6a21:6089:b0:3c4:2cd3:f0bb with SMTP id adf61e73a8af0-3c91a777750mr9595530637.10.1785685587512;
        Sun, 02 Aug 2026 08:46:27 -0700 (PDT)
Received: from Mac.net (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm30602192eec.31.2026.08.02.08.46.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Aug 2026 08:46:26 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [RFC net-next 0/4] ptp: ocp: Add R4006 I2C peripheral support
Date: Sun,  2 Aug 2026 08:46:16 -0700
Message-ID: <cover.1785684064.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The R4006 Time Card places a PCA9546 I2C mux behind the FPGA XIIC
controller. Its downstream buses contain temperature, humidity, and
pressure sensors, an 18-channel LED controller, and a BNO08x inertial
sensor. The current ptp_ocp driver exposes the root bus but does not
describe these peripherals.

This RFC adds the generic infrastructure and board description needed to
let existing subsystem drivers bind to the R4006 devices:

  1. A binding for the Lumissil IS32FL3207 LED controller.
  2. A generic IS32FL3207 LED class driver with individual and multicolor
     LED support and per-output current limits.
  3. Software-node propagation from an I2C mux to its channel adapters.
  4. EEPROM-based R4006 detection and a per-card software-node topology
     in ptp_ocp.

The BNO08x is intentionally not instantiated because there is no upstream
driver for it. LED status policy is also left to userspace. The kernel
exports one multicolor LED class device for GNSS and one for each SMA
connector.

The zero-based IS32FL3207 output mapping, confirmed on production
hardware, is:

             red  green  blue
  GNSS        13    12    14
  SMA1         7     6     8
  SMA2        10     9    11
  SMA3         1     0     2
  SMA4         4     3     5

Questions for this RFC:

  - Should IS32FL3207 remain a standalone multicolor driver, or should
    support be integrated into the older is31fl32xx driver?
  - Is assigning software-node children in the generic I2C mux core the
    preferred way to describe PCI-card mux topologies?
  - Which tree should carry the cross-subsystem series once the LED and
    I2C changes are reviewed?

Validation performed:

  - dt_binding_check, including schema lint and example compilation
  - ARM64 and x86-64 W=1 builds of all three modified driver objects
  - x86-64 sparse C=2 checks with endian checking enabled
  - strict checkpatch and git diff --check
  - I2C addresses and LED channel mapping validated on an R4006 using the
    existing downstream implementation

The complete upstream series has not yet been boot-tested on the card.
One portability limitation is that the ICP10100 has a fixed 1.8 V board
rail but its driver requires a vdd regulator. ACPI server systems provide
the dummy regulator used by this PCI target; an ACPI-disabled system may
leave the pressure sensor unbound. Feedback on whether that supply needs
an explicit representation before v1 would be useful.

Ahmad Byagowi (4):
  dt-bindings: leds: Add IS32FL3207 controller
  leds: rgb: Add IS32FL3207 controller driver
  i2c: mux: Propagate software nodes to channel adapters
  ptp: ocp: Add R4006 I2C peripheral topology

 .../bindings/leds/issi,is32fl3207.yaml        | 204 +++++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/i2c-mux.c                         |  55 ++
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-is32fl3207.c            | 541 ++++++++++++++++++
 drivers/ptp/ptp_ocp.c                         | 485 +++++++++++++++-
 7 files changed, 1278 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
 create mode 100644 drivers/leds/rgb/leds-is32fl3207.c


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.50.1 (Apple Git-155)
