Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951188;
	b=i4hftWQQesv69IiAUd4KZjGqro3JAg9zBFtKWqvrYPT3NIiccFv0FYY27FIIj3e+OMQx
	 ikgsX966fre/shvJGRJUkElWL9QDDPid+JPLLRrnEQqaJ1YLvejEhowc/VIdVpSvoFGjy
	 QQpwliwJxzVi/h5x65hORmTRt1OL4PRqDUy0xkxS1OOLNahtuqsMn5QwWA9lN8tTzJ3/Z
	 zYfaf4ntWRUktSPACAesb0+5MPvRsRhAqwW7Bvsu4U/Geym+36ya9S9z8ISGhFOXqvhUl
	 lMBNULFIm1NXZwCknfKYbl8vVSyMRgj8ZiYWJK6Jurx5eRiLVPzgox+lcDRcoFuTjlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951188;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iQFWAC+LE0ukQFDAdwhgMAzRUq3lyn5OIEXjDc/Z2Dg=;
	b=3xr5Urran6etMfRw6dqbRRMopxkBfzXzMM/oqfsp5bWKt8cPmo3dYJSQnSIhusD6J028
	 0IqF5mEqKg5FSWKGVhhHAzWY8akPpmBxCmoAf+JMkSFqGsNYQm+6afOvaqoHg8HDZKd4p
	 EoCsyNwAWsxOGh1vFlUplKeUWcI9BhncdIMnSMr3aYh3iueWGkQdEnh5JXmQnbj8efk2x
	 30Sg2xnORLY46lJFU7NpSd30yjiqV3OcsEZ+2Nyts4Tby9ssP0x64816zGVIxhjskiupk
	 2cjjcROJY7WFosnqNCZ54JfkIjTnoaWx26uzsq3dPCKN1dR4kDDMgqz2H03HTzCfmqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJ+KIJj3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04650606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJ+KIJj3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE4D1F01825;
	Sun, 25 Oct 2026 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951187;
	bh=iQFWAC+LE0ukQFDAdwhgMAzRUq3lyn5OIEXjDc/Z2Dg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AJ+KIJj3mua/2BMOGt/lRfzkFPFgRQaXFj4qtj0WwWNkYonSnCWIlzEHyon2bPUhL
	 i0H5hISMktL79d7qBDc47LqT391v63tjj6XXGVXaClblZ6p5nIVxG4+UvYF3EXLvv1
	 PCNlX3+DbOK0u0cJmBqClAGa8vUBpGcm/AbP1mO1rWfJjdgDTOIlvpAMojdtK/5a1Q
	 C1Ojcn5mYepfOlTVh3jCWtmRiXcnVbAbzdS5ZLF3H9i8hGfEBg57az+c+6bP4fZpT2
	 auhyZPGsIbXzmjn+hPtj7PC2s4fWZ1HklsJryJX4VCJXZsD2NOlZFD4dLhjrgl1DEP
	 FYhPEtgnxHf7Q==
Subject:
 Re: [PATCH net] net: page_pool: bound queue_idx before indexing dev->_rx[]
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 kuba@kernel.org
Date: Sun, 25 Oct 2026 17:59:46 +0000
Message-ID: <179295118685.3134.9411044728619197719@kernel.org>
In-Reply-To: <20261021155611.68473-1-phx0fer@gmail.com>
References: <20261021155611.68473-1-phx0fer@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in page_pool_init() (net/core/page_pool.c) bounds
  queue_idx by netdev->real_num_rx_queues.
- [Medium] The commit message says "A queue_idx at or beyond
  real_num_rx_queues reads past the dev->_rx[] allocation".

--

net: page_pool: bound queue_idx before indexing dev->_rx[]

This patch adds a check to page_pool_init() for pools created with
PP_FLAG_ALLOW_UNREADABLE_NETMEM. The check rejects a queue_idx at or
above netdev->real_num_rx_queues, and it runs before
__netif_get_rx_queue() is used to look up the queue's memory provider.

> [ ... ]  A
> queue_idx at or beyond real_num_rx_queues reads past the dev->_rx[]
> allocation:

[Severity: Medium]

Is this description accurate? dev->_rx[] is sized by num_rx_queues, not
by real_num_rx_queues:

net/core/dev.c:netif_alloc_rx_queues() {
	unsigned int i, count = dev->num_rx_queues;
	struct netdev_rx_queue *rx;
	size_t sz = count * sizeof(*rx);
    ...
}

alloc_netdev_mqs() sets both num_rx_queues and real_num_rx_queues to
rxqs. Drivers can then lower real_num_rx_queues.

An index in [real_num_rx_queues, num_rx_queues) is still inside the
allocation. The quoted KASAN report needs an index >= num_rx_queues.

Could the commit message be corrected? It could also say that the new
check rejects indices that are inside the allocation.

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d7c88c0b67e53..87f14ae855e32 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -274,6 +274,15 @@ static int page_pool_init(struct page_pool *pool,
>  
>  	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>  		netdev_assert_locked(pool->slow.netdev);
> +
> +		/* queue_idx indexes dev->_rx[]; reject a value the device
> +		 * cannot serve before dereferencing the queue.
> +		 */
> +		if (pool->slow.queue_idx >= pool->slow.netdev->real_num_rx_queues) {
> +			err = -EINVAL;
> +			goto free_ptr_ring;
> +		}

[Severity: High]

Can this check reject valid queue indices when a driver increases its
number of rx queues?

Before this patch, an index between real_num_rx_queues and num_rx_queues
was in bounds and just found NULL mp_params. Several drivers that set
PP_FLAG_ALLOW_UNREADABLE_NETMEM create page pools for new rx queues
before they raise real_num_rx_queues.

For bnxt, here is the path when ethtool -L increases the combined count:

bnxt_set_channels()
  bnxt_close_nic()
  bp->rx_nr_rings = channel->combined_count;
  bnxt_open_nic()
    __bnxt_open_nic()
      bnxt_alloc_mem()
        bnxt_alloc_rx_rings()
          bnxt_alloc_rx_page_pool()
            page_pool_create()
              page_pool_init()  <-- queue_idx >= stale real_num_rx_queues
      ...
      bnxt_request_irq()
        bnxt_setup_int_mode()
          bnxt_set_real_num_queues()
            netif_set_real_num_rx_queues(dev, bp->rx_nr_rings)

bnxt_alloc_rx_page_pool() always sets the flag, with queue_idx =
rxr->bnapi->index. So this would affect every bnxt device, even without
devmem. bnxt_alloc_mem() would fail and the interface would stay down.

The same ordering seems to apply to:

  bnge: bnge_open_core() -> bnge_alloc_core() -> ... ->
  bnge_alloc_rx_page_pool() runs before bnge_request_irq() ->
  bnge_setup_interrupts() -> netif_set_real_num_queues()

  mlx5 with SHAMPO: mlx5e_safe_switch_params() -> mlx5e_open_channels()
  creates the pools before the preactivate hook
  mlx5e_num_channels_changed() calls netif_set_real_num_rx_queues()

  gve with header split: gve_adjust_config() -> gve_queues_mem_alloc()
  runs before gve_queues_start() calls netif_set_real_num_rx_queues()

The existing helpers netif_rxq_has_unreadable_mp() and netif_rxq_has_mp()
in net/core/netdev_rx_queue.c treat such indices as having no memory
provider, not as an error:

	if (rxq_idx < dev->real_num_rx_queues)
		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
	return false;

Would it work to bound queue_idx by num_rx_queues instead? Another option
is to skip the mp lookup above real_num_rx_queues rather than return
-EINVAL. Because of the Fixes: tag, this change would also go to stable
trees.

>  		rxq = __netif_get_rx_queue(pool->slow.netdev,
>  					   pool->slow.queue_idx);
>  		pool->mp_priv = rxq->mp_params.mp_priv;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155611.68473-1-phx0fer%40gmail.com
