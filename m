Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A04908B1;
	Sat, 25 Jul 2026 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983963; cv=none; b=hGhRPymYblQ1Ibbqhyc8uz5cM68u7oH4xIQhdbivhOcQgVHXeJ12RcLzt0VvC5fZtXSwBop0KVaYlIwJRoDNSgWqJCY13guxE2C3rtHNZI0pWBTgapHB3fMJvz6scA09Y+r6ghSpkkS8guQoIH5xXTuQB8uTEpDf0kxGl7SYS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983963; c=relaxed/simple;
	bh=tKV47GvuhHzmQIQkHMcaHdIf0iBX0DZ5dQNigjA0iLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLuNOE3sIvbxZMaI6u+zOzOTEEpa3DqD/DYlXF8MqrES0u83U/fnkpbxFPSMV5MEPLFCqdgepoQgxgn7Q0ej+d51zsmdOGDtyKol4A7pqhcTLL2NV2IndUsbMlvtuL4TE7MOs9lb1Y7Oa4pvSHOXWNaOzUJllnbRgfxvkNIBqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8ej9lUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8ej9lUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23841F000E9;
	Sat, 25 Jul 2026 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784983961;
	bh=gT38tjeb++jK/k2GuhtDfea7iMxOcK2Bu0owLvQjsQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E8ej9lUKixqo3RxPh//MNsA71v7PrPdyLkXDtAeGb3Yemsy9aEzLvk2K5oz84l5x3
	 +FzzucF/0rBESyA5JsMmGfCIvEIri2OV6fKCcYdjt3vBqejmaa86y0MHGDa0PMhkab
	 31usKxz6ndNOGZigUb0uEUvaa092ddmGqMXUG0PcRx7hnuG3v0kLW0SD98ABoO0TJd
	 hsKil2gkGtSzIIVg/fGfmFysDRP/80BIT40/O3WeYZ6UD4dhlv8seIhoFmFTJEvg68
	 mn0LqPLvrruEwBxA4b9dqIuzN/1+ZhLL+pS96jfw809ydAF7SV9jsEEvjDu2OS+d2O
	 rH2JfYXTWt0zQ==
Date: Sat, 25 Jul 2026 12:52:38 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] riscv: dts: spacemit: Fix phy id check for the phy
 on pico-itx board
Message-ID: <20260725125238-GKC77545@kernel.org>
References: <20260725005804.373698-1-inochiama@gmail.com>
 <20260725005804.373698-2-inochiama@gmail.com>
 <9545227f-77ef-480d-bb55-6caf1124627c@freeshell.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9545227f-77ef-480d-bb55-6caf1124627c@freeshell.de>

Hi E Shattow,

On 01:12 Sat 25 Jul     , E Shattow wrote:
> Hi Inochi,
> 
> On 7/24/26 17:58, Inochi Amaoto wrote:
> > Current phy framework can not reinit the phy correctly, as it will
> > assert the phy reset GPIO so the phy id can not be readed. Setting
> > the phy id of board pico-itx manually so the phy id dectection can
> > be skipped.
> > 
> > Fixes: 74657a376960 ("riscv: dts: spacemit: Add ethernet device for K3")
> > Reported-by: E Shattow <e@freeshell.de>
> > Reported-by: Inochi Amaoto <inochiama@gmail.com>
> > Closes: https://lore.kernel.org/netdev/20260712045233.800748-1-inochiama@gmail.com
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: E Shattow <e@freeshell.de>
> > ---
> >  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > index b2a7d2d0d3a8..b9d2de878f38 100644
> > --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > @@ -196,7 +196,8 @@ &eth0 {
> >  
> >  	mdio {
> >  		phy0: phy@1 {
> > -			compatible = "ethernet-phy-ieee802.3-c22";
> > +			compatible = "ethernet-phy-id001c.c916",
> > +				     "ethernet-phy-ieee802.3-c22";
> >  			reg = <1>;
> >  			reset-gpios = <&gpio 0 15 GPIO_ACTIVE_LOW>;
> >  			reset-assert-us = <10000>;
> 
> Looks good to me, aside from commit message spelling and grammar nits
> ("re-initialize", "read", "detection"). Yixun may just fix in-flight, my
> R-by and T-by tags can stay.
> 
Yes, I will fix them while applying, no need to resend, thanks for review

-- 
Yixun Lan (dlan)
