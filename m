Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C43F787F
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532626; cv=none; b=YjqjBeOML1a2UeqoXqZ8MO/YmB+R3UUfRebvuYjTrHPQki52odgyX8qPFIxspuRZ3EaFE6EWhWyGY5ztXn3aF/1XSeZXRSOBGAGDhgVT32hJu4Wk/1oriI1ohQ0cQnureMlx4XnvGBIWiH3beMMXAKrQ0KaySxSkWJdxQHnKOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532626; c=relaxed/simple;
	bh=ojL5AP8L6WG+T+j3AGHlDG/e4NEUksF2lsjngZpxUA4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5rToh/NEt8jEooXCanPGduEAgORZv+X+eAYZPVSesqjf3K2pidu/8LyVrUuxMXa/tiTKOMn9cU01Myw+Djya+rIB3cSt+725pKTL3KCU/Kz4FJkUcDRlC5k85IUfi45O4bt6AoNgkR85OGtNtOq2qugcgmaiYMuLazJXXjqLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoXGpswi; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoXGpswi"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b3e03939so25360395e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781532623; x=1782137423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/bfZlkIthONZwal+BuFPrR21tTmL0QJZVmWIFcUsNk=;
        b=hoXGpswizDp9LdjJ4b60adwIq1atMp0r3uIG6tQk/L2MQ/Aevw7kUYudKkqShH9ERO
         YvE4EkDtvboasGDFn6dr9vA31bZYNGdbI+Tvwgn7ntnqhfojDkOoSoNvjvmMfzFkA0mx
         c+aNbSWhkr+1VtBFdiJHts8gePM0fUJuzsLe/jiGJrLhKzQraci4EtjCC+3rapmuUTpU
         9t9FG2HsUqBrvKd6TTF06vEkI88puyb7mbO4rs69Ay5hJnjZmoLHNY84isOFWiAc+jht
         I/Zsq1MTwIPOCAkwcJSdDkJsh0ZnaD31pQvlmZlUnFPydRCk03sFLX9dAUSKDPpsecct
         ZAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532623; x=1782137423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/bfZlkIthONZwal+BuFPrR21tTmL0QJZVmWIFcUsNk=;
        b=BTXjT5J3F3vYnfuIIIRBWVfvY0O7PwXbGG97C6IxowZZRmxaa6/RDq9kdsa5jk0Fu5
         50SLOoNU3RaccilRhFhX7YkPR2VZ5ggKB20DoyMQELGhchqoeMXMxVR/ALjr2S77mwKA
         mE1jbacYTRJsDTmhuLNxeS4KNL4XNlPdwQqblZ7eub+UGVRPg/e2z0yx7ndomZqZeebo
         IxqYHP8rev7Ki4MZg/mQBrrd56dBPkz5S6I4KJlaV+YC/goeUdEqMjrxfIbaCtFRUAQS
         7EbaCytiAji8irv5d2j5jlM7N1bzHpqzo17l3ONnKGRHubWgRC02IV9YLxcSdmx71/hI
         8wJA==
X-Forwarded-Encrypted: i=1; AFNElJ/P9IulnMNlvSDPT2hVbVK33qwgDBCrkeyB8XxhUI3SjJHUOfvjjr0frh1H4aycdOw22VyzcdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpjXzjhhIdKY7/fAmHo91nrHEHTE5ewedKZKMIIxSimKqB49G
	96TufNTFnxzRegfUjmwl8tiGtvjlHYJGwfQPmiAcoPuaMxpYSQC7YHrE
X-Gm-Gg: Acq92OED6FTua++4RdavCp38EgWgOjkXozLnXVafqXnazmmxanTY9t37L0pv178nPOE
	GUyPeV6Tmg747ocxkpgOmYGifDMcfL1uSJlQPVSn7QzHn98IS8bkiaqnoOK2j6ODeHmvbLycAsi
	KDaxPj2DYN8nntDLDP06s1etqXYXal89hOJ8NIgNMr3OHSWGfEr9ev37inpg4Cl6rtKk29ibRj7
	78urEnYFmZ2cujZ1Ag/9f/5BUe6hOd2DS5abeayZbXlsmWt4Q6baW+5xvX7uRa7yDEizsq6QJyb
	3uHpZyMbYCX6dL09hdEJAOMBm4t0LHSnO0eVrzNxqJR95yDiFAoMLZyZED0GQf+qcyr9QDp79ga
	ygWo5mkQZCn1veXcw0llBmUcg1I6yO7TvCCBDZTRMNPnqHUjCZKLK/wR/uOcUEqnJzA7B4Ho1IG
	SQmyDPNlFedqpwR65WJv59ElfVyKoqDSxCALZ9QiFMhTrIw6AMXISQEw==
X-Received: by 2002:a05:600c:1912:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-490ec30f6aamr146216505e9.0.1781532623124;
        Mon, 15 Jun 2026 07:10:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea9563b8sm223213855e9.2.2026.06.15.07.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:10:22 -0700 (PDT)
Message-ID: <6a3007ce.73de60af.3a056d.d903@mx.google.com>
X-Google-Original-Message-ID: <ajAHynRJ1jnbycam@Ansuel-XPS.>
Date: Mon, 15 Jun 2026 16:10:18 +0200
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <867a39de-ccc2-4dcf-be24-ab2542d20ab6@bootlin.com>

On Mon, Jun 15, 2026 at 04:07:03PM +0200, Maxime Chevallier wrote:
> Hi Christian,
> 
> On 6/15/26 14:29, Christian Marangi wrote:
> > Add support for late PCS provider attachment to a phylink instance.
> > This works by creating a global notifier for the PCS provider and
> > making each phylink instance that makes use of fwnode subscribe to
> > this notifier.
> > 
> > The PCS notifier will emit the event FWNODE_PCS_PROVIDER_ADD every time
> > a new PCS provider is added.
> > 
> > phylink will then react to this event and will call the new function
> > fwnode_phylink_pcs_get_from_fwnode() that will check if the PCS fwnode
> > provided by the event is present in the pcs-handle property of the
> > phylink instance.
> > 
> > If a related PCS is found, then such PCS is added to the phylink
> > instance PCS list.
> > 
> > Then we link the PCS to the phylink instance and we refresh the supported
> > interfaces of the phylink instance.
> > 
> > Finally we check if we are in a major_config_failed scenario and trigger
> > an interface reconfiguration in the next phylink resolve.
> > 
> > In the example scenario where the link was previously torn down due to
> > removal of PCS, the link will be established again as the PCS came back
> > and is now available to phylink.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> 
> [...]
> 
> > @@ -2151,6 +2204,10 @@ void phylink_destroy(struct phylink *pl)
> >  	if (pl->link_gpio)
> >  		gpiod_put(pl->link_gpio);
> >  
> > +	/* Unregister notifier for late PCS attach */
> > +	if (pl->fwnode_pcs_nb.notifier_call)
> > +		unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
> 
> I wanted to try this out, but I get :
> 
> drivers/net/phy/phylink.c:2218:17: error: implicit declaration of function ‘unregister_fwnode_pcs_notifier’; did you mean ‘register_fwnode_pcs_notifier’? [-Werror=implicit-function-declaration]
>  2218 |                 unregister_fwnode_pcs_notifier(&pl->fwnode_pcs_nb);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                 register_fwnode_pcs_notifier
> 
> I guess you either need to stub this, or there's a missing Kconfig
> dependency somewhere
>

Hi yes if you want toi test just enable CONFIG_FWNODE_PCS. I forgot to add
the static declaration for unregister_fwnode_pcs_notifier. 

-- 
	Ansuel
