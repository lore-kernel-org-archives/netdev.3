Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202B3FA5DD
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534118; cv=none; b=AqToNR6AwhlLD1jKhFBksIW6z7t2PZiZeKRbzohwdUybE5bSlz0vp43SXo3H+4I7a4pEZhsxEanms+4gNGpMSwFPfe5+N1AHSFdgWSpPgbR+hHBLydsHdL9wG7Mmp75ZETX45/glYSrb9uoKZTIyCSz0DevczudnS//7rmQVFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534118; c=relaxed/simple;
	bh=wvoL/ARwz34r4zELAfhhtSWiVFqfCTHu90foqCKrMhc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPr7h+e6M1yQBIVqROX9CSVWA883H3JVNSRtWY/tpUzyI500bzKrFBonPpeTer2AcOQri5mwtkJBucmwwabA9aPVbSE4/3874qGhw/EiOhnANM5JcXT8jtOa4Ky8HNWEAjXNTyWvgsQAKok9bImJhZYz8mr2/Gu3cpnCOX8/Cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRZrBFhl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRZrBFhl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so17948535e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781534113; x=1782138913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xNzTJAzLpoj9UCkQ0S0Kema5FeZLkRTnD+aulM3+7ZM=;
        b=lRZrBFhlYuH6/KA3OV+795aqezI3io8TLzm+ZdNJFO68kw95Sqa1dO+fvXlkvLaFFB
         ojwST7fv8uDxRgUCOy3hPgU8VJ+CL+OT6076XNF9rVqSOYRFxIE/gm4Vb3FSIiwI+Xl+
         Hn9p/hp+QsSVmOnzZnGQ6XVA5+oWFQsDHgWLQeedKZr/+yUqY8HCdg1nTWmWUqmiezKf
         asYEbT09eNW8vWE5Vo+u7scyfRiZvi+00FqjIAj0eWhZY2Bq3hxujmEngYQ3DkhZWOwG
         izu6LScV/qxwzr6XDm8GGq3xEZN+iWJvZwAywpopvoVpEQGdPYE4zwm+2De2QputBpXf
         eSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781534113; x=1782138913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNzTJAzLpoj9UCkQ0S0Kema5FeZLkRTnD+aulM3+7ZM=;
        b=jDp2/+zjB9AXHjA26SxhlyjxhXU9mLRL0HfSexABZIQTd9AjlmV4feQZNafaSNk623
         1x0K+/J5R2ZsBSH/+L/9mhWj42LBvV7NAlU+2liY06EyuZfDGcYkdECQCbQrijl7z2cO
         vHL7mf6G9ruaOIPo3WH69mHhfralH5K/ZGO6th09iUPbycVl4miY856Ic+bPHJmoG/1+
         +8OoTy8VnSNoPXqT95wO4hMY8JUaSzRGOaRsc5UMGv0x6oRUZ9iB85fR0N7XZRN5YVRI
         k0YMUD9gXYQBKxu4wcY5I2dJ9TY2XRRPN426jvIbOEBw/bfNhmhc2OH1jgmBqI6oVMI3
         oy5g==
X-Forwarded-Encrypted: i=1; AFNElJ8x3xXRP/3liE6G2APzfB1ZjYEHmVfhY/HtiaefD+zDetbW3PYUCcWWSdxhFvlm7kNFlb73MXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDficG3ZWE2LkLJwFVUBp5pVA0dQhtHcD26SKQ8h89P/s7gorD
	++981HsBN1iGxkH27MhwyB69582agcmNE5MOwRCvH0qc/5JXzEtskwIR
X-Gm-Gg: Acq92OF9oBuG1/2DkTsBtQ+L9fSQXWABmEvQyVqMepX7Irf4VsNDjOTpai1+BbVzybS
	Q6Lu1FNJcIP6wRHJjtXD79hxuHqd6QMf5TK18wNyxMhXNY8rSLF/F5VRUmhgsAXIvMCgtHY1mi6
	MAzCp6rNFW7AmZUd85PElNPWKXc2evEvUr8e56P6NCeGfWpfD7wYcsWD65xovqOq9fjz5DIQsad
	DWnCt/ntlOmohWAxxwonHj4g2+27xd+mJbCxGonB01bbtC86+hfBtAWgXzwWVLWixWY+ck61XAr
	jgDFEZcHG3H4eI5VJCYu/Dx3Jc79vNcpeBovnjEsX4qWbxDfpr24aU0Nf0325jzcqdguZ/zNKtW
	LNn4rGTD54tn6wwDR9eE9/qxdihOsOOHUHw3MnMo1wvNwlW4wAbi/A48DeRW9KEsUKr6pRS0MXB
	Gju48vKcaagWHR3flyqQ/lRLeOQezGOjn3QgLcTZbzk3JJdwHJTMXJuQ==
X-Received: by 2002:a05:600c:3512:b0:491:9969:739d with SMTP id 5b1f17b1804b1-4922011393fmr148091175e9.29.1781534113065;
        Mon, 15 Jun 2026 07:35:13 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm35561117f8f.8.2026.06.15.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:35:12 -0700 (PDT)
Message-ID: <6a300da0.d5af3cef.1ca29d.19c4@mx.google.com>
X-Google-Original-Message-ID: <ajANmyh9gB9a8FGL@Ansuel-XPS.>
Date: Mon, 15 Jun 2026 16:35:07 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v7 05/12] net: phylink: support late PCS
 provider attach
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-6-ansuelsmth@gmail.com>
 <867a39de-ccc2-4dcf-be24-ab2542d20ab6@bootlin.com>
 <6a3007ce.73de60af.3a056d.d903@mx.google.com>
 <7702ac09-75fd-49de-8ad2-fceaa122b627@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7702ac09-75fd-49de-8ad2-fceaa122b627@bootlin.com>

On Mon, Jun 15, 2026 at 04:29:04PM +0200, Maxime Chevallier wrote:
> 
> 
> On 6/15/26 16:10, Christian Marangi wrote:
> > On Mon, Jun 15, 2026 at 04:07:03PM +0200, Maxime Chevallier wrote:
> >> Hi Christian,
> >>
> >> On 6/15/26 14:29, Christian Marangi wrote:
> >>> Add support for late PCS provider attachment to a phylink instance.
> >>> This works by creating a global notifier for the PCS provider and
> >>> making each phylink instance that makes use of fwnode subscribe to
> >>> this notifier.
> >>>
> >>> The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
> >>> a new PCS provider is added.
> >>>
> >>> phylink will then react to this event and will call the new function
> >>> fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
> >>> provided by the event is present in the pcs-handle property of the
> >>> phylink instance.
> >>>
> >>> If a related PCS is found, then such PCS is added to the phylink
> >>> instance PCS list.
> >>>
> >>> Then we link the PCS to the phylink instance and we refresh the supported
> >>> interfaces of the phylink instance.
> >>>
> >>> Finally we check if we are in a major_config_failed scenario and trigger
> >>> an interface reconfiguration in the next phylink resolve.
> >>>
> >>> In the example scenario where the link was previously torn down due to
> >>> removal of PCS, the link will be established again as the PCS came back
> >>> and is now available to phylink.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>
> >> [...]
> >>
> >>> @@ -2151,6 +2204,10 @@ void phylink_destroy(struct phylink *pl)
> >>>  	if (pl->link_gpio)
> >>>  		gpiod_put(pl->link_gpio);
> >>>  
> >>> +	/* Unregister notifier for late PCS attach */
> >>> +	if (pl->fwnode_pcs_nb.notifier_call)
> >>> +		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
> >>
> >> I wanted to try this out, but I get :
> >>
> >> drivers/net/phy/phylink.c:2218:17: error: implicit declaration of function ‘unregister_fwnode_pcs_notifier’; did you mean ‘register_fwnode_pcs_notifier’? [-Werror=implicit-function-declaration]
> >>  2218 |                 unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
> >>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>       |                 register_fwnode_pcs_notifier
> >>
> >> I guess you either need to stub this, or there's a missing Kconfig
> >> dependency somewhere
> >>
> > 
> > Hi yes if you want toi test just enable CONFIG_FWNODE_PCS. I forgot to add
> > the static declaration for unregister_fwnode_pcs_notifier. 
> 
> I'll give it a go with this yeah, I have a few devices here I'd like to
> try this on.
> 
> Can you CC me for the next rounds ?
> 

Sure, if you can would be good to check also the other commit if everything
is logically correct.

BTW by checking test from patchwork I can see also another fix is needed if
you want to test this revision.

phylink_create()

-if (config->num_possible_pcs && pl->mac_ops->mac_select_pcs) {
+if (config->num_possible_pcs && mac_ops->mac_select_pcs) {

Aside from these change I expect the current legacy code to be not
affected by these change.

-- 
	Ansuel
