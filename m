Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F073D525F;
	Thu, 24 Sep 2026 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216488; cv=none; b=QV+XrZAhT7ecRi1Y1KWIs9LMMaybuqZ7ROe/6XRADujp52Fu16xK6zOfF3UzuAD5JP5o79FqqvuyM+Bohaiyh1BO2lnE0c8ynaheqeAA5EI0V991mkqNe42ScreLRtiqqwQnT1Z074zDyU61MmQAxuw9YUn4imGv9PbkzrDZoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216488; c=relaxed/simple;
	bh=/NuRmTeC/wNcGOs7oZ5UbkGxnLs1YaRtydvVaEmL7XE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nITdTs+4si2CZdicsFL6XUoJzG5uQMj7cAQU3aH/WLJHGVnXTO0KVdMq0JBeorAPvryIi7P+AEQs3H5/CzaycC+4YXN33uPuG2V7bxnfmNDFU8kB0R2wPRwRloCG7Pq1LL84aJQdzl+y1vIGoxyFW4t9bZ8bwpDOT0a0OQcG6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0dG7qfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0dG7qfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5DE1F00893;
	Thu, 24 Sep 2026 02:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216484;
	bh=ZsTzF8H+eR5EpCjxccei3jk/IqV7hA0cUdDks8EWZcQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=W0dG7qfS0XkzPCG2GsrNjkVKXGLK1JHA1yEVq53ZeNEH3V7brBfCgdVPdqR8rQasl
	 c2CECe19hsrCgss5o6ScNORkDtcfA+PudTfYmLQFcw/rDB3JBDMAbnxgETWrOFposW
	 WjgwviNsHFWTU+OxmER1+Il8+/o00gF7oflPHissubFgae3hjFTMVPu9MCaTFu3Zy9
	 ucMfSEtZWPCfhx5CwihdpZvxLJQPkYtAmFxDQKw5YPDqcGJa59swDjBfNX7BEHB0Ec
	 9zqcgkKP1vuAtAdtW4IumR57+FTw2Ih6EEoIUTU2/qTecL1icrLpJiBqp88IxLNEHl
	 uEyNggRqNfh4Q==
Subject: Re: [PATCH net v2 02/10] net: systemport: Fix invalid dev_id argument
 in bcm_sysport_poll_controller()
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:21:23 +0000
Message-ID: <179021648333.2160803.6963764174050231839@kernel.org>
In-Reply-To: <20260922232440.598918-3-florian.fainelli@broadcom.com>
References: <20260922232440.598918-3-florian.fainelli@broadcom.com>
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

- [Medium] Now that bcm_sysport_poll_controller() passes a valid dev, the
  polled calls to bcm_sysport_rx_isr() and bcm_sysport_tx_isr() actually…

Pre-existing issues:
- [Medium] bcm_sysport_poll_controller()
  (drivers/net/ethernet/broadcom/bcmsysport.c:1196-1209) calls…

--

net: systemport: Fix invalid dev_id argument in bcm_sysport_poll_controller()

This commit makes bcm_sysport_poll_controller() pass dev instead of priv
to bcm_sysport_rx_isr() and bcm_sysport_tx_isr(). Both ISRs call
netdev_priv() on their dev_id argument, so passing priv crashed them when
netconsole or netpoll ran.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index db627cd15fb7a..8328fe824d152 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -1198,12 +1198,12 @@ static void bcm_sysport_poll_controller(struct net_device *dev)
>  	struct bcm_sysport_priv *priv = netdev_priv(dev);
>  
>  	disable_irq(priv->irq0);

[Severity: Medium]
This is a pre-existing issue, but is it safe to call disable_irq() here?

The only caller of ndo_poll_controller is netpoll_poll_dev(). It is called
from the retry loop in __netpoll_send_skb(), and that loop runs with IRQs
disabled:

net/core/netpoll.c:__netpoll_send_skb() {
    ...
	lockdep_assert_irqs_disabled();
    ...
}

netpoll_send_skb() calls local_irq_save() before this. For netconsole,
target_list_lock is also held.

disable_irq() can sleep:

kernel/irq/manage.c:disable_irq() {
	might_sleep();
	if (!__disable_irq_nosync(irq))
		synchronize_irq(irq);
}

With CONFIG_DEBUG_ATOMIC_SLEEP, would this print "sleeping function called
from invalid context" each time netpoll has to poll the device because TX
is busy or the queue is stopped?

The handlers are requested with flags 0. With threadirqs or PREEMPT_RT
they are force-threaded, so synchronize_irq() can wait_event() on the IRQ
thread with IRQs disabled.

Before this patch the path oopsed. Now it completes, so netconsole users on
this NIC would hit this problem next. No later patch in the series changes
the disable_irq() calls.

The driver already does TX completion in NAPI. netpoll_poll_dev() also
calls poll_napi() right after the callback:

	ops->ndo_poll_controller(dev);

	poll_napi(dev);

Could bcm_sysport_poll_controller() be removed entirely, as was done for
other NAPI drivers? Or could it at least use disable_hardirq(), as
e1000_netpoll() does?

> -	bcm_sysport_rx_isr(priv->irq0, priv);
> +	bcm_sysport_rx_isr(priv->irq0, dev);

[Severity: Medium]
Now that the ISR calls here actually run, will the masked status usually
be zero?

On the previous netpoll_poll_dev() iteration, poll_napi() already cleared
the status. bcm_sysport_desc_rx() clears INTRL2_0_RDMA_MBDONE, and
__bcm_sysport_tx_reclaim() clears each ring's INTRL2_1 bit:

	intrl2_1_writel(ring->priv, BIT(ring->index), INTRL2_CPU_CLEAR);

Sources whose NAPI is scheduled are also masked. In that case
bcm_sysport_rx_isr() takes this path:

	if (unlikely(priv->irq0_stat == 0)) {
		netdev_warn(priv->netdev, "spurious RX interrupt\n");
		return IRQ_NONE;
	}

On non-Lite hardware, bcm_sysport_tx_isr() prints "spurious TX interrupt"
in the same way.

While TX is busy, the retry loop in __netpoll_send_skb() calls
netpoll_poll_dev() up to jiffies_to_usecs(1)/USEC_PER_POLL times. Could
that fill the log with unratelimited spurious interrupt warnings? That is
up to 40 at HZ=1000 and 400 at HZ=100 each time txq goes from empty to
busy.

Each warning is also a new printk that netconsole tries to send over the
same congested interface.

Should the polled path skip this warning or ratelimit it, or should the
poll_controller be removed?

>  	enable_irq(priv->irq0);
>  
>  	if (!priv->is_lite) {
>  		disable_irq(priv->irq1);
> -		bcm_sysport_tx_isr(priv->irq1, priv);
> +		bcm_sysport_tx_isr(priv->irq1, dev);
>  		enable_irq(priv->irq1);
>  	}
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232440.598918-1-florian.fainelli%40broadcom.com
