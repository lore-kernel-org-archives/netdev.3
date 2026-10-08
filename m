Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD63CCA13;
	Thu,  8 Oct 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486394; cv=none; b=OzWndn7r2N/uu+KnG2EDCMBqpjQjVZZ5+ertTnOTi+rV2wE1NtaUIyutJnJCMFewht8tk84Tif+MNZV+/NTChoy2lVfP/a/wGzd4eoPo24LeV0IceAmuFq9RVjnudzJ2ZrzPyJzIOCj6ZZxHpIu58xDfGEhwBji4RSR8m2G7U5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486394; c=relaxed/simple;
	bh=QWvqYlIclSU577QHdo8oFCCswV80DaYjPFElC0Wwdwk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+o2rPpUUVQ6MW754mxJfLxsZICXQ855ZwkawCkxgDqVlMTvMhZAvdA0xSuuL7nco/bebbb5apjLTsEPDjjn2VAsxhPZwjAjZpUIBIS+krnJsM/+LPhWNC7VOG9ZmCvVWxY4cyRFfR/fiNoWgjNt7TsrdhJtK6FAkwAm7x9hYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9cTvlty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9cTvlty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D701F000FF;
	Thu,  8 Oct 2026 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486384;
	bh=Neq1DVpdii5E8ryT4RNx89MngYirE9gSw74tNAUt3nI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e9cTvlty5vA8uR4sp7kO5dfZASBJWOjiJktgSfbNQ9Z3TWGgyVIHRXLGRmWUD+dLr
	 nGD+XOYDhooT0tBJf9IJ20umUKUDS6ZU//FucfOOOat9VopN39kYgelO6wlmMavYHA
	 EQHLfRKbCbGUVvxJjZYXKEpnEXfEWnqtETlVC+UAhdUGRSOODpTWM0VIrOK9PSNKyF
	 2WGXcxEh2cTXHcKMISsHD+AJe2n036TSIxo4VUB7Hy70ZgAuTw8yZG8t5a+n0MlwSL
	 3v4inoMRRI4QnBdknSJ+HcqCoNfd6fMzgabY/vfV1IFH0aOvYfZKmuCPIAG4ED7g0A
	 nESEM5s9tIStA==
Subject: Re: [PATCH net-next v7 1/2] net: wwan: core: propagate modem control
 signals to port drivers
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 19:06:23 +0000
Message-ID: <179148638373.434549.9837156771321645089@kernel.org>
In-Reply-To: <20261006040422.3208888-2-peter.hunt@opengear.com>
References: <20261006040422.3208888-2-peter.hunt@opengear.com>
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

- [Low] [Baseline: false positive, kept only because
  requires_validation=true] The concern was that the new optional op…
- [Low] wwan_port_fops_at_ioctl() handles TIOCMSET/TIOCMBIS/TIOCMBIC by
  copying a raw user-supplied int with copy_from_user().
- [Low] A failed TCSETS/TCSETSW/TCSETSF/TCSETS2/TCSETSW2/TCSETSF2 ioctl
  can turn off the new hang-up-on-close behaviour.
- [Low] On every WWAN_PORT_AT port, TIOCMSET/TIOCMBIC/TIOCMBIS now take
  port->ops_lock with an uninterruptible mutex_lock().

--

net: wwan: core: propagate modem control signals to port drivers

This patch adds an optional ->dtr_rts() operation to struct wwan_port_ops.
The core calls it from the TIOCMSET/TIOCMBIC/TIOCMBIS ioctl path for AT
ports. It also raises DTR/RTS on first open, drops them on last close if
HUPCL is set (HUPCL now defaults to on for AT ports), and always drops them
when an open port is removed.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e681..eba4b0582b5ad 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c

[ ... ]

> @@ -679,12 +683,34 @@ struct wwan_port *wwan_create_port(struct device *parent,
>  }
>  EXPORT_SYMBOL_GPL(wwan_create_port);
>  
> +/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
> + * the lines are only dropped if HUPCL is set, as for a TTY, on port
> + * removal they are always dropped.
> + */
> +static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_only)
> +{
> +	unsigned int bits;
> +
> +	mutex_lock(&port->data_lock);
> +	if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL)) {
> +		mutex_unlock(&port->data_lock);
> +		return;
> +	}

[Severity: Low]
Can a failed TCSETS ioctl quietly turn off the hang-up on last close?

wwan_port_fops_at_ioctl() copies directly into the live termios:

	case TCSETS:
	case TCSETSW:
	case TCSETSF:
		if (copy_from_user(&port->at_data.termios, (void __user *)arg,
				   sizeof(struct termios)))
			ret = -EFAULT;
		break;

On a fault, copy_from_user() zero-fills the bytes it could not copy. With a
bad pointer this clears c_cflag, and so HUPCL, and the ioctl returns -EFAULT
without restoring the old settings. The TCSETS2/TCSETSW2/TCSETSF2 cases
behave the same way.

On last close, wwan_port_op_stop()->wwan_port_drop_dtr_rts(port, true) then
sees HUPCL clear and returns early. DTR/RTS stay asserted even though no
ioctl ever cleared HUPCL successfully.

The direct copy is older than this patch, but this patch is the first to
let c_cflag control the modem lines. Could the termios ioctls copy into a
temporary ktermios and commit it only on success?

> +	port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
> +	bits = port->at_data.mdmbits;
> +	mutex_unlock(&port->data_lock);
> +
> +	port->ops->dtr_rts(port, bits);
> +}

[ ... ]

> @@ -1036,6 +1080,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  			port->at_data.mdmbits |= mdmbits;
>  		else
>  			port->at_data.mdmbits = mdmbits;
> +		if (port->type == WWAN_PORT_AT)
> +			call_dtr_rts = true;
>  		break;
>  	}

[Severity: Low]
Should the user value be masked before it is stored and passed to
->dtr_rts()?

mdmbits comes straight from copy_from_user(). It is merged into
port->at_data.mdmbits unchanged and later passed as-is to
port->ops->dtr_rts(). That means TIOCM_LOOP, the input-only bits
(TIOCM_CAR, TIOCM_CTS, TIOCM_DSR, TIOCM_RNG) and undefined bits all reach
the driver. So does the sign bit after the int to unsigned int conversion.

By comparison, tty_tiocmset() in drivers/tty/tty_io.c masks the value
before calling the driver:

	set &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;
	clear &= TIOCM_DTR|TIOCM_RTS|TIOCM_OUT1|TIOCM_OUT2|TIOCM_LOOP;

Also, call_dtr_rts is set on every TIOCMSET/TIOCMBIS/TIOCMBIC, even when
DTR/RTS do not change. The commit message says:

  The wwan core tracks the full TIOCM bitmask in port->at_data.mdmbits
  and calls ->dtr_rts when it changes

Is that accurate? With the mhi_wwan_ctrl user added later in the series,
each of these ioctls allocates and queues a new IP_CTRL message.

The kernel-doc in include/linux/wwan.h only describes @mdmbits as "a
TIOCM_* bitmask". Could the core filter out the extra bits and the
unchanged-state calls? If not, could the kernel-doc say which bits drivers
may see and that calls can be redundant?

[ ... ]

> @@ -1061,6 +1107,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  
>  	mutex_unlock(&port->data_lock);
>  
> +	if (call_dtr_rts) {
> +		unsigned int bits;
> +
> +		mutex_lock(&port->ops_lock);
> +		if (port->ops && port->ops->dtr_rts) {

[Severity: Low]
Could this make TIOCMSET/TIOCMBIC/TIOCMBIS sleep uninterruptibly on AT
ports whose driver does not implement ->dtr_rts?

ops_lock is taken before port->ops->dtr_rts is checked, and
wwan_port_op_tx() holds ops_lock across the driver's blocking TX:

	mutex_lock(&port->ops_lock);
	...
	if (nonblock || !port->ops->tx_blocking)
		ret = port->ops->tx(port, skb);
	else
		ret = port->ops->tx_blocking(port, skb);

rpmsg_wwan_ctrl registers AT ports and implements .tx_blocking with
rpmsg_send(), which sleeps until the remote has TX space. It does not
implement ->dtr_rts:

thread A
write()
  wwan_port_op_tx()
    mutex_lock(&port->ops_lock)
    rpmsg_wwan_ctrl_tx_blocking()
      rpmsg_send()    <- waiting on the remote

thread B
ioctl(TIOCMBIS)
  wwan_port_fops_at_ioctl()
    mutex_lock(&port->ops_lock)    <- blocks until A is done
    port->ops->dtr_rts is NULL, nothing to call

Before this patch, these ioctls only took data_lock and returned at once.
Could ops_lock be skipped when no ->dtr_rts can apply, or taken with
mutex_lock_interruptible()?

> +			mutex_lock(&port->data_lock);
> +			bits = port->at_data.mdmbits;
> +			mutex_unlock(&port->data_lock);
> +			port->ops->dtr_rts(port, bits);
> +		}
> +		mutex_unlock(&port->ops_lock);
> +	}
> +
>  	return ret;
>  }
>  
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index 1e0e2cb535799..57406139304ea 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h

[ ... ]

> @@ -70,6 +72,7 @@ struct wwan_port_ops {
>  	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
>  	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
>  			    poll_table *wait);
> +	void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
>  };

[Severity: Low]
This isn't a bug, but this patch adds ->dtr_rts with no in-tree
implementer. On its own it does not fix the problem the commit message
describes, where modems withhold unsolicited result codes until DTR is
asserted.

The series covers this. The next patch, "net: wwan: mhi_wwan_ctrl: drive
DTR/RTS via the IP_CTRL channel", adds .dtr_rts = mhi_wwan_ctrl_dtr_rts to
wwan_pops. mhi_wwan_ctrl_stop() only tears down the DUN data channel and
sends nothing on IP_CTRL. So with HUPCL cleared, DTR also stays asserted
across close for that driver, as the commit message says.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006040422.3208888-1-peter.hunt%40opengear.com
