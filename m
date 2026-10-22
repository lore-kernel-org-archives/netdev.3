Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666376;
	b=OKlvniGEv9aqNHn24FFjylurYehcf+RBtDNjpF43IAIBP0lqV3KMNybB6Xp0WQggJaUL
	 Vtk8+G6Jkr0ZcxhSU1YCG+NbI8Mqi57Q1oqdyp1+HDDE7hm2GuPWukIeOwxTMiaeEmPsq
	 AxBVx7VV9G7BrtjVSvSoPbbbdipHF61ugzDc819WbeBwVVf7wUSqwnQBHJhjOpIOBsmCI
	 tJnoriog14YuxhiyGMPWfSgE12U5L8JIL5426SRigt9fARp8jR5YcVqWpzyqNuny+yILH
	 fvz3U+XFALAn751lB4r6Yx6IEscwSxLXiCuy1FYY5utho2EvgNsI1ukGPzu93byAJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666376;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vwrggvuqHJQ/Cl+eQIsicnlth4Pru1SY3OAx2uBPjdM=;
	b=WYW5wEm3GZCnElZxyNAWmDVVVhAth3xEMJbg3Jf8Y/e5j8DjhpX6IG2E2pE6ZZc+E2Wl
	 BdL5K0kmFVBxFl9aDP5simXYzRQ+dFL0UUCY1bBr/n79NVq9DNXGhsbddE8kW5BMsV/5W
	 FJKaEaAUeZXUvpSjxpZxtZfwkkCnmHzRZxqH4oRLbQNirnOHZymCFwAIFQeVGf6JmYp3a
	 eStV5irJqPmoc4Hw0KmaCOSs6XcpRyDXZP8L6ROit33CLl9Y2szb6OhFh3eaJvXtFHa/b
	 JiIv9sza8avFzvU3ckva2pG6Jg5londFZQ1TeHvUFPIaQGVlJprUntcmGBZOpBr4RvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8UxxglD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C30606A31B;
	Thu, 22 Oct 2026 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m8UxxglD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917541F000C3;
	Thu, 22 Oct 2026 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792666376;
	bh=vwrggvuqHJQ/Cl+eQIsicnlth4Pru1SY3OAx2uBPjdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m8UxxglDlElIQAXquf2pBWby7YOUVUv5RJAn+4ICUmScuaCAo7oKuwnIq50K7WMM3
	 AnfNXcXBBNECPltXFvYsdtiNY6TOEYMZRD/9JYXynN4ZXV6mSJlE6rToWuCAK8I7tz
	 hB91qJajKnaS5VBVCY8Tj4vI+hORSPk1W46SPS9HqNhjpTyZuiXpzosB3SbfNYM07p
	 +vWMuPJcR7iw4YLLWw0pFddOBMP7Y/dm8hoaMFsT9ZUwHVZczA8mhwHeojJpVS6xH+
	 Vo7AaspF7lyFKPettVS3Yp+k9eRo5aVTSWX+vBZxesEicfjoIt9Tu5SRmC+f4P93Au
	 4tNo4AJckEfMg==
Date: Thu, 22 Oct 2026 12:52:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>, 
	Phil Elwell <phil@raspberrypi.com>, netdev@vger.kernel.org, James Clark <jjc@jclark.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: bcm2835: add the BCM2711 GISB
 clock
Message-ID: <20261022-prehistoric-wealthy-leech-0ec8ff@quoll>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
 <20261020-devel-bcm2711-gisb-clk-v1-1-a1728724d0f8@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-1-a1728724d0f8@tipi-net.de>

On Tue, Oct 20, 2026 at 04:58:09PM +0200, Nicolai Buchwitz wrote:
> BCM2711 has a clock generator for the GISB bus that the firmware sets
> up at 200 MHz. The GENET MDIO controller runs its MDC off it, so add an
> id for it.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  include/dt-bindings/clock/bcm2835.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

