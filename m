Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821249504E;
	Sun, 18 Oct 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792324937; cv=none; b=Gxh04US4PS/GkvlXKWO/9tH+3r+lpT6eUNRhrcXFqWVkqPt27Y7FgXhKif7s1ETqbFGK9R5s67BRTfUwGLRsQ+MSBpwsbgAWUP3hRnqYhLSwJ4+I4ICCeUbzuaCjaZc+C0otGlKEnLfHqW8IqzWj0++fqZNF3RESEVjPfuKtUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792324937; c=relaxed/simple;
	bh=K8x3r/hkMwWzR5M3Nfx4xxYwSdZwq3KfSD8hgEAbTHU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=us+hPe8C2Nx/6CjK8995yS4bXw/7qCBtsndq18/gXkkveQX5TsaZuuEM3vHiuxO803cTNxpwXk7ZVSno1BJpYGof/TVM59/rAV0uroYInpE+CbObFPYCIsEq8aikKAofSmnyBac1gyKwhIsvZVs1Ito0g1d+k3Krfn3g3eL3qss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuQwA4Nx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuQwA4Nx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F0A1F000C4;
	Sun, 18 Oct 2026 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792324930;
	bh=UnxQWbmrHkwPD5U1GBrF6/x4QSu6Xjh1Z5PUhaHQGLo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BuQwA4NxKdKZD5PgYhPB4nHQHuQs/ReBDYkMKCnGG+NYP1ZFUDmNlXQI0CO0QO6wt
	 3RyHcLktk8FGRCWo+GU2QA6qDjNvful13J5SJ/ikgVMeSTAXPCrdg89ejg4RopnXr7
	 itZG9IzF3UPiBqlWQa1aJDzPIjv/JmRsTHi/sbBEj8N4zL/4r2dDR+qKVRCnyMGUEV
	 +XNjY7d9KuZgzZufkihSo3dnvTK4pDyHiV2BvXZ8uoEnq/4TIvY2L9vLxZHEVs7AS3
	 r6sy9Sm+rH0+qk/OMTdfIxRgN4w0pLWrwQHziij/fvi3hCSJwmu7AFSLClj1tSmmzU
	 66QgnsEkMM5JQ==
Subject: Re: [PATCH net 1/4] net: bcmgenet: stop the PHY when a WoL resume
 rebuilds the datapath
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 12:02:09 +0000
Message-ID: <179232492989.3135.6148472964891077526@kernel.org>
In-Reply-To: <20261017-nb-genet-fini-dma-net-v1-1-47e7c57f6834@tipi-net.de>
References: <20261017-nb-genet-fini-dma-net-v1-1-47e7c57f6834@tipi-net.de>
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

- [Medium] In bcmgenet_resume()
  (drivers/net/ethernet/broadcom/genet/bcmgenet.c), the new guard on the…

--

net: bcmgenet: stop the PHY when a WoL resume rebuilds the datapath

This patch adds a phy_stop() to the WoL teardown path in
bcmgenet_resume(), which runs when the MAC was found reset, so the
phy_start() in the rebuild does not warn and do nothing. The stop is
skipped when phy_is_started() says the PHY is not running, because a
failed earlier rebuild may already have stopped it.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8908916558b1..308716cddc077 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -4288,6 +4288,9 @@ static int bcmgenet_resume(struct device *d)
>  		bcmgenet_rdma_disable(priv);
>  		bcmgenet_intr_disable(priv);
>  		bcmgenet_fini_dma(priv);
> +		/* An earlier rebuild of this datapath may have stopped it */
> +		if (phy_is_started(dev->phydev))
> +			phy_stop(dev->phydev);

[Severity: Medium]

If the PHY is in PHY_ERROR at this point, does it get past this guard
and still hit the phy_start() warning during the rebuild?

phy_is_started() only returns true for states at or above PHY_UP:

include/linux/phy.h:phy_is_started() {
	return phydev->state >= PHY_UP;
}

In enum phy_state, PHY_ERROR comes before PHY_UP, so a PHY in that state
skips phy_stop(). phy_stop() itself accepts PHY_ERROR without warning
and moves the PHY to PHY_HALTED:

drivers/net/phy/phy.c:phy_stop() {
	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
	    phydev->state != PHY_ERROR) {
		WARN(1, "called from state %s\n",
		...
	phydev->state = PHY_HALTED;
	...
}

The kernel-doc for PHY_ERROR in enum phy_state also says "phy_stop moves
to @PHY_HALTED".

Next, the rebuild calls bcmgenet_netif_start()->phy_start(), which only
accepts READY or HALTED:

drivers/net/phy/phy.c:phy_start() {
	if (phydev->state != PHY_READY && phydev->state != PHY_HALTED) {
		WARN(1, "called from state %s\n",
		     phy_state_to_str(phydev->state));
		goto out;
	}
	...
}

When that happens, the PHY is not resumed and the state machine is not
restarted. bcmgenet_resume() still returns 0, but the link stays down
until the interface is taken down and up again.

Nothing stops the PHY state machine during a WoL suspend:

  - bcmgenet_mii_probe() sets mac_managed_pm = true, so
    mdio_bus_phy_suspend() and mdio_bus_phy_resume() return early.
  - The WoL branch of bcmgenet_suspend() does not call phy_stop().
  - bcmgenet_wol_power_up_cfg() writes PHY_RUNNING or PHY_NOLINK
    without stopping the machine.

So two things in that window could leave the PHY in PHY_ERROR when this
check runs:

  - an MDIO error in _phy_state_machine(), via phy_error_precise()
  - a phy_error() call from a PHY driver's interrupt handler

Nobody has seen this happen in practice yet. It follows from the code
paths above.

The commit message says:

    A rebuild that failed can have stopped it already, and
    phy_stop() warns about that too.

That holds for PHY_READY and PHY_HALTED, but not for PHY_ERROR. Would it
make sense to have the guard accept the same states phy_stop() does?
For example:

	if (phy_is_started(dev->phydev) ||
	    dev->phydev->state == PHY_ERROR)
		phy_stop(dev->phydev);

The non-WoL path does not have this gap, because bcmgenet_netif_stop()
always calls phy_stop().

>  		enable_irq(priv->irq1);
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834%40tipi-net.de
