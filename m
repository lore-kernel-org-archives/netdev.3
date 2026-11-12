Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495528;
	b=TmFsXlT4psAQiilDEt535yyUy36XesqUy4UsC/usd8ibataPyms3cD7HofJbzE1VcxXq
	 RNxmAOVuFc4kccVhnkLc3FurO/va+Lqma0T3IddsZHlM92ASUAgB29PKhcvyDxkrApDdF
	 xbRgBi91euuL6HAyCqhtWM6ckrrD8yGxoCkC6Nuput05y3vIRKcrP4jfK1a/KpJubITtH
	 R6TUHoPuLyO6euhfxvGEeAIiMKDAe0yfXQhZT77tdCguycIgG6vGvYLMSxtwOrAKGnWq9
	 EypGc3v2RmdDiec3CHgPEaouUuG2FeW1/Da46T8nmmtO8rWtkYBXUaxrRsG/knwy1Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495528;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ahp2R8XXPiuO6iEjfb6UKUnsMrVVlx0bOA5QMiN/SCg=;
	b=ghx8vJW3rtRnjUEx+9GrgXy6nqbO8GEnJgrnu5Uy3hqTDj92/hFxuIJdMKMt5Sk8hJa2
	 vn16d+CnqPspJ3GqSx9OvrrTgDw2qos5fbhkOQbSlPMUTw1VYOtqfr+95eL3agyTpSLEB
	 r57MhRf9czc4MBDoHxn5L9/iEZFMdb4k6JgBjRzLDoanSvtmP6W6HyFfh96jxdMuv8iak
	 IjcSqoCp0n3yMEQ38YVYeOxrfZ3YunjoJVqcAYSXOAw0RfKYBGwa4Nb8KcoFghUFvg1/j
	 1IGQ7RQydoiYb0EDP4pYykzjhKd6hK0u5UZsE7V1hRgZMwJUIr4VxiCGownL6sG3rSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evi7clWU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB5606A32E
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=evi7clWU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B29E1F00A10
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495528;
	bh=Ahp2R8XXPiuO6iEjfb6UKUnsMrVVlx0bOA5QMiN/SCg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=evi7clWUqzfu5IwbwBr1JJlISMJDxPDhvh6uAAOyCg4ZnCnklbxu8+ZjPmsyAJp/0
	 aP8kAcEIz52VuMwJki7SyO4fuxYHvB3MavOJRR03w0bl2i7fAv32f91k/+09mGMrj3
	 iWt4HXcH3d0ZZxsnA6Rm9vsEqznM4YC0+n0a6kqqns3tv22HaO3JdV6Q+ZvJtYkBfF
	 h9guIvmInAtJSD2Thdtkqr1TC4gRLGYeJpVypaDuYlIneKDv92USZioY1YD+c92ZTM
	 GNRqYI1l0LabEgiidIKy/Ghen9POAU1/k4/CNgnT6u71WupklB+95qmRViP8rE0x3t
	 oi8M7RhZ7wVeQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so36358301fa.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 06:58:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHdIeElWa7F8Nm3uzUk/bZKw8HlgAwYqQESS2xFSYosh+hczKxGUVD9c9aNuDXRneEPCQT68CE=@vger.kernel.org
X-Gm-Message-State: APuU4Z83YqQvrIquFQofvMoJOMAJYg2cSWwYOBVTJ7TktQwYBMX3WKNG
	bCRf6+q9HCUeVJ87/NBBPfZ7ieSZmK/AGyRQkBUneOHDpd+FpaJ1CDXM3CurqXUQdE4J5nEj3ab
	tC+/4RdX0ze0JryRpoq+ieCDSGfAPID4=
X-Received: by 2002:a05:651c:e0c4:10b0:3ae:25db:795 with SMTP id
 38308e7fff4ca-3ae25db0827mr3381781fa.12.1794495527049; Thu, 12 Nov 2026
 06:58:47 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech> <20261112-a733-clk-v7-6-db7c5451ffa2@pigmoral.tech>
In-Reply-To: <20261112-a733-clk-v7-6-db7c5451ffa2@pigmoral.tech>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 12 Nov 2026 23:58:33 +0900
X-Gmail-Original-Message-ID: <CAGb2v64Ye4wEiE3y2msoFh1P5Cs7dvXQ_vESmVFEJ=qhkp9PVQ@mail.gmail.com>
X-Gm-Features: AclHuK-IX9I87FO9BVEBpEeLaHk1PETWtM0mWihOigloFLp60Bd_bejTc7ChEns
Message-ID: <CAGb2v64Ye4wEiE3y2msoFh1P5Cs7dvXQ_vESmVFEJ=qhkp9PVQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] clk: sunxi-ng: a733: Add mod clocks support
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

Hi,

On Thu, Nov 12, 2026 at 4:15=E2=80=AFPM Junhui Liu <junhui.liu@pigmoral.tec=
h> wrote:
>
> Add the module clocks found in the Allwinner A733 SoC, including video,
> storage, interfaces and others. While most of these clocks are similar
> to those in the A523 SoC, this implementation accounts for changes in
> register offsets and introduces support for new modules.
>
> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
> Tested-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 1087 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 1087 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-n=
g/ccu-sun60i-a733.c
> index 8bc603393f5a..5ea65bf5b5e0 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c

[...]

> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_asrc_clk, "i2spcm2_asrc", i2=
spcm2_asrc_parents, 0x1224,

This and the csi master clocks later have an underscore in the clk name str=
ing.
They should have hyphens instead. I will fix it when I apply the patches.
No need to resend just for this.

> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master0_clk, "csi_master0", csi_ma=
ster_parents, 0x1800,

This one.

> +                                 0, 5,         /* M */
> +                                 8, 5,         /* N */
> +                                 24, 3,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master1_clk, "csi_master1", csi_ma=
ster_parents, 0x1804,

This one.

> +                                 0, 5,         /* M */
> +                                 8, 5,         /* N */
> +                                 24, 3,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);
> +static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master2_clk, "csi_master2", csi_ma=
ster_parents, 0x1808,

And this one.

> +                                 0, 5,         /* M */
> +                                 8, 5,         /* N */
> +                                 24, 3,        /* mux */
> +                                 BIT(31),      /* gate */
> +                                 0);


These were flagged by a review agent comparing the driver against the datas=
heet
and BSP code.


ChenYu
