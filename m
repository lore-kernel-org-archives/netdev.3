Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888253;
	b=fkr4r+DzDKaDI/SZQKDSzyuDHufKabIQjueCAr9kIZFesl2hF53RfQoTfPg/RgUHnS+T
	 Yk9aq0s/A20ZRLoRU0S/Z5r2FKOoKtWNSteR3CD4aNdNhI1Uz5GYqeoU1vhREX3fohZiZ
	 aSfSeZaZKzjf1RPEHMYQc5RcADDCpuBDvd3zE/uS274G/0B4zFjXOwN1jLwqX39RGiLjb
	 uoswGLmUJdpKpLra6NlTK5HZYY3mypaZC8KThPETEIAL5jyuhUoeCKPXzpCoR3RepsS7w
	 yUBiHO1dU0yn4aXfFrBgyK9LSbT51uZc0Sj5LDMv0xhSsH2wruTXtQt4cuBRQI7izOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888253;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc;
	bh=24aA//X1CYKibRhi0qUD5kQWQwwxJdtbvG8q3ONPQB8=;
	b=FTm+BfHu1qFPP4Fhtm5hoVpaAiKoEf35YKP5FJbY3UHPjW7u63p6xlVgrh7CXVX7Jlz6
	 GCb7MtctasBLZLies0iitc6ZDX5hXZwA4PwFe7QHpGBliML3jZMDGyzyLpypD8IIs8odg
	 Gq6KC0hPzHcYtIP6ycxweaDRUhcKASUp3GBRu9v0VHwVdLIXn15f2yGfYZO6+Pyo29JF/
	 g8Fn3LovyGw6geTHWyOTV+5FZRtHP0glu9Rr6WXjYN5BsaGKXeDni+m3UzdFFud5cuCz3
	 B7HfCzEUR6q9PwOmd4nZTD3Hwo5XDfq575r2jzqTss6hTVwaO0zdC5bVbenT3yt+vjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Og9fWIWH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1v5utpqi;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D8606A326;
	Thu,  5 Nov 2026 14:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C6D8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Og9fWIWH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1v5utpqi
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793888245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24aA//X1CYKibRhi0qUD5kQWQwwxJdtbvG8q3ONPQB8=;
	b=Og9fWIWHNW0M26m9Q4d1w52gRNZ28UwvJC1F8JLad2jv0KBwQq0jx+MHwUEZyggJCf7xPT
	FrtM8g7b/O8rYyoiaO+BkohfvCF0p37lVzUD7ZfF9zPKn73b+cK6/VoXDhgSKOKHjoTsUa
	h/u9oIEHecCBsRtmbM00ypnbUhsMK5QYCv9IBJVmJHGBj0+JrLJCS3SE38J2ciTKJA35uk
	K7pefHsxaTNyam29nEA+tpJemom4UwEtgmYtyjSAwrL2oWZ8psHKyFkE1/7lvj666gQdCm
	LDp1MZet6dlMyA0+huembVlC1uH8f0Imo2s3F2VGNQ33H6PJDI9ukewwXVuuAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793888245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24aA//X1CYKibRhi0qUD5kQWQwwxJdtbvG8q3ONPQB8=;
	b=1v5utpqikbLE9gUpzvw22RMkUKT/nihbccC4BUoy94ro6wOIfJvjVVESdZZIAtwHqq9R61
	DJwaxrmdWThhmgCQ==
Subject: [PATCH net-next v4 0/8] net: dsa: Add support for SoC-e Ethernet
 switch IP cores
Date: Thu, 05 Nov 2026 15:16:44 +0100
Message-Id: <20261105-devel-vstrassheim-soce-dsa-ml-v4-0-02f3cde2afa1@linutronix.de>
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
X-B4-Tracking: v=1; b=H4sIAM2P7GoC/43OwW7DIAwG4FepOM8VIQ1Jeup7TDtgcBamlFSYo
 kxV3n00PWyaJnXHX7a/3zfBFD2xOO5uIlL27OdQwuFlJ+xowjuBdyULJZWWrerBUaYJMqdomEf
 yZ+DZEjg2cJ5ASadNYxx2dSeKcYk0+GXzX0WgBIGWJN4eE77iB9l05++7o+c0x8/tlVxtF/9sz
 RVIQGp07wxVqORp8uGa4hz8sne09WX1LfayfiaqIg4om661eNAa/xLrH6J6KtZFdI7QDBZ7NO1
 vcV3XL+x3vOuOAQAA
X-Change-ID: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Lee Jones <lee@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, mfd@lists.linux.dev, 
 Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Add support for SoC-e Ethernet switch IP cores implemented in FPGAs.

The series introduces the SoC-e vendor prefix and Device Tree bindings,
an MFD parent driver, an EtherType-based SDSA tagger, an MDIO controller
driver, and a DSA switch driver.

The drivers use a memory-mapped control interface. The MFD parent
validates the core version and instantiates the child devices. The
switch driver reads the licensed and implemented port counts and
detects optional hardware features. Implemented port counts from 3
through 31 are supported.

The driver configures the hardware DSA feature to isolate user ports
from each other and restrict them to exchanging frames with the CPU
port. Bridge forwarding is handled in software by the Linux bridge.
Hardware STP offload is not implemented. The driver disables the
hardware STP feature when present, leaving STP state handling to the
Linux bridge.

Supported port interfaces are MII, GMII, RMII, and RGMII. On cores
synthesized with Port VLAN support, the driver programs VLAN membership
tables. Bridge VLAN filtering is not offloaded.

On cores synthesized without Port VLAN support, VLAN information is
lost when frames enter the switch through the CPU port and is not
preserved in the SDSA header. The driver therefore rejects direct VLAN
uppers on such cores. VLAN-aware software bridging is also unsupported
on these cores.

External MDIO outputs are exposed as separate logical MDIO buses sharing
the integrated MDIO controller. The controller supports Clause 22 and
Clause 45 transactions. The generic MMIO MDIO mux selects the external
bus through the upper halfword of the shared control register, while
the controller accesses the lower halfword.

The drivers were tested with a SoC-e MRS 25.01 IP core on a Xilinx
ZynqMP platform. The tested core was synthesized with three ports, DSA,
IEEE 802.1w RSTP, hybrid SVL/IVL MAC tables, port-based VLAN support,
QoS priorities, and statistics counters.

VLAN TX testing exercised in-band C-tags. TX VLAN offload is disabled
and cannot be enabled on this platform, so the accelerated SDSA-TCI TX
path was not tested.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
Changes in v4:
- Rebase onto net-next/main.
- Introduce an MFD parent for core version validation and DT-based
  child-device creation. Keep feature detection and switch register
  mapping in the DSA driver. (Andrew)
- Split the combined switch binding into MFD-parent and switch-function
  bindings. Use soce,swip for the parent and
  soce,swip-switch-00-04-0c-10 for the switch function.
- Reference dsa.yaml#/$defs/ethernet-ports and remove the redundant
  local DSA port schema reference and property closure. (Rob)
- Update description for swip-switch-00-04-0c-10 compatible. (Rob,
  Andrew)
- Rename the MDIO compatible to soce,swip-mdio and update the examples.
- Move the switch driver directly into drivers/net/dsa/, rename it
  to soce-swip.c, and remove its subdirectory Kconfig and Makefile.
- Rename the DSA and MDIO Kconfig symbols to NET_DSA_SOCE_SWIP and
  MDIO_SOCE_SWIP. Make the MFD and MDIO options internal and select
  them from NET_DSA_SOCE_SWIP.
- Reserve and map switch register blocks separately instead of
  claiming the entire IP-core window, and validate their ranges
  against the parent resource.
- Restrict the MDIO control resource to its lower 16-bit halfword.
  Use readw_poll_timeout() and writew() instead of 32-bit
  read-modify-write accesses, leaving the mux selector untouched.
  (Andrew, sashiko-bot)
- Replace the MDIO mapping helper with named platform resource mappings
  and propagate mapping errors through IS_ERR()/PTR_ERR().
- Report feature-detection failures with dev_err_probe() and use
  explicit masks and FIELD_GET() for version extraction. (Andrew)
- Advertise half-duplex capabilities for RMII and RGMII in phylink.
- Disable all user ports during setup before configuring VLANs,
  disabling hardware STP, and enabling tagging. (sashiko-bot)
- Remove the unreachable bridge VLAN-filtering callback and associated
  PVID and untagged-mask tracking. Keep hardware ports VLAN-unaware
  with ingress filtering disabled. (sashiko-bot)
- Program standalone VLAN 1 membership explicitly and preserve it
  when explicit VLAN membership is removed. Explicit membership takes
  precedence over default untagging. (sashiko-bot)
- Wait for both VLAN WRITE bits to clear before changing the shared
  VID selector or data registers. On programming failure, restore
  the software shadow, attempt hardware rollback, log rollback
  failures, and return the original error. (sashiko-bot)
- Clear the VLAN membership shadow after a successful setup reset.
- Handle VID 0 before checking hardware VLAN support in both callbacks.
  Return -EINVAL for unsupported non-zero VID additions. (sashiko-bot)
- Set needs_standalone_vlan_filtering only when Port VLAN is present.
  Reject direct VLAN uppers otherwise through port_prechangeupper,
  while retaining software-bridge support.
- Rename vlan_lock to feature_lock, initialize it independently of
  VLAN support, and remove unnecessary setup locking. (Andrew)
- Push accelerated non-802.1Q VLAN tags in-band before inserting
  SDSA, and handle allocation failure. (sashiko-bot)
- Include linux/bitfield.h explicitly in the SDSA tagger and document
  the duplicated VLAN TCI in received frames.
- Replace SKB_DROP_REASON_HDR_TRUNC with the reason returned by
  pskb_may_pull_reason(), following API change in net-next.

- Link to v3: https://patch.msgid.link/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de

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
To: Eric Dumazet <edumazet@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: mfd@lists.linux.dev
Cc: Martin Kaistra <martin.kaistra@linutronix.de>
Cc: Benedikt Spranger <b.spranger@linutronix.de>

---
Vasilij Strassheim (8):
      dt-bindings: vendor-prefixes: Add soce
      dt-bindings: net: Add SoC-e SWIP MDIO controller
      dt-bindings: net: dsa: Add SoC-e SWIP switch function
      dt-bindings: mfd: Add SoC-e SWIP parent
      net: dsa: Add tag handling for SoC-e switches
      net: mdio: Add SoC-e SWIP MDIO controller driver
      net: dsa: soce: Add basic support for SoC-e switch IP cores
      net: dsa: soce: Add VLAN membership table support

 .../devicetree/bindings/mfd/soce,swip.yaml         | 137 ++++
 .../bindings/net/dsa/soce,swip-switch.yaml         |  96 +++
 .../devicetree/bindings/net/soce,swip-mdio.yaml    |  47 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/soce-swip-core.c                       |  76 +++
 drivers/net/dsa/Kconfig                            |  15 +
 drivers/net/dsa/Makefile                           |   1 +
 drivers/net/dsa/soce-swip.c                        | 717 +++++++++++++++++++++
 drivers/net/dsa/soce-swip.h                        |  39 ++
 drivers/net/mdio/Kconfig                           |  10 +
 drivers/net/mdio/Makefile                          |   1 +
 drivers/net/mdio/mdio-soce.c                       | 213 ++++++
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_sdsa.c                                 | 168 +++++
 18 files changed, 1542 insertions(+)
---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20260729-devel-vstrassheim-soce-dsa-ml-20d6a5adb838

Best regards,
--  
Vasilij Strassheim <v.strassheim@linutronix.de>

