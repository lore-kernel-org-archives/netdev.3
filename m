Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ADD1A704B
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112503; cv=none; b=pvtESNz2S//dHZK2LWb1hm49smYkpJAImLRXMjvJZlecky5nr9mnq5aK9hHOEUe8Vzx1ZVxkC4DnPy5+v/urBA4aD8TOdyYEoh3nwqU43AwIc/COowccqHcXznevv9vLUJMoJO/zGUiGYQ+5mktGqqTKDnSrBmV6qTsL2Vi7u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112503; c=relaxed/simple;
	bh=hsUe3R8HTIJa107Px4Pv5UjHvCZZlBUMI1qqHQMrE1U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fj3dXBhtD+jdVop2fd6egPNuR14LnJLKtQ8iLaQYt8RyB6BAhQKh7ROaz0MsWY18Crw0Q+axHxUyJxNG8Q/pDtHNiohPLuMAa8zbU6kIZrSoHxBzq12VY2Tp9TeFmAfXaJn6r5xZAQ/wdREYjeiml7sZPcEelOahQ3ykT64idpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IO3RWP4M; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IO3RWP4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791112496; x=1791371696;
	bh=axUuY6R+xPUQ9WsKqWZyN6vKAeBDZjWnfhApo6LvrFU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IO3RWP4MxsoympIGLuMgbYvzs9IVs1H4h4EsImXO+KDAGmiMm81gXPq616RUv4pyV
	 ggy3fdn3B1uimqvqorZcmf+qI98ciJzr1bgAYUSxyXC7UxeaI80pKFqxQD3jg/VIxn
	 yHonCeDb115PBvkfjUGx6GIifZYHjiEyg/8FNF9vi2HTjprUr4Q2Mvm9qnvxv/Febi
	 GOkZofTu0EYjJLfFWclkELv5rALS8Rzyacmu4qht+nbVA8iRmVS+G5BBTU2P8RHd3n
	 qpLtzBjgXdNwsBQtR8DjlHZSW85qIUfycbCeVl3tu19oVcg3Jnc9IH5StFjEjeerUO
	 cwh9aunD2WP7A==
Date: Sun, 04 Oct 2026 11:14:50 +0000
To: wens@kernel.org
From: Norman Herms <dockseed@proton.me>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, Enzo Adriano <enzo.adriano.code@gmail.com>, Andre Przywara <andre.przywara@arm.com>
Subject: AW: Re: [PATCH v5 7/8] clk: sunxi-ng: a733: Add bus clock gates
Message-ID: <TEcOYCDcz77vYtgXxuHGwhVo6AFFgV2M5rIDAsLiG4T7fD6J41La8o19hf2iMQhaMXd1wHsvqeDardYv7hjy3TbV9oCkfzYKRMn0EGlh7Ww=@proton.me>
In-Reply-To: <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech> <20260930-a733-clk-v5-7-11175b41cd2d@pigmoral.tech> <CAGb2v65Lqo7NiFhc2GYdfY7+jkC4Y+p6=Zy85HOFmXJzT0u1fg@mail.gmail.com>
Feedback-ID: 144388465:user:proton
X-Pm-Message-ID: 24affaecb9b426f52699549cb7abbc8bb40c0be3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 1:03 PM Chen-Yu Tsai <wens@kernel.org> wrote:
> > +static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
> > +                         0x5c0, BIT(24), CLK_IS_CRITICAL);
> > +static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
> > +                         0x5c0, BIT(28), CLK_IS_CRITICAL);
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

Two data points, in case they help.

The vendor BSP (radxa/allwinner-bsp, branch cubie-aiot-v1.5.0,
drivers/clk/sunxi-ng/ccu-sun60iw2.c) models no hierarchy either. It
registers every gate in 0x5c0 and 0x5e0 as a keyed gate on the
oscillator and marks each one CLK_IS_CRITICAL or CLK_IGNORE_UNUSED, so
clk_disable_unused() never closes any of them.

On a Cubie A7S running our own 6.18-based tree, with the GPU power
domain up and ahb-gpu0 (0x5c0 bit 7) and mbus-gpu0 (0x5e0 bit 16) both
closed, drm/powervr still bound, read the core ID and loaded the
matching firmware, but the firmware then failed to boot ("Firmware
failed to boot"). With both bits set, the same modprobe initialized the
GPU. So for the GPU, register access worked with these two gates
closed; what failed was the firmware running on the GPU.

The measurements were run on my boards by AI agents.

Norman
