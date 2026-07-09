Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC22386C10;
	Thu,  9 Jul 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605834; cv=none; b=jsjImXNQu7B7rt2GUSotTkMLU/NpICWmfgjGzdo4VCMjXZHr40G34stRqvY4o1Y32UH85bRZan81AV3hgDKD/H7FREQoTGWNCkIoek3DVhNnzJEi+zB9AvSP/4unxIXVrmJd1m8GO5pUsHD/CjBn8FV5dnwkggS66BvBla77abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605834; c=relaxed/simple;
	bh=UZ3PHDW4zdDEQxDflFdrx632qTOxZ6BffzUYxwD25o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eqq+dt8T22iiclA81U8RP/WFW1r3eZ4FcaWcutxRyKTrT+HX9nJTqSvxKBXAoflCierdEx+iVz+fCPB0HDp3FBwOJiv//2y32vhp/ymCwHTW0mol61xyMmcgDugszx6RshUliV/ZU/j5FBhqmW3clEXu59+0XpbxSVGM+60CUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aonCRNv7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aonCRNv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783605831;
	bh=UZ3PHDW4zdDEQxDflFdrx632qTOxZ6BffzUYxwD25o8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aonCRNv78A6rJhUU9Yelak8FMv9h3vWd6X2KAv9D+3tQKgL++k+u9a1CpDyQtYB/+
	 WPfEDilYkS7rR5HAw0oZeMANo/AkMQmUD+CdMx8odchxfd8iqykMH9x3u6O01WUuLV
	 jflyz1wXeIZeXc0NbPmTQmpiP6vFzyOvV3MZNIN/M4QdpxtRNASsv90LpqhEcZbsU1
	 lAsryKztCwJVB3kbtOGk8O4D8CHnrdVJ8JDju87BwDCiwXR3eQX4GqvBU8Y8KLzWY0
	 9msiVgM+eXtV109ZqNUaHwKCQknMsjMhj8Hy6sKk7QfaH/2X5K1hLZ26I49X8JllFT
	 eeMV5WEPOa57g==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B592F17E071A;
	Thu, 09 Jul 2026 16:03:50 +0200 (CEST)
Message-ID: <9c128479-ff4e-43dc-a220-4653a3068e56@collabora.com>
Date: Thu, 9 Jul 2026 16:03:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] dt-bindings: clock: mediatek: regroup MT8192
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
 <20260709-mt8189-clocks-system-base-v2-6-2926da3db6cf@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-6-2926da3db6cf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/26 15:42, Louis-Alexis Eyraud wrote:
> Regroup the MT8192 clock and system clock dt-bindings into MT8186 ones
> to ease maintainability and have common files for several currently
> supported SoC or new future ones, that have the same kind of clock
> controller design.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

