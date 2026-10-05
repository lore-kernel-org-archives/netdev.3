Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735047F2C8;
	Mon,  5 Oct 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205298; cv=none; b=oDOgmARo9DnLJr1eEDNgWWS4LTuG9PAs1DmII/cLPuosqHLlqOUqtLNWT9iKHEZt6XlFTR0+rc20YJFTYF50HnBaGk2Z/tefLG80dIs0jjbUymriReVWvk3UYhutmlDlR7gx/ksvAqWxMgTBj4N3dmNOonOTKEScnLhZRhWAeH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205298; c=relaxed/simple;
	bh=JstREQ3UGaRasqIFXBc7ooyna7fBYSxyJpdNP8bTnF0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIJOWwBu2JDejpQ3pr5aQ+rPPuharRRo7mDT4Vvui6S49qvC8Nb6Ajs0bpvXGr+PEGWRB/IVZ3YccmbAzLg352PGsufggeH5AQRLzCkRlbYxPwMfx3KQFjQSOwv1A4j7Po5SLmOkw/8LGFAu2wmo/tFOjXfNiy8ohRZtSewGpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0dOiqd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0dOiqd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00D71F000FF;
	Mon,  5 Oct 2026 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791205296;
	bh=jQJA3FY6QTOTfnaajXMlA+9N1fLIuqKYQKz41jDxnlA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y0dOiqd0P5+k9tAJ6wWc/8NvNFnORzOj1KzU66nFtbxlLNl9G1kUNA9nfS3w+fNRL
	 ebOX/3scY/EZDyMJqKugTBHTc+bDxSYLA1ANLI0BWk9v+f1dO/iP0GFJEGzwTf5fNq
	 IFx0aeUzzyjOWs+AEDIcQ1KaFq2tPc3/7HJAFVcbwD1gVwJIIGaO56DdBz+UAi5eJT
	 6thRKXFkTzaj4tEmDj/jaRhPLpKrNmmVgEdaceCgGIRNxkAhMIYaADFI6D9LiZJ6YP
	 4tbRdcBCHdl7SgOTigXiDTE+RFceQJfcBaDKKDF6PgS9caihkBpIBWXe0izJLZAoKe
	 +lVzSxPgtSC9A==
Subject: Re: [PATCH net-next v4 1/4] net: phy: refuse a second attach before
 touching the PHY
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Mon, 05 Oct 2026 13:01:35 +0000
Message-ID: <179120529541.434549.16314859661569894992@kernel.org>
In-Reply-To: <20261001130120.104628-2-f@lex.la>
References: <20261001130120.104628-2-f@lex.la>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new 'already attached' guard in phy_attach_direct() is a
  lockless check-then-act.
- [Low] The commit message says the old error path ran
  phy_detach_internal() and, for the generic driver, unbound genphy.

--

net: phy: refuse a second attach before touching the PHY

This patch moves the "PHY already attached" test in phy_attach_direct()
to the start of the function, before any module or device references are
taken and before the generic driver is bound. It also tests
phydev->phy_link_change instead of phydev->attached_dev, so that a PHY
attached without a netdev is refused too.

> phy_attach_direct() tests phydev->attached_dev only after it has taken
> its references and, for a PHY with no driver, bound the generic one, and
> then leaves through the error path that calls phy_detach_internal().
> That call works on the PHY's current attachment, so a second attach of
> a PHY in use tears down the first consumer: it clears that netdev's
> phydev pointer and the PHY's attached_dev, removes the sysfs links,
> suspends the PHY and, for the generic driver, unbinds it, while the
> first consumer goes on using the PHY.

[Severity: Low]
Is this description accurate for a PHY that the generic driver drives?

Since commit 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct
phy_device"), is_genphy_driven is a field of struct phy_device and no
longer a local variable. On a second attach of a genphy-driven PHY,
d->driver is already set and is_genphy_driven is still 1, so the old code
runs:

phy_attach_direct() {
    ...
	if (phydev->is_genphy_driven) {
		err = d->driver->probe(d);
		if (err >= 0)
			err = device_bind_driver(d);

		if (err)
			goto error_module_put;
	}
    ...
}

That runs phy_probe() again on a PHY that is in use. It registers the LED
triggers a second time, resets the link modes and sets the state to
PHY_READY.

device_bind_driver() then fails in driver_sysfs_add() with -EEXIST, since
the links from the first bind are still there. The code then reaches:

error_module_put:
	module_put(d->driver->owner);
	phydev->is_genphy_driven = 0;
	d->driver = NULL;

At that point the first consumer still has the PHY bound and attached.

On this path, the old attached_dev test and phy_detach_internal() are
never reached. Could the message describe this failure mode instead? Does
the Fixes: tag cover how the problem appears on current kernels?

The removed dev_err(&dev->dev, ...) also dereferenced a pointer built from
a NULL dev. That happens when a PHY already attached to a netdev is
attached again without one. Switching to phydev_err() fixes that as well.
Is it worth mentioning in the message?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b13a74e2fa92..0bdd2dc84d81a 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1794,6 +1794,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	struct module *ndev_owner = NULL;
>  	int err;
>  
> +	/* Set by every attach, with or without a netdev */
> +	if (phydev->phy_link_change) {
> +		phydev_err(phydev, "PHY already attached\n");
> +		return -EBUSY;
> +	}
> +

[Severity: Medium]
Can two concurrent attaches of the same phy_device both get past this
check?

phy_link_change is read here with no lock held. The claim is written much
later in phy_attach_direct():

	phydev->phy_link_change = phy_link_change;
	if (dev) {
		phydev->attached_dev = dev;
		dev->phydev = phydev;

Between the two are try_module_get(), get_device() and, for genphy,
d->driver->probe() and device_bind_driver(), which can sleep.

Not every caller holds RTNL. DSA attaches at probe time through
dsa_user_create()->dsa_user_phy_setup() before rtnl_lock(). CPU and DSA
link ports attach through
dsa_shared_port_phylink_register()->phylink_of_phy_connect(), also without
RTNL. MAC drivers attach from ndo_open with RTNL held.

So the following sequence looks possible:

CPU0                                 CPU1
phy_attach_direct()
  phy_link_change == NULL
                                     phy_attach_direct()
                                       phy_link_change == NULL
  phydev->phy_link_change = ...
  phydev->attached_dev = dev0
  dev0->phydev = phydev
                                       phydev->phy_link_change = ...
                                       phydev->attached_dev = dev1
                                       dev1->phydev = phydev
                                       phy_init_hw(phydev)

CPU1 overwrites attached_dev and phy_link_change and re-runs
phy_init_hw() on the PHY that dev0 is using, while dev0 keeps its phydev
pointer. For genphy, CPU1 re-runs the probe, device_bind_driver() fails,
and error_module_put clears d->driver and is_genphy_driven under the
first consumer.

The later patch in this series, "net: phy: serialise attach and detach
with PHY driver bind and unbind", adds phydev->bind_lock, but this check
stays outside it. An attacher that has passed the check blocks on
bind_lock while the first attach completes. It then takes the lock and
attaches again without checking a second time.

Would it make sense to do this test under bind_lock, or to claim the PHY
atomically, so the check and the assignment cannot be separated?

The reads and writes of phy_link_change here and in phy_detach_internal()
are also plain accesses without READ_ONCE()/WRITE_ONCE(). KCSAN would
probably report them as a data race.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130120.104628-1-f%40lex.la
