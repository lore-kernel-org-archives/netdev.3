Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F213AEB29
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307344; cv=none; b=bH3VCCPDpoHig9NTXIGHqGSGQWqGRj3I+tDjNTtaaM27h/bk0gzvdRJNxvMkdpYa/W/Y3JLQND1gnNaPqfuCOv4nF3NHgO6Ld9Zf1oUAWaaP+aF4QkGa4hUnaLbKJ5DCDg+iaLzUbU22Yo+MHNfo3IcsbQOXWcIkqm23XSgoFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307344; c=relaxed/simple;
	bh=fyiGki5oL1mtR50fYa+K1BlQfwrl2hRsAgPG/8W6kq0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cBflwlGERLsc3Q8NjHPf3SLeJtYafUbyyOBWj7MSSxvUWhbDvOHVm3bpUgeJGfgLUIH1cyMw2m5V7JlgKbTFqUGk30J5O53BEiFgsJAR6kzfJ+KQF9SRAqtK6kS2P/c3DzjvB13h+nhxSHCJu6sOBhS6e5Fv/fNdlNf+ZCaT2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpkFV+1f; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpkFV+1f"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ae9b721927so814914eaf.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307341; x=1786912141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v96AfPjp7gXHhBL7+XCzQDRCuy+dlaYHJlcDmlcO34A=;
        b=NpkFV+1fyLwuspeEDu/HlI2cu0S0WRLhQDHhipnowtAB6sS80DwxVkcGA/ih0PlJ9T
         A4cuQJSRgOL6mE7Qu/AjPMpIq5zcWTsnVvx+8f6mqNepJXFUkrB80xJg7Q/M7FvvdQJ3
         HLNQoAF4rN1Jcsv0PD06agexa7HRfStPtZaM1jhUS0Er5p+BgRnRpflpx7amzyhn8YBk
         uwZylVpXV78FrHQLUHEUH6Q6TWuxGolmGtgnR0rdqHyNCPzUMSW7J3wnXsqZeHwRKgHb
         uvLbr1oYZt8o8cBMGdIfiCVg3kq5LmSP1gQl150cHs0WQEarjVOBLMWmns2UEAnH82dE
         iXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307341; x=1786912141;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v96AfPjp7gXHhBL7+XCzQDRCuy+dlaYHJlcDmlcO34A=;
        b=Jt3KboCaHGVDg3k+zQlh6rjxw+XUMOJa+s/rX+lSxw4M9H4zRiQcGISrglikc+virf
         DoF8/H0/2MHTCWOXaDBoxasTwxHaaq3DWl4gTCutl+iotTBfiegfK0hXr2ITH6Xl9jQx
         Q/E52VzGFw21UlqsqbqEW/tU9qEAG0L9a8GMUqMinV5REIYYd8/sNFatmTMHZ4zjwpN0
         +Wr/w4Hyhm9oOS9maOJxhvcu8y3Y/1JkY5MHE0VBz+JWsVNjs4MEh/S3XDN2YuMk8s0r
         e/ZmS+skf4HGmYqbOT8But6MMsPtMyyLj7Z72obqE7UYp9QbU11kYBT6Y2uKqONxSHLt
         ckSw==
X-Forwarded-Encrypted: i=1; AHgh+RpGrKgg2OHd0+KozLWsqSqueSpMdi16MOOe9gaQex38Fjvwio8drCNfl5c0+Asa1EXAnxpZKPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNjfeqHJseMkr8zicQ4Jfs3eFn/up2hNkRu1sPeKOATUPJDId
	Ly/eOl90kDrzgOswQ3K8OZxxWy8WfYSW/VJjRxa9QL4eV3EHBc3SrTmT
X-Gm-Gg: AR+sD12cdFBrTNpnTiA71NI3nZSsnfJF3N4dRxu35gmndQq5oZDU2to+/FNVK09xvjM
	wr6bGi2m1WCYATtrXwA/O1ghiNusTsx6SzSHMPnstkp9NMRwrb7rSB8lZdpyKBjPZXmwEKIuD2N
	mEsd6G4AXkud9ZUPuhn+leGYq4eQYUwNmtocQ542z5OFEsTi5hlztooXtOYqo9/7bfSiDZg3FXm
	fgIT6WxEzZ30WmcnRX2HSREAj4gsBTrsl3ADwV8kJ28ux3fjuUQwiN0XQIC3GdJ3tZ6ZKDECYyl
	w/EExv/ZBPDNjFSlm2ayrn4zigEefhgpcaCLnON0+uF11UPjjYXwm3RMmNz8C9J+qsnNzymIfkr
	KJt8im5md+DvXXRIdG7SVd/oCfMzsIzKPoCQSULjTIBOqWXAPQkToJQz8sEmXC0T3xDV7y/egj5
	0cQX0BNPENktzfrrW/c3IAjAU4wbE2l+VDD1BtvQUNSBqkqT9a0pbhjBvYIuvbi1jARIq3HLTt1
	kyFBVA/PCk2TdIevZ6TnMTVLZQNwfbXvqyQtz20m8eM5/wiFKR1qN/Gc3AuWlrQhyNfKCMcBnPq
	9qFjdyVsmDi0zgC4fuZKRDa95tgeoY5PVWYkrprfMjdCZkGQB9DbjRWm0tc1eB5niDn/EFVXg+Y
	L88d1cK8lG3kqA3lt
X-Received: by 2002:a05:6820:c88:b0:6ac:a8ef:9a86 with SMTP id 006d021491bc7-6ae96cf7403mr20483686eaf.15.1786307341184;
        Sun, 09 Aug 2026 13:29:01 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm6975362fac.1.2026.08.09.13.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:29:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net-next v5 0/5] net: phy: add X-Powers AC200/AC300 EPHY
 support
Date: Sun, 09 Aug 2026 14:28:30 -0600
Message-Id: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OwQ6CMAwG4FchO1szuoHiyfcwHubYsEaGYXOBG
 N7dgR44cfzT9vv7Yd70ZDw7ZR/Wm0ieOpdCscuYvivXGKA6ZYYcS37kCP59aymA0gPn0FmoR6d
 a0hBzqKTitc4Li0dkCXj1xtKw4BfmTABnhsCuv0lyHkaH2Z537+RD14/LH1EsF//KYqsyCuAgU
 AvMuSotFuemVfTc665diqJcU+UmJRNV3Szag5R5KXBNTdP0BZ/L4worAQAA
X-Change-ID: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2

The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
report the same Clause 22 identifier and use the same link-side register
layout. The link endpoint is inaccessible until package-specific control
registers have powered and configured it.

Version 2 represented those control ranges as separate devices. Version 3
instead modeled each variant as a standard Ethernet PHY package with one
forced-ID link-PHY child. The package reg value is the link address.
AC300's control range is a fixed package-relative offset of 16 and is
accessed with the PHY package helpers; it has no separate DT node or MDIO
driver. AC200 references its I2C MFD because the corresponding control
registers reside in that multi-function device.

This revision retains that package model and publishes the AC200 regmap
through syscon. It adds managed registration for externally created
syscon regmaps so a removable provider can withdraw its entry before the
regmap is released. The PHY establishes a managed device link to the AC200
I2C device before looking up the regmap through its firmware reference,
which keeps the supplier bound until its PHY consumer has unbound.

Fixed hardware uses an AC200- or AC300-specific package compatible. Systems
which can contain either package use the ACx00 package compatible and one
packed SID configuration field. Bits 3 through 0 carry the analog
calibration, bit 8 selects AC300, and bit 9 selects its low-calibration
tuning. The driver chooses the backend before acquiring any
backend-specific resource, so an AC300 system does not instantiate or
access the AC200 I2C device.

One xpowers-acx00 PHY module binds the link child, joins the parent package
and runs the selected AC200 or AC300 backend. Only the link PHY registers a
driver. The common implementation and the private backends live in an
X-Powers subdirectory and are linked into the same module. Thus the PHY
driver owns the complete Ethernet PHY while the AC200 MFD owns the shared
mixed-signal chip and its regmap.

The package node owns a common vcc-supply, connected to EPHY_VCC on AC200
and VCC1 on AC300. The PHY driver manages that function supply and can turn
it off while the PHY is suspended. The AC200 MFD keeps ownership of the
chip-wide system input clock.

The series contains no CONFIG_OF_DYNAMIC code and no generic MDIO
reconfiguration. Firmware must make the selected AC200 provider path
available before the PHY probes.

The common link implementation performs the vendor analog initialization,
supports MII and RMII, preserves automatic MDI/MDI-X, and restores package
state across suspend and resume. It preserves standard MAC-managed EEE
advertisement while disabling only the vendor PHY-autonomous Intelligent
EEE mode.

The five patches add the minimal AC200 MFD binding, managed registration
for external syscon regmaps, the AC200 regmap provider, the AC200/AC300
PHY package binding and the combined PHY driver. Board Device Trees and
optional PHY features remain outside this initial series.

The AC200 portions build on earlier work by Jernej Skrabec and Andre
Przywara:

  https://github.com/jernejsk/linux-1/commits/ac200-v4

Public AC200 and AC300 documentation is linked from:

  https://linux-sunxi.org/AC200

Validation completed for v5:

  - arm64 defconfig vmlinux and module builds with W=1;
  - x86_64 allmodconfig object builds with W=1;
  - a built-in AC300-only configuration with I2C and MFD_SYSCON disabled;
  - dt_binding_check for both new schemas;
  - strict checkpatch checks for all five patches, with only the generic
    FILE_PATH_CHANGES prompt ignored; and
  - managed syscon registration, lookup, supplier removal and re-registration
    on the running kernel.

The final AC200 path was hardware-tested on an H616 board. The packed
configuration was 0x001, selecting AC200. The MFD reported revision 0x101
in package 1, the PHY obtained its regmap through syscon after establishing
the supplier device link, and the link PHY bound at address 0. It applied
RMII mode, negotiated a 100 Mbps full-duplex link and passed eight MiB of
traffic in each direction and 100 consecutive pings without loss.

An administrative link down/up cycle dropped the package regulator
consumer count from one to zero, restored it and renegotiated the same link
mode. With the link administratively down, unbinding the AC200 supplier
unbound the PHY consumer before removing the syscon regmap. Rebinding the
supplier re-registered the regmap; rebinding the PHY then restored the
device link and the 100 Mbps full-duplex link.

The final AC300 path was hardware-tested on the connected H616 board. The
driver read the packed SID field as 0x106, selected AC300 without enabling
the AC200 I2C path, accessed the control range at package base plus 16,
bound the link PHY at address 0, applied RMII mode and negotiated a
100 Mbps full-duplex link after a cold boot. Eight MiB of traffic passed
in each direction. An administrative link down/up cycle disabled and
restored the package regulator and renegotiated the same link mode.

Assisted-by: OpenAI Codex (gpt-5.6-sol, max)
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - model AC200 and AC300 as standard Ethernet PHY packages
  - remove the standalone AC200 and AC300 control bindings and drivers
  - put the common link implementation and both private backends in one
    xpowers-acx00 module
  - access the AC300 control range at package base plus 16 with PHY package
    helpers
  - access AC200 package registers through its referenced MFD regmap and a
    managed device link
  - add an ACx00 package compatible which selects the backend from one
    packed SID configuration field
  - combine calibration, package selection and AC300 tuning into that field
  - optionally activate only a selected fail-needs-probe AC200 path when
    CONFIG_OF_DYNAMIC is available
  - preserve standard MAC-managed EEE advertisement and disable only the
    PHY-autonomous Intelligent EEE mode
  - reduce the series from eight patches to four
  - Link to v2:
    https://patch.msgid.link/20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com

Changes v3 -> v4:
  - rebase onto current net-next
  - always restore the PHY page and release the MDIO bus lock after a
    page-selection error
  - preserve AC300 external-VDD configuration until package status
    identifies the supply arrangement
  - remove the unsupported AC300 MDIO-error clear/readback sequence,
    which is absent from the BSP initialization
  - remove AC200 post-reset waits not required by its documentation or
    hardware testing
  - report the failing AC200 control register
  - follow MFD subject and driver-data naming conventions
  - use the AC200 teardown callback directly, follow reverse Christmas-tree
    declaration ordering and use a named I2C ID initializer
  - use named input-clock rates and simplify MII/RMII selection
  - avoid blocking on the AC200 supplier lock while checking driver
    readiness
  - Link to v3:
    https://patch.msgid.link/20260805-submit-acx00-of-dynamic-v1-v3-0-32c3210a6f25@gmail.com

Changes v4 -> v5:
  - remove CONFIG_OF_DYNAMIC path activation from the submitted series
  - publish the AC200 regmap through syscon and add managed registration
    for externally created regmaps
  - resolve the AC200 regmap through its phandle after establishing a
    managed device link to the I2C supplier
  - move EPHY_VCC and VCC1 ownership to a common PHY-package vcc-supply and
    manage it across suspend and resume
  - move the four PHY source files into an X-Powers subdirectory
  - remove private backend mutexes because phylib serializes these
    lifecycle callbacks and neither backend has an independent worker or
    interrupt path
  - rebase onto current net-next
  - Link to v4:
    https://patch.msgid.link/20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com

To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
James Hilliard (5):
      dt-bindings: mfd: x-powers: Add AC200
      mfd: syscon: Add managed registration for external regmaps
      mfd: ac200: Add X-Powers AC200 support
      dt-bindings: net: x-powers: add AC200/AC300 EPHY packages
      net: phy: add X-Powers AC200/AC300 EPHY driver

 .../devicetree/bindings/mfd/x-powers,ac200.yaml    |  49 ++
 .../bindings/net/x-powers,acx00-ephy-package.yaml  | 207 ++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/ac200.c                                | 170 +++++++
 drivers/mfd/syscon.c                               |  87 +++-
 drivers/net/phy/Kconfig                            |  11 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/xpowers/Makefile                   |   3 +
 drivers/net/phy/xpowers/ac200.c                    | 315 ++++++++++++
 drivers/net/phy/xpowers/ac300.c                    | 387 +++++++++++++++
 drivers/net/phy/xpowers/acx00.c                    | 536 +++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h                    |  28 ++
 include/linux/mfd/syscon.h                         |  12 +
 14 files changed, 1797 insertions(+), 22 deletions(-)
---
base-commit: 001b5d347d8ba39b2dccaefcc57967b18caec8fe
change-id: 20260802-submit-acx00-of-dynamic-v1-94a0dc15f282

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

