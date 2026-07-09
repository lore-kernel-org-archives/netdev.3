Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE250263F34;
	Thu,  9 Jul 2026 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605939; cv=none; b=gspM+2GyKJcjw3A2RpVZzFvkNGesRB+O1YwaG7xm02oizaWHhTNLTctY0DkRl5nuJhvXH/c3phJOcz09Uww/E0kwYTMjWXaEBofsoHAD43N1ogDXuVE2b30XLF/lckWogfrHclYceneGGFWumWZgKqWSbNWJ7rdL+JiVOXO8n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605939; c=relaxed/simple;
	bh=22XW+V5XF0iLnR9+YP/enVD7BjheUREeDzPkDNifOPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYc0G1C8cZesJcUJgC7KIsh5N/btGC4DPThN5Sp5nnYH50qcYCaGSyshXvyOT+Ja90J4RAbqcb8JmnRFSRQRqIpi8c+i2vsLwo9PQflJXxBk5ly0FkSmYKDzQdwtJNQtfoNo7dwL2nCfbRE7XEg/vrc2gQ3CDkep8gZv5rGtQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E2gh5g0k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E2gh5g0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605936;
	bh=22XW+V5XF0iLnR9+YP/enVD7BjheUREeDzPkDNifOPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E2gh5g0kBLcL0tlvGP5nqHnNOU9SxBdqIErJCJ08vhsQe96SukRtXPz0bsZ31RePJ
	 heP8e84zIwb2JQlb79rVImPzBDdiu6WMid3f1JVswovoT0UVHBJsLz5cKuu2mPR3J8
	 vdQ//iJB/Ewhm7tFUxQTIUHJt1y8BCctSOj+xi6+swIyxdqNOj5iVKDsfE0E7WA4ih
	 6xXs5SJkWULzDLLjdRtyMDq1reTPelSSTxCaqElhEmaT0j6DOLIfH1caWtr6/yBa65
	 cqEAblwdhI6KY9XPbbO+UhVkiQTtltwIxsSxaX9BOxMkILfdmYaOolzgtpgKutMal6
	 R0XunXKcYLiSQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84B4D17E01AC;
	Thu, 09 Jul 2026 16:05:35 +0200 (CEST)
Message-ID: <39ba7e37-bdd7-41ab-b72d-fed0bdbfc3b6@collabora.com>
Date: Thu, 9 Jul 2026 16:05:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] dt-bindings: clock: mediatek: Add MT8189 clocks
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
 netdev@vger.kernel.org, Irving-CH Lin <irving-ch.lin@mediatek.com>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
 <20260709-mt8189-clocks-system-base-v2-8-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-8-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Add dt schema and IDs for the clocks of MediaTek MT8189 SoC.
> The MT8189 clock IP provide clock control for main system
> (apmixedsys, topcksys and vlpcksys) and subsys (eg. peri, scp,
> ufs...).
> 
> Also, add compatible for frequency hopping and spread spectrum clock
> functionality and reset controller header file for MT8189 UFS reset
> controller support.
> 
> Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Both the commit description and title are misleading, as in, you're not adding
MT8189 clocks, but *both* clocks *and* resets.

Fix it please.

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../bindings/clock/mediatek,mt8186-clock.yaml      |  15 +
>   .../bindings/clock/mediatek,mt8186-fhctl.yaml      |   1 +
>   .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   5 +
>   include/dt-bindings/clock/mediatek,mt8189-clk.h    | 433 +++++++++++++++++++++
>   include/dt-bindings/reset/mediatek,mt8189-resets.h |  17 +
>   5 files changed, 471 insertions(+)
> 


