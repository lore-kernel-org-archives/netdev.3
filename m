Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4753282F3F;
	Wed, 29 Apr 2026 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777506917; cv=none; b=gbgk5j8MBKLmqZS/i8AV6QwoPxXOxrS0yBdaXqzf8idA2x+0pNIWew06KBOkiaCjx1MDkA/nnoUjZZTYqzEJdNFLlLluPmGqZ9C0UmCa21hMitq2fACHew1nYso7wQIBt3MRx6T+S6BeEvTSBse9/+DPN26hZFWKaENxsLZAC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777506917; c=relaxed/simple;
	bh=kPqGOE/GUeX9gbFD4GiuiOB0UrYWSUXfAmNqgI/Ip6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxGMMbamZVyB8NGU8j+66E9rVrxzjZbdHA+r2EoWSvkpKmxz2Z1HUljv4jrWUXgfoDLM4bVLGpeJLkLr+l4Ew+uRCS4lxZmyJxIRb4F2VA+6TCD3C6eVtJpiEXmBdy/MreRqxdknUCUAqaA8lqXkqfXMvGLdLju9F6EO627voHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wIEkC-000000005vx-440e;
	Wed, 29 Apr 2026 23:55:05 +0000
Date: Thu, 30 Apr 2026 00:55:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: chester.a.unal@arinc9.com, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v4] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <afKaVQ27GUQiWZTb@makrotopia.org>
References: <16efd278e4f17776ccfbf8491e5be71a4689c137.1777385305.git.daniel@makrotopia.org>
 <20260429234612.2240476-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429234612.2240476-2-kuba@kernel.org>

On Wed, Apr 29, 2026 at 04:46:13PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: mt7530: fix .get_stats64 sleeping in atomic context
> 
> This commit introduces a delayed workqueue to asynchronously poll MIB counters
> for MDIO-connected switches. This caches the results so they can be returned
> safely without sleeping in the atomic .get_stats64 callback.
> 
> > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > index b9423389c2ef..66bff861a921 100644
> > --- a/drivers/net/dsa/mt7530.c
> > +++ b/drivers/net/dsa/mt7530.c
> 
> [ ... ]
> 
> > @@ -3137,9 +3187,25 @@ mt753x_setup(struct dsa_switch *ds)
> >  	if (ret && priv->irq_domain)
> >  		mt7530_free_mdio_irq(priv);
> >  
> > +	if (!ret && priv->bus) {
> > +		spin_lock_init(&priv->stats_lock);
> > +		INIT_DELAYED_WORK(&priv->stats_work, mt7530_stats_poll);
> > +		mt7530_stats_refresh(priv);
> > +		schedule_delayed_work(&priv->stats_work,
> > +				      MT7530_STATS_POLL_INTERVAL);
> > +	}
> > +
> >  	return ret;
> >  }
> 
> [ ... ]
> 
> > @@ -3409,6 +3476,9 @@ mt7530_remove_common(struct mt7530_priv *priv)
> >  
> >  	dsa_unregister_switch(priv->ds);
> >  
> > +	if (priv->bus)
> > +		cancel_delayed_work_sync(&priv->stats_work);
> 
> Could this call cancel_delayed_work_sync() on an uninitialized work struct
> if the driver is unbound before the DSA switch tree completes?
> 
> The priv->bus pointer is initialized during probe. However,
> INIT_DELAYED_WORK() is only called in mt753x_setup(), which might never
> execute if the DSA tree remains incomplete.
> 
> If the driver is unbound in this state, mt7530_remove_common() will evaluate
> priv->bus as true and pass a zero-initialized work struct to
> cancel_delayed_work_sync(). This usually triggers lockdep ("trying to
> register non-static key") and debugobjects ("assert_init not available")
> warnings.
> 
> Would it be better to move the INIT_DELAYED_WORK() call into the probe
> path or track whether the setup function was actually completed?

Not sure if this is real. The fix could be simply

	if (priv->bus && priv->ds->setup)
		cancel_delayed_work_sync(&priv->stats_work);

Anyone?
