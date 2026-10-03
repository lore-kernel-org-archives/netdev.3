Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058913B6359;
	Sat,  3 Oct 2026 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791031992; cv=pass; b=SjjcDQw9GlbI6KnyInd3r1YBYcvj1tskP1vgDzCThqzQyVlHDxwxDm7nWQ/b1jzFb6Eq90IQx44imuPBrXpOasDTd2ltaINwFWBoNxIddm0KEqYeRRPJTYuVj+tAn36B/bNjTQTpKiDenSJLrAJ5Ny1X48f+KAANp1W34tf7kRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791031992; c=relaxed/simple;
	bh=rH14carUj0uSQqIYD5FEvx8V6DrzhIC+GPdnpvka0pM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GFfiwVw9Lc9qtmsIv0RhTS8pGnvTl39rJjgimI96K0nkxtsGhdESgxlrqrehJYzcWZaGq1UsvG3FyIW/yKCZMZhSmOjuLR+/96moGba0/orQImb7J9cfypAd0IfVi/ggorpEM1aqXo7wFIP3gvEDFkfDKJeddGOv3S/3aHTjYDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=NcNoKS1c; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="NcNoKS1c"
ARC-Seal: i=1; a=rsa-sha256; t=1791031939; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N5vt+iiHQmegh8SyIvLQAUi/f2vSOUw9Z9mN4vteHwlOWTE4409DJodDQF5EkRZNNI0TPyqm/MGA8uJ1Ioo93Cy9VtqAL82OGHcE7dPOUVcDxWgG++iyd5Aatnp2CNrONz4v8lTl8odyrZ62C5QzKzNLyf9TGlucNq2QrxcLJno=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791031939; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w9AGJ2+NMj0TzmkVZNqdUpfodPO1cSXhGRHZ/sEBZS8=; 
	b=lOLp+AnBm+oAYiJ6gKX/8SnHJ+Z7hqO0RnfS42v81HGtL1WRXtB4n/ASPZ28t8dTTjrsgg04dX1V0yVC9L5wbTNt16x8cGSbcF0LumQiW0mItpj/JuVFHU90kfeGQdLCw5HTAupV9FOgiAObpwDWtmEcw48zA60ShPVeVrKxsaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791031939;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Reply-To;
	bh=w9AGJ2+NMj0TzmkVZNqdUpfodPO1cSXhGRHZ/sEBZS8=;
	b=NcNoKS1cOcBSYTvhxhBySCVO9GEvTQJ2o4AjxuwLzD3RQ2hda0qzJm1wX9BrRGCO
	1gKy70NWKW4Avd7awRlod4hQIxxeDcqLXnF9/O4/fOXCMZ92QlEuH0WDRbs3WW4lCOI
	Qqk53dxVOoXI8x61uIvSXgdFzt6FwD5p4CFHmy7A=
Received: by smtp.zohomail.com with SMTPS id 1791031938348944.7508385072523;
	Sat, 3 Oct 2026 05:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 20:52:08 +0800
Message-Id: <DLV7TXB5Q2PM.EYY9YISYPCR@pigmoral.tech>
Subject: Re: [PATCH v5 0/8] clk: sunxi-ng: Add support for Allwinner A733
 CCU and PRCM
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>, "Stephen Boyd"
 <sboyd@kernel.org>, "Brian Masney" <bmasney+clk@redhat.com>, "Jerome
 Brunet" <jbrunet+clk@baylibre.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <netdev@vger.kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>, "Enzo
 Adriano" <enzo.adriano.code@gmail.com>, "Andre Przywara"
 <andre.przywara@arm.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
In-Reply-To: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
X-ZohoMailClient: External

Hi folks,

Gentle ping on this series.

It would be great if this could make it into v7.4, as other A733 drivers
can then be developed on top of the clock/reset support provided by this
series.

On Wed Sep 30, 2026 at 1:26 AM CST, Junhui Liu wrote:
> Add support for the main CCU and the PRCM module (R-CCU) found in the
> Allwinner A733 SoC. The clock architecture is derived from the previous
> A523 design, with the MCU_CCU removed and the clock tree extended for
> the additional functional blocks found on the A733.
>
> The A733 introduces a "pll-ref" clock that normalizes the physical
> oscillator frequency, which can be 19.2MHz, 24MHz, or 26MHz, into a
> consistent 24MHz reference for the PLL clock tree.
>
> The peripheral, video, and DE PLLs provide multiple independently gated
> outputs with programmable dividers. Model these outputs as separate
> divider-and-gate child clocks. Also follow the documented hierarchy for
> the derived peripheral PLL outputs. The explicitly named PLL_AUDIO1 /2
> and /5 outputs are modeled as fixed-factor clocks, with their divider
> fields initialized accordingly.
>
> Also extend the sunxi-ng SDM (Sigma-Delta Modulation) support for the
> dual-pattern register layout used by the A733 PLLs. PLL_AUDIO0 uses the
> dual-pattern SDM support to synthesize its fractional output.
> PLL_AUDIO1 does not expose fractional rates, but its SDM controls are
> modeled so that stale settings left by firmware can be disabled when an
> integer rate is programmed.
>
> The actual parents of a small number of bus gates are not documented in
> the user manual. Follow the vendor BSP and keep these gates parented to
> "hosc" until more complete hardware information is available.
>
> This series depends on the A523 single-divider clock fixes [1], which
> add feature support to the M-only clock macro used by the MBUS and DRAM0
> clocks. The prerequisite series has been applied to the
> sunxi/clk-for-7.4 branch.
>
> Link: https://patch.msgid.link/20260906-sunxi-clk-no-p-v1-0-cbde21c9fe69@=
pigmoral.tech [1]
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
> Changes in v5:
> - Add the CLK_GIC binding ID, inserted after CLK_TRACE
> - Add the GIC clock and mark it critical
> - Fix the continuation line alignment of the trace clock
> - Mark ahb-cpus critical
> - Link to v4: https://patch.msgid.link/20260921-a733-clk-v4-0-9c184ebe9ac=
1@pigmoral.tech
>
> Changes in v4:
> - Model the MBUS and DRAM0 clocks as M-only clocks
> - Base the series on the A523 single-divider clock fixes
> - Link to v3: https://patch.msgid.link/20260905-a733-clk-v3-0-50f238f39c7=
8@pigmoral.tech
>
> Changes in v3:
> - Patch 1: Rename the clock/reset binding headers with the allwinner vend=
or
>   prefix, use BSD-2-Clause for their dual license, and reorder the bindin=
g
>   properties according to the preferred schema layout
> - Patches 1 and 4: Drop the undocumented 12X suffix from the video and DE
>   PLL core clock names and binding IDs
> - Patch 2: Require all PAT1 enable bits to be set when checking whether S=
DM
>   is enabled
> - Patch 4: Model the independently gated peripheral, video, and DE PLL
>   outputs as programmable-divider child clocks
> - Patch 4: Follow the documented hierarchy for the derived peripheral PLL
>   outputs
> - Patch 4: Model the explicitly named PLL_AUDIO1 /2 and /5 outputs as
>   fixed-factor clocks and initialize their divider fields accordingly
> - Patch 4: Model the PLL_AUDIO1 SDM controls so stale firmware settings a=
re
>   disabled when an integer rate is programmed
> - Patch 4: Add the missing module device table and remove an unused inclu=
de
> - Patch 6: Replace the MP helpers used by timer clocks, which have no M
>   divider, with the corresponding P-only helpers
> - Patch 7: Document the unresolved parents of bus gates kept on hosc and
>   fix the APB/AHB IOMMU1 system clock names
> - Patches 3 and 8: Make the reset maps const
> - Link to v2: https://patch.msgid.link/20260711-a733-clk-v2-0-974d188cbe0=
c@pigmoral.tech
>
> Changes in v2:
> - Rework the clocks property in DT bindings to source hosc directly from
>   the oscillator to adapt to the new RTC binding
> - Clean up the SDM dual-pattern helper macro and add the missing enable
>   parameter for pll-audio0
> - Number single-instance clocks with 0, e.g. GPU0, VE_ENC0/VE_DEC0,
>   DRAM0, NAND0, GPADC0, THS0, etc
> - Correct 8x PLL post-divider names to 12x for video and DE PLLs
>   (pll-videoX-12x, pll-de-12x)
> - Drop gic, cpu-peri, nsi clocks
> - Rename clocks: OWA -> SPDIF, USB_REF -> USB01_REF, HDMI_ESM -> HDCP_ESM=
,
>   PWMCTRL -> PWM
> - Mark bus-dram0, ahb-store and mbus-store critical to avoid DMA, MMC and
>   SPI NOR failures when unused clocks are disabled
> - Switch PRCM timer clocks to P-only helpers
> - Fix bus gate bit positions for UARTs and correct the sysdap register
>   address
> - Interleave bus clocks into function clocks
> - Link to v1: https://lore.kernel.org/r/20260310-a733-clk-v1-0-36b4e9b244=
57@pigmoral.tech
>
> ---
> Junhui Liu (8):
>       dt-bindings: clk: sun60i-a733-ccu: Add Allwinner A733 support
>       clk: sunxi-ng: sdm: Add dual patterns support
>       clk: sunxi-ng: a733: Add PRCM CCU
>       clk: sunxi-ng: a733: Add PLL clocks support
>       clk: sunxi-ng: a733: Add bus clocks support
>       clk: sunxi-ng: a733: Add mod clocks support
>       clk: sunxi-ng: a733: Add bus clock gates
>       clk: sunxi-ng: a733: Add reset lines
>
>  .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  |  107 +
>  drivers/clk/sunxi-ng/Kconfig                       |   10 +
>  drivers/clk/sunxi-ng/Makefile                      |    4 +
>  drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c           |  273 +++
>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2406 ++++++++++++++=
++++++
>  drivers/clk/sunxi-ng/ccu_sdm.c                     |   52 +-
>  drivers/clk/sunxi-ng/ccu_sdm.h                     |   29 +-
>  .../dt-bindings/clock/allwinner,sun60i-a733-ccu.h  |  291 +++
>  .../clock/allwinner,sun60i-a733-r-ccu.h            |   39 +
>  .../dt-bindings/reset/allwinner,sun60i-a733-ccu.h  |  129 ++
>  .../reset/allwinner,sun60i-a733-r-ccu.h            |   23 +
>  11 files changed, 3337 insertions(+), 26 deletions(-)
> ---
> base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> change-id: 20260202-a733-clk-0d4fc00a9f9c
> prerequisite-message-id: <20260906-sunxi-clk-no-p-v1-0-cbde21c9fe69@pigmo=
ral.tech>
> prerequisite-patch-id: 0df2ae41836b86fd868dfa01ddfde57f888f761a
> prerequisite-patch-id: 88f3a431e7c551a9fa732f062188f10fdd362eeb
> prerequisite-patch-id: 3e88bc873c909059d1199f82cda4013765e7a5e5
> prerequisite-patch-id: 0dbc27cd7417352319a0705a051dff35085e8922
>
> Best regards,
> -- =20
> Junhui Liu <junhui.liu@pigmoral.tech>

--=20
Best regards,
Junhui Liu

