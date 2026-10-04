Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA524DCF9
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111843; cv=none; b=d05XvW9ixK8WdH6wXEYaBWMYsuS6xrznLQXdbjQa43TVg38Gs4G3OTpjOPRIOH1oPQM0L7eu7jQR+xsYRgMcbpz4f+OrbV4X9fF9H0r+X5YinEPJfQk5umaWpaBGhkDDo9xJmV1rpt40xsftVKakqdH4UIZIdtVPHiUgMaCdiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111843; c=relaxed/simple;
	bh=1GuMMdI0gCkYAcDChdWziL+okYLnQHMBpAIl7CKXeKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttXtnHBkX/ua06lsOgwmSWOqkMLh3R35GAvH7cIFjPliGlyQyLp9tHOu3p9lK8Y76Aao9ZlbkzOV3KSw7KCmJDxvd2LJPYyQ1vjEtqpE9wlG7PcLRi+fo8mQulHOPwyCydm44LTZu0CAq8oHIYVXesM5pjxrYyku3GJ5WQT5e+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq47FrTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq47FrTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85CF1F008A1
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791111841;
	bh=sP+U6vTOYVFeaddq3bndo5VJDBbsue1fF5yn9Hxp6Z8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=Wq47FrTZl87QqSe72Vw6iixqDzDAGVGWBG4ujf3ihu+oLVPRSKYEu4pliFc7Vnu4B
	 0CAFZ1R3dg8mMjq5nwRYczn8xSsmIdg0NTH4ZAuh4m5FlVzq/kzuJ5BYsdQntAmm+8
	 8ApZI6wnB0PbodOQ4hO68ZUjinVkDPBMHODWLypyPwwT3HPUqzxfMHYLAHtT/DTJGL
	 IEnpyIrsIzVRN8sIBrKl0+bVI8YL3wmqt6nFPh8pfP8qi9iILS/2BpWVAcxTCYT0WZ
	 YaEtzUPzXkLkZQg5Q3vcmXOPxQ4XcD2Ec50gSfqI4cb/ywjVFJ0RSER2Dd/gLQr5+Z
	 UJ1tYbAxQRntQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a97c689f0bso5438161fa.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 04:04:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwoo5KxE0zaqi54mYlBAaTrHTZxR67aB1dxWJa3aR5nEw/W/KW4Tkg9hvM9AsCoCSNXitdMAW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfnnDorlA0YYRsOS6CiUzzdgphcXu/T1V6Vi8QfAtMiy3McCwE
	7CzySzpI0kss3El3RtW8QxtcWEU/68b6esR6FhzvuoGdFLIgpcdD0xYFn4NrOW4EMKrGDeKqHh0
	97O7CQiEA87AN0W/K6UvnfpP6DXXjYxk=
X-Received: by 2002:a05:651c:b06:b0:3a3:2a41:e329 with SMTP id
 38308e7fff4ca-3a974f2002fmr11552811fa.9.1791111839797; Sun, 04 Oct 2026
 04:03:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-7-11175b41cd2d@pigmoral.tech>
In-Reply-To: <20260930-a733-clk-v5-7-11175b41cd2d@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 4 Oct 2026 13:03:46 +0200
X-Gmail-Original-Message-ID: <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
X-Gm-Features: AclHuK-3Yak0ZaS0tUNz8C2FVnQs0VdN0bcI-ns1tG3C0FjgWxx3tVmNCyaYb4Y
Message-ID: <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] clk: sunxi-ng: a733: Add bus clock gates
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
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:28=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
> Add the bus clock gates that control access to the devices' register
> interface on the Allwinner A733 SoC. These clocks are typically
> single-bit controls in the BGR registers, covering UARTs, SPI, I2C, and
> various multimedia engines. It also includes bus gates for system
> components like the IOMMU and MSI-lite interfaces.
>
> Also mark the ahb-store, mbus-store and ahb-cpus clocks as critical.
> Disabling either store gate breaks access to boot/storage devices such
> as MMC and SPI NOR, while gating ahb-cpus hangs any access to the CPUS
> power domain registers when unused clocks are disabled.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 492 +++++++++++++++++++++++++++=
+++++-
>  1 file changed, 491 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-n=
g/ccu-sun60i-a733.c
> index 1b2d4d36ec4c..b077e5d2f32c 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> @@ -4,6 +4,10 @@
>   * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>   * Based on the A523 CCU driver:
>   *   Copyright (C) 2023-2024 Arm Ltd.
> + *
> + * TODO: The real parents of some bus gates, including its-pcie0-aclk,
> + * msi-lite, npu, ufs, sgpio, lpc and i2spcm, are not documented in the
> + * manual. For now, follow the vendor BSP, which keeps them on hosc.
>   */

[...]

> @@ -510,9 +522,118 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_clk=
, "mbus", mbus_parents, 0x588
>                                            BIT(31),     /* gate */
>                                            CLK_IS_CRITICAL,
>                                            CCU_FEATURE_UPDATE_BIT);
> +static const struct clk_hw *mbus_hws[] =3D { &mbus_clk.common.hw };
> +
> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_sys_clk, "mbus-iommu0-sys", mbus_h=
ws, 0x58c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(apb_iommu0_sys_clk, "apb-iommu0-sys", apb0_hws=
, 0x58c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_iommu0_sys_clk, "ahb-iommu0-sys", ahb_hws,=
 0x58c, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE_DATA(bus_msi_lite0_clk, "bus-msi-lite0", hosc, 0x5=
94, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_msi_lite1_clk, "bus-msi-lite1", hosc, 0x5=
9c, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA(bus_msi_lite2_clk, "bus-msi-lite2", hosc, 0x5=
a4, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", mbus_h=
ws, 0x5b4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb-iommu1-sys", apb0_hws=
, 0x5b4, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb-iommu1-sys", ahb_hws,=
 0x5b4, BIT(2), 0);

> +static SUNXI_CCU_GATE_HWS(ahb_ve_dec_clk, "ahb-ve-dec", ahb_hws,
> +                         0x5c0, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_ve_enc_clk, "ahb-ve-enc", ahb_hws,
> +                         0x5c0, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_vid_in_clk, "ahb-vid-in", ahb_hws,
> +                         0x5c0, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout0_clk, "ahb-vid-cout0", ahb_hws,
> +                         0x5c0, BIT(3), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout1_clk, "ahb-vid-cout1", ahb_hws,
> +                         0x5c0, BIT(4), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_de_clk, "ahb-de", ahb_hws,
> +                         0x5c0, BIT(5), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_npu_clk, "ahb-npu", ahb_hws,
> +                         0x5c0, BIT(6), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_gpu0_clk, "ahb-gpu0", ahb_hws,
> +                         0x5c0, BIT(7), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_serdes_clk, "ahb-serdes", ahb_hws,
> +                         0x5c0, BIT(8), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_usb_sys_clk, "ahb-usb-sys", ahb_hws,
> +                         0x5c0, BIT(9), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_msi_lite0_clk, "ahb-msi-lite0", ahb_hws,
> +                         0x5c0, BIT(16), 0);
> +static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
> +                         0x5c0, BIT(24), CLK_IS_CRITICAL);
> +static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
> +                         0x5c0, BIT(28), CLK_IS_CRITICAL);

I suspect these refer to a AHB-AHB bridge for the various subsystems shown
in the memory map. That would explain why when the "ahb-store" clock is
gated, the storage bits stop working.

If that's the case, we should describe it as the parent of each storage
peripheral bus gate's parent. Same would go for the other types. I haven't
checked what the BSP does though.

> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_clk, "mbus-iommu0", mbus_hws,
> +                         0x5e0, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_clk, "mbus-iommu1", mbus_hws,
> +                         0x5e0, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_desys_clk, "mbus-desys", mbus_hws,
> +                         0x5e0, BIT(11), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_gate_clk, "mbus-ve-enc0-gate", mb=
us_hws,
> +                         0x5e0, BIT(12), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_gate_clk, "mbus-ve-dec0-gate", mb=
us_hws,
> +                         0x5e0, BIT(14), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_gpu0_clk, "mbus-gpu0", mbus_hws,
> +                         0x5e0, BIT(16), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_npu_clk, "mbus-npu", mbus_hws,
> +                         0x5e0, BIT(18), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_vid_in_clk, "mbus-vid-in", mbus_hws,
> +                         0x5e0, BIT(24), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_serdes_clk, "mbus-serdes", mbus_hws,
> +                         0x5e0, BIT(28), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite0_clk, "mbus-msi-lite0", mbus_hws=
,
> +                         0x5e0, BIT(29), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_store_clk, "mbus-store", mbus_hws,
> +                         0x5e0, BIT(30), CLK_IS_CRITICAL);

Same thing for the MBUS clocks.

> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite2_clk, "mbus-msi-lite2", mbus_hws=
,
> +                         0x5e0, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE_HWS(mbus_dma0_clk, "mbus-dma0", mbus_hws,
> +                         0x5e4, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_clk, "mbus-ve-enc0", mbus_hws,
> +                         0x5e4, BIT(1), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
> +                         0x5e4, BIT(2), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_dma1_clk, "mbus-dma1", mbus_hws,
> +                         0x5e4, BIT(3), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_nand_clk, "mbus-nand", mbus_hws,
> +                         0x5e4, BIT(5), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
> +                         0x5e4, BIT(8), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
> +                         0x5e4, BIT(9), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_gmac0_clk, "mbus-gmac0", mbus_hws,
> +                         0x5e4, BIT(11), 0);
> +/* Undocumented, taken from the vendor kernel. */
> +static SUNXI_CCU_GATE_HWS(mbus_gmac1_clk, "mbus-gmac1", mbus_hws,
> +                         0x5e4, BIT(12), 0);
> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_clk, "mbus-ve-dec0", mbus_hws,
> +                         0x5e4, BIT(18), 0);

[...]

The remaining definitions look correct (minus the vendor BSP ones which I
couldn't check at this time).

I didn't check the clock list additions.

Consider this

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>


We can change the AHB / MBUS clock parents later if we do figure it out.


ChenYu
