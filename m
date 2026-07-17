Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F71375AC6;
	Fri, 17 Jul 2026 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279162; cv=none; b=eiSYOX4kDPqOz4euqFtAYOcWYrNyYSHpcIJ/eemjmvlER/a8k9g6CIFLKoHW4bPXBMq8xHx9Ge4VF4/GpkEmOHfJ2bVKxKEkscfcxlT5WLAG8aipVOrzMAA8oaVoVQpm1Aewd6ulgKz/IucC+D7eJ01SWZ5+NeO4O8VFW/LVxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279162; c=relaxed/simple;
	bh=m939+coOWBrdAQ5XXQDtJxDlYVYdGp3IQtpQtXVqBtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUIQYwfUPVxjWARTLZfdSF80otiCQsLbsxucd83ofXXs59Anm0KOk2VhaEpFGx8OmlXmcVFyk9zzoKk3W7b/BP0AGoqdcCrRuVqyKC2PICaNjnBCPKRox8UlVdagcs1icP2Xv8SqPzRmvrUGYJZpje9652SMsIxwcStLKuaGMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm4NWxJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm4NWxJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409C51F000E9;
	Fri, 17 Jul 2026 09:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279157;
	bh=+N3kzdUKsK1iHRg6QBEsmQw5YxW2CmsK2YhMLjdQuu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hm4NWxJkb6Itm5VW+gWXxRyfK3W/nHYaa2aHXDItmjWlbYffWWhIRl6ITYRImRJYf
	 jU7s49Nu52SHYs5dKD2Sa+foQrFY0SijDINRSoqH8Ggw7GbtEI7DTzv8b2Cww8XGld
	 d2XqFJQzmZWa4lHwLDA/G0uiGMham6gZdy2avWc0DvYA5o0RaqBDjYsybtW4yPpBC6
	 UAmds1k757Lpi4uZ15mM22wJNu1+HG6ARruY2YWmhvLU0oiaSD7YCPhKAVuylPtOkQ
	 NBJckYVgTwNQWawtxV34r1wmcqxMXJetSaqy1IWzXxfzlJcG0rFhtlwGNkplxMh2wT
	 ZuTeHiaeq75jw==
Date: Fri, 17 Jul 2026 11:05:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liu Changjie <liucj1228@outlook.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Luo Jie <jie.luo@oss.qualcomm.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: Add Maxio MAE0621A PHY
Message-ID: <20260717-immortal-moth-of-will-6ab571@quoll>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
 <MN0PR19MB6091F865EF7FE6AC1EE41C10ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN0PR19MB6091F865EF7FE6AC1EE41C10ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>

On Fri, Jul 17, 2026 at 11:44:03AM +0800, Liu Changjie wrote:
> Document the MAE0621A PHY ID and its optional 125 MHz CLKOUT
> setting. Boards which do not provide the property retain the hardware
> strap or bootloader configuration.
> 
> Only the 125 MHz setting is exposed because it is the only setting
> exercised on hardware.
> 
> Signed-off-by: Liu Changjie <liucj1228@outlook.com>
> ---

How did you address previous feedback?

If you ignore feedback, shall we ignore the patch?

Best regards,
Krzysztof

