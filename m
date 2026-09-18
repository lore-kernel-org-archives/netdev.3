Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00C52188A;
	Fri, 18 Sep 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756050; cv=none; b=WzALX5VoGtarrri+h3kvsF+bCNSFVfWYO+5/QLs522szpziLcdt5z1LWmYdQd4Q859Ifyncd6J2eUaLYi1tdOZRV8Uaht8KdXZidgianyyXWZsH8suDiPrmPCluIi7U5hMGnWG3A3D/1zRWulfwgmldV5cVLDoZii7vTCZ2mK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756050; c=relaxed/simple;
	bh=Dri96WREQxEfwj2wUP6PyuqNIP93ZOfNmQegkWad4mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg55eOibqWwWXic2NbWYv0bTaRiXsiQhPHZRCZZJzVz9xzDs/3d0hO00AzScqB8f9IRfcwYdRyjz5Dcrh3xGUgybNqXtTVQP58XuBMDeLdGQrnhcZNGd58v1kJlln8FXSsuusohbwHzld4sZB/McX/OLa7lXPKP8nQZYWYWgnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOhzJEHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOhzJEHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8821F000FF;
	Fri, 18 Sep 2026 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756048;
	bh=WLZnhkcbCs2cGW8z2qAspQRyV6RDHbz3ypUhIp/hIoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOhzJEHvKuUqYkqOMv6WEMzOnah9ODgXw77d8su//Qz/QRBWSYMq30HRBZyJfcBPs
	 GIZ0OpjHyVy60b4/F1ETe9qo8pNdupvvo+ok3kKVVu8M+JCnDwuXZxoDENMojh7o5Y
	 Xhd/tG3jhRVJnTgRENawjOtynb06j161CAXuxBExwL/NjG26R2w+bV+wQy6N6xbOQu
	 jcuby6T2fvjbrjeFFjNRj7bTdtmRGglf5GCzVWBwZ/6MdTA/zbi7RPQ9WqDGWCfqfW
	 0A3eJ8sE6AJR7jDevEuz8/ry5S9XKC/yaGsa5LxjZHwGj5TUEL5ShBFxDLx3dbv/nU
	 KYurNwwtu06Kg==
Date: Fri, 18 Sep 2026 13:27:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: net: snps,dwmac: allow stmmaceth-ocp reset
 name
Message-ID: <178975604551.1250907.16038130786685150489.robh@kernel.org>
References: <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909080559.2028-1-muhammad.nazim.amirul.nazle.asmade@altera.com>


On Wed, 09 Sep 2026 01:05:59 -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Arria10 SoCFPGA DWMAC nodes use reset-names = "stmmaceth",
> "stmmaceth-ocp", which matches what dwmac-socfpga looks up for the
> OCP reset. The generic snps,dwmac binding only allowed "ahb" as the
> second reset name, so Arria10 DTS failed schema validation.
> 
> Allow "stmmaceth-ocp" as an alternative second reset name and drop
> the related TODO from the Altera SoCFPGA DWMAC binding.
> 
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
>  .../devicetree/bindings/net/altr,socfpga-stmmac.yaml          | 2 --
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml         | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

