Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021800;
	b=uDb6RERZdRvFvRyomUA3E5PP9XU+BxkFkiUsbRM1nI7OVfQTMRhRduNSBJ0tjtRaaB9l
	 8+r7dBrmanJXsfAWkzDqSOZPVnq0zZqNJFqnDFvAj8s6lp8tduSFRcVY+9WVlmR13Eraw
	 Q4NIQIeFKV7Ii6B4Z5JwzPoY8nIV+dRwwFV1M+xWKlDl4VX0Uugde0G7FcEkA4YnwoztI
	 1M7ToLiyJrQRmEyZ6R06PCQjN3wj/Wf7+QdVfICViB6GFpT2hHnggOEs1ebxt5MZaVvnY
	 iN2GKJyWT9VixB/LLL5QMjOoEE4W8yYvBbhicRaeXnjbkJRnIAhhNj4B4ha96dZxMJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021800;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=u+3wSkSWQgwuFMFiViQDJVrhL9go48YADqXEr3eJRfg=;
	b=CfY41jv3fvhkbEDBGFNyjWkv8mJme6rPy8JwYID3377Zs+pBtD7Z/IOTqpcsBuZcK1l0
	 LddTvkuCpGaX6mQ03ZQd7Iw+aiz/apBygE4fMzOl281YjnmlHFhaC6M3+tkV19nOW+JWR
	 H1ytKqW8gd8j6nRbOem7N1SqYVeFsJBLjqWDplmjKIh8LxFpQGbxG6OgP2gtbyWvHhAhl
	 2CLMTI6vfVYHpMTsMiVHUq/mHNO7x2neTSt6Xe6fWctPy+szfRf34Enuqfm2Fy0U+dkD7
	 MvZ4zaGHM8quxLryH7yG9vZIqiKxFio9cz6yXhFarBrFWleyU+QVbrTwsFBZFQ5aGSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCJkpxxN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F43606A331;
	Sat,  7 Nov 2026 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCJkpxxN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC371F0089F;
	Sat,  7 Nov 2026 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794021800;
	bh=u+3wSkSWQgwuFMFiViQDJVrhL9go48YADqXEr3eJRfg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZCJkpxxNVsGOdQSrddRjDkfZaTK522LA5OBtNjKurGZQNSG4/SAZTYRvKV7j3g3UV
	 UyHqQsn6F7I43paClEUXnrrC7A1ymFx9Wav86aP6VtuoQJ7XiMj5JJCmXXEUzKq+MM
	 SuGoOga0lKQucj8itxnxycJW1VWgC77EZXOceDJPriPK3wjt5uVCkEZzvco2iv8h0R
	 EC1lU2kThtBpmcMsuyO/IcjPulZYvT8ZOSI1onKopX6s73VcktfP7DF/Am0Z6NoDc8
	 z4sqnLQY/c9nIeUe7ghnyCG52ysmxuBL188CWRN77PuB1LhcYBa9HYYBu0TybboYhg
	 LG+nsLLkWpmpg==
Subject:
 Re: [PATCH net v7 2/3] nfc: nci: uart: quiesce callbacks during teardown
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, david@ixit.cz,
 horms@kernel.org, gio@octane.security, kuba@kernel.org
Date: Sat, 07 Nov 2026 03:23:19 +0000
Message-ID: <179402179947.994134.10399672518212378012@kernel.org>
In-Reply-To: <20261104062026.80599-3-shubham@octane.security>
References: <20261104062026.80599-3-shubham@octane.security>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says teardown will "Balance tx_start() with
  tx_done() if teardown catches an active transmit burst".
- [Low] The commit message says nci_uart_tty_close() frees transport
  state "before ensuring that the UART write worker and receive callback…
- [Low] The new field comment in include/net/nfc/nci_core.h says
  `spinlock_t tx_lock; /* protects tx_state */`.
- [Low] nci_uart_set_ready() (net/nfc/nci/uart.c) calls
  nci_uart_queue_empty() with no lock.

--

nfc: nci: uart: quiesce callbacks during teardown

This patch adds a tx_lock and a CLOSING tx state to the generic NCI UART
layer. Teardown can then stop the write worker and receive callbacks before
transport state is freed. It also publishes the Marvell UART back-pointers
before nci_register_device(), and adds nci_ready/nci_quiesce hooks that roll
them back on failure and on unregister.

> nci_uart_tty_close() releases transport state before ensuring that the
> UART write worker and receive callback have stopped using it.

[Severity: Low]
Is the receive callback part of this accurate for the close path?

tty_ldisc_close() runs with the ldisc semaphore held for write:

drivers/tty/tty_ldisc.c:tty_ldisc_close() {
	lockdep_assert_held_write(&tty->ldisc_sem);
    ...
}

tty_port_default_receive_buf() only delivers data after it gets an ldisc
reference:

	ld = tty_ldisc_ref(tty);
	if (!ld)
		return 0;

tty_wakeup() also goes through tty_ldisc_ref(). So nci_uart_tty_receive()
and nci_uart_tty_wakeup() can't run at the same time as
nci_uart_tty_close(). During close, the only concurrent user of tx_skb,
rx_skb and tx_q appears to be nu->write_work.

The same applies here:

> and roll the state back if registration fails.  On close, detach TTY
> callback admission first but keep transmit available while the transport

The old code also cleared tty->disc_data before it used nu.

The new READY recheck under rx_lock in nci_uart_tty_receive() and the
nci_uart_rx_stop() calls look like they are needed for the failed-open path
instead. On that path, NCIUARTSETDRIVER runs under an ldisc read reference,
nfcmrvl_uart_nci_ready() publishes READY, and nci_register_device() then
fails. nfcmrvl_uart_nci_quiesce() rolls back while receive_buf can still
run.

Could the commit message say which race actually exists in close?

> diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
> index 529c8cf8861af..63671ea38c67b 100644
> --- a/net/nfc/nci/uart.c
> +++ b/net/nfc/nci/uart.c

[ ... ]

> @@ -64,24 +65,61 @@ static inline int nci_uart_queue_empty(struct nci_uart *nu)

[ ... ]

> +void nci_uart_tx_stop(struct nci_uart *nu)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	set_bit(NCI_UART_CLOSING, &nu->tx_state);
> +	spin_unlock_irqrestore(&nu->tx_lock, flags);
> +
> +	cancel_work_sync(&nu->write_work);
> +	clear_bit(TTY_DO_WRITE_WAKEUP, &nu->tty->flags);
> +
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	clear_bit(NCI_UART_SENDING, &nu->tx_state);
> +	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +	spin_unlock_irqrestore(&nu->tx_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(nci_uart_tx_stop);
> +
>  static void nci_uart_write_work(struct work_struct *work)
>  {
>  	struct nci_uart *nu = container_of(work, struct nci_uart, write_work);
>  	struct tty_struct *tty = nu->tty;
>  	struct sk_buff *skb;
> +	unsigned long flags;
>  
>  restart:
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	if (test_bit(NCI_UART_CLOSING, &nu->tx_state)) {
> +		clear_bit(NCI_UART_SENDING, &nu->tx_state);
> +		clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +		spin_unlock_irqrestore(&nu->tx_lock, flags);
> +		return;
> +	}
>  	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +	spin_unlock_irqrestore(&nu->tx_lock, flags);
>  
>  	if (nu->ops.tx_start)
>  		nu->ops.tx_start(nu);
> @@ -99,14 +137,55 @@ static void nci_uart_write_work(struct work_struct *work)
>  		kfree_skb(skb);
>  	}
>  
> -	if (test_bit(NCI_UART_TX_WAKEUP, &nu->tx_state))
> +	spin_lock_irqsave(&nu->tx_lock, flags);
> +	if (test_bit(NCI_UART_CLOSING, &nu->tx_state)) {
> +		clear_bit(NCI_UART_SENDING, &nu->tx_state);
> +		clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +		spin_unlock_irqrestore(&nu->tx_lock, flags);
> +		if (nu->ops.tx_done)
> +			nu->ops.tx_done(nu);
> +		return;
> +	}
> +	if (test_and_clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state)) {
> +		spin_unlock_irqrestore(&nu->tx_lock, flags);
>  		goto restart;
> +	}
> +	spin_unlock_irqrestore(&nu->tx_lock, flags);
>  
>  	if (nu->ops.tx_done && nci_uart_queue_empty(nu))
>  		nu->ops.tx_done(nu);

[Severity: High]
The commit message says teardown will "Balance tx_start() with tx_done() if
teardown catches an active transmit burst". Can nci_uart_write_work() still
exit after tx_start() without ever calling tx_done()?

Consider this sequence:

write_work                         nfcmrvl_uart_nci_quiesce()
restart: CLOSING clear
ops.tx_start()
  break_ctl(tty, 0)
write loop
test_and_clear_bit(TX_WAKEUP) true
spin_unlock_irqrestore()
                                   nci_uart_tx_stop()
                                     set_bit(NCI_UART_CLOSING)
                                     cancel_work_sync()
goto restart
restart: CLOSING set
  clear SENDING, TX_WAKEUP
  return

The CLOSING exit at restart: returns without calling ops.tx_done(), even
though tx_start() already ran earlier in the same burst. Only the CLOSING
branch after the write loop calls tx_done().

TX_WAKEUP can be set during the write loop by the close-time CORE_RESET,
sent via nci_close_device()->__nci_request()->nci_uart_send(). If the
closing task has a signal pending,
wait_for_completion_interruptible_timeout() returns early. Teardown then
reaches nci_uart_tx_stop() almost immediately.

There is a second path. If tty->ops->write() writes only part of the skb,
nu->tx_skb stays set. nci_uart_queue_empty() then returns false, so the
tx_done() call above is skipped, and SENDING is cleared while the worker
waits for a write wakeup. If teardown runs at that point, nci_uart_tx_stop()
cancels an idle work item and never calls tx_done() either.

For nfcmrvl with break_control, tx_start and tx_done look like this:

drivers/nfc/nfcmrvl/uart.c:nfcmrvl_nci_uart_tx_start() {
    ...
	/* Remove BREAK to wake up the NFCC */
	if (priv->config.break_control && nu->tty->ops->break_ctl) {
		nu->tty->ops->break_ctl(nu->tty, 0);
    ...
}

drivers/nfc/nfcmrvl/uart.c:nfcmrvl_nci_uart_tx_done() {
    ...
	if (priv->config.break_control && nu->tty->ops->break_ctl) {
		nu->tty->ops->break_ctl(nu->tty, -1);
    ...
}

So in both cases BREAK is left removed at teardown. Before this patch, in
the first path, cancel_work_sync() let the running worker finish and reach
tx_done().

The later patch in this series ("nfc: nfcmrvl: stop firmware work before
unregistering") doesn't touch net/nfc/nci/uart.c, so both paths are still
present at the end of the series.

Would it work to set a local started flag when tx_start() runs, and call
tx_done() from every CLOSING exit when it is set? nci_uart_tx_stop() could
also call tx_done() when a burst is still pending.

[ ... ]

> +void nci_uart_set_ready(struct nci_uart *nu)
> +{
> +	/* Publish transport fields before callbacks observe READY. */
> +	smp_mb__before_atomic();
> +	set_bit(NCI_UART_READY, &nu->flags);
> +
> +	if (!nci_uart_queue_empty(nu))
> +		nci_uart_tx_wakeup(nu);
>  }

[Severity: Low]
Is it safe to call nci_uart_queue_empty() here without tx_lock?

nci_uart_set_driver() calls nci_uart_set_ready() a second time after
nu->ops.open() returns. For nfcmrvl, by then nfcmrvl_nci_register_dev() has
already set READY through nfcmrvl_uart_nci_ready() and exposed the device
through nci_register_device().

Userspace can bring the device up in that window:

NFC_CMD_DEV_UP->nci_open_device()->CORE_RESET->nci_uart_send()

The write worker then makes plain stores to nu->tx_skb in
nci_uart_dequeue() and on partial writes, while this unlocked read of
nu->tx_skb runs. Before this patch, nci_uart_queue_empty() was only called
from the worker. Would KCSAN report this as a data race?

The handoff that restarts an already queued frame also seems to lack a full
barrier. This side does set_bit(READY) and then loads the queue. The sender
does skb_queue_tail() and then test_bit_acquire(READY) under tx_lock. That
is a store-buffering pattern the LKMM does not forbid. With nfcmrvl,
though, nothing can be queued before READY is first published.

[ ... ]

> @@ -136,21 +215,17 @@ static int nci_uart_set_driver(struct nci_uart *nu, unsigned int driver)

[ ... ]

>  err_module:
> -	cancel_work_sync(&nu->write_work);
> +	nci_uart_rx_stop(nu);
> +	nci_uart_tx_stop(nu);
>  	kfree_skb(nu->tx_skb);
>  	nu->tx_skb = NULL;
> -	kfree_skb(nu->rx_skb);
> -	nu->rx_skb = NULL;
>  	skb_queue_purge(&nu->tx_q);
> -	clear_bit(NCI_UART_SENDING, &nu->tx_state);
> -	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
> +	clear_bit(NCI_UART_CLOSING, &nu->tx_state);

[Severity: Low]
Is the new field comment in include/net/nfc/nci_core.h accurate?

	spinlock_t		tx_lock; /* protects tx_state */

This clear_bit() of NCI_UART_CLOSING runs without tx_lock. Every other
tx_state access the patch adds holds tx_lock.

It is safe today only because nci_uart_rx_stop() has already cleared
NCI_UART_READY, and nci_uart_tx_wakeup() checks CLOSING || !READY under the
lock.

Should this clear take tx_lock, or should the comment be narrowed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104062026.80599-1-shubham%40octane.security
