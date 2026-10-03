Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BD32B104
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034682; cv=none; b=Xw1ljkZEb5oHdMzDVdUgB8woqQlAgzclr8RUT1gnCHsKMABrvYGFBbl3CEebZFilF1c65SX462F3Nq5nW56kyhrwJQ30X/8CUe5q0h+9aWW55anaFnLZveyHVWzZdTcrv03aV8AmXxyNySkJQRPX7spL4Vee/MgbXZWzFat1Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034682; c=relaxed/simple;
	bh=ArrPLAXTmiW750X0hyiB51dp23uByMOYZwkt3RhpfVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHeXefDTco/ZRwGJUTTb7bsXuNmuR9AnjBO0rJAZmIVxuYixW3nTd1hxoN/X7qoj2I8IMO5bDfYBTfVaLG/+hokF7MvdZOb1FNe9xIF39dxA92WkdZ+3SUXK8/kQj+FU/yXqvzR8SmBhYvTQR80h5cXK4x/ffC4vwMPDGmoc7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkmkDHPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkmkDHPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861B81F008A1
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791034680;
	bh=R73yQ3jH6GvWRUmndkK++08QPLSVcxmoMOlppi3GsLA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=gkmkDHPqUMMEtJPnPIOMYKgusfwkkGQEnExjtK270Y2aRbiYJ3J4owePAH7MtL6Rs
	 +pMqnV/CZm5MYSpNN7FmqXellpG1au572wfMvXsVpqxuzSTl8BIQaJmYIN6pmHxB2Q
	 pUsvROA1pc1L17BJPC4Gvm2lmigBOjO2SplnnyiNsXwdcW+Y3z43ZKYyBpPVT6TdoF
	 U+hdWghywMfDda2XiTxIG1e8dozBnHR3Iqcquh/ua1ak/G/1oC/9sB5OnR7VtyNHx/
	 6OImIsZsSatsjCyIyREHFrdadfKfdI4QrrbYGRRLBnMSvrzWdFQKxNSjaQ4nSvmeST
	 JwxnMPTbu497g==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5bcb81018ecso229064e87.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 06:38:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZ2bE2cfY5sXgLErTn8Cf2IYmmzZmq3NRg7jrfQrBV5wLEYDMc4Xw+LlAPGUuIxRKb53m5g7Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFCEimes5AxwUcWILaTtokt1F1dBm/K5UZfGU2sMY1xTmiCg5P
	EEpBUAZ0/jMJLSzwGEZPY2hj+nPeRjz5sPB38XWr3WJnKLlm2cGNVJLMmijeV7rQ5QX2krbXIVN
	ZPVhTdbhJbQkWl82iA8VmxMgH8C7svJo=
X-Received: by 2002:a05:651c:b11:b0:3a7:7a0e:5703 with SMTP id
 38308e7fff4ca-3a87ed423a1mr16877761fa.2.1791034678614; Sat, 03 Oct 2026
 06:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
In-Reply-To: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sat, 3 Oct 2026 21:37:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v66O7Ze=TiHO_5q=76QpU8ZXraFyV+HfO+_HpkTDr1U-nQ@mail.gmail.com>
X-Gm-Features: AclHuK8VXX-H-epbJc-LIAYuxq6Cwq5Gper5Df4uf2UiYK9NyxKckBCIfgbI7oY
Message-ID: <CAGb2v66O7Ze=TiHO_5q=76QpU8ZXraFyV+HfO+_HpkTDr1U-nQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] clk: sunxi-ng: Add support for Allwinner A733 CCU
 and PRCM
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Enzo Adriano <enzo.adriano.code@gmail.com>, 
	Andre Przywara <andre.przywara@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Yixun Lan <dlan@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 1:27=E2=80=AFAM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
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

Some of the clock controls, like the PLL and AHB/APB bus dividers, are
secure by default and need to be set to non-secure for Linux to be able
to use them properly. And there is also a TWD clock in the PRCM that the
user manual says is secure only.

Have you given any thought to this? If we end up having to convert to
SCMI or something to handle those clocks it's going to be a bit ugly.

And presumably things work now because the secure/non-secure access bit
isn't in effect right now because you aren't using secure boot? At least
this was a thing in the past...


Thanks
ChenYu


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
> --
> Junhui Liu <junhui.liu@pigmoral.tech>
>
>
