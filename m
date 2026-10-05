Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59A2BE034
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207932; cv=none; b=GwFBQ2ua6qRit65w1qjHoIs5UR2YM/mACWgRbMOk+dNieYDNO+RthAaSkTCWWN6pwv8bFW/pT1k4KAwZpBDRaUbdpyYYzC4DTihOaPYWnsakLvoLbRwhZ20hU8KWZkURWbJ8lUcS0YWKcdrFI7YFfjUmoEh1KyJGsHCjLHR5fDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207932; c=relaxed/simple;
	bh=eZLckH+y4V5PkusdpY7EuKcEBhFPwGKC/A/XRrJg+3U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfiWCdLCusbTWxAGyG18JrG07W2Zg5mfqzCSHPxguFuxWwjLzkj1fzKTWfK5fIUPqK4RNmgI3ykElCSJvb43pmRC5zcEdPAiqDFIUQthIUXXsLfqYlGpKdyvquR4JEPJk/ol2Reuzuh5vGW4WSQAiorcCiDDoLB14X+L0ezg7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWGnLTk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWGnLTk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46631F00893;
	Mon,  5 Oct 2026 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207931;
	bh=qSNNueSHHMIJIkrhemEvTdjz3ia7iDN425kZJKsco4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WWGnLTk0pyHD43qlao15nt+NWfGzx99yYYkiwz7ENg4UsPwhRdXTjKdtMdg/Erzy2
	 tgPAopt+gGLVO68xgJ7tmDyTnN4eKfXhbnnKcc40gXnOvcY4DTrQdIrx/2zjtOkL3m
	 cXpy1aZUu3h5LzVh3LZHI71BuOcNsAjuZRvdlOmDYO8kYrwiMes+Ufv64NKhB6OfAy
	 hBPvsVmWeHJDsRJC1pfsihN4vyxlHbYO2dW+mli/WGVshnIHEHwEyUjLDZ2Y/KeMkV
	 OKwxSf+XKZC+T1Av3UFjIChVq2auTd5+zqG3vSSQ7LlMDqn6zWFhCvHU6sSSk4DkbA
	 mZpB/Ld5BBUTg==
Subject: Re: [RFT] net: wireless: rtl8xxxu: do not embed URBs
From: netdev-bot+sashiko@kernel.org
To: oneukum@suse.com
Cc: pkshih@realtek.com, netdev@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 13:45:30 +0000
Message-ID: <179120793038.434549.3738662776462883685@kernel.org>
In-Reply-To: <20261001132443.553875-1-oneukum@suse.com>
References: <20261001132443.553875-1-oneukum@suse.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Type confusion and heap corruption: the RX wrapper struct is
  freed as if it were an sk_buff.
- [Medium] Memory leak: the kmalloc'ed struct rtl8xxxu_tx_urb and struct
  rtl8xxxu_rx_urb containers are never freed.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  adds two new ways into it.

--

net: wireless: rtl8xxxu: do not embed URBs

This commit stops embedding struct urb in struct rtl8xxxu_tx_urb and
struct rtl8xxxu_rx_urb. The URBs are now allocated separately with
usb_alloc_urb(). The URB completion context changes from the skb to the
wrapper struct, which keeps the skb in a new skb field.

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index bddbd0990de72..4d4e56830ae6d 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -5097,7 +5097,7 @@ static void rtl8xxxu_free_tx_resources(struct rtl8xxxu_priv *priv)
>  	list_for_each_entry_safe(tx_urb, tmp, &priv->tx_urb_free_list, list) {
>  		list_del(&tx_urb->list);
>  		priv->tx_urb_free_count--;
> -		usb_free_urb(&tx_urb->urb);
> +		usb_free_urb(tx_urb->urb);

[Severity: Medium]
Does this leak the struct rtl8xxxu_tx_urb wrappers?

Before this patch, the urb was the first member of the wrapper. So
usb_free_urb(&tx_urb->urb) ended in urb_destroy()->kfree(urb), and that
freed the whole kmalloc'ed wrapper. Now urb_destroy() frees only the
separately allocated urb, and nothing frees tx_urb.

The struct rtl8xxxu_rx_urb wrappers look affected in the same way. This
covers rtl8xxxu_free_rx_resources(), the shutdown branch of
rtl8xxxu_queue_rx_urb() and the default branch of rtl8xxxu_rx_urb_work().
It also covers the cleanup label in rtl8xxxu_rx_complete(), which the
patch doesn't touch:

cleanup:
	usb_free_urb(urb);
	dev_kfree_skb(skb);

rtl8xxxu_stop() drops all RTL8XXXU_TX_URBS tx wrappers and all
RTL8XXXU_RX_URBS rx wrappers. Wouldn't every start/stop cycle then leak
about 96 kmalloc-64 objects, plus one for each RX URB that completes
with an error?

Should each of these sites also kfree() the wrapper after
usb_free_urb()?

>  	}
>  	spin_unlock_irqrestore(&priv->tx_urb_lock, flags);
>  }

[ ... ]

> @@ -5851,9 +5851,9 @@ static void rtl8xxxu_queue_rx_urb(struct rtl8xxxu_priv *priv,
>  		if (priv->rx_urb_pending_count > RTL8XXXU_RX_URB_PENDING_WATER)
>  			schedule_work(&priv->rx_urb_wq);
>  	} else {
> -		skb = (struct sk_buff *)rx_urb->urb.context;
> +		skb = (struct sk_buff *)rx_urb->urb->context;
>  		dev_kfree_skb_irq(skb);
> -		usb_free_urb(&rx_urb->urb);
> +		usb_free_urb(rx_urb->urb);
>  	}
>  
>  	spin_unlock_irqrestore(&priv->rx_urb_lock, flags);
> @@ -5896,9 +5896,9 @@ static void rtl8xxxu_rx_urb_work(struct work_struct *work)
>  		default:
>  			dev_warn(&priv->udev->dev,
>  				 "failed to requeue urb with error %i\n", ret);
> -			skb = (struct sk_buff *)rx_urb->urb.context;
> +			skb = (struct sk_buff *)rx_urb->urb->context;
>  			dev_kfree_skb(skb);

[Severity: Critical]
Is the urb context still an skb here?

rtl8xxxu_submit_rx_urb() now sets the context to the wrapper before it
submits:

	rx_urb->skb = skb;
	usb_fill_bulk_urb(rx_urb->urb, priv->udev, priv->pipe_in, skb->data,
			  skb_size, rtl8xxxu_rx_complete, rx_urb);
	usb_anchor_urb(rx_urb->urb, &priv->rx_anchor);
	ret = usb_submit_urb(rx_urb->urb, GFP_ATOMIC);

Suppose the device is unplugged while the worker is draining the pending
list. usb_submit_urb() returns -ENODEV and we take this default branch
with context == rx_urb.

Wouldn't that pass the 40 byte struct rtl8xxxu_rx_urb to dev_kfree_skb()
(consume_skb())? consume_skb() would then:

- read and decrement skb->users well past the end of the kmalloc-64
  object;
- read the destructor pointer out of bounds, and possibly call it;
- free the object into skbuff_cache.

The real skb in rx_urb->skb would also leak.

The shutdown branch of rtl8xxxu_queue_rx_urb() above casts the same way
before dev_kfree_skb_irq(). rtl8xxxu_stop() sets priv->shutdown before
it calls cancel_work_sync(&priv->rx_urb_wq). So a worker that is still
running can reach that branch with context == rx_urb, if
usb_submit_urb() fails with -ENOMEM or -EAGAIN after the fill.

The rtl8xxxu_start() error path was changed to read u->skb, but these
two sites were not. Should they use rx_urb->skb instead? If so,
rtl8xxxu_rx_complete() would need to clear rx_urb->skb rather than
rx_urb->urb->context once the skb is handed to parse_rx_desc().

> -			usb_free_urb(&rx_urb->urb);
> +			usb_free_urb(rx_urb->urb);
>  		}
>  	}
>  }

[ ... ]

> @@ -7435,7 +7435,14 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
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
>  		INIT_LIST_HEAD(&tx_urb->list);
>  		tx_urb->hw = hw;
>  		list_add(&tx_urb->list, &priv->tx_urb_free_list);
> @@ -7456,14 +7463,22 @@ static int rtl8xxxu_start(struct ieee80211_hw *hw)
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
This is a pre-existing issue that wasn't introduced by this patch.
However, the two new usb_alloc_urb() failure branches copy the same
pattern from the kmalloc_obj() failure branches.

If the allocation fails with i > 0, ret is still 0. In the RX loop it is
the 0 returned by the previous rtl8xxxu_submit_rx_urb(). So
rtl8xxxu_start() jumps to error_out and reports success:

error_out:
	rtl8xxxu_free_tx_resources(priv);
	/*
	 * Disable all data and mgmt frames
	 */
	rtl8xxxu_write16(priv, REG_RXFLTMAP2, 0x0000);
	rtl8xxxu_write16(priv, REG_RXFLTMAP0, 0x0000);

	return ret;

mac80211 would then treat the interface as started, but tx_urb_free_list
is empty and the RX filter maps are zeroed. Meanwhile enable_rf(), the
interrupt URB and any RX URBs already submitted are left as they are.

Could the new branches return -ENOMEM in every case, or could error_out
undo what was set up before it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001132443.553875-1-oneukum%40suse.com
