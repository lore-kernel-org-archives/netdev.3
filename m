Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38B3B14A3;
	Mon, 14 Sep 2026 07:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370459; cv=none; b=CnDQVOVPtTIgstTNPcdFLLrnB8iUuv1fXpnxFQq7br0mxgc6U/8AOPu7nz+c88hEbUrNtjXyi0Esh95SgUlHcYef/PZquLSTC4EfT4A7Pcd4PcXngcXg6sgQ9WGxGQMFDcRGvJQXxDanxVGjVHovOFtoxNroBbXP9rzZibipx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370459; c=relaxed/simple;
	bh=s/ioGDqzizB20jNzdrlPzzPsVy3iG0nOPkZcrhatn7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/hUadC46sdJBe53GbSkQgmAT0MziObPPxvgveG8conMiVgPFYiFXJVLVPPO5AXCG19PvWd6vgi3fKNX6pW6p58Dfxp+/Wc0w2jtFd9Ejh+ozPHnhVS7SBliTdebI87YUhNbX3dhjQLb3HSwkfz/2OFXMuRE6XLTq+nbOdze0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpK5gBu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpK5gBu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447371F00899;
	Mon, 14 Sep 2026 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370451;
	bh=isWeIxls51ik/Z+POh1QwRRDOLE3t+BZ03Z8qRbFXeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpK5gBu+ASpbEIdEN2wOlBci4eD2VtbLlzSAy7+WkpJ2DxUicWfzCrkOHsvQG/0gw
	 qF3ndt4j/xcoBIz6rdsJAxsiaxOPPPIzhNfgeh7nQ2NFaF4tCJSdh5lBGS6CDf/YQ5
	 MEcKQaDHctNH0yRyHP//8SZuSK5QqUxILQ3ISjAFGjPAx+8hLZgsy2jUjBMgPPH+Nj
	 3tbvt05fKllrIk656/iezp2CAJiqXN96+5CAFesXu5gjUkap1CoEUzSGtj0olBN0sX
	 ERO/yxDgx3HpSVcj2JzKcgFxzKN4yDUrxWDhvyYM/zoXV5aMsVjKg5kwtQOUggLtMg
	 Fo496JcV6Pj8g==
From: Simon Horman <horms@kernel.org>
To: han.junyang@zte.com.cn
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ran.ming@zte.com.cn,
	han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v2 2/3] dinghai: add MSI-X interrupt pools
Date: Mon, 14 Sep 2026 08:20:45 +0100
Message-ID: <20260914072045.232985-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911120217310cUI5W_KC5mMJa9d1oIEnh@zte.com.cn>
References: <20260911120217310cUI5W_KC5mMJa9d1oIEnh@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260911115929435mXJzcTF08xlUAdjnT8qqm@zte.com.cn?part=2
---
dinghai: add MSI-X interrupt pools

This commit introduces a driver for ZTE DingHai Ethernet, specifically
allocating the fixed MSI-X vector layout of the device. It manages the
vectors in per-purpose pools for async event queues and vq queue pairs.

[Severity: Medium]
The commit message states:

  manage the vectors in per-purpose pools: one pool for the async event queues
  and one for the vq queue pairs, with a range reserved for RDMA in between.

Was the VQ pool allocation omitted from this patch by mistake? Looking at
zxdh_pf_irq_pools_init(), only the async pool is allocated.

> diff --git a/drivers/net/ethernet/zte/dinghai/zxdh_irq.c b/drivers/net/ethernet/zte/dinghai/zxdh_irq.c
> new file mode 100644
> index 0000000000000..437344329c7e8
> --- /dev/null
> +++ b/drivers/net/ethernet/zte/dinghai/zxdh_irq.c
[ ... ]
> +static void zxdh_irq_release(struct kref *kref)
> +{
> +	struct zxdh_irq *irq = container_of(kref, struct zxdh_irq, refcount);
> +	struct zxdh_irq_pool *pool = irq->pool;
> +
> +	lockdep_assert_held(&pool->lock);
> +	xa_erase(&pool->irqs, irq->index);
> +	/* free_irq() requires the affinity hint to be cleared before it is
> +	 * called; the asymmetry with the set path in zxdh_irq_alloc() is
> +	 * intentional.
> +	 */
> +	irq_update_affinity_hint(irq->irqn, NULL);
> +	free_cpumask_var(irq->mask);
> +	free_irq(irq->irqn, irq);
> +	kfree(irq);
> +}

[Severity: High]
Does this code leak the logical counters in pool->irqs_per_cpu?

When an IRQ is allocated, zxdh_irq_pool_request_irq() increments
pool->irqs_per_cpu[cpu]. It seems zxdh_irq_release() misses a call to
zxdh_cpu_put(), which will permanently skew load balancing and trigger the
WARN_ON(pool->irqs_per_cpu[cpu]) during zxdh_irq_pool_free().

[ ... ]
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
> +	snprintf(irq->name, ZXDH_MAX_IRQ_NAME, "async_%d@pci:%s", vecidx,
> +		 pci_name(zxdh_dev->pdev));

[Severity: Low]
Is this hardcoded name prefix intentional?

This ignores the configured pool->name. If this generic library is reused for
other pools, such as the VQ pool, they will all show up as "async_" in
/proc/interrupts.

> +
> +	err = request_irq(irq->irqn, zxdh_irq_int_handler, 0, irq->name, irq);
> +	if (err) {
> +		dev_err(zxdh_dev->device, "request_irq failed: %d\n", err);
> +		goto err_irqn;
> +	}
> +
> +	if (!zalloc_cpumask_var(&irq->mask, GFP_KERNEL)) {
> +		dev_err(zxdh_dev->device, "zalloc_cpumask_var failed\n");
> +		err = -ENOMEM;
> +		goto err_cpumask;
> +	}
> +
> +	if (affinity) {
> +		cpumask_copy(irq->mask, affinity);
> +	} else {
> +		/* No preference requested; spread over all online CPUs. */
> +		for_each_online_cpu(cpu)
> +			cpumask_set_cpu(cpu, irq->mask);
> +	}
> +	irq_update_affinity_hint(irq->irqn, irq->mask);

[Severity: Medium]
Will this actually configure the SMP hardware routing for the IRQ?

The driver uses irq_update_affinity_hint() which only sets a userspace hint
via procfs. Should this be irq_set_affinity_and_hint() instead to actually
enforce the intended hardware IRQ load balancing?

[ ... ]
> +static struct zxdh_irq *zxdh_irq_pool_request_irq(struct zxdh_irq_pool *pool,
> +						  const struct cpumask *req_mask)
> +{
> +	const struct cpumask *affinity = req_mask;
> +	cpumask_var_t auto_mask;
> +	struct zxdh_irq *irq;
> +	u32 irq_index;
> +	int err;
> +
> +	if (!zalloc_cpumask_var(&auto_mask, GFP_KERNEL))
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = xa_alloc(&pool->irqs, &irq_index, NULL, pool->xa_num_irqs,
> +		       GFP_KERNEL);

[Severity: High]
Will this xa_alloc() call fail unconditionally?

The XArray API strictly forbids NULL entries for allocation because NULL
represents an unallocated slot. Passing NULL as the entry triggers a
WARN_ON_ONCE(!entry) and returns -EINVAL.

[ ... ]
> +void zxdh_irq_pool_free(struct zxdh_irq_pool *pool)
> +{
> +	struct zxdh_irq *irq;
> +	unsigned long index;
> +	u32 cpu;
> +
> +	/* On a fast teardown the table may still hold IRQs; release
> +	 * whatever is left.
> +	 */
> +	mutex_lock(&pool->lock);
> +	xa_for_each(&pool->irqs, index, irq)
> +		zxdh_irq_release(&irq->refcount);
> +	mutex_unlock(&pool->lock);

[Severity: High]
Can this manual iteration bypass the reference counting and cause a
use-after-free?

If zxdh_irq_pool_free() executes while active consumers still hold an IRQ
reference during a fast teardown, it will forcefully execute
zxdh_irq_release() on the irq object. When the consumer eventually calls
zxdh_irq_put() and accesses the freed irq and its freed pool->lock, will
this trigger a use-after-free?

[ ... ]
