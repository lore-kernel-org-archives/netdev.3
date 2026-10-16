Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53248DB28;
	Fri, 16 Oct 2026 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792191508; cv=none; b=j++X9Z4tfCZ/zrVpxyntIdpJCm+AFL4lOUEoYl3NBkjARQb6Ypus4BCJp7zLKeeO5WCBTtrqNOC+vB0DJB7G1GYkXoHJ/M/PJeEdI0RtV4z26m9H4fBJZUFiBK/2MdOa/1LSsrInAThDWFLECsl9rvhwSD9UDsgZFn5eHPO9hkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792191508; c=relaxed/simple;
	bh=vqvvABVBzTGMebKz/IHc0AVIw4erDJUPvxE61OhS4Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTqo7gQOJzZ7Dt/KDhQRHAEHEm8JHFBca2T7MsZA7WjPwifiaR394lqSj1kno0q+ihFiXxAPKpftEvNWu1TMjpVnDZhosTjlmlSSwCEk4DdfvaIjp8Y9KxLHesJ06TQTFp15H5/+mvjT8/MtNAxZqUpGzwuka1nt7qvo+z/O1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJmnck2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJmnck2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFDD1F000C4;
	Fri, 16 Oct 2026 22:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792191506;
	bh=EwYRXxb65dU5pBBDG8naBKTasqjzlMLWFZHZF/jw8Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZJmnck2lGMYxZRZmBXW2oyIAi65yZueTyn8wlbxlJhIaYdOODi78PRC6yIVoPGPw4
	 Mv+Jqxmr4PaFLqO+/X+4JS+SUBCF0bbVBWezVJYXWEoK+v60l2DYPX0ldc32AUcffa
	 vHs86yv5E52hWNUl9lPe4leheba5r4SW6mImgeAeHxGt+3oT0iJab3hPIcqotrrDt+
	 Afi2qjrw3+rbTBovqrfyHuwRUoqBdlAZUcGre7KJo282+Rj0M1W7e+7cOh+mFDzxiu
	 bUf9YRwNzdnSiZFvCIQ5dG3OLsufeSMlzr2J6SYy61ZpBE19od8XWDtDkkM0Bx3uKp
	 uv1MQ1XXpJrjA==
Date: Fri, 16 Oct 2026 15:58:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] usbnet: fix EVENT_RX_PAUSED race in
 usbnet_skb_return()
Message-ID: <20261016155825.17d29015@kernel.org>
In-Reply-To: <179175615306.434549.2652185067157444525@kernel.org>
References: <20261007220311.113827-1-omermetekaya0@gmail.com>
	<179175615306.434549.2652185067157444525@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 22:02:33 +0000 netdev-bot+sashiko@kernel.org wrote:
> Will lockdep complain now that this lock is taken with hardirqs enabled?
> 
> Before this patch, rxq_pause.lock was only taken through skb_queue_tail()
> and skb_dequeue(). Both use spin_lock_irqsave(). Here the lock is taken
> with spin_lock_bh(). usbnet_resume_rx() below takes it with plain
> spin_lock() inside local_bh_disable().
> 
> usbnet_probe() initializes all four queues with the same inline helper,
> so they appear to share one lockdep class:
> 
> usbnet_probe() {
>     ...
> 	skb_queue_head_init (&dev->rxq);
> 	skb_queue_head_init (&dev->txq);
> 	skb_queue_head_init (&dev->done);
> 	skb_queue_head_init(&dev->rxq_pause);
>     ...
> }
> 
> defer_bh() relies on this too. It uses spin_lock_nested() for
> dev->done.lock while it holds rxq.lock or txq.lock.
> 
> Some host controllers do not set HCD_BH (OHCI, UHCI, musb and others).
> On those, usb_hcd_giveback_urb() runs the completion directly from the
> HCD interrupt handler, so rx_complete()->defer_bh() takes that lock class
> in hardirq:
> 
> defer_bh() {
> 	spin_lock_irqsave(&list->lock, flags);
> 	...
> 	spin_lock_nested(&dev->done.lock, SINGLE_DEPTH_NESTING);
>     ...
> }
> 
> With CONFIG_PROVE_LOCKING, wouldn't the first qualifying MTU increase
> through usbnet_change_mtu()->usbnet_resume_rx() then trigger an
> "inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage" report and turn
> lockdep off?
> 
> No code takes rxq_pause.lock itself from hardirq today, so no real
> deadlock is known. Using spin_lock_irqsave()/spin_unlock_irqrestore() in
> both new critical sections would match every other sk_buff_head lock use
> in usbnet.c.

Good suggestion. 
