Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AC1C5799;
	Wed, 16 Sep 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541246; cv=none; b=cFWpFJofXtXy5hyvKHxYIBpBo4uwrVVQz6A1LeX70Hh9Mx/NPPLh3NGRt+TIbCNMb+WY7mQ5+FbbYmcjuxowjx0SqhzcqXyaoKDStM65Q7s3Lyae94eTwMe+Fhgt02jn8eesflU+gFgS/nVS87nRcbzix9FzxjBVumbfXOBR5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541246; c=relaxed/simple;
	bh=h4GEVye/4f+Q9A/loFfDFokBmxdT71s6YKZurv91g+8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d55zd7e8mLihzlQgVzhFo/vE/vuB3asV/hEN/vmwJXYuF0tyhY/dZWRotl2VJiW3MjKybtg4kqLbCuxcwXg6u/51eVsSLzcymAourj3iMW1szr4XBeCXwWXew225ekyILcRKIPLZdPB7eYX2Tnj/7rB/EgFXnheIPleoMiu02dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ3t46/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ3t46/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72191F000FF;
	Wed, 16 Sep 2026 06:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541244;
	bh=0Aj3RlK1m86icSpydF2c6wtxa1gwC/wcJe1RSzbsTuc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UQ3t46/GE9fa9f8jr4oL3XM8el/UcljIAOlDoiLgqnToCnbREDHQES02FGyPEtwgm
	 Ya691HTMVFXmLJHEicFqlvx2IkWfxqi/zu38zr+ABGXFSMAKc+fAngUIYSiJPro+MG
	 THQhpN6JU8km8EIu7Uoo1pUBz5VZnuZkzbscDdBq+ZrDHoQNkiheLYY5Gz0/r5Bof+
	 OFR2JD9lEAnjldEpXYJc+YMtfPjzuNhRpt1Bb/CNXc3ZAogHzraXxylFMnxn7wSB0J
	 471qJL2BC3aAY2IsELQXz0M81lshTald/i94SHs7mobOz8bYLbtIuqqPYDZogAAexN
	 xb1rlMIL9+44Q==
Subject: Re: [PATCH net-next v11 01/15] phylink: Add phylink_mac_interrupt
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:23 +0000
Message-ID: <178954124325.22033.15259491368067745017@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-1-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-1-5ea7a925ba6d@birger-koblitz.de>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] phylink_mac_interrupt() (drivers/net/phy/phylink.c:1621) reads
  pl->phydev with a plain, unsynchronized load and immediately…

--

phylink: Add phylink_mac_interrupt

Adds an exported phylink_mac_interrupt() helper that forwards a link-change
interrupt received by the MAC to phylib via phy_mac_interrupt(), so that
drivers can avoid polling the PHY.

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

How is the read of pl->phydev in phylink_mac_interrupt() synchronized
against the writers?

Every other pl->phydev accessor in phylink.c either holds
pl->phydev_mutex (phylink_bringup_phy(), phylink_disconnect_phy(),
phylink_resolve()) or calls ASSERT_RTNL() (phylink_rx_clk_stop_block(),
phylink_ethtool_*(), phylink_mii_ioctl(), phylink_speed_up/down(),
phylink_prepare_resume()).  The field itself carries the comment:

	/* Serialize updates to pl->phydev with phylink_resolve() */
	struct mutex phydev_mutex;

Since the kernel-doc says the helper is for a link-change interrupt, the
caller cannot take that sleeping mutex, so is the documented rule for this
field reachable through this API at all?

Also, the load is a plain load rather than READ_ONCE().  Can the compiler
re-materialize pl->phydev for the phy_mac_interrupt(phy) use after the
NULL test, so that a concurrent clear in phylink_disconnect_phy() ends up
in phy_mac_interrupt(NULL)?  The dereference happens here:

drivers/net/phy/phy.c:phy_queue_state_machine() {
	mod_delayed_work(system_power_efficient_wq, &phydev->state_queue,
			 jiffies);
}

There is a second question about teardown ordering, reachable with the
consumer added later in this series (ax88179a_status() calls
phylink_mac_interrupt() from URB completion context):

drivers/net/usb/usbnet.c:usbnet_stop() {
	...
	if (info->stop) {
		retval = info->stop(dev);	/* -> phylink_stop() ->
						   phy_stop() ->
						   phy_stop_machine() */
	...
	usbnet_status_stop(dev);		/* status URB killed only here */
}

phy_stop_machine() does cancel_delayed_work_sync(&phydev->state_queue).
If a status URB completion lands between info->stop and
usbnet_status_stop(), does phylink_mac_interrupt() re-arm
phydev->state_queue after that synchronous cancel and run the state
machine on an already stopped PHY?

Finally, phylink_disconnect_phy() clears pl->phydev under the mutex and
then calls phy_disconnect() outside it:

	mutex_unlock(&pl->phydev_mutex);

	if (phy) {
		flush_work(&pl->resolve);
		phy_disconnect(phy);
	}

with no synchronize_irq(), refcount or RCU to exclude a reader that
already loaded the pointer.  For a future caller that does not quiesce its
interrupt source before phylink_disconnect_phy(), can the lockless load
become a use-after-free on phydev->state_queue once phy_detach() ->
put_device() has dropped the last reference?

Would it help to document a calling-context and PHY-lifetime contract on
the new declaration in include/linux/phylink.h, i.e. that the caller must
mask and synchronize its interrupt before phylink_disconnect_phy(), and to
use READ_ONCE() for the pl->phydev load?

> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 1dda5c7ed5f14..f6c1db837fb50 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -768,6 +768,7 @@ int phylink_ethtool_set_eee(struct phylink *link, struct ethtool_keee *eee);
>  int phylink_mii_ioctl(struct phylink *, struct ifreq *, int);
>  int phylink_speed_down(struct phylink *pl, bool sync);
>  int phylink_speed_up(struct phylink *pl);
> +void phylink_mac_interrupt(struct phylink *pl);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
