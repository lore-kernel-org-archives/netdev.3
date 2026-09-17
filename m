Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD72E7398;
	Thu, 17 Sep 2026 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608756; cv=none; b=JAuYwa2BBefuvPD3k1FLG3FS5F92A8WFJonLSqvB7oTwCzxu0E7m3xpF4gt7IqKQJCdMtQH9eZFOH75guMwelGvo8eaT3bdqfT4liGZTCzCi5IwcdwzViCuwEvJO0zAN1urDJxeCccyLpmFEHRqq5ak5rrI/X+9hiTk+T7/tlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608756; c=relaxed/simple;
	bh=8n6201mEnBig5sh7efNy+2GWhDjCttDYqOzxDZEx0Vk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qrvL+TUPS6lSQQEvBHUTic/OgGifpIBKFz9rqpPHFrV5FVHIXQVLEOR9iJkt0HFFRAoPxfmL82TK2eaU7u0oJ6bfwi0xCjwAFgb2rFmXkRI+WLXgcKRyVnhc8SHef3HjAWrPVwoVSQqyUXdjMG++tQkzoWd/3iUowS/JPr63uss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr5vUUrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr5vUUrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846791F00893;
	Thu, 17 Sep 2026 01:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608751;
	bh=k4C2H6oc0PVSDtr2BbANTgnb9mCYuHjoqz6OOHEdOZ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kr5vUUrPXvNBWlkJpft3+gcFmONeNjnmJLsdw6akaI3arSePlXZA2GQdDhsnxtxAF
	 yGwXzSSgEpzjcoG0d8vRx844dT1LTD2MgfHo0RcLT/0Lvw0AkGVNEzMQDM+veCw09R
	 94N31MQxmWjY0NkiPDvmhlS6O055C6ydxIodKrwqdN8FbkdAXBbJGGJXykKMPmD15A
	 FISvetbXFfTN6mTIz/7tJ5Cc944kwuKViRiQ2RI8XzsvatRfqTv6U0kwwfIHgRLBD8
	 el/3WnXe6iIvepPihkTGa5s1+XxK6FKP2UePkY0WlH/pB8nJP0wdiuUkJiHAK+b3uL
	 252qNH5SLBsvQ==
Subject: Re: [PATCH net-next v12 2/5] net: rnpgbe: Add basic TX packet
 transmission support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 17 Sep 2026 01:32:30 +0000
Message-ID: <178960875012.22033.6141876343276467028@kernel.org>
In-Reply-To: <CE1CAC70A116A231+20260914013213.2262606-1-dong100@mucse.com>
References: <CE1CAC70A116A231+20260914013213.2262606-1-dong100@mucse.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 2

- [Medium] rnpgbe_probe() replaces the previously error-checked
  `dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56))` (which logged…
- [Low] rnpgbe_setup_tx_resources()
  (drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c) declares and kernel-…
- [Low] rnpgbe_free_q_vector() clears the ring pointers with plain stores
  (`mucse->tx_ring[ring->queue_index] = NULL;` at…

--

net: rnpgbe: Add basic TX packet transmission support

This adds the TX path for rnpgbe: the TX descriptor format and buffer
management, rnpgbe_xmit_frame_ring(), TX ring setup/teardown, and TX
completion handling in rnpgbe_clean_tx_irq(). It also adds per-ring TX
statistics reported through ndo_get_stats64().

A few questions below about the DMA mask handling and the new lockless
statistics reader.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index d4a27b2ad5c12..fed07d53e5fe1 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -279,7 +403,7 @@ static void rnpgbe_free_q_vector(struct mucse *mucse, int vector_idx)
>  		mucse->rx_ring[ring->queue_index] = NULL;
>  	mucse->q_vector[vector_idx] = NULL;
>  	netif_napi_del(&q_vector->napi);
> -	kfree(q_vector);
> +	kfree_rcu(q_vector, rcu);
>  }

[Severity: Low]
Should the ring pointer clearing in rnpgbe_free_q_vector() use
WRITE_ONCE() now that there is a lockless reader on the other side?

The removal side uses plain stores:

	mucse_for_each_ring(ring, q_vector->tx)
		mucse->tx_ring[ring->queue_index] = NULL;

while the new rnpgbe_get_stats64() reads the same slot with:

	struct mucse_ring *ring = READ_ONCE(mucse->tx_ring[i]);

The two can overlap: rnpgbe_dev_shutdown() reaches
rnpgbe_clear_interrupt_scheme() -> rnpgbe_free_q_vectors() ->
rnpgbe_free_q_vector() while the netdev is still registered, and
ndo_get_stats64 is reachable without rtnl from readers of /proc/net/dev.

Object lifetime looks fine here because the q_vector is now released via
kfree_rcu() and the reader holds rcu_read_lock(), so this appears to be a
plain data race that KCSAN would report rather than a use-after-free.
ixgbe annotates both sides, e.g. in ixgbe_free_q_vector():

	WRITE_ONCE(adapter->tx_ring[ring->queue_index], NULL);

Would it make sense to match that here for both the publish side in
rnpgbe_alloc_q_vector() and the clearing side?

[ ... ]

> @@ -574,8 +859,416 @@ bool rnpgbe_down(struct mucse *mucse)

[ ... ]

> +/**
> + * rnpgbe_setup_tx_resources - allocate Tx resources (Descriptors)
> + * @tx_ring: tx descriptor ring (for a specific queue) to setup
> + * @mucse: pointer to private structure
> + *
> + * Return: 0 on success, negative on failure
> + **/
> +static int rnpgbe_setup_tx_resources(struct mucse_ring *tx_ring,
> +				     struct mucse *mucse)
> +{
> +	struct device *dev = tx_ring->dev;
> +	int size;
> +
> +	size = sizeof(struct mucse_tx_buffer) * tx_ring->count;

[Severity: Low]
Is the mucse argument to rnpgbe_setup_tx_resources() used anywhere in the
function?  Everything it needs comes from the ring: tx_ring->dev,
tx_ring->count, and sizeof(struct rnpgbe_tx_desc).  The kernel-doc
documents "@mucse: pointer to private structure" for a parameter the body
never references, and the only caller,
rnpgbe_setup_all_tx_resources(), passes it for every queue:

	err = rnpgbe_setup_tx_resources(mucse->tx_ring[i], mucse);

Could the parameter and its kernel-doc entry be dropped?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 22280d4ca8a08..21136abe12317 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -209,6 +250,13 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>  		goto err_clear_interrupt;
>  	}
>  
> +	netdev->features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_SG;
> +	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32)) {
> +		netdev->features |= NETIF_F_HIGHDMA;
> +		netdev->hw_features |= NETIF_F_HIGHDMA;
> +	}
> +
>  	err = register_netdev(netdev);
>  	if (err)
>  		goto err_remove_mbx;
> @@ -251,12 +299,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		return err;
>  
> -	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"No usable DMA configuration, aborting %d\n", err);
> -		goto err_disable_dev;
> -	}
> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(56));

[Severity: Medium]
The commit message says:

    Require a 56-bit streaming and coherent DMA mask.

But the return value of dma_set_mask_and_coherent() is discarded here,
and the baseline error path that logged "No usable DMA configuration,
aborting" and did goto err_disable_dev is removed.  Is that intentional?

Every other failure in rnpgbe_probe() is checked and routed through the
goto ladder; this is now the only call whose result is ignored.  If the
negotiation fails on a bus_dma_limit constrained platform, probe
continues and the TX rings are later allocated and mapped under whatever
mask remained installed:

rnpgbe_open()
  rnpgbe_setup_all_tx_resources()
    rnpgbe_setup_tx_resources()
      dma_alloc_coherent()

There is also the asymmetric case: dma_set_mask_and_coherent() applies
the coherent mask only after the streaming mask succeeds, so the pair can
end up mismatched.  The single downstream consumer only inspects the
streaming mask:

	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32)) {
		netdev->features |= NETIF_F_HIGHDMA;

so a partially failed negotiation is not detected there either.

The descriptor layout also encodes the 56-bit assumption, in
rnpgbe_tx_map():

	fun_id = (u64)tx_ring->pfvfnum << 56;
	...
	tx_desc->pkt_addr = cpu_to_le64(dma | fun_id);

and in rnpgbe_configure_tx_ring() with pfvfnum << 24 written into
TX_BASE_ADDR_HI.  Would it be better to keep the error check so the
requirement stated in the commit message is actually enforced?  This call
is still unchecked at the end of the series, so no later patch adds the
check back.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/64BE41C2D2C0836A%2B20260914013019.2262317-1-dong100%40mucse.com
