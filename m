Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6ED408612;
	Thu,  1 Oct 2026 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870809; cv=none; b=LavoEy3tBzHLDojIguPyzwZy0dzem3AFuKfguK9VxCGHXOfx2Q7nprpODq53xmxQ9L1qp4QlEOl23fwoyFrvuqyfuSja5q9W01pTnqCK74XUtpE2Fx++C8m8uu0AZU8DSpMLH2IQMUUGf7XV4+iN0x184mRv/lF5Uc5RljS70RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870809; c=relaxed/simple;
	bh=l8+noZkp63aNawaAnj+8TsRyj2+ycU1v89Te3nvroKE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvGv1yAjUQRIYqr1a6ILX9SjwOMaawmEyXBZxE336mLQk36xL9/Oy6BK+IbgT8B236bi8Q7x0Sw2AewVBzO3epTOrTkBcrdaHSuytx4Xo11i6YePX73cvR0Us1ZquMjH6fTbfgiRU5uvJiMViWY3udcqgWbwys0t2ebBiNqKF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFrAH2g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFrAH2g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AD11F008BD;
	Thu,  1 Oct 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790870806;
	bh=QzdZVGsBhb86uFnqhlQV/l3Wz3CnvhbzCzbHnzSCWUs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GFrAH2g3gbw+2wqb39X9mzsup+WCKbIqwLLvaTS+mlo5VO6VbvKvCh873/7yqyD3l
	 D9IiO/pwkDPYZC5PNQl9KsbYXUeu/IRMPbn2Cn2UZMSENigM6lTN9L/+rpt6NlknHL
	 EoehOqGkU1gHjLlaew1VcYBULCTlhpv3DYO4bJsYMCDB07AgGG4u7zBg5a1r7XCqW0
	 IoEswiun36o8KZ6irowxkRZ2HsUR5p+LcOfhu6R484w5fZX7yIyV2pzMXbZjxTYYyd
	 imjVfLDijvAfiUP9ExYDDQvFs7fJ92N3MwqxP+ypUg5hsXZ9wn+lXXR+nBhBwrEUBp
	 DsMy67a7/Ls1g==
Subject:
 Re: [PATCH net-next v15 3/7] r8169: add support for new interrupt mapping
From: netdev-bot+sashiko@kernel.org
To: javen_xu@realsil.com.cn
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 16:06:45 +0000
Message-ID: <179087080509.434549.16383544775565277664@kernel.org>
In-Reply-To: <20260928070423.202-4-javen_xu@realsil.com.cn>
References: <20260928070423.202-4-javen_xu@realsil.com.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/ethernet/realtek/r8169_main.c,
  rtl8169_request_irq() registers rtl8169_interrupt_msix for every…
- [Low] Concern: the commit message says the patch adds support for the
  new interrupt mapping, but every new path is gated by tp->irq_nvecs >…

--

r8169: add support for new interrupt mapping

This commit adds the vector-map interrupt registers (IMR_SET_VEC_MAP_REG,
IMR_CLEAR_VEC_MAP_REG, ISR_VEC_MAP_REG). It also adds per-vector MSI-X
handlers for the RX queues, the TX queue and link change, plus separate
RX and TX NAPI poll functions. All of the new paths are gated on
tp->irq_nvecs > 1.

> To support RSS, the number of hardware interrupt bits should match the
> interrupt of software. So we add support for new interrupt mapping here.

[Severity: Low]
This isn't a bug, but every new path in this patch is gated on
tp->irq_nvecs > 1. At this commit rtl_alloc_irq() still does:

    nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

so none of the new vector-map code can be reached yet.

The next patch in the series, "r8169: enable new interrupt mapping",
changes rtl_alloc_irq() to request get_min_irq_nvecs()..get_max_irq_nvecs()
vectors, and that is what turns this code on.

Could the commit message say that this patch only adds the infrastructure
and that the next patch enables it?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f24a1e1f435c0..4656ae108f9c6 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5219,18 +5310,28 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  		napi = &tp->rtl8169_napi[i];
>  		irq = pci_irq_vector(pdev, i);
>  
> -		rc = request_irq(irq, rtl8169_interrupt, irqflags,
> -				 dev->name, napi);
> +		if (tp->irq_nvecs > 1) {
> +			/* RX: 0~7, TX: 8*/
> +			if (i <= R8169_MAX_RX_QUEUES)
> +				rc = request_irq(irq, rtl8169_interrupt_msix,
> +						 irqflags, dev->name, napi);

[Severity: Medium]
This installs rtl8169_interrupt_msix() on every vector from 0 to 8, with
&tp->rtl8169_napi[i] as dev_id. However, r8169_init_napi() only calls
netif_napi_add() for the active RX rings and for index
R8169_MAX_RX_QUEUES:

    for (i = 0; i < tp->num_rx_rings; i++) {
        netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
                       rtl8169_poll_msix_rx);

What happens if a message arrives on a vector between num_rx_rings and 7?
Those napi entries are still zeroed from kcalloc(), so
rtl8169_interrupt_msix() would do:

    struct net_device *dev = napi->dev;    /* NULL */
    ...
    tp = netdev_priv(dev);
    message_id = napi - tp->rtl8169_napi;

    rtl8169_disable_hw_interrupt_msix(tp, message_id);

Could this oops in hardirq context when RTL_W32() goes through
tp->mmio_addr? If it didn't fault, it would call napi_schedule() on a
NAPI that was never added.

This can't happen at this commit, because only one vector is allocated.
Later in the series, rtl_alloc_irq() requests 30 to 32 vectors on
RTL_GIGA_MAC_VER_80. num_rx_rings comes from
rounddown_pow_of_two(min(netif_get_num_default_rss_queues(), 8)), which
is 1 in a kdump kernel and below 8 on many machines.

Only the vector-map IMR keeps these vectors quiet, and it isn't cleared
before the handlers are installed:

  - At probe, rtl8169_irq_mask_and_ack() runs before rtl_alloc_irq() sets
    irq_nvecs. It therefore clears IntrMask_8125, not the vector-map IMR.
  - In rtl_open(), rtl8169_request_irq() runs before rtl8169_up() resets
    the vector-map IMR.

Could IMR state left by a previous kernel fire one of these vectors as
soon as request_irq() unmasks it? One example is a crashed kernel before
kdump that had more rings enabled.

Would it make sense to request the MSI-X handler only for
i < tp->num_rx_rings, i == R8169_MAX_RX_QUEUES and
i == MSIX_ID_VEC_MAP_LINKCHG, so the set matches the NAPI setup?
rtl8169_free_one_irq() uses the same i <= R8169_MAX_RX_QUEUES check and
would need the matching change.

> +			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
> +				rc = request_irq(irq, rtl8169_interrupt_other,
> +						 irqflags, dev->name, tp);
> +			else
> +				continue;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928070423.202-1-javen_xu%40realsil.com.cn
