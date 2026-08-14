Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB763C1419;
	Fri, 14 Aug 2026 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737064; cv=none; b=ZetXq6rToDI0bNac5GWnpDo1GttZXmkuqFiFQsEy5R5yUkPek72OaqUtibW4X4TeugPs8P+3bRQqa+EqyK1f9vrdD+CghDRyzQc+DCmvoEyY3PhzxAshwCkPPyhIadlatT/t7lW08L3ce3dbxGqu17TRB27vL4LEBUM0YoGtR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737064; c=relaxed/simple;
	bh=Tg0Hi7FwxeAAVjtZKZfrsawG5Y3Zq69hnHKFs7ojjl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9cU9Nc2aDZZK7jEJ13pqgEzVnDq1mkfe3TPvYNzF6g7B0FvU3+dznBAH418uhIWiAQQxLm1yQdiI4jWwnRbi2QzqG8OlPfb8OF5G5kRzNUlEPulBzlOto/EN9APc5GZD1LPlkqxV2z5gQmxCA15tehYWQOrMlbiIFlrKw7iPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5J2/25z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5J2/25z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0EF1F000E9;
	Fri, 14 Aug 2026 19:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737062;
	bh=/gmhQQIkmx7gG+7jxdQA4x4beQCkP+wvUQj15igRjCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5J2/25zG+tKycS4zQ9ONaMmUpLsW5YIDTocUWE+iglXHLGQKuVodGT3qiP3jxT4/
	 E7zns8pelK8x63iajFJd7xvTb39yE3EjV6wQUaHmNXQLDZdwXc3wECfiJMJZlrVKTI
	 0JY0DDHQQAWvdfrN8TkOUZEtVxOEOMkSD+soZcw3RMTmCve3LdHTpLL3cOTKbKMXkd
	 1oapKRmdJDW0QGJG+Lcw7wc8cHmyAYN++nxrlgSkKfa+ftgek50iMXI5H8X+7D4fpq
	 r00043i5qUxl6G4QGIF3Tw5qI8FsAv1HXKpM7j7cu9ENHrUE5bn0ZaggWkRUhDaduq
	 U32Rim04R1K9g==
From: Jakub Kicinski <kuba@kernel.org>
To: peter.hunt@opengear.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/3] net: wwan: core: propagate modem control signals to port drivers
Date: Fri, 14 Aug 2026 12:50:57 -0700
Message-ID: <20260814195056.3203996-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807215042.2714442-2-peter.hunt@opengear.com>
References: <20260807215042.2714442-2-peter.hunt@opengear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: wwan: core: propagate modem control signals to port drivers

Adds an optional ->dtr_rts(port, on) callback to struct wwan_port_ops so
port drivers learn when the host raises or drops DTR/RTS. The wwan core
calls it from the TIOCMSET/TIOCMBIC/TIOCMBIS emulation and also raises the
lines on first open and drops them on last close of an AT port.

A few questions about the new call sites below.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e68..f8ca9cda3c9a 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -759,8 +759,15 @@ static int wwan_port_op_start(struct wwan_port *port)
>  	if (!port->start_count)
>  		ret = port->ops->start(port);
>  
> -	if (!ret)
> +	if (!ret) {
>  		port->start_count++;
> +		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
> +		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
> +		    port->ops->dtr_rts) {
> +			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
> +			port->ops->dtr_rts(port, true);
> +		}
> +	}

[Severity: Medium]
Which lock owns port->at_data.mdmbits now?

wwan_port_op_start() and wwan_port_op_stop() do the read-modify-write while
holding port->ops_lock only, but wwan_port_fops_at_ioctl() reads and updates
the same field under port->data_lock:

	mutex_lock(&port->data_lock);
	...
		if (cmd == TIOCMBIC)
			port->at_data.mdmbits &= ~mdmbits;
		else if (cmd == TIOCMBIS)
			port->at_data.mdmbits |= mdmbits;

The struct comment says that field is covered by data_lock:

	struct mutex data_lock;	/* Port specific data access serialization */

Since a wwan port allows multiple concurrent opens (start_count is a
counter and exclusivity is opt-in via TIOCEXCL), can a close on one fd and
a TIOCMBIS on another fd run at the same time and lose one of the two
updates, leaving TIOCMGET reporting a bitmask that does not match what the
driver was last told?

Along the same lines, can the two paths deliver the assert and de-assert to
->dtr_rts in an order inverted relative to the order in which mdmbits was
committed, for example an ioctl-driven dtr_rts(true) landing after the
last-close dtr_rts(false)/->stop() sequence has already started?

>  
>  out_unlock:
>  	mutex_unlock(&port->ops_lock);
> @@ -773,6 +780,11 @@ static void wwan_port_op_stop(struct wwan_port *port)
>  	mutex_lock(&port->ops_lock);
>  	port->start_count--;
>  	if (!port->start_count) {
> +		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT port */
> +		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts) {
> +			port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
> +			port->ops->dtr_rts(port, false);
> +		}

[Severity: Medium]
Should the WWAN_PORT_AT filter here also apply to the ioctl call site?

wwan_port_fops_ioctl() dispatches into wwan_port_fops_at_ioctl() for both
port types:

	if (port->type == WWAN_PORT_AT || port->type == WWAN_PORT_QCDM) {
		/* AT and QCDM port specific IOCTLs */
		res = wwan_port_fops_at_ioctl(port, cmd, arg);

The new ioctl handling calls ->dtr_rts() with no type gate, while both the
raise in wwan_port_op_start() and this drop are gated on WWAN_PORT_AT.

For a QCDM port, is this sequence possible?

	open("/dev/wwan0qcdm0")
	ioctl(TIOCMSET, &(int){TIOCM_DTR | TIOCM_RTS})  ->  dtr_rts(port, true)
	close(fd)
	  wwan_port_op_stop()
	    /* WWAN_PORT_AT test fails, drop is skipped */
	    port->ops->stop(port);

That leaves the channel torn down with the lines still asserted and no path
that ever calls ->dtr_rts(port, false). The MHI driver added later in this
series has such a port:

	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },

Also, since port->at_data.mdmbits lives in the long-lived wwan_port, does a
re-open of that QCDM port then report a stale TIOCM_DTR|TIOCM_RTS through
TIOCMGET even though the core never re-drove ->dtr_rts, because the
open-time raise is AT-only?

>  		if (port->ops)
>  			port->ops->stop(port);
>  		skb_queue_purge(&port->rxq);
> @@ -1036,6 +1048,10 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  			port->at_data.mdmbits |= mdmbits;
>  		else
>  			port->at_data.mdmbits = mdmbits;
> +		if (port->ops->dtr_rts)

[Severity: High]
Can port->ops be NULL here?

wwan_remove_port() clears it under ops_lock while file descriptors are
still open:

	mutex_lock(&port->ops_lock);
	if (port->start_count) {
		port->ops->stop(port);
		port->start_count = 0;
	}
	port->ops = NULL; /* Prevent any new port operations (e.g. from fops) */
	mutex_unlock(&port->ops_lock);

The wwan_port itself survives removal because wwan_port_fops_open() ->
wwan_port_get_by_minor() -> class_find_device() holds a device reference
that is only dropped in wwan_port_fops_release(). So a process that keeps
an fd open on an AT or QCDM chardev across a modem unplug or a driver
unbind, and then issues TIOCMSET/TIOCMBIC/TIOCMBIS, reaches this
dereference with ops == NULL.

Every other ops access in the file is guarded, including the new hunk in
wwan_port_op_stop() above:

	wwan_port_op_start():  if (!port->ops) { ret = -ENODEV; ... }
	wwan_port_fops_poll(): if (port->ops && port->ops->tx_poll)
	wwan_port_op_stop():   if (port->ops && port->type == WWAN_PORT_AT && ...

Separately, this call site holds only data_lock, not ops_lock, whose comment
reads:

	struct mutex ops_lock; /* Serialize ops + protect against removal */

Can ->dtr_rts() therefore run concurrently with, or after, ->stop() and
driver teardown? With the driver added later in this series,
wwan_port_get_drvdata() returns NULL once wwan_port_unregister_wwan() has
done dev_set_drvdata(&port->dev, NULL), so mhi_wwan_ctrl_send_dtr() would
dereference a NULL mhiwwan as well.

> +			port->ops->dtr_rts(port,
> +					   !!(port->at_data.mdmbits &
> +					      (TIOCM_DTR | TIOCM_RTS)));

[Severity: Medium]
Does this reduction lose the independent state of the two lines?

After first open the core sets mdmbits = TIOCM_DTR|TIOCM_RTS. Consider the
usual software hangup:

	ioctl(TIOCMBIC, &(int){TIOCM_DTR})
	  port->at_data.mdmbits &= ~TIOCM_DTR;      /* leaves TIOCM_RTS */
	  !!(mdmbits & (TIOCM_DTR | TIOCM_RTS))     /* still true */
	  port->ops->dtr_rts(port, true);

DTR stays asserted at the driver while TIOCMGET reports it clear. In the
other direction, a TIOCMBIS with TIOCM_RTS alone also yields on = true, and
the consumer added later in this series maps that to both lines:

	mhi_wwan_ctrl_dtr_rts():  on ? TIOCM_DTR | TIOCM_RTS : 0

so DTR gets asserted without userspace asking for it. TTY routes these
ioctls to tty_operations->tiocmset(tty, set, clear) with separate masks for
that reason. Would a set/clear mask pair in the op signature be preferable
here, given that widening it later is an ops-struct change?

Also, ->dtr_rts is invoked on every TIOCM* command even when the resolved
boolean is unchanged. Is the redundant driver-side signalling intended?

>  		break;
>  	}
>  
> diff --git a/include/linux/wwan.h b/include/linux/wwan.h
> index 1e0e2cb53579..a7684950d73b 100644
> --- a/include/linux/wwan.h
> +++ b/include/linux/wwan.h
> @@ -57,6 +57,8 @@ struct wwan_port;
>   * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
>   *               to the device.
>   * @tx_poll: Optional routine that sets additional TX poll flags.
> + * @dtr_rts: Optional routine that asserts (on=true) or de-asserts (on=false)
> + *           the DTR and RTS modem control lines.

Related to the previous comment: this text describes both lines moving
together, but the ioctls permit mixed states, and the caller passes true
whenever either bit is set. Can the header text and the caller's reduction
both be correct?

>   *
>   * The wwan_port_ops structure contains a list of low-level operations
>   * that control a WWAN port device. All functions are mandatory unless specified.
> @@ -70,6 +72,7 @@ struct wwan_port_ops {
>  	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
>  	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
>  			    poll_table *wait);
> +	void (*dtr_rts)(struct wwan_port *port, bool on);
>  };

[ ... ]
-- 
pw-bot: cr
