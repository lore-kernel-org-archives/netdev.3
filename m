Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00209530DE7;
	Tue, 22 Sep 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071767; cv=none; b=XSvOk9oHUFu2a0n+wTEV+l8u2zXQNDnx8zvPob5IKjZ4SWpaXwQKCLPaIAbAPe/v3k5g7dvGUwH2HulgHdqM63p+I92cs/wUOyNJLNboex/7Ck952fScd+wkeTVACWQKWePYnruY381L4PoFHvGz6dCrbC0N0HBANOmToecJIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071767; c=relaxed/simple;
	bh=qTqHwclqRWBclsZaysC5q9ddYkhx1/0njDAW5arZiG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVeQuuPDhTVvwed/FljLVTVIykXJ9pLU21wDSjMtPfuUnOISeXSk//PqgdGMtxEY0zeoT2DNt0WKmdJaBHbpRypDaBRZLO8gaRiEJm161hP4mYSIxKrKJIPpnl3/O8dczb7qBiLqs52AARPAjqO/Y2W0gq2I2Es5aEJg4zdDpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PErfNAeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PErfNAeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D01F00898;
	Tue, 22 Sep 2026 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071757;
	bh=vNzKIHCSRmHMesEJDdC2iO7/Tn/+hgA/tdwMMDzneoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PErfNAeI5VSx79fg9xu2V1T+OieOV3Yoe5vhWUMNrRcqelwAu45DlePftQi6m+/S9
	 ae/TEtGWwMo5ULKQVHFCyBqguRYRmUTJNgTdp0wHPITtptOrf+4rE5oYWWE7VZ3Hh6
	 pOGWXVHH1ezleqANmX1iRLnB6v4tXeugk8mxJAQBYk4eayVwJFj+HqxQ40LcaYO692
	 2qBimcb21Buur2kPaj5yKSj/05Upsc6CRZCTR7wvPQqLDYhA0BwXtsaZrTK4C/iTXw
	 1gu3RysWxvFn48EvbTUp01R6J1jMBZ5FDRcxGr1aTZH1m/HrvhLtWO+XFMwOsP0CUm
	 LJ2xUCyZL1m0Q==
Date: Tue, 22 Sep 2026 11:09:13 +0100
From: Simon Horman <horms@kernel.org>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v3 2/3] dinghai: add MSI-X interrupt pools
Message-ID: <20260922100913.GA13925@horms.kernel.org>
References: <202609211451400236_aZ55Ox3y7NW8MQnYImM@zte.com.cn>
 <202609211459460680vBvKdpuZZ9yR4QVn3ONR@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609211459460680vBvKdpuZZ9yR4QVn3ONR@zte.com.cn>

On Mon, Sep 21, 2026 at 02:59:46PM +0800, han.junyang@zte.com.cn wrote:
> From: Junyang Han <han.junyang@zte.com.cn>
> 
> Allocate the fixed MSI-X vector layout of the device and manage the
> vectors in per-purpose pools: the async event queues first, a range
> reserved for RDMA in between and the vq queue pairs last. This series
> wires up the async pool; the vq pool comes with the netdev series.
> 
> IRQs are reference counted so that several event queues can share one
> vector. The pool hands out the least loaded matching IRQ once it passes
> the pool minimum threshold, and binds newly created IRQs to the least
> loaded CPU of the requested affinity mask. Interrupt delivery fans out
> through an atomic notifier chain attached to each IRQ, which the async
> event queue setup posted later in this series hooks into.
> 
> Signed-off-by: Junyang Han <han.junyang@zte.com.cn>

...

> @@ -516,10 +604,24 @@ static int zxdh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_modern_cfg;
>  	}
> 
> +	ret = zxdh_pf_irq_table_init(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_irq_table_init failed: %d\n", ret);
> +		goto err_modern_cfg;
> +	}
> +
> +	ret = zxdh_pf_irq_table_create(zxdh_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "zxdh_pf_irq_table_create failed: %d\n", ret);
> +		goto err_irq_table;
> +	}

I am wondering if you considered calling zxdh_pf_irq_table_create()
from zxdh_pf_irq_table_init(). And likewise for
zxdh_pf_eq_table_init()/zxdh_pf_eq_table_create() in patch 3/3.

I mainly ask because it seems like it would simplify zxdh_pf_probe()
slightly. But I don't feel strongly about this.

> +
>  	devlink_register(devlink);
> 
>  	return 0;
> 
> +err_irq_table:
> +	kvfree(zxdh_dev->irq_table.priv);

As a counter to my previous comment: I see the line is changed to call
zxdh_pf_irq_table_destroy() in patch 3/3. But I'm wondering if it should be
(or would be nicer if it was) zxdh_pf_irq_table_destroy() in this patch.

>  err_modern_cfg:
>  	zxdh_pf_modern_cfg_uninit(zxdh_dev);
>  err_cfg_init:

...

> diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_irq.c b/drivers/net/ethernet/zte/dinghai/zxdh_irq.c

...

> +static struct zxdh_irq *zxdh_irq_alloc(struct zxdh_irq_pool *pool, int vecidx,
> +				       const struct cpumask *affinity)
> +{
> +	struct zxdh_core_dev *zxdh_dev = pool->dev;
> +	struct zxdh_irq *irq;
> +	int err;
> +	int cpu;
> +
> +	irq = kzalloc_obj(*irq, GFP_KERNEL);
> +	if (!irq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	irq->pool = pool;
> +	irq->irqn = pci_irq_vector(zxdh_dev->pdev, vecidx);
> +	if (irq->irqn < 0) {
> +		err = irq->irqn;
> +		goto err_irqn;
> +	}
> +
> +	ATOMIC_INIT_NOTIFIER_HEAD(&irq->nh);
> +	snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
> +		 vecidx, pci_name(zxdh_dev->pdev));

W=1 builds complain about this. E.g. GCC 16.2.0 on x86_64 says:

  CC [M]  drivers/net/ethernet/zte/dinghai/zxdh_irq.o
drivers/net/ethernet/zte/dinghai/zxdh_irq.c: In function 'zxdh_irq_alloc':
drivers/net/ethernet/zte/dinghai/zxdh_irq.c:94:52: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 99 [-Wformat-truncation=]
   94 |         snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
      |                                                    ^~
drivers/net/ethernet/zte/dinghai/zxdh_irq.c:94:9: note: 'snprintf' output 8 or more bytes (assuming 107) into a destination of size 100
   94 |         snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "%s_%d@pci:%s", pool->name,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   95 |                  vecidx, pci_name(zxdh_dev->pdev));
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

...
