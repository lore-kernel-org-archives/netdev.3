Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240439;
	b=ZvdUiWLtrFES6V7sqMxuMXi9rzDZMKZDmQDEY05vgNHUikVzm3qP/7NzUcMw0q7RSLQ2
	 d5Hw8WfcCpqm2/4TJ5j1TBMPDwLbbaVJs9c5+wdLjA5RnXYBHrUudpq44fW3xsKlIW+8T
	 DzVSoXvOoDKyqKzui2rrqPN6E/2pJvrKCVkPkUvWKdIgxCTRrW0XMs2GjW6kuW6nlufrt
	 MqqaFg4tj4QLP25mRGxyNDfhOQvHTcFr4gtQ+T9HA0PykZD1CxTe1Q0UOABQcT0jRBBff
	 0d1aO4sM5Ys/QwOFdDLn2umJtGXp/fTWekEQw3yz4QBYRZwl+AcQtnJ1ehyZJdTmGsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240439;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GFQPb65NT7RMSCppnWXFsuqs6MvLmEnYZdDh5XC4mjA=;
	b=rh2FXigc66SAMEBqPBMjRVYEgvG8wID52MxuhM/ajF6qYym5ZHybQSInXbVB8ZLp2bOK
	 ormSmI1LKMKU0FsxqJqrowBRuGhGRRGEf2ix1qtSoaOtKpnd/DR4TG2ZegFQMKx92ZYgR
	 DAkJUV/IcSY0M9JH4+PuYH+pulnpQZC+XpdXbNYO0YmmACysolkFaIdXMV7Q1gSn2x66B
	 5zYpMnT9EeYAOkGav/+h8N5Q3naKw39R31SvYNjn3BC/YGzFSwX26oGYQGNP+VPj56uM2
	 32urguoA6puZG6W6+GEtrLc52qceapC4SNFOCdlsjg+fLMKG4dnO/P1yrBpzsh+iYqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Puyq/GHS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B18606EEB3
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Puyq/GHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F89F1F008A6
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794240438;
	bh=GFQPb65NT7RMSCppnWXFsuqs6MvLmEnYZdDh5XC4mjA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=Puyq/GHSaxDgBRMYK4eabz6Z3GYKDUO07DGeh0jwnCvTp3v+z2sg1MCkJBFhXrlKH
	 xGe4jUBrFKWOPxi3Nm52k6itYEZmiCf3G2CJ/LBewN+EqZjhO4nhxj0ZG04W4LqAfK
	 EaysLBv6Vg8AbkSBm7N/Ngm0nVnLBmHUjVugKDjbd15YyE+Zdlg+9JlSUDpACvmhhC
	 +dxpDMtRekkCUxlJn0oX+BL4UpfgfutKwx606W8jYMXyWlPc0krQuzpJXsiGcdFDoL
	 kILuY0b8/omMfXu888a5rIHXEskSYU/Z6iaJROpp0putugvHmFWK4OZ5oRF0gHitXZ
	 OjjlYvIA7GILQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so7936241fa.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 08:07:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHNofzsj70TFtBxHlC/3liWpWBTz0b7TTDaV/2dV8u4VDkdK3uZdUYBAwlC8bLKkMBfLMj7euE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/PA3xeH6Y9KBtuN1w0CDeOZ9uf3F15rCn3uf0g0rb18G8PGfsZ
	r4xbvUNMYSvc9aF0Tqny59hjqEjOnuGv/PHR/7VEOjgx0lycOvSCDq/qnEjDlhe/chu/l0DukrN
	uCjPx9yHXviGOeCxkMrl08RUPgi9KX4s=
X-Received: by 2002:a05:6512:1396:b0:5c1:4974:c15e with SMTP id
 2adb3069b0e04-5c14c0347cbmr1335285e87.52.1794240436213; Mon, 09 Nov 2026
 08:07:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009-a733-clk-v6-0-ae8178fce7e8@pigmoral.tech> <20261009-a733-clk-v6-6-ae8178fce7e8@pigmoral.tech>
In-Reply-To: <20261009-a733-clk-v6-6-ae8178fce7e8@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 10 Nov 2026 01:07:03 +0900
X-Gmail-Original-Message-ID: <CAGb2v67M2bN6a4AsNL_Lv70QmHTvdSWUCbPQat6Po_7KbbqA-w@mail.gmail.com>
X-Gm-Features: AclHuK9agX6QEN1ILAcd18vE_t6MGmoL64ggMRVBKmQGQ0cwuc_S8X4_YIrWVls
Message-ID: <CAGb2v67M2bN6a4AsNL_Lv70QmHTvdSWUCbPQat6Po_7KbbqA-w@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] clk: sunxi-ng: a733: Add mod clocks support
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
	Andre Przywara <andre.przywara@arm.com>, Norman Herms <dockseed@proton.me>, 
	Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 12:54=E2=80=AFAM Junhui Liu <junhui.liu@pigmoral.te=
ch> wrote:
>
> Add the module clocks found in the Allwinner A733 SoC, including video,
> storage, interfaces and others. While most of these clocks are similar
> to those in the A523 SoC, this implementation accounts for changes in
> register offsets and introduces support for new modules.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 1103 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 1103 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-n=
g/ccu-sun60i-a733.c
> index 371c4297c3ab..7847eec84313 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c

[...]

> +static const struct clk_parent_data dram_parents[] =3D {
> +       { .hw =3D &pll_ddr_clk.common.hw, },
> +       { .hw =3D &pll_periph0_800M_clk.common.hw, },
> +       { .hw =3D &pll_periph0_600M_clk.hw, },
> +       { .hw =3D &pll_de_clk.common.hw, },
> +       { .hw =3D &pll_npu_clk.common.hw, },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(dram0_clk, "dram0", dram_pare=
nts, 0xc00,
> +                                          0, 4,        /* M */

My LLM agent flagged this: the divider is 5 bits wide, not 4.
Both the user manual (page 149 from start or 128 as numbered on the page)
and the BSP agree.


ChenYu
