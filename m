Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794194236;
	b=FzUMp4WtR5AIGVLN3X7lxDwEJk3kqhzBOVBjy7Cv2UQyTsHeHmhd6sglk2k58kjaSWew
	 XB7tAI//8qr69b2ZZYxm+7sGonjZQNIYbeXLzlSGWG+P/Vi7mvV74lIzMxbV7qGmFZtkO
	 xfV5HW74lMm2SG2FE8QFWu/6HfrQcipaLVOgIvb62z57cjVgs7GNv/KAExT7bsYMQz1Ef
	 lbZqQTQtW88Jlc/jMZVl+CDqoAh3UvMK313u7BZAUm1aWbo3RBRy+jD4pFalsERYASPHj
	 R8K3uS6wqutxZSkrwApx/HUpewp97ob3YHMDhk8KPNDPc9oSq8w7Yhkwvs7UgtH5Auw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194236;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ZohoMailClient;
	bh=wkPpP6AwZpMNKZU0R11NpMOQrwHOhcED5088KBtaDHA=;
	b=BcqcSN+Fkcvr+NEMj+7GboLqQNOIRCuF9Nr/KiSFB+BbQAxWcGnySVuEOPln5RcUGzrX
	 XDORbj4Vd2a7N1QfJVZVLW7e/rupge1EC17MIuoAchfhPCKaZPk+Sl4fjy6jUuUkvEz5p
	 2acPlZAamU6d4kPYELkptkiTxZYC56q+UUWDgU/8h/sx5ly6AjZHI1O2zt/HmeuVwGkRW
	 nMC3AJUBiEASpwfr+9dmGzaXhG3qDV2d/fkXE6udeeeQ+54SzQWrD2gKr9sGkQ783QG6/
	 +HSSVBj9vjUCJIEndnzpnNx1jzAlW8MSCo7DldQgEoz+wWuUkzd/OTYoihvYdQSyv+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pigmoral.tech;
	spf=pass smtp.mailfrom=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=E4aXrlQ4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B401606A320;
	Mon,  9 Nov 2026 03:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B401606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=E4aXrlQ4
ARC-Seal: i=1; a=rsa-sha256; t=1794194189; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L0MjgcqXPJitlOVyDqAKTd5p+9n9JBhQ+dGSFjhfNlVdklM9BiPhXCsr0Nc4SJrK76EzvVfdE9QeJrPXYS6Z/EV9n+YyRJVAskDgnwcVs0knngMBwCriIn4bt5ojg5RiwyVa8qcwj2PfzPI3ocxId48jDBcRXW900Z951pdo2qc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794194189; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wkPpP6AwZpMNKZU0R11NpMOQrwHOhcED5088KBtaDHA=; 
	b=n5RjKUI4/T8o/eLGpOfchAZ9Xusey+v+/5oWqXYbsV1HXGH34vH//WqWreXqa+lrIxXEfZfAxxSNHohcvJo3pkW42s0Jjvcd/19wdDIPlpI/+Sdn8JFV/Ahr8KzSaNKDk8Oh++yLyVwcFKJOkVfr+uOLDlhLYpe8jVHLN56mrwg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: a=rsa-sha256; b=E4aXrlQ4V6gCj/NHcpw5zGo8qbS90mcj/GoM4hGCu8r8HhWeiKaagUo7Rth+K1/nQVg0UWV1ak3XKCiW8w8JPCnqxJptgCQ0vFWhEoP9bDXguXxDyCOTuc3Afk0puDsGvj8yBS0QMYi2evneze7XziX+9qqNc+AM+48Ow3x317U=; c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1; bh=wkPpP6AwZpMNKZU0R11NpMOQrwHOhcED5088KBtaDHA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794194187174866.5006536015394;
	Sun, 8 Nov 2026 19:16:27 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 11:16:17 +0800
Message-Id: <DMQCR64N88M9.GCX83LKYT3IE@pigmoral.tech>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <netdev@vger.kernel.org>, "Jerome Brunet" <jbrunet@baylibre.com>, "Enzo
 Adriano" <enzo.adriano.code@gmail.com>, "Norman Herms"
 <dockseed@proton.me>, "Vinicius Pedrosa"
 <vinicius.eduardo.pedrosa@gmail.com>
Subject: Re: [PATCH v6 6/8] clk: sunxi-ng: a733: Add mod clocks support
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Andre Przywara" <andre.przywara@arm.com>, "Junhui Liu"
 <junhui.liu@pigmoral.tech>, "Stephen Boyd" <sboyd@kernel.org>, "Brian
 Masney" <bmasney+clk@redhat.com>, "Jerome Brunet"
 <jbrunet+clk@baylibre.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Richard Cochran"
 <richardcochran@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech>
 <20261009-a733-clk-v6-6-ae8178fce7e8@pigmoral.tech>
 <30e43e84-e6e8-4024-b415-dedf67070c4f@arm.com>
In-Reply-To: <30e43e84-e6e8-4024-b415-dedf67070c4f@arm.com>
X-ZohoMailClient: External

Hi Andre,

Thanks for your patient review.

Besides the issues you pointed out, I also found a few other places that
don't match the manual. I'll fix those in the next version as well.

On Mon Nov 2, 2026 at 11:32 PM CST, Andre Przywara wrote:
> Hi,
>
> judging from the "fun" this is to review, I very much appreciate your=20
> efforts in putting this together ;-)
>
> On 10/9/26 17:52, Junhui Liu wrote:
>> Add the module clocks found in the Allwinner A733 SoC, including video,
>> storage, interfaces and others. While most of these clocks are similar
>> to those in the A523 SoC, this implementation accounts for changes in
>> register offsets and introduces support for new modules.
>>=20
>> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>   drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 1103 ++++++++++++++++++++++++=
++++++++
>>   1 file changed, 1103 insertions(+)
>>=20

[...]

>> +
>> +/* Undocumented, taken from the vendor kernel. */
>> +static const struct clk_parent_data avs_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .fw_name =3D "hosc" },
>> +};
>
> Those two parents appear two more times below (usb01_ref_parents and=20
> hdmi_sfr_parents). Please rename this array to something more generic=20
> and reuse it below.

Okay, I'll rename it to sys_24M_hosc_parents and reuse it for those
clocks.

>
>> +static SUNXI_CCU_MUX_DATA_WITH_GATE(avs_clk, "avs-clk", avs_parents, 0x=
880,
>> +				    24, 3,		/* mux */
>> +				    BIT(31),		/* gate */
>> +				    0);
>> +
>> +static const struct clk_hw *de_parents[] =3D {
>> +	&pll_de_3x_clk.common.hw,
>> +	&pll_de_4x_clk.common.hw,
>> +	&pll_periph0_480M_clk.common.hw,
>> +	&pll_periph0_400M_clk.hw,
>> +	&pll_periph0_300M_clk.hw,
>> +	&pll_video0_4x_clk.common.hw,
>> +	&pll_video2_4x_clk.common.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(de0_clk, "de0", de_parents, 0xa00,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    CLK_SET_RATE_PARENT);
>> +
>> +static const struct clk_hw *di_parents[] =3D {
>> +	&pll_periph0_600M_clk.hw,
>> +	&pll_periph0_480M_clk.common.hw,
>> +	&pll_periph0_400M_clk.hw,
>> +	&pll_video0_4x_clk.common.hw,
>> +	&pll_video2_4x_clk.common.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0xa20,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    CLK_SET_RATE_PARENT);
>> +
>> +static const struct clk_hw *g2d_parents[] =3D {
>> +	&pll_periph0_400M_clk.hw,
>> +	&pll_periph0_300M_clk.hw,
>
> My copy of the manual puts the 300MHz clock first, then the 400 MHz one.=
=20
> Can you please check this?

Yes, I checked the manual, and the first parent is indeed 300MHz.

The last parent should also be pll_video2_4x rather than pll_video1_4x.
I'll fix both.

[...]

>> +
>> +/*
>> + * GPU_CLK =3D ClockSource * ((16 - M) / 16)
>> + * Here we use a div_table to select M values that result in integer di=
visors.
>> + */
>> +static struct clk_div_table gpu_div_table[] =3D {
>> +	{ .val =3D 0, .div =3D 1 },
>> +	{ .val =3D 8, .div =3D 2 },
>> +	{ .val =3D 12, .div =3D 4 },
>> +	{ .val =3D 14, .div =3D 8 },
>> +	{ .val =3D 15, .div =3D 16 },
>> +	{ /* sentinel */ },
>> +};
>> +static const struct clk_parent_data gpu_parents[] =3D {
>> +	{ .hw =3D &pll_gpu0_clk.common.hw, },
>> +	{ .hw =3D &pll_periph0_800M_clk.common.hw, },
>> +	{ .hw =3D &pll_periph0_600M_clk.hw, },
>> +	{ .hw =3D &pll_periph0_400M_clk.hw, },
>> +	{ .hw =3D &pll_periph0_300M_clk.hw, },
>> +	{ .hw =3D &pll_periph0_200M_clk.hw, },
>> +};
>> +static struct ccu_div gpu0_clk =3D {
>> +	.enable		=3D BIT(31),
>> +	.div		=3D _SUNXI_CCU_DIV_TABLE(0, 4, gpu_div_table),
>> +	.mux		=3D _SUNXI_CCU_MUX(24, 3),
>> +	.common		=3D {
>> +		.reg		=3D 0xb20,
>> +		.features	=3D CCU_FEATURE_UPDATE_BIT,
>
> Just a heads up: in my A523 CPU clocks series, I reworked the update bit=
=20
> handling, so depending on the order of merging this might need some rewor=
k.

I've seen that. I'd prefer to keep this series independent of your A523
CPU clocks series for now. Once your series has settled, I'll send a
separate patch to adapt the A733 update bit handling, or update this
series if yours lands first.

>
>> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("gpu0", gpu_parents,
>> +							   &ccu_div_ops, 0),
>> +	}
>> +};
>> +
>> +static const struct clk_parent_data dram_parents[] =3D {
>> +	{ .hw =3D &pll_ddr_clk.common.hw, },
>> +	{ .hw =3D &pll_periph0_800M_clk.common.hw, },
>> +	{ .hw =3D &pll_periph0_600M_clk.hw, },
>> +	{ .hw =3D &pll_de_clk.common.hw, },
>
> Should this be pll_de_3x instead?

You're right. The second and third parents should also be periph1 rather
than periph0. I'll fix them together.

[...]

>> +
>> +static const struct clk_parent_data irtx_parents[] =3D {
>> +	{ .fw_name =3D "losc"},
>
> I think this clock should be sys_24M_clk.

You're right. I'll fix it.

>
>> +	{ .hw =3D &pll_periph1_600M_clk.hw },
>> +	{ .fw_name =3D "hosc"},
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irtx_clk, "irtx", irtx_parents, 0=
x1008,
>> +				      0, 5,	/* M */
>> +				      24, 3,	/* mux */
>> +				      BIT(31),	/* gate */
>> +				      0);
>> +
>> +/* Undocumented, taken from the vendor kernel. */
>> +static const struct clk_parent_data sgpio_parents[] =3D {
>> +	{ .fw_name =3D "losc"},
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(sgpio_clk, "sgpio", sgpio_parents=
, 0x1060,
>> +				      0, 5,	/* M */
>> +				      24, 3,	/* mux */
>> +				      BIT(31),	/* gate */
>> +				      0);
>> +
>> +/* Undocumented, taken from the vendor kernel. */
>> +static const struct clk_hw *lpc_parents[] =3D {
>> +	&pll_video0_3x_clk.common.hw,
>> +	&pll_video1_3x_clk.common.hw,
>> +	&pll_video2_3x_clk.common.hw,
>> +	&pll_periph0_300M_clk.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(lpc_clk, "lpc", lpc_parents, 0x1080=
,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static const struct clk_hw *i2spcm_parents[] =3D {
>> +	&pll_audio0_4x_clk.common.hw,
>> +	&pll_audio1_div2_clk.hw,
>> +	&pll_audio1_div5_clk.hw,
>> +	&pll_periph0_200M_clk.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm0_clk, "i2spcm0", i2spcm_pare=
nts, 0x1200,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm1_clk, "i2spcm1", i2spcm_pare=
nts, 0x1210,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_clk, "i2spcm2", i2spcm_pare=
nts, 0x1220,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static const struct clk_hw *i2spcm2_asrc_parents[] =3D {
>> +	&pll_audio0_4x_clk.common.hw,
>> +	&pll_audio1_div2_clk.hw,
>> +	&pll_audio1_div5_clk.hw,
>> +	&pll_periph0_300M_clk.hw,
>> +	&pll_periph1_300M_clk.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_asrc_clk, "i2spcm2_asrc", i=
2spcm2_asrc_parents, 0x1224,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm3_clk, "i2spcm3", i2spcm_pare=
nts, 0x1230,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm4_clk, "i2spcm4", i2spcm_pare=
nts, 0x1240,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static const struct clk_hw *spdif_tx_parents[] =3D {
>> +	&pll_audio0_4x_clk.common.hw,
>> +	&pll_audio1_div2_clk.hw,
>> +	&pll_audio1_div5_clk.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(spdif_tx_clk, "spdif-tx", spdif_tx_=
parents, 0x1280,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static const struct clk_hw *spdif_rx_parents[] =3D {
>> +	&pll_periph0_200M_clk.hw,
>> +	&pll_periph0_300M_clk.hw,
>
> The manual I am looking at says those two muxes are "Reserved". So are=20
> those parents from the BSP? Can you please add a comment about it then?

Yes, I took them from the vendor BSP. I'll add a comment explaining that.

[...]

>> +
>> +static const struct clk_parent_data usb01_ref_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .fw_name =3D "hosc" },
>> +};
>> +static SUNXI_CCU_MUX_DATA(usb01_ref_clk, "usb01-ref", usb01_ref_parents=
, 0x1340, 24, 3, 0);
>> +
>> +static SUNXI_CCU_MUX_DATA(usb2_u2_ref_clk, "usb2-u2-ref", usb01_ref_par=
ents, 0x1348, 24, 3, 0);
>
> Don't these two clocks miss the gate at bit 31? So it should be=20
> SUNXI_CCU_MUX_DATA_WITH_GATE instead?

Oops, I missed them. I'll add them.

>
>  > +
>> +static const struct clk_parent_data usb2_suspend_parents[] =3D {
>> +	{ .fw_name =3D "losc" },
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_suspend_clk, "usb2-suspend",=
 usb2_suspend_parents,
>> +				      0x1350,
>> +				      0, 5,	/* M */
>> +				      24, 1,	/* mux */
>> +				      BIT(31),	/* gate */
>> +				      0);
>> +
>> +static const struct clk_parent_data usb2_mf_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .hw =3D &pll_periph0_300M_clk.hw },
>> +	{ .fw_name =3D "hosc" },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_mf_clk, "usb2-mf", usb2_mf_p=
arents,
>> +				      0x1354,
>> +				      0, 5,	/* M */
>> +				      24, 3,	/* mux */
>> +				      BIT(31),	/* gate */
>> +				      0);
>> +
>> +static const struct clk_parent_data usb2_u3_utmi_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .hw =3D &pll_periph0_300M_clk.hw },
>> +	{ .fw_name =3D "hosc" },
>
> Aren't those parents exactly the same as the usb2_mf_parents[] above?

Yes, I'll reuse the array.

[...]

>> +
>> +static const struct clk_hw *edp_tv_parents[] =3D {
>> +	&pll_video0_4x_clk.common.hw,
>> +	&pll_video1_4x_clk.common.hw,
>> +	&pll_video2_4x_clk.common.hw,
>> +	&pll_periph0_2x_clk.common.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_tv_clk, "edp-tv", edp_tv_parent=
s, 0x1640,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>
> There is a second divider range from bits [12:8].

Okay, I'll switch this to SUNXI_CCU_DUALDIV_MUX_GATE.

>
>> +
>> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k",=
 pll_periph0_2x_hws, 0x1680,
>> +				      BIT(30),	/* gate */
>> +				      36621,	/* pre div */
>> +				      0);
>> +
>> +static const struct clk_parent_data hdmi_cec_parents[] =3D {
>> +	{ .fw_name =3D "losc" },
>> +	{ .hw =3D &hdmi_cec_32k_clk.common.hw },
>> +};
>> +static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec_=
parents, 0x1680,
>> +				    24, 1,	/* mux */
>
> Even though there are indeed only two choices, the manual still=20
> specifies the mux bits as ranging from [26:24] (as for many other clocks)=
.

Okay, I'll update the mux width.

>
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static const struct clk_parent_data hdmi_tv_parents[] =3D {
>> +	{ .hw =3D &pll_video0_4x_clk.common.hw },
>> +	{ .hw =3D &pll_video1_4x_clk.common.hw },
>> +	{ .hw =3D &pll_video2_4x_clk.common.hw },
>> +	{ .hw =3D &pll_periph0_2x_clk.common.hw },
>> +};
>> +static SUNXI_CCU_DUALDIV_MUX_GATE(hdmi_tv_clk, "hdmi-tv", hdmi_tv_paren=
ts, 0x1684,
>> +				  0, 5,		/* M */
>> +				  8, 5,		/* N */
>> +				  24, 3,	/* mux */
>> +				  BIT(31),	/* gate */
>> +				  0);
>> +
>> +static const struct clk_parent_data hdmi_sfr_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .fw_name =3D "hosc" },
>> +};
>> +static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_sfr_clk, "hdmi-sfr", hdmi_sfr_=
parents, 0x1690,
>> +				    24, 1,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static SUNXI_CCU_GATE_HWS(hdcp_esm_clk, "hdcp-esm", pll_periph0_300M_hw=
s, 0x1694, BIT(31), 0);
>> +
>> +static const struct clk_parent_data ledc_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .hw =3D &pll_periph0_600M_clk.hw },
>> +	{ .fw_name =3D "hosc" },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ledc_parents, 0=
x1700,
>> +				      0, 5,	/* M */
>> +				      24, 3,	/* mux */
>> +				      BIT(31),	/* gate */
>> +				      0);
>> +
>> +static const struct clk_parent_data csi_master_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .hw =3D &pll_video0_4x_clk.common.hw },
>> +	{ .hw =3D &pll_video0_3x_clk.common.hw },
>> +	{ .hw =3D &pll_video1_4x_clk.common.hw },
>> +	{ .hw =3D &pll_video1_3x_clk.common.hw },
>> +	{ .hw =3D &pll_video2_4x_clk.common.hw },
>> +	{ .hw =3D &pll_video2_3x_clk.common.hw },
>> +};
>> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master0_clk, "csi_master0", csi_m=
aster_parents, 0x1800,
>> +				  0, 5,		/* M */
>> +				  8, 5,		/* N */
>> +				  24, 3,	/* mux */
>> +				  BIT(31),	/* gate */
>> +				  0);
>> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master1_clk, "csi_master1", csi_m=
aster_parents, 0x1804,
>> +				  0, 5,		/* M */
>> +				  8, 5,		/* N */
>> +				  24, 3,	/* mux */
>> +				  BIT(31),	/* gate */
>> +				  0);
>> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master2_clk, "csi_master2", csi_m=
aster_parents, 0x1808,
>> +				  0, 5,		/* M */
>> +				  8, 5,		/* N */
>> +				  24, 3,	/* mux */
>> +				  BIT(31),	/* gate */
>> +				  0);
>> +
>> +static const struct clk_hw *csi_parents[] =3D {
>> +	&pll_video2_4x_clk.common.hw,
>> +	&pll_de_4x_clk.common.hw,
>> +	&pll_periph0_480M_clk.common.hw,
>> +	&pll_periph0_400M_clk.hw,
>> +	&pll_periph0_600M_clk.hw,
>
> My manual lists two more parents: video0_4x and video1_4x.

I missed them. I'll add them.

>
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_clk, "csi", csi_parents, 0x1840=
,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static const struct clk_hw *isp_parents[] =3D {
>> +	&pll_video2_4x_clk.common.hw,
>> +	&pll_periph0_480M_clk.common.hw,
>> +	&pll_periph0_400M_clk.hw,
>> +	&pll_periph0_600M_clk.hw,
>> +	&pll_video0_4x_clk.common.hw,
>> +	&pll_video1_4x_clk.common.hw,
>> +};
>> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(isp_clk, "isp", isp_parents, 0x1860=
,
>> +				    0, 5,	/* M */
>> +				    24, 3,	/* mux */
>> +				    BIT(31),	/* gate */
>> +				    0);
>> +
>> +static SUNXI_CCU_GATE_DATA(res_dcap_24m_clk, "res-dcap-24m", hosc, 0x1a=
00, BIT(3), 0);
>> +
>> +static const struct clk_parent_data apb2jtag_parents[] =3D {
>> +	{ .hw =3D &sys_24M_clk.hw },
>> +	{ .fw_name =3D "losc" },
>> +	{ .fw_name =3D "iosc" },
>> +	{ .hw =3D &pll_periph0_480M_clk.common.hw },
>> +	{ .hw =3D &pll_periph1_480M_clk.common.hw },
>> +	{ .hw =3D &pll_periph0_200M_clk.hw },
>> +	{ .hw =3D &pll_periph1_200M_clk.hw },
>> +};
>> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(apb2jtag_clk, "apb2jtag", apb2jta=
g_parents, 0x1c00,
>> +				      0, 5,	/* M */
>> +				      24, 3,	/* mux */
>> +				      BIT(31),	/* gate */
>> +				      0);
>> +
>> +static SUNXI_CCU_GATE_HWS(fanout_24M_clk, "fanout-24M", sys_24M_hws, 0x=
1f30, BIT(0), 0);
>> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_12M_clk, "fanout-12M", sys=
_24M_hws, 0x1f30,
>> +				      BIT(1), 2, 0);
>> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M", pll=
_periph0_480M_hws, 0x1f30,
>> +				      BIT(2), 30, 0);
>> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M", pll=
_periph0_2x_hws, 0x1f30,
>> +				      BIT(3), 48, 0);
>
> Where do those parents come from? My manual just lists the frequencies.
> Is that matching the 0x1f3c register sources?

Yes, these match the sources listed in CCMU_FAN_REG (0x1f3c).

The current definitions fold the intermediate fixed dividers:
PERI0_160M / 10 becomes PERI0_480M / 30, and PERI0_150M / 6 becomes
PERI0PLL2X / 48.

I'll use PERI0_160M / 10 and PERI0_150M / 6 in the next revision to match
the documented clock tree more directly.

>
> The rest seems to be correct, as far as my mostly manual comparison goes.
>
> Cheers,
> Andre
>

--=20
Best regards,
Junhui Liu
