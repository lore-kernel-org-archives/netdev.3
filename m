Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762354EE868;
	Fri,  4 Sep 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540538; cv=pass; b=FRMVHAEgsNUTWr2OuuRnW2u+atB+Cl6Uj1muufbQKXeUEURgFGK+Qx4LARCnfKm3H2QzhbFbluey7A6lwMbyiygHvDge4IkWzoKHoan9c1w/Q9lZ85kjBjkQHuhq/+x3nCDWj33PUvpipPFf3aV5YWIhh2EAMF1mPz8MkTZV50o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540538; c=relaxed/simple;
	bh=Y9sjBTJ9hFrQqrYxDq2Fqpl/vreR8VRqsKf6hnQCATY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sjsYsLgzKoKWkOVOZkCvHArOhL9IMhA4f+pr+NzWyJmGdy+cR/45kHksTc03PIinjP05OudJShoDbaIjIvWwibur+V7c/xhDAfDLBsaBU+WgFMO8RKHIUqUpOWgkh4H0ZX6YjHynhAxGSW3ixJcpSLscfjQrMntPf41svODXyjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=ftjxekmn; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="ftjxekmn"
ARC-Seal: i=1; a=rsa-sha256; t=1788540404; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N9IRieT/SCRHJ4r0DF/wJxdK3lo0jbad8zGcOncyg7UlyW75jpVgDJAeDgg7xAJiezvdJ0TTDBWVMgPZQi1axNDW2WZ417i4xrywp2zqn+jWCNLf1kMfSyXIuEy23aA+ao70szhvLXbWbQ5nvQlkfLraL8mdGMt+V0EWCGi+ZpE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788540404; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tnvfOvnQKHUOQCvB4ofv1b+vTcRaMN09Qd84S8ymUrI=; 
	b=cLDZDjwTaS4pWi8zmsZ8ViKDhnvEvrw+6FGzaRG9xYc5JQfr2QVw0q3QJ2lOe/+OIxTd4fVAP9bvRr6IBAnPLU3dtVu3bkOSH8g0KWIHqDwRwuJVjHs41c1yHMbOqgTqNunkPwwJ1LXgWvjTYs6lMXWGN9xO3LLdIvJYtTpjv18=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788540404;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=tnvfOvnQKHUOQCvB4ofv1b+vTcRaMN09Qd84S8ymUrI=;
	b=ftjxekmnXiMG/7vhKDMWxrm7xreoTgAoIhCYzsZV0Lv+W3tUhxagBlo8TkBADxbc
	mwsgkwre8fMe4/zCZvDjN2X94omlkllUV+sWBdOmBiLPI5D3P2wJtVY2Ek/H/BhaxWm
	HSvdeWhyP5Jwdezu51bmUUB6ihx69M9re1B+pNaY=
Received: by mx.zohomail.com with SMTPS id 1788540401893275.7810059880454;
	Fri, 4 Sep 2026 09:46:41 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v3 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
Date: Sat, 05 Sep 2026 00:45:29 +0800
Message-Id: <20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12MzQ6CMBAGX4X0bM32R0o5+R7GQykLNCKQljQaw
 rtb8IDxsslsvpmFBPQOAymzhXiMLrhxSCBOGbGdGVqkrk5MOPAc0qFGCUFt/6BQy8YCGN1oS9J
 88ti415663RN3Lsyjf+/lyLbvNyIYHJHIKFCRVxJ1xaW8qOvk2ufoTX+e0XZkC0V+yIqxH5knW
 StZs6KwFYL9l9d1/QAZ+yC94QAAAA==
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
 Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5138;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=Y9sjBTJ9hFrQqrYxDq2Fqpl/vreR8VRqsKf6hnQCATY=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJmfd3bvEDl5jfRN6u9Ni7OLFhmeOulrMkZKxn9hYqvO
 88e0dkj21HKwiDGxSArpsjC5S/+z1qH59sRgdb7MHNYmUCGMHBxCsBElq9nZHgaaNqmX9AoxKh3
 6LFpoMaq4wf2b1m1au3VfeaVUfsFBKsY/rs8O6ezfQGXz85VHTeaNS/sUpqwSj///a1pSbv2W91
 uF2MGAA==
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

---
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
 drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c           |  273 +++
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2393 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.c                     |   52 +-
 drivers/clk/sunxi-ng/ccu_sdm.h                     |   29 +-
 .../dt-bindings/clock/allwinner,sun60i-a733-ccu.h  |  290 +++
 .../clock/allwinner,sun60i-a733-r-ccu.h            |   39 +
 .../dt-bindings/reset/allwinner,sun60i-a733-ccu.h  |  129 ++
 .../reset/allwinner,sun60i-a733-r-ccu.h            |   23 +
 11 files changed, 3323 insertions(+), 26 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260202-a733-clk-0d4fc00a9f9c

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

