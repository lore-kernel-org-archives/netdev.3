Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58574380FC6;
	Thu,  9 Jul 2026 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605810; cv=none; b=bnwL8aO0N4F/1+NH1I8whVAB+MbMQcJY+5wMwhy/dKl7VwjEZ6HhXJlqzJSQkta14bwGhqf45L4s+ZNWrh95Z3Uofts87bj8KSyZforoOCOAkZvntgGE2gKZbzWLez4SLI9lxDyBSaH056PPqwRP/2GYP1pcgV+6TtN7zO7AGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605810; c=relaxed/simple;
	bh=ebi8GJI9/lZKf3AA3RpD8Pnml58iLOulJKMht+JSC6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB1vwrwZ9Lcr3HW9ASHdzUW9LHWwBQebm4Z1nEkZSag2temgbXI/7mlcX8sSB78G87xGebKGhfEdK5eNWxY28LuOou8avygSjFbdbDdFDU6bJnGgBdG/M3entnaMa+lj1LMBYao22hV+74fH/NOnJGMmHx1WBEbS0lW3Qn+G54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TUtZHbt7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TUtZHbt7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605807;
	bh=ebi8GJI9/lZKf3AA3RpD8Pnml58iLOulJKMht+JSC6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TUtZHbt72S8Pig54Zw6VmDB/bcbKwANwpSrXjwPLGtvugVeQA8Z00o4QYTSB4fe10
	 YVXVfj4ZjvSAGpjvgkqV79NLff1EpHORUAwu9wLsiRQt57TQJE4xXsuZb718T57SK8
	 8Iy4JhaW4ONJi+vACxxPfsOrTQoJ8itTMFLUFGEeE6mrrQT/YPd6ssDjuMBXVNBgNt
	 4daC286mTjy0rJsNp+SGWgKpNSWZwPo5CQtXaH/w2A2qLfNyNlebTQyqKR+Ix7d/2w
	 7xG8U0tjmptEFWaPRx3YBg4UrWT4n+ngkodFq16qAWmN+FbCmrcewWV/v9jtJT+6NE
	 9b4AtLgaD+x/A==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EE68617E071A;
	Thu, 09 Jul 2026 16:03:26 +0200 (CEST)
Message-ID: <7366c2b4-cd69-44ec-96c2-541c61a2708f@collabora.com>
Date: Thu, 9 Jul 2026 16:03:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] dt-bindings: clock: mediatek: regroup MT8188
 dt-bindings into MT8186
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-5-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-5-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Regroup the MT8188 clock and system clock dt-bindings into MT8186 ones
> to ease maintainability and have common files for several currently
> supported SoC or new future ones, that have the same kind of clock
> controller design.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>   .../bindings/clock/mediatek,mt8186-clock.yaml      | 50 +++++++++++-
>   .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |  6 +-
>   .../bindings/clock/mediatek,mt8188-clock.yaml      | 93 ----------------------
>   .../bindings/clock/mediatek,mt8188-sys-clock.yaml  | 58 --------------
>   4 files changed, 54 insertions(+), 153 deletions(-)
> 

..snip..

> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
> index 6733dafbde16..199eac2034f2 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
> @@ -4,7 +4,7 @@
>   $id: http://devicetree.org/schemas/clock/mediatek,mt8186-sys-clock.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: MediaTek System Clock Controller for MT8186
> +title: MediaTek System Clock Controller for  Mediatek SoCs

"for<space><space>MediaTek SoCs"

You should really fix the double space, or if that can be fixed while applying,
that's also fine for me.

So, with that fixed, either by you or while applying...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
