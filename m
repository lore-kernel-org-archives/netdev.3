Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548C304BB2
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620853; cv=none; b=uPKiDn8g/w+1rR01W7wV3kFQbPPtJNdPBHEaBT+2WxnhbY34kpS3hdpjc1Ks2slK7UVz5vu5dr9ezkdRBQZhtUEEhGfdRWBq4hmvOFdh67TV2lbVTKe57cCNmQLFZBwMEpN/WCi5JURyJPltO56aWVUI9giKAeceEA2XtV2I/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620853; c=relaxed/simple;
	bh=kbXQW/0HLuEneR5kaTvCv1vFl8xwBNryAJIgyqaUWCY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Po5QZx94eXQJF3IqJY1UN6txMutH5fyxE4gjX0tHOldc/4852BMZXEOp/6H7HLXhZmJ6opChWhwDNyNROk9Cmn6C7J4l+8+7LIPTDZ6FzvKJx4xK2/YCVHzZJClSTMSqw2CzOUU0qPR27rXaQugRhMdJwrtKkbGisgpI4FiDKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQmGw5MN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQmGw5MN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF361F000FF;
	Sat, 10 Oct 2026 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791620852;
	bh=oGagcUG5Cj+z5KDp1TuXUbr4ZtlxvcpnKqPJlb1Ed2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DQmGw5MNxCaNYzy582bwELEQo5qazrqhPDjy05TqZ+nih1LCsN1X+0S6nJA6ogQeN
	 RSsZHJzqrM3T6jUREuYF3qcmE1EbHvuewT49SI49hmbRJvStjPWT9Wy3PgNuVA8XQ4
	 mIkLBFslfCoG/90CjqpE14HuQWWuNPMng54Mf5M9hfzBHFXyvKsAE/vMBL4GdUfE2Y
	 2xiPAxXt+v67ymZBGAzb2MaDo9OdM+V+t9y6Zofnu7DM+Z8PdUhIlZmZDJlYqj9d0/
	 ApINrJ+65yh3MTDx8kG1NiQBARdPG8cr/GBckFVEF1K7XXvxt+Sir5ML3jXH6rfDhb
	 oQoyEMxH8eT1g==
Subject: Re: [RFTv2] net: wireless: rtl8xxxu: do not embed URBs
From: netdev-bot+sashiko@kernel.org
To: oneukum@suse.com
Cc: pkshih@realtek.com, netdev@vger.kernel.org, kuba@kernel.org
Date: Sat, 10 Oct 2026 08:27:31 +0000
Message-ID: <179162085123.434549.13573628856256428679@kernel.org>
In-Reply-To: <20261006081733.323024-1-oneukum@suse.com>
References: <20261006081733.323024-1-oneukum@suse.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 2 · Medium: 0 (3) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] This patch introduces a double free / use-after-free of RX
  skbs.
- [High] In rtl8xxxu_rx_complete()
  (drivers/net/wireless/realtek/rtl8xxxu/core.c), the error path…
- [High] rtl8xxxu_start() allocates each rx_urb with kmalloc_obj(), which
  expands to kmalloc() via __alloc_objs(kmalloc, ...) and does not zero…
- [Low] The subject line uses the prefix 'net: wireless: rtl8xxxu:', but
  rtl8xxxu changes use 'wifi: rtl8xxxu:'.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  adds new branches that follow it.
- [Medium] This problem wasn't introduced by this patch, but
  rtl8xxxu_submit_rx_urb() can allocate an skb, store it in rx_urb->skb,…
- [Medium] This problem wasn't introduced by this patch, but the patch
  adds two more ways to reach it.

--

net: wireless: rtl8xxxu: do not embed URBs

This patch changes struct rtl8xxxu_rx_urb and struct rtl8xxxu_tx_urb so
they no longer embed a struct urb. Each wrapper now holds a pointer to a
URB allocated with usb_alloc_urb(). urb->context now points at the
wrapper, and a new skb field in each wrapper tracks the buffer.

> net: wireless: rtl8xxxu: do not embed URBs

[Severity: Low]
This isn't a bug, but other rtl8xxxu commits use the "wifi: rtl8xxxu:"
prefix. One example is commit 6c080026ecc1 ("wifi: rtl8xxxu: fix
use-after-free from rx_urb_wq on stop"). Should the subject use that
prefix too?

The body only says "Allocate them separately". Could it also say that
urb->context now points to the wrapper instead of the skb, and that both
structs gained a new skb field? The RX completion, shutdown and error
paths all rely on that ownership change.

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index bddbd0990de72..7356f91e92df1 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c

[ ... ]

> @@ -6544,11 +6546,10 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
>  
>  static void rtl8xxxu_rx_complete(struct urb *urb)
>  {
> -	struct rtl8xxxu_rx_urb *rx_urb =
> -		container_of(urb, struct rtl8xxxu_rx_urb, urb);
> +	struct rtl8xxxu_rx_urb *rx_urb = urb->context;
>  	struct ieee80211_hw *hw = rx_urb->hw;
>  	struct rtl8xxxu_priv *priv = hw->priv;
> -	struct sk_buff *skb = (struct sk_buff *)urb->context;
> +	struct sk_buff *skb = rx_urb->skb;
>  	struct device *dev = &priv->udev->dev;
>  
>  	skb_put(skb, urb->actual_length);
> @@ -6557,7 +6558,7 @@ static void rtl8xxxu_rx_complete(struct urb *urb)
>  		priv->fops->parse_rx_desc(priv, skb);
>  
>  		skb = NULL;
> -		rx_urb->urb.context = NULL;
> +		rx_urb->urb->context = NULL;
>  		rtl8xxxu_queue_rx_urb(priv, rx_urb);

[Severity: Critical]
Before this patch, urb->context held the skb. Clearing it here dropped
the driver's only reference once parse_rx_desc() had taken ownership.

Now urb->context holds the wrapper and the skb is stored in rx_urb->skb.
That field is never cleared, so it still points at the consumed skb.

parse_rx_desc() always takes ownership of the skb. It either passes it to
ieee80211_rx_irqsafe(), queues it on c2hcmd_queue, or frees it. One
example of the free is in rtl8xxxu_parse_rxdesc24():

	if (urb_len < sizeof(struct rtl8xxxu_rxdesc24)) {
		kfree_skb(skb);
		return RX_TYPE_ERROR;
	}

When priv->shutdown is set, the shutdown branch of
rtl8xxxu_queue_rx_urb() then does:

	skb = rx_urb->skb;
	dev_kfree_skb_irq(skb);

rtl8xxxu_stop() sets shutdown before it drains the worker and kills the
RX URBs:

	priv->shutdown = true;
	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
	...
	cancel_work_sync(&priv->rx_urb_wq);

	usb_kill_anchored_urbs(&priv->rx_anchor);

Suppose a bulk-in URB completes with status 0 inside that window. Can
its skb then be freed a second time, or freed while it is still queued
in mac80211 or on c2hcmd_queue?

There is a second way to hit this. rtl8xxxu_rx_urb_work() can run while
shutdown is set. If rtl8xxxu_submit_rx_urb() then returns -ENOMEM from
__netdev_alloc_skb(), it does so before rx_urb->skb is reassigned. The
-ENOMEM case then calls rtl8xxxu_queue_rx_urb() with the stale pointer.

Commit 6c080026ecc1 ("wifi: rtl8xxxu: fix use-after-free from rx_urb_wq
on stop") notes that the worker can resubmit URBs during this same
window.

Would it help to set rx_urb->skb = NULL here, either instead of clearing
urb->context or as well as clearing it?

>  	} else {
>  		dev_dbg(dev, "%s: status %i\n",	__func__, urb->status);

[Severity: High]
Does the error path of rtl8xxxu_rx_complete() now leak the rx_urb
wrapper? The cleanup label is outside this hunk and still reads:

cleanup:
	usb_free_urb(urb);
	dev_kfree_skb(skb);

Before this patch, the URB was the first member of the kmalloc'd struct
rtl8xxxu_rx_urb. The last usb_free_urb() therefore freed the whole
wrapper through urb_destroy(). The URB is now a separate usb_alloc_urb()
allocation, so only the URB gets freed.

This patch added kfree(rx_urb) at the other places that free an rx_urb:
rtl8xxxu_free_rx_resources(), the shutdown branch of
rtl8xxxu_queue_rx_urb(), and the default case of rtl8xxxu_rx_urb_work().

Every in-flight RX URB takes this path when rtl8xxxu_stop() calls
usb_kill_anchored_urbs(&priv->rx_anchor), with status -ENOENT. URBs also
take it on disconnect and on bus errors. Would each stop then leak up to
RTL8XXXU_RX_URBS wrappers?

Should kfree(rx_urb) be added after usb_free_urb(urb)?

[ ... ]

> @@ -6592,12 +6593,13 @@ static int rtl8xxxu_submit_rx_urb(struct rtl8xxxu_priv *priv,
>  		return -ENOMEM;
>  
>  	memset(skb->data, 0, rx_desc_sz);
> -	usb_fill_bulk_urb(&rx_urb->urb, priv->udev, priv->pipe_in, skb->data,
> -			  skb_size, rtl8xxxu_rx_complete, skb);
> -	usb_anchor_urb(&rx_urb->urb, &priv->rx_anchor);
> -	ret = usb_submit_urb(&rx_urb->urb, GFP_ATOMIC);
> +	rx_urb->skb = skb;
> +	usb_fill_bulk_urb(rx_urb->urb, priv->udev, priv->pipe_in, skb->data,
> +			  skb_size, rtl8xxxu_rx_complete, rx_urb);
> +	usb_anchor_urb(rx_urb->urb, &priv->rx_anchor);
> +	ret = usb_submit_urb(rx_urb->urb, GFP_ATOMIC);
>  	if (ret)
> -		usb_unanchor_urb(&rx_urb->urb);
> +		usb_unanchor_urb(rx_urb->urb);
>  	return ret;
>  }

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Suppose
usb_submit_urb() fails with -ENOMEM or -EAGAIN after rx_urb->skb has been
set. Is the skb leaked in that case?

For these errors, rtl8xxxu_rx_urb_work() requeues the rx_urb without
freeing the skb:

		case -ENOMEM:
		case -EAGAIN:
			rtl8xxxu_queue_rx_urb(priv, rx_urb);

rtl8xxxu_start() frees the skb only when ret != -ENOMEM.

The next submit then overwrites rx_urb->skb. rtl8xxxu_free_rx_resources()
also frees pending wrappers without freeing their skb. The baseline had
the same leak through urb.context.

[ ... ]

> @@ -7435,7 +7437,14 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
>  
>  			goto error_out;
>  		}
> -		usb_init_urb(&tx_urb->urb);
> +		tx_urb->urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!tx_urb->urb) {
> +			kfree(tx_urb);
> +			if (!i)
> +				ret = -ENOMEM;
> +
> +			goto error_out;
> +		}

[Severity: Medium]
This isn't a bug introduced by this patch, since the existing
kmalloc_obj() failure branches behave the same way. The new
usb_alloc_urb() branches copy that pattern, though. If the allocation
fails at i > 0, ret is not set before goto error_out.

error_out then empties the TX URB pool and closes the RX filters:

error_out:
	rtl8xxxu_free_tx_resources(priv);
	...
	rtl8xxxu_write16(priv, REG_RXFLTMAP2, 0x0000);
	rtl8xxxu_write16(priv, REG_RXFLTMAP0, 0x0000);

	return ret;

In the TX loop ret is still 0. In the RX loop it holds the result of the
last rtl8xxxu_submit_rx_urb() call, which is usually 0. Would mac80211
then treat the start as successful, even though there are no TX URBs,
the RX filters are closed, and ra_watchdog was never scheduled?

[ ... ]

> @@ -7456,15 +7465,24 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
>  
>  			goto error_out;
>  		}
> -		usb_init_urb(&rx_urb->urb);
> +		rx_urb->urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!rx_urb->urb) {
> +			kfree(rx_urb);
> +			if (!i)
> +				ret = -ENOMEM;
> +
> +			goto error_out;
> +		}

[Severity: Medium]
This is a pre-existing issue, but this new branch adds another way to
reach it. By the time error_out runs, rtl8xxxu_start() has already done:

	priv->fops->enable_rf(priv);
	if (priv->usb_interrupts) {
		ret = rtl8xxxu_submit_int_urb(hw);

error_out only frees the TX resources and writes REG_RXFLTMAP0/2.
rtl8xxxu_stop() also kills the anchored RX and interrupt URBs, disables
RF and masks HIMR, but error_out does none of that.

When i == 0, start returns -ENOMEM and mac80211 never calls .stop. Does
that leave RF on and the interrupt URB live? It may also leave any RX
URBs that were already submitted or pending still alive.

If so, the next start() runs init_usb_anchor() on anchors that may still
hold URBs.

>  		INIT_LIST_HEAD(&rx_urb->list);
>  		rx_urb->hw = hw;
>  
>  		ret = rtl8xxxu_submit_rx_urb(priv, rx_urb);
>  		if (ret) {
>  			if (ret != -ENOMEM) {
> -				skb = (struct sk_buff *)rx_urb->urb.context;
> +				struct rtl8xxxu_rx_urb *u = rx_urb->urb->context;
> +				skb = u->skb;
>  				dev_kfree_skb(skb);
> +				u->skb = NULL;
>  			}
>  			rtl8xxxu_queue_rx_urb(priv, rx_urb);
>  		}

[Severity: High]
Is rx_urb->skb ever initialized on the -ENOMEM path? The wrapper comes
from kmalloc_obj(struct rtl8xxxu_rx_urb), which does not zero memory.
rtl8xxxu_submit_rx_urb() returns before it reaches the only assignment
to rx_urb->skb:

	skb = __netdev_alloc_skb(NULL, skb_size, GFP_KERNEL);
	if (!skb)
		return -ENOMEM;

The wrapper is then put on the pending list with an uninitialized skb
pointer.

Later, rtl8xxxu_rx_urb_work() may retry and get -ENOMEM again while
rtl8xxxu_stop() has set priv->shutdown. In that case the shutdown branch
of rtl8xxxu_queue_rx_urb() runs dev_kfree_skb_irq(rx_urb->skb) on
uninitialized heap contents.

Before this patch, that branch read urb.context, which usb_init_urb()
had zeroed.

Would allocating with kzalloc_obj() avoid this? Setting rx_urb->skb and
tx_urb->skb to NULL right after allocation would work too.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006081733.323024-1-oneukum%40suse.com
