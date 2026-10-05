Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B534DB56;
	Mon,  5 Oct 2026 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185958; cv=none; b=E3jSs+3rnKfH48OOzhfomkr4TFETA8TP+QK+R2bcIZAe+/07g1CenLcdlGL61g01DYXciYDkLLziOca/sp9SW6icZWEamG9sP9rPlBdvcQ3eLxlo/V7AW67lNsoCra+ijj1xxWjTjbWH8zZE5K6frCtv2H7de0AqsSrOlrD0ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185958; c=relaxed/simple;
	bh=FBHakGryps74VWRpsW6RxcIjv8H+CCla+beRxFON5q4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucwldsXgaP3uz5uGm7AjwgUqFQcfB4mT7WtS0PjVs72QCIW2I38i19aADKaUk/D8OHyzKQQc1zFHPniSUWbbYnlt/++K1D/IhWNkBn4JdtuWS1ihhxI2YsYs02qHUeiSEMnJpIb9wsiZQGkBrHV9NCbPbPLz57qPbYRGjewCwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWVxXrB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWVxXrB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8151F000FF;
	Mon,  5 Oct 2026 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791185956;
	bh=q4QkilO6Wz+2Ci6IB2te9amWlWhgHlAM/4zp+BDg/wk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gWVxXrB4vWKt2NL98LWTejrQIsuv3XFHuqspjad15iV90xAgJN0Ukr3XY6OF3jAMR
	 DbPnEBTB2d0L0r096T09v1mWyhoBibHsO73bSYXEjiz4lAMiwWJ2Ho5tLnuPdNinA5
	 BnNgxmjQ/4DAAQotURFkU9IgayQSgOewraipPFy8R6h+m/TV9Etdh4kn2ZzRtlGeds
	 iMMQAA1wvYGLvGGau3k8qAndBAibSxvNte/4NqpRTas2DkEy/0CfW1At7l6Xdxn2XZ
	 fdJ9qMrfDNQdXJvWTwN2l0Fh6V2nuOLpN0XiMK94cpmBjE54ff1eyjyoi0op3x4m/j
	 m7TwOKLCWQgjQ==
Subject: Re: [PATCH net] net: phylink: allow stopping a suspended instance
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 07:39:15 +0000
Message-ID: <179118595534.434549.13886697155302109114@kernel.org>
In-Reply-To:
 <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
References:
 <20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch does not handle the state where
  PHYLINK_DISABLE_STOPPED and PHYLINK_DISABLE_MAC_WOL are both set.

--

net: phylink: allow stopping a suspended instance

This patch lets drivers call phylink_stop() on a suspended phylink
instance after a failed MAC resume. For MAC WoL it finishes the deferred
link-down and clears PHYLINK_DISABLE_MAC_WOL. It also keeps the saved
link state when MAC WoL suspend is repeated, and tracks suspend-time PHY
speed-down separately.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 1bbcf46c83566..08f06ae5213fa 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -2509,11 +2518,30 @@ EXPORT_SYMBOL_GPL(phylink_start);
>   *
>   * This will synchronously bring down the link if the link is not already
>   * down (in other words, it will trigger a mac_link_down() method call.)
> + * A suspended instance may be stopped without first calling phylink_resume().
> + * In particular, closing a device after a failed resume must not restart the
> + * link or reconfigure the MAC just to finish shutting it down.

[ ... ]

>  void phylink_stop(struct phylink *pl)
>  {
>  	ASSERT_RTNL();
>  
> +	/* Also undo PHY speed control when terminating a suspended instance. */
> +	phylink_restore_suspend_speed(pl);
> +
> +	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state)) {
> +		/* A failed MAC resume may have called phylink_prepare_resume()
> +		 * and powered the stopped PHY back up to supply its RX clock.
> +		 */
> +		if (pl->phydev)
> +			phy_suspend(pl->phydev);
> +		return;
> +	}
> +
>  	if (pl->sfp_bus)
>  		sfp_upstream_stop(pl->sfp_bus);
>  	if (pl->phydev)
> @@ -2526,6 +2554,16 @@ void phylink_stop(struct phylink *pl)
>  
>  	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
>  
> +	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
> +		/* Finish the link-down deferred by MAC WoL, without restarting. */
> +		flush_work(&pl->resolve);
> +		mutex_lock(&pl->state_mutex);
> +		if (pl->suspend_link_up)
> +			phylink_link_down(pl);
> +		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
> +		mutex_unlock(&pl->state_mutex);
> +	}
> +

[Severity: Medium]
What happens when PHYLINK_DISABLE_STOPPED and PHYLINK_DISABLE_MAC_WOL
are both set?

phylink_suspend() takes the MAC WoL branch without checking
PHYLINK_DISABLE_STOPPED, so this sequence looks possible:

  phylink_suspend(pl, false)   /* non-WoL, phylink_stop() sets STOPPED */
  <MAC resume fails before phylink_resume() is called>
  phylink_suspend(pl, true)    /* MAC WoL, sets MAC_WOL */

At that point suspend_link_up is false, because the carrier is already
off.

If phylink_stop() is called next, the new STOPPED early return runs
before the MAC_WOL block above. That block is the only place that clears
PHYLINK_DISABLE_MAC_WOL, so the bit survives the stop. The next
phylink_start() only clears STOPPED:

  phylink_start()
    phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED)
      phylink_run_resolve()
        if (!pl->phylink_disable_state)
            queue_work(system_power_efficient_wq, &pl->resolve);

Does this leave the resolver gated, so the link stays down until another
stop/start cycle?

If phylink_resume() is called instead, it takes the MAC_WOL branch. It
calls phylink_mac_initial_config() and clears only MAC_WOL.
phylink_start() never runs, so STOPPED stays set, phy_start() and
sfp_upstream_start() are skipped, and the resolver stays gated. This
patch doesn't change that part of phylink_resume(). Still, the patch is
meant to make re-suspend and stop after a failed resume behave
correctly.

fbnic looks like it can reach this. fbnic_stop() passes a firmware
derived value as mac_wol:

  phylink_suspend(fbn->phylink, fbnic_bmc_present(fbn->fbd));

The BMC presence is re-read from firmware during resume, before
__fbnic_open() runs. So the mode can change between a failed resume (for
example, fbnic_mac_request_irq() failing) and the next suspend. Since
fbnic only uses phylink_suspend() and phylink_resume(), the link could
stay down across open/close cycles while fbnic_bmc_present() stays true.

For stmmac (stmmac_resume() failing in stmmac_hw_setup()) and ucc_geth,
ethtool rejects WoL changes with -ENODEV while the device is detached. So
the mode change seems harder to hit on those drivers.

The new kernel-doc says "A suspended instance may be stopped without
first calling phylink_resume()". The commit message says "For MAC WoL,
finish the deferred link-down and clear the WoL disable bit".

Should the STOPPED early return also handle a pending
PHYLINK_DISABLE_MAC_WOL? Separately, should phylink_suspend() avoid
setting MAC_WOL on an instance that is already stopped, or should
phylink_resume() fall back to phylink_start() in that case?

>  	pl->pcs_state = PCS_STATE_DOWN;
>  
>  	phylink_pcs_disable(pl->pcs);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-submit-phylink-suspended-stop-v1-v1-1-0669fdb4a93b%40gmail.com
