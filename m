Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF67E792;
	Sat, 10 Oct 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645056; cv=none; b=a3xRsPehp/LkY3qzdr9SqPGSMTJ7q2mDmAOKjSvV5SzJRJgh5JKaAYvQ9WgISSzUBDjuzLmoKsZ5vrwWTJUBr5Rn8GTZVjsOwJbIBjRQQMP0iSfvWi/P0OUzQWojrDbljDXtnQXD9eWRGyJFC/UhRE5YNWKUJNwIVBh54qr9yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645056; c=relaxed/simple;
	bh=QLQUZhuHquu5h+K5+++8K6ov30ItV3eholh0zPIekJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRRSju6ob7YAmexn2sWdr9u88kkVNGkpPgKcOwguy/TIb6hZUXCd5cYrxnteydT8+p7Bnic/CwdfY+k+fhPGLFdd6iwe5wZ/21vOS3rgTDglbnkTcebpS6nHYTfk8dJM9NJ6lvL7PrzTmJNV4rUwD6ZiKhv7Gk/8UuMPtUEkm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyc9V+7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyc9V+7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0930E1F000FF;
	Sat, 10 Oct 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645055;
	bh=7EBKa23MEeJpJW/VFfDJEHoVP27kKDvX20/UW5ru+3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eyc9V+7bQR2DStaiC77LENg6wQ7gF6Kin/cJ8FP4nbhKLdQzqf7Isg/IdaEUT6Ry1
	 sccgdNez0HifF9Gb6j+/ev84my2AGa0pO5oU7Hqcw78O6pf/rFlXI9yn5YJYJLIKla
	 Xuf6qS2Dkcng4xDU2L65F2h+06N5CfR7y60zLcoP4S+pmnCXt3LUF0cU86FM296WZE
	 f5++Qlqs8zBKY/GbvBo6nuk0GEtsahgEj/3cgewM7bCPrdCEfRO07AUyOOaDgLI9a1
	 f6IyLOrC0/3UrDUSDesce5e4tJkiqCl+zsSm0CDrkglYmPQU8t8zWKRXZQTziURQC1
	 Em4FBc1IJwfmA==
Subject: Re: [PATCH net-next 1/5] net: mdio: add timestamped write operation
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, linux@armlinux.org.uk,
 conor.dooley@microchip.com, bcm-kernel-feedback-list@broadcom.com,
 tglx@kernel.org, mlichvar@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 15:10:53 +0000
Message-ID: <179164505350.434549.15673211306849416822@kernel.org>
In-Reply-To: <20261009143506.2507607-2-jjc@jclark.com>
References: <20261009143506.2507607-2-jjc@jclark.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] __mdiobus_write_sts() in drivers/net/phy/mdio_bus.c can return
  -EINVAL or -EBUSY after bus->write_sts() has already succeeded and the…
- [Low] In __mdiobus_write_sts() (drivers/net/phy/mdio_bus.c:223-226),
  the comment says the 1 ms cap 'guards against an aux clock being…

--

net: mdio: add timestamped write operation

This adds an optional write_sts mii_bus operation. It returns PTP system
timestamps that bound the completion of an MDIO write, and comes with the
__mdiobus_write_sts() and __phy_write_sts() helpers. The core checks the
returned timestamps. For clocks that can be stepped, it also busy-waits
until the clock's raw time reaches the upper bound. mdio-mux passes the
operation through to the parent bus.

> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 00d0e4159e9bb..8e734227b2c67 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c

[ ... ]

> @@ -145,6 +146,105 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
>  }
>  EXPORT_SYMBOL(__mdiobus_write);
>  
> +/**
> + * __mdiobus_write_sts - Timestamped version of the __mdiobus_write function

[ ... ]

> + * Return: Zero if successful, negative error code on failure. Returns
> + *	   -EBUSY or -EINVAL if the system timestamps are not valid. If @sts
> + *	   is not NULL, -EOPNOTSUPP is returned only if
> + *	   mdiobus_supports_write_sts() is false.

[ ... ]

> +	if (bus->write_sts)
> +		err = bus->write_sts(bus, addr, regnum, val, sts);
> +	else
> +		err = -EOPNOTSUPP;
> +
> +	trace_mdio_access(bus, 0, addr, regnum, val, err);
> +	mdiobus_stats_acct(&bus->stats[addr], false, err);
> +
> +	if (err)
> +		return err;
> +
> +	if (!sts->pre_sts.valid || !sts->post_sts.valid)
> +		return -EINVAL;
> +
> +	if (sts->clockid == CLOCK_MONOTONIC ||
> +	    sts->clockid == CLOCK_MONOTONIC_RAW)
> +		return 0;
> +
> +	/* Fail if the clock was stepped; callers must retry anyway. */
> +	if (sts->pre_sts.clock_was_set_seq != sts->post_sts.clock_was_set_seq)
> +		return -EBUSY;

[Severity: Low]
These -EINVAL and -EBUSY returns in __mdiobus_write_sts() happen after
bus->write_sts() has already returned 0, so the PHY register has already
changed. The same is true for the !now.valid return, the sequence mismatch
return and the 1 ms deadline return in the loop below.

The same codes can also mean the write never happened. Bus drivers are only
told not to return -EOPNOTSUPP. Also, mdio_mux_write_sts() passes a
switch_fn error straight through without doing the write:

    r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
    ...
    if (r)
        goto out;

For example, the meson g12a mux switch callback returns -EINVAL in its
default case.

Should the kernel-doc say that -EBUSY or -EINVAL from timestamp validation
means the write was performed? The doc says "Returns -EBUSY or -EINVAL if
the system timestamps are not valid", and the comment here says "callers
must retry anyway". Together, they suggest a retry is always safe.

A caller of __phy_write_sts() cannot tell "register not written" apart from
"register written, timestamps unusable". Could a retry of a non-idempotent
write apply it twice? Examples are a time load, a time adjust or a
self-clearing trigger.

The bcm_ptp_framesync_ts() user in bcm-phy-ptp.c handles this correctly. It
always polls for the capture and restores NSE_CTRL, whatever the error. So
nothing misbehaves today. The gap is in the API contract for future users.

> +
> +	/* The shifted upper bound can be later than actual completion. */
> +	deadline = ktime_add_ns(ktime_get_raw(), NSEC_PER_MSEC);
> +	for (;;) {
> +		ktime_get_snapshot_id(sts->clockid, &now);
> +		if (!now.valid)
> +			return -EINVAL;
> +
> +		if (now.clock_was_set_seq != sts->pre_sts.clock_was_set_seq)
> +			return -EBUSY;
> +
> +		if (!ktime_before(now.monoraw, sts->post_sts.monoraw))
> +			return 0;
> +
> +		/* Cap the wait at 1 ms, which is more than any single
> +		 * write's delay. This guards against an aux clock being
> +		 * disabled and reenabled, which restarts its raw time.
> +		 */
> +		if (!ktime_before(ktime_get_raw(), deadline))
> +			return -EBUSY;

[Severity: Low]
Does the 1 ms cap fully guard against an aux clock being disabled and then
re-enabled?

aux_clock_enable() clears the shadow timekeeper:

kernel/time/timekeeping.c:aux_clock_enable() {
    ...
	/* Remove leftovers of a previous registration */
	memset(aux_tks, 0, sizeof(*aux_tks));
    ...
	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
}

This resets clock_was_set_seq, the raw time and offs_aux to 0. Then
TK_UPDATE_ALL increments clock_was_set_seq to 1.

An aux clock that was enabled and never set has seq 1. After a disable and
re-enable it has seq 1 again. The clock_was_set_seq comparisons in
__mdiobus_write_sts() therefore cannot see the reset. The only guard left
is the now.monoraw >= post_sts.monoraw check.

Two cases look like they get through.

In the first case, the aux clock was enabled recently, so post_sts.monoraw
is small. The re-enable happens while the provider sleeps after taking its
snapshots, for example in a wait_event_timeout() based wait such as
bcmgenet_mii_wait() with HZ / 100. The restarted raw time can then pass
post_sts.monoraw before this loop runs. The deadline is only computed after
write_sts() returns, so it does not help here.

In the second case, the disable and re-enable happen on another CPU between
the pre and post snapshots. post_sts then has a small monoraw from the new
epoch, and the loop returns 0 at once. Nothing checks that pre_sts comes
before post_sts.

In both cases gettimex64 would report bounds that cross an aux clock reset
as valid, instead of returning -EBUSY. This needs a privileged user to
toggle the aux clock during the write, so the window is narrow.

Should the comment be reworded to describe what the cap actually covers? Or
should the reset be detected some other way?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009143506.2507607-1-jjc%40jclark.com
