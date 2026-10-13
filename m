Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6151E45F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911474; cv=none; b=uhcDRWZ/lB2PKw2PfPCQhj7+sETwXOBIRmjqNkDKkmXrKG1LzONm+yI0cutZJYixPKeM4kxb68XnH5OnhD9AoW5dvwPYVdW7hIsqCXRC8DdG8L7BWfOppqwBYR3eJ2fPGRbC7uPqLSScO9X7ZJ+H4U7YL+YKC9EL6lOBTsAb6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911474; c=relaxed/simple;
	bh=/FHId1ZK2TDkd6lGQZNO6Ug3h61kMO0oPTzbGncnFT8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCkh3t2kjcMxYM0OuRyCTfWSMg8oCdi2hqeZK4pijvzFkZeKwloHUb5oNHwFdQATHlGFMUFxbHJq2ccTCeeWYACdAgGu6sjCgzCpcGwMUZzes0fLJng59qMW4xj6E7GirziZVGNKlTFf/EU4lSBPXG+vztYEVeF5GqRqPvVCra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwzoscEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwzoscEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958031F00893;
	Tue, 13 Oct 2026 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911472;
	bh=L10U5xMW9r9wYkAhP92y+TmWwOU6Sk88cfaGoHxP/ug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HwzoscExAQHWIPAhHjB8q7uTeohWyG3sZJSKNHVw/LnyouiMHCl1aFGS3bgW7jXPx
	 dGL8TocwOkSPa2SKthYGNprcAnhsmKcxo+m8YyQK/fo3sNk9PwAXEMF0EilPRUHj8L
	 8iPPJD4FP94vxqEcxxfzA6TRqY/7PMIVPb/xuPj6v0gVZJt3K0kVkX8lqgcYLGB8Ol
	 11dKS5GN+GptsX7BJ0cXnfQgJTqSv3hfilEQflNLDGuPtv4czLlKA9tM8StoYIMHlh
	 c3rmuGNv/xRxAxpDX69QSm6bC87FMbTOfekpz6yNCI0OggRVc2nDYIkWe6fjtkrnme
	 /9UZZmQr74JgQ==
Subject:
 Re: [PATCH net] net: devmem: allow peer-to-peer dma-buf attach for bindings
From: netdev-bot+sashiko@kernel.org
To: erfansh@meta.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com,
 sdf@fomichev.me, bobbyeshleman@meta.com
Date: Tue, 13 Oct 2026 17:11:11 +0000
Message-ID: <179191147111.434549.14845230247470339266@kernel.org>
In-Reply-To: <20261012170754.669462-1-erfansh@meta.com>
References: <20261012170754.669462-1-erfansh@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit carries 'Fixes: 170aafe35cb9 ("netdev: support
  binding dma-buf to netdevice")', but it is an enhancement, not a bug…
- [Medium] The commit message says exporters that cannot do P2P 'fall
  back as before'.
- [Medium] net_devmem_bind_dmabuf() now waits with
  `dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL, false,…
- [Medium] net_devmem_bind_dmabuf() now calls dma_buf_pin() for every
  netlink bind-rx/bind-tx request on a userspace-supplied dmabuf fd, and…
- [Medium] The patch makes devmem a peer-to-peer importer, so a binding's
  sg_table can now hold PCI BAR bus addresses (exporter VRAM aperture or…

Pre-existing issues:
- [Low] io_uring zcrx's io_import_dmabuf() still uses a static
  `dma_buf_attach(mem->dmabuf, ifq->dev)` plus…

--

net: devmem: allow peer-to-peer dma-buf attach for bindings

This commit switches net_devmem_bind_dmabuf() from a static
dma_buf_attach() to dma_buf_dynamic_attach() with allow_peer2peer set.
The goal is to let exporters such as amdgpu keep the buffer in device
memory. Because the core does neither for dynamic attachments, the buffer
is now pinned explicitly with dma_buf_pin() and the exporter's kernel
fences are waited on after mapping.

> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")

[Severity: Medium]
Is this a fix for 170aafe35cb9? The old static dma_buf_attach() path looks
correct under the dma-buf contract. amdgpu_dma_buf_pin() drops VRAM when
any attachment has peer2peer == false:

drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:amdgpu_dma_buf_pin() {
    ...
	list_for_each_entry(attach, &dmabuf->attachments, node)
		if (!attach->peer2peer)
			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
    ...
}

So the BO was pinned in GTT and payloads were delivered correctly, just
into host memory. This patch seems to add a new capability (P2P DMA into
exporter VRAM) rather than fix a bug.

The Fixes: tag also makes this a stable candidate. However, the patch
depends on recent dma-buf core changes. Commit 575157b1b5fc ("dma-buf:
Make .invalidate_mapping() truly optional") removed this check from
dma_buf_dynamic_attach():

	if (WARN_ON(importer_ops && !importer_ops->invalidate_mappings))
		return ERR_PTR(-EINVAL);

In older trees the callback is named move_notify. The patch also relies on
commit 609fc8766d68, which made dma_buf_pin_on_map() skip all dynamic
attachments.

net_devmem_dmabuf_attach_ops only sets .allow_peer2peer. On v6.12+ stable
trees, wouldn't a backport hit that WARN_ON? Every bind-rx and bind-tx
would then fail with -EINVAL at goto err_exit_ref. Even where the patch
applies cleanly, it adds new VRAM pinning and P2P DMA behaviour.

Should the Fixes: tag be dropped?

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7fd..3721a47426fac 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -49,6 +50,10 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
>  	       ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shift);
>  }
>  
> +static const struct dma_buf_attach_ops net_devmem_dmabuf_attach_ops = {
> +	.allow_peer2peer = true,
> +};

[Severity: Medium]
With allow_peer2peer set, the binding's sg_table can now hold PCI BAR bus
addresses. There is no .invalidate_mappings callback here, and
dma_buf_invalidate_mappings() skips such attachments:

drivers/dma-buf/dma-buf.c:dma_buf_invalidate_mappings() {
    ...
	list_for_each_entry(attach, &dmabuf->attachments, node)
		if (attach->importer_ops &&
		    attach->importer_ops->invalidate_mappings)
			attach->importer_ops->invalidate_mappings(attach);
    ...
}

What happens if the exporter loses or reassigns the BAR window while a
binding is live, for example on GPU reset or hot-unplug? Bound RX queues
would keep posting DMA writes to a range the exporter may no longer
decode, and TX would keep issuing reads from it. This could show up as
AER errors on the NIC. After a reassignment, NIC writes could land in
another device's MMIO.

The binding is released only after all page_pool and in-flight skb
references drop, and the exporter has no control over that. Before this
patch, the binding was always backed by GTT system pages, which stay
valid.

I could not fully confirm how amdgpu handles reset and hot-unplug here.
The RDMA code that the commit message refers to does have a separate
revocable variant for this case:

drivers/infiniband/core/umem_dmabuf.c:
static const struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_revocable_ops = {
	.allow_peer2peer = true,
	.invalidate_mappings = ib_umem_dmabuf_revoke_locked,
};

Exporters like VFIO can use dma_buf_attach_revocable() to reject
non-revocable importers, but amdgpu does not make that check.

Does devmem need a way to revoke a P2P binding?

[ ... ]

> @@ -234,19 +242,35 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  	binding->dmabuf = dmabuf;
>  	binding->direction = direction;
>  
> -	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
> +	binding->attachment =
> +		dma_buf_dynamic_attach(binding->dmabuf, dma_dev,
> +				       &net_devmem_dmabuf_attach_ops, binding);

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch.
io_uring zcrx's io_import_dmabuf() still uses the static attach path:

io_uring/zcrx.c:io_import_dmabuf() {
    ...
	mem->attach = dma_buf_attach(mem->dmabuf, ifq->dev);
    ...
	mem->sgt = dma_buf_map_attachment_unlocked(mem->attach, DMA_FROM_DEVICE);
    ...
}

So with amdgpu exporters, zcrx dma-buf areas still fall back to GTT. Is
that difference from devmem intended?

>  	if (IS_ERR(binding->attachment)) {
>  		err = PTR_ERR(binding->attachment);
>  		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
>  		goto err_exit_ref;
>  	}
>  
> -	binding->sgt = dma_buf_map_attachment_unlocked(binding->attachment,
> -						       direction);
> +	dma_resv_lock(dmabuf->resv, NULL);
> +	err = dma_buf_pin(binding->attachment);
> +	if (err) {
> +		NL_SET_ERR_MSG(extack, "Failed to pin dmabuf");
> +		goto err_unlock;
> +	}

[Severity: Medium]
The commit message says:

  Exporters that cannot do P2P to the device fall back as before.

Does this still hold when the same dma-buf has more than one attachment?
With amdgpu, the first devmem binding over a P2P-capable path now pins the
BO in VRAM, because every attachment has peer2peer == true at that point.

A later attachment with peer2peer == false then asks for GTT only. One
case is a second devmem bind to a NIC with no P2P path, where
amdgpu_dma_buf_attach() clears peer2peer:

	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
		attach->peer2peer = false;

Static importers such as io_uring zcrx or v4l2 are another case.

amdgpu_bo_pin() then rejects the request, because the BO is already pinned
in VRAM:

drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:amdgpu_bo_pin() {
    ...
	if (bo->tbo.pin_count) {
		uint32_t mem_type = bo->tbo.resource->mem_type;
		...
		if (!(domain & amdgpu_mem_type_to_domain(mem_type)))
			return -EINVAL;
    ...
}

The second devmem bind fails with "Failed to pin dmabuf", and static
importers fail in dma_buf_map_attachment(). Before this patch all devmem
pins went to GTT, so these combinations worked.

Is this regression expected?

[Severity: Medium]
The dma_buf_pin() kernel-doc says:

 * Only dynamic importers (who set up @attach with dma_buf_dynamic_attach()) may
 * call this, and only for limited use cases like scanout and not for temporary
 * pin operations. It is not permitted to allow userspace to pin arbitrary
 * amounts of buffers through this interface.

Here, every netlink bind-rx or bind-tx request pins a userspace-supplied
dma-buf for the lifetime of the binding. Devmem has no per-user or global
limit on bindings. NETDEV_CMD_BIND_TX is registered with only
GENL_CMD_CAP_DO, so no privilege is needed to reach it.

With allow_peer2peer, amdgpu_dma_buf_pin() keeps VRAM and also sets:

	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

So the pin lands in CPU-visible VRAM, which is small on systems without
resizable BAR.

Could an unprivileged user pin arbitrary amounts of non-evictable visible
VRAM this way and starve other GPU clients or display scanout? The pinned
RDMA path breaks the same rule, but this adds another unbounded caller.

> +
> +	binding->sgt = dma_buf_map_attachment(binding->attachment, direction);
>  	if (IS_ERR(binding->sgt)) {
>  		err = PTR_ERR(binding->sgt);
>  		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
> -		goto err_detach;
> +		goto err_unpin;
> +	}
> +	dma_resv_unlock(dmabuf->resv);
> +
> +	err = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL, false,
> +				    MAX_SCHEDULE_TIMEOUT);

[Severity: Medium]
The commit message presents this as the same wait the core does for static
attachments. The core version is interruptible, though:

drivers/dma-buf/dma-buf.c:dma_buf_map_attachment() {
    ...
	if (!dma_buf_attachment_is_dynamic(attach)) {
		ret = dma_resv_wait_timeout(attach->dmabuf->resv,
					    DMA_RESV_USAGE_KERNEL, true,
					    MAX_SCHEDULE_TIMEOUT);
    ...
}

Here intr is false and the timeout is MAX_SCHEDULE_TIMEOUT. A bind stuck
on a slow or stalled exporter kernel fence, such as a TTM move or clear on
a hung GPU, can't be aborted with SIGKILL.

The wait also runs while the bind paths hold their locks.
netdev_nl_bind_rx_doit() holds priv->lock and the netdev instance lock,
and netdev_nl_bind_tx_doit() also holds netdev_lock(bind_dev):

netdev_nl_bind_tx_doit()
    mutex_lock(&priv->lock)
    netdev_get_by_index_lock()
    netdev_lock(bind_dev)
    net_devmem_bind_dmabuf()
        dma_resv_wait_timeout(..., false, MAX_SCHEDULE_TIMEOUT)

BIND_TX is unprivileged. Should this pass intr=true to match the old
behaviour? As written, a signal can never reach the err < 0 branch below.

> +	if (err < 0) {
> +		NL_SET_ERR_MSG(extack, "Failed to wait for dmabuf fences");
> +		goto err_unmap;
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012170754.669462-1-erfansh%40meta.com
