Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973176;
	b=26jBHPHcbJWbnwBlG3vFqGvAOIAH6Ye1MS38vREGAfIedHucNVf5vyy6FRqpC8XYmkgm
	 gLCmwaivv+leoIMpXOckkL2Dfp/ar+dRTiS21v67fUHMiBX8MjNqPlIHWiQFhogv3JltJ
	 e9fgdH7q9PRf3MCbdgFZs8I/uWz1n3nuz32sFxqZOnZUYyi5gXM7MA3CbhbFDbfKr6Vtq
	 jzzXCTdiFKQJmb9iiGdo7WkSM+CsehyJcaLbKMJRicIS6fLFFcyWncTVm80QI60BWR0Ey
	 w3yjp+XpGfSIh3lgKsVmOyiEsldOjw6WIfsBRgFYD4Y5hA+3AHtmhDLf9hwxJLv43hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973176;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iLJUa7RNyvktGWZspqCmJJxytObzLNUkqP+M9DQ5xt4=;
	b=CZQyy9KMxzLB1Mz9C8fn9ZN/pBAvJvuHGY/gxQZ6X9fclBEcoMh6SjyESVX5LFp2l3LX
	 uWw3bepek5nb7NCWV7r1iivCnX5f7hyPz40SfpYKgVQbx6AVBla8R4gbVk3cSvIVPu4Ve
	 7c42VBmIko/GG2AWsgaN+oPxIZ9t6a7eOd/cXip2fproOV5tBcT1uBLQ6/5jm91Y2l8RT
	 CscAmfWPK58Fh+h5Ndi4/TnO3ao+fPR6wEEWexizLE1MoIRNbw1muFq0+t/7QSfVnmJ7e
	 O5pfom5Y+pCB5pLJogBIW68qoRmA822hDEEUEDblU5CmFFPMu9CXJj6+5mWOXQtXZbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nB+xwxhw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5B606A31A;
	Mon, 26 Oct 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nB+xwxhw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF181F01825;
	Mon, 26 Oct 2026 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973176;
	bh=iLJUa7RNyvktGWZspqCmJJxytObzLNUkqP+M9DQ5xt4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nB+xwxhwtztbe4cVzrr7c8zzmFgOCRUra0/q3I+Q7KR8Kj3GRn4an/M/pqVY8oasN
	 rZZQ/hku1ZTpm2hbgaP87qmkcWxIAwwhabXICZfhN33ayMv/Hsftv5rCXaaR0JRrSd
	 DsgxVN+lujYi71Gk1bFHy5FifogawOspSI+ylqJu/RYg02FdPbKPXnM2FK9OdNEmqq
	 BVekgnnD7D3LqNqAe4xdD+Ed6vekhgBru6z4WctrfW6FYbZHnOZIXEBRBQRbz8JbqQ
	 gaEdCGAelbVhq7/JWHArO/JXV7DEAGYk6CdZihp7RCCAn0ZaENHVHLEYd8gFaTW+e4
	 8hbTYoJobuK7w==
Subject:
 Re: [PATCH net] net: 8139cp: close race between NAPI completion and Rx unmask
From: netdev-bot+sashiko@kernel.org
To: colton.pawielski@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@0x0f.com, geert@linux-m68k.org
Date: Mon, 26 Oct 2026 00:06:15 +0000
Message-ID: <179297317507.3134.14510456592684233796@kernel.org>
In-Reply-To: <20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com>
References: <20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch moves napi_complete_done() inside
  spin_lock_irqsave(&cp->lock) in cp_rx_poll()…

--

net: 8139cp: close race between NAPI completion and Rx unmask

This commit moves napi_complete_done() in cp_rx_poll() so that it runs
under cp->lock with interrupts disabled. NAPI completion and the Rx
IntrMask unmask then happen atomically with respect to cp_interrupt().
The goal is to fix an Rx interrupt storm that hard-hung SH7751 LANDISK
boards.

> diff --git a/drivers/net/ethernet/realtek/8139cp.c b/drivers/net/ethernet/realtek/8139cp.c
> index 9016527e229a..a9334d3a0f7d 100644
> --- a/drivers/net/ethernet/realtek/8139cp.c
> +++ b/drivers/net/ethernet/realtek/8139cp.c
> @@ -554,11 +554,12 @@ static int cp_rx_poll(struct napi_struct *napi, int budget)
>  	/* if we did not reach work limit, then we're done with
>  	 * this round of polling
>  	 */
> -	if (rx < budget && napi_complete_done(napi, rx)) {
> +	if (rx < budget) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&cp->lock, flags);
> -		cpw16_f(IntrMask, cp_intr_mask);
> +		if (napi_complete_done(napi, rx))
> +			cpw16_f(IntrMask, cp_intr_mask);

[Severity: Critical]
Can this deadlock on cp->lock?

8139cp passes every received frame to GRO in cp_rx_skb():

    napi_gro_receive(&cp->napi, skb);

Frames that GRO cannot merge wait on gro->rx_list until gro_normal_batch
is reached, and TCP flows can sit in the GRO hash. All of them are
delivered by napi_complete_done() when the poll ends with rx < budget:

napi_complete_done()
  gro_flush_normal()
    gro_flush()
    gro_normal_list()
      netif_receive_skb_list_internal()

With this change, that receive processing runs with cp->lock held and
hard IRQs off.

Suppose the stack replies synchronously on the same interface, for
example with an ARP reply, an ICMP echo reply, a TCP ACK, or a forwarded
or bridged frame. The transmit path then seems to come back into the
driver:

netif_receive_skb_list_internal()
  arp_process() / icmp_reply() / tcp_send_ack()
    dev_queue_xmit()
      sch_direct_xmit()
        dev_hard_start_xmit()
          cp_start_xmit()
            spin_lock_irqsave(&cp->lock, intr_flags);

Wouldn't this CPU then spin forever on a cp->lock it already holds? On
SMP, one ARP request or ping from a peer on the link looks like enough to
trigger it. That includes QEMU's emulated rtl8139, which reports revision
0x20 and binds to 8139cp.

There may also be a second path. __dev_queue_xmit() uses
rcu_read_lock_bh()/rcu_read_unlock_bh(), and netfilter uses
local_bh_disable()/local_bh_enable(). Both reach __local_bh_enable_ip().
That function does lockdep_assert_irqs_enabled(), and with
CONFIG_TRACE_IRQFLAGS it also calls local_irq_enable().

Could hard IRQs come back on while cp->lock is still held? Then
cp_interrupt() could run on the same CPU and spin on:

    spin_lock(&cp->lock);

The commit message says:

    Do the completion and the unmask under the lock, as 8139too does.

Does that comparison carry over? rtl8139_rx() in 8139too calls
netif_receive_skb() directly, so its GRO lists stay empty. As a result,
napi_complete_done() under tp->lock in rtl8139_poll() never delivers
packets.

Before commit ab1e7e1d2666 ("8139cp: use napi_complete_done()"),
cp_rx_poll() called napi_gro_flush(napi, false) before taking cp->lock.
Only __napi_complete() and the IntrMask write were done under the lock.

The SH7751 test boards are UP. There, spin_lock() without
DEBUG_SPINLOCK reduces to preempt_disable(), which may explain why this
didn't show up in testing.

Would it work to keep GRO flushing and stack delivery outside cp->lock?
Only the NAPI state change and the IntrMask unmask would then run under
the lock. One way is to flush GRO before taking the lock. Another is to
keep napi_complete_done() outside the lock and close the race some
other way, for example by re-checking IntrStatus or handling the case in
cp_interrupt().

>  		spin_unlock_irqrestore(&cp->lock, flags);
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-b4-8139cp-napi-v1-1-c9b683d9564b%40gmail.com
