Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19B48D872;
	Tue,  6 Oct 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298316; cv=pass; b=aKJIJfSthdsC8uyygCOoSCzftwdGHISmnarUcG+SHaxMBzqG+bnV+Mkv8XNV0GPCtnh/okdRU2+UUPi8xrXxIgRfOg8MxfwWRWJxxftPWP42uSCzbM0PvnLFqTokvgBHjfECwfcFCEZ7dD9J6dyXjwHyKL2EVB2LLkLU0dIsmTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298316; c=relaxed/simple;
	bh=xp4TpAnZJ8pV/cSJVVO6TBBgOg0fs10ejIwlTXONutI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r3tSj6bLhsBD1NCeQwxlxMJmCtRp5opvmpyWm5BlCF/XwkMhGk/S/doTxd8G4MamsCvDCCwpiVVc7ZPfeFW468gdcnbpYJyQrugTwNCH132biiQNcqutS+Fd8khjDvYKDbk7iwCDq+4NK4t7QUZC00mV58N8E7SUNnTZhm0JmEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=IVzgev0T; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="IVzgev0T"
ARC-Seal: i=1; a=rsa-sha256; t=1791298248; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UrTUQfRR23+2xgdIqR7ufPIOQtXKYEmKzw22QZhkDTRkUab/dXpLLIeAWpsl6J04gQiIMaUqdHrfSYj8ibT4ScL49qqjdzpIVcBEJKje09vkKiZXEEksPT182OnrG4X+AdE6e2W8lepWIJfDNvDge4Ndm7ChAwmRXPbv1RggZX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791298248; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qW3JrXnSc/0PGNO65eZiaUtPOoi0orx1PmmfsGlG284=; 
	b=Xj2v+E9DkNWwKyCFm2GwLlNrxcTWxTlvN5+DvEqO+/hXb2vXDpbGTR0p/ojgC0qyNODoqtSJOKEx5O7sm4yRM8zPuynEs1phkbJQ3J06K8XP6ZlSa4GOtFEJkv3TpQHkTrnsemxK6CSymjoeSlEQMrhHU3fGUQkMbGr8Gr0vS7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791298248;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
	bh=qW3JrXnSc/0PGNO65eZiaUtPOoi0orx1PmmfsGlG284=;
	b=IVzgev0T1bHj9svuH4dGyZFR2ISdAvkNrGwqY/VQGNW1gWvE2brirG7Zu7Qsx7Sm
	MUoiK6yo8bKGQx0d+lqAhNanirS+dz2/1HQhaKWDTtKEV7f3kkHDbRTJIiyYhExFQUq
	/rYY1dLRM0wiVdFTN8BS07NGFSFnzKJ7Tqbr9idE=
Received: by smtp.zohomail.com with SMTPS id 1791298245153771.1925389458397;
	Tue, 6 Oct 2026 07:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 22:50:34 +0800
Message-Id: <DLXU88MGGIWX.2IUEKEMBTV4QC@pigmoral.tech>
Cc: "Stephen Boyd" <sboyd@kernel.org>, "Brian Masney"
 <bmasney+clk@redhat.com>, "Jerome Brunet" <jbrunet+clk@baylibre.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>, "Jerome
 Brunet" <jbrunet@baylibre.com>, "Enzo Adriano"
 <enzo.adriano.code@gmail.com>
Subject: Re: [PATCH v5 7/8] clk: sunxi-ng: a733: Add bus clock gates
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Andre Przywara" <andre.przywara@arm.com>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, <wens@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
 <20260930-a733-clk-v5-7-11175b41cd2d@pigmoral.tech>
 <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
 <DLWMN3TYBP9F.3N62QFP7QEE9U@pigmoral.tech>
 <4ac4c90f-887e-4545-9c26-9706bdaa1a79@arm.com>
In-Reply-To: <4ac4c90f-887e-4545-9c26-9706bdaa1a79@arm.com>
X-ZohoMailClient: External

Hi Andre, Chen-Yu,

I ran some tests and now have a better understanding of the clock
hierarchy. Please see the results below.

On Mon Oct 5, 2026 at 5:17 PM CST, Andre Przywara wrote:
> Hi,
>
> On 10/5/26 06:41, Junhui Liu wrote:
>> Hi Chen-Yu,
>>=20
>> On Sun Oct 4, 2026 at 7:03 PM CST, Chen-Yu Tsai wrote:
>>> On Tue, Sep 29, 2026 at 7:28=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral=
.tech> wrote:
>>>>
>>>> Add the bus clock gates that control access to the devices' register
>>>> interface on the Allwinner A733 SoC. These clocks are typically
>>>> single-bit controls in the BGR registers, covering UARTs, SPI, I2C, an=
d
>>>> various multimedia engines. It also includes bus gates for system
>>>> components like the IOMMU and MSI-lite interfaces.
>>>>
>>>> Also mark the ahb-store, mbus-store and ahb-cpus clocks as critical.
>>>> Disabling either store gate breaks access to boot/storage devices such
>>>> as MMC and SPI NOR, while gating ahb-cpus hangs any access to the CPUS
>>>> power domain registers when unused clocks are disabled.
>>>>
>>>> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>>>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>>>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>>>> ---
>>>>   drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 492 +++++++++++++++++++++++=
+++++++++-
>>>>   1 file changed, 491 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunx=
i-ng/ccu-sun60i-a733.c
>>>> index 1b2d4d36ec4c..b077e5d2f32c 100644
>>>> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>>>> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>>>> @@ -4,6 +4,10 @@
>>>>    * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>>>    * Based on the A523 CCU driver:
>>>>    *   Copyright (C) 2023-2024 Arm Ltd.
>>>> + *
>>>> + * TODO: The real parents of some bus gates, including its-pcie0-aclk=
,
>>>> + * msi-lite, npu, ufs, sgpio, lpc and i2spcm, are not documented in t=
he
>>>> + * manual. For now, follow the vendor BSP, which keeps them on hosc.
>>>>    */
>>>
>>> [...]
>>>
>>>> @@ -510,9 +522,118 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_=
clk, "mbus", mbus_parents, 0x588
>>>>                                             BIT(31),     /* gate */
>>>>                                             CLK_IS_CRITICAL,
>>>>                                             CCU_FEATURE_UPDATE_BIT);
>>>> +static const struct clk_hw *mbus_hws[] =3D { &mbus_clk.common.hw };
>>>> +
>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_sys_clk, "mbus-iommu0-sys", mbu=
s_hws, 0x58c, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_HWS(apb_iommu0_sys_clk, "apb-iommu0-sys", apb0_=
hws, 0x58c, BIT(1), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_iommu0_sys_clk, "ahb-iommu0-sys", ahb_h=
ws, 0x58c, BIT(2), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite0_clk, "bus-msi-lite0", hosc, =
0x594, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite1_clk, "bus-msi-lite1", hosc, =
0x59c, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite2_clk, "bus-msi-lite2", hosc, =
0x5a4, BIT(0), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", mbu=
s_hws, 0x5b4, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb-iommu1-sys", apb0_=
hws, 0x5b4, BIT(1), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb-iommu1-sys", ahb_h=
ws, 0x5b4, BIT(2), 0);
>>>
>>>> +static SUNXI_CCU_GATE_HWS(ahb_ve_dec_clk, "ahb-ve-dec", ahb_hws,
>>>> +                         0x5c0, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_ve_enc_clk, "ahb-ve-enc", ahb_hws,
>>>> +                         0x5c0, BIT(1), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_vid_in_clk, "ahb-vid-in", ahb_hws,
>>>> +                         0x5c0, BIT(2), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout0_clk, "ahb-vid-cout0", ahb_hws=
,
>>>> +                         0x5c0, BIT(3), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout1_clk, "ahb-vid-cout1", ahb_hws=
,
>>>> +                         0x5c0, BIT(4), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_de_clk, "ahb-de", ahb_hws,
>>>> +                         0x5c0, BIT(5), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_npu_clk, "ahb-npu", ahb_hws,
>>>> +                         0x5c0, BIT(6), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_gpu0_clk, "ahb-gpu0", ahb_hws,
>>>> +                         0x5c0, BIT(7), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_serdes_clk, "ahb-serdes", ahb_hws,
>>>> +                         0x5c0, BIT(8), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_usb_sys_clk, "ahb-usb-sys", ahb_hws,
>>>> +                         0x5c0, BIT(9), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_msi_lite0_clk, "ahb-msi-lite0", ahb_hws=
,
>>>> +                         0x5c0, BIT(16), 0);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
>>>> +                         0x5c0, BIT(24), CLK_IS_CRITICAL);
>>>> +static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
>>>> +                         0x5c0, BIT(28), CLK_IS_CRITICAL);
>>>
>>> I suspect these refer to a AHB-AHB bridge for the various subsystems sh=
own
>>> in the memory map. That would explain why when the "ahb-store" clock is
>>> gated, the storage bits stop working.
>>>
>>> If that's the case, we should describe it as the parent of each storage
>>> peripheral bus gate's parent. Same would go for the other types. I have=
n't
>>> checked what the BSP does though.
>>=20
>> As Norman mentioned in his reply, the vendor BSP also does not model
>> this hierarchy and instead models these gates as independent clocks
>> parented to the oscillator. The manual does not describe the hierarchy
>> either, so I don't think we have enough information to model it
>> differently at this point.
>
> Well, I wouldn't use the BSP as a good example on how to model the clock=
=20
> tree, they have been very misguided in the past.

Understood. I will not rely on the BSP's clock hierarchy.

> What the BSP does is to add just more input/gate MBUS clocks for each=20
> device, which is something I think we should avoid.
> To that regard using them as parent clocks for the existing gates, as=20
> Chen-Yu suggested, sounds like a good idea: We keep a single clock for=20
> the devices, but still can turn both clocks off (I think, not tested).

I tested bus-mmc0, bus-mmc2, bus-spi0, bus-ufs, bus-nand0, and
bus-spif individually. Disabling each bus gate made the corresponding
controller's MMIO registers inaccessible: reads either returned zero or
a fixed invalid value.

With those individual bus gates enabled, disabling ahb-store made the
MMIO registers of all those controllers inaccessible. Restoring
ahb-store made them accessible again.

Based on these results, I plan to make ahb-store the parent of the
following bus clocks in the next version:

  bus-nand0
  bus-mmc0
  bus-mmc1
  bus-mmc2
  bus-mmc3
  bus-spi0
  bus-spi1
  bus-spi2
  bus-spif
  bus-spi3
  bus-spi4
  bus-ufs

I directly tested MMC0, MMC2, SPI0, SPIF, NAND0, and UFS. The remaining
instances use the same type of bus gates in the same storage subsystem,
so I plan to model them in the same way.

For mbus-store, testing with MMC0 and UFS showed that disabling it
breaks the storage DMA paths.

Most of these storage controllers do not have dedicated MBUS gate
clocks, so there is no clock that can be parented to mbus-store to model
their DMA dependency. I therefore plan to keep mbus-store marked as
CLK_IS_CRITICAL, as we already do for the main mbus clock. For NAND,
which does have a dedicated mbus-nand gate, I will make mbus-store its
parent.

I also tested NVMe, but disabling either ahb-store or mbus-store had no
effect on it.

Does this approach look reasonable to you?

Best regards,
Junhui Liu

>
> Cheers,
> Andre
>
>> I will add comments explaining why ahb_store_clk, mbus_store_clk, and
>> ahb_cpus_clk are marked critical.
>>=20
>>>
>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_clk, "mbus-iommu0", mbus_hws,
>>>> +                         0x5e0, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_clk, "mbus-iommu1", mbus_hws,
>>>> +                         0x5e0, BIT(1), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_desys_clk, "mbus-desys", mbus_hws,
>>>> +                         0x5e0, BIT(11), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_gate_clk, "mbus-ve-enc0-gate",=
 mbus_hws,
>>>> +                         0x5e0, BIT(12), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_gate_clk, "mbus-ve-dec0-gate",=
 mbus_hws,
>>>> +                         0x5e0, BIT(14), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_gpu0_clk, "mbus-gpu0", mbus_hws,
>>>> +                         0x5e0, BIT(16), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_npu_clk, "mbus-npu", mbus_hws,
>>>> +                         0x5e0, BIT(18), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_vid_in_clk, "mbus-vid-in", mbus_hws,
>>>> +                         0x5e0, BIT(24), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_serdes_clk, "mbus-serdes", mbus_hws,
>>>> +                         0x5e0, BIT(28), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite0_clk, "mbus-msi-lite0", mbus_=
hws,
>>>> +                         0x5e0, BIT(29), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_store_clk, "mbus-store", mbus_hws,
>>>> +                         0x5e0, BIT(30), CLK_IS_CRITICAL);
>>>
>>> Same thing for the MBUS clocks.
>>>
>>>> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite2_clk, "mbus-msi-lite2", mbus_=
hws,
>>>> +                         0x5e0, BIT(31), 0);
>>>> +
>>>> +static SUNXI_CCU_GATE_HWS(mbus_dma0_clk, "mbus-dma0", mbus_hws,
>>>> +                         0x5e4, BIT(0), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_clk, "mbus-ve-enc0", mbus_hws,
>>>> +                         0x5e4, BIT(1), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
>>>> +                         0x5e4, BIT(2), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_dma1_clk, "mbus-dma1", mbus_hws,
>>>> +                         0x5e4, BIT(3), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_nand_clk, "mbus-nand", mbus_hws,
>>>> +                         0x5e4, BIT(5), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
>>>> +                         0x5e4, BIT(8), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
>>>> +                         0x5e4, BIT(9), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_gmac0_clk, "mbus-gmac0", mbus_hws,
>>>> +                         0x5e4, BIT(11), 0);
>>>> +/* Undocumented, taken from the vendor kernel. */
>>>> +static SUNXI_CCU_GATE_HWS(mbus_gmac1_clk, "mbus-gmac1", mbus_hws,
>>>> +                         0x5e4, BIT(12), 0);
>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_clk, "mbus-ve-dec0", mbus_hws,
>>>> +                         0x5e4, BIT(18), 0);
>>>
>>> [...]
>>>
>>> The remaining definitions look correct (minus the vendor BSP ones which=
 I
>>> couldn't check at this time).
>>>
>>> I didn't check the clock list additions.
>>>
>>> Consider this
>>>
>>> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>>>
>>=20
>> Thanks!
>>=20
>>>
>>> We can change the AHB / MBUS clock parents later if we do figure it out=
.
>>>
>>>
>>> ChenYu
>>=20
