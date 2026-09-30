Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC5370D4D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736648; cv=none; b=FFiSFrudxzBTHRb9UEXAZd9YH5+F6lT9HtgWEPpn7w3CCt1iXCQ7chOrPL2miKA4+ZNGQfU36GlXvMsj3j/MBfJtYmMhTz0OQbUtDt6LfuV3b62PPlopFoX0fOjGGi0B2TDcDZW+84xowEDtAgKXw19R3Gc4qR3vTXWv5YXa5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736648; c=relaxed/simple;
	bh=CVF7TPDK1Gr+JDznsPqjy43KIHnuu1NIzWjlP6Xg+gc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSbtd3g1UQwiGRd37QInF1cb4heN4pxgBcdnUW57U962LZeQD2UcyyQs3XVnFOLz+lnu1hc8SYAgEZmV+7LxP6474QvdKrQ5e9xEBfQWpu0PdSI9zcw2TW5GDjLzYuXsgIih6H2SvrM9iz+Nhv+9N9qY+Wuh+5QtNXenXYUmsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7O3v90U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7O3v90U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261981F00893;
	Wed, 30 Sep 2026 02:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736646;
	bh=QUSVV1HuLpNyOiwuz9zBol9zQ0C+QGp7v8KlNiJFrkI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O7O3v90U2PpgwaapXFGCRFpfLkPDoIoHeTZhaUlryz+2O2Oh8hghmBidshDbA3u38
	 qPXVsei6eZAbAFJqoHSG8eyF9Mm9Xgk3d70kKshn60KHfSOX2aU4u0bAxF0IxxRiuc
	 08cphiIPfUJIP0OUlYsiWnCqS5cMPH9L4KKyNargTS79neAGC90YsgnbCvC5nQJ1vZ
	 7xGhQ/28l1Z4nwIW54FGgGJbrRVImWin11xnnBR/OAiVxqKk1Ujy6SqeqUqfs8KdxE
	 To9RpIsigmT7I3huEuBT6SG4j0KP7NioQhLhG78gj3AW42TrAvc2Dcay5Zx2OjWCSa
	 /jJ556+pC24yA==
Subject: Re: [PATCH net-next v2 09/11] net: ethernet: cortina: Release partial
 RX frames on stop
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:45 +0000
Message-ID: <179073664572.434549.859098711047104218@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-9-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-9-758a795d7a78@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message understates what this patch fixes.
- [Low] The patch fixes a real, user-visible defect in gmac_stop() but
  has no Fixes: tag.
- [Low] The new discard in gmac_stop() drops the pending partial frame
  with napi_free_frags() but does not increment port->stats.rx_dropped.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but gmac_stop()
  cancels the RX coalesce hrtimer as its first step…

--

net: ethernet: cortina: Release partial RX frames on stop

A NAPI poll can leave a partially assembled RX frame in napi->skb. This
patch frees that frame in gmac_stop() with napi_free_frags(), after
napi_disable() and before port->rx_skb and the saved RX state are
cleared.

> A NAPI poll can retain a partially assembled frame across invocations. The
> stop path clears that pointer without releasing its fragment references,
> leaking every page already attached to the frame.

[Severity: Low]
Does this describe only part of what the patch fixes?

Before this patch, gmac_stop() cleared only port->rx_skb, and napi->skb
still pointed at the half-built skb. napi_disable() and napi_enable() do
not touch napi->skb, so the stale skb is still there on the next open.

After ifup, gmac_rx() starts with skb = NULL and frag_nr = 0. The first
SOF descriptor then gets the old skb back:

gmac_rx()
  gmac_skb_if_good_frame()
    napi_get_frags()   <- returns the stale napi->skb unchanged

At EOF, the length math uses the stale skb->len:

    if (frame_len < skb->len)
        goto err_length;
    frag_len = frame_len - skb->len;

Either the good frame is dropped as a length error, or
skb_fill_page_desc(skb, 0, ...) overwrites frag 0 and sets nr_frags to
1. The second case leaks the old fragment pages. It also leaves data_len
larger than the bytes the frags actually hold.

That skb is then passed to napi_gro_frags(). If the remaining fragment is
shorter than ETH_HLEN, this path can reach the BUG_ON() on
skb_copy_bits() failure:

napi_frags_skb()->skb_gro_header_slow()->pskb_may_pull()->__pskb_pull_tail()

Could the commit message say that stale RX state was carried into the
next open, and that the next received frame could be corrupted or hit
a BUG_ON()? Right now it only mentions a page leak.

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Low]
Should this have a Fixes: tag?

The incomplete reset in gmac_stop() appears to come from commit
06937db21ee3 ("net: ethernet: cortina: Make RX SKB per-port"). That
commit added port->rx_skb = NULL without calling napi_free_frags(). It
carries its own tag, Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver
for Gemini gigabit ethernet").

The napi_disable() call that never releases napi->skb goes back to
4d5ae32f5e1e.

Without a Fixes: tag, stable trees could pick up 06937db21ee3 but not
this follow-up. The stale napi->skb reuse after ifdown/ifup would then
stay in stable kernels.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 258bb44d5570..a7096690e4be 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2077,6 +2077,8 @@ static int gmac_stop(struct net_device *netdev)
>  	gmac_disable_tx_rx(netdev);

[Severity: High]
This isn't a bug introduced by this patch, but can the RX coalesce
hrtimer be re-armed after gmac_stop() cancels it?

gmac_stop() cancels the timer first. It masks the port interrupts much
later:

    hrtimer_cancel(&port->rx_coalesce_timer);
    netif_tx_stop_all_queues(netdev);
    gmac_disable_tx_rx(netdev);
    ...
    gmac_enable_irq(netdev, 0);
    ...
    free_irq(netdev->irq, netdev);

The window between hrtimer_cancel() and gmac_enable_irq(netdev, 0)
includes the mdelay(10) in gmac_disable_tx_rx(). If rx_coalesce_nsecs is
nonzero, an RX interrupt in that window runs:

gmac_irq()
    gmac_enable_rx_irq(netdev, 0);
    ...
    hrtimer_start(&port->rx_coalesce_timer, ktime,
                  HRTIMER_MODE_REL);

gmac_set_coalesce() puts no upper bound on rx_coalesce_usecs. The timer
can therefore stay pending for seconds after gmac_stop() returns.

On the next gmac_open(), hrtimer_setup() would memset a timer that is
still linked in the timerqueue, corrupting the hrtimer rbtree.

On unbind or remove, dev_close()->gmac_stop() is followed by
free_netdev(). That frees the private area holding the armed timer.
gmac_coalesce_delay_expired() would later run napi_schedule(&port->napi)
on freed memory.

Would it work to mask the port interrupts with gmac_enable_irq(netdev,
0), or call free_irq(), before the hrtimer_cancel()? Then nothing could
re-arm the timer once it has been cancelled.

>  	gmac_stop_dma(port);
>  	napi_disable(&port->napi);
> +	if (port->rx_skb)
> +		napi_free_frags(&port->napi);

[Severity: Low]
Should this discard also increment port->stats.rx_dropped?

Both existing places in gmac_rx() that discard the pending partial frame
count it. One is the SOF-while-open path:

    if (skb) {
        napi_free_frags(&port->napi);
        port->stats.rx_dropped++;
        ...

The other is the err_drop path, which follows the same pattern.

gmac_skb_if_good_frame() already counted this frame in rx_packets and
rx_bytes at SOF. A frame discarded here therefore shows up as received
and never as dropped.

If a counter is added, the update would need to sit inside
u64_stats_update_begin/end(&port->rx_stats_syncp). gmac_get_stats64()
reads these fields under that seqcount, and this is a 32-bit platform.

>  	port->rx_skb = NULL;
>  	port->rx_frag_nr = 0;
>  	port->rx_dropping = false;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
