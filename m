Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA57471CE0;
	Fri, 16 Oct 2026 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143465; cv=none; b=qr7sXJSkvTEFbB+6jUtFOJPnPeU/gqxJ1F73YPe2PiFYnoguw3pDMyLub2fNcFDlpHDjGaaiwjVxvLCCgLEitLevUfQA8ACrO/WWh6Us51ATBsiYLSeqklcUs/r0Bb0BE2Zm/3zZW/eOe7hCTKGz4hc/K0pxiYQOJQW6IVHWt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143465; c=relaxed/simple;
	bh=e9gbeLWoGual7E/T5uFf4fnd+cwMhh5w3w0gTWnzGag=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tClTz4evJP6Bv77qQusyBRc2vNMZHBPuETLwq5IBUVJPRNMNlZMrNpIMGcvWcZBsrzxkSWodcq1Ohu1PCAHpgADP1EUwRkAiI5ZNnmS3kkuDAqi5zPVUPgMpBbnlLr8tmYspzlAa8vwNMPZ/X7vuYptkXJPvWrMPvqg9UDVu2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+DfBHHw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+DfBHHw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F61F000C4;
	Fri, 16 Oct 2026 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143463;
	bh=LQ2IT7TR1yICH3fFYYaeo1ICf/N7bybfC80lKaTGcLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X+DfBHHw9sTSENXkZd4TQRxyq1INaQqK59Np4H1rVrx/2Vvuc/hgyj7EiPGnccS0z
	 VcimmsElX/astSlSLZOvpwo1h0zYDIx+PABzb0ADp+ypD3Hk5fvLnqKEs3ZMMWVgFW
	 l9f3eabxVpyCOmuRdMKqe8bqyrxGMotikaDDAAjIy0MMHSCXTG035Vbgh1lcFMPCWU
	 b/dcmj2yJ2imgHMivTcWZhjeiUy4KcKYClXRF9r/R5thVsoAnvGIxMW348nMIjHjjL
	 4+AInFY9WmyxIIkkJacumavZqMe2P5pyMvx7Pn0N3MJTHA39LWB+astR6cLcOoNDyY
	 74mcXlLh+iY6A==
Subject: Re: [PATCH net-next v10 1/2] net: wwan: core: propagate modem control
 signals to port drivers
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, dnlplm@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 16 Oct 2026 09:37:42 +0000
Message-ID: <179214346234.434549.2545307661462448073@kernel.org>
In-Reply-To: <20261013183500.261229-2-peter.hunt@opengear.com>
References: <20261013183500.261229-2-peter.hunt@opengear.com>
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

- [Medium] The patch moves the AT/QCDM termios and TIOCM state from the
  private data_lock to ops_lock, but wwan_port_op_tx() holds ops_lock…

--

net: wwan: core: propagate modem control signals to port drivers

This adds an optional ->dtr_rts() operation to struct wwan_port_ops. The
wwan core calls it when an AT port is first opened, on last close if
HUPCL is set, on port removal and when TIOCMSET/TIOCMBIS/TIOCMBIC changes
DTR or RTS. The termios and TIOCM state is moved from data_lock to
ops_lock, and data_lock is removed.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e681..7097b58dafdea 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c

[ ... ]

> @@ -976,92 +1017,109 @@ static __poll_t wwan_port_fops_poll(struct file *filp, poll_table *wait)
>  }
>  
>  /* Implements minimalistic stub terminal IOCTLs support */
> -static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
> -				    unsigned long arg)
> +/* TCGETS/TCSETS and their termios2 variants. @size is the size of the user
> + * structure, a prefix of struct ktermios. As for the TIOCM ioctls, user
> + * memory is only accessed outside ops_lock.
> + */
> +static long wwan_port_termios_ioctl(struct wwan_port *port, bool set,
> +				    void __user *uarg, size_t size)
>  {
> -	int ret = 0;
> +	struct ktermios termios;
>  
> -	mutex_lock(&port->data_lock);
> +	if (!set) {
> +		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->ops_lock)
> +			termios = port->at_data.termios;

[Severity: Medium]
Can TCGETS and the other termios and TIOCM ioctls now block indefinitely
behind a blocking write() on the same AT port?

wwan_port_op_tx() holds ops_lock for the whole of ->tx_blocking():

drivers/net/wwan/wwan_core.c:wwan_port_op_tx() {
	mutex_lock(&port->ops_lock);
	...
	if (nonblock || !port->ops->tx_blocking)
		ret = port->ops->tx(port, skb);
	else
		ret = port->ops->tx_blocking(port, skb);
	...
}

Before this patch, these ioctls only took data_lock, and no TX path takes
data_lock. After this patch, TCGETS/TCSETS*/TCGETS2/TCSETS*2 in
wwan_port_termios_ioctl() and TIOCMGET/TIOCMSET/TIOCMBIS/TIOCMBIC in
wwan_port_fops_at_ioctl() all take ops_lock. They would sleep until an
in-flight blocking write finishes, or return -ERESTARTSYS if a signal
arrives first.

This seems reachable with in-tree drivers. rpmsg_wwan_ctrl registers
DATA4 and DATA1 as WWAN_PORT_AT, and its .tx_blocking calls rpmsg_send().
On SMD that ends up in __qcom_smd_send(), which has an untimed wait:

wwan_port_op_tx()
  mutex_lock(&port->ops_lock)
  rpmsg_wwan_ctrl_tx_blocking()
    rpmsg_send()
      __qcom_smd_send()
        wait_event_interruptible(channel->fblockread_event,
                qcom_smd_get_tx_avail(channel) >= tlen ||
                channel->state != SMD_CHANNEL_OPENED);

If the remote side never drains the FIFO, a tcgetattr(), tcsetattr() or
TIOCMGET from another thread or process could stay stuck until it gets a
signal. On a real TTY, TCGETS and tty_tiocmget()/tty_tiocmset() do not
take the tty write lock.

The commit message says the ioctls wait behind a blocking write and that
the lock is taken interruptibly. That makes the wait interruptible, but
the wait itself is still unbounded.

A driver that implements both .tx_blocking and .dtr_rts could also end
up in a circular wait, where the write only completes once the host
raises DTR, but TIOCMBIS(DTR) is stuck on ops_lock. No in-tree driver
does this right now: rpmsg_wwan_ctrl has no .dtr_rts and mhi_wwan_ctrl
has no .tx_blocking.

Could the termios/TIOCM state be kept under a lock the TX path does not
hold? If ->dtr_rts() needs to be serialised against removal, only that
call could take ops_lock.

> +		return copy_to_user(uarg, &termios, size) ? -EFAULT : 0;
> +	}
> +
> +	/* Commit only on success, a partial copy must not clear HUPCL */
> +	if (copy_from_user(&termios, uarg, size))
> +		return -EFAULT;
> +	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->ops_lock)
> +		memcpy(&port->at_data.termios, &termios, size);
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013183500.261229-1-peter.hunt%40opengear.com
