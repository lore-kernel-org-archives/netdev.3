Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2E44AB68;
	Fri, 16 Oct 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143466; cv=none; b=rT5IX4bSDek56OWKHCLX6ynIH2S6dq7WI35OyVgM9tIKVu1JlAd9ah3jxu11VOqIGkJ04otn7FM/aSidneaC0lJ1vI4o3jI6K+gVliuwdnm544KZNfoUEZG6I0Ne3Fg3LyzclhpmQ4MUUHmSIahcofwvKMqu6XhffEWBpwND0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143466; c=relaxed/simple;
	bh=+41lUksb60ntBNBFJotV1Ct+Or9nWSKom6ylC0IKg8U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glhG5/uuPjUS4A6Lc2Bh7CmO0ZRZ17JaVhHPsqHADRDjTc6rX5ecqmy5OFBQWSfDP3zCRdXQWwq/g89unHKpGuLTnMERtiiEbVqpYcZMnI6m9rpgcaDyJx7yUXY5RRMq09+Uv3UwsFeg5v3fRN7jnJaBhCPISqqHwh3raUNzxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlXLDhCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlXLDhCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212D11F000C5;
	Fri, 16 Oct 2026 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143464;
	bh=4u6I18RErT7nE5zp+pS+FLViccrZOflmOd48mT9ZTfI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FlXLDhCYVKpaKSNamp+Iyzv9QZfW2jdNJWfjDza5QJN5HI9kd9XDk2CIipVB0yybX
	 pQwPkin/ARD0nqgav/WL/PINWIY0Cvhu5BjPW1ancKGZSS1HomlNRx4dl6d27G7xUt
	 0eZg3NxSvZj2OyLXbXbGVLNKyOUedpKxdxk1iAv1GIJF2/d6l534YqTQ8forNfuDAY
	 7zGDO8y03prB/HJ1lmsTQ6sZaDVCZRCKiXMXao3TlXw3K1LhCErIn5E1j4mND3PLnm
	 6+cH3/CLWJW8rc3AXRRlw5GPM7IOqQ0xbrMaQS1S6S1SUSYemotJ/GbrKQL6WM27u/
	 4s9t2JX76nm4g==
Subject: Re: [PATCH net-next v10 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, dnlplm@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 16 Oct 2026 09:37:43 +0000
Message-ID: <179214346368.434549.12561882856700666394@kernel.org>
In-Reply-To: <20261013183500.261229-3-peter.hunt@opengear.com>
References: <20261013183500.261229-3-peter.hunt@opengear.com>
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

- [Medium] A DTR/RTS request made while the IP_CTRL channel is not bound
  is silently lost, and nothing sends it again when IP_CTRL binds later.
- [Low] The DTR/RTS drop on last close (HUPCL) or on port removal is now
  sent asynchronously and coalesced with later state, so the modem may…

--

net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

This patch makes mhi_wwan_ctrl also bind the IP_CTRL MHI channel, using a
separate mhi_driver. It implements the wwan ->dtr_rts op for AT ports.
Each port records its DTR/RTS state, and a delayed work item sends it over
the IP_CTRL channel of the same controller. The work coalesces bursts and
retries on -EAGAIN/-ENOMEM.

> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
> index a31d8540fbb85..e3c2075889565 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c

[ ... ]

> @@ -103,6 +140,80 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
>  	}
>  }
>  
> +/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL channel */
> +static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned int mdmbits)
> +{

[ ... ]

> +	guard(mutex)(&mhi_wwan_dtr_lock);
> +
> +	list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
> +		if (dtr->cntrl == cntrl) {
> +			ctrl_dev = dtr->mhi_dev;
> +			break;
> +		}
> +	}
> +	if (!ctrl_dev) {
> +		dev_dbg(&mhiwwan->mhi_dev->dev,
> +			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
> +		return 0;
> +	}

[Severity: Medium]
If IP_CTRL is not bound when a DTR/RTS request comes in, is that request
lost for good?

mhi_wwan_ctrl_dtr_work() only reschedules on -EAGAIN or -ENOMEM, so it
treats this return 0 as a successful send:

	ret = mhi_wwan_ctrl_send_dtr(mhiwwan, READ_ONCE(mhiwwan->dtr_mdmbits));
	if (ret == -EAGAIN || ret == -ENOMEM)
		schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffies(10));

Later, mhi_wwan_dtr_probe() adds the IP_CTRL entry to mhi_wwan_dtr_list.
Nothing at that point sends the current dtr_mdmbits for the AT ports that
are already open on that controller.

The wwan core won't resend it either. wwan_port_raise_dtr_rts() only runs
on first open from wwan_port_op_start(). The TIOCMSET/TIOCMBIS/TIOCMBIC
handler only calls ->dtr_rts when the cached bits change:

	if (port->type == WWAN_PORT_AT && port->ops &&
	    port->ops->dtr_rts &&
	    (old ^ port->at_data.mdmbits) & (TIOCM_DTR | TIOCM_RTS))
		port->ops->dtr_rts(port, port->at_data.mdmbits);

So if userspace asks for TIOCM_DTR again, the driver never sees it.

The modem would then keep DTR deasserted and hold back URCs, while
TIOCMGET reports DTR|RTS as asserted.

Some ways to get into this state:

Unbinding and rebinding mhi_wwan_dtr through sysfs while a DUN port is
open. Any request made between mhi_wwan_dtr_remove() and the next probe
is dropped.

An IP_CTRL probe that fails and is retried later.

A controller config that puts IP_CTRL at a higher channel index than DUN.
mhi_create_devices() probes devices in channel-index order.

The commit message says:

    If a send fails because the ring is full or memory is short, the
    work retries shortly with whatever state is latest by then, so the modem
    ends up with the final state that was requested.

As far as I can tell, that only holds for -EAGAIN/-ENOMEM. It does not
cover an IP_CTRL channel that binds late.

Could mhi_wwan_dtr_probe() resync the open AT ports on its controller, or
could this case be handled so the state is sent again once IP_CTRL binds?

> +
> +	dtr_msg = kzalloc_obj(*dtr_msg);
> +	if (!dtr_msg)
> +		return -ENOMEM;

[ ... ]

> +static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
> +{
> +	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
> +
> +	WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
> +	schedule_delayed_work(&mhiwwan->dtr_work, 0);
> +}

[Severity: Low]
Can the HUPCL drop on last close get lost here?

wwan_port_op_stop() drops DTR/RTS and then stops the port:

	wwan_port_drop_dtr_rts(port, true);
	port->ops->stop(port);

This function only records the bits and schedules the work. The message
is therefore queued later, possibly after mhi_wwan_ctrl_stop() has already
called mhi_unprepare_from_transfer() on the DUN channel. The drop from
wwan_remove_port() is also sent only after ->stop() has run.

Suppose dtr_work is still pending when the port is reopened.
wwan_port_raise_dtr_rts() overwrites dtr_mdmbits with DTR|RTS, and
mhi_wwan_ctrl_dtr_work() only reads the raised value. The drop is never
sent.

The most likely way for the work to be pending is a 10 ms retry armed
after -EAGAIN or -ENOMEM. schedule_delayed_work(..., 0) does nothing to a
delayed work that is already pending, and it does not shorten the delay.

On a modem configured with AT&D2, could a quick close and reopen then
fail to hang up an active data call?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013183500.261229-1-peter.hunt%40opengear.com
