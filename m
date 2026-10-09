Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AB38D3FD;
	Fri,  9 Oct 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561235; cv=pass; b=LEVEeTdrI0uG+3o6Nj/fh/yow2QAbxCTw6C3vhUD/2cdurtDrpCLyIZh4xVVT+fg83OZu3oEvOms2kYsKTmhlr1LVco+cXS1DnHTSAX9yyEVyKBHkCZBb7nsH0ysCYGX2treQVqv+Xlh9c9shDEGRYk4zPUano8JTSRXh/Ylxu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561235; c=relaxed/simple;
	bh=StBWC5rdGl30CGSA8cby9W9feHch4ijdhDIwbiWdprQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LeIhehMf0vLFKK9hu0oiy32Ju7Y5CC3vkUrhdIVeYUZc22j+7/urdKfqDKH3arMblKGaIMbZkCjhROxAPdekGkXYRgTryT6mhXjQvLGUP7AuAoU65YS6AttoJkxLVWsesPo58KUgPn2NaWTsyHqTAN/yvR92aR27wafzONDAbrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=o5Lm4Xf7; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="o5Lm4Xf7"
ARC-Seal: i=1; a=rsa-sha256; t=1791561184; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=atvbFYNzQ6nMs+vHCSb9N2vNC07w8pxOBj5iBtLNWXygmeGmZzHB+w2dB/EWfbxPyMRRtrbTxsbeDFy8ozP2Ry3dqOlfj+sZxy8vWFuX/2zWuJIYdMwpcWVUeexo6I18F9DxtKr3OGP9VmbbkA/0m83NuN3k8eEYvVeOqgsdwXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791561184; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fPdEIZW7sOTj4odPbZ748d72yqRqKOz4PkPYMfEhMj8=; 
	b=OmiTjmRSwGJb3v2qBQUgxUE8h2zuxLUKZiirg1HPoaDolmAboO/6JambR2J7ZaofE8jZtb0PW662mzJxYoqJsswmhzU6P4hf5aKoui9aOUGzV8uzVuEWZfHrG6JbsKmRNoLqdqOUkJHRMNOwRx2TVCGLL2Q1QKjCFKGNKUICWLQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791561184;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=fPdEIZW7sOTj4odPbZ748d72yqRqKOz4PkPYMfEhMj8=;
	b=o5Lm4Xf7oj6XjLNVMW6Ba1V69FgAAAXb8gmGoL6Y84y9/2LkxVMkxY5AkHgglmV4
	jJEm/x8b5DiCrGn+n6mgBDFX8+LjhclRVUi7irVeYweRAasLzcpV5PTus4OXUy1W7FG
	P++tMvpGXcIbHkxalP43TkOp/ge5AaZdM5dIPB14=
Received: by smtp.zohomail.com with SMTPS id 1791561181104459.34509613209946;
	Fri, 9 Oct 2026 08:53:01 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v6 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
Date: Fri, 09 Oct 2026 23:52:05 +0800
Message-Id: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22R0WrDMAxFfyX4eS6W7cRxGWP/MfZgK8pq1iSdn
 YaO0n+fkwyajb4YZHSO0NWVJYqBEtsXVxZpCikMfS6qp4LhwfUfxEOTayaFrER+uDNKcTx+ctH
 oFoVwtrXIcvspUhsui+rtPdeHkMYhfi/mCebfVaJA3CUTcMFV5TVZL7UuzespfHRDdMfdSHhgs
 2iSd9gAbGCZYWt0A3WNngQ+gtUdtqLcwCrDpWilqltl0dSPYL2B5Xaynicj1Jo8WYfwCC43sNr
 uXGYYAEzpNWAjm//wbU0z0tc532NcI2UdpeSWe+yL5999Kp7O/SUs2n7gpzVP9A1JQNtSZf+6X
 +ZDeZeI49B1YdwXk9kpHhHy1NsP+5z44Q0CAAA=
X-Change-ID: 20260202-a733-clk-0d4fc00a9f9c
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Enzo Adriano <enzo.adriano.code@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Norman Herms <dockseed@proton.me>, 
 Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7311;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=StBWC5rdGl30CGSA8cby9W9feHch4ijdhDIwbiWdprQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJO8m5yeBZ3r0qYa/oXz7/scp/mnTi9gvPIX20vG49Fy
 oc3Rkyw6ChlYRDjYpAVU2Th8hf/Z63D8+2IQOt9mDmsTCBDGLg4BWAiv1QYGaYzzj2T7RHzhUFk
 04Oyo/rGZQLuvVuFkuuq1aOUThY+ucLIcGzBme6CxI2BU8u59j02e/qxY9ctl9h/Hx4t3Dwv2un
 TIw4A
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add support for the main CCU and the PRCM module (R-CCU) found in the
Allwinner A733 SoC. The clock architecture is derived from the previous
A523 design, with the MCU_CCU removed and the clock tree extended for
the additional functional blocks found on the A733.

The A733 introduces a "pll-ref" clock that normalizes the physical
oscillator frequency, which can be 19.2MHz, 24MHz, or 26MHz, into a
consistent 24MHz reference for the PLL clock tree.

The peripheral, video, and DE PLLs provide multiple independently gated
outputs with programmable dividers. Model these outputs as separate
divider-and-gate child clocks. Also follow the documented hierarchy for
the derived peripheral PLL outputs. The explicitly named PLL_AUDIO1 /2
and /5 outputs are modeled as fixed-factor clocks, with their divider
fields initialized accordingly.

Also extend the sunxi-ng SDM (Sigma-Delta Modulation) support for the
dual-pattern register layout used by the A733 PLLs. PLL_AUDIO0 uses the
dual-pattern SDM support to synthesize its fractional output.
PLL_AUDIO1 does not expose fractional rates, but its SDM controls are
modeled so that stale settings left by firmware can be disabled when an
integer rate is programmed.

The actual parents of a small number of bus gates are not documented in
the user manual. Follow the vendor BSP and keep these gates parented to
"hosc" until more complete hardware information is available.

This series depends on the A523 single-divider clock fixes [1], which
add feature support to the M-only clock macro used by the MBUS and DRAM0
clocks. The prerequisite series has been applied to the
sunxi/clk-for-7.4 branch.

Link: https://patch.msgid.link/20260906-sunxi-clk-no-p-v1-0-cbde21c9fe69@pigmoral.tech [1]
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Changes in v6:
- Patches 1 and 3: Drop the R-TWD bus clock, since S_TWD_BGR_REG is
  always secure and cannot be accessed by the non-secure kernel
- Patches 1 and 7: Rename mbus-nand and CLK_MBUS_NAND to mbus-nand0 and
  CLK_MBUS_NAND0
- Patches 3 and 4: Document the firmware requirements for the PRCM and
  CCMU security switch registers
- Patch 4: Add CLK_SET_RATE_PARENT to the video and DE PLL output clocks
- Patch 5: Document why the CPU_PERI and NSI clocks are not modelled
- Patch 7: Model ahb-store as the parent of the NAND, MMC, SPI, SPIF and UFS
  bus gates, and drop its CLK_IS_CRITICAL flag
- Patch 7: Keep mbus-store critical for the storage DMA paths and make it
  the parent of mbus-nand0
- Patch 7: Add comments explaining the ahb-store, ahb-cpus and mbus-store
  gates
- Patches 5, 7 and 8: Collect Reviewed-by tags
- Link to v5: https://patch.msgid.link/20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech

Changes in v5:
- Add the CLK_GIC binding ID, inserted after CLK_TRACE
- Add the GIC clock and mark it critical
- Fix the continuation line alignment of the trace clock
- Mark ahb-cpus critical
- Link to v4: https://patch.msgid.link/20260921-a733-clk-v4-0-9c184ebe9ac1@pigmoral.tech

Changes in v4:
- Model the MBUS and DRAM0 clocks as M-only clocks
- Base the series on the A523 single-divider clock fixes
- Link to v3: https://patch.msgid.link/20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech

Changes in v3:
- Patch 1: Rename the clock/reset binding headers with the allwinner vendor
  prefix, use BSD-2-Clause for their dual license, and reorder the binding
  properties according to the preferred schema layout
- Patches 1 and 4: Drop the undocumented 12X suffix from the video and DE
  PLL core clock names and binding IDs
- Patch 2: Require all PAT1 enable bits to be set when checking whether SDM
  is enabled
- Patch 4: Model the independently gated peripheral, video, and DE PLL
  outputs as programmable-divider child clocks
- Patch 4: Follow the documented hierarchy for the derived peripheral PLL
  outputs
- Patch 4: Model the explicitly named PLL_AUDIO1 /2 and /5 outputs as
  fixed-factor clocks and initialize their divider fields accordingly
- Patch 4: Model the PLL_AUDIO1 SDM controls so stale firmware settings are
  disabled when an integer rate is programmed
- Patch 4: Add the missing module device table and remove an unused include
- Patch 6: Replace the MP helpers used by timer clocks, which have no M
  divider, with the corresponding P-only helpers
- Patch 7: Document the unresolved parents of bus gates kept on hosc and
  fix the APB/AHB IOMMU1 system clock names
- Patches 3 and 8: Make the reset maps const
- Link to v2: https://patch.msgid.link/20260711-a733-clk-v2-0-974d188cbe0c@pigmoral.tech

Changes in v2:
- Rework the clocks property in DT bindings to source hosc directly from
  the oscillator to adapt to the new RTC binding
- Clean up the SDM dual-pattern helper macro and add the missing enable
  parameter for pll-audio0
- Number single-instance clocks with 0, e.g. GPU0, VE_ENC0/VE_DEC0,
  DRAM0, NAND0, GPADC0, THS0, etc
- Correct 8x PLL post-divider names to 12x for video and DE PLLs
  (pll-videoX-12x, pll-de-12x)
- Drop gic, cpu-peri, nsi clocks
- Rename clocks: OWA -> SPDIF, USB_REF -> USB01_REF, HDMI_ESM -> HDCP_ESM,
  PWMCTRL -> PWM
- Mark bus-dram0, ahb-store and mbus-store critical to avoid DMA, MMC and
  SPI NOR failures when unused clocks are disabled
- Switch PRCM timer clocks to P-only helpers
- Fix bus gate bit positions for UARTs and correct the sysdap register
  address
- Interleave bus clocks into function clocks
- Link to v1: https://lore.kernel.org/r/20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech

---
Junhui Liu (8):
      dt-bindings: clk: sun60i-a733-ccu: Add Allwinner A733 support
      clk: sunxi-ng: sdm: Add dual patterns support
      clk: sunxi-ng: a733: Add PRCM CCU
      clk: sunxi-ng: a733: Add PLL clocks support
      clk: sunxi-ng: a733: Add bus clocks support
      clk: sunxi-ng: a733: Add mod clocks support
      clk: sunxi-ng: a733: Add bus clock gates
      clk: sunxi-ng: a733: Add reset lines

 .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  |  107 +
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    4 +
 drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c           |  277 +++
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2422 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.c                     |   52 +-
 drivers/clk/sunxi-ng/ccu_sdm.h                     |   29 +-
 .../dt-bindings/clock/allwinner,sun60i-a733-ccu.h  |  291 +++
 .../clock/allwinner,sun60i-a733-r-ccu.h            |   38 +
 .../dt-bindings/reset/allwinner,sun60i-a733-ccu.h  |  129 ++
 .../reset/allwinner,sun60i-a733-r-ccu.h            |   23 +
 11 files changed, 3356 insertions(+), 26 deletions(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260202-a733-clk-0d4fc00a9f9c
prerequisite-message-id: <20260906-sunxi-clk-no-p-v1-0-cbde21c9fe69@pigmoral.tech>
prerequisite-patch-id: 0df2ae41836b86fd868dfa01ddfde57f888f761a
prerequisite-patch-id: 88f3a431e7c551a9fa732f062188f10fdd362eeb
prerequisite-patch-id: 3e88bc873c909059d1199f82cda4013765e7a5e5
prerequisite-patch-id: 0dbc27cd7417352319a0705a051dff35085e8922

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

