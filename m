Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274FF389116;
	Thu,  6 Aug 2026 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018018; cv=none; b=sZ0HvjXp8kO3yA+1bLfcxNU505cFcy5GguX8K2j09aWzYQ15ESAxqwYOSrwW4fkShNfmPl7hwWSPxIQlCFQDVvFThFQqkMnj1+nebw+cShBHomJzSTIEvVgDOQj0MR+ZKzly0ry5hFkRE9joOfk0juL6ItQC8AR/vZ7mlNeRMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018018; c=relaxed/simple;
	bh=r9VGBxwF+J0VJMXe/vi44fLPtflZtoQXoDHaJyHXsjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDuKHlWM6OuaM3HfksdvXZ80jEqANy0NArJySAhKiWrnUeILIlKd83NUEjTSfQW0DeEW09YJx4RFPR3N+K1W0XY0mBIFMOrE4Zi9zsiWVwgP/x2YyHtILBS7/eQjQGf6Hl4X6vdL4VX2oLqA6RPVrl3fj5nfXcJtITAi+cyUaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GGKJmMit; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GGKJmMit"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F033153B;
	Thu,  6 Aug 2026 05:06:52 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A133F632;
	Thu,  6 Aug 2026 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786018016; bh=r9VGBxwF+J0VJMXe/vi44fLPtflZtoQXoDHaJyHXsjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GGKJmMity6kCF4wZUNnHzGepGcdf1SaRohZ8rLzLYO1VxTi0fZmOhXFOXJnUb1Vf9
	 okW11psOZ0rMszXq//5a61um/a4XDtFh74fuswTOVdDdoe608hYchCJ1BUTHAAGX9F
	 dklFELZc0aOaNaGHxF0c2x8fqfYoTiYtoz3VBiSY=
Message-ID: <3c39665b-5fe0-4015-ae96-c97e0ce8e9c2@arm.com>
Date: Thu, 6 Aug 2026 14:06:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 0/2] net: stmmac: Add support for Allwinner A733
 GMAC210
To: Jerome Brunet <jbrunet@baylibre.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 7/31/26 18:30, Jerome Brunet wrote:
> The A733 GMAC210 is a DesignWare MAC 5.20 with an Allwinner glue close to
> the A523 GMAC200 already supported by dwmac-sun55i, but with a few
> significant differences:
> 
>   * The glue configuration registers are a dedicated MMIO region of the
>     controller instead of a syscon register.
>   * That region is inside the controller reset domain, so the reset must be
>     released before the configuration is written, and must not be asserted
>     again afterwards or the configuration is lost.
>   * The DMA channels have their own interrupt lines.
>   * A PTP reference clock and an AHB reset are needed.
>   * The controllers do not require a power domain (AFAIK).
>   * The TX clock delay value is 5 bits wide instead of 3, split over 2
>     register fields.
> 
> The DT changes for the A733 and the Cubie A7A board are not part of this
> series and will be sent separately through the sunxi tree.
> 
> Tested on a Cubie A7A, RGMII with an external PHY on GMAC0.
> 
> Full disclosure: at the moment there is a problem with EEE/LPI while
> testing on the Cubie A7A. If the device stays in LPI mode long enough, the
> link sometimes (but not always) goes down, coming back up when the device
> exits LPI mode.

I saw that the MAXIO PHY *vendor* driver disables exactly those two 
modes, so is this maybe more of a PHY problem?

Cheers,
Andre

> 
> I'm currently working around the problem by adding the following
> properties to the PHY node:
> 
> 	eee-broken-100tx;
> 	eee-broken-1000t;
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Jerome Brunet (2):
>        dt-bindings: net: sun8i-emac: Add A733 GMAC210 compatible
>        net: stmmac: Add support for Allwinner A733 GMAC210
> 
>   .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 130 +++++++++++++++---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c | 145 ++++++++++++++++++---
>   2 files changed, 242 insertions(+), 33 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260731-allwinner-a733-gmac-support-163bde10c152
> 
> Best regards,
> --
> Jerome
> 
> 

