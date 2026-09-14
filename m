Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA74766BB;
	Mon, 14 Sep 2026 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393705; cv=none; b=m6R6stc3Qb+jkanu2oySIzPW/C5cKEbWL0agMbMJc2Oq1UyGT3BnD37iv8E7Ff35icOkhginiKXdoev30muPg18RSo7+wx+VGWlRGRk0ORn4Vrh6ipeFqwwZw1qiadAugOisxycpuNge3NRxnpiLkolccnxRwISkTBOMpjhdzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393705; c=relaxed/simple;
	bh=sqm232wL8WeQzLs2jOKgbSNxH7ke3GuXlQGXo8yJQk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWnJU3B31X4MNUaqOUiKkRTJmoInhUAV0vgq+MtsNjueIRdp9HkwXz7R7HjCx2V76T6hG6gXNx7iTPZRe48kovEsgCXef3B7iYTDoMAepon/+gXyZ3tWynQ3tmBoHcX6IHcdV1ArlH/93sE+LDbVXMltpHs3U2Ws7DDJFO7zMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ppLT7Hd2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ppLT7Hd2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789393702;
	bh=sqm232wL8WeQzLs2jOKgbSNxH7ke3GuXlQGXo8yJQk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ppLT7Hd2WVLs8uYNpUu5s+TTm1uVg/17FO1N+akh3gXmRprLckeYvUZYclQ8A+ej/
	 5b61o4zyKcZEKYqp0BGPsfADvf8U4o4/S0Tv4pgFh7WaC9zEgTewYSj1jJ7QvioVq9
	 8r8MgxyjLBD3w2d7dQeqcStjxltDHSkmyBt4ptaAUnbaNWqNTSUMHUwbq4BVspZaep
	 pfyoJhfhorVIiyEfYSRn7yqRgmWC1W4ObKxBknAPZMxEWmK5vADCBE2xvlLj1XW+RQ
	 U5tEP42bvP++JeIRK2Cgsut81NOnNfaR+nSPPD+B5FrOrLBMgmVb8acscT5rCO6aRb
	 gcH0RHmaow1XQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5676717E05D3;
	Mon, 14 Sep 2026 15:48:21 +0200 (CEST)
Message-ID: <f2bb7446-bfbd-4598-ba95-d9561a4e132b@collabora.com>
Date: Mon, 14 Sep 2026 15:48:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/24] MT8189: Add support for system and base clock
 controllers
To: Brian Masney <bmasney@redhat.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
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
 <1f6bdf69-c3fe-4e1d-8ff8-0e36d9f4e063@collabora.com>
 <aqf6NH-xrMtCQppv@redhat.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aqf6NH-xrMtCQppv@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 15:44, Brian Masney wrote:
> Hi Angelo,
> 
> On Fri, Jul 31, 2026 at 12:04:49PM +0200, AngeloGioacchino Del Regno wrote:
>> On 7/30/26 20:22, Brian Masney wrote:
>>> Should there be a new MAINTAINERS entry added? There's currently 221
>>> files under drivers/clk/mediatek/ and there's currently only one
>>> mediatek maintainer entry:
>>>
>>>       MEDIATEK MT6735 CLOCK & RESET DRIVERS.
>>>
>>> Is there anyone from mediatek (or elsewhere) that could act as a clk
>>> subsystem maintainer similar to what the other SoC vendors do? Help with
>>> reviews, send in pulls, etc?
>>>
>>
>> I may be able to step in, but I have to check if it's feasible, time-wise, on
>> my side.
>>
>> Though, that won't happen until mid-September... because, well, I'm about to go
>> on holiday (in a few days from now).
> 
> I'm checking in to see if you would be willing to be clk submaintainer
> for the MediaTek clk drivers?
> 
> Brian

Time is lacking, but I get that one hour from me is more than zero, which is
a good thing.

Let's do it.

Cheers,
Angelo
