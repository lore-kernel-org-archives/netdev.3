Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589170;
	b=jfQ7U2rS5vXgxNX4cNMCBR2oDBVRbev73tlHn/IPvkihAY2Ee/GOTKBzYLVtpRajGD99
	 exzbB3k4qhFo9EYFwOtgcagpB//80vaXc4BW+yb2f875mIPg8mpLoLafh0DfFLiDe/p1B
	 xo0w/IsEmb5tdhPTBULkNpSF4Sj8iM0Rd34conKhBkIsz/zKUSX3Z7SzQFWlCb0A30SdO
	 TQ5CeJrkAeug7iVuS6q6CT1qBPdwluyJAOMiWkiGH9cIK8ctA2/hzoHc9PjiFqoRjPtnQ
	 8TFGKPZWgDtogD2PFGF+T6f3mksNFq0SGRhmtDfPkZuxIx3jiKsOeSLZzIAg8UDTryg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589170;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a5AEqQ0Q9CU6uILx3jmLLUXLvw6A66c2udjlKpLKQWk=;
	b=jYmu4gWpF3Vt6Wa9wTDabfhuOghI5t3YFC+xZCd90vey5mcXsqvsFs7ODuwHFTXOipvU
	 ULlyTzRa8821ooDXtbOodi6Lfv8H4EEigod02+/oPyt906196VlMbDMTAk/4fjQf94ELO
	 vmJ7wmjL8eUI0f8PQJjVQZv03lELrmvX2NfhAVCrptm/n1NRgIU9xftwvZK708xOUA+3X
	 KZizPwsc5vtO6pGbP9DuM/1gnQVYehnx26onHwby7mgKHGl8IsQZbIRAbakUbae9qhdxa
	 Hs4AizIzTnM0wGSUkHYtDdmu/QjL2ICxzNsilFahrOli7BRSWocBPiTNqF2lKc+1thw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ytei4xbY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070B606A32D;
	Fri, 13 Nov 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ytei4xbY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589170;
	b=2JN04TlFJNZnueaL5BC8NnXrMME7dPau/s1ccCRquguM4yHL54TLaTa8Pk/a3VRHvkEF
	 sWM9niQAoKHJ1V1CNtu5Vdjx+mu/L13Szc26eMDJ5nG/sDLQzUdWlPokJW5UKB6dKSKvm
	 E2Tbrr+xE4KLnBSc+a6lrxZ6YW+XcPfkakJPJN0V0RKqlUsFr2q81bmoi60dT0EV4hvtR
	 lkdKXafsEs2S4mqXVlt1Ylxf+9aysVwJUQG27soweJHaTjEggXEqSoUdXY1IyaqkWEPvm
	 N3SQddoKrNGPpkjPni0cBe6XJZubqTgIgWgFUq+VDMXLlsN/S1VbKA/idBXRPLm+vgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589170;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a5AEqQ0Q9CU6uILx3jmLLUXLvw6A66c2udjlKpLKQWk=;
	b=AWxcSWyFSMYYQZcXornwYcdQ+d+Pyu6vKuby1cc7TLyNf/w3EHfl1LnP2rcS5ONnK55X
	 Nk+3cUDut2lFKhQkjeboS+t1OIDPoHpAhoHJQEceUjDOoVtAt+K8ETClek4c2UWChiug7
	 4wL+uj9MpUt7D0AfszXfrnMZRFPKJqZWeto9JIbkEZFeRmljA6TxXwdChf57FpwSYn26F
	 wXDOQAwHOEVqSv41K76IlXPwwA1YQWqNpsFDe8W89at8/stBvPqQmBfRPIFUo2ag8SyV+
	 VGEsw7Vn7n6iu4D3qZJ/MeELgEa1fLl8MKVTZfAuvl5gjDcTK+/YgsxBmViww/eDo4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 90C941F000C4;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589170;
	bh=a5AEqQ0Q9CU6uILx3jmLLUXLvw6A66c2udjlKpLKQWk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Ytei4xbY5m3847VfRBKXXB9Yv9PbkJ0+rwCIFv21tiB+46vAqeUv8JS4bNjRuyHPZ
	 wNhHN70rYt/c00oAmwRKZbx55EXpb1r++vJH6LJGVob23Vub2AanhmJ8ScZjqhFt4c
	 tLCk+V5YdCfEvpVIHEu8RDti+FJhl3M2GWQs9lpCN0jC3le75xXEtXiAf+kWSeXZBm
	 +NmsH4NwYAOQa6sOg9g3/m3n6MgY8vwPrj2vKwXlsHAXbsMmFjbxkgtJEDF/bl892i
	 RvPtk6ISABdTF1w6j+oc/Fy1MaKxv4gUm9QK0zLDWV34IG5YpY+bykdx/XYvSAbEAh
	 p2PfCQ0rb19Yw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DECE549A0F;
	Fri, 13 Nov 2026 16:59:28 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net-next v11 00/14] (no cover subject)
Date: Fri, 13 Nov 2026 08:59:19 -0800
Message-Id: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
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
X-B4-Tracking: v=1; b=H4sIAOlB92oC/3XQwW7DIAwG4FepOI/JJgFDT3uPaQcgzppJTaKQR
 q2qvvtoNq2dIo5g+/vBV5F46jiJ/e4qJl661A19PiC+7EQ8+P6TZdfkC6FAGTCAMikNII8+yvF
 wkek0jsM0y7qtPDsFbaBK5Nlx4rY7r/C76HmWPZ9n8fFTSafwxXG+s/feQ5fmYbqsb1jqdeI3T
 RfSllqCbDinRayiaezb0Cc+dq9xOK4hi35isC4xOjPWWaoDqZaU3jDmiVGuxJjMoI1MLpcrwg1
 DD4bAlhjKTE02WiLv0bsNYx+MU0XGZoYYEL2PsYIt4/4YBCh+yt1XHLllbCC00GwYhIeDYEoOQ
 oYqDNobF6wO9A+63W7fy7HmvIQCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=9258;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Q7u++2+ia99ofeeV7c7KuHVHI+2bSLsv96doH7MQEJ8=;
 b=ZDdKCWf6WR7a5lEaDG7UN/wTsADOgN/tGaM8IpEe7hV2Px2DDndDYjtufIbjxB6Kxtvnv7rPr
 DdQYbxDpemmChwC944uasCYH5O63MYxPsVPA/ZjRhwlHCJ/7OcjlLCY
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

Changes in v11:
- Create new patches to move vendor changes to its own patch
- Improve commit message to be more informative of the changes
- Add clarity to kernel documentation in oa-tc6-framework.rst
- Fix issues potential Oops issue in S2500 driver.
- Add logic to take care of frame drop bit from MAC-PHY 
- Link to v10: https://lore.kernel.org/r/20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com

Support for onsemi's S2500 10Base-T1S MAC-PHY

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
   to enable RX cut-through mode
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
Selvamani Rajagopal (14):
      dt-bindings: net: add onsemi's S2500
      Documentation: networking: Add timestamp related APIs to OA TC6 framework
      net: ethernet: oa_tc6: Move oa_tc6.c to its own directory
      net: ethernet: oa_tc6: Move constant definitions to header file
      net: ethernet: microchip: lan865x: Depends on PTP_1588_CLOCK_OPTIONAL
      net: ethernet: adi: adin1140: Depends on PTP_1588_CLOCK_OPTIONAL
      net: ethernet: oa_tc6: Support for hardware timestamp
      net: ethernet: oa_tc6: Drop frames if footer has FD bit set
      net: phy: ncn26000: Enable enhanced noise immunity
      net: ethernet: onsemi: s2500: Add driver support for S2500
      net: ethernet: onsemi: s2500: Add selftest support
      net: phy: Add helper to modify only the PHY loopback bit
      net: phy: ncn26000: Support for onsemi's S2500 internal phy
      net: phy: dp83867: Use genphy_loopback_no_speed()

 .../devicetree/bindings/net/onnn,s2500.yaml        |  71 +++
 Documentation/networking/oa-tc6-framework.rst      |  81 +++-
 MAINTAINERS                                        |  11 +-
 drivers/net/ethernet/Kconfig                       |  13 +-
 drivers/net/ethernet/Makefile                      |   3 +-
 drivers/net/ethernet/adi/Kconfig                   |   1 +
 drivers/net/ethernet/microchip/lan865x/Kconfig     |   1 +
 drivers/net/ethernet/oa_tc6/Kconfig                |  16 +
 drivers/net/ethernet/oa_tc6/Makefile               |   7 +
 .../ethernet/{oa_tc6.c => oa_tc6/oa_tc6_main.c}    | 504 ++++++++++++++++-----
 drivers/net/ethernet/oa_tc6/oa_tc6_ptp.c           |  68 +++
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h       | 173 +++++++
 drivers/net/ethernet/oa_tc6/oa_tc6_tstamp.c        | 224 +++++++++
 drivers/net/ethernet/onsemi/Kconfig                |  21 +
 drivers/net/ethernet/onsemi/Makefile               |   6 +
 drivers/net/ethernet/onsemi/s2500/Kconfig          |  20 +
 drivers/net/ethernet/onsemi/s2500/Makefile         |   6 +
 drivers/net/ethernet/onsemi/s2500/s2500_ethtool.c  | 388 ++++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_hw_def.h   | 151 ++++++
 drivers/net/ethernet/onsemi/s2500/s2500_main.c     | 498 ++++++++++++++++++++
 drivers/net/ethernet/onsemi/s2500/s2500_ptp.c      | 156 +++++++
 drivers/net/phy/Kconfig                            |   2 +-
 drivers/net/phy/dp83867.c                          |  11 +-
 drivers/net/phy/ncn26000.c                         |  67 ++-
 drivers/net/phy/phy_device.c                       |  24 +
 include/linux/oa_tc6.h                             |  32 ++
 include/linux/phy.h                                |   2 +
 27 files changed, 2412 insertions(+), 145 deletions(-)
---
base-commit: d1f4b7c6b997c29de67ad7178ababac2328cb1b4
change-id: 20260601-s2500-mac-phy-support-4f3ae920fb73

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>


