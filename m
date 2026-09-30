Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D036998C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736652; cv=none; b=Pf+ILMd8r3MjTkJfdK4CfoY3FpmaptceJz4OXlUnsrAbyTasiPH6EJmq7Y+zAJVN9vlTNKg1IqJGDxk1eUHmPQlqOx0irossDZjZz1kQzwE6CSokjyqOeg5lZP2s6s+i5SxTUKhrXpKiPQpxGrguTivL4H9Ji1gDdWOJvtqrYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736652; c=relaxed/simple;
	bh=yoOJ8vWPOpq54rWmqYMnqXl8rODACNnUVU+dLhAzVUQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EDyOLSw5EvBOfhaHBxnfbsZxKoWKAS4WCwBeAiMyIrvKb4zzaGjMaMRXt8EFmD/N6mra3TmFpg5w3NrWiC3AE0soxwsSosb38Pbrrux3YR3eDOHRk9BpyZUs2RIrSlXl7I3s5WHN5J3trTHD9hMgFPI/HQEJgFcWmGE5PpISYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO9p5WNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO9p5WNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F1E1F00898;
	Wed, 30 Sep 2026 02:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736647;
	bh=M5gaPISJz/YDKYlwS9SDruvkmSzz1aLWxoSb/Ho2iPU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jO9p5WNgS9NoD7ko/6Yt/QBvisRrcBtbp07IWnoud1h3VqtDgvAB1Gj09+Zilhn3u
	 8OsVBEEsTC4PNHRtPIDthY4db+4gMgaYeWHlVn9j5eJfTRqwJ/A6n60QpnhF+cfQYP
	 1wm9ZjEz1CgcbLjnChBREgg2qHad8a0G3Xa2ueS/kt0LsF98wMhTZIFVK7/ED++2tP
	 rEDU0bglut0yw2p5XfDqqn3BXxAwPqHQx3XNqlITELX70wV0HdKrkCSAc0wxecjKpr
	 bnZ8Wn5on0XC4t8MCWJ/94DzhZvM71hHro3IpiaoO9/9QgNJMRomnYKXuSxgT7+nxh
	 Aiqj1D4+bn/4Q==
Subject: Re: [PATCH net-next v2 11/11] net: ethernet: cortina: Use guard
 helpers for locking
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:46 +0000
Message-ID: <179073664681.434549.10297325133888163725@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-11-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-11-758a795d7a78@kernel.org>
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

- [Low] The patch goes against netdev's documented policy on cleanup.h
  and on standalone clean-ups.
- [Low] gmac_rx() now mixes goto-based cleanup with a cleanup.h helper,
  which subsystem/cleanup.md and include/linux/cleanup.h (lines 148-153)…

--

net: ethernet: cortina: Use guard helpers for locking

This commit converts the spinlock lock and unlock pairs in the Gemini
ethernet driver to guard() and scoped_guard() from linux/cleanup.h. The
goto based unlock path in geth_freeq_claim() is replaced with early
returns. No functional change is intended.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 910de9925949..4fdd7478601f 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -790,10 +778,11 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
>  
>  	index = geth_freeq_mapping_index(geth, mapping);
>  
> -	spin_lock_irqsave(&geth->freeq_lock, flags);
> +	guard(spinlock_irqsave)(&geth->freeq_lock);
> +
>  	gpage = xa_load(&geth->freeq_mappings, index);
>  	if (!gpage || !gpage->page || !gpage->fragments)
> -		goto err_unlock;
> +		return NULL;

[Severity: Low]
Does this conversion fit the netdev guidance on cleanup.h?
Documentation/process/maintainer-netdev.rst says:

  Use of guard() is discouraged within any function longer than 20 lines,
  scoped_guard() is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.

geth_freeq_claim() is about 46 lines long. Its function-scope guard()
covers xa_load(), xa_erase(), dma_unmap_single_attrs() and put_page().
There are also two early return NULL exits, which now release freeq_lock
implicitly.

gmac_update_hw_stats(), gmac_enable_irq() and the gemini_port_irq()
hardirq handler are also longer than 20 lines and now use a
function-scope guard().

The same document also says:

  Netdev discourages patches which perform simple clean-ups, which are not
  in the context of other work.

The commit message only says "Use cleanup guard helpers to scope the
driver's spinlocks automatically". The patch has no functional change, and
it touches the RX and IRQ paths in gmac_rx(), gmac_irq() and
gemini_port_irq(). That may make stable backports harder.

Would it be better to keep the explicit spin_lock_irqsave() and
spin_unlock_irqrestore() calls in the longer functions? Or use
scoped_guard() there, or fold this into other work on the driver?

[ ... ]

> @@ -1622,17 +1593,16 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,

[ ... ]

> -	spin_lock_irqsave(&geth->irq_lock, flags);
> -	rw.bits32 = readl(ptr_reg);
> -	/* Reset interrupt as all packages until here are taken into account */
> -	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
> -	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
> -	spin_unlock_irqrestore(&geth->irq_lock, flags);
> +	scoped_guard(spinlock_irqsave, &geth->irq_lock) {
> +		rw.bits32 = readl(ptr_reg);
> +		/* Reset interrupt as all packages until here are taken into account */
> +		writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
> +		       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
> +	}
>  
>  	r = rw.bits.rptr;
>  	w = rw.bits.wptr;

[Severity: Low]
Does this mix goto based cleanup with a cleanup.h helper in gmac_rx()?

Before this patch gmac_rx() used only gotos. Its RX loop already relies on
goto based cleanup through the err_length, err_drop and next_desc labels:

err_drop:
		if (skb) {
			napi_free_frags(&port->napi);
			skb = NULL;
			frag_nr = 0;
		}

		if (page)
			put_page(page);

include/linux/cleanup.h says:

  the expectation is that usage of "goto" and cleanup helpers is never
  mixed in the same function. I.e. for a given routine, convert all
  resources that need a "goto" cleanup to scope-based cleanup, or
  convert none of them.

Nothing goes wrong today. The scoped_guard() block closes before the while
loop, and none of the gotos cross its scope.

If the locked section were later moved into the loop, or changed to
guard(), those gotos would jump across a cleanup scope.

Could gmac_rx() keep the explicit spin_lock_irqsave() and
spin_unlock_irqrestore() pair? Another option is to move the locked rwptr
read and interrupt ack into a small helper.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
