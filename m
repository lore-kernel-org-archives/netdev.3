Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467651;
	b=Y6ggbYTGKRfyXb/KBLr8+os+AYJ2+x23f/9WZpwA+9r9LNnOqJ2+N+ow3vH+a5BaDQ0v
	 lbwyWSBFZpiCLP6O6EvggwDIvvRqrNzXECJkrn/qds3njiD1Alpev6tnBggd10OTDoyEF
	 g/HLqKEKSEdul378hp8XWhqycbzPwFJkcyjr5C7NfXwAAGxntdokwj+ce/IGbT5adY5uT
	 ldZKsFDHp9h35AL4yMiZ/KmFn6R7oJiSq8RFAzk3CrLPBPZKoIHzdxOoVQkK6G+wRQEx4
	 HPOYszqTBE0158X0uxtBygOQg0V9eYj26QG0C9CKXaxQuhpQNFMap70j7/ZzhLvyafQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467651;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ZohoMailClient;
	bh=7SJXi7Q2ISPCL9/+n6wNfoFH+ghIme3sVDHuX/k4ej8=;
	b=Zd1Dj/2dH68BkyUXhKl3BlK7qNVeoIkKKhWDBipfTRp4tqVjn5sZdYuU3Q7lsYP8sPXW
	 LJnw/qt9Nx8PmoV6Ki3rpoHL1Q+tHh9UZijqTzI3wL75jaXZOD/1xMJbIMzkRRuPCpy7g
	 pwCNWl736UqSOxgyo3qleoQVNwuCWdyhDOISRI1yJ+i9EWwuy5ytqqmSb8KWWUATtKMLo
	 UBGYXu5y4mcaFHhqZz9YBHL4YRqhcLuVG1M8aW85pFoq7y1GpKYs0MydTo8F28QIjXMCN
	 CwANDNKEhxOkPBn50jlf6YTjzWcOoo+E6mVsi5Am59++DBOmA5Gcct5wxjqM2z8aiTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pigmoral.tech;
	spf=pass smtp.mailfrom=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=T9dFumNz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B6606A323;
	Thu, 12 Nov 2026 07:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 670B6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=T9dFumNz
ARC-Seal: i=1; a=rsa-sha256; t=1794467600; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GQklXaqEgzoVYf5QvQNRVkuZrFajDf0rTAqn0LZQCn+i0syIt4JcF/N3DGoqy+C4mg70XqtJOgqC2pYxAdmkBmgWQ5foRx7AD5gRf7Gbesm1nDqvY9aBrh6C19jQ/nE+E7PyT2fpsjEZWbnsVzC+KYBztvD0AJeox9BIyn2nu+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794467600; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7SJXi7Q2ISPCL9/+n6wNfoFH+ghIme3sVDHuX/k4ej8=; 
	b=HUpIXfXR0eSwB8ADPbgrtW6eduuB7GP74Xz8Zmst0WLWU/mkxJDhEXdWQv8o7M+sQg4C1vdpdz4aZ1xdPRi0RfTBTzjkX+Axnf8Bu8f71wYpkLX4IzhCYBFhVtsr1oPok/wgmcj+Z0RoV/FO47+yYWLqy45YLg504OKOP1sYt4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: a=rsa-sha256; b=T9dFumNziim9obSDgP1Eer5PfVgZQWQndkGmlqvbTKrImdQNnZovRCyKOFZq9Ib0pj0tuNwe9gaLzrTyzAXs0LyiIu0n6VuMJA9Sw4B8AZYyc17RWSektM/e97NZcXpZFa7ihFhgEsuFg1eDojBWadeW9t89I167A77LeYpdg5M=; c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1; bh=7SJXi7Q2ISPCL9/+n6wNfoFH+ghIme3sVDHuX/k4ej8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794467599617418.7331795434135;
	Wed, 11 Nov 2026 23:13:19 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v7 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
Date: Thu, 12 Nov 2026 15:11:49 +0800
Message-Id: <20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23RzU7EIBAH8FfZcBbD8FHAk+9hPNDpsCWu25XWR
 rPpu0t3jSWxF5Ih/P4zZK5spJxoZE+HK8s0pzEN51LYhwPDPpyPxFNXaiaFbEQ5eLBKcTy9cdH
 piEIEHz2y8vySKaavW9TLa6n7NE5D/r4lz7De3kMUiC1kBi64alpNvpVaG/t8Scf3IYfT40TYs
 zVolhu2ABWWBXurO3AOWxK4h9WGvTAVVgUbEaVyUXm0bg/rCsu6s147IzhNLfmAsIdNhVX9Z1M
 wAFjTasBOdnu4+cMghK9wU3AgB9ZFJEv/xl7uq8j08VmWOf3uY1l+AFb+4BLqAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7391;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=FEdphdA6ezS+mTsUDdTB+sTKWjVRHNI1UV7u1NsCN6Q=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLK+pl0tt79156Di0zNvSw7fZajj2/F4b3I97/qdTXdT5
 81pW5Uj3lHKwiDGxSArpsjC5S/+z1qH59sRgdb7MHNYmUCGMHBxCsBELH0ZGc6GilTuzNM+ajan
 OnDR1cXZYYt2CNr/FfvH8j7pwP4/IS0M/4N/1+0+dnzX+fVe/Jrn6w419jyIKVx7RV9/1uSVtWv
 P3OIEAA==
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

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
Changes in v7:
- Rebase to v7.4-rc1
- Patch 5: Fix the MBUS parents to use periph0 instead of periph1
- Patch 6: Fix the G2D parent order and replace video1 with video2
- Patch 6: Fix the DRAM0 parents and widen its divider to 5 bits
- Patch 6: Fix the IRTX first parent and the SGPIO parent order
- Patch 6: Add the missing gates for usb01-ref and usb2-u2-ref
- Patch 6: Add the second divider for edp-tv and fix the HDMI CEC and SFR
  mux widths
- Patch 6: Add the missing video0_4x and video1_4x parents for CSI
- Patch 6: Use the documented parents and fixed dividers for fanout-16M
  and fanout-25M
- Patch 6: Reuse common parent arrays
- Link to v6: https://patch.msgid.link/20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech

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
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2402 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.c                     |   52 +-
 drivers/clk/sunxi-ng/ccu_sdm.h                     |   29 +-
 .../dt-bindings/clock/allwinner,sun60i-a733-ccu.h  |  291 +++
 .../clock/allwinner,sun60i-a733-r-ccu.h            |   38 +
 .../dt-bindings/reset/allwinner,sun60i-a733-ccu.h  |  129 ++
 .../reset/allwinner,sun60i-a733-r-ccu.h            |   23 +
 11 files changed, 3336 insertions(+), 26 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260202-a733-clk-0d4fc00a9f9c

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

