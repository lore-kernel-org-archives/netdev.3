Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AC614F70;
	Sat, 26 Sep 2026 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463683; cv=none; b=R/QmSHqQvAa17pw9evIe0WEnfbb/dqx8RMmDNiGUvPGSNiEwpr8UIiHhqqb/jBsJwm4AUt/SQ78nnI//6UsikP+g/+22lCRSgXn/+rvPdVbUarb07OXBKUErd6D1ZglFjXN9PJ2QndGMXWDwqM891t+kBVE7akiDmDZOBBxsSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463683; c=relaxed/simple;
	bh=5XzksYi+f+/84FiMnacSwsSFLVLrSZX09k+Iq+90BRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ak3Hjy0aADYzjaS34IEFIdx0qAowCto8Tbll0G8TyHQazHiDLWWdTCaRZoseSFyJ43mQxaKJsRYYANYuiPc9Val7LA/bBu3Rxpl0t3E7VhhlI/Hkrrtmv9Y9FfxP+xWkmasqqNcEq6tZXKoTfSP4ocNeJy/kHayxeLFP3Ycc/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eQimBSM1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eQimBSM1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 019391570;
	Sat, 26 Sep 2026 16:01:15 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB2C3F632;
	Sat, 26 Sep 2026 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790463678; bh=5XzksYi+f+/84FiMnacSwsSFLVLrSZX09k+Iq+90BRw=;
	h=From:To:Cc:Subject:Date:From;
	b=eQimBSM1xITQv/spU2KKZgZxSo7SAlwN3Xbn3DELrfU/+3MXKZx3Zy+IYKz8LueUd
	 F/tkkHNePWwzigfpapuryQBFDG2hVkcR+u+8w4k4bZB/zywXUBS326X8ALY/BOAClf
	 aP8trvXxUL7aR1tWtip88Yb05/PlfgR9nmluHd0A=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/5] net: phy: Add Maxio MAE0621A support
Date: Sun, 27 Sep 2026 00:56:20 +0200
Message-ID: <20260926225625.25969-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAXIO MAE0621A [1] is a Gigabit Ethernet PHY. It appears on low priced
development boards and other devices like TV boxes. This series adds
support for this PHY, altough we (for now) only use some special clock
setup beyond the standard clause 22 functionality.
There appear to be two variants of this PHY, labelled with a -Q2C or -Q3C
suffix. There seem to be more differences than a mere revision bump would
suggest, and vendor drivers [2] seem to treat them differently. For the
features that this driver uses at the moment, they are the same, but
prepare for future divergence by declaring two drivers, using the same
functions, for now. This is added in the second part, along with support
for enabling the PHY clock explicitly described in the DT.

This series merges Liu Changjie's original PHY driver series[3] with
my additions to support the -Q2C variant[4]. I split off my last two
patches that were adding the DT description for a TV Box using this PHY
and the input clock provided by a fanout clock pin for now.

Original cover letter:
=============================
Add a binding and PHY driver for the Maxio MAE0621A Gigabit Ethernet
PHY. The driver matches the exact PHY ID and optionally selects a
125 MHz clock on CLKOUT. When the property is absent, the driver
preserves the hardware strap or bootloader setting.

This was tested on the LCKFB Taishan Pi 3M. With the PHY's default
CLKOUT configuration, the RK3576 GMAC negotiated a 1 Gbit/s link but
the data path did not work. A read-modify-write of page 0xa43,
register 0x19, setting bits 0 and 11 produced a readback value of
0x0823 and restored the data path without changing the RGMII delays.
The readback also confirmed that the unrelated set bits were
preserved.

Only the 125 MHz setting has been exercised on hardware and only that
value is exposed by this series. The 0 and 25 MHz choices from the
initial draft have been removed.

Public documentation for the MAE0621A register is not available. The
exact definitions of page 0xa43, register 0x19 bits 0 and 11, their
reset defaults, and whether a soft reset is required after changing
them still need confirmation from Maxio. The register programming in
this series is therefore supported by the hardware A/B result, not by
a public datasheet citation.

Hardware tests with the 125 MHz setting:
- all supported 10/100/1000 Mbit/s link modes
- 100 ICMP packets in each direction with no loss
- 936/934 Mbit/s host-to-board iperf3, no retransmits
- 943/941 Mbit/s board-to-host iperf3, no retransmits
- link unplug/replug and a normal reboot, followed by another 100 ICMP
  packets in each direction with no loss
- no RX errors, missed packets, carrier errors or collisions

Static tests on net-next commit f6f3b36c15ed:
- dt_binding_check with dtschema 2026.6
- W=1 arm64 defconfig build of drivers/net/phy/maxio.o with GCC 10.3
- W=1 arm64 allmodconfig build of drivers/net/phy/maxio.o with GCC 10.3
- git diff --check and checkpatch.pl

Based on v7.3-rc1.

Please have a look and test!

Cheers,
Andre

[1] https://www.lcsc.com/datasheet/C49308068.pdf
[2] https://gist.github.com/inindev/79afc051493244997458d5117aef19c3
[3] https://lore.kernel.org/netdev/MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com/
[4] https://lore.kernel.org/netdev/20260803101452.2993721-1-andre.przywara@arm.com/T/#u


Changes in v3:
- add patches for -Q2C variant support
- add second PHY ID into the DT binding
- support -Q2C variant using a separate driver
- reorder error handling code to return on error first

Changes in v2:
- Extend hardware validation to all supported 10/100/1000 Mbit/s link
  modes.
- Keep the binding limited to the tested 125 MHz setting. CLKOUT-disable
  support can be added later after its register behavior is documented
  and tested.
- No binding or driver code changes.


Andre Przywara (3):
  net: phy: maxio: prepare for more DT properties
  net: phy: maxio: parse and enable PHY clock from generic DT binding
  net: phy: maxio: add support for -Q2C variant

Liu Changjie (2):
  dt-bindings: net: Add Maxio MAE0621A PHY
  net: phy: Add support for the Maxio MAE0621A

 .../bindings/net/maxio,mae0621a.yaml          |  40 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/net/phy/Kconfig                       |   8 ++
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/maxio.c                       | 124 ++++++++++++++++++
 5 files changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
 create mode 100644 drivers/net/phy/maxio.c


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.46.4

