Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77433D0938
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435775; cv=none; b=nzLExc2X51U+HkU0UowfAUh7XSgh3jLaItao2soDshlYF7AJ3wjlzrslEoj9BJtk/RYLJCVKvH5z0riPL3lO5IQrLLntoQGBt/+qgbC4S/zEnKuoXzBU/SWmhXdlQlUJJdCwE1iEXvJT6Xi21XUIgYH5CIWexHlTfoqGnDcTPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435775; c=relaxed/simple;
	bh=dDeMXpjPA4/d6nv1lGdAEuc0hbO+ZdPT1uwNq+bzcUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEo8u4MtBP0kHrppx3KNmHKbM53xr8cC8wz0+YlWWrq6RWSvE9Q/mSssCMY3ElYgPjf3d2eimsw5bmlIpcb/22Q1I+4TEDhIBN2qwCwRbBDjM3srTwYwDwH1qf8EZc4Cn+rep20k0v+GETrCLBtHZGPgfTbf28OBEy0bW6Pj+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bgs+D2/w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tu7zf+e1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bgs+D2/w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tu7zf+e1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785435771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57rmP4vhcSTbGsoBnLah+TzWrTa5sRCpdridw9cY9ZA=;
	b=Bgs+D2/w0zk0FPCceFytKcRxM33AObSpgssoBr7mxH/T9VQYwHuEVVwPuqSCDlsRoBWU1G
	HFZxZiAoJrg30PfEvvQLf1NoixmZC5HPig8EP/EkQGVYnn99S5Xd5bPk0HSeydwmlXLHRS
	om0lOn9GUwTwZTmH07weYwYmOwS+QIQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-hIUtndeqO0GFbgOgm5ZYSg-1; Thu, 30 Jul 2026 14:22:50 -0400
X-MC-Unique: hIUtndeqO0GFbgOgm5ZYSg-1
X-Mimecast-MFC-AGG-ID: hIUtndeqO0GFbgOgm5ZYSg_1785435770
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81f0e988059so4610267b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785435770; x=1786040570; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=57rmP4vhcSTbGsoBnLah+TzWrTa5sRCpdridw9cY9ZA=;
        b=Tu7zf+e1Xe1pRBwdRN1iO1n/zFDA0Ct4lb3MsTIMgO4KafAewdBzP6Bsdjz23dstae
         RLnuBC/+9wPM21JxGF1r65eO9e4m+o1EnNOohQIfCQ8S4KQiYbATjWGtsYNcFl2I/om1
         djQSOCfmIhPfKLHBFKfzJmGFx/hLc80Ts5MeHf7XebBrZMjoeXtRPglADdehGM5eUZ9q
         fvghyvqDNFw80UjThoHohyhShhpnq2S6ilebAYW4YfEzafTgv2rPO3Uof3uvW5S7v/XV
         GOkiL7JULduSoPkXMztFJkno38X0idY+UTBkz2o+8d3o66wcDIuiNSWCF3PEtU/p8AlC
         B76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435770; x=1786040570;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57rmP4vhcSTbGsoBnLah+TzWrTa5sRCpdridw9cY9ZA=;
        b=tMQj4UpqUgfrrsJkWTBHi6b2CvVO3bBEUGqdB7uKZFcWH+rkrCoFe7Fy5oxXM3nChS
         5D+YG4EAivG0J5gssXss/zB0uZJQd+izHAihriJVDUQPzvw4+pWQ4INVa1iXeZJEvvil
         UrxZ/LKq0ltsbWzsfeMUyH9TPZNdUX90dlNnNRpovtlng9x77v6B7eqwB+jpMg9IQ7iR
         kFvXgxjWJt7Mc8SKDs22Xxj8tsJNgm0L89uCE1fBfdrHAr+2k840Cwhf4YL1naUmZvND
         Yu7I9uSZZnD+Q9sPP7dtWRyUF0UFquk7CMrKBpwmJfV4X6Bwglmy/kg500Q18GhIDomd
         +aLw==
X-Forwarded-Encrypted: i=1; AHgh+RonyWClc6IQVb4Oz1ZV/tdBoJh7hZPSm5sMb7UOSArQnHHjIeiGtXCBg251O+C+HE6f4fP5EpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytLWTTZEmMFvh58gDrzdQRS7/bz+IeKBoCOxlerbALL14PJP/E
	dUHPkIOBN3ZYjDWem9t5VWxIYcI7YM0yeLFz5YBiouPd7IjKd33WDyJThB57AZkeWmXQFfw/xK8
	Oz20WN9/UukRTONrUOrTJxbpJ4b6gW7t8QkhyxEppgEvRRbPYUHq8kypH6g==
X-Gm-Gg: AR+sD10aNl+/tUXyp95eVbN2BIvjvhQDaE2zS9CJCduc2fbQTe68R55jGO6F1lncAmF
	Xs0C6ZMZ2P599THN6kUysE4XPmPddduKuDJnXrFBUgQcS6xKwXrLxinzSRB4dqI4BKh58qN096+
	1D3rXSj+mJfg0f73RxmPRe9f1qd6cdWvxeJT4fGuoB8Hsq7OVoZ6ElauW2qmOFYBZfSq3TL5Xys
	NBR72EdRgl8J8P8qx/9Up8sA7zM5k0Hx60wS7rj3PdyPP46DAYy4Y3iSxZy9NY/JInxTsJV6mb1
	U1y9nx8b6pU/tqmNHlIeSU91READSp1dv8PSD+yY2rXXRTRfjlEAudidUyDk0ZTF5nskSgpFaiI
	kCGbWrkt6DKMViq0Vzv0JkmwyE2TPuxxKd4I=
X-Received: by 2002:a05:690c:3705:b0:7f4:fad5:2087 with SMTP id 00721157ae682-81fb8b36a91mr27760407b3.38.1785435769608;
        Thu, 30 Jul 2026 11:22:49 -0700 (PDT)
X-Received: by 2002:a05:690c:3705:b0:7f4:fad5:2087 with SMTP id 00721157ae682-81fb8b36a91mr27759957b3.38.1785435769087;
        Thu, 30 Jul 2026 11:22:49 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fc4175a04sm2847377b3.15.2026.07.30.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:22:48 -0700 (PDT)
Date: Thu, 30 Jul 2026 14:22:45 -0400
From: Brian Masney <bmasney@redhat.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Edward-JW Yang <edward-jw.yang@mediatek.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Irving-CH Lin <irving-ch.lin@mediatek.com>
Subject: Re: [PATCH v4 00/24] MT8189: Add support for system and base clock
 controllers
Message-ID: <amuWdRD-TBQtFT_4@redhat.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Jul 29, 2026 at 12:02:44PM +0200, Louis-Alexis Eyraud wrote:
> This series is a continuation by AngeloGioacchino Del Regno and I of a
> previous series ([1]), that adds the clock controller support for
> the Mediatek MT8189 SoC and its variants (MT8371, MT8391).  
> 
> The first major changes is the split of the series in two:
> - one for all basic clock controllers including system ones (this
> series)
> - one for the multimedia and graphics related clock controllers (to be
> send in the future)
> 
> We chose to separate the multimedia clock drivers from the base system
> ones, as there is currently an unsolvable inter-dependency between the
> power domains and multimedia clocks; the power domains need a
> dual-stage bring-up, where only a part of the multimedia clocks are
> accessible in the first power domain powerup stage, and the rest when
> the second stage (SRAM enablement) is done.
> The current workarounds for this issue, such as removing the is_enabled
> operation from the impacted clock controllers clk_ops table or
> let the multimedia power domain always on, were quickly discarded
> for upstream.
> 
> The second major change is the dt-bindings patch ([2]) that got heavily
> reworked, not only because of the split choice. We took the opportunity
> to regroup in the MT8186 clock and system clock dt-bindings the
> description of several other Mediatek SoC (MT8188, MT8192 and MT8195)
> and add in them the MT8189 new ones.
> The rationale is to ease maintainability and have common files for
> several currently supported SoC or new future ones, that have the same
> kind of clock controller design.
> 
> Finally the pending remarks from peer reviews on the v6 revision of [1]
> were also taken into account and new fixes and cleanups were also
> added.
> 
> A more detailed changelog between [1] and this series:
> - Removed multimedia and graphics related clock controllers code and
>   definitions from series
> - Added new dt-bindings patches to factorise existing MT8188, MT8192
>   and MT8195 in MT8186 clock dt-bindings
> - Heavily modified the MT8189 dt-bindings to add new compatibles 
>   in MT8186 clock dt-bindings
> - Created a new dt-bindings include for the MT8189 reset controller
>   definitions (include/dt-bindings/reset/mediatek,mt8189-resets.h)
> - Removed unnecessary `syscon` compatible fallback from MT8189 base
>   clock controllers
> - Added missing 'mediatek,mt8189-fhctl' compatible declaration in
>   dt-bindings
> - Modified Kconfig to COMMON_CLK_MT8189 be tristate (and not bool) to 
>   allow all MT8189 clock controller drivers to be built as modules (it
>   was partial) 
> - Fix pll unregisters in clk_mt8189_apmixed_probe error case
> - Reparent several clocks to correct 26M references in clk-mt8189-bus.c,
>   clk-mt8189-topckgen.c and clk-mt8189-vlpckgen.c
> - Removed CLK_SET_RATE_NO_REPARENT flag from mfg_sel_mfgpll
> - Rename TOPCKGEN_fmipi_csi_up26m clock to fmipi_csi_up26m to remove caps usage
> - Implemented reset controllers in clk-mt8189-ufs.c
> - Updated all file headers to update copyrights and add all authors
> - Added all co-developed-by trailers
> 
> The series is based on linux-next tree (tag: next-20260728) and has
> been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK (MT8391)
> boards, with hardware enablement patch series ([3]), and on Genio
> 510-EVK (MT8370, variant of MT8188) and Genio 1200-EVK (MT8395,
> variant of MT8195).
> 
> [1]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-1-irving-ch.lin@mediatek.com/
> [2]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-2-irving-ch.lin@mediatek.com/
> [3]: https://lore.kernel.org/linux-mediatek/20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com/
> 
> ---
> Changes in v4:
> - Rebased on next-20260728 tag
> - Added patches 9 to 14 to add new clock ops data set for PLL and
>   PLL-FHCTL to handle a new PLL switch logic for PLL control and BAR
>   reset, supported by MT8189 SoC
> - Patch 15:
>   - Removed useless includes (B. Masney)
>   - Fixed variable declaration order in clk_mt8189_apmixed_probe (B.
>     Masney)
>   - Added missing pwr_reg setting setting in PLL_SETCLR macro (B. 
>     Masney, Sashiko)
>   - Added en_set_reg, en_clr_reg, rst_bar_reg, rst_bar_set_reg and
>     rst_bar_clr_reg fixed offsets and new mtk_pll_setclr_ops ops
>     setting in PLL_SETCLR macro
>   - Added pwr_reg offset values in apmixed_plls array
>   - Fixed rst_bar_mask for mainpll univpll, and mmpll in apmixed_plls
>     array to match rst_bar set/clr reg settings
> - Fixed factor ratio for mainpll_d4_d8, tvdpll1_d16, tvdpll2_d16 and
>   osc_d16 clocks (Sashiko)
> - Link to v3: https://lore.kernel.org/r/20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com
> 
> Changes in v3:
> - Rebased on next-20260717 tag
> - Added Fixes tags to patches 1, 2 and 3
> - Reworded patch 8 subject and description messages
> - Updated Reviewed-by and Acked-by trailers
> - Link to v2: https://lore.kernel.org/r/20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com
> 
> Changes in v2:
> - Rebased on next-20260708 tag
> - Added patch 1,2 and 3 to make the #clock-cells a required property in
>   MT8186, MT8192 and MT8195 clock controller dt-bindings
> - Patch 5:
>   - Removed conditional blocks to check clock-cells property presence
>     for MT8188 clock controller compatible
>   - Reworded commit message to remove the note (no more applicable)
>   - Fixed incorrect property value in else block for #reset-cells
>     property check.
> _ Removed from patch 9 conditional blocks to check clock-cells property
>   presence for MT8189 clock controller compatible
> - Fixed missing MODULE_DEVICE_TABLE in patches 10, 11 and 12.
> - Added devicetree series link in cover letter
> - Link to v1: https://lore.kernel.org/r/20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com
> 
> ---
> Louis-Alexis Eyraud (24):
>       dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8186
>       dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8192
>       dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8195
>       dt-bindings: clock: mediatek: reorder MT8186 compatibles
>       dt-bindings: clock: mediatek: regroup MT8188 dt-bindings into MT8186
>       dt-bindings: clock: mediatek: regroup MT8192 dt-bindings into MT8186
>       dt-bindings: clock: mediatek: regroup MT8195 dt-bindings into MT8186
>       dt-bindings: clock: mediatek: Add MT8189 system/base clocks and resets
>       clk: mediatek: Harmonize mtk_pll_fenc related symbol names
>       clk: mediatek: pll: Add BAR reset register offsets
>       clk: mediatek: pll: split default prepare/unprepare callbacks
>       clk: mediatek: pll: Add ops for PLLs using set/clr regs
>       clk: mediatek: pllfh: Add configurable clock ops to mtk_pllfh_data
>       clk: mediatek: pllfh: Add ops for PLLs using set/clr regs
>       clk: mediatek: Add MT8189 apmixedsys clock support
>       clk: mediatek: Add MT8189 topckgen clock support
>       clk: mediatek: Add MT8189 vlpckgen clock support
>       clk: mediatek: Add MT8189 vlpcfg clock support
>       clk: mediatek: Add MT8189 bus clock support
>       clk: mediatek: Add MT8189 dbgao clock support
>       clk: mediatek: Add MT8189 dvfsrc clock support
>       clk: mediatek: Add MT8189 i2c clock support
>       clk: mediatek: Add MT8189 scp clock support
>       clk: mediatek: Add MT8189 ufs clock support
> 
>  .../bindings/clock/mediatek,mt8186-clock.yaml      |  128 ++-
>  .../bindings/clock/mediatek,mt8186-fhctl.yaml      |    1 +
>  .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   24 +-
>  .../bindings/clock/mediatek,mt8188-clock.yaml      |   93 --
>  .../bindings/clock/mediatek,mt8188-sys-clock.yaml  |   58 --
>  .../bindings/clock/mediatek,mt8192-clock.yaml      |  191 ----
>  .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |   68 --
>  .../bindings/clock/mediatek,mt8195-clock.yaml      |  238 -----
>  .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |   76 --
>  drivers/clk/mediatek/Kconfig                       |   79 ++
>  drivers/clk/mediatek/Makefile                      |    8 +
>  drivers/clk/mediatek/clk-mt8189-apmixedsys.c       |  203 ++++
>  drivers/clk/mediatek/clk-mt8189-bus.c              |  200 ++++
>  drivers/clk/mediatek/clk-mt8189-dbgao.c            |   98 ++
>  drivers/clk/mediatek/clk-mt8189-dvfsrc.c           |   58 ++
>  drivers/clk/mediatek/clk-mt8189-iic.c              |  122 +++
>  drivers/clk/mediatek/clk-mt8189-scp.c              |   77 ++
>  drivers/clk/mediatek/clk-mt8189-topckgen.c         | 1025 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mt8189-ufs.c              |  133 +++
>  drivers/clk/mediatek/clk-mt8189-vlpcfg.c           |  116 +++
>  drivers/clk/mediatek/clk-mt8189-vlpckgen.c         |  285 ++++++
>  drivers/clk/mediatek/clk-mt8196-apmixedsys.c       |    2 +-
>  drivers/clk/mediatek/clk-mt8196-vlpckgen.c         |    2 +-
>  drivers/clk/mediatek/clk-pll.c                     |  135 ++-
>  drivers/clk/mediatek/clk-pll.h                     |   13 +-
>  drivers/clk/mediatek/clk-pllfh.c                   |   15 +-
>  drivers/clk/mediatek/clk-pllfh.h                   |    3 +
>  include/dt-bindings/clock/mediatek,mt8189-clk.h    |  433 +++++++++
>  include/dt-bindings/reset/mediatek,mt8189-resets.h |   17 +
>  29 files changed, 3135 insertions(+), 766 deletions(-)

Should there be a new MAINTAINERS entry added? There's currently 221
files under drivers/clk/mediatek/ and there's currently only one
mediatek maintainer entry:

    MEDIATEK MT6735 CLOCK & RESET DRIVERS.

Is there anyone from mediatek (or elsewhere) that could act as a clk
subsystem maintainer similar to what the other SoC vendors do? Help with
reviews, send in pulls, etc?

I'll review this one in a bit but this subsystem is big enough that it
really should have some support from the vendor (or via a consulting
company) in some form.

Brian

