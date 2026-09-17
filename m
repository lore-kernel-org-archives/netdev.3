Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E994EFFCE;
	Thu, 17 Sep 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680293; cv=none; b=kN9uYSCeMYd9moo/0fGXFsYUDx3Cj8C+Z+8tIHHFT4dRtsRmitQPzXenZ4o9hVKSa+440iloEds6ysGwAAqS2RUY25A2Zm1xs7tDd2NKWejD5nu+o350vjHAnbzWgBgmvfgKVa3WVbn/7s4N0TJGC2GLEW3ZAN3yyko5d+cdXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680293; c=relaxed/simple;
	bh=P8voqwId4Gda+5U2KPBBLwsnhgv+Zhy9VZZz81W0Osg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REpk8DcizfdIUhmZh8tusvEd3p5Su6hYoSCzh8Oe9+s7FPZXSWzunY3b0TgOInyuCWNONyrGn7LdAZqs7fOgeGXXEQVImPqri+haG4taW8DmP2vxvYIs8Hqdr0hLSEaVLo0Y/L3Nd1HkPbeL7iT8y0lsyi5GTh8cRV2QUu7k7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNnIGdKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNnIGdKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F51F00893;
	Thu, 17 Sep 2026 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680291;
	bh=N6R9pMOaRwb2THfN4DreUB5DADY2TM0zL/rqkrabrhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WNnIGdKNZt/MlrSHkibOnjiMJbQwsY4qxGh6XHQ8eaifqtkiVCXfJu/EHmvkQOQQC
	 r8jMgQfyc/RjumtkiEIhkGmjYot5ruprN65ukaIJrew9EHUvbhDf4dRxNgfKIOJfb+
	 nL6tJki8V6bqtKk1TmzdEPzfPZTOY7l3az19LGeG1EeTkowLG6VfhniPPdM4Abf2Id
	 p9AfJ5eGbGQe4HTMHHiFAIdRwItiirE/EcCcVKV78BiTz+zPEqovDrBO9cHvvdQYSL
	 G4G3qWPuIR5+AtaK6w7e/ZOtCCg6phqwuC0VY/y8N9jKz47qX0cVljBf4JWCIAsgkJ
	 0+/bVlsZvvC6g==
Subject: Re: [PATCH net-next v12 01/15] phylink: Add phylink_mac_interrupt
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:50 +0000
Message-ID: <178968029017.22033.2874254681410388676@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] `phylink_mac_interrupt()`
  (drivers/net/phy/phylink.c:1621-1628) reads `pl->phydev` with no…
- [Low] Claim that the newly exported `phylink_mac_interrupt()`
  (drivers/net/phy/phylink.c) and its prototype…

--

phylink: Add phylink_mac_interrupt

This adds an exported phylink_mac_interrupt() helper which forwards a
link-change interrupt received by the MAC to phylib by calling
phy_mac_interrupt() on pl->phydev.  It is intended for drivers that want to
avoid polling the PHY.

(no Link: tags in the commit header)

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 3ec3bb4391095..96ed13458e9f3 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1612,6 +1612,22 @@ static bool phylink_link_is_up(struct phylink *pl)
>  	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
>  }
>  
> +/**
> + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
> + * @pl: a pointer to a &struct phylink returned from phylink_create()
> + *
> + * Passes a link-change interrupt received by the MAC to phylib.
> + */
> +void phylink_mac_interrupt(struct phylink *pl)
> +{
> +	struct phy_device *phy;
> +
> +	phy = pl->phydev;
> +	if (phy)
> +		phy_mac_interrupt(phy);
> +}
> +EXPORT_SYMBOL_GPL(phylink_mac_interrupt);

[Severity: Medium]
Is the unsynchronized read of pl->phydev here safe?  Every other reader of
that field in phylink.c is serialized, and the struct member carries the
comment describing that rule:

	/* Serialize updates to pl->phydev with phylink_resolve() */
	struct mutex phydev_mutex;

phylink_resolve() and phylink_bringup_phy() take pl->phydev_mutex, and the
ethtool/ioctl/phylink_speed_up()/phylink_speed_down() readers run under
ASSERT_RTNL().  Since this new helper is documented as being called from a
MAC link-change interrupt, it can take neither the mutex nor RTNL, and the
signature (struct phylink * only) gives the caller no way to pin the
phy_device across the call.

Can this race with teardown?  phylink_disconnect_phy() is the only writer
that clears the pointer:

drivers/net/phy/phylink.c:phylink_disconnect_phy() {
	mutex_lock(&pl->phydev_mutex);
	phy = pl->phydev;
	if (phy) {
		...
		pl->phydev = NULL;
		...
	}
	mutex_unlock(&pl->phydev_mutex);

	if (phy) {
		flush_work(&pl->resolve);
		phy_disconnect(phy);
	}
}

So the sequence would be:

CPU0 (MAC link IRQ)
phylink_mac_interrupt()
	phy = pl->phydev;		/* latched */

CPU1 (RTNL)
phylink_disconnect_phy()
	pl->phydev = NULL;
	phy_disconnect(phy)		/* phy_stop_machine() ->
					   cancel_delayed_work_sync(
						&phydev->state_queue) */

CPU0 resumes
	phy_mac_interrupt(phy)
		phy_trigger_machine(phy)
			phy_queue_state_machine()
				mod_delayed_work(..., &phy->state_queue, ...)

Does that re-arm the PHY state machine work after the teardown path already
did its synchronous cancel, so the state machine runs on a detached phydev?

For an SFP cage the phy_device is also freed while the interface is still
up:

drivers/net/phy/sfp.c:sfp_sm_phy_detach() {
	sfp_remove_phy(sfp->sfp_bus);	/* -> phylink_sfp_disconnect_phy()
					   -> phylink_disconnect_phy() */
	phy_device_remove(sfp->mod_phy);
	phy_device_free(sfp->mod_phy);
	sfp->mod_phy = NULL;
}

Can the mod_delayed_work() above then write into the freed phy_device?

Separately, the load of pl->phydev is a plain access to a field written
under a mutex on another CPU.  Should this at least be READ_ONCE()?  As
written, nothing prevents the compiler from re-loading pl->phydev when
forming the call argument, which would make the "if (phy)" test useless and
pass NULL into phy_mac_interrupt() -> mod_delayed_work().

Would it make sense to either make pl->phydev lookup IRQ-safe (RCU with
deferred free, or hold a device reference), or to document in the kernel-doc
that the caller must quiesce its link interrupt before
phylink_disconnect_phy()/phylink_destroy()?  The added kernel-doc currently
states no calling context or lifetime contract.

> +
>  static void phylink_resolve(struct work_struct *w)
>  {
>  	struct phylink *pl = container_of(w, struct phylink, resolve);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
