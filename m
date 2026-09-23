Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFE314A98;
	Wed, 23 Sep 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207192; cv=none; b=Z+DH4bS/14SMsf7qNJ8w6TMg6mXYuPHKaJD4+pvwovCcEn7Z66jGRoH9qaAof0+yGFYr/ikh+0BzSR3tUnuO/xTpFU8Pujkf+pXGBWQXoNeD/WQ3PKUyVCjAGv8v1Kg7exMRWMAekTkcRk7RbWo1sd40k+XgqWW2E5sZQjTZKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207192; c=relaxed/simple;
	bh=uPB/zP/1RcV6XkcYHd1sJQE+D7ArbKl4UymCg8uj9VQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UppFykW61kml3cCbIAMvqwMJp9Tq/e9zsIfXpW/LEc32nWFQV9OcB/sCZ01DP0hndfvO/dumicpWpDsqiG4Dzu7K4yY9M5C3IJRMUuIhrFXOCY3f16gDxKZZ1dx8bhEsy34ox5ZddNwh3gzLmzztwfyXyE34AsoNusCdmu5uRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtd9g942; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtd9g942"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63961F00893;
	Wed, 23 Sep 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790207190;
	bh=vvkmf6PhsFKIr1Rj/+iu1gTg+NqaiZEuldOsD/SuEb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wtd9g942cTQ7ObEK6aYwYpHgeDqL+U0jSnDIhN/0qGjiJ/EgUEfXGkivqHNGoeEgW
	 K4VU7C5rZUa4XuMISO0MAdYeyBS3Y8SYGOIensXKNrUhPhFz/joBkAmmey1aE+MkMU
	 oXpCc0iy4+7GGyUkZW3F1pUmtptvEbDSC2ojz8xISuuAnCwKoCl60EnPDnIQz1xFMh
	 NVQcxGjjmytxYN0Nm+CNBR1eLNZblEzKzb9sziNmqrjalyP7XbnTXeW+hDZb4KsgUk
	 otthNgASv1qlgh82kRE6OuXxX+EUmk0+8asKmKONE3sMUzRGMDVK7VB/xoaTWFEx9J
	 SGGGqpSP/GvDA==
Subject: Re: [PATCH net-next 2/3] net: devmem: use memory provider helpers for
 net_iovs
From: netdev-bot+sashiko@kernel.org
To: sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, asml.silence@gmail.com, axboe@kernel.dk,
 sdf@fomichev.me, bobbyeshleman@meta.com, almasrymina@google.com,
 kaiyuanz@google.com, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Date: Wed, 23 Sep 2026 23:46:29 +0000
Message-ID: <179020718952.2160803.820732555059297637@kernel.org>
In-Reply-To: <20260922204348.717198-3-sdf@fomichev.me>
References: <20260922204348.717198-3-sdf@fomichev.me>
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

- [Low] net: devmem: use memory provider helpers for net_iovs bundles a
  real bug fix into a patch whose commit message presents it as a…

--

net: devmem: use memory provider helpers for net_iovs

This converts net/core/devmem.c to the public memory-provider helpers
net_mp_niov_set_dma_addr(), net_mp_niov_set_page_pool() and
net_mp_niov_clear_page_pool() instead of open-coding page_pool state,
switches the net_iov array to kvzalloc_objs(), and now rejects DMA
addresses that cannot be represented in net_iov metadata.

>  	Zero the net_iov array because net_mp_niov_set_page_pool() ORs
>  	PP_SIGNATURE into pp_magic. Reject DMA addresses that cannot be
>  	represented in net_iov metadata.

[Severity: Low]
This isn't a bug in the new code, but should the "Reject DMA addresses
that cannot be represented in net_iov metadata" sentence spell out that
the old behaviour was a silent truncation, and should the patch carry a
Fixes: tag?

Before this patch net_devmem_bind_dmabuf() dropped the return value of
page_pool_set_dma_addr_netmem(), which is the "this address does not
round-trip through the compressed net_iov metadata" indicator:

net/core/page_pool_priv.h:page_pool_set_dma_addr_netmem() {
	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
		netmem_set_dma_addr(netmem, addr >> PAGE_SHIFT);

		/* We assume page alignment to shave off bottom bits,
		 * if this "compression" doesn't work we need to drop.
		 */
		return addr != (dma_addr_t)netmem_get_dma_addr(netmem)
				       << PAGE_SHIFT;
	}
	...
}

Every other caller treats a true return as fatal, e.g.
page_pool_dma_map():

	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
		goto unmap_failed;
	}

and io_uring/zcrx.c returns -EFAULT. Devmem was the only site that kept
the truncated address and handed it to the NIC for DMA.

The path looks reachable from user space on 32-bit arches with 64-bit
dma_addr_t: netdev_nl_bind_rx_doit() only checks is_power_of_2() on
NETDEV_A_DMABUF_RX_PAGE_SIZE before niov_shift = ilog2(rx_page_size), so
a sub-PAGE_SIZE niov size is accepted, and the bind loop then advances
dma_addr += niov_size producing non-page-aligned addresses whose
compression fails.

Given that the next patch in the series ("net: devmem: decode DMA
addresses for TX") does carry a Fixes: tag for the other half of the same
32-bit/64-bit-DMA problem, would it make sense to split this hunk out
with its own Fixes: tag so it can be picked up for stable?

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index c1c1872b88de2..0fc77c1a29569 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -274,8 +272,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  		for (i = 0; i < nr_niovs; i++, niov_idx++) {
>  			niov = &binding->area.niovs[niov_idx];
>  			net_iov_init(niov, &binding->area, NET_IOV_DMABUF);
> -			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
> -						      dma_addr);
> +			if (net_mp_niov_set_dma_addr(niov, dma_addr)) {
> +				err = -EFAULT;
> +				NL_SET_ERR_MSG(extack,
> +					       "dmabuf DMA address cannot be represented");
> +				goto err_free_niovs;
> +			}
>  			if (direction == DMA_TO_DEVICE)
>  				binding->tx_vec[niov_idx] = niov;
>  			else

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922204348.717198-1-sdf%40fomichev.me
