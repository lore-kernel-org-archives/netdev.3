Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F33E49FE
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808846; cv=none; b=kdJAo2U6yHq9A2yEOUYWp1OcYp8qOy3bpdARoojmKzKFRhsotjg9je8ji21i6XMUOVocKGvlDM0svWWNOzaAxS2cRqx82826Eh4Avvzbnx2btwjHGSNNs/EXz8mBbqn0bk3BfcgX8NfDYo6kv26MKbMf+ESSuDwdCaKKnAzyZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808846; c=relaxed/simple;
	bh=yzwj7AAbh1KBoSfxBMNOGuNmk5+Gp6jmovCqoDSi+KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onVdcz1kSY7HURVSTTpRkm2vbNZZjUvdLVg6mPJEvD9ZGCjD0eJLwvXGKsO5fatSs75FpNGClmTKRqYy9yTkJHHT3KuLUrTF8p4AmUPxo9nmQHlxeTN6O/D0ZrUlGpcMPCdyws1jb6q0UxfD3r0QQOg+124OwS25YtVlsim5uDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDgNjstv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDgNjstv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90241F000E9;
	Tue,  4 Aug 2026 02:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785808845;
	bh=8jUoN8EsSINh9NULLJm88aCn6K/BxgWPO3wQyQX+kyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RDgNjstvoWyIVBwgIBS9LuASr7g8pFVPeqLgOUsXnvZXjZJjeP3Ox5nMghQgxe3xi
	 gyaHo8By+VdKbpviz0akkT7LiBIKvs8kdHeY8ocX7wW6FbZ/SHPhLDkNz1nDCy31Pj
	 GgkxtZcohIp67AlnIuSkZJX2RZuqG0DGekuhD9pyV38KciXTz28MiA7xaM0VQe4FxD
	 fW+nH+qNKPb2zdJtZPMf4XUE9l8XvZln7UrKe54dnvL5rNUFZOy+AdCk0xtiKVhibR
	 0xM/1QXXDuax0HdhS7TapUVXmhGbk4nZkHYp+3FLXXhLZghOqPbeScsBItY+UNuFBA
	 Zzv/nMmTJ5Jvg==
Date: Mon, 3 Aug 2026 19:00:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: andrew@lunn.ch, richardcochran@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v2] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <20260803190044.274355ea@kernel.org>
In-Reply-To: <20260730064451.32261-1-xuanqiang.luo@linux.dev>
References: <20260730064451.32261-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 14:44:51 +0800 xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
> removal handling") moved per-bus clock cleanup from module exit to the
> remove path. This leaves two lifetime problems.
> 
> dp83640_clock_get_bus() publishes a newly allocated clock before the
> driver allocates its per-PHY data and registers the PTP clock. If either
> operation fails, no PHY is bound and the remove callback cannot release
> the clock, leaking the clock, its pin configuration, and the MII bus
> device reference.
> 
> The remove path can also free a clock after dropping clock_lock. A
> concurrent probe may already have found the clock under
> phyter_clocks_lock and be waiting for clock_lock, allowing it to acquire
> a freed mutex and access the freed clock.
> 
> Use the PHY package infrastructure for the per-bus clock. The package
> table is scoped to each MII bus and holds the shared object until the
> last joined PHY leaves. Serialize the one-time clock initialization with
> the bus shared lock because phy_package_probe_once() elects an
> initializer but does not wait for initialization to finish.
> 
> Manage both the package reference and the per-PHY state with devres.
> This is needed because dp83640_probe() may succeed before later PHY core
> initialization fails, and the driver remove callback is not called for
> that failure. Register the per-PHY cleanup action after the package
> reference so probe unwinding first unregisters the PTP clock or removes
> the PHY from the clock list, then releases the shared clock. Release the
> same action from the normal remove path.
> 
> Embed the pin configuration in the package private data so the final
> package leave releases all clock storage.
> 
> Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>

No need to add Suggested-by tags for review comments.
Only if the v1 was suggested by the person.

> +static int dp83640_probe(struct phy_device *phydev)
> +{
>  	struct dp83640_private *dp83640;
> +	struct dp83640_clock *clock;
>  	int err = -ENOMEM, i;
>  
>  	if (phydev->mdio.addr == BROADCAST_ADDR)
>  		return 0;
>  
> -	clock = dp83640_clock_get_bus(phydev->mdio.bus);
> -	if (!clock)
> +	err = devm_phy_package_join(&phydev->mdio.dev, phydev,
> +				    BROADCAST_ADDR, sizeof(*clock));
> +	if (err)
>  		goto no_clock;
>  
> +	clock = phy_package_get_priv(phydev);
> +	/* Ensure other PHY probes wait for shared clock initialization. */
> +	mutex_lock(&phydev->mdio.bus->shared_lock);
> +	if (phy_package_probe_once(phydev))
> +		dp83640_clock_init(clock);
> +	mutex_unlock(&phydev->mdio.bus->shared_lock);
> +
> +	mutex_lock(&clock->clock_lock);
> +
>  	dp83640 = kzalloc_obj(struct dp83640_private);
>  	if (!dp83640)

AI reviewer points out that this error path is now missing setting
the err variable. Please clean this up as part of your change.
Remove the init to -ENOMEM and have every goto x; path set err
if it needs to

>  		goto no_memory;
> @@ -1450,24 +1432,31 @@ static int dp83640_probe(struct phy_device *phydev)
>  	} else
>  		list_add_tail(&dp83640->list, &clock->phylist);
>  
> -	dp83640_clock_put(clock);
> +	mutex_unlock(&clock->clock_lock);
> +
> +	err = devm_add_action_or_reset(&phydev->mdio.dev,
> +				       dp83640_phy_release, dp83640);
> +	if (err)
> +		return err;
> +
>  	return 0;
>  
>  no_register:
>  	clock->chosen = NULL;
> +	clock->ptp_clock = NULL;
> +	phydev->default_timestamp = false;
> +	phydev->mii_ts = NULL;
> +	phydev->priv = NULL;
>  	kfree(dp83640);
>  no_memory:
> -	dp83640_clock_put(clock);
> +	mutex_unlock(&clock->clock_lock);
>  no_clock:
>  	return err;
>  }
>  
>  static void dp83640_remove(struct phy_device *phydev)
>  {
> -	struct dp83640_clock *clock;
> -	struct list_head *this, *next;
> -	struct dp83640_private *tmp, *dp83640 = phydev->priv;
> -	bool remove_clock = false;
> +	struct dp83640_private *dp83640 = phydev->priv;
>  
>  	if (phydev->mdio.addr == BROADCAST_ADDR)
>  		return;
> @@ -1475,43 +1464,8 @@ static void dp83640_remove(struct phy_device *phydev)
>  	phydev->mii_ts = NULL;
>  
>  	enable_status_frames(phydev, false);
> -	cancel_delayed_work_sync(&dp83640->ts_work);
> -
> -	skb_queue_purge(&dp83640->rx_queue);
> -	skb_queue_purge(&dp83640->tx_queue);
> -
> -	clock = dp83640_clock_get(dp83640->clock);
>  
> -	if (dp83640 == clock->chosen) {
> -		ptp_clock_unregister(clock->ptp_clock);
> -		clock->chosen = NULL;
> -	} else {
> -		list_for_each_safe(this, next, &clock->phylist) {
> -			tmp = list_entry(this, struct dp83640_private, list);
> -			if (tmp == dp83640) {
> -				list_del_init(&tmp->list);
> -				break;
> -			}
> -		}
> -	}
> -
> -	if (!clock->chosen && list_empty(&clock->phylist))
> -		remove_clock = true;
> -
> -	dp83640_clock_put(clock);
> -	kfree(dp83640);
> -
> -	if (remove_clock) {
> -		mutex_lock(&phyter_clocks_lock);
> -		list_del(&clock->list);
> -		mutex_unlock(&phyter_clocks_lock);
> -
> -		mutex_destroy(&clock->extreg_lock);
> -		mutex_destroy(&clock->clock_lock);
> -		put_device(&clock->bus->dev);
> -		kfree(clock->caps.pin_config);
> -		kfree(clock);
> -	}
> +	devm_release_action(&phydev->mdio.dev, dp83640_phy_release, dp83640);

Why the explicit call? if you're using devm_ you should let it handle
the unwind.. If you want to have an explicit call, don't use dev_ APIs.
-- 
pw-bot: cr

