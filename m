Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD83C4167;
	Thu,  1 Oct 2026 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862146; cv=none; b=j3bMX3dRDNq5rTuD20x6Q6XCaocqVwk7XiH2GPyZdiKbLi5Ok7R/KWH03P83xvJKJv0ouIYD1zmTwfmO65XLpkOOAcFLhZF3H8Of2g0wHlu5jwH5a/aBdMRikgEGQNxg2k4uPc7MSQEy3vKQE8rECNrCz10/XCLlBOUsHTaidlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862146; c=relaxed/simple;
	bh=m+PIYgpzATj6dMWTuMZqLnnGbUP6lmmFSgfStmPX9Wg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lGPk8iaSu6yDctRKDW3xzyjKkuwTdzG6Rc4qpOwc2J0KeXbHIDqCPuIrS9ZIPMbNUbUeoXOr6XOkhL6M7OHRWQALqhHMYYdxPQZtPeIudxUQJisMUBVhOg4PI11fOqThypVyBd+EG9go0gh/daf0y/LjTYTHNffFVI6azDj3v6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td5zlE2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td5zlE2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25E31F00898;
	Thu,  1 Oct 2026 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862137;
	bh=3jRt9Xf+0TeEf4XF1/71lJRzb1ZuaaAHPHCF5R0i77s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Td5zlE2qQd7mRS5kOHJQrSNJq6FOHI9pqrFK9nyWhvwiE8tdtWV6yRh0XehvUE8LM
	 I3IQKCHqE+txgbFNweXAq31oB62NgB+IbM4cxtjx4ghZSvUpYXHWG73tsYKyYKyWeg
	 Yg8FtnN8WfYiDeE9JkO6+FF9NYA4f6fkPWHTeyt3tq/5v+CLHV/n0R/yLVGXsRcdMF
	 op6fxkQzfEvXyHrmQLw+EV0koP+iF/TzOLgijdXrxEy5/qQ94isC/+66xtKgaGgF6m
	 tUtGb2p46X4T1t8I2tSux9JpfK+Slu4nbOxOsGxHgZdL7OEMdkOznRN7ry8khKJUDt
	 CDG0oCIpr/nLg==
Subject:
 Re: [PATCH net] net: plip: quiesce private work when stopping the interface
From: netdev-bot+sashiko@kernel.org
To: getshell@seu.edu.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Date: Thu, 01 Oct 2026 13:42:16 +0000
Message-ID: <179086213620.434549.7621820175200159527@kernel.org>
In-Reply-To: <20260928134136.1213-1-getshell@seu.edu.cn>
References: <20260928134136.1213-1-getshell@seu.edu.cn>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The IRQ publisher is already live when plip_open() resets its
  state, so a peer trigger can be lost and receive stays stuck.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it defeats the
  reopen support the commit message claims.
- [Low] Parallel-port data lines can be left mid-handshake after close
  (baseline: pre-existing, low impact).

--

net: plip: quiesce private work when stopping the interface

This patch initializes the immediate and deferred PLIP work items as
disabled. plip_open() now resets the protocol state and then enables the
work items. plip_close() disables and drains both work items before it
releases the parport and any pending skbs.

> diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
> index d81163bc910a..97bbac0b95da 100644
> --- a/drivers/net/plip/plip.c
> +++ b/drivers/net/plip/plip.c

[ ... ]

> @@ -1077,6 +1079,17 @@ plip_open(struct net_device *dev)
>  
>  	nl->should_relinquish = 0;
>  
> +	/* Initialize the state machine. */
> +	nl->rcv_data.state = PLIP_PK_DONE;
> +	nl->snd_data.state = PLIP_PK_DONE;
> +	nl->rcv_data.skb = NULL;
> +	nl->snd_data.skb = NULL;
> +	nl->connection = PLIP_CN_NONE;
> +	nl->is_deferred = 0;
> +
> +	enable_work(&nl->immediate);
> +	enable_work(&nl->deferred.work);

[Severity: Medium]
In IRQ mode, can a trigger interrupt from the peer get lost here?

The commit message says open will "reset protocol state before enabling
the work and its IRQ or polling publishers". However, the parport_claim()
call at the top of plip_open() already makes plip_interrupt() reachable.

parport_claim() sets port->cad to the PLIP pardev and calls
restore_state(). For parport_pc, the saved CONTROL value already has
ackIntEn set:

drivers/parport/parport_pc.c:parport_pc_init_state() {
    ...
	if (dev->irq_func && dev->port->irq != PARPORT_IRQ_NONE)
		/* Set ackIntEn */
		s->u.pc.ctr |= 0x10;
    ...
}

Suppose the interrupt lands after nl->connection = PLIP_CN_NONE but before
enable_work(&nl->immediate) finishes. plip_interrupt() then does:

	case PLIP_CN_NONE:
	case PLIP_CN_SEND:
		rcv->state = PLIP_PK_TRIGGER;
		nl->connection = PLIP_CN_RECEIVE;
		nl->timeout_count = 0;
		schedule_work(&nl->immediate);
		break;

The work is still disabled from plip_init_netdev(), so this schedule_work()
is silently dropped. enable_work() does not replay it.

Every later trigger then hits:

	case PLIP_CN_RECEIVE:
		...
		break;

Receive stays stuck until a local transmit happens to queue plip_bh().
Before this patch the work was always enabled, so this interrupt would
always have queued plip_bh().

Would it work to do the state reset and the enable_work() calls before
parport_claim()? Another option is to keep the port interrupt masked, and
do the reset under nl->lock, until the work is enabled.

> +
>  	/* Clear the data port. */
>  	write_data (dev, 0x00);
>  

[ ... ]

> @@ -1141,6 +1148,9 @@ plip_close(struct net_device *dev)
>  		wait_for_completion(&nl->killed_timer_cmp);
>  	}
>  
> +	disable_work_sync(&nl->immediate);
> +	disable_delayed_work_sync(&nl->deferred);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does reopen work in IRQ
mode? The commit message says "The balanced enable and disable operations
support later interface reopen". However, plip_close() does an
unconditional, counted disable_irq() earlier in the function:

	netif_stop_queue (dev);
	DISABLE(dev->irq);
	synchronize_irq(dev->irq);

where:

#define DISABLE(irq) if (irq != -1) disable_irq(irq)

plip_open() never calls ENABLE(dev->irq). It only calls
enable_parport_interrupts(), which for parport_pc ends up in
parport_pc_enable_irq():

	__parport_pc_frob_control (p, 0x10, 0x10);

That sets the chip's IRQ enable bit, but it does not unmask the Linux IRQ
line. The other DISABLE/ENABLE pairs in the transfer and recovery paths
balance each other, and none of them undoes the disable in close.

After an ifdown/ifup, the IRQ disable depth stays at one or more. As a
result, plip_interrupt() is never delivered and the interface can't
receive.

dev->irq is the parport controller's IRQ (plip_attach() sets it from
port->irq), and PCI parport cards request it with IRQF_SHARED. Doesn't
this also leave the line masked for other parport clients and for any
device sharing that IRQ?

>  #ifdef NOTDEF
>  	outb(0x00, PAR_DATA(dev));
>  #endif

[Severity: Low]
This is a pre-existing issue, but plip_close() never sets the data
register back to idle before parport_release(). The only reset is the
outb() above, which is compiled out.

If the interface is closed mid-transfer, the last handshake value stays on
the wire. Examples are the 0x08 trigger from plip_send_packet() or the ACK
from plip_receive_packet():

	write_data (dev, 0x01); /* send ACK */

parport_pc_save_state() and parport_pc_restore_state() only handle CTR and
ECR. The data value therefore stays in place until this side reopens and
plip_open() writes 0x00. Until then the peer may stay in PLIP_CN_ERROR.

This patch doesn't change that behaviour. Before it, any work still
pending after close was already a no-op: close sets nl->is_deferred = 0
and nl->connection = PLIP_CN_NONE. So plip_kick_bh() returned early and
plip_bh() ran plip_none(), and neither of them writes the data register.

Would a write_data(dev, 0x00) after the work is drained and before
parport_release() be a reasonable cleanup here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928134136.1213-1-getshell%40seu.edu.cn
