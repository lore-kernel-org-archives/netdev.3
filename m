Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB36414DE0;
	Thu, 24 Sep 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269658; cv=none; b=aC01huiD1/7cE8e0MfHjUXJErlizeh1oZRdBudhetPJ2bbVuw1MIqruxnH2nrn9pxar1N/6pBktRzhaisUZ+MtA1jMP9Htl/QcxJpkRW6LOCpnuFmVHVVYLrOCKhDYrcKsS1sFWwFQkGPv18N9vt+USh2ehrFNJ8AgV1BCmlSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269658; c=relaxed/simple;
	bh=0xbYoNuIOggiVqnzrmB7NDhAHCEUt5ZjTVcrqSqVuiE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Na8LlEiCX7/EqqNZQsqzdOWelthtgIC6iBlod35opgQga/ehWBtCoGf5otvk0toN2bPkFM/AOxxyqBSENezcpWnfEXQYPQYAL/Gt86J7Tp6cAUqrKZBc8Lf7yId+kmUv0YCVeKqB2wjkHrklhxL2gtA1r+HGNbyypegp8TEsyFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAYa33SZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAYa33SZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4861F000FF;
	Thu, 24 Sep 2026 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269657;
	bh=JY5d4b+HQK5cRuge+ElFIAIu82JHzvSlmwCWU1kY50o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MAYa33SZAaWLJ2zkvu1xFFspSvvC9I7DxBdt5VRzkg+oheBdOnhbYUNhPGMmH2tED
	 IKzxJrfeUuJX1fnQIp9kiwydXFAOO2LHyQSwS8rml2Z8ynUVSaUVoAytiFH8DQtKYc
	 C5iV/D8jyfn/l7v+DmeBC4VBkUUKA9gLhu6lpK0ekul0hh9SlSSeCKwQhc0uYpsfGe
	 jzjzUfsKBvjj91ov51+GMmnRrpXblEhXDPF1ehwZKrWi2oUk8b/j6tulomRvcT9dya
	 95Kg+5tLzHDtXIWjWsa5ZZA4JRQwaX/sZMcb2gmKSQjIg7vbqymPIQgZjJj4Ymkf0q
	 tv0YnZWh065xQ==
Subject: Re: [PATCH net 02/12] net: systemport: Fix invalid dev_id argument in
 bcm_sysport_poll_controller()
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:35 +0000
Message-ID: <179026965597.2160803.11240582125225278425@kernel.org>
In-Reply-To: <20260921231305.394773-3-florian.fainelli@broadcom.com>
References: <20260921231305.394773-3-florian.fainelli@broadcom.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcm_sysport_poll_controller()
  (drivers/net/ethernet/broadcom/bcmsysport.c:1199-1211, post-patch)…
- [Medium] With the dev_id argument fixed, bcm_sysport_poll_controller()
  now performs real MMIO against the SYSTEMPORT INTRL2 block from…

--

net: systemport: Fix invalid dev_id argument in bcm_sysport_poll_controller()

This corrects bcm_sysport_poll_controller() so that it hands the
struct net_device pointer, rather than the driver private pointer, to
bcm_sysport_rx_isr() and bcm_sysport_tx_isr(), both of which call
netdev_priv() on their dev_id argument.

A couple of questions about the surrounding code in that callback below.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index db627cd15fb7a..8328fe824d152 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -1198,12 +1198,12 @@ static void bcm_sysport_poll_controller(struct net_device *dev)
>  	struct bcm_sysport_priv *priv = netdev_priv(dev);
>  
>  	disable_irq(priv->irq0);
> -	bcm_sysport_rx_isr(priv->irq0, priv);
> +	bcm_sysport_rx_isr(priv->irq0, dev);
>  	enable_irq(priv->irq0);

[Severity: High]
Can disable_irq() be called from this callback at all?  ndo_poll_controller
is invoked by netpoll with hard IRQs disabled and under rcu_read_lock():

net/core/netpoll.c:netpoll_send_skb() {
	local_irq_save(flags);
	...__netpoll_send_skb(np, skb);
}

/* call with IRQ disabled */
static netdev_tx_t __netpoll_send_skb(...)
{
	...
	lockdep_assert_irqs_disabled();
	...
			/* tickle device maybe there is some cleanup */
			netpoll_poll_dev(np->dev);
	...
		WARN_ONCE(!irqs_disabled(), ...);
}

and netpoll_poll_dev() then does:

	ops = dev->netdev_ops;
	if (ops->ndo_poll_controller)
		ops->ndo_poll_controller(dev);

	poll_napi(dev);

while disable_irq() is a sleeping API:

kernel/irq/manage.c:disable_irq() {
	might_sleep();
	if (!__disable_irq_nosync(irq))
		synchronize_irq(irq);
}

Does this produce a "sleeping function called from invalid context" splat with
CONFIG_DEBUG_ATOMIC_SLEEP on every netpoll poll of a SYSTEMPORT interface?

There also looks to be a hang case.  If the netconsole message being
transmitted originates from inside the handler itself, for example:

	if (unlikely(priv->irq0_stat == 0)) {
		netdev_warn(priv->netdev, "spurious RX interrupt\n");
		return IRQ_NONE;
	}

then irq0 is IRQD_IRQ_INPROGRESS on this CPU when synchronize_irq() runs:

	while (irqd_irq_inprogress(&desc->irq_data))
		cpu_relax();
...
	wait_event(desc->wait_for_threads, !atomic_read(&desc->threads_active));

With local IRQs disabled the in-progress handler can never complete, so does
this spin forever?  And with force-threaded handlers (threadirqs or
PREEMPT_RT), does the wait_event() schedule while atomic?

Given that netpoll_poll_dev() already calls poll_napi() and drives the
driver's NAPI instances, would removing ndo_poll_controller from
bcm_sysport_netdev_ops be preferable to fixing the argument?  At a minimum,
would disable_irq_nosync() be more appropriate here?

>  
>  	if (!priv->is_lite) {
>  		disable_irq(priv->irq1);
> -		bcm_sysport_tx_isr(priv->irq1, priv);
> +		bcm_sysport_tx_isr(priv->irq1, dev);
>  		enable_irq(priv->irq1);
>  	}
>  }

[Severity: Medium]
Now that the register base is correct, these hand-calls perform real MMIO
against the INTRL2 block from netpoll context.  Both handlers read the status
latch and acknowledge it:

bcm_sysport_rx_isr() {
	priv->irq0_stat = intrl2_0_readl(priv, INTRL2_CPU_STATUS) &
			  ~intrl2_0_readl(priv, INTRL2_CPU_MASK_STATUS);
	intrl2_0_writel(priv, priv->irq0_stat, INTRL2_CPU_CLEAR);

	if (unlikely(priv->irq0_stat == 0)) {
		netdev_warn(priv->netdev, "spurious RX interrupt\n");
		return IRQ_NONE;
	}
}

bcm_sysport_tx_isr() {
	intrl2_1_writel(priv, 0xffffffff, INTRL2_CPU_CLEAR);

	if (unlikely(priv->irq1_stat == 0)) {
		netdev_warn(priv->netdev, "spurious TX interrupt\n");
		return IRQ_NONE;
	}
}

When netpoll is only tickling a stopped TX queue there is typically nothing
latched, so does this emit "spurious RX interrupt" / "spurious TX interrupt"
from inside the netconsole transmit path, feeding those warnings back into the
same path?

A second concern, which I could not confirm from the tree since it depends on
the brcmstb interrupt controller latching semantics: events consumed and
cleared here happen outside hardirq context, so if a parent-level request is
still pending after enable_irq(), the real handler would run against an
already-cleared status latch, warn and return IRQ_NONE.  Could repeated
IRQ_NONE returns be accounted by note_interrupt() and eventually escalate to
"nobody cared" disabling of the SYSTEMPORT line?

Deleting the callback and relying on poll_napi() would avoid both of these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
