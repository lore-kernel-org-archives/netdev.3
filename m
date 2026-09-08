Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F908337107;
	Tue,  8 Sep 2026 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838994; cv=none; b=CoP1E0KM2ptPSXN/JIbHwU26//x4STEHZXlj+xSANjfLdhLtDfaPwj56ptDaGwoCxcik54bFi+69UXAfTLyWMNPzMu6fBGey2nmwlCz51N0jtNfZkAoAUV9Dh/Btygkn3LR3J8fUgxy6mRsgMc/HJhbYB9EiB9Th7ats7q2LJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838994; c=relaxed/simple;
	bh=JoCZbJNkQGnYIF9nt1EBJe2RNrAzxhRowkT+SPptSUs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eg+GvipwfA1Dvc1jjZIRU2hpB714s2d08jPePm/ZGvNtbhbk+NDNtjIVSt0tilne+BLmG75gqsbIk1NF+KxjBDonTZ9n9xodOWYobRVqP3UlAnboiktg13w12+PY8AMWjUIglXLdrdfcuaq5aauqGH9tc/Wzj7z1gcVBlELlxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSUKC9/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSUKC9/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A141F00A3A;
	Tue,  8 Sep 2026 03:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838983;
	bh=bEYfxCvOTYpsKc+p1y96lsApMRpaSU0NyNDjzJEVjGc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dSUKC9/QthhdLJb/Ok+NaQCgz42O7EQrDRru2Tk/ipOcEY4dC2OfcG8riUN5aOYPR
	 gfOCDViBGgbtLHj/YxMWLdYKBQsOOkaIwevZP23Kjd5R4t2L2yC8E4QRLMqr5vrfhR
	 0m3BlW5fS+6xIIWT9aNw+QcJHPdHPjlYtxQsnArUgADEsXcWK5/aQK7RctzqF6ICK/
	 P1Rrl1S4Ql8V0l6pzUMMCC3XaLnDtcfDysK9fifmiyw9P6Dz49Pg3fS1KK7avgrotA
	 5HDhWpTCySKnXFW3Ux4zXE0TeLusiV1T+ALsZ/XUmOltRQeF6hx7mIn5cydfnVt1YC
	 kjh1NO00ELnIA==
Subject:
 Re: [PATCH net v2] usbnet: fix smp_processor_id() use in preemptible context
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Date: Tue, 08 Sep 2026 03:43:02 +0000
Message-ID: <178883898204.219967.14658814972021382191@kernel.org>
In-Reply-To: <20260905224553.595766-1-omermetekaya0@gmail.com>
References: <20260905224553.595766-1-omermetekaya0@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] The commit message's premise is only true for one of the two
  changed sites, and the Fixes: tag is provably wrong.
- [Medium] The patch replaces the arch-tuned u64_stats irqsave helpers
  with an unconditional local_irq_save()/local_irq_restore() pair around…

--

usbnet: fix smp_processor_id() use in preemptible context

This patch moves the this_cpu_ptr() lookup of dev->net->tstats inside a
local_irq_save()/local_irq_restore() region in usbnet_skb_return() and
tx_complete(), and switches the u64_stats writers from the irqsave
helpers to the plain begin/end variants.

Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d

Two questions on the changelog first:

>     usbnet_skb_return() and tx_complete() call this_cpu_ptr() before
>     disabling IRQs, which triggers a BUG when running with PREEMPT_FULL:

[Severity: Medium]
Is the "usbnet_skb_return()" half of that sentence reachable?  Every
caller I can find already runs with preemption disabled.

rx_process() -> usbnet_skb_return() is only reached from usbnet_bh(),
which is either the dev->delay timer callback:

	timer_setup(&dev->delay, usbnet_bh, 0);

or run from usbnet_bh_work() queued on the BH workqueue:

	queue_work(system_bh_wq, &dev->bh_work);

and BH work items execute from workqueue_softirq_action(), i.e. softirq
context.  The minidriver ->rx_fixup() call sites (asix_common.c,
cdc_ncm.c, rndis_host.c, cx82310_eth.c, lg-vl600.c, ...) are all invoked
from that same rx_process() context.

The one remaining caller explicitly disables BH around the loop:

	local_bh_disable();
	clear_bit(EVENT_RX_PAUSED, &dev->flags);

	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
		usbnet_skb_return(dev, skb);
	...

That leaves tx_complete(), which really can run in preemptible task
context when the HCD does not use HCD_BH and usb_hcd_giveback_urb()
completes "in the caller's context".  Would it make sense to describe the
change as a tx_complete() fix, or is there an RX path that reaches
usbnet_skb_return() with preemption enabled?

>     Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")

[Severity: Medium]
Does this Fixes: tag point at the right commit?  43daa96b166c is from
2016 and only added usbnet_pause_rx()/usbnet_resume_rx() calls to
usbnet_change_mtu() plus an EVENT_RX_PAUSED test in usbnet_bh(); it never
touched the stats code.  git blame on the pre-patch tx_complete() block
shows:

  af0c351cc34857 (Heiner Kallweit 2020-11-10) struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
  2695578b896aea (Eric Dumazet   2018-03-05) flags = u64_stats_update_begin_irqsave(&stats64->syncp);

Should the tag name af0c351cc34857 instead, so that stable backports land
in trees that actually contain the code being changed?

> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index a19ecf718f36a..6a48f38e105d4 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -338,10 +338,13 @@ void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
>  	if (skb->protocol == 0)
>  		skb->protocol = eth_type_trans(skb, dev->net);
>  
> -	flags = u64_stats_update_begin_irqsave(&stats64->syncp);
> +	local_irq_save(flags);
> +	stats64 = this_cpu_ptr(dev->net->tstats);
> +	u64_stats_update_begin(&stats64->syncp);
>  	u64_stats_inc(&stats64->rx_packets);
>  	u64_stats_add(&stats64->rx_bytes, skb->len);
> -	u64_stats_update_end_irqrestore(&stats64->syncp, flags);
> +	u64_stats_update_end(&stats64->syncp);
> +	local_irq_restore(flags);

[Severity: Medium]
Does this add a hardirq-off window on 64-bit where there was none?  In
include/linux/u64_stats_sync.h the 64-bit branch is:

	static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp) { }
	static inline void __u64_stats_update_end(struct u64_stats_sync *syncp) { }
	static inline unsigned long __u64_stats_irqsave(void) { return 0; }

so u64_stats_update_begin_irqsave() masked nothing on 64-bit, while
local_irq_save() masks unconditionally.  usbnet_skb_return() runs once
per received packet, so this looks like a new per-packet interrupts-off
region for all 64-bit builds, PREEMPT_RT included.

The changelog describes it as ordering only:

>     Fix by saving IRQs first with local_irq_save(), then calling
>     this_cpu_ptr() and using the non-irqsave variants of u64_stats
>     update helpers, since IRQs are already disabled at that point.

Since only preemption/migration needs to be suppressed to make
this_cpu_ptr() legal, would get_cpu_ptr()/put_cpu_ptr() around the
existing u64_stats_update_begin_irqsave()/u64_stats_update_end_irqrestore()
pair work here?  That keeps IRQ masking on 32-bit only, and matches the
core helper dev_sw_netstats_rx_add() in include/linux/netdevice.h:

	struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);

	u64_stats_update_begin(&tstats->syncp);

usbnet_resume_rx() already uses local_bh_disable() for the same purpose,
which would be another option.

> @@ -1298,13 +1301,16 @@ static void tx_complete(struct urb *urb)
>  	struct usbnet		*dev = entry->dev;
>  
>  	if (urb->status == 0) {
> -		struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
> +		struct pcpu_sw_netstats *stats64;
>  		unsigned long flags;
>  
> -		flags = u64_stats_update_begin_irqsave(&stats64->syncp);
> +		local_irq_save(flags);
> +		stats64 = this_cpu_ptr(dev->net->tstats);
> +		u64_stats_update_begin(&stats64->syncp);
>  		u64_stats_add(&stats64->tx_packets, entry->packets);
>  		u64_stats_add(&stats64->tx_bytes, entry->length);
> -		u64_stats_update_end_irqrestore(&stats64->syncp, flags);
> +		u64_stats_update_end(&stats64->syncp);
> +		local_irq_restore(flags);

[Severity: Medium]
Same question for the TX completion path: this site is the one that can
genuinely be entered preemptibly, but would get_cpu_ptr()/put_cpu_ptr()
plus the existing irqsave helpers be enough, rather than disabling
interrupts on every successful TX completion on 64-bit?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905224553.595766-1-omermetekaya0%40gmail.com
