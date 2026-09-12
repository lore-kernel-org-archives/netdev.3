Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCA47D928
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218280; cv=none; b=jSNjyk2Mdbt6eWo+ojeTltCoOLYh5QN/wg4IpA+/Pejs0GZp31W3h6VIiKktaVBg9Sm8dJBgfkP9pInmmn/FU/HLxLs7W82YKjftN4+YLyd4ZGa3idVumK/3p2UWXrb4pWbJSvypkfBIomrvfsni4KyEo2M+dei/z8TAT91Nw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218280; c=relaxed/simple;
	bh=lrJDZYIesz5lfa3S1SNxpOdY8ktjqo7PFji8Pr9jH20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwlaWxRVcZB5a9aLeWvip9gMGPTeGqJ3Ia42rg+3UhEyh7YV4OWzaXPuVq+4+lzTk22lZpIh5fQZQUuXFcXWRXgflIiizdRWG/VFjtkQBE6X/aQ2eoAmJBQXtzyuScXrQjwHqOZQnk46l7Fg3Nf/2j/XneoTaJ/F3fSESwznCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=CTSKV41j; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="CTSKV41j"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso398339f8f.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1789218276; x=1789823076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9Wf4msTC5//vRbQpoM2ZlYbsILyRTETawQ26GHJe0Y=;
        b=CTSKV41j4DkW/BHwDXM7O9yzjY8cc3jddw+sHbk2sd/QQB41UrfOKiQvprxQF5HfaJ
         /GcPcJ90bGF8OA5vKzJC60rAm4sK77UMNGiMCndLL6nvIoaN780NtRC/zGn7EMMuFcT7
         fvp1Ua1zgDEjb7ZC6CvkmjD47TIVFqY+tfRElyB0Ymcc/kZaBc6/KdIjF1EniNz/1UeD
         8Jsfr9kS15VhYshgD4QY9Dr2A0FpxRfVjmEGRHH/4K1pk7jUatQ8KgGxi+2/uytVGDiQ
         2E8C6VkNEwKMt0YUtMZoqnEQzelASiH7PN7f9epk02oLAbMcjno/I6b5FCULGVR1x8HW
         WrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789218276; x=1789823076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9Wf4msTC5//vRbQpoM2ZlYbsILyRTETawQ26GHJe0Y=;
        b=M/V99zsq0s28OrVJPgVY/uNeW3SKOKF6x/AvFHcqxwe4Qz+TaNabDlPrqFaNHGDXXC
         YlZhw3XGFO5YPgpEYq4ciwavY2yysp9cAg1iFmjfE+pyL9eLfxsEJ/nsilaDUfKIJKLr
         n0Oo/2U5Q5+RRJ1THlLHxedl6yoSUpIzK4XYkKejTeo44z9guhrSiUrEmXPkQP0dxGrU
         3P3rcgaqU69bd5y5y9kM+ExpyDDzzBl3jA/AxtoZXFycYEIlhl57inVLwFKmc/SlFimJ
         o5oYqaTgBeFCwiB0vX+SY627P5qu7yjvtEoR2zt6R9WmeW6slSZaD1MlPW3MQqQOKkYm
         eGPw==
X-Forwarded-Encrypted: i=1; AKwUvBwnZuv2tgOOw6rglPhqzjTbri9Lpg7Cxt0b2MzXRY4CEaVKvjqU9Gnk6fRPC7guAjJw80shInA=@vger.kernel.org
X-Gm-Message-State: AFuF++n1UhSMU7d4Q58cjacvjUBhV9qSpLxqA16epIsYGRypEFOg0pZv
	oVe9N4NPu3zzorFm6Nla+qPBDro6QrqtKY4msmhXP79ifH+85FqLmOeQ0b6t2Zq+jyU=
X-Gm-Gg: AYBFou3pgNAlCcv+UeKKtijQTKDqeLK5I0lehMuIhGSYhHFbpZ8KbTJCiyBEEcdwZPf
	3SOwLSnJpA4QNYDMX1HYinl5y/6ThLmkCpsLw/mapwbQSLMsOoOPCEJ5tU+g8LwHEneC/fwjmko
	TJEjWFgC0mjsZRSQU4fS6m536TLHjQU1SgivI3s6ZVT/TZVe8TKqMi4nTHqvLkulvU+ZgOrDRbr
	P3tbebp7i5ze1pK1/k/Z4keXOWE//MMYDJOh78e9/OFgBm3Odb1023dytCuxazJbR65Gqi+dS/U
	4Lg79TLmz5SBi39a5lwp1q83SqYadtzA61GAvpDonhLcAZg3usf68h3+ctwfRVA9ewsfyIYfpbX
	c3xGbpibaydsxME1ursXqf2KnaH1v3jkdacIvzAyR20949Y4fYOHVdlsP1/nKk5VUax4B8RARLO
	HBzXbpWLG2twItGW4I9De+y6B/lgmzLPPFFTlho4sFvbqqg8Xo5A==
X-Received: by 2002:a05:600c:19c9:b0:49e:6c9b:4e94 with SMTP id 5b1f17b1804b1-49e6cc11409mr23637875e9.28.1789218276314;
        Sat, 12 Sep 2026 06:04:36 -0700 (PDT)
Received: from remote-01 ([84.17.55.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm80985785e9.5.2026.09.12.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:04:35 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v3 0/6] net: mdio: an MDIO device driver for the Airoha EN8811H
Date: Sat, 12 Sep 2026 16:04:24 +0300
Message-ID: <20260912130430.2246285-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last version, not for application, sorry for the noise. The other
option was to drop this quietly. I would rather have the reviewed state
on lore for whoever has a board that needs it; I don't.

The board it was written for does not need it. With the EN8811H
described the ordinary way, the phylink half [1] carries the port: the
PHY driver is a module that arrives after the switch has probed, and
the firmware sits on the squashfs, readable by the time the module
loads.

The second reason v2 [2] gave, a PHY node whose detach wipes the loaded
image, is wrong. I tried it: reset-gpios on the PHY node, the 10 ms
assert delay the Bananapi BPI-R3 Mini and OpenWrt One describe, a
switch unbind that reaches phy_detach(). The MD32 image stays. A marker
written into its RAM reads back unchanged, and the port comes back
after rebind. v2 states the opposite in two places.

What is left is the one-shot probe: -ENOENT at .probe() is not retried,
so a board whose firmware is not readable at that moment either loads
the driver after the filesystem or embeds 144 KB of blobs. That is the
case this driver is for, and I have no such board. Rather stop than
send code I cannot run.

For whoever searches for this later: in-tree the chip is on the
OpenWrt One (mt7981b-openwrt-one) and the Bananapi BPI-R3 Mini
(mt7986a-bananapi-bpi-r3-mini), both with the PHY on a MAC that
attaches at ifup, so neither is that board. Nothing
builds AIR_EN8811H_PHY in by default, so the case is a custom config
with the driver built in and the firmware on a filesystem mounted
later. Out of tree the chip also sits behind the MT7530 DSA bus on
EN7581, mdio-airoha on AN7583 and the SiFlower xgmac; a DSA port losing
a module that arrives late is what the phylink half is for. The
AN8811HB shares the download code touched here and I have none.

The series describes the chip as an MDIO device that owns the download
and the reset, and publishes the PHY on a child bus once the firmware
runs. Patch 4 leaves a running MD32 alone, so a board using the PHY
driver by itself keeps working as before.

Andrew, your points from v2 are answered in that thread. Two things
changed since. I said the next round would go without the RFC tag; it
keeps it, because this one is not for application. And the two
questions I left you there, whether to swap the Kconfig direction and
whether to add a MAINTAINERS record over both files, need no answer
now.

Tested on a Netcraze NC-1012, also sold as the Keenetic KN-1012
(MT7981B, EN8811H on a 2500base-x switch port), OpenWrt 6.18.44, the
series carried as target patches:

  - The MCU driver takes mdio-bus:0d, the PHY appears as mdio-bus:0d:0d
    from /soc/ethernet@15100000/mdio-bus/mcu@d/mdio/ethernet-phy@d,
    DSA attaches it to lan4 with irq=15, the interrupt fires, link up
    at 1Gbps. No bind or unbind in the driver's sysfs directory, rmmod
    of either module refused while the PHY is attached.
  - Download and late arrival, on an image with no firmware in the
    squashfs: the driver binds, publishes nothing, warns once at 61s of
    accumulated waiting naming both files and -ENOENT. Files copied in
    at 103s are taken on the next poll at 128s, the PHY is published,
    DSA attaches it with irq=15, link up at 160s.
  - A PHY node at an address the MCU does not answer: one error naming
    the node and both addresses, -EINVAL, no child bus.
  - Adoption of an already running MD32 has no hardware evidence. This
    board comes up needing firmware on every boot, warm or cold.

Changes since v2:
  - mdiodev_lock() helpers dropped, 7 patches became 6
  - wrong-address and empty-node checks moved into probe, so they fail
    once instead of on every retry
  - child bus lock taken once around the whole programming phase, the
    firmware read stays outside it
  - a failed bus registration keeps retrying on -EPROBE_DEFER
  - resume comment and commit text had the order backwards; the MCU
    resumes before the PHY
  - the detach-wipes-firmware reason is withdrawn

[1] https://lore.kernel.org/netdev/20260908155729.4164814-1-f@lex.la/
[2] https://lore.kernel.org/netdev/20260908155707.4164559-1-f@lex.la/

Aleksei Sviridkin (6):
  dt-bindings: net: add Airoha EN8811H PHY MCU
  net: phy: air: type the buckpbus core on the mdio device
  net: phy: air: move the EN8811H firmware download into the library
  net: phy: air: skip the download when the MD32 is already running
  net: mdio: add Airoha EN8811H MDIO device driver
  net: mdio: en8811h: add the nested bus

 .../bindings/net/airoha,en8811h-mcu.yaml      | 127 +++++
 MAINTAINERS                                   |   8 +
 drivers/net/mdio/Kconfig                      |  13 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c        | 378 +++++++++++++++
 drivers/net/phy/air_en8811h.c                 | 155 +-----
 drivers/net/phy/air_phy_lib.c                 | 440 ++++++++++++++++--
 drivers/net/phy/air_phy_lib.h                 |  27 ++
 include/linux/mdio/mdio-airoha-en8811h.h      |  29 ++
 9 files changed, 999 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
 create mode 100644 drivers/net/mdio/mdio-airoha-en8811h.c
 create mode 100644 include/linux/mdio/mdio-airoha-en8811h.h


base-commit: ab217fbb9b2169ce677b09a66558d5c3adcfbb76
-- 
2.53.0

