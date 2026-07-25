Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250A17A303
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785019897; cv=none; b=b9hOd61yQObTQHg86DeNwdfR1Ffnv6OsUPr7sbYu+TNyqkDF0ywOFjhcYkHl0B2CeHDN6JIpB9DZ4qYL+GhI4xqpOcymcO5pthYjVtcH4vdQqILobayBiIvHDPb5brCbUuEOfS6sMcM8wW0SVm/2/6bIUSVESxfIyvIsGiGCpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785019897; c=relaxed/simple;
	bh=OTMLoaXNmc0daefahm7Ve/Ya1YVd+Uzup/9wVhoFs/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKg/VrHXNW7bYZvFyxV95ueu6+Pugpa3eLsOI7K4w/0sfy6NQb86aVTIWOxWLFYc1y6FK7mnTRtbj/Usl6Gg8N7sw+XlzcYATKYLZRJGunXqMBYWFLXt9D0hzu6AREFBTIpHHFu0FbWsNkOypKAcNFZDZxoPuj4EqbjZQPXNBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugm1IM1g; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugm1IM1g"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1760038a91.1
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785019895; x=1785624695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e597SzF5n/PM9EkMnGuBBQh4XkUddaPspXC7fYxFtHE=;
        b=Ugm1IM1g3IdKVSV76YGowyNU5KXZU7ZFTU+lQhnVIQXSw7EF35SrRC5MudtxWAoJc+
         Cw0JDVe5342OIOYuaWnEyczcucP1a6R1GsJu3kHbYfebgbLGkgF+Fs9rxsEI3j1+Q2Xv
         BP9xkpI1ZVvfE9lvRHV7zuBv0+nUgWnNIgc/FZhUfNKj5EUylcGi6IRCa0lZxT2m0aIc
         xWzA8OfJ6O5beLcEHmlLTAqYyS+71aA4pFIeWL0viP5bD3/I+MOUIGD9S3aqxwUti2tK
         RXYXX0UwetLRTgXdeBDnPnYL6qwsLt9kiKg6FyL5HWjHOW3YOglNxptIohnims3JANrQ
         w12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785019895; x=1785624695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e597SzF5n/PM9EkMnGuBBQh4XkUddaPspXC7fYxFtHE=;
        b=RpK7GbH+68rNA7hN27/DI9Lt4bekNtPf7yxM4LecJDl+Gm4ew7GwWIiKQB2vtHR68Q
         hzqge3lk2CYjBoJQxPUg3r9vt6tTUKN26QwCUFIzYHpz80zsPvdcganuUqq1a0U2FR6K
         u0oYwrV33GBbtG6OgmeyWG6icgOBWHatVQyIU3q1YIREOQD1qzt+OUDPzsXL0ucGGtbo
         WrCAs4N9TqQMEyCGk13s46l0dgxYf1tVTF2dbocb7MTtv/82q4QjOwO4g8OCvQkDOg0O
         M0aeeq5EX4itH6/vDoKrGyWP2um4bowWOS9fO37lm+4tkKkcZD+/LJqy5FB9FqRdgaxU
         PrgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz83AshoOuPFXkeqOKw1gTem/c19dtDViTW1NqBgyp80GyU28JWLRw/sIJQAGPvzVfNqV1s/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZBnP2B52B9m/EW1EMRyTvTKWKoUCyTPEiExunX6vp4HZbXCj
	PB8nCBMcE8EQJ+m4q7mxk3PvptNL483WaSZ4uKOOruDpR8AxY2bbB+Xa
X-Gm-Gg: AR+sD11odR6wPRRd+Xze80t3VjjjppPwOOlTERAHx/jCBUR/soerwt2jGb4LBOA0vEH
	+tUpkzBf+mkRBawcE/6K9ssLk79r9d7+5p9txRzBzIoOIecGedO1rJ8KGk3vRc68Ju5riOGzM0R
	5rSm00cpRG1E2QDlH2arj8m0je+8UkJJ5B9iMbLToXLJkuejEKVKyuzsxoxzHgvpImJB+RyQJQ2
	yiNp9PHD07c+7BdYhmDZ0sy5HDehedUZBesN8k4C5r2A/epwpKtUZPTa5k0JOuiQpqFfK1OH2XV
	bkUi6W0KjwQG2eyKCKTWXDZDDiwlz7AqOHyJQQUMIOZpHXclBSsEB3Hk2xlTjyoeoEEbhrPUByW
	cUk0XYltrQiYZ6dCCnvrSocg7zdgBtTRTJsqg4mKURkwdmZIfic2S8oFQ3FprSFgDbQJzfqD1/w
	YP
X-Received: by 2002:a17:90b:268f:b0:387:df8f:1408 with SMTP id 98e67ed59e1d1-38f2978b966mr3637050a91.41.1785019895045;
        Sat, 25 Jul 2026 15:51:35 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm3263879a91.8.2026.07.25.15.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 15:51:34 -0700 (PDT)
Date: Sun, 26 Jul 2026 06:51:28 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	E Shattow <e@freeshell.de>
Subject: Re: [PATCH 1/2] riscv: dts: spacemit: Fix phy id check for the phy
 on pico-itx board
Message-ID: <amU94BeIJT39DRRL@inochi.infowork>
References: <20260725005804.373698-1-inochiama@gmail.com>
 <20260725005804.373698-2-inochiama@gmail.com>
 <0d11de51-546a-42b6-80cb-8ca258389a17@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d11de51-546a-42b6-80cb-8ca258389a17@lunn.ch>

On Sat, Jul 25, 2026 at 05:57:42PM +0200, Andrew Lunn wrote:
> On Sat, Jul 25, 2026 at 08:58:02AM +0800, Inochi Amaoto wrote:
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
> 
> There was a patch recently from one of the DT Maintainers removing the
> -c22 compatible when there was a specific PHY ID. I did not look into
> why. Does this pass all the binding tool checks?
> 

Thanks for this mention, I have found the patch link.
https://lore.kernel.org/netdev/20260323194803.GA1241974-robh@kernel.org/

It seems like this patch is not merge at now, but I am fine to
send a new version for the incoming change.

Regards,
Inochi
