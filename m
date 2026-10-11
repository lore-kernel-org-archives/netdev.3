Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9518536B90D;
	Sun, 11 Oct 2026 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756155; cv=none; b=oExlwxnqY7Z21o5F1ijz3/WK3Q3R00w11PUeyU2oYTc9LbXl9aq5CvyEkccZo7VbEmjilRUdKDkVrEFFtHgakaYcaS06ncDkkwV9AnRtDjTc9Qq07mvHtwZ9J0g5BIDZv7n00jOvew2dnJ0acQ2l4VZQ4zv9LQSeiS4dZgUJBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756155; c=relaxed/simple;
	bh=IOQ6Kn361gzXZN/eP3CuzAftBE8aA1w+SPfEslOnw+I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFrr0/FF/RZktS3NVGQGFpPyTjIFfmZcBQqQI5LTgX2dhKeipGEbbhY17QouAOJQ7DwxiR8GXOnDSFCheytjNNGnRAJgQ0F0DB0HFWkLOAocDYPzUB60O0hl6bUnmhzALPLNhZwpYoOlRnQaOVK7q+bHimwystYacFkqI9BbG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJA+fGFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJA+fGFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C15F1F0089B;
	Sun, 11 Oct 2026 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791756154;
	bh=tKnWZFpBWK3QVqTzr3bEg1UobV+MSNnPRYy46L24/j0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RJA+fGFY8N1J5xlRnoi+mvngNP5hv/KoJxGX4RtmWwAzQkJ1v2Px4VXy8sc8XKkeX
	 WLSn6Oa+r15kMWLvYu2/94b73uEglYyMwMj8ij3SjgnPReu+QviBy8T23Pzh2CKzcx
	 Kn0XfLfJMfoBtUC2fFeIJknKK7Nom1yn9m4Ugj9MKFUoNmbL/FJOThAJdLO4N8Jpwr
	 3eIzkpWpOQ/dQMR/HWpByffTCVU0YwtihofGxWhN3rxXBAmaGs0H4WFE/dliIIwkNH
	 QGlMzUZOv4VzBiLArQ0AX6eDk44rRf3qzN6mX89EawE4IoZAoRteO7st0Sj6a2FjJx
	 O9Lvm7Mhn2dVA==
Subject:
 Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 22:02:33 +0000
Message-ID: <179175615306.434549.2652185067157444525@kernel.org>
In-Reply-To: <20261007220311.113827-1-omermetekaya0@gmail.com>
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch takes dev->rxq_pause.lock with hardirqs enabled in
  two places.

Pre-existing issues:
- [High] usbnet_resume_rx() always queues dev->bh_work, and
  usbnet_change_mtu() reaches it even when the interface is down.

--

usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

This patch closes a race where usbnet_skb_return() could queue an skb on
rxq_pause after usbnet_resume_rx() had already cleared EVENT_RX_PAUSED
and drained the queue. On the slow path it now rechecks the flag under
rxq_pause.lock, and usbnet_resume_rx() clears the flag under the same
lock. The patch also moves queue_work() after local_bh_enable() in
usbnet_resume_rx().

> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index a19ecf718f36a..d1ec3ba1e10e6 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -329,9 +329,14 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
>  	unsigned long flags;
>  	int	status;
>  
> -	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
> -		skb_queue_tail(&dev->rxq_pause, skb);
> -		return;
> +	if (unlikely(test_bit(EVENT_RX_PAUSED, &dev->flags))) {
> +		spin_lock_bh(&dev->rxq_pause.lock);
> +		if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
> +			__skb_queue_tail(&dev->rxq_pause, skb);
> +			spin_unlock_bh(&dev->rxq_pause.lock);
> +			return;
> +		}
> +		spin_unlock_bh(&dev->rxq_pause.lock);
>  	}

[Severity: Medium]
Will lockdep complain now that this lock is taken with hardirqs enabled?

Before this patch, rxq_pause.lock was only taken through skb_queue_tail()
and skb_dequeue(). Both use spin_lock_irqsave(). Here the lock is taken
with spin_lock_bh(). usbnet_resume_rx() below takes it with plain
spin_lock() inside local_bh_disable().

usbnet_probe() initializes all four queues with the same inline helper,
so they appear to share one lockdep class:

usbnet_probe() {
    ...
	skb_queue_head_init (&dev->rxq);
	skb_queue_head_init (&dev->txq);
	skb_queue_head_init (&dev->done);
	skb_queue_head_init(&dev->rxq_pause);
    ...
}

defer_bh() relies on this too. It uses spin_lock_nested() for
dev->done.lock while it holds rxq.lock or txq.lock.

Some host controllers do not set HCD_BH (OHCI, UHCI, musb and others).
On those, usb_hcd_giveback_urb() runs the completion directly from the
HCD interrupt handler, so rx_complete()->defer_bh() takes that lock class
in hardirq:

defer_bh() {
	spin_lock_irqsave(&list->lock, flags);
	...
	spin_lock_nested(&dev->done.lock, SINGLE_DEPTH_NESTING);
    ...
}

With CONFIG_PROVE_LOCKING, wouldn't the first qualifying MTU increase
through usbnet_change_mtu()->usbnet_resume_rx() then trigger an
"inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage" report and turn
lockdep off?

No code takes rxq_pause.lock itself from hardirq today, so no real
deadlock is known. Using spin_lock_irqsave()/spin_unlock_irqrestore() in
both new critical sections would match every other sk_buff_head lock use
in usbnet.c.

> @@ -700,15 +705,16 @@ void usbnet_resume_rx(struct usbnet *dev)
>  	int num = 0;
>  
>  	local_bh_disable();
> +	spin_lock(&dev->rxq_pause.lock);
>  	clear_bit(EVENT_RX_PAUSED, &dev->flags);
> -
> +	spin_unlock(&dev->rxq_pause.lock);
>  	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
>  		usbnet_skb_return(dev, skb);
>  		num++;
>  	}
>  
> -	queue_work(system_bh_wq, &dev->bh_work);
>  	local_bh_enable();
> +	queue_work(system_bh_wq, &dev->bh_work);

[Severity: High]
This is a pre-existing issue, but moving queue_work() after
local_bh_enable() seems to widen a use-after-free window on dev->bh_work.

usbnet_change_mtu() can reach usbnet_resume_rx() while the interface is
down. It only needs dev->rx_urb_size == old_hard_mtu and a larger new RX
buffer:

usbnet_change_mtu() {
    ...
	if (dev->rx_urb_size == old_hard_mtu) {
		dev->rx_urb_size = dev->hard_mtu;
		if (dev->rx_urb_size > old_rx_urb_size) {
			usbnet_pause_rx(dev);
			usbnet_unlink_rx_urbs(dev);
			usbnet_resume_rx(dev);
		}
	}
    ...
}

If the device is then disconnected, unregister_netdev() does not call
ndo_stop for a device that is not IFF_UP:

netif_close_many() {
    ...
		if (!(dev->flags & IFF_UP))
			list_del_init(&dev->close_list);
    ...
}

So usbnet_stop() and its cancel_work_sync(&dev->bh_work) never run.
usbnet_disconnect() cancels only kevent before it frees the netdev:

usbnet_disconnect() {
    ...
	unregister_netdev(net);

	cancel_work_sync(&dev->kevent);
    ...
	free_netdev(net);
}

If bh_work is still pending at that point, can the BH workqueue run
usbnet_bh_work()->usbnet_bh() on the freed struct usbnet (dev->done,
dev->bql_spinlock, dev->wait, dev->net)?

Before this patch, queue_work() ran inside the local_bh_disable()
section. The work therefore almost always ran at local_bh_enable(),
before usbnet_resume_rx() returned.

Now the work is queued from process context with BHs enabled, so the
softirq is handed to ksoftirqd. The work can stay pending after the MTU
change returns. With threadirqs, or with ksoftirqd starved on that CPU,
it could stay pending through unregister_netdev() and free_netdev() on
another CPU.

Would it make sense to add cancel_work_sync(&dev->bh_work) to
usbnet_disconnect() before free_netdev(), once further submissions are
blocked?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007220311.113827-1-omermetekaya0%40gmail.com
