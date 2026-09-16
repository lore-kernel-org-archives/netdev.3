Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657B4E56D1;
	Wed, 16 Sep 2026 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559408; cv=none; b=U40nr7NKdrZA1ZJC80gpYnup5BjNpERX4lkMQRGanbMvYLIY/kwqn65AYd2YdYcVyUZgxWP1Dawe3NMRTl0dpLhtLCN6rMVCrNvcBTAvD+ithu+b0vURW+o7wM0uxjpdRJe6N0Yy05HhvTj7jGP+hcviZrlGZKl3JFjJkbr29Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559408; c=relaxed/simple;
	bh=BtzL1WjzyyiVgDG9bdORuUhmySKbO+w1kIj3Wp4eExA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AH3XmON5CPYQghvXhReK2iOsM/nMW6/pME7QSGSMuro4PkhksJvQ4UNDxHUT9yC6dna8ZAYpknAXC/e+W+sLTGt4f0aaWBh3FP3iz9TJRQy9Jnn2Xf+zSQrZSfzl1qwlwbE6qF3tH/po1uCeNrStv7s8YRbUv5riWbyeBdfjSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5d9o3/Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5d9o3/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DCB1F000FF;
	Wed, 16 Sep 2026 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559396;
	bh=LjgLSw2MeL5vGjW/rbVSbpNes7RvuqTBrpBub5QjU2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V5d9o3/Q56q/nqPu66WlLzFTSH6eWM2fvDyPPX8s53fRCK2Q4O8mXKdFR0+sbs4IM
	 2Uwtw0HbQW92rHuVl1BRdMmS+JBi+A53ws4jhb/0x8xMqEmbrJRf1ez2/gq+XxywCD
	 sX0MDaUpqS4H6oIy3MWelsBGsGl3NISxAI19FIlqC/bHydqGRsQbF4m/Ge31FLNRqo
	 i93OKRE2fMcVSlBPlRY6NsueMZQiQDCdiSR0GDDp/8Gg/gaWIhL75hrID+CApdizns
	 VfNMFIbiltLrr+zVODBlxTccoWGyG6MiEPtm8myDzVO+ORhK8XGt/eg9J6VtSngcQX
	 FKcxG7AGCUPOA==
Subject:
 Re: [PATCH net] net: axienet: bound TX completion cleanup by the NAPI budget
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 robert.hancock@calian.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 11:49:55 +0000
Message-ID: <178955939540.22033.11518643324722820075@kernel.org>
In-Reply-To: <20260914114821.55503-1-maimon.sagi@gmail.com>
References: <20260914114821.55503-1-maimon.sagi@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] drivers/net/ethernet/xilinx/xilinx_axienet_main.c:795 — the
  newly added `if (!force && packets >= budget) break;` is evaluated at…
- [Low] The kernel-doc block of axienet_free_tx_chain()
  (drivers/net/ethernet/xilinx/xilinx_axienet_main.c:768-781) was not…

--

net: axienet: bound TX completion cleanup by the NAPI budget

This adds a break in axienet_free_tx_chain() so the TX completion loop
stops once the NAPI budget has been spent, instead of being bounded only
by the TX ring size.  The check is skipped when @force is set.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..4381643227139 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -788,6 +788,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  	dma_addr_t phys;
>  
>  	for (i = 0; i < nr_bds; i++) {
> +		/* A NAPI poll must not return more than its budget.  Stop on a
> +		 * packet boundary once it is spent - cur_p->skb is only set on
> +		 * a packet's last descriptor, so no packet is left half-freed.
> +		 */
> +		if (!force && packets >= budget)
> +			break;
> +

[Severity: High]
What happens on this path when budget is 0 and force is false?  The test
is evaluated before any descriptor is looked at, and 0 >= 0 is true, so
the loop breaks at i == 0.

netpoll calls the poll function with a budget of exactly 0:

net/core/netpoll.c:poll_one_napi() {
	...
	/* We explicitly pass the polling call a budget of 0 to
	 * indicate that we are clearing the Tx path only.
	 */
	work = napi->poll(napi, 0);
	...
}

lp->napi_tx is registered with netif_napi_add() in axienet_probe(), so it
is on dev->napi_list and poll_napi() reaches axienet_tx_poll(), which
forwards the budget unchanged with force = false:

	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
					&size, budget);

With the new break taken at i == 0, does this turn the netpoll TX reclaim
into a no-op?  No dma_unmap_single() or napi_consume_skb() runs, and
lp->tx_bd_ci += i leaves the consumer index unchanged.

Since packets is then 0, axienet_tx_poll() also skips the if (packets)
block containing netdev_completed_queue() and netif_wake_queue(), and
packets < budget (0 < 0) is false, so napi_complete_done() and the
re-write of lp->tx_dma_cr that re-enables TX completion interrupts are
skipped too.

Can this stall netconsole/kgdboe output when interrupts are disabled, for
example during an oops, where the TX completion interrupt and the NAPI
softirq will never run?  Ring-full detection depends only on software
clearing cur_p->cntrl:

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_check_tx_bd_space() {
	...
	if (cur_p->cntrl)
		return NETDEV_TX_BUSY;
	...
}

and cur_p->cntrl is cleared solely by axienet_free_tx_chain(), so
netif_xmit_stopped(txq) stays true and __netpoll_send_skb()'s bounded
retry loop, which calls netpoll_poll_dev() to "tickle device maybe there
is some cleanup", exhausts its tries with the skbs still pinned on the
ring.

Before this patch the same call cleaned every completed descriptor, with
budget only used as the napi_consume_skb() bulk-free hint, and
napi_consume_skb(skb, 0) degrades to dev_consume_skb_any().

Would it work to make budget 0 mean "clean everything, report no work",
for instance:

	if (!force && budget && packets >= budget)
		break;

or alternatively leave the loop unbounded and clamp the value returned by
axienet_tx_poll() to the budget?

The commit message reasons about budget 0 only for the force path:

  "The check is skipped on the @force path, which cleans up
   after a DMA mapping failure with a @budget of 0."

Could the netpoll caller be covered as well, since it uses budget 0 with
force = false?

[Severity: Low]
Should the kernel-doc block just above axienet_free_tx_chain() be updated
in the same patch?  It still reads:

 * @nr_bds:	Max number of descriptors to clean up
 ...
 * @budget:	NAPI budget (use 0 when not called from NAPI poll)

@nr_bds is no longer the only cleanup bound for the !force path, and
@budget is no longer just a napi_consume_skb() hint.  A caller that
follows the documented advice of passing 0 outside NAPI poll with
force = false now reclaims nothing and does not advance lp->tx_bd_ci.
Could the @budget line state that cleanup stops after @budget completed
packets when @force is false?

>  		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
>  		status = cur_p->status;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914114821.55503-1-maimon.sagi%40gmail.com
