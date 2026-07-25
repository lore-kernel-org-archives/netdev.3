Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5516386C3D;
	Sat, 25 Jul 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784995080; cv=none; b=ajI9EhPrdaldyEL+VzqcZZYEB3rFCXvPSrCq85a8IYS510MOsUDzzcyWBaUb4CchPYofF70KxLjqck5Kx2v+P2DCMfsFwTRnjZUWV3KjpO2v4uVVjOIqadWyeq0sPba5A4bx00Lqw+/ByKVP8o0XZ8VU/htgmV2zD+0Qbmx8BHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784995080; c=relaxed/simple;
	bh=8v4akMFID5xsxgiJnCDCF/p/7xIBw54PZPOaiynEh3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tS2chY1iXYw+Lm6Gz/t7da3IInICh+olH30hyNGXW1W44XF+5FWfhqaeH++Nf1mcr9xr5y4iPoRfyJPzrl1ewS/t8Bo532A7lc88kcjVM57wLSMEdQ1UMbumuaA2rBhUKCMsquzEtqAaEUg2t7N2wb0f6nDswz6GAsomvr27LmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aXXlbmLd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aXXlbmLd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jgtuDnxQHEcklSeiDd1KgmBuuv8iaStyhrluO90ziCo=; b=aXXlbmLdbUaQPC3cjZ4BdXrF6i
	kqFuWuGky72WVRw8gdnecWTFVPorfj/UXuSshZda+KE3VOXB1ngc/y/ZwyG08337V0V7oYJGAas2X
	28kh/uP3z8AVwibMp+3/W1UbOcui9FcXds/vMJhbSiJqy1xRKyy9fC11DileQTMQlGQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnekw-00E9wW-NK; Sat, 25 Jul 2026 17:57:42 +0200
Date: Sat, 25 Jul 2026 17:57:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, E Shattow <e@freeshell.de>
Subject: Re: [PATCH 1/2] riscv: dts: spacemit: Fix phy id check for the phy
 on pico-itx board
Message-ID: <0d11de51-546a-42b6-80cb-8ca258389a17@lunn.ch>
References: <20260725005804.373698-1-inochiama@gmail.com>
 <20260725005804.373698-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725005804.373698-2-inochiama@gmail.com>

On Sat, Jul 25, 2026 at 08:58:02AM +0800, Inochi Amaoto wrote:
> Current phy framework can not reinit the phy correctly, as it will
> assert the phy reset GPIO so the phy id can not be readed. Setting
> the phy id of board pico-itx manually so the phy id dectection can
> be skipped.
> 
> Fixes: 74657a376960 ("riscv: dts: spacemit: Add ethernet device for K3")
> Reported-by: E Shattow <e@freeshell.de>
> Reported-by: Inochi Amaoto <inochiama@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260712045233.800748-1-inochiama@gmail.com
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> index b2a7d2d0d3a8..b9d2de878f38 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -196,7 +196,8 @@ &eth0 {
>  
>  	mdio {
>  		phy0: phy@1 {
> -			compatible = "ethernet-phy-ieee802.3-c22";
> +			compatible = "ethernet-phy-id001c.c916",
> +				     "ethernet-phy-ieee802.3-c22";

There was a patch recently from one of the DT Maintainers removing the
-c22 compatible when there was a specific PHY ID. I did not look into
why. Does this pass all the binding tool checks?

     Andrew
