Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD174A92CD;
	Sun,  4 Oct 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147661; cv=none; b=AIBkm1ZVW2Fh8FRIRrY9rJNnKHnEF1sg/Aj2xRPwoD/QtA7MsX5R7tb80A5KkI+/2ONIy2ugxdd8sfY01qp/BSt2jVCAyyJpF4DelhFFBZkmemP2tgxucYYNRs/e7HIEgRmdmZahuQabuQ0zi/GVjsUay93hUvoXxjwKV8HL7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147661; c=relaxed/simple;
	bh=NHdlZAk4SSTWPHwTKUIqNnlBuJ28JKxIPaWWMniUZCg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+K89wlhoT3rhHE6fpq2tb639LAejXW8tJJKA75gN4v8T1XGCAI+Uv0UYzveDCmkywE+zHdSv3nhWiWFdbPaUTTuoGbB64tQQiGFlAarFgxroE6edLdQFM6cMx/xmcSMHpn7eJFv6mUi+Yp56pe0sEvHm2hX0+eAcJtoMvPFaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCi825HV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCi825HV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF42B1F00893;
	Sun,  4 Oct 2026 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791147653;
	bh=GTX2JEXjMONxgG6Zb71pboutBtnb2i8m9AdwUMuDpp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RCi825HVyaOCGFtndxrfd0lbAFi22UsCLPkwOJxgrn7vyRxnUGIXTkNhdD4l7AdpZ
	 VBRPq0JFFCptVcDcN1mlgK5zN0zeisUaaVjZyy205nmTbhjoNlmMJD7i8Qp/ykBZOg
	 5dceiHpv3lzjgka4rYLwCbMFaUlab+TjJB7eyaKLFpSthxPV+OVbpeEDxggqoztIPf
	 7gAwxHkRe4cXT+24LNODfNAAMiqLhUMvCcVjwnjqKw8G76mPCKELTwJqmj0ba5eta9
	 bqgpDo0RPdV7Tk4ZCY/52XQuZH57KNKOt1Bg6tez0vQIALpcrwHEawBjKaddpKQYqH
	 /xAkZYA8M6nzg==
Subject:
 Re: [PATCH net v5] usbnet: fix smp_processor_id() use in preemptible context
From: netdev-bot+sashiko@kernel.org
To: omermetekaya0@gmail.com
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Date: Sun, 04 Oct 2026 21:00:52 +0000
Message-ID: <179114765252.434549.11117691651073714185@kernel.org>
In-Reply-To: <20260930215047.718270-1-omermetekaya0@gmail.com>
References: <20260930215047.718270-1-omermetekaya0@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message is wrong about the usbnet_skb_return()
  hunk, and the Fixes tag is wrong for both hunks.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the
  EVENT_RX_PAUSED check-then-queue in usbnet_skb_return() is not atomic…

--

usbnet: fix smp_processor_id() use in preemptible context

This patch replaces this_cpu_ptr() with get_cpu_ptr()/put_cpu_ptr() for
the per-CPU tstats updates in usbnet_skb_return() and tx_complete(). With
this change, preemption is disabled before the per-CPU pointer is taken.
The existing _irqsave seqcount helpers are kept.

Closes: https://syzkaller.appspot.com/bug?extid=04cd90bb99c6ef81a65d

> usbnet_skb_return() and tx_complete() call this_cpu_ptr() before
> disabling preemption, which triggers a BUG when running with PREEMPT_FULL:
>
>   BUG: using smp_processor_id() in preemptible code in tx_complete

[Severity: Medium]
Is this description still accurate for usbnet_skb_return()?

Commit 327cd4b68b43 ("usbnet: Fix using smp_processor_id() in preemptible
code warnings") already put local_bh_disable()/local_bh_enable() around
the drain loop in usbnet_resume_rx():

drivers/net/usb/usbnet.c:usbnet_resume_rx() {
    ...
	local_bh_disable();
	clear_bit(EVENT_RX_PAUSED, &dev->flags);

	while ((skb = skb_dequeue(&dev->rxq_pause)) != NULL) {
		usbnet_skb_return(dev, skb);
    ...
}

Every other caller of usbnet_skb_return() is a minidriver rx_fixup
callback or rx_process(), and all of them are reached from usbnet_bh().
usbnet_bh() only runs from the dev->delay timer and from usbnet_bh_work
on system_bh_wq. Both of those are softirq context.

In the current tree, is the usbnet_skb_return() hunk hardening rather
than a fix for a live warning? The quoted splat is also in tx_complete(),
not in usbnet_skb_return().

The reference to PREEMPT_FULL also looks inaccurate. The warning comes
from check_preemption_disabled() under CONFIG_DEBUG_PREEMPT. The splat
quoted in 327cd4b68b43 was on a PREEMPT(voluntary) kernel.

> Fixes: 43daa96b166c ("usbnet: Stop RX Q on MTU change")

Is this the right Fixes tag? 43daa96b166c is from 2016, before usbnet
used this_cpu_ptr() anywhere. 327cd4b68b43 already uses the same tag for
the usbnet_resume_rx() path.

The per-CPU pointer in tx_complete() came from c8b5d129ee29 ("net:
usbnet: support 64bit stats"). The completion handler only became
preemptible after ed194d136769 ("usb: core: remove local_irq_save()
around ->complete() handler").

Would one of those be a more accurate Fixes target for the tx_complete()
hunk?

> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index a19ecf718f36a..84f97f448b2da 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -325,7 +325,7 @@ static void __usbnet_status_stop_force(struct usbnet *dev)
>   */
>  void usbnet_skb_return(struct usbnet *dev, struct sk_buff *skb)
>  {
> -	struct pcpu_sw_netstats *stats64 = this_cpu_ptr(dev->net->tstats);
> +	struct pcpu_sw_netstats *stats64;
>  	unsigned long flags;
>  	int	status;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but can the EVENT_RX_PAUSED
check at the top of usbnet_skb_return() race with usbnet_resume_rx()?

usbnet_skb_return() does:

	if (test_bit(EVENT_RX_PAUSED, &dev->flags)) {
		skb_queue_tail(&dev->rxq_pause, skb);
		return;
	}

usbnet_change_mtu() calls usbnet_pause_rx(), usbnet_unlink_rx_urbs() and
usbnet_resume_rx() in process context. Meanwhile usbnet_bh() on another
CPU can still be handling rx skbs that completed earlier:

CPU0 (usbnet_bh)                    CPU1 (usbnet_change_mtu)
rx_process()
  usbnet_skb_return()
    test_bit(EVENT_RX_PAUSED) true
                                    usbnet_resume_rx()
                                      clear_bit(EVENT_RX_PAUSED)
                                      skb_dequeue(&dev->rxq_pause) == NULL
                                      queue_work()
                                      local_bh_enable()
    skb_queue_tail(&dev->rxq_pause, skb)

The local_bh_disable() on CPU1 does not exclude CPU0. The rxq_pause
spinlock protects the list, but not the flag.

usbnet_bh() only drains dev->done. Would this skb then sit in rxq_pause
until the next MTU-driven resume, or until usbnet_purge_paused_rxq()
frees it at usbnet_stop()? The packet would be delayed and reordered, or
dropped.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930215047.718270-1-omermetekaya0%40gmail.com
