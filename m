Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE634D3BE;
	Fri,  9 Oct 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564617; cv=none; b=bVoV89JylWFtUNAvNVjRPlU9kJacEE84CYqCxuuNhUgODIzxs/tGiWHbsWvv8oChcKs92RR7BprxGsb1yyY/zyx4VyKi28cfSWf4ZADDIKH+XnH8T3biyOCa9Zmvr8holpFBzULTMf8FIgIYArC3rdQRHFq0KXuZ01GsUf3o9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564617; c=relaxed/simple;
	bh=5G0sBwACRL5D52xdlWgz3htUbJLR0HlFH/MMh7jYA+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqm230Em269R9Ft6tXqxkLbywg2F1EK9GGBHrIA/XE7OPkUu0PrOkzIJCzXOlL/7I1oSCFgwW3C46MEU+qCiWpTSWHnIOfYyqapTs9kgIAty8HTnDkhJY/JjcXNkch465i1LoTzEZDU9KBvzIbUCLERObIPZja8c0nzY3Wfnrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWyDY+ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWyDY+ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA00E1F000FF;
	Fri,  9 Oct 2026 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791564616;
	bh=X5bMgzoAD9TX0Ya0OQIcLnyUsUBkoiE4qn++57CQU/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gWyDY+ezHCpkHnpiVa+qJfyQh44cMGLAEea9ajLx2EdZnqG8WGnwDgrNQ7fK5dGeC
	 giFTynWHnUkmmIctB0JvtkUcCdR7FFXh3CQwa9xCkKFARs1xDhGdtGZWd5domM8smQ
	 gdzJ7lbM07RnbBAmgV9z2mF/k1lMhz83yXlO3ZZfEenB3zmqJYXvSZNYG1mdaXB0hV
	 n4QawKNGnVK9Ypjce91gXG73wOELPv+q004DNN0axye/nqPWpOl3GkfhBpaZku1a5e
	 bqrMk6P9ek3E/Tiw/DzGwUo0MBtMVzaUA1dqKqiZrY1OEtCDWLrKeT9ej8V4lQqFgW
	 qGoBkJunp7ZCg==
Date: Fri, 9 Oct 2026 11:50:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v11 4/6] dt-bindings: net: rockchip-dwmac:
 document pcs-handle
Message-ID: <179156461404.2718981.13574948615000926953.robh@kernel.org>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
 <20261008175225.3375274-5-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008175225.3375274-5-coiaprant@gmail.com>


On Fri, 09 Oct 2026 01:51:58 +0800, Coia Prant wrote:
> The Rockchip GMAC binding needs to describe the PCS reference used by
> the SGMII support added later in this series. The property will be
> parsed by rk_pcs_init(), and a missing phandle fails the probe. Add it
> and require it when phy-mode is "sgmii" on rockchip,rk3568-gmac, the
> only SoC in this binding that has SGMII support.
> 
> Signed-off-by: Coia Prant <coiaprant@gmail.com>
> ---
>  .../bindings/net/rockchip-dwmac.yaml          | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

