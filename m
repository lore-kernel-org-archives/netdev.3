Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E11B4F0A;
	Fri,  9 Oct 2026 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525339; cv=none; b=eWBURvNDN2cVh4V+W/JjS73iC1y7frLJ7wJ2ojo17mvFJ2cMdkd//A/R6XVdwI3hexc8emFc4JByq0cZK4IqEAjpeKC1nMOZlohQpGrg7Ze8SoL5DM0v6AwY2JR4rxodEXcL4al0Yi8LiRRd3+zk3fGRSXCFp8jibZaG6Sg8ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525339; c=relaxed/simple;
	bh=IGoLwZgHM+A8k45W6DHg4WD6ZHMwtSlO7CCubNLI+io=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qw9yL50OGdF6mYEk/X+yvs7X3MuTaph5Xasc7YkC3ZETlbXhff6xpYBTkB6gFATV1T4w1DRyInjqi7fLhIfM5kaV4TTN0dxHcgQYlUucVmX2J80Hoaa99/SzMcBIs/5pt5FzGYAY1dRiUJx1tVd3aiNj4xxUWEW7eDQ6Up02e+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW/R5kRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW/R5kRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12741F000FF;
	Fri,  9 Oct 2026 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791525338;
	bh=z++ovmLCjLUQb7TShFLHPtLsuA2Bcf+FxL9MZyiRbuI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AW/R5kRvVobQcMcjPpus0isKodlrA+ms3ZWMSe5F2w/qjDg2npEK/3WkGaCqBmFWI
	 KAZNDNlhZuuKVpRKm5WqZze0DKIW4ZJyhyp0OrINXHDqu5ev1X7doBpoYePeH6aFcI
	 hsTDbZty93tM0wj/LfvY8fU20IMWnsXrTaj2iNI9NXAGjCaOiuFnqbhyaBxXblze8U
	 kSFORk8DznwqlCz4FNbWGTNV8mxzfLCo7Oks31tpz9LZJZXI7X2AoUw/lRrJ1vavZ0
	 u9MUf9vPWL20yl6YEN3l1fVg/9zYXyFKNXdu32L/0roX16JfVFAtFT2UFMImVjasfO
	 hDtbh3vlx1iMg==
Subject: Re: [PATCH v4 2/2] nfc: nci: uart: fix use-after-free of write_work
 on ldisc teardown
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, david@ixit.cz,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
 gio@octane.security
Date: Fri, 09 Oct 2026 05:55:37 +0000
Message-ID: <179152533733.434549.9573604181273544366@kernel.org>
In-Reply-To: <20261006115532.72100-3-shubham@octane.security>
References: <20261006115532.72100-3-shubham@octane.security>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 2 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Regression: CORE_RESET sent while the device is torn down
  never reaches the NFCC.
- [Low] The commit message describes the tty-hangup race wrongly.
- [Low] The new comment in nci_uart_tx_wakeup() is wrong as soon as the
  patch lands.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but two
  NCIUARTSETDRIVER ioctls can race on one tty (TOCTOU), orphaning an…
- [Medium] This problem wasn't introduced by this patch, but the TX state
  machine can lose a wakeup.
- [Medium] This problem wasn't introduced by this patch, but the driver-
  template registry has a lifetime race.
- [Low] This problem wasn't introduced by this patch, but tty->disc_data
  is published only after nu->ops.open() has registered the NCI device…

--

nfc: nci: uart: fix use-after-free of write_work on ldisc teardown

This patch gates nci_uart_tx_wakeup() on a new NCI_UART_READY bit taken
under a percpu rwsem. It reorders nci_uart_tty_close() so write_work is
cancelled before ops.close() runs and before the tx skbs are freed. It
also takes the module reference and sets READY before ops.open() in
nci_uart_set_driver(), and adds shared error labels to that path.

> Two paths can therefore (re)queue the write worker after the
> skbs are freed and run it against freed memory:
>
>  - a tty hangup invokes the ldisc ->write_wakeup() (nci_uart_tty_wakeup
>    -> nci_uart_tx_wakeup -> schedule_work), and

[Severity: Low]
Is this description of the hangup path accurate?

In tty_ldisc_hangup(), ->write_wakeup() is called under a tty_ldisc_ref()
reference. That reference is dropped before tty_ldisc_lock() is taken and
before ->close() runs:

drivers/tty/tty_ldisc.c:tty_ldisc_hangup() {
    ld = tty_ldisc_ref(tty);
    ...
        ld->ops->write_wakeup(tty);
    ...
    tty_ldisc_deref(ld);
    ...
    tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
}

Other wakeups go through tty_wakeup()->tty_ldisc_ref(). That call fails
while the ldisc semaphore is write-held during close. So it looks like no
tty-originated wakeup can run inside nci_uart_tty_close().

The hangup use-after-free seems to have a different cause. Work queued
just before close is still pending or running when the old code frees
nu->tx_skb and calls nu->ops.close().

For that path, moving cancel_work_sync() ahead of the frees is what closes
the window. The NCI_UART_READY gate only matters for the internal
nci_uart_send() path.

The changelog later says:

> neither the tty nor the internal send path can requeue write_work once it
> is cancelled

Could the changelog describe which reordering closes which window?

> diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
> index aa20e8603f327..a971fb3b1bbb6 100644
> --- a/net/nfc/nci/uart.c
> +++ b/net/nfc/nci/uart.c

[ ... ]

> @@ -58,13 +59,28 @@ static inline int nci_uart_queue_empty(struct nci_uart *nu)
>  
>  static int nci_uart_tx_wakeup(struct nci_uart *nu)
>  {
> +	/* This may be called in an IRQ context, so we can't sleep.  Therefore
> +	 * we try to acquire the read lock only, and if that fails we assume
> +	 * the tty is being closed, because that is the only time the write
> +	 * lock is taken (nci_uart_tty_close()).  If the write lock is ever
> +	 * taken elsewhere, this must be revisited.
> +	 */

[Severity: Low]
This isn't a bug, but is this comment accurate? The same patch also takes
the write lock in the err_ready path of nci_uart_set_driver():

err_ready:
	...
	percpu_down_write(&nu->tx_lock);
	clear_bit(NCI_UART_READY, &nu->tx_state);
	percpu_up_write(&nu->tx_lock);

Dropping the wakeup there is harmless because that path is also teardown.
Still, the comment says nci_uart_tty_close() is the only place the write
lock is taken.

> +	if (!percpu_down_read_trylock(&nu->tx_lock))
> +		return 0;
> +
> +	if (!test_bit(NCI_UART_READY, &nu->tx_state))
> +		goto out;
> +
>  	if (test_and_set_bit(NCI_UART_SENDING, &nu->tx_state)) {
>  		set_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> -		return 0;
> +		goto out;
>  	}

[Severity: Medium]
This is a pre-existing issue, but can a wakeup be lost here?
nci_uart_write_work() checks NCI_UART_TX_WAKEUP before it clears
NCI_UART_SENDING:

net/nfc/nci/uart.c:nci_uart_write_work() {
    ...
	if (test_bit(NCI_UART_TX_WAKEUP, &nu->tx_state))
		goto restart;

	if (nu->ops.tx_done && nci_uart_queue_empty(nu))
		nu->ops.tx_done(nu);

	clear_bit(NCI_UART_SENDING, &nu->tx_state);
}

Consider this interleaving:

CPU1 (nci_uart_write_work)
  dequeue loop ends with tx_q empty
  test_bit(NCI_UART_TX_WAKEUP) -> false

CPU2 (nci_uart_send)
  skb_queue_tail(&nu->tx_q, skb)
  nci_uart_tx_wakeup()
    test_and_set_bit(NCI_UART_SENDING) -> 1
    set_bit(NCI_UART_TX_WAKEUP)

CPU1
  tx_done skipped, queue not empty
  clear_bit(NCI_UART_SENDING)

The new skb then stays on nu->tx_q with no work scheduled until an
unrelated wakeup arrives, so the pending NCI command can time out.

nci_uart_tty_wakeup() also clears TTY_DO_WRITE_WAKEUP. A tty wakeup that
lands while SENDING is set therefore doesn't reliably rescue the frame.

hci_uart_tx_wakeup() and hci_uart_write_work() avoid this race. They set
TX_WAKEUP before test_and_set_bit(SENDING), and clear SENDING before
rechecking TX_WAKEUP.

Since this function is being rewritten to follow hci_uart, could it use
that ordering too?

> @@ -123,18 +139,46 @@ static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
>  	INIT_WORK(&nu->write_work, nci_uart_write_work);
>  	spin_lock_init(&nu->rx_lock);
>  
> -	ret = nu->ops.open(nu);
> -	if (ret) {
> -		kfree(nu);
> -		return ret;
> -	} else if (!try_module_get(nu->owner)) {
> -		nu->ops.close(nu);
> -		kfree(nu);
> -		return -ENOENT;
> +	ret = percpu_init_rwsem(&nu->tx_lock);
> +	if (ret)
> +		goto err_free;
> +
> +	/* Take the module reference and enable the write worker before the
> +	 * device is registered: ops.open() may already transmit (e.g. download
> +	 * firmware), and user space can use the interface as soon as it is
> +	 * registered.
> +	 */
> +	if (!try_module_get(nu->owner)) {
> +		ret = -ENOENT;
> +		goto err_rwsem;
>  	}

[Severity: Medium]
This is a pre-existing issue, but is the module reference still taken too
late? Earlier in nci_uart_set_driver(), the template is read from the
registry with no lock and no module reference held:

	if (!nci_uart_drivers[driver])
		return -ENOENT;
	...
	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));

The template lives in the nfcmrvl_uart module image.
nci_uart_unregister() clears the slot without any synchronization:

	nci_uart_drivers[nu->driver] = NULL;

Suppose an rmmod of nfcmrvl_uart completes between the slot check and
try_module_get(). Can the memcpy() then read freed module memory, or
try_module_get() run on a freed struct module?

Moving try_module_get() ahead of ops.open() narrows this, but the window
between lookup and reference remains. Triggering it needs CAP_SYS_MODULE
racing the ioctl.

> +
> +	set_bit(NCI_UART_READY, &nu->tx_state);
> +
> +	ret = nu->ops.open(nu);
> +	if (ret)
> +		goto err_ready;
> +
>  	tty->disc_data = nu;

[Severity: High]
This isn't a bug introduced by this patch, but can two concurrent
NCIUARTSETDRIVER ioctls on the same tty both get here?

tty_ioctl() takes only a shared ldisc reference before calling
ld->ops->ioctl. nci_uart_tty_ioctl() then checks tty->disc_data without
any serialization:

	case NCIUARTSETDRIVER:
		if (!nu)
			return nci_uart_set_driver(tty, (unsigned int)arg);
		else
			return -EBUSY;

tty->disc_data is stored only after nu->ops.open() returns, so the window
covers all of device registration. Both callers can allocate their own nu,
set NCI_UART_READY and register a separate NFC device. The second store
then overwrites tty->disc_data.

nci_uart_tty_close() tears down only the instance in tty->disc_data. The
first nu is never unregistered or freed, its write_work is never
cancelled, and it keeps its module reference.

Setting N_NCI and issuing this ioctl need no capability, so an
unprivileged pty user can repeat the race.

Once the tty has been freed, bringing the orphaned NFC device up looks
like it would use the freed nu->tty:

NFC_CMD_DEV_UP
  nci_open_device()
    nci_uart_send()
      nci_uart_tx_wakeup()          <- NCI_UART_READY is still set
        nci_uart_write_work()
          set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
          tty->ops->write(tty, skb->data, skb->len);

That last step needs NFC_CMD_DEV_UP, which is GENL_ADMIN_PERM.

hci_ldisc guards HCIUARTSETPROTO with test_and_set_bit(HCI_UART_PROTO_SET,
...). Would a similar guard work here?

[Severity: Low]
This is a pre-existing issue, but tty->disc_data is published only after
nu->ops.open() has registered the NCI device. In that window,
nci_uart_tty_wakeup() and nci_uart_tty_receive() return early because
disc_data is still NULL:

	struct nci_uart *nu = tty->disc_data;

	if (!nu)
		return;

A write_wakeup after a partial write, or response bytes arriving in this
window, are therefore dropped.

TX does not stall for good, because nci_uart_write_work() always clears
NCI_UART_SENDING at the end. The worst case seems to be one NCI command
timing out, for example a dev_up issued right after
nci_register_device(). This patch does not change that behaviour.

[ ... ]

> @@ -180,16 +224,24 @@ static void nci_uart_tty_close(struct tty_struct *tty)
>  	if (!nu)
>  		return;
>  
> -	kfree_skb(nu->tx_skb);
> -	kfree_skb(nu->rx_skb);
> +	/* Drain in-flight tx_wakeups and block new ones, so write_work cannot
> +	 * be requeued once it is cancelled below.
> +	 */
> +	percpu_down_write(&nu->tx_lock);
> +	clear_bit(NCI_UART_READY, &nu->tx_state);
> +	percpu_up_write(&nu->tx_lock);
>  
> -	skb_queue_purge(&nu->tx_q);
> +	cancel_work_sync(&nu->write_work);
>  
>  	nu->ops.close(nu);

[Severity: Medium]
Does this prevent the CORE_RESET sent during unregistration from reaching
the controller?

For nfcmrvl_uart, ops.close() ends up in nci_close_device(), which sends
CORE_RESET when NCI_UP is set:

nfcmrvl_nci_uart_close()
  nfcmrvl_nci_unregister_dev()
    nci_unregister_device()
      nci_close_device()
        __nci_request(ndev, nci_reset_req, ...)
          nfcmrvl_nci_send()
            nfcmrvl_uart_nci_send()
              nci_uart_send()
                skb_queue_tail(&nu->tx_q, skb)
                nci_uart_tx_wakeup()

NCI_UART_READY is already clear at this point. nci_uart_tx_wakeup() now
returns without scheduling write_work:

	if (!test_bit(NCI_UART_READY, &nu->tx_state))
		goto out;

The frame is never written to the tty. skb_queue_purge(&nu->tx_q) frees
it later.

Nothing else on this path quiesces the NFCC. nfcmrvl_uart_nci_close() is
a no-op, and nfcmrvl_nci_unregister_dev() neither calls
nfcmrvl_chip_halt() nor touches the reset GPIO.

Before this patch, write_work could still run during ops.close(). The
reset therefore reached the UART whenever the tty was still working at
ldisc close. Examples are a TIOCSETD switch, or a hangup where
tty_ldisc_hangup() runs before tty->ops->hangup().

If the ldisc is detached while the device is up and polling, can the NFCC
keep its RF and firmware state until the next power cycle, GPIO reset or
dev_up?

hci_ldisc makes the same choice by clearing HCI_UART_PROTO_READY before
hci_unregister_dev(). The commit message doesn't mention this behaviour
change for NCI UART, though.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006115532.72100-1-shubham%40octane.security
