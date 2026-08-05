Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A63932DB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952166; cv=none; b=Y04QMYzwvfCyfdVywrEtGxOVq299iicFpZTb4YCa224htaB5wz+jlL0eJ2Zp9QZw6TQbA16T/OTzQEfvSd/KsGF1IcH2BgV2zxRvXi3940ZODELeZDu4MGtK4UUAbKr6womGZ6Dwo2jgNyoPfRVBStVPRueYcxqAM90Ry/E3hWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952166; c=relaxed/simple;
	bh=o98xVnT4COBnJxZ45bEwmqBnJwG6CT6AcnhDd8BkxQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZdhWl9FUHecWXfx4MUdz9v+5eci/srl7FYoPT0EfRLwzn6lOOlBztHKmH1unGPkX7jrCC8xQrR+QeNWiqD5n8AszrfY0MErextxhaGW+xU57NotU4atejWvp2eVIQcTrYjoQfRclpSrKlKPMEtxKr8bY+tV5pHDMGOm9xEjuQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUCiRPiV; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUCiRPiV"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-458de93b53fso582112fac.2
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785952162; x=1786556962; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IBQGTYyJQQ4o4r7qxnQpfIdQ0TE9l2pOB0fNSGOzrYM=;
        b=TUCiRPiVdekIH0Sc7xVG5u9VYStmuoDhB0gTeM9vuJYlf+dqXsfI+SpfH/j+V7gMr8
         jwNuVDsCnxyt4y3uUnD+xDchDx0JzfA2KIFBEwqoVACNq50NLzZGp7vUChc+7BSfAiz0
         AferY7DnvffpBeURNF6ao+nLi8yvSry7P03DGSa1mCZQl/Pb9NvdvhJjSC1xfbxDBkoL
         xUenLjnhq1ZqKKCGfA5/aBbAGWirk5ePbKX1YHwI3j0exUlAwd7jR3C3LCPl2Bq+so0Q
         0H4T3V+4HxSYD1sUtp2TztYzaMfZlYX0qhTxLpxADnRhhN+8QKPvSgCKoMXWRt4Pv1g2
         46nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952162; x=1786556962;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IBQGTYyJQQ4o4r7qxnQpfIdQ0TE9l2pOB0fNSGOzrYM=;
        b=CsRPXikp/MPX4jnq+LfF+F/nzYHTaCNmokAXlSX9SwRExEZ2Co5XFYFjv81RhEN2jb
         13PSGBRnazDnkVmUgOtsn6Kk2AadzYm0mkDTMihU03DlHtxZQVnS9uOrXZmS/zYrYb3G
         +wBmezCElsbmFoSCGDyfSbT9YKFKrpkONdq88F8HcH+U54izoFtS00LPWwKxg/cENAuI
         uK46Td6Waf6GHBVzwqF3TvlHYI2XD5MsI2yU6N17MI/+r58PtHhsLZhKkUhSgvrbA57b
         +TzmxmqYCtQAun6yQROEI9stSWQnwEDA8PX3z98HGec3nGsHmIzYKcdpFIhMmhuTvwks
         QOZw==
X-Gm-Message-State: AOJu0YwczNEjzOsse+xUrtQByRAgMEuUJDU6LboB8Vc2PPo8PS+6KZHF
	NPch/TPSZN+6R/oyMc1NRrF95+suv2IP/uZVXnClqrM96r2ssq5OdWbk
X-Gm-Gg: AR+sD13kKBaQ3Mu9k6StTmRlgUbwBGfc34iPn04HbwlAQS71s6/NtB1Pt3LOXZAxHpp
	B/8NtJj1L/JpUbkjGkFtqkk3/nQW7Eln97pWJ6+iPhxHU/cH9RrLgkydYqSHBcvvczRMorT0pqu
	55Wj3P6EnT9uqmVqG+JxOGkrYkYSKNKJoHr8CN/T7GFP04/FCzn3LFYsXbvNqAGnvX73vkmQAoU
	8YF8+ejOSaqHebHCGsM2GGjAJBcW7hpw8tf+GwKIYbDrUKsGg04FsAKC950708EGF07Usfd5Vxg
	1WuDKInBrHbHD1W372/RNLvtLwEQaDhdTzATQZn7dK4XaxM0J+hsvjGIl24gH2VV2JqJZt9jDiz
	w2uCAxn4pFB8KD6HN96S4q2ouGs+xC7wcJRq+zUpAoVGCMGFc7jTeeW30JHOlb/P9XDS6rsOrOK
	Mfrqea5G5WOVpM/uPXtW1PC6ZGVnD2G/tuQi+8jpu+JKFh7sSvLIR/i59sDzeMLfT+2Yd8HJHNq
	sQs9CAbZkDCTz9KgynnlSp2nXJa5zVouXZgI+133lrZeMIf7+I+hfZZLakYxcTKQ0Xf7cyfFWHK
	hFV2Aw2o6g9gb+8XUC9al2vhe8iwWoMvl1W3Ben8hM004HbXCNWB+ZZwqHl8d7NepRLZJhR4vNJ
	738kbqy2ZuKY6KNKe
X-Received: by 2002:a05:6871:60f:b0:43b:bb18:affd with SMTP id 586e51a60fabf-4599eb7d3e1mr4455586fac.8.1785952162103;
        Wed, 05 Aug 2026 10:49:22 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4599dd615ecsm3281704fac.0.2026.08.05.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:49:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v3 0/4] net: mdio: support dynamic OF device
 changes
Date: Wed, 05 Aug 2026 11:49:11 -0600
Message-Id: <20260805-submit-mdio-of-dynamic-v2-v3-0-16f3cc893b0e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBCEX8Xs2TWl/AiefA/DobQF1tjWtJVAC
 O9uwRcwmctkdr6dFYL2pAPcTit4PVEgZ5PJzyeQo7CDRlLJA2e8YjXLMXw6QxGNIoeuR7VYYUj
 ixLFhZcWkyMqmayD13173NB/sB1gd0eo5QvtLEuapZdzR++1IITq/HDMmfjT++JjEsK/rIuvzj
 Bfqeh+MoNdFOgPttm1fSLe4v94AAAA=
X-Change-ID: 20260803-submit-mdio-of-dynamic-v2-90560ca159b9
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

MDIO buses enumerate firmware children only when the bus is registered. A
later devicetree overlay or status transition is ignored, unlike on I2C and
SPI buses. Supporting live reconfiguration also means that population and
removal can race address scanning, PHY attachment and bus teardown.

This is generic OF_DYNAMIC support for MDIO buses. It contains no
Allwinner H616 or X-Powers AC200/AC300-specific behavior and does not
depend on either platform; H616 hardware was used only as the runtime
test platform.

Patch 1 fixes an existing lifetime bug exposed while auditing those races:
PHY attach and detach paths cache the MDIO bus but read its owner after
dropping their PHY device reference. Cache the owner before that lifetime
boundary.

Patch 2 factors fixed-address child registration and legacy PHY scanning
into helpers shared by initial and dynamic population.

Patch 3 serializes MDIO device-map changes, reserves addresses while
registration is in progress, publishes devices only after registration
completes, routes lockless map readers through the ordered accessor, and
coordinates scans, attachment, removal and bus teardown. Firmware removal
is exclusive with registration, scanning and other firmware changes.
Dynamically removed PHY devices remain pinned until bus teardown,
preserving the borrowed-pointer convention of mdiobus_get_phy(); generic
MDIO devices can be released normally because their lookup API takes a
reference.

Patch 4 adds the OF reconfiguration notifier. It supports fixed-address
PHYs and generic MDIO devices, scanned PHY addresses, and Ethernet PHY
packages. It preflights overlay removal before firmware nodes disappear
and refuses removal of attached or in-flight PHYs, including while another
MDIO map operation is still completing.

Build-tested on net-next under W=1 with arm64 defconfig, x86_64
allmodconfig under GCC and Clang, and minimal arm64 configurations covering
CONFIG_OF_DYNAMIC=n and CONFIG_OF_DYNAMIC=y with CONFIG_OF_OVERLAY=n. No
warning was emitted from a changed file. Runtime-tested on Allwinner H616
hardware from SD with 100 notifier-driven add/remove cycles for a
fixed-address generic MDIO device; rejection of an out-of-range fixed
address without device creation; 20 complete MAC/MDIO teardown and
recreation cycles with link recovery; another 50 notifier-driven cycles
after bus recreation; successful removal of an unrelated non-MDIO overlay;
and successful link traffic after testing.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- add a preparatory fix for MDIO bus-owner lifetime handling
- make teardown take a device reference and honor removal ownership
- use one checked callback for normal and dynamic internal removal
- publish map entries only after device registration completes
- route the remaining direct map reader through mdiobus_get_phy()
- retire only PHY devices which have a borrowed-pointer lookup API
- make firmware removal exclusive with registration, scanning and other
  firmware changes
- preserve existing error handling while propagating package population
  conflicts
- allow global overlay removal to ignore unrelated nodes and absent MDIO
  buses
- annotate the recursive notifier lock owner accesses for KCSAN
- avoid an OF/MDIO lock inversion during overlay preflight
- refuse overlay removal while another MDIO map change is active
- propagate removal-transaction conflicts from the OF notifier
- do not treat malformed fixed addresses as addressless PHYs
- rebase onto current net-next
- Link to v2: https://patch.msgid.link/20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com

Changes in v2:
- split the generic MDIO work from the ACx00 series
- rebase onto current net-next
- move touched declarations to function scope for netdev style
- Link to v1: https://patch.msgid.link/20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com

To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
James Hilliard (4):
      net: phy: cache MDIO bus owner before dropping PHY reference
      net: mdio: factor out OF child registration helpers
      net: mdio: make device map changes hotplug-safe
      net: mdio: support dynamic OF device changes

 drivers/net/mdio/of_mdio.c          | 514 +++++++++++++++++++++++++++++++++---
 drivers/net/phy/mdio_bus.c          |  14 +-
 drivers/net/phy/mdio_bus_provider.c | 147 ++++++++---
 drivers/net/phy/mdio_device.c       | 236 +++++++++++++++--
 drivers/net/phy/mscc/mscc_ptp.c     |   6 +-
 drivers/net/phy/phy_device.c        | 118 ++++++---
 drivers/net/phy/phylib-internal.h   |   4 +-
 include/linux/mdio.h                |   4 +-
 include/linux/phy.h                 |  20 ++
 9 files changed, 923 insertions(+), 140 deletions(-)
---
base-commit: a23b36233d4103def55dc8cf65698106d0bd1e62
change-id: 20260803-submit-mdio-of-dynamic-v2-90560ca159b9

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

