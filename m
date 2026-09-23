Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33F48A8D1;
	Wed, 23 Sep 2026 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159993; cv=none; b=Golwyp5OQ9BD+eYMkwxOiyF3jqeq7cVH5BWzb+dlOwU6YA7x5O+se2WtQg7kVqYKvDIaYa0mfdTJtcui3jChO4QJnd2mC8uS4Mjq4AxEGMUvkYM/RaDvZGq/x84YVUorIeUwCJ6l+dI102M3GiiiJ740Lb3/T4AFfXtl8JJxl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159993; c=relaxed/simple;
	bh=mYuxuiI97Ryv2didHFZyqmEcgvep5DTC1EOQo9xd7g4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lchoTpxKojSUYrZPriavh/2bnj4BWow3MMjTsbBXGd0/ggRREEUj6SkS1xERxBkRirLYsrU//7MGtJd4d3QDAof4U3e3eWpXWUGcLhrz9kV470KW/HYEJt9tDtARQJxUBDzmoLNAUjQro+ULolWCql7C7FX3VpJeyhTiswXmubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSN/Yvpq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWSUOIyi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSN/Yvpq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWSUOIyi"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G38dLMDwun3+wjVpqN310g0Tz5zcKrPGJvzV0sk8Dbw=;
	b=VSN/Yvpq27tMARlhUv5p5VeQJ+zZiTTAdXJ9y12br8rIvMOxIvcL7JCeorZH767CkYlh/Y
	yeuBi9hlvwJ/i4qc5RPBJlmojxPRkJMHUiEpv62uKr0qf3iJLip436sT9/o1Pl8F7JowTr
	Tpk5NPP1/x6hZBV2zRhHEdKVIIP/Srchvq1sZpkuh+YU1mTM6XOargjsdk3e6sSwkU5rY8
	z5I2SEfVo81WaMFpm1xIvCaXlvIlsDmtS1x1aknAgjRO5RiSb96fMwR5j6VIa4cFQGUd1s
	+9GT9X+l3H+fiuiH8ZqpWAMKg8s6FN6EdzHCSY2JnvoBr7dv6wmcfC/Xnz81xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G38dLMDwun3+wjVpqN310g0Tz5zcKrPGJvzV0sk8Dbw=;
	b=rWSUOIyis0atzAY5EjMorb7zJT61X/kuNICPIo/XjXtg1X3S73DTc1zb2dwc/xVvjP+Wp2
	hqSX/SXjtjQ70XCQ==
Subject: [PATCH net-next v3 0/8] net: dsa: Add SoC-e DSA driver
Date: Wed, 23 Sep 2026 12:39:27 +0200
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+ss2oC/43OwQ6CMAwG4FcxO1szhkzw5HsYDxsrUoPDrHPBG
 N5dwIOJFz3+afv9fQrGQMhiv3qKgImYej+FfL0SdWv8GYHclIWSSsudqsBhwg4Sx2CYW6QrcF8
 jODZw7UBJp01hnC3zUkzGLWBDw+IfhccIHocoTu8J3+0F6zjz825LHPvwWF5J2XLxZ2vKQILFQ
 lfOYGaVPHTk7zH0noaNw6UvqY9YyfyXqCaxsbIod7Xdam2/xXEcX/AlVNU8AQAA
X-Change-ID: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Add support for SoC-e Ethernet switch IP cores synthesized for and
implemented in FPGAs.

The series introduces the SoC-e vendor prefix and device tree bindings,
an EtherType-based SDSA tagger, an MDIO controller driver, and a DSA
switch driver.

The switch driver uses a memory-mapped control interface. During probe,
it detects the core version and the licensed and implemented port
counts, and verifies that the synthesized core provides DSA support.
Port counts from 3 through 31 are supported.

It supports Ethernet switching using MII, GMII, RMII, and RGMII port
interfaces. VLAN filtering and membership are also offloaded when the
corresponding hardware feature is synthesized. Unsupported hardware STP
offloading is disabled.

External MDIO outputs are exposed as separate logical MDIO buses sharing
the integrated MDIO controller. The controller supports Clause 22 and
Clause 45 transactions, while the generic MMIO MDIO mux selects the
external bus through the shared control register.

The drivers were tested with a SoC-e MRS 25.01 IP core on a Xilinx
ZynqMP platform with the following options enabled: 3 ports, DSA, IEEE
802.1w - RSTP, MAC Table Type with Hybrid SVL/IV, Port-based VLAN, QoS -
Priorities, Statistic Counters.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
Changes in v3:
- Rebase onto net-next/main and update tag protocol number in dsa.h
- Drop the deprecated ports and port@ node names and keep only
  ethernet-ports and ethernet-port@ in the binding.
- Drop labels from the switch binding example.
- Rename the MDIO master to MDIO controller.
- New Patches 2 and 5: Move the integrated MDIO controller into a
  separate driver and add the corresponding binding, Kconfig entry, and
  build integration.
- Switch from internal MDIO multiplexing to the generic MMIO MDIO mux
  framework for selecting the synthesized external MDIO buses.
- Check that the MDIO controller is idle before programming a
  transaction and wait for completion afterward.
- Replace MDIO magic values and resource indices with named definitions.
- Reduce MDIO timeout from 1s to more reasonable 1ms.
- Remove inline declarations and unnecessary checks from the remaining
  MDIO code.
- Use mdio-mux-mmioreg for the 11-bit MDIO bus selector at bits 26:16
  and access it through the upper 16-bit half of the shared control
  register.
- Update the switch binding to describe the MDIO controller, generic
  MMIO mux, child buses, and PHY references.
- Remove struct soce_probe_desc, since only one register layout is
  supported.
- Reject configurations with fewer than three implemented ports.
- Add port enable and disable callbacks to prevent unmanaged forwarding
  after driver unbind or module removal.
- Disable tagging during teardown.
- Rename and regroup register field macros to identify their associated
  registers.
- Remove obsolete and irrelevant comments.
- Add new comments for proper documentation and clarity.
- Switch to dev_err_probe() to improve probe error reporting.
- Embed struct dsa_switch in struct soce_priv instead of allocating it
  separately.
- Remove the trailing comma after the sentinel entry in the match table.

Follow-up validation and feature work using a new IP core:
- New patch 7: Add basic VLAN hardware offload through
  port_vlan_filtering, port_vlan_add, and port_vlan_del.
- Warn when the Port VLAN feature is unavailable and reject VLAN
  configuration with netlink extended acknowledgements.
- Reset VLAN offloading configuration during teardown.
- New patch 8: Disable STP offloading, which is not supported by the
  initial driver.
- Improvements in SDSA tag handling:
  - Add specific skb drop reasons for malformed SDSA frames.
  - Restore VLAN metadata from the SDSA tag on receive and encode skb
    VLAN metadata into the SDSA tag on transmit.

- Link to v2: https://patch.msgid.link/20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de

Changes in v2:
- Correctly use net-next prefix
- Rework the binding into a single MMIO-based switch node
- Model hardware MDIO outputs as separate logical MDIO buses
- Detect the switch version, features, and port count from hardware
- Drop incomplete STP, bridge, and FDB offloading
- Derive phylink capabilities from each port's phy-mode
- Harden MDIO access and SDSA receive validation
- Address binding, naming, and coding style review comments

Link to v1: https://patch.msgid.link/20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Simon Horman <horms@kernel.org>
To: Russell King <linux@armlinux.org.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

---
Vasilij Strassheim (8):
      dt-bindings: vendor-prefixes: Add soce
      dt-bindings: net: Add SoC-e SWIP MDIO controller
      dt-bindings: net: dsa: Add SoC-e SWIP switch
      net: dsa: Add tag handling for SoC-e switches
      net: mdio: Add SoC-e SWIP MDIO controller driver
      net: dsa: soce: Add basic support for SoC-e switch IP cores
      net: dsa: soce: Add VLAN offload support
      net: dsa: soce: Disable unsupported hardware STP

 .../devicetree/bindings/net/dsa/soce,swip.yaml     | 162 +++++
 .../devicetree/bindings/net/soce,swip-mdio.yaml    |  47 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/net/dsa/Kconfig                            |   2 +
 drivers/net/dsa/Makefile                           |   1 +
 drivers/net/dsa/soce/Kconfig                       |  14 +
 drivers/net/dsa/soce/Makefile                      |   4 +
 drivers/net/dsa/soce/soce_dsa.h                    |  38 ++
 drivers/net/dsa/soce/soce_dsa_core.c               | 737 +++++++++++++++++++++
 drivers/net/mdio/Kconfig                           |   7 +
 drivers/net/mdio/Makefile                          |   1 +
 drivers/net/mdio/mdio-soce.c                       | 239 +++++++
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_sdsa.c                                 | 158 +++++
 16 files changed, 1421 insertions(+)
---
base-commit: 944ae66642b726bd6b25ae71b1e9ff88a0e0bdb0
change-id: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838

Best regards,
--  
Vasilij Strassheim <v.strassheim@linutronix.de>

