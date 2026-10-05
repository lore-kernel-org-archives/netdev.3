Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21822126C;
	Mon,  5 Oct 2026 04:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175332; cv=pass; b=AVLD3uynFm525cUOAGYAonXbgzNlEThO3qN0GycvJ3MdpP7IwlsiUWDzZeCg7GRN3nOYZotkBbeZO8uETmfL9MwXJEy08n3wfCu1jEPq1pbluRp8WV0oEPjNltAnkDNf3oUFFpL0lmxNcoNqVHBPVzuxa8pCRC8EvvXdD0dVt30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175332; c=relaxed/simple;
	bh=TZxNSZ/fvte5/PVYeZHaRCQtAGAMtGntWtDaIM4Nn40=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K0jvIFR7MIZYwKpjwudh15IZWm49cSEhBgq0umefbSYkdCEH8bswgbf4wA7HnVoW30aeP3sFblABqEu4ppswXSXdjJAOx4PDCaknl4d847XBIJFjTS3BdO01q6mjDtp7G58vGcUiLprNBmzCqJakYBlX6MIAAiPpYdiNZPtuvrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=Vlu2rvsu; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="Vlu2rvsu"
ARC-Seal: i=1; a=rsa-sha256; t=1791175281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AI67L/etDKRXMy/h3C/49dpfgoEQTzxqfRUsfPKNRCeO7jwbUxjXou0t+MSuNygOA5ajn7UVyb2DoAuxBJuPQo5EMuJK7SrCtH2jY2Qgd+lrJ4yBllNuOYZ/+GUNAgLftThDJPrMKOHl9/c2VnaajwKSyV/vlij8ly8f+hf3TWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791175281; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qJFGQKjvbH1HqSDayT62DQ2rPAzEBQdHJkasbzlXbNg=; 
	b=PDfcLn1BYodAaZUEHZJw2Dd2oDe1yF3nrD0G5arhe66YWaJZUjcH7leENicRbTn0dlYOXdk6L7cIbAsH8rMgs8M1XK6kvxx2NBRc8TjqZNIa4OKM4POx2vRIpuJx3mm8KQ8MxYwGZt38B4nP2gH+hwFjGnl8WVCwK7vVSWpblcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791175281;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
	bh=qJFGQKjvbH1HqSDayT62DQ2rPAzEBQdHJkasbzlXbNg=;
	b=Vlu2rvsuksYEU7h9UlpgeiLM4sV2miSw8nrRHl0jfNGZvoK2wDl80etPsjnuc3aj
	bOSQvL4WI6A+Vr5cwNPvzu5bDHEvH81Vkn11EIx0PCCYuHdDZQu3Sys8XaANa76iiH+
	h7bqGLFvsABQvSS9yzOe53P8IJJ/bJWv12anp2Ac=
Received: by smtp.zohomail.com with SMTPS id 1791175279488549.9267500854362;
	Sun, 4 Oct 2026 21:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 12:41:10 +0800
Message-Id: <DLWMN3TYBP9F.3N62QFP7QEE9U@pigmoral.tech>
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
 <enzo.adriano.code@gmail.com>, "Andre Przywara" <andre.przywara@arm.com>
Subject: Re: [PATCH v5 7/8] clk: sunxi-ng: a733: Add bus clock gates
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: <wens@kernel.org>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
 <20260930-a733-clk-v5-7-11175b41cd2d@pigmoral.tech>
 <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
In-Reply-To: <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
X-ZohoMailClient: External

Hi Chen-Yu,

On Sun Oct 4, 2026 at 7:03 PM CST, Chen-Yu Tsai wrote:
> On Tue, Sep 29, 2026 at 7:28=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.t=
ech> wrote:
>>
>> Add the bus clock gates that control access to the devices' register
>> interface on the Allwinner A733 SoC. These clocks are typically
>> single-bit controls in the BGR registers, covering UARTs, SPI, I2C, and
>> various multimedia engines. It also includes bus gates for system
>> components like the IOMMU and MSI-lite interfaces.
>>
>> Also mark the ahb-store, mbus-store and ahb-cpus clocks as critical.
>> Disabling either store gate breaks access to boot/storage devices such
>> as MMC and SPI NOR, while gating ahb-cpus hangs any access to the CPUS
>> power domain registers when unused clocks are disabled.
>>
>> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 492 ++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 491 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-=
ng/ccu-sun60i-a733.c
>> index 1b2d4d36ec4c..b077e5d2f32c 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
>> @@ -4,6 +4,10 @@
>>   * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
>>   * Based on the A523 CCU driver:
>>   *   Copyright (C) 2023-2024 Arm Ltd.
>> + *
>> + * TODO: The real parents of some bus gates, including its-pcie0-aclk,
>> + * msi-lite, npu, ufs, sgpio, lpc and i2spcm, are not documented in the
>> + * manual. For now, follow the vendor BSP, which keeps them on hosc.
>>   */
>
> [...]
>
>> @@ -510,9 +522,118 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_cl=
k, "mbus", mbus_parents, 0x588
>>                                            BIT(31),     /* gate */
>>                                            CLK_IS_CRITICAL,
>>                                            CCU_FEATURE_UPDATE_BIT);
>> +static const struct clk_hw *mbus_hws[] =3D { &mbus_clk.common.hw };
>> +
>> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_sys_clk, "mbus-iommu0-sys", mbus_=
hws, 0x58c, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HWS(apb_iommu0_sys_clk, "apb-iommu0-sys", apb0_hw=
s, 0x58c, BIT(1), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_iommu0_sys_clk, "ahb-iommu0-sys", ahb_hws=
, 0x58c, BIT(2), 0);
>> +
>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite0_clk, "bus-msi-lite0", hosc, 0x=
594, BIT(0), 0);
>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite1_clk, "bus-msi-lite1", hosc, 0x=
59c, BIT(0), 0);
>> +static SUNXI_CCU_GATE_DATA(bus_msi_lite2_clk, "bus-msi-lite2", hosc, 0x=
5a4, BIT(0), 0);
>> +
>> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", mbus_=
hws, 0x5b4, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb-iommu1-sys", apb0_hw=
s, 0x5b4, BIT(1), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb-iommu1-sys", ahb_hws=
, 0x5b4, BIT(2), 0);
>
>> +static SUNXI_CCU_GATE_HWS(ahb_ve_dec_clk, "ahb-ve-dec", ahb_hws,
>> +                         0x5c0, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_ve_enc_clk, "ahb-ve-enc", ahb_hws,
>> +                         0x5c0, BIT(1), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_vid_in_clk, "ahb-vid-in", ahb_hws,
>> +                         0x5c0, BIT(2), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout0_clk, "ahb-vid-cout0", ahb_hws,
>> +                         0x5c0, BIT(3), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_vid_cout1_clk, "ahb-vid-cout1", ahb_hws,
>> +                         0x5c0, BIT(4), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_de_clk, "ahb-de", ahb_hws,
>> +                         0x5c0, BIT(5), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_npu_clk, "ahb-npu", ahb_hws,
>> +                         0x5c0, BIT(6), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_gpu0_clk, "ahb-gpu0", ahb_hws,
>> +                         0x5c0, BIT(7), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_serdes_clk, "ahb-serdes", ahb_hws,
>> +                         0x5c0, BIT(8), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_usb_sys_clk, "ahb-usb-sys", ahb_hws,
>> +                         0x5c0, BIT(9), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_msi_lite0_clk, "ahb-msi-lite0", ahb_hws,
>> +                         0x5c0, BIT(16), 0);
>> +static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
>> +                         0x5c0, BIT(24), CLK_IS_CRITICAL);
>> +static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
>> +                         0x5c0, BIT(28), CLK_IS_CRITICAL);
>
> I suspect these refer to a AHB-AHB bridge for the various subsystems show=
n
> in the memory map. That would explain why when the "ahb-store" clock is
> gated, the storage bits stop working.
>
> If that's the case, we should describe it as the parent of each storage
> peripheral bus gate's parent. Same would go for the other types. I haven'=
t
> checked what the BSP does though.

As Norman mentioned in his reply, the vendor BSP also does not model
this hierarchy and instead models these gates as independent clocks
parented to the oscillator. The manual does not describe the hierarchy
either, so I don't think we have enough information to model it
differently at this point.

I will add comments explaining why ahb_store_clk, mbus_store_clk, and
ahb_cpus_clk are marked critical.

>
>> +static SUNXI_CCU_GATE_HWS(mbus_iommu0_clk, "mbus-iommu0", mbus_hws,
>> +                         0x5e0, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_iommu1_clk, "mbus-iommu1", mbus_hws,
>> +                         0x5e0, BIT(1), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_desys_clk, "mbus-desys", mbus_hws,
>> +                         0x5e0, BIT(11), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_gate_clk, "mbus-ve-enc0-gate", m=
bus_hws,
>> +                         0x5e0, BIT(12), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_gate_clk, "mbus-ve-dec0-gate", m=
bus_hws,
>> +                         0x5e0, BIT(14), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_gpu0_clk, "mbus-gpu0", mbus_hws,
>> +                         0x5e0, BIT(16), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_npu_clk, "mbus-npu", mbus_hws,
>> +                         0x5e0, BIT(18), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_vid_in_clk, "mbus-vid-in", mbus_hws,
>> +                         0x5e0, BIT(24), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_serdes_clk, "mbus-serdes", mbus_hws,
>> +                         0x5e0, BIT(28), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite0_clk, "mbus-msi-lite0", mbus_hw=
s,
>> +                         0x5e0, BIT(29), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_store_clk, "mbus-store", mbus_hws,
>> +                         0x5e0, BIT(30), CLK_IS_CRITICAL);
>
> Same thing for the MBUS clocks.
>
>> +static SUNXI_CCU_GATE_HWS(mbus_msi_lite2_clk, "mbus-msi-lite2", mbus_hw=
s,
>> +                         0x5e0, BIT(31), 0);
>> +
>> +static SUNXI_CCU_GATE_HWS(mbus_dma0_clk, "mbus-dma0", mbus_hws,
>> +                         0x5e4, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_clk, "mbus-ve-enc0", mbus_hws,
>> +                         0x5e4, BIT(1), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
>> +                         0x5e4, BIT(2), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_dma1_clk, "mbus-dma1", mbus_hws,
>> +                         0x5e4, BIT(3), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_nand_clk, "mbus-nand", mbus_hws,
>> +                         0x5e4, BIT(5), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
>> +                         0x5e4, BIT(8), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
>> +                         0x5e4, BIT(9), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_gmac0_clk, "mbus-gmac0", mbus_hws,
>> +                         0x5e4, BIT(11), 0);
>> +/* Undocumented, taken from the vendor kernel. */
>> +static SUNXI_CCU_GATE_HWS(mbus_gmac1_clk, "mbus-gmac1", mbus_hws,
>> +                         0x5e4, BIT(12), 0);
>> +static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_clk, "mbus-ve-dec0", mbus_hws,
>> +                         0x5e4, BIT(18), 0);
>
> [...]
>
> The remaining definitions look correct (minus the vendor BSP ones which I
> couldn't check at this time).
>
> I didn't check the clock list additions.
>
> Consider this
>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>

Thanks!

>
> We can change the AHB / MBUS clock parents later if we do figure it out.
>
>
> ChenYu

--=20
Best regards,
Junhui Liu

