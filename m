Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187F3D9533
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786309186; cv=none; b=NIZmieYAdoxKJgjuIN0Q1oKj2/hyZ/C8mzQD9IxlMxv0NEE17XevhDuGMGom1MDcLJhRJxJhnyJtvimQbCney8MBv7wmxZiTb2aquHaIoOM4y4NGEz+7jWbld3HbVRtqjQvlYmoZcScWZSHj4xKVAINlgEWuW/q5y/BHWcGuJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786309186; c=relaxed/simple;
	bh=yP48NfBQNo4R0PchtDbozjKoJ2iHh4aYKSNN83OczTE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RecY41adebbcV5COnQrFBD47mHuMHfkUIRmC67aPKlJCJ0azPRKe1lImn0QTnWxP7DPrxIOA8oXOX1Nx9e+Y3AndR3MH/qpZS+F81t4gJCRLoWH3PCTvpqBdA6cq1HTTdkzcyUzTw7NLl8fP5WHl3sJzc1dnsFdWirmAM2hv8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxNwN1ww; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxNwN1ww"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so657565f8f.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786309181; x=1786913981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vO4zsqd6+CKiqzXBlsgszWemmLXQdGd/m+GIX3H8Vzs=;
        b=KxNwN1wwdMSi+lPudeW+FJ7QhaKt1A+yYoaNtUZaHLTZby9Yk9yLeVqz6I4gJGer5w
         BmDDqAnZPHg/QSd9BY2d0uHN89/rmrIKm3PA+FbUVlFocc7fBsaBnkfutKs7J3eGsnKS
         tRl67spqpd8u5JCywuhHTozcv8vRUlWHg6SUFd3g/WSSd93Q6B4dhCxB8a3t4VblEt8g
         rAZsmUzO+dz6dr0ygidJ69E7TnyHt6/kROsr1BTLiXPVA2B4X48NnpAtDaYTdeQPn3h/
         IthNM21IxIk5r3O64LWpnT4IbL0wuKI6Yyji03Ra7DxHiw1YBTFli2G09GamGDHi5ffK
         0w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786309181; x=1786913981;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vO4zsqd6+CKiqzXBlsgszWemmLXQdGd/m+GIX3H8Vzs=;
        b=sRoQ7Ec6nmNks2W2sEV4cc8XOX4lEiyNBT9CcYooJjb/IrgnLXAF+E3CGMr8cwbqow
         AwO0NFN97Pai9ZEzyCD+gLM3Mh3LzN6ZqEY4mEhXk1Xmv8Pkmlp2QmcYvzwCG5A5indb
         FHsGiOYHh61VoikNEsFiU6ZYZ6QMrCWOyjHW+eIB9U58lqlUW5yBijS6kGHQX5D/9VZK
         pPqVm97vD86p4S//ojgjvb/fzEUrV9fZtgNwTB2Ht0DKfJQFYU1phdu71bOoLmBNSxvK
         tjSI0ORsHaWTSG/MW1qOK0WqabJw4QuI0zJOMIyV2c6/XitmETvDElYTM/waXO2l/LNu
         XFbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpcMboOz7XerlF71nlglCVa3c5Q9TXPsMd3XBJP48czRGUD8bsI3GJFxDsuYXxzgydOSATHt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCS97H7rJvUzdxRDvLvQPT80zpWgjQHcbiu/yj4gauHpVmxJf
	P+935mm20b4yG+NxuvPrnpT2D+dfjMjygl7Iv+vV/kCEwf51xxjyb/A7
X-Gm-Gg: AR+sD10wTJexCwJ1iZ1sFKjmZXRqoEgE42Vmv/0ZtwDoqknUXmJ2JmucQJAbfU33YKM
	jTnldSP2WQjlBzajDXC2wEXWKXNjciHK2bAvFvI7HFFvw55FQ8j1tSigPNnEia9bg+fmjEu6mPe
	gVGUbtaZP1EeJugZNViq/ymzOqFZTdq8aJg267yPDMyRzz3k1VNUfN1+Hl1QUHQj4hfTZc8Xv3M
	PxbLqM+tvmiuIO8bkRoSkdXwCJVauYByjzYdU8VbysdGOc0BnjnEHbxjwGa2SRkgl8H4TKw1dZJ
	FKjKNeZZ83Z9CtYpfKpyE84DhrJn5ZXtmiNG2FaX4tEh24ngZk4Fmpe+LZF41+wRJnpEyqp+St+
	Lzigbh3ZNm83G9BUKvxis5My9IqWjRLogLCxMTlSeBt+tfZf7S0vbZepXWeP+IodrhYRK0mRm1v
	Z4OPHMURLvKH3hjWSw3FgWOep+B8DdIOcovQQS7vua9i9zT6sKhuHovNsZRzNFuI3UoM7UwZaRC
	4rpGiEJaW/jh5VpaUNNX0/ZdgNhdf0=
X-Received: by 2002:a05:6000:2006:b0:480:c5:d635 with SMTP id ffacd0b85a97d-48000c5d6d9mr30371840f8f.0.1786309181299;
        Sun, 09 Aug 2026 13:59:41 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220a6d9sm30149581f8f.34.2026.08.09.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:59:40 -0700 (PDT)
Message-ID: <6a78ea3c.be490abf.cfd7.7505@mx.google.com>
X-Google-Original-Message-ID: <anjqOJWkUJvo6Wsi@Ansuel-XPS.>
Date: Sun, 9 Aug 2026 22:59:36 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v11 00/12] net: pcs: Introduce support for
 fwnode PCS
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
 <4c595c15-17d9-4c23-bb44-344c48d36e9a@lunn.ch>
 <6a78bdc6.89544747.3fcae.b8e0@mx.google.com>
 <f9151481-7dcf-4c9e-9507-7eb0c217851d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9151481-7dcf-4c9e-9507-7eb0c217851d@lunn.ch>

On Sun, Aug 09, 2026 at 10:43:27PM +0200, Andrew Lunn wrote:
> > I think the most annoying one will be stmmac with the 3 different PCS
> > implementation but we already handled that in a upcoming ipq50xx driver
> > currently present in OpenWrt mainline.
> 
> stmmac is always annoying :-(
> 
> If this can make it more uniform, make internal and external PCS look
> the same, that would be great.
> 
>

I posted v12 that should smooth stuff even more. I think I found a good way
with the notifier approach.
 
> > @@ -6808,7 +6792,10 @@ static void mvpp2_acpi_start(struct mvpp2_port *port)
> >         };
> >         struct phylink_pcs *pcs;
> > 
> > -       pcs = mvpp2_select_pcs(&port->phylink_config, port->phy_interface);
> > +       if (mvpp2_is_xlg(port->phy_interface))
> > +               pcs = &port->pcs_xlg;
> > +       else
> > +               pcs = &port->pcs_gmac;
> 
> I thought the point of new API was that phylink picked the PCS. Why
> this if? Why not register both and let phylink pick?
> 

Yep I'm not sure of this... If they expose different interface mode then
both can be provided at the same time. I think it was done to reduce the
logic difference and patch delta to the minimum.

> > +static int mvpp2_port_fill_pcs(struct phylink_config *config,
> > +                              struct phylink_pcs **available_pcs,
> > +                              unsigned int num_possible_pcs)
> > +{
> > +       struct mvpp2_port *port = mvpp2_phylink_to_port(config);
> > +
> > +       available_pcs[0] = &port->pcs_gmac;
> > +
> > +       if (mvpp2_port_supports_xlg(port)) {
> > +               if (num_possible_pcs < 2)
> > +                       return -EINVAL;
> 
> This seems like defensive programming. If we said there was two, we
> should assume available_pcs has room for two. I would not even pass
> int num_possible_pcs as a parameter.
> 

Yes the if is redundant. The phylink core code ALWAYS allocate based on the
phylink_config value. The num_possible is just as a validation value of
what the space allocated in available_pcs.

If everyone is ok I can change and include this in the series.

-- 
	Ansuel
