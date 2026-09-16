Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F26348477;
	Wed, 16 Sep 2026 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521853; cv=none; b=sKpfqV7Elc7gEl0MGVxC/VTLywh1VF3U5KUU3pWBOaADHXHKxSCBpLHrjFQXfpvX8lQRiArh6tb1MzaiFBRl5ZHwz+enoHVxrt0oZrfovxE/GK3xq5iVERpnjPjDTwMjlDpYLJl9ErD83JxMHdUGLjHJXBZ3OEn9zv0yXsZgKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521853; c=relaxed/simple;
	bh=n8+5dHg3jdmWa57RiC8x7xDwMxMSLE8du758VDc+8aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkdCiSSa+E7suUozeoYHl7R//BUbOTPqxVAI6BZzDC3zi8N+pi/T8Pwq15kyk8/27J2tnvmCsj4AZOitP0tYDTiQrZNTdh2kSAQtWo9IDOERNqhJH7mbhLEG5YTvTofhA5Dr0f0OywxaSP4zIJWn7bMLDgQPBmG9INxfpSwXnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlTIzsrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlTIzsrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9291F000FF;
	Wed, 16 Sep 2026 01:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521852;
	bh=PlD7CFT+H6A8lBwoe+Oft1tubktXcd3yJZSUUnwZ5hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlTIzsrDMjuH6qEhz4zd47Vx61PEN61JPhKFSUsi9AK9F9vomZ7Bang/FHsJlfb8t
	 s8hpn5mWz7Lw6jw36RcuHsjQVpPdCP1wVexEsRqCuRByfm7Yb0gR+3XH3v2Ey45Sv6
	 uE+i5VaCKE7HD3rfMMvGGH2qybIpuYIEYeMxuCiTFH7lekgqiQnhVOkenqjnWYW1x7
	 Ja0wrLExCASdQmECVOcj66QW7DSux+ADJlB+p7TA5FYor/t+agv+btxBAqgfZtEOTI
	 9Q7xbhKP29ma86i+tvsJDMVXDZroBmmWosEmF57iILq9Ad6nzpHCSQGlS/QVtrazF8
	 8TUWOK1n74DDw==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 1/7] r8169: add support for multi irqs
Date: Tue, 15 Sep 2026 18:24:10 -0700
Message-ID: <20260916012410.1649367-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063110.1350-2-javen_xu@realsil.com.cn>
References: <20260910063110.1350-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: add support for multi irqs

This converts the single struct napi_struct in struct rtl8169_private into a
dynamically allocated array indexed by IRQ vector, replaces the open-coded
request_irq()/free_irq() calls with per-vector pci_request_irq()/pci_free_irq()
helpers, and passes the NAPI instance through rtl_rx() and the interrupt
handler.

A couple of questions below.

> RSS uses multi rx queues to receive packets, and each rx queue needs one
> irq and napi. So this patch adds support for multi irqs and napi here.

[Severity: Low]
This isn't a bug, but does the changelog match what the patch does?

rtl_alloc_irq() still asks for exactly one vector:

	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);

and the new rtl_setup_rx_params() hard-codes a single ring:

	static void rtl_setup_rx_params(struct rtl8169_private *tp)
	{
		tp->num_rx_rings = 1;
	}

So tp->irq_nvecs and tp->num_rx_rings are both always 1 here, every new
loop over irq_nvecs runs once, and netif_set_real_num_queues(tp->dev, 1, 1)
has no effect until the later patches in the series raise the vector and
queue counts.  Would something like "prepare for multiple IRQs and NAPI
instances, no functional change" describe this patch more accurately?

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5415ff62a2869..b362855c262f8 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -5043,13 +5066,43 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  	}
>  
>  	rtl_irq_disable(tp);
> -	napi_schedule(&tp->napi);
> +	napi_schedule(napi);
>  out:
>  	rtl_ack_events(tp, status);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static void rtl8169_free_irq(struct rtl8169_private *tp)
> +{
> +	for (int i = 0; i < tp->irq_nvecs; i++) {
> +		struct napi_struct *napi = &tp->rtl8169_napi[i];
> +
> +		pci_free_irq(tp->pci_dev, i, napi);
> +	}
> +}
> +
> +static int rtl8169_request_irq(struct rtl8169_private *tp)
> +{
> +	struct net_device *dev = tp->dev;
> +	struct napi_struct *napi;
> +	int i, rc;
> +
> +	for (i = 0; i < tp->irq_nvecs; i++) {
> +		napi = &tp->rtl8169_napi[i];
> +		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> +				     NULL, napi, "%s-%d", dev->name, i);
> +		if (rc)
> +			goto free_irq;
> +	}
> +	return 0;

[Severity: Medium]
Does switching to pci_request_irq() here drop IRQF_NO_THREAD for MSI and
MSI-X?

pci_request_irq() in drivers/pci/irq.c has no flags argument:

	unsigned long irqflags = IRQF_SHARED;

	if (!handler)
		irqflags |= IRQF_ONESHOT;

Since rtl8169_interrupt is passed as the primary handler and thread_fn is
NULL, every vector ends up registered with plain IRQF_SHARED.  On kernels
booted with threadirqs, and on PREEMPT_RT where force_irqthreads() is
always true, irq_setup_forced_threading() in kernel/irq/manage.c then does:

	if (new->flags & (IRQF_NO_THREAD | IRQF_PERCPU | IRQF_ONESHOT))
		return 0;
	...
	new->flags |= IRQF_ONESHOT;

so rtl8169_interrupt() is moved into ->thread_fn behind
irq_default_primary_handler() and the vector stays masked for the duration
of the handler.

That looks like it reverts commit 870f531e178e ("r8169: set IRQF_NO_THREAD
if MSI(X) is enabled"), which set IRQF_NO_THREAD precisely because MSI and
MSI-X are never shared.  Was this behaviour change intended?  If not,
request_threaded_irq() with per-vector flags would keep the previous
semantics.

> +
> +free_irq:
> +	while (--i >= 0)
> +		pci_free_irq(tp->pci_dev, i, &tp->rtl8169_napi[i]);
> +	return rc;
> +}
> +

[ ... ]

> @@ -5221,7 +5275,6 @@ static int rtl_open(struct net_device *dev)
>  {
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  	struct pci_dev *pdev = tp->pci_dev;
> -	unsigned long irqflags;
>  	int retval = -ENOMEM;
>  
>  	pm_runtime_get_sync(&pdev->dev);
> @@ -5246,8 +5299,7 @@ static int rtl_open(struct net_device *dev)
>  
>  	rtl_request_firmware(tp);
>  
> -	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_NO_THREAD : IRQF_SHARED;
> -	retval = request_irq(tp->irq, rtl8169_interrupt, irqflags, dev->name, tp);
> +	retval = rtl8169_request_irq(tp);
>  	if (retval < 0)
>  		goto err_release_fw_2;
>  

[ ... ]

> @@ -6202,10 +6283,17 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		}
>  	}
>  
> +	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
> +				   GFP_KERNEL);
> +	if (!tp->rtl8169_napi)
> +		return -ENOMEM;

[Severity: Medium]
Does this new error exit leak the phylink instance?

rtl_init_phylink() stores an unmanaged phylink_create() result in
tp->phylink, and the neighbouring failure paths in rtl_init_one() all
release it explicitly, for example the r8169_mdio_register() failure:

	rc = r8169_mdio_register(tp);
	if (rc) {
		phylink_destroy(tp->phylink);
		return rc;
	}

and the register_netdev() failure just below:

	rc = register_netdev(dev);
	if (rc) {
		phylink_destroy(tp->phylink);
		goto err_free_napi;
	}

The netdev itself is devm-allocated, so devres unwinding on probe failure
frees the netdev but nothing frees the phylink object.  Should this branch
use the same unwind, e.g. rc = -ENOMEM followed by a goto to a label that
calls phylink_destroy()?

This is still the case at the end of the series, where the same branch only
gains a kfree(tp->rx_ring).

> +
> +	r8169_init_napi(tp);
> +
>  	rc = register_netdev(dev);
>  	if (rc) {
>  		phylink_destroy(tp->phylink);
> -		return rc;
> +		goto err_free_napi;
>  	}
>  

[ ... ]
-- 
pw-bot: cr
