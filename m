Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589B19D07A;
	Tue, 16 Jun 2026 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781568923; cv=none; b=QSgQGtPY5QjO/bAfMufLPev84rllEkAP/6ocKToJZFySIzPwo4pN59jlCBJlemYFhtTNuO18So9OoKb4jxIhzbuvcM5hAy5OdD/mJhtK6reD142vN/K20NqtoEc77Zlxm5GY/UMXZ6iHIfzrKTZRV9qr2a3yxD8LeLSMTZAJaFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781568923; c=relaxed/simple;
	bh=nAJovhwBTVkTiFEcITJJg8ZhgJaJExeRuwFj8cl0msA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4FlrRIOealJM7h24+hf+sbuBbgHtam2cX4DkRvb8nRvUSK4iHrUQQn0dFIrHAjCkuhkqhwKvCJX1juSMTEGZMTleuN2cR5dlnqpvPC+l/NWeRenk3foyLsOccqRhrLBWlL3LXPL/MGBataQTNvo7AOqVLXNl9eHcQO3ef59z50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+q5pju7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+q5pju7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DC11F000E9;
	Tue, 16 Jun 2026 00:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781568922;
	bh=WzApdNind1Co5Xbcn1rQaSPzEq7He8P/6Dkl73QhY40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T+q5pju7LWkXd6Y1SVay308qFKHCSGXe8YQWAXzQQLRhoLNOLXzV1F73822ZYC85z
	 IlLlAvhIYmnN2QcfASlc1yAUZBKFXbPxLRFkLNMQIP75jyeBK17y/t+KCYA92cfKLG
	 EsciXIYoR4P/Eg+1zcRDmKU3MCSWZICwYbbZw7RXTy5UYG+RHOWq5Ar2qa0LOSCFdr
	 hVM8Ensq68LbFj1dR0BQNVGO2Gw4mqnJAwZU84AxQ3b0Cae7bYWTqpkNcF6xO0aEqM
	 8tV3Ffsx2SGbMKO4SVbFHPsPUX4WSq/XHLwt1FSiQgs1nIeRVj08Z+NTxrMc6Hg3Lt
	 giATJZ4GSttxQ==
Date: Mon, 15 Jun 2026 17:15:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: daniel@makrotopia.org
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 5/8] net: dsa: mt7530: replace mt7530_read
 with regmap_read
Message-ID: <20260615171521.60d93bf1@kernel.org>
In-Reply-To: <20260615235649.1060736-1-kuba@kernel.org>
References: <c6fc9cfae9762bf8d8a136339c91d4a76a307355.1781312667.git.daniel@makrotopia.org>
	<20260615235649.1060736-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 16:56:49 -0700 Jakub Kicinski wrote:
> >  static u32
> > -mt7530_read(struct mt7530_priv *priv, u32 reg)
> > +mt7530_mii_poll(struct mt7530_dummy_poll *p)
> >  {
> > -	int ret;
> >  	u32 val;
> >  
> > -	ret = regmap_read(priv->regmap, reg, &val);
> > -	if (ret) {
> > -		WARN_ON_ONCE(1);
> > -		dev_err(priv->dev,
> > -			"failed to read mt7530 register\n");
> > -		return 0;
> > -	}
> > +	regmap_read(p->priv->regmap, p->reg, &val);
> >  
> >  	return val;
> >  }  
> 
> [Medium]
> The old wrapper guaranteed val == 0 on failure. The new mt7530_mii_poll()
> declares val without an initializer and ignores the regmap_read() return
> code, so on a failed underlying transfer val is whatever was on the stack.
> 
> Looking at drivers/net/dsa/mt7530-mdio.c::mt7530_regmap_read():
> 
>     ret = bus->write(bus, priv->mdiodev->addr, 0x1f, page);
>     if (ret < 0)
>         return ret;
> 
>     lo = bus->read(bus, priv->mdiodev->addr, r);
>     hi = bus->read(bus, priv->mdiodev->addr, 0x10);
> 
>     *val = (hi << 16) | (lo & 0xffff);

This looks legit, AFAICT, sadly.

Maybe just write *val = 0; in mt7530_regmap_read() unconditionally ?
