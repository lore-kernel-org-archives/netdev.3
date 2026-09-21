Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAA31E82E;
	Mon, 21 Sep 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986052; cv=none; b=Tq+gB0wUlOdje4OKa1QH3sXK8hJ3jsTzGRQZs4tKl0tpva9FLIHW3YL98kF+9oZUrQkAQD27Wlebbt74yacNz2N6WlIReslStMCsp7H/mhco4LJGSDxb7Kjy0tyipnpvLA1mcyaBCAoBENvyovJ7Bkgj6JYFBvafaP/8ioZd/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986052; c=relaxed/simple;
	bh=QmOgBzA2Kq2tYkYWMPInrTyhbi7hBNQhHZS7PB9kXaE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVeHyCKhTZpRljpVnjbhJFFGF8fWUff/1DK6/hUZNDjTmNM5fQdUl0buuutNAhysKYMb4dhKl9OyYsqX/Hei0Ga23gIpb8OaweIuRph71+f5ce3IiBgj08Ct6BR6bqV6AbwFoBf3bztK2hhqjM9j1SdqmK6T2Z7dvJ0Eqkk5XC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SETYlG2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SETYlG2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02841F00893;
	Mon, 21 Sep 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986046;
	bh=seDXjnfqJ0rhIy2Fav3ax7NOc5hwcP/VOGFy9gPK4P0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SETYlG2mDOHsqpos4gaM9/jzJebQ9kgrOd0Khn8y/pAwZxLJzN8v0iRDunkDka8yN
	 Arf6UFW1T1O8nXoGEOIpbDdYdR22p4Iy++YjYX7WVSjauw/YUANK/mODh/ea6jB/Q9
	 1/wtkpzOhfHJfTjdXJEHtzfp/5ISG4MsvilZesuU+RTLJcswP8gaIaWZGlhfuiKp2N
	 O6UWDTWSog5XfHnTHLbYSuRJNpKM16pajj6xp3nX30YomLAuy9HD6cGId1THdgF5AC
	 4ZzV6wAY/eGaXZZCqEB3NBs5bJbINadgaQtRf9CI7CKza2y+E/FPHDgbKkbEorDRlX
	 jHFZ7SUFUO+/w==
Subject: Re: [PATCH net-next v13 2/5] net: rnpgbe: Add basic TX packet
 transmission support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 21 Sep 2026 10:20:45 +0000
Message-ID: <178998604523.2160803.309404195274642417@kernel.org>
In-Reply-To: <5CF5340DA3D4CE3C+20260920092622.345496-1-dong100@mucse.com>
References: <5CF5340DA3D4CE3C+20260920092622.345496-1-dong100@mucse.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rnpgbe_probe() replaces the previously error-checked
  `dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56))` (which aborted…
- [Medium] In this patch ndo_start_xmit becomes reachable before the TX
  ring software resources exist: rnpgbe_add_adapter() calls…
- [Low] In drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h,
  RESV_DESC_NEEDED is documented as "2 desc gap to keep tail from…
- [Low] Two headers touched by the patch are not self-contained.
- [Low] The patch builds an RCU protocol for the
  mucse->tx_ring[]/rx_ring[] slots (adds `struct rcu_head rcu` to struct…

--

net: rnpgbe: Add basic TX packet transmission support

This adds the TX path for rnpgbe: the TX descriptor layout and buffer
management, rnpgbe_xmit_frame_ring(), TX ring setup/teardown, TX completion
handling in rnpgbe_clean_tx_irq(), and per-ring TX stats reported through
ndo_get_stats64(). It also switches the DMA mask setup to
dma_set_mask_and_coherent() and enables NETIF_F_SG/NETIF_F_HIGHDMA.

A few questions below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> index 40e41521a279..864cbf0caf44 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h

[ ... ]

> @@ -69,31 +135,37 @@ struct mucse_q_vector {
>  	int hw_vector;
>  	struct mucse_ring_container rx, tx;
>  	struct napi_struct napi;
> +	struct rcu_head rcu;
>  	char name[IFNAMSIZ + 18];
>  	/* for dynamic allocation of rings associated with this q_vector */
>  	struct mucse_ring ring[] ____cacheline_internodealigned_in_smp;
>  };
>
> -struct mucse_stats {
> -	u64 tx_dropped;
> -};
> -
>  #define MAX_Q_VECTORS 8
>
> +#define M_DEFAULT_TXD     512
> +#define M_DEFAULT_TX_WORK 256
> +
> +enum mucse_state_t {
> +	__MUCSE_AXI_FAULT,
> +};
> +
>  struct mucse {
>  	struct net_device *netdev;
>  	struct pci_dev *pdev;
>  	struct mucse_hw hw;
> -	struct mucse_stats stats;
>  	struct mucse_ring *tx_ring[RNPGBE_MAX_QUEUES]
>  		____cacheline_aligned_in_smp;
>  	struct mucse_ring *rx_ring[RNPGBE_MAX_QUEUES]
>  		____cacheline_aligned_in_smp;

[Severity: Low]
The patch introduces an RCU protocol for these slots: struct mucse_q_vector
gains an rcu_head, rnpgbe_free_q_vector() switches from kfree() to
kfree_rcu(), and rnpgbe_get_stats64() reads the slots under
rcu_read_lock(). Should the arrays carry __rcu and should the publish and
consume sides use rcu_assign_pointer()/rcu_dereference() rather than
WRITE_ONCE()/READ_ONCE()?

In rnpgbe_alloc_q_vector() the store is:

	ring->pfvfnum = hw->pfvfnum;
	u64_stats_init(&ring->syncp);
	WRITE_ONCE(mucse->tx_ring[ring->queue_index], ring);

WRITE_ONCE() carries no release semantics, so the pointer store is not
ordered against the preceding ring->dev/ring->count/ring->netdev stores or
u64_stats_init(&ring->syncp), and rnpgbe_get_stats64() reads the slot with a
plain READ_ONCE().

Today this looks unreachable: rnpgbe_alloc_q_vector() runs from
rnpgbe_init_interrupt_scheme() before register_netdev(), and
rnpgbe_free_q_vector() runs either on the probe error path or after
unregister_netdev(), so no ndo_get_stats64 caller can race. Would it be
worth completing the idiom now, before any runtime queue reconfiguration or
reset path is added, and so sparse/RCU checkers can validate it?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index 0dce78e4a91b..6dc29ebe6fa7 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -7,13 +7,20 @@
> +#define RNPGBE_DMA_STATUS              0x0008
> +#define TX_AXI_RW_EN                   0xc
> +/* DMA_STATUS_REG[23:20]: tx_wr, tx_rd, rx_wr, rx_rd done status. */
> +#define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)

[Severity: Low]
This isn't a bug, but rnpgbe_hw.h has no #include lines at all while now
using GENMASK_U32() (and BIT() already). It builds only because the .c files
happen to pull in the right headers first. Would adding
#include <linux/bits.h> here make sense? The driver's other GENMASK_U32
users, rnpgbe_mbx.c and rnpgbe_mbx_fw.c, do include <linux/bitfield.h>.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index 9196fa130ca9..af5cef987051 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> +static int rnpgbe_tx_map(struct mucse_ring *tx_ring,
> +			 struct mucse_tx_buffer *first, u32 mac_ip_len,
> +			 u32 tx_flags)
> +{

[ ... ]

> +	if (size) {
> +		dma = dma_map_single(tx_ring->dev, skb->data, size,
> +				     DMA_TO_DEVICE);
> +		first->mapped_as_page = false;

[ ... ]

> +	/* write last descriptor with RS and EOP bits */
> +	tx_desc->vlan_cmd_bsz = build_ctob(tx_flags | M_TXD_CMD_EOP |
> +					   M_TXD_CMD_RS,
> +					   mac_ip_len, size);

[Severity: Low]
This isn't a bug, but rnpgbe_tx_map() only ever writes data descriptors
(pkt_addr plus build_ctob()), with tx_flags hardcoded to 0 and mac_ip_len
fixed at M_DEFAULT_MAC_IP_LEN, so the "1 desc for context descriptor"
comment on RESV_DESC_NEEDED in rnpgbe_lib.h describes a descriptor class the
code never emits. Should the comment be trimmed to the two-descriptor gap
until the offload code that needs the context descriptor lands?

[ ... ]

> +netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
> +				   struct mucse_ring *tx_ring)
> +{

[ ... ]

> +	/* record the location of the first descriptor for this packet */
> +	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +	first->skb = skb;

[Severity: Medium]
Can this dereference a NULL tx_buffer_info during the first ifup?

At this patch rnpgbe_add_adapter() calls register_netdev() without
netif_carrier_off() or netif_tx_stop_all_queues(), and __dev_open() sets
__LINK_STATE_START before calling ndo_open, so all three conditions checked
by __dev_direct_xmit() are satisfied while rnpgbe_open() is still running:

	netif_running() && netif_carrier_ok() &&
	!netif_xmit_frozen_or_drv_stopped()

An AF_PACKET socket with PACKET_QDISC_BYPASS can then enter
rnpgbe_xmit_frame() -> rnpgbe_xmit_frame_ring() in the window inside
rnpgbe_open():

	err = netif_set_real_num_queues(netdev, mucse->num_tx_queues,
					mucse->num_rx_queues);
	if (err)
		goto err_free_irqs;

	err = rnpgbe_setup_all_tx_resources(mucse);

where tx_buffer_info is still NULL, and a slightly later landing reaches
writel(i, tx_ring->tail) in rnpgbe_tx_map() with tail still NULL.

The window is closed later in the series by "net: rnpgbe: Add link status
handling support", which adds netif_carrier_off() before register_netdev()
and at the top of rnpgbe_open(). Would it make sense to fold that
netif_carrier_off() into this patch so it stands on its own?

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> index d38c08df6b7c..1fe290ed224d 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

[ ... ]

> +#define M_MAX_TXD_PWR             12
> +#define M_MAX_DATA_PER_TXD        (0x1 << M_MAX_TXD_PWR)
> +#define TXD_USE_COUNT(S)          DIV_ROUND_UP((S), M_MAX_DATA_PER_TXD)
> +#define DESC_NEEDED               (MAX_SKB_FRAGS + 4)
> +/* 2 desc gap to keep tail from touching head */
> +/* 1 desc for context descriptor */
> +#define RESV_DESC_NEEDED          3

[Severity: Low]
Same self-containment question as for rnpgbe_hw.h: rnpgbe_lib.h has no
#include lines, yet now uses MAX_SKB_FRAGS and DIV_ROUND_UP here, and
netdev_tx_t, struct sk_buff, struct net_device and struct rtnl_link_stats64
in the prototypes below. Should it include <linux/skbuff.h> and
<linux/netdevice.h> so it does not depend on include order in the .c files?

> @@ -31,4 +53,12 @@ void rnpgbe_free_irq(struct mucse *mucse);
> +netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
> +				   struct mucse_ring *tx_ring);
> +void rnpgbe_get_stats64(struct net_device *netdev,
> +			struct rtnl_link_stats64 *stats);
>  #endif

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index debed2f3fe64..cdda5f3d09b2 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -206,6 +247,13 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
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

> @@ -248,12 +296,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
Should the return value of dma_set_mask_and_coherent() still be checked
here? The previous code aborted probe and printed "No usable DMA
configuration, aborting", and dma_set_mask_and_coherent() is a plain static
inline int with no __must_check, so a failure is now completely silent.

If dma_supported() rejects a 56-bit mask, neither the streaming nor the
coherent mask is changed, the device keeps the PCI core's 32-bit default,
and probe continues through pci_request_mem_regions() to register_netdev().

The dma_get_mask() test above keeps highmem frags away by not setting
NETIF_F_HIGHDMA, but it does not cover the linear-data mapping in
rnpgbe_tx_map():

	dma = dma_map_single(tx_ring->dev, skb->data, size,
			     DMA_TO_DEVICE);
	...
	if (dma_mapping_error(tx_ring->dev, dma))
		goto err_unmap;

nor the descriptor allocation in rnpgbe_setup_tx_resources():

	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size, &tx_ring->dma,
					   GFP_KERNEL);

So every frame whose linear data sits above 4GB would be dropped with only
the private per-ring dropped counter moving and no kernel message.

The commit message says only:

  "Configure streaming and coherent DMA masks for the hardware's 56-bit
  DMA addressing capability."

Could it also state that a DMA configuration failure is now non-fatal and
unreported, or could the check and the error path be restored?

The call is still unchecked at the end of the series, so no later patch
covers this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B8AF0FDE24FAFB51%2B20260920092424.345309-1-dong100%40mucse.com
