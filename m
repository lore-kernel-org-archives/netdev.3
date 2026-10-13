Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6A522EFF;
	Tue, 13 Oct 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912232; cv=none; b=iWyZfsEnrnJDBpIzLYxQ7Q8DHuwkCPF+Yem24Uznv5ZjE7443sTAcXuWmQgpEkoQBzqYWSkgdmacqQ/+Vq3HuS2/rdowsKF7VeZw0xYqklQ0rwgs4k9Or04IGUFtE29A4kSbzy4vXb97k+ZAWlfM3dfYwOvxcedZQiXxaS8W2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912232; c=relaxed/simple;
	bh=ZBX/bwUQFb1q4SA1VSX33XP71BD0E0yj2dLx/8R5oEQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rokekTlDfBAUZ3wR9DC3Jo08VrJ+cCrcUZkHRyaiKcExhAmjzInHlTy6QIN3qW00w/ZSKbs0wM9bN2I6ocQrRpvWCv4zyL0ORJZD/FbaIxUMTEezZWts2iTAgv5KuYfuppiEHwg9gJVY0p9RoGyG/czbRRwbJX1oD6oo7JRxiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6aOdfG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6aOdfG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CBD1F000FF;
	Tue, 13 Oct 2026 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912230;
	bh=drDOPzr2nRrD+iaQx9Uo11Ocys6Yy8DVgXwY17hRO3I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F6aOdfG2ziFr8sxJeYMG7+w9ggBsCBjroVmVBb6D6oEJGb9jR+JaibAZhQU/bv6VK
	 /2WwA5Q4mdNcDU+RpKUKwfOUEurNLzciel1GqBamsht1V3SzvbcAV46YmdOCALyUXI
	 14UpIYNEm5WXc00SnQXeHtITNaYmFrh+JCX4ZJs0aPQB10a/vzGUWZMhuc4XJ7nA61
	 ePv9TzZSFFElaVYRXrWoNAXT27t14ipYfnjCHG/evUJPZ8LAFJtZa6LAl3MB2SnGK0
	 lDrvIdjAxuCnrEn+vHyjMIpYDzMT0MzXJg2yKMu6OXTgMnfDIOk1hrn5lohkx8f43S
	 G/DJSKpSCF43g==
Subject: Re: [PATCH net-next v9 1/2] net: wwan: core: propagate modem control
 signals to port drivers
From: netdev-bot+sashiko@kernel.org
To: peter.hunt@opengear.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, dnlplm@gmail.com,
 johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 17:23:49 +0000
Message-ID: <179191222962.434549.5982381221454218948@kernel.org>
In-Reply-To: <20261012172219.3668624-2-peter.hunt@opengear.com>
References: <20261012172219.3668624-2-peter.hunt@opengear.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `wwan_port_fops_at_ioctl()` now does `ACQUIRE(mutex_intr,
  lock)(&port->ops_lock)` before its `switch`, so every ioctl on an…
- [Medium] `wwan_port_fops_at_ioctl()` now holds `port->ops_lock` for the
  whole function, via a function-scope ACQUIRE guard, across every user-…
- [Low] Not a valid finding (baseline decision: false).
- [Low] The comments say the wwan open/close DTR handling works 'as a TTY
  does', but the code ignores the baud field of the termios state it…
- [Low] The new `->dtr_rts` kernel-doc in include/linux/wwan.h says the
  op is 'Called on first open, on last close if HUPCL is set, on port…

--

net: wwan: core: propagate modem control signals to port drivers

This adds an optional ->dtr_rts() operation to struct wwan_port_ops. The
wwan core calls it on first open, on last close when HUPCL is set, on
removal of an open port, and when TIOCMSET/TIOCMBIS/TIOCMBIC change DTR or
RTS on an AT port. The separate data_lock is removed, and the AT/QCDM
termios and TIOCM state is now protected by ops_lock, which the ioctl
handler takes interruptibly.

> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ffbcf11e4e681..27ae6583d3e08 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c

[ ... ]

> @@ -653,7 +654,10 @@ struct wwan_port *wwan_create_port(struct device *parent,
>  	mutex_init(&port->ops_lock);
>  	skb_queue_head_init(&port->rxq);
>  	init_waitqueue_head(&port->waitqueue);
> -	mutex_init(&port->data_lock);
> +
> +	/* AT ports hang up on last close by default, as a TTY does */
> +	if (type == WWAN_PORT_AT)
> +		port->at_data.termios.c_cflag = HUPCL;
>  
>  	port->dev.parent = &wwandev->dev;
>  	port->dev.type = &wwan_port_dev_type;
> @@ -679,12 +683,44 @@ struct wwan_port *wwan_create_port(struct device *parent,
>  }
>  EXPORT_SYMBOL_GPL(wwan_create_port);
>  
> +/* Raise DTR/RTS on first open of an AT port, as a TTY does. Called with
> + * ops_lock held.
> + */
> +static void wwan_port_raise_dtr_rts(struct wwan_port *port)
> +{
> +	lockdep_assert_held(&port->ops_lock);
> +
> +	if (port->type != WWAN_PORT_AT || !port->ops->dtr_rts)
> +		return;
> +
> +	port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
> +	port->ops->dtr_rts(port, port->at_data.mdmbits);
> +}

[Severity: Low]
The comments here and in wwan_create_port() say this behaves as a TTY
does. Is the baud field of the termios taken into account anywhere?

wwan_create_port() sets c_cflag to just HUPCL, so TCGETS reports B0 to
userspace. Even so, wwan_port_raise_dtr_rts() asserts DTR/RTS on every
first open. On a TTY, the lines are only raised when the baud rate is
non-zero:

drivers/tty/tty_port.c:tty_port_block_til_ready() {
    ...
		if (C_BAUD(tty))
			tty_port_raise_dtr_rts(port);
    ...
}

The TTY default is also tty_std_termios (B38400 | CS8 | CREAD | HUPCL),
not bare HUPCL.

In the same way, a TCSETS with B0 only stores the termios here and never
calls ->dtr_rts(). A TTY would drop DTR in that case. Examples are
stty -F /dev/wwan0at0 0, or the POSIX hang-up of cfsetospeed(B0) followed
by tcsetattr().

Separately, the kernel-doc says "Called on first open", but the call only
happens when ->start() succeeds.

Should the comments make a weaker claim? Alternatively, could the default
termios use a non-zero baud rate so that TCGETS matches what the driver
was told?

> +
> +/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
> + * the lines are only dropped if HUPCL is set, as for a TTY, on port
> + * removal they are always dropped.
> + */
> +static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_only)
> +{
> +	lockdep_assert_held(&port->ops_lock);
> +
> +	if (port->type != WWAN_PORT_AT || !port->ops->dtr_rts)
> +		return;
> +	if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL))
> +		return;
> +
> +	port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
> +	port->ops->dtr_rts(port, port->at_data.mdmbits);
> +}
> +
>  void wwan_remove_port(struct wwan_port *port)
>  {
>  	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
>  
>  	mutex_lock(&port->ops_lock);
>  	if (port->start_count) {
> +		wwan_port_drop_dtr_rts(port, false);
>  		port->ops->stop(port);
>  		port->start_count = 0;
>  	}

[Severity: Low]
The comment above says "on port removal they are always dropped". The
->dtr_rts kernel-doc in include/linux/wwan.h also lists "on port removal"
without any condition. Is that accurate, given that the drop sits inside
the if (port->start_count) block?

The commit message describes clearing HUPCL as the way to keep DTR
asserted across close. If userspace does that and then closes the port,
wwan_port_op_stop() returns early in wwan_port_drop_dtr_rts(). A later
wwan_remove_port() then sees start_count == 0, so the driver never gets a
->dtr_rts() call on removal.

The behaviour itself matches a TTY. Could the comment and the kernel-doc
say that the lines are only dropped when a port is removed while still
open?

[ ... ]

> @@ -979,9 +1020,15 @@ static __poll_t wwan_port_fops_poll(struct file *filp, poll_table *wait)
>  static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  				    unsigned long arg)
>  {
> -	int ret = 0;
> +	int ret;
>  
> -	mutex_lock(&port->data_lock);
> +	/* ops_lock serialises the termios/TIOCM state with port ops and
> +	 * removal. A blocking write holds it too, so wait interruptibly.
> +	 */
> +	ACQUIRE(mutex_intr, lock)(&port->ops_lock);
> +	ret = ACQUIRE_ERR(mutex_intr, &lock);
> +	if (ret)
> +		return ret;

[Severity: Medium]
The lock is now taken before the switch, so every ioctl on an AT/QCDM
port waits on ops_lock. That includes TCGETS, TCFLSH,
TIOCEXCL/TIOCNXCL/TIOCGEXCL, and commands that end up in the default
-ENOIOCTLCMD case.

FIONREAD is one of those, because wwan_port_fops_ioctl() tries the AT
handler first:

drivers/net/wwan/wwan_core.c:wwan_port_fops_ioctl() {
    ...
		res = wwan_port_fops_at_ioctl(port, cmd, arg);
		if (res != -ENOIOCTLCMD)
			return res;
	}

	switch (cmd) {
	case TIOCINQ: {	/* aka SIOCINQ aka FIONREAD */
    ...
}

wwan_port_op_tx() holds ops_lock across ->tx_blocking(). For
rpmsg_wwan_ctrl that is a blocking rpmsg_send(). Suppose thread A is in a
blocking write():

wwan_port_fops_write()
  wwan_port_op_tx()
    mutex_lock(&port->ops_lock)
    port->ops->tx_blocking()
      rpmsg_send()

Thread B's ioctl(FIONREAD) or tcgetattr() now waits behind it. A signal
during that wait makes mutex_lock_interruptible() return -EINTR. That
value is not -ENOIOCTLCMD, so it goes straight back to userspace, and
SA_RESTART won't restart the call.

Before this patch these paths only took data_lock, which the write path
never held.

Could ops_lock be taken only for the commands that touch the
termios/TIOCM state or call ->dtr_rts()?

[ ... ]

> @@ -1024,18 +1082,24 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
>  	case TIOCMSET:
>  	case TIOCMBIC:
>  	case TIOCMBIS: {
> -		int mdmbits;
> +		int mdmbits, old = port->at_data.mdmbits;
>  
>  		if (copy_from_user(&mdmbits, (int __user *)arg, sizeof(int))) {

[Severity: Medium]
The ACQUIRE guard holds ops_lock for the whole function, so several user
memory accesses now run with ops_lock held:

  - this copy_from_user()
  - the copy_to_user() calls for TCGETS/TCGETS2
  - the copy_from_user() calls for TCSETS*/TCSETS2*
  - the put_user() for TIOCMGET

Can userspace hold ops_lock indefinitely this way?

Suppose arg points into memory whose page fault never completes, for
example an mmap of a file on a FUSE mount whose daemon never answers. The
thread then sleeps in the fault handler with ops_lock held. The
interruptible acquisition doesn't help once the lock is owned.

wwan_remove_port(), wwan_port_op_start(), wwan_port_op_stop(),
wwan_port_op_tx() and wwan_port_fops_poll() all take ops_lock with plain
mutex_lock(). Device removal, for example via mhi_wwan_ctrl_remove() or a
cdc-wdm disconnect, would then hang in D state:

ioctl(fd, TIOCMSET, ptr_into_fuse_mapping)
  wwan_port_fops_at_ioctl()
    ACQUIRE(mutex_intr, lock)(&port->ops_lock)
    copy_from_user()   <- waits on FUSE

wwan_remove_port()
  mutex_lock(&port->ops_lock)   <- blocks

Any other process that opens, closes or polls the port would block in the
same way.

Before this patch the ioctl user copies ran under the ioctl-private
data_lock. wwan_port_fops_write() copies user data before calling
wwan_port_op_tx(), so nothing touched user memory under ops_lock.

Would it work to copy the argument in before taking the lock, and copy
results out after dropping it, as the TTY core does?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012172219.3668624-1-peter.hunt%40opengear.com
