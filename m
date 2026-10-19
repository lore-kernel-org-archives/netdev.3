Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FD4D7974;
	Mon, 19 Oct 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406075; cv=none; b=t5Ik5rrzJfVB748DtXvi01ymIvUxqLRxBeOMUYTFpBlOlzvoc8h9jtdUy3JeRd7NKqLbSksvnPvAC5OAPPZGvSVkOEXU42WemdaoRHFjU6UMSPzMrp6Ee0ilIarVVvtFo+ptPjNusPy8zBI0ZfC4IzLGnQAd31omCvC0nnw+VO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406075; c=relaxed/simple;
	bh=KPsdekwwtdtR/pI/Tk01zeXnCa0mQh0mLSfWq3iuiCo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRDL1j0s+TWJ7uj7GF/BDJMDN9+bieu2EaLOYSXkI6vKhX4EjGcy8NmEoQRab/usKJsW7Tuz1Q4QXw9Qkmk+A0+8BqxW8YM2pHaFkVemznvWBe1WCJ6lbtZPw4QVjV45Gz7GrDvG28HeF827JrkfSnk5KtvPh5u8hecfEwIdzWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QblzHjp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QblzHjp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CBB1F000C4;
	Mon, 19 Oct 2026 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792406073;
	bh=MhOVvAHRwrn/bxN4xsZbqGICfgFTzBI3SyvZopcU6hg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QblzHjp4OJne+hVkaodaE26QTvYDFKeljVpfg2Uy9UQMeuND221vQS+Dhgju1r1cT
	 X4PZTe9RKy1xcav1nQMgHenRg4hAOqXndbsG5OjO5nCcd00GiQ9Kvq57ozNTXNfNMs
	 +JThnOdgEm4dqbxvWYfi6S0FaGt3J3ZAxx9rzwcu2WbOPTfjSQHLDCNoNR1Rm7pPlP
	 2GN+bomD7z8mTTO0pLRO4DTjr2uVXSosM0oMwtqKxYz13kONKrvN6d06jqOlSht8AV
	 pKb3zq7CQcOj81DjkaaMJaWQv912rSbQhQTX6CsprsyxBkIyp8tuBQlIjM/IPCrEYU
	 uQuyZzrrrFaBQ==
Subject:
 Re: [PATCH net-next v2 3/6] net: mdio: add timestamped write operation
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 richardcochran@gmail.com, florian.fainelli@broadcom.com, opendmb@gmail.com,
 nb@tipi-net.de, theo.lebrun@bootlin.com, andrew@lunn.ch,
 linux@armlinux.org.uk, conor.dooley@microchip.com,
 bcm-kernel-feedback-list@broadcom.com, tglx@kernel.org, jstultz@google.com,
 sboyd@kernel.org, mlichvar@redhat.com, olteanv@gmail.com,
 h.feurstein@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 10:34:32 +0000
Message-ID: <179240607211.3135.395447603413971860@kernel.org>
In-Reply-To: <20261018100257.566267-4-jjc@jclark.com>
References: <20261018100257.566267-4-jjc@jclark.com>
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

- [Low] Claim: the fixed event_delay_ns + 1 ms deadline in
  __mdiobus_write_sts() hard-codes a minimum MDC rate of about 65 kHz.

--

net: mdio: add timestamped write operation

This adds an optional write_sts mii_bus operation that returns system
timestamp bounds for the completion of a clause 22 MDIO write. The new
__mdiobus_write_sts() adds an event delay to the upper bound, then waits
until that upper bound has passed so it can check that the clock was not
stepped. It also adds MDIO_C22_FRAME_BITS and MDIO_PREAMBLE_BITS, which bus
drivers can use to work out when a write completes.

> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 00d0e4159e9bb..493eb4ae0303d 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c

[ ... ]

> @@ -145,6 +146,112 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)

[ ... ]

> +int __mdiobus_write_sts(struct mii_bus *bus, int addr, u32 regnum, u16 val,
> +			u32 event_delay_ns, struct ptp_system_timestamp *sts)
> +{

[ ... ]

> +	/* Fail if the clock was stepped. */
> +	if (sts->pre_sts.clock_was_set_seq != sts->post_sts.clock_was_set_seq)
> +		return -EBUSY;
> +
> +	/* Fail if the shift in the upper bound crosses a clock step. Since
> +	 * write_sts() can return before the transfer completes, we need to wait
> +	 * until the shifted upper bound has passed. This wait needs a deadline
> +	 * in case an aux clock is disabled and reenabled, which restarts its
> +	 * raw time. 1 ms is enough for a frame with MDC down to about 65 kHz.
> +	 */
> +	deadline = ktime_add_ns(ktime_get_raw(),
> +				(u64)event_delay_ns + NSEC_PER_MSEC);
> +	for (;;) {
> +		bool late = !ktime_before(ktime_get_raw(), deadline);
> +
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
> +		if (late)
> +			return -EBUSY;

[Severity: Low]

This isn't a bug, but the 1 ms allowance is counted from the moment
write_sts() returns, which makes it part of the bus op contract.

Suppose a write_sts() implementation returned more than about 1 ms before
its predicted completion. Wouldn't every timestamped write on that bus fail
here with -EBUSY for CLOCK_REALTIME, CLOCK_BOOTTIME and aux clocks, even
though the write itself succeeded?

This looks theoretical for the implementations in this series.
macb_mdio_write_c22_sts() and unimac_mdio_write_sts() both wait for the
controller to go idle before returning. Their upper bound is therefore at
most about one MDC period plus event_delay_ns past the return time.
Synchronous drivers such as bit-banged MDIO also return after the frame.

The code comment above does state the limit. The @write_sts kerneldoc in
include/linux/phy.h, though, only says:

	/**
	 * @write_sts: Perform a C22 write transfer on the bus,
	 * with system timestamps bounding its completion. Set only
	 * if timestamps can always be provided. Must not return
	 * -EOPNOTSUPP.
	 */

Could that kerneldoc also say that write_sts() must not return more than
1 ms before the predicted completion of the transfer?

> +
> +		cpu_relax();
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__mdiobus_write_sts);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018100257.566267-1-jjc%40jclark.com
