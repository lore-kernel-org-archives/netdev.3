Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1AB490BF4;
	Thu,  8 Oct 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461405; cv=none; b=UnOJQX8pR6QYiwTKNBSCsmrTE9isg1R2G/uG/h8QjGnlvZTSJu1nUbDF4Af93SlJUxRi26qPfM5bPSN1WVtDBNtW/yJurKQkwsaomdfMgw3ISEySXVWsdGlBzY0wRVznxTnR9YgB/+LuPkaeOkXEqYq1l69tlIwPtEfbHB2djuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461405; c=relaxed/simple;
	bh=fm8hnLQ87j/HniBBSzjsIxMOM+8ZC5AwUf9bCYp/fx0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQu+Jhu9rrmBWDl0V27e+sz6qS+siRtBQNx+zaCgK3MdSSKiJuYQvFR2qaqFvTx7Y1Z/WLcTcH9w+UNbJRCPY2UNB0nkMG/QQtk3X+YP7fIzkoLFxMpaqnnxHhoqKekAT+iQXorS0/4aFj/Az+bTT+L2RxFUvm/HY7x+04W0NYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywa+2Zv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywa+2Zv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B971F000FF;
	Thu,  8 Oct 2026 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791461404;
	bh=hHfA58dTjNt9k2vhbq/4fIySxGEknhamS/nxV/UVryA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ywa+2Zv47v4FFXNSq7h4iRZADiC9Rl8CpqshiS871g7OPaPNIRt1C/EMMszZBtAOa
	 cLypixVxo83zvRt2G7bbq2gLh6LYvbhVIVMkAQ57ok2p4RXpLmWI2n8GTFcLp1fPZT
	 i6ej8coSHksSen6e3gvCnh5GxWBLrtJBAHHbtfHi0Dh/EvASo/+ACF7CPw6FV68Oi7
	 onLPR3oTDxKzF9G53gIjLW38FyVAVugMBQ5JjpTiCR6w0LpmYsV7Lq33k15p2QGPAM
	 QuPbKA0/H41Ykb8uAHACcEf6FJj99qMM1A3o7g8rKFWl9VdPPJKOdhTpk6WOlMoIQg
	 nBCUrKnzYVIvg==
Subject:
 Re: [PATCH net v2] usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 12:10:03 +0000
Message-ID: <179146140323.434549.4025996988733762970@kernel.org>
In-Reply-To: <20261006120825.342164-1-omermetekaya0@gmail.com>
References: <20261006120825.342164-1-omermetekaya0@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch brings back the syzbot 'BUG: using smp_processor_id()
  in preemptible code' bug that commit 327cd4b68b43 ('usbnet: Fix using…

--

usbnet: fix EVENT_RX_PAUSED race in usbnet_skb_return()

This patch targets a race between usbnet_skb_return() and
usbnet_resume_rx(). It moves clear_bit() in usbnet_resume_rx() under
rxq_pause.lock, and usbnet_skb_return() now takes that lock to recheck
EVENT_RX_PAUSED on the slow path. As part of this, the
local_bh_disable()/local_bh_enable() pair in usbnet_resume_rx() is
replaced by a spin_lock_bh() section that covers only clear_bit().

> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index a19ecf718f36a..dc340ea248c6b 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c

[ ... ]

> @@ -699,8 +704,9 @@ void usbnet_resume_rx(struct usbnet *dev)
>  	struct sk_buff *skb;
>  	int num = 0;
>  
> -	local_bh_disable();
> +	spin_lock_bh(&dev->rxq_pause.lock);
>  	clear_bit(EVENT_RX_PAUSED, &dev->flags);
> +	spin_unlock_bh(&dev->rxq_pause.lock);
>  
>  	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
>  		usbnet_skb_return(dev, skb);
> @@ -708,7 +714,6 @@ void usbnet_resume_rx(struct usbnet *dev)
>  	}
>  
>  	queue_work(system_bh_wq, &dev->bh_work);
> -	local_bh_enable();

[Severity: High]
Does this bring back the syzbot warning that was fixed by commit
327cd4b68b43 ("usbnet: Fix using smp_processor_id() in preemptible code
warnings")?

That commit added the local_bh_disable()/local_bh_enable() pair around
the drain loop and queue_work(). With this patch, BHs come back on right
after clear_bit(). The drain loop then runs in preemptible process
context when it is reached from the MTU change path:

dev_ioctl()
  dev_set_mtu()
    usbnet_change_mtu()
      usbnet_resume_rx()
        usbnet_skb_return()

usbnet_skb_return() starts with:

	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);

With CONFIG_DEBUG_PREEMPT, this should produce the same "BUG: using
smp_processor_id() in preemptible" splat that 327cd4b68b43 quotes.

Without debug options, the task could migrate after this_cpu_ptr(). It
would then update another CPU's pcpu_sw_netstats while that CPU's own BH
RX path (usbnet_bh()->rx_process()->usbnet_skb_return()) writes the same
counters. Can RX stats updates be lost this way?

On 64-bit, u64_stats_inc() and u64_stats_add() are local64 operations
and are not safe across CPUs. On 32-bit, two writers on one syncp could
corrupt the seqcount. Readers in dev_fetch_sw_netstats() could then keep
retrying.

The commit message doesn't mention that the BH protection around the
drain loop is removed. The patch also carries Fixes: 43daa96b166c, so it
could bring this back into stable trees that already have 327cd4b68b43.

Could the local_bh_disable()/local_bh_enable() pair stay around the
whole drain loop and queue_work()? Inside that region, rxq_pause.lock
could then be taken with spin_lock()/spin_unlock() just around
clear_bit().

>  
>  	netif_dbg(dev, rx_status, dev->net,
>  		  "paused rx queue disabled, %d skbs requeued\n", num);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006120825.342164-1-omermetekaya0%40gmail.com
