Received: from sender5-pp-g120.zoho.com (sender5-pp-g120.zoho.com [165.173.182.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EB549C4A0;
	Tue,  6 Oct 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302402; cv=pass; b=i2k6tJax92io5pVJLc3SIVHjwMMIaHgr3TXK+bhlxIppr5/VhzaZoYE6hbknieK36yH0d8LTITOnChof8UUH+Z3QySn6Gt4vr2wsqud1dH+U2Ntfj0Z8EqnycGSGKg8C81vutFIKHjHLGpDXKLXsVL+/tlZvb0dtMKAsDbFM86k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302402; c=relaxed/simple;
	bh=31dft7DrMoMIL7cQinT8Mc1lr5vjidUapYSotieFims=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C4yBsR2vgnT5GgOIuRyNDZkCrb/Y7xvORhSvwG0w3OUVqyQ9CiB5eRkj/rjP3nmu004FEmRGilep0VDAWgWn5uvdoRX9X/E3kk/nprTeyo/UCF283dSLrbYbr92CZt2vO6rePCvt5PoYW0/46xDkwjlaghe6GgcpDwhMz5nkWb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=rnViszo2; arc=pass smtp.client-ip=165.173.182.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="rnViszo2"
ARC-Seal: i=1; a=rsa-sha256; t=1791302364; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fvYX0IY6tjWMM9ZOcE/JSMqlSFzGx8fL+vHApnEYomu2oNqgXzmU5NicaQz6J+lWXH+prfLjzEEVFJyJoOn/Kx5jvkq2z5UaDuFJfKD1aS32Ll6+8zGT5/t6ocuWu6We/i8UvxO1iHvq3SVD3RyByxGJBjo3XPjYgQ00EgJybpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791302364; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ofJ6lFmaqkMAD1B5crgh4ZVwIkmC1rZp5ZE3WR+x4IQ=; 
	b=Wq0b7NnvCl/3C3ZOLM2dwKExw6wCwFGPMW6cQ1Hf5uRNtbi8oPGp2bcsHJxkdX7xaU3P7zhUDvAVz9ujNIPQGaeGYjO9y/iHqWxUAL9RDKfufbLSwwvwr3Rwb3TzyE1aEl+krhLvQuYF5eZ49nFrtEalFQ7KKc5bZ/2hQ44TW1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791302364;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
	bh=ofJ6lFmaqkMAD1B5crgh4ZVwIkmC1rZp5ZE3WR+x4IQ=;
	b=rnViszo2gzEw3WXjg8UERJ6Q8Hl+VIa+/lLTYE0A97TTTJgQd4umIVR8DO51z32Q
	R9BLlL9Hv4oA9rmksZGwEtrmoNXtnaNwyG79uvpOcdS53UxRLHqrQnhau57geCILYpb
	HH3w2dQjw1wrcYvOFpvpxPLrS1Qm/3VNO0Ex+49s=
Received: by smtp.zohomail.com with SMTPS id 1791302362417454.9136076680727;
	Tue, 6 Oct 2026 08:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 23:59:12 +0800
Message-Id: <DLXVOSID7Y2U.VWIHLBRJIU7B@pigmoral.tech>
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
 <DLXU88MGGIWX.2IUEKEMBTV4QC@pigmoral.tech>
 <d7cb2a75-7d9c-4e91-8fcf-4c466734497d@arm.com>
In-Reply-To: <d7cb2a75-7d9c-4e91-8fcf-4c466734497d@arm.com>
X-ZohoMailClient: External

Hi Andre,

On Tue Oct 6, 2026 at 11:29 PM CST, Andre Przywara wrote:
> Hi,
>
> On 10/6/26 16:50, Junhui Liu wrote:
>> Hi Andre, Chen-Yu,
>>=20
>> I ran some tests and now have a better understanding of the clock
>> hierarchy. Please see the results below.
>>=20
>> On Mon Oct 5, 2026 at 5:17 PM CST, Andre Przywara wrote:
>>> Hi,
>>>
>>> On 10/5/26 06:41, Junhui Liu wrote:
>>>> Hi Chen-Yu,
>>>>
>>>> On Sun Oct 4, 2026 at 7:03 PM CST, Chen-Yu Tsai wrote:
>>>>> On Tue, Sep 29, 2026 at 7:28=E2=80=AFPM Junhui Liu <junhui.liu@pigmor=
al.tech> wrote:
>>>>>>
>>>>>> Add the bus clock gates that control access to the devices' register
>>>>>> interface on the Allwinner A733 SoC. These clocks are typically
>>>>>> single-bit controls in the BGR registers, covering UARTs, SPI, I2C, =
and
>>>>>> various multimedia engines. It also includes bus gates for system
>>>>>> components like the IOMMU and MSI-lite interfaces.
>>>>>>
>>>>>> Also mark the ahb-store, mbus-store and ahb-cpus clocks as critical.
>>>>>> Disabling either store gate breaks access to boot/storage devices su=
ch
>>>>>> as MMC and SPI NOR, while gating ahb-cpus hangs any access to the CP=
US
>>>>>> power domain registers when unused clocks are disabled.
>>>>>>
>>>>>> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>>>>>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>>>>>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>>>>>> ---
>>>>>>    drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 492 ++++++++++++++++++++=
++++++++++++-
>>>>>>    1 file changed, 491 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/su=
nxi-ng/ccu-sun60i-a733.c
>>>>>> index 1b2d4d36ec4c..b077e5d2f32c 100644
>>>>>> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>>>>>> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>>>>>> @@ -4,6 +4,10 @@
>>>>>>     * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>>>>>     * Based on the A523 CCU driver:
>>>>>>     *   Copyright (C) 2023-2024 Arm Ltd.
>>>>>> + *
>>>>>> + * TODO: The real parents of some bus gates, including its-pcie0-ac=
lk,
>>>>>> + * msi-lite, npu, ufs, sgpio, lpc and i2spcm, are not documented in=
 the
>>>>>> + * manual. For now, follow the vendor BSP, which keeps them on hosc=
.
>>>>>>     */
>>>>>
>>>>> [...]
>>>>>
>>>>>> @@ -510,9 +522,118 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbu=
s_clk, "mbus", mbus_parents, 0x588
>>>>>>                                              BIT(31),     /* gate */
>>>>>>                                              CLK_IS_CRITICAL,
>>>>>>                                              CCU_FEATURE_UPDATE_BIT)=
;
>>>>>> +static const struct clk_hw *mbus_hws[] =3D { &mbus_clk.common.hw };
>>>>>> +
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_sys_clk, "mbus-iommu0-sys", m=
bus_hws, 0x58c, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(apb_iommu0_sys_clk, "apb-iommu0-sys", apb=
0_hws, 0x58c, BIT(1), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_iommu0_sys_clk, "ahb-iommu0-sys", ahb=
_hws, 0x58c, BIT(2), 0);
>>>>>> +
>>>>>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite0_clk, "bus-msi-lite0", hosc=
, 0x594, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite1_clk, "bus-msi-lite1", hosc=
, 0x59c, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite2_clk, "bus-msi-lite2", hosc=
, 0x5a4, BIT(0), 0);
>>>>>> +
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", m=
bus_hws, 0x5b4, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb-iommu1-sys", apb=
0_hws, 0x5b4, BIT(1), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb-iommu1-sys", ahb=
_hws, 0x5b4, BIT(2), 0);
>>>>>
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_ve_dec_clk, "ahb-ve-dec", ahb_hws,
>>>>>> +                         0x5c0, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_ve_enc_clk, "ahb-ve-enc", ahb_hws,
>>>>>> +                         0x5c0, BIT(1), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_vid_in_clk, "ahb-vid-in", ahb_hws,
>>>>>> +                         0x5c0, BIT(2), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout0_clk, "ahb-vid-cout0", ahb_h=
ws,
>>>>>> +                         0x5c0, BIT(3), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout1_clk, "ahb-vid-cout1", ahb_h=
ws,
>>>>>> +                         0x5c0, BIT(4), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_de_clk, "ahb-de", ahb_hws,
>>>>>> +                         0x5c0, BIT(5), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_npu_clk, "ahb-npu", ahb_hws,
>>>>>> +                         0x5c0, BIT(6), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_gpu0_clk, "ahb-gpu0", ahb_hws,
>>>>>> +                         0x5c0, BIT(7), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_serdes_clk, "ahb-serdes", ahb_hws,
>>>>>> +                         0x5c0, BIT(8), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_usb_sys_clk, "ahb-usb-sys", ahb_hws,
>>>>>> +                         0x5c0, BIT(9), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_msi_lite0_clk, "ahb-msi-lite0", ahb_h=
ws,
>>>>>> +                         0x5c0, BIT(16), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
>>>>>> +                         0x5c0, BIT(24), CLK_IS_CRITICAL);
>>>>>> +static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
>>>>>> +                         0x5c0, BIT(28), CLK_IS_CRITICAL);
>>>>>
>>>>> I suspect these refer to a AHB-AHB bridge for the various subsystems =
shown
>>>>> in the memory map. That would explain why when the "ahb-store" clock =
is
>>>>> gated, the storage bits stop working.
>>>>>
>>>>> If that's the case, we should describe it as the parent of each stora=
ge
>>>>> peripheral bus gate's parent. Same would go for the other types. I ha=
ven't
>>>>> checked what the BSP does though.
>>>>
>>>> As Norman mentioned in his reply, the vendor BSP also does not model
>>>> this hierarchy and instead models these gates as independent clocks
>>>> parented to the oscillator. The manual does not describe the hierarchy
>>>> either, so I don't think we have enough information to model it
>>>> differently at this point.
>>>
>>> Well, I wouldn't use the BSP as a good example on how to model the cloc=
k
>>> tree, they have been very misguided in the past.
>>=20
>> Understood. I will not rely on the BSP's clock hierarchy.
>
> Well, I meant more the BSP software/DT modelling, as in: this device=20
> know needs now two input clocks. As you mentioned, the manual does not=20
> describe every relation, so we need to rely on the BSP for knowing the=20
> parents. But ...

Got it, thanks for clarifying.

>
>>> What the BSP does is to add just more input/gate MBUS clocks for each
>>> device, which is something I think we should avoid.
>>> To that regard using them as parent clocks for the existing gates, as
>>> Chen-Yu suggested, sounds like a good idea: We keep a single clock for
>>> the devices, but still can turn both clocks off (I think, not tested).
>>=20
>> I tested bus-mmc0, bus-mmc2, bus-spi0, bus-ufs, bus-nand0, and
>> bus-spif individually. Disabling each bus gate made the corresponding
>> controller's MMIO registers inaccessible: reads either returned zero or
>> a fixed invalid value.
>>=20
>> With those individual bus gates enabled, disabling ahb-store made the
>> MMIO registers of all those controllers inaccessible. Restoring
>> ahb-store made them accessible again.
>
> Ah, awesome, that's a good test, thanks for doing this! I thought that=20
> this clock is really about the data path, not the (MMIO register)=20
> control part, which is typically a separate low-speed bus (APB).
> Since that is somewhat surprising, it's probably best to add a comment=20
> in the code about that.

Okay, I will add a comment.

>
>> Based on these results, I plan to make ahb-store the parent of the
>> following bus clocks in the next version:
>
> Is ahb-store ungated at reset?

Yes. Both the manual and a read through FEL before loading any external
firmware confirmed that ahb-store is ungated at reset. The same is true
for mbus-store.

>
>>    bus-nand0
>>    bus-mmc0
>>    bus-mmc1
>>    bus-mmc2
>>    bus-mmc3
>>    bus-spi0
>>    bus-spi1
>>    bus-spi2
>>    bus-spif
>>    bus-spi3
>>    bus-spi4
>>    bus-ufs
>>=20
>> I directly tested MMC0, MMC2, SPI0, SPIF, NAND0, and UFS. The remaining
>> instances use the same type of bus gates in the same storage subsystem,
>> so I plan to model them in the same way.
>>=20
>> For mbus-store, testing with MMC0 and UFS showed that disabling it
>> breaks the storage DMA paths.
>
> When you say "storage DMA", you mean the actual DMA data path, using=20
> those chained descriptors? Does it work for PIO accesses, as U-Boot uses?

Yes, I mean the actual DMA data path.

In my tests, MMC and SPI PIO transfers in U-Boot still worked with
mbus-store disabled, and the controller MMIO registers remained
accessible.

>
>> Most of these storage controllers do not have dedicated MBUS gate
>> clocks, so there is no clock that can be parented to mbus-store to model
>> their DMA dependency.
>
> Could this be like mbus-store -> ahb_store -> bus-{mmc,spi,ufs,nand}<n>?

I don't think that would reflect the hardware topology. mbus-store is
fed by mbus, while ahb-store is fed by ahb. Chaining them would also
make the AHB bus gates inherit the MBUS rate in the CCF model.

I would therefore prefer to keep mbus-store marked as CLK_IS_CRITICAL,
or use a better way to model this dependency if there is one.

Best regards,
Junhui Liu

>
> Cheers,
> Andre
>
>> I therefore plan to keep mbus-store marked as
>> CLK_IS_CRITICAL, as we already do for the main mbus clock. For NAND,
>> which does have a dedicated mbus-nand gate, I will make mbus-store its
>> parent.
>>=20
>> I also tested NVMe, but disabling either ahb-store or mbus-store had no
>> effect on it.
>>=20
>> Does this approach look reasonable to you?
>>=20
>> Best regards,
>> Junhui Liu
>>=20
>>>
>>> Cheers,
>>> Andre
>>>
>>>> I will add comments explaining why ahb_store_clk, mbus_store_clk, and
>>>> ahb_cpus_clk are marked critical.
>>>>
>>>>>
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_clk, "mbus-iommu0", mbus_hws,
>>>>>> +                         0x5e0, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_clk, "mbus-iommu1", mbus_hws,
>>>>>> +                         0x5e0, BIT(1), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_desys_clk, "mbus-desys", mbus_hws,
>>>>>> +                         0x5e0, BIT(11), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_gate_clk, "mbus-ve-enc0-gate=
", mbus_hws,
>>>>>> +                         0x5e0, BIT(12), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_gate_clk, "mbus-ve-dec0-gate=
", mbus_hws,
>>>>>> +                         0x5e0, BIT(14), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_gpu0_clk, "mbus-gpu0", mbus_hws,
>>>>>> +                         0x5e0, BIT(16), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_npu_clk, "mbus-npu", mbus_hws,
>>>>>> +                         0x5e0, BIT(18), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_vid_in_clk, "mbus-vid-in", mbus_hws,
>>>>>> +                         0x5e0, BIT(24), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_serdes_clk, "mbus-serdes", mbus_hws,
>>>>>> +                         0x5e0, BIT(28), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite0_clk, "mbus-msi-lite0", mbu=
s_hws,
>>>>>> +                         0x5e0, BIT(29), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_store_clk, "mbus-store", mbus_hws,
>>>>>> +                         0x5e0, BIT(30), CLK_IS_CRITICAL);
>>>>>
>>>>> Same thing for the MBUS clocks.
>>>>>
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite2_clk, "mbus-msi-lite2", mbu=
s_hws,
>>>>>> +                         0x5e0, BIT(31), 0);
>>>>>> +
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_dma0_clk, "mbus-dma0", mbus_hws,
>>>>>> +                         0x5e4, BIT(0), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_clk, "mbus-ve-enc0", mbus_hw=
s,
>>>>>> +                         0x5e4, BIT(1), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
>>>>>> +                         0x5e4, BIT(2), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_dma1_clk, "mbus-dma1", mbus_hws,
>>>>>> +                         0x5e4, BIT(3), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_nand_clk, "mbus-nand", mbus_hws,
>>>>>> +                         0x5e4, BIT(5), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
>>>>>> +                         0x5e4, BIT(8), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
>>>>>> +                         0x5e4, BIT(9), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_gmac0_clk, "mbus-gmac0", mbus_hws,
>>>>>> +                         0x5e4, BIT(11), 0);
>>>>>> +/* Undocumented, taken from the vendor kernel. */
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_gmac1_clk, "mbus-gmac1", mbus_hws,
>>>>>> +                         0x5e4, BIT(12), 0);
>>>>>> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_clk, "mbus-ve-dec0", mbus_hw=
s,
>>>>>> +                         0x5e4, BIT(18), 0);
>>>>>
>>>>> [...]
>>>>>
>>>>> The remaining definitions look correct (minus the vendor BSP ones whi=
ch I
>>>>> couldn't check at this time).
>>>>>
>>>>> I didn't check the clock list additions.
>>>>>
>>>>> Consider this
>>>>>
>>>>> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>>>>>
>>>>
>>>> Thanks!
>>>>
>>>>>
>>>>> We can change the AHB / MBUS clock parents later if we do figure it o=
ut.
>>>>>
>>>>>
>>>>> ChenYu
>>>>
