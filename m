Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F13B993F;
	Fri, 31 Jul 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492313; cv=none; b=KKfZ2+m7L/bUL6F06jJKPVoDvy698m4WAFh1gNpMBHDVxO+fZ9d+Jz3DRy0zKl/fXpPikA6qDT1MSnq1isp3PfLU6HYcrvBGW/QmW8D71DOn5tRB1fG1BrJxZzh0PXWMTwvnxfl+yvvTJisRoe5cxb87j1x9/J969N/yB4Jklxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492313; c=relaxed/simple;
	bh=q7Y9ualYVmyDVCnf/GOhgUr1C87Lvn2uHjeOpqU1XFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmYfwGX9HIvmr1uwn7PV9ALSYHnGNLOM0gWO1ehar7reI1Ihwciq5SVRyG7JCu25JXzn4v14OsdyhT7UOFpFMF2v0YPeY0Tsk7VkVMAh+cskZnB0qZOzR09lngy6J8PgLfgIV2IUarrVZ/qyD/KWURviBW3WAyBtdeHQCPeNzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZljWTeFP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZljWTeFP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785492290;
	bh=q7Y9ualYVmyDVCnf/GOhgUr1C87Lvn2uHjeOpqU1XFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZljWTeFPbh+GZAPLCO8Hq+ytm1LR0AbgVzcQUQwlLfaUDsVTiFhtxooguurTDxAE/
	 bYpwwFaJgKoZu6IKHGzGp++ZO0fevAj7ry630QkS7RDbx37GKbYQ2eZeBhOC1DEP7E
	 xrDLnn4vZD0diTKPRRTDgzhLtMbNH6XisuehRMLGCmAHeCrE6feq96bmvvBuGTWE4Q
	 XYVobpkDamJNeLLQwg+MmgC5V+bEyQzvcfJw3ATBDWy6TcZ8VAKDwFfDMiDO+VrBcg
	 4kYtoVBUKXUfZU3w4w/k2pP04PxA1iAzzWfvuFU2c3sk1WIxXiUvgHMGCRVIyZXZul
	 gE2gvKZeZQYTw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1ED4F17E051A;
	Fri, 31 Jul 2026 12:04:50 +0200 (CEST)
Message-ID: <1f6bdf69-c3fe-4e1d-8ff8-0e36d9f4e063@collabora.com>
Date: Fri, 31 Jul 2026 12:04:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/24] MT8189: Add support for system and base clock
 controllers
To: Brian Masney <bmasney@redhat.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Richard Cochran <richardcochran@gmail.com>, Chen-Yu Tsai
 <wenst@chromium.org>, kernel@collabora.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Irving-CH Lin <irving-ch.lin@mediatek.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
 <amuWdRD-TBQtFT_4@redhat.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <amuWdRD-TBQtFT_4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 20:22, Brian Masney wrote:
> On Wed, Jul 29, 2026 at 12:02:44PM +0200, Louis-Alexis Eyraud wrote:
>> This series is a continuation by AngeloGioacchino Del Regno and I of a
>> previous series ([1]), that adds the clock controller support for
>> the Mediatek MT8189 SoC and its variants (MT8371, MT8391).
>>
>> The first major changes is the split of the series in two:
>> - one for all basic clock controllers including system ones (this
>> series)
>> - one for the multimedia and graphics related clock controllers (to be
>> send in the future)
>>
>> We chose to separate the multimedia clock drivers from the base system
>> ones, as there is currently an unsolvable inter-dependency between the
>> power domains and multimedia clocks; the power domains need a
>> dual-stage bring-up, where only a part of the multimedia clocks are
>> accessible in the first power domain powerup stage, and the rest when
>> the second stage (SRAM enablement) is done.
>> The current workarounds for this issue, such as removing the is_enabled
>> operation from the impacted clock controllers clk_ops table or
>> let the multimedia power domain always on, were quickly discarded
>> for upstream.
>>
>> The second major change is the dt-bindings patch ([2]) that got heavily
>> reworked, not only because of the split choice. We took the opportunity
>> to regroup in the MT8186 clock and system clock dt-bindings the
>> description of several other Mediatek SoC (MT8188, MT8192 and MT8195)
>> and add in them the MT8189 new ones.
>> The rationale is to ease maintainability and have common files for
>> several currently supported SoC or new future ones, that have the same
>> kind of clock controller design.
>>
>> Finally the pending remarks from peer reviews on the v6 revision of [1]
>> were also taken into account and new fixes and cleanups were also
>> added.
>>
>> A more detailed changelog between [1] and this series:
>> - Removed multimedia and graphics related clock controllers code and
>>    definitions from series
>> - Added new dt-bindings patches to factorise existing MT8188, MT8192
>>    and MT8195 in MT8186 clock dt-bindings
>> - Heavily modified the MT8189 dt-bindings to add new compatibles
>>    in MT8186 clock dt-bindings
>> - Created a new dt-bindings include for the MT8189 reset controller
>>    definitions (include/dt-bindings/reset/mediatek,mt8189-resets.h)
>> - Removed unnecessary `syscon` compatible fallback from MT8189 base
>>    clock controllers
>> - Added missing 'mediatek,mt8189-fhctl' compatible declaration in
>>    dt-bindings
>> - Modified Kconfig to COMMON_CLK_MT8189 be tristate (and not bool) to
>>    allow all MT8189 clock controller drivers to be built as modules (it
>>    was partial)
>> - Fix pll unregisters in clk_mt8189_apmixed_probe error case
>> - Reparent several clocks to correct 26M references in clk-mt8189-bus.c,
>>    clk-mt8189-topckgen.c and clk-mt8189-vlpckgen.c
>> - Removed CLK_SET_RATE_NO_REPARENT flag from mfg_sel_mfgpll
>> - Rename TOPCKGEN_fmipi_csi_up26m clock to fmipi_csi_up26m to remove caps usage
>> - Implemented reset controllers in clk-mt8189-ufs.c
>> - Updated all file headers to update copyrights and add all authors
>> - Added all co-developed-by trailers
>>
>> The series is based on linux-next tree (tag: next-20260728) and has
>> been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK (MT8391)
>> boards, with hardware enablement patch series ([3]), and on Genio
>> 510-EVK (MT8370, variant of MT8188) and Genio 1200-EVK (MT8395,
>> variant of MT8195).
>>
>> [1]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-1-irving-ch.lin@mediatek.com/
>> [2]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-2-irving-ch.lin@mediatek.com/
>> [3]: https://lore.kernel.org/linux-mediatek/20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com/
>>
>> ---
>> Changes in v4:
>> - Rebased on next-20260728 tag
>> - Added patches 9 to 14 to add new clock ops data set for PLL and
>>    PLL-FHCTL to handle a new PLL switch logic for PLL control and BAR
>>    reset, supported by MT8189 SoC
>> - Patch 15:
>>    - Removed useless includes (B. Masney)
>>    - Fixed variable declaration order in clk_mt8189_apmixed_probe (B.
>>      Masney)
>>    - Added missing pwr_reg setting setting in PLL_SETCLR macro (B.
>>      Masney, Sashiko)
>>    - Added en_set_reg, en_clr_reg, rst_bar_reg, rst_bar_set_reg and
>>      rst_bar_clr_reg fixed offsets and new mtk_pll_setclr_ops ops
>>      setting in PLL_SETCLR macro
>>    - Added pwr_reg offset values in apmixed_plls array
>>    - Fixed rst_bar_mask for mainpll univpll, and mmpll in apmixed_plls
>>      array to match rst_bar set/clr reg settings
>> - Fixed factor ratio for mainpll_d4_d8, tvdpll1_d16, tvdpll2_d16 and
>>    osc_d16 clocks (Sashiko)
>> - Link to v3: https://lore.kernel.org/r/20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com
>>
>> Changes in v3:
>> - Rebased on next-20260717 tag
>> - Added Fixes tags to patches 1, 2 and 3
>> - Reworded patch 8 subject and description messages
>> - Updated Reviewed-by and Acked-by trailers
>> - Link to v2: https://lore.kernel.org/r/20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com
>>
>> Changes in v2:
>> - Rebased on next-20260708 tag
>> - Added patch 1,2 and 3 to make the #clock-cells a required property in
>>    MT8186, MT8192 and MT8195 clock controller dt-bindings
>> - Patch 5:
>>    - Removed conditional blocks to check clock-cells property presence
>>      for MT8188 clock controller compatible
>>    - Reworded commit message to remove the note (no more applicable)
>>    - Fixed incorrect property value in else block for #reset-cells
>>      property check.
>> _ Removed from patch 9 conditional blocks to check clock-cells property
>>    presence for MT8189 clock controller compatible
>> - Fixed missing MODULE_DEVICE_TABLE in patches 10, 11 and 12.
>> - Added devicetree series link in cover letter
>> - Link to v1: https://lore.kernel.org/r/20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com
>>
>> ---
>> Louis-Alexis Eyraud (24):
>>        dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8186
>>        dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8192
>>        dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8195
>>        dt-bindings: clock: mediatek: reorder MT8186 compatibles
>>        dt-bindings: clock: mediatek: regroup MT8188 dt-bindings into MT8186
>>        dt-bindings: clock: mediatek: regroup MT8192 dt-bindings into MT8186
>>        dt-bindings: clock: mediatek: regroup MT8195 dt-bindings into MT8186
>>        dt-bindings: clock: mediatek: Add MT8189 system/base clocks and resets
>>        clk: mediatek: Harmonize mtk_pll_fenc related symbol names
>>        clk: mediatek: pll: Add BAR reset register offsets
>>        clk: mediatek: pll: split default prepare/unprepare callbacks
>>        clk: mediatek: pll: Add ops for PLLs using set/clr regs
>>        clk: mediatek: pllfh: Add configurable clock ops to mtk_pllfh_data
>>        clk: mediatek: pllfh: Add ops for PLLs using set/clr regs
>>        clk: mediatek: Add MT8189 apmixedsys clock support
>>        clk: mediatek: Add MT8189 topckgen clock support
>>        clk: mediatek: Add MT8189 vlpckgen clock support
>>        clk: mediatek: Add MT8189 vlpcfg clock support
>>        clk: mediatek: Add MT8189 bus clock support
>>        clk: mediatek: Add MT8189 dbgao clock support
>>        clk: mediatek: Add MT8189 dvfsrc clock support
>>        clk: mediatek: Add MT8189 i2c clock support
>>        clk: mediatek: Add MT8189 scp clock support
>>        clk: mediatek: Add MT8189 ufs clock support
>>
>>   .../bindings/clock/mediatek,mt8186-clock.yaml      |  128 ++-
>>   .../bindings/clock/mediatek,mt8186-fhctl.yaml      |    1 +
>>   .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   24 +-
>>   .../bindings/clock/mediatek,mt8188-clock.yaml      |   93 --
>>   .../bindings/clock/mediatek,mt8188-sys-clock.yaml  |   58 --
>>   .../bindings/clock/mediatek,mt8192-clock.yaml      |  191 ----
>>   .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |   68 --
>>   .../bindings/clock/mediatek,mt8195-clock.yaml      |  238 -----
>>   .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |   76 --
>>   drivers/clk/mediatek/Kconfig                       |   79 ++
>>   drivers/clk/mediatek/Makefile                      |    8 +
>>   drivers/clk/mediatek/clk-mt8189-apmixedsys.c       |  203 ++++
>>   drivers/clk/mediatek/clk-mt8189-bus.c              |  200 ++++
>>   drivers/clk/mediatek/clk-mt8189-dbgao.c            |   98 ++
>>   drivers/clk/mediatek/clk-mt8189-dvfsrc.c           |   58 ++
>>   drivers/clk/mediatek/clk-mt8189-iic.c              |  122 +++
>>   drivers/clk/mediatek/clk-mt8189-scp.c              |   77 ++
>>   drivers/clk/mediatek/clk-mt8189-topckgen.c         | 1025 ++++++++++++++++++++
>>   drivers/clk/mediatek/clk-mt8189-ufs.c              |  133 +++
>>   drivers/clk/mediatek/clk-mt8189-vlpcfg.c           |  116 +++
>>   drivers/clk/mediatek/clk-mt8189-vlpckgen.c         |  285 ++++++
>>   drivers/clk/mediatek/clk-mt8196-apmixedsys.c       |    2 +-
>>   drivers/clk/mediatek/clk-mt8196-vlpckgen.c         |    2 +-
>>   drivers/clk/mediatek/clk-pll.c                     |  135 ++-
>>   drivers/clk/mediatek/clk-pll.h                     |   13 +-
>>   drivers/clk/mediatek/clk-pllfh.c                   |   15 +-
>>   drivers/clk/mediatek/clk-pllfh.h                   |    3 +
>>   include/dt-bindings/clock/mediatek,mt8189-clk.h    |  433 +++++++++
>>   include/dt-bindings/reset/mediatek,mt8189-resets.h |   17 +
>>   29 files changed, 3135 insertions(+), 766 deletions(-)
> 
> Should there be a new MAINTAINERS entry added? There's currently 221
> files under drivers/clk/mediatek/ and there's currently only one
> mediatek maintainer entry:
> 
>      MEDIATEK MT6735 CLOCK & RESET DRIVERS.
> 
> Is there anyone from mediatek (or elsewhere) that could act as a clk
> subsystem maintainer similar to what the other SoC vendors do? Help with
> reviews, send in pulls, etc?
> 

I may be able to step in, but I have to check if it's feasible, time-wise, on
my side.

Though, that won't happen until mid-September... because, well, I'm about to go
on holiday (in a few days from now).

> I'll review this one in a bit but this subsystem is big enough that it
> really should have some support from the vendor (or via a consulting
> company) in some form.

Thanks for that.

Cheers,
Angelo

