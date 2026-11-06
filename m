Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007137;
	b=SnEVpSUtg2MH9niUr33VEWkNvWgfBl/jHdJnw+ALB4rc5K8RHoBg54vLaD9VQHE3gbHu
	 8Lz2lrFAkkTVU6IbmOj0XE/b3rSJbEPzrspGYjQEf1Tn9TnOOu/Vjxm5yOAyRheAYHR7W
	 oXdCjZ56E5Xf146q0Do6bt5L5naO9NEtM2qEKHcd3/etSDImb2UfvK/NBXnblfkxILUfb
	 kvWT30TYj4xBf7O3aHQbpT6ZTP25WmLa/5SEA/CssDYm8JvRMFe00fbCn4ra7ksb6VOPL
	 UYf1DWkFIvvUw0MmXq0r8yWPazXEmSNeHsLBjzzEBL1JUpZAVOw1mWyPIGw2BIQsH+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007137;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=O71YwAfQ3CxBrHCRmLTtTo9WELf2TULk27qTgQln2gY=;
	b=af+5IpdgUxxiFjBqDKeZ8EXcOZ1NFbEaVCyy9O9GW4NHIYpNrma1S3q0KOGy9fTxc8ss
	 egGSjrtYqTA83OJvO0Pkw1W5tW4DHWRjIyMNsFGf6mqkvE7SPXJ/P7DID7naSdxnsBJhg
	 THk1BWarWqHP9KAhgQjyi2vlJpA0RigSubpxZzhVQk8OJJf13FkPUYmSx945aOUvg7GGG
	 7tOSP+6/9c2MiQoUvLc5xwSKkudl6Y9cXp87ug16+TAukY2LZy9SQi5QuOOrrIdl7vqJr
	 BkS9zugeZJxzgUlzEU7AEiSAGcvqq3ZH18KO89HVPx0w6GuZh4nfg4gq4XUofdZ/PCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr1+aXWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E4606A32E;
	Fri,  6 Nov 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tr1+aXWE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007136;
	b=IBGklC5Tg/RQXlu2ie9ba+h3durwTeoENIJluLMn5vYtNqdOayNtdcYKVCSHPqiGQPgU
	 Gv759ulDGX1NGoq/4Th1di2k4pu/n9VF4YNzSFqNklVbvLPDMRHOXFgXQtozRsFq388ik
	 r+zyN79X0NKDX0WXZMYcB6+5EPHOe8DwSvWFzQqEtdnlugzRwyeunVH2oDnsPazemgyMU
	 Aa35xfWIje7Ey8sYy8rQb7BIkXjXh1Swh6YuwlPAJQoWlikSNGvvKWy5UuHsmagxP5gz5
	 LjQ97gStVmnZNCtg363Y1cxWVDzyaUDDofCIXWPM3kwcQWxXS1q2iQ3Q6LmBRhKgAqg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007136;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=O71YwAfQ3CxBrHCRmLTtTo9WELf2TULk27qTgQln2gY=;
	b=YFLE1caaTpFEQELJ6TBEc1yLQT1CU+XkgJi4KQj/2wKNTWJzDA4bDf4I4HU2BgZ/zFxh
	 MjIAt/sdCJJ/lul+lmk65brS4a+Vja9Kylgv/FltzVibirk7dL23OXSHlW94pDtlTVOQF
	 VfnFeBdE14v+9iFnFk3qqzvwFIZwt/ScAQisQWKJrY0OcNsjInq877thTFW6Em8JiIUJN
	 tGQFAI9fHUu4//Y/V0MzLqwPHLKpbABhmnDX5PjrfFBEIz7sm+5lzHo1B1zlEnYrC9R/A
	 e0cCO4UYGdEkPHtwr3oNRHyQZwaqlJiXXHnXUXkcGbQ1Hj6t7afaO0fLr53m/vphAew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F5711F008A2;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007136;
	bh=O71YwAfQ3CxBrHCRmLTtTo9WELf2TULk27qTgQln2gY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Tr1+aXWEc3PlXTEyXkp14plxRclNVx8rBhEtzn3/afNFqMCeOZGnjmwUor6c4yMV/
	 5jykr2xrNl5piaJRf7gTBe93uBVfpFZfm1mDBZcU8VuwjZzN3nFec5Er7tge16U/DX
	 JVlyry9xU+MXiIEGq0/5a5bONcfEl9XDW6El1RVaeLOvBLyVfuRbrCSrdRtZ+n9KvB
	 FtVLgr5tx2L/nalSRt7YUoC3kh7yqGb5nQ95UwdPdm1HzMfj/jG6rXI8BW6wMxXLSR
	 o84WL8rTtMtzfpjWrwoCNtdomF71AjJpi76pyT7cq37QAR15IhwPNXHD7DNLA1iy9B
	 w5NGHX1Xdq/dQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C192C478DC;
	Fri,  6 Nov 2026 23:18:54 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net-next v10 00/11] Support for onsemi's S2500 10Base-T1S
 MAC-PHY
Date: Fri, 06 Nov 2026 15:18:46 -0800
Message-Id: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
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
X-B4-Tracking: v=1; b=H4sIAFhg7moC/3XQzW7DIAwH8FepOI/JEBJDT3uPaQdCzMKkfCikU
 asq7z6STWuniCPY/v3BdxZpChTZ+XRnEy0hhqFPBwEvJ+Za238SD026YBJkBRUIHmUJwDvr+Nj
 eeLyM4zDNXPnCkpHgayxYmh0n8uG6w++sp5n3dJ3Zx08lXuovcvPGbr1tiPMw3fY3LGqf+E0rM
 2mL4sAbSmlOFK5q9NvQR+rCqxu6PWQpnxihckyZGG00qhqlR1kemOqJkSbHVIkR2hGaVC5QHBh
 8MAg6x2BiFGqnEa0V1hwY/WCMzDI6MUgghLXOFXBkzB8jALKfMtuKHXkSDdQemn/Muq7f9ICNQ
 zsCAAA=
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=8502;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=mgpeoSJkv6FNq6OsRigHMZkeJxnOEduvOPGvcm9hPqI=;
 b=6Ve0oTZHFLex5vRNbjrlYdsSescHSkkimy+YGVv2ELlgQJv+0ASIW6kU4ChR2IFRTdrXji+XG
 ZInHvuklTfqCtdV/PgTq3qHX951iiNFo8HdAUgVEfVZhyKq/r2FDeo8
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

This patch series brings support for onsemi's S2500 that iss
IEEE 802.3cg compliant Ethernet transceiver with an integrated
Media Access Controller (MAC-PHY)

Driver implementation is compatible and works with OA TC6
framework that is already present. S2500 driver supports
hardware timestamping. Along with this driver, OA TC6
frame work is also changed to add hardware timestamping
support.

Driver has support for running selftest and loopback tests.
Through ethtool, it can provide traffic stats, rmon stats,
and timestamping related traffic stats.

As S2500 has an internal PHY, changes have been added
to onsemi's PHY driver to support this device.

To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>
To: Richard Cochran <richardcochran@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Simon Horman <horms@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Eric Dumazet <edumazet@kernel.org>
To: Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: Jerry Ray <jerry.ray@microchip.com>
Cc: Ciprian Regus <ciprian.regus@analog.com>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Changes in v10:
 - Removed config_intr callback in S2500 PHY driver
 - Removed writing status0/config0 from s2500 driver
 - Implemented API to set tx credit threshold and 
   to enable RX cut through mode
 - Drop the frame when frame drop bit in footer is set
 - Module name restored back to oa_tc6.ko from oa_tc6_mod.ko
- Link to v9: https://lore.kernel.org/r/20261009-s2500-mac-phy-support-v9-0-dcefe1d0bf0d@onsemi.com

Changes in v9:
- Renamed the new phy API from having "fixed_speed" to "no_speed"
- Fixed compilation issue due to having changes in the wrong patch
- Added the MAINTAINERS changes to where files were introduced.
- Fixed coding style issues reported.
- Moved the order of patches so that selftest changes goes after
  s2500 support.
- Made Pier's email ID consistent across to be consistent across 
  the codebase.

- Link to v8: https://lore.kernel.org/r/20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com

Changes in v8:
- Modified to use newer MMD based read/write APIs
- clean up by removing unused definitions/initializations
- Better handling of timestamp capture events by using
  bit fields so that we don't lose any event
- timestamp skb queue is protected with spinlock
- added reset-gpio in YAML file as support is recently added
- removed ioctl from OA TC6 framework as it is not needed.

- Link to v7: https://lore.kernel.org/all/20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com

Changes in v7:
- Fixed compiler warning due to prototype mismatch
- Moved the order of patches to ensure dt-bindings comes first
  before it is being used
- Added missing review tag
- Added missing MODULE_DEVICE_TABLE
- OA_TC6 framework enables 64 bit timestamping mode by default.

- Compiler related warnings fixed.
- Link to v6: https://lore.kernel.org/r/20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com

Changes in v6:
- Changes to ensure onsemi code stay within 80 columns.
- Fixed the error of "not described in comments section"
  in comments section.

- Fixed compiler warnings.
- Link to v5: https://patch.msgid.link/20260614-s2500-mac-phy-support-v5-0-89874b72f725@onsemi.com

Changes in v5:
 - kernel doc related changes in oa_tc.c, onsemi driver files and
  oa tc6 rst file
- Link to v4: https://lore.kernel.org/r/20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com

Changes in v4:
 - Added return value comment for genphy_read/write_phy_mmd functions
 - Added genphy_loopback_fixed_speed helper function to be used in
   set_loopback callbacks
 - Updated networking documentation for OA TC6 framework to elaborate
   on what is expected in the ptp_clock_info structure for registration.
 - added spi-max-frequency in YAML file based on alert from sashiko-bot
 - Removed model/version from the onsemi driver's private structure as
   they were useful as "information-only" data.
 - Replaced the non-standard selftest with Linux's standard selftest
   and made it as a separate patch
 - Changed bit manipulation, shift operations to use macros so that
   it is clean and readable.
 - added new read_register and write_register apis with _mms postfix
   so that MMS (memory map selector) can be given as a parameter.
 - Fixed the wrong condition check with NETIF_F_RXFCS to subtract
   FCS size from the length of the frame.
 - Link to v3: https://lore.kernel.org/r/CY8PR02MB92499C9080614FA3CEB8CD0483162@CY8PR02MB9249.namprd02.prod.outlook.com

Changes in v3:
 - Moved OA TC6 framework to its own directory.
 - Split changes to smaller patches based on feedback.
 - Added PHY loopback support as a separate patch.
 - New, read and write register APIs with extra parameter MMS
 - Link to v2: https://lore.kernel.org/r/CY8PR02MB924920C8825C7AE5D22EFA4483382@CY8PR02MB9249.namprd02.prod.outlook.com

Changes in v2:
 - API to add vendor specific MMS to mdio device map.
 - Link to v1: https://lore.kernel.org/r/CY8PR02MB9249D083B637477C254F9B0583322@CY8PR02MB9249.namprd02.prod.outlook.com

---
Selvamani Rajagopal (11):
      dt-bindings: net: add onsemi's S2500
      Documentation: networking: Add timestamp related APIs to OA TC6 framework
      net: ethernet: oa_tc6: Move oa_tc6.c to its own directory
      net: ethernet: oa_tc6: Move constant definitions to header file
      net: ethernet: oa_tc6: Support for hardware timestamp
      net: ethernet: oa_tc6: Support for vendor specific MMS
      net: phy: ncn26000: Enable enhanced noise immunity
      onsemi: s2500: Add driver support for S2500 MAC-PHY
      onsemi: s2500: Added selftest support to onsemi's S2500 driver
      net: phy: ncn26000: Support for onsemi's S2500 internal phy
      net: phy: ncn26000: Support for loopback

 .../devicetree/bindings/net/onnn,s2500.yaml        |  71 +++
 Documentation/networking/oa-tc6-framework.rst      |  72 +++
 MAINTAINERS                                        |  11 +-
 drivers/net/ethernet/Kconfig                       |  13 +-
 drivers/net/ethernet/Makefile                      |   3 +-
 drivers/net/ethernet/adi/Kconfig                   |   1 +
 drivers/net/ethernet/microchip/lan865x/Kconfig     |   1 +
 drivers/net/ethernet/oa_tc6/Kconfig                |  17 +
 drivers/net/ethernet/oa_tc6/Makefile               |   7 +
 .../ethernet/{oa_tc6.c => oa_tc6/oa_tc6_main.c}    | 526 ++++++++++++++++-----
 drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c           |  65 +++
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h       | 175 +++++++
 drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c        | 224 +++++++++
 drivers/net/ethernet/onsemi/Kconfig                |  22 +
 drivers/net/ethernet/onsemi/Makefile               |   7 +
 drivers/net/ethernet/onsemi/s2500/Kconfig          |  21 +
 drivers/net/ethernet/onsemi/s2500/Makefile         |   7 +
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c  | 385 +++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h   | 155 ++++++
 drivers/net/ethernet/onsemi/s2500/s2500_main.c     | 500 ++++++++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c      | 163 +++++++
 drivers/net/phy/dp83867.c                          |  11 +-
 drivers/net/phy/ncn26000.c                         |  59 ++-
 drivers/net/phy/phy_device.c                       |  22 +
 include/linux/oa_tc6.h                             |  32 ++
 include/linux/phy.h                                |   2 +
 26 files changed, 2425 insertions(+), 147 deletions(-)
---
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20260601-s2500-mac-phy-support-4f3ae920fb73

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>


