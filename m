Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03A39A079;
	Wed, 16 Sep 2026 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521857; cv=none; b=o5QzQd+CnXBQJ9IrXVwCJG1+mWGlENtONVoCoiQMLXqpnwB08lTWPqw2Tp9W/KpjRkxHzH8OtXARjynSBkXPjrtqQ2zKIAxVnFg8v60uEmlWp/ruTzmA5P8SibsLjPxQcSXgtGNbXer1uBXn0A+xdDpJ7MRCkDuECAJwuGUAXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521857; c=relaxed/simple;
	bh=hlzlARlr+WuikbQcaV78ibNH9uh7GjE82sdJQOxoGdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/9GKrDZUAntMcBeiQk7OOyJ4RNl2zkO9qwDCfVCFeB5MxLS+JmnV2kX7Sph2W3HcRYtxwHFV4oVbI0Im/qm7uLgonngO+D8JeUQWIG+G1S4fGbQqqld3MZEVutsYxjyIr10x1uAukcyLq6gSZCBUCq2V8S7fLd49Gq/EqHwhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbI0yKjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbI0yKjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857631F00893;
	Wed, 16 Sep 2026 01:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521855;
	bh=WKKLbCLxEJPywKxwIuNOErSZ/y/sWa4N9jOU20ai71g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JbI0yKjxpNzegxzo5S+dKCd8d9xSZwZMgsB69vMVDuxfCO1IZbzyGqWDfdL6TxdWz
	 3pgKUPmKz289VVWMZjLIj79tYbi53Crl5ajjPU3a11umVIw9U80joAo6Du3Vw5+PKk
	 BSnPoiphxDDMbq7Us3SANh8v3IxRvmxoTu/gyYOTpIEPE0Zxk/TEp8XDeAmyaOCd04
	 HdWQEer34f3fvvqVfIKbTeaSz8KUGQylF0Vg66cyQSq/acH28ZNgSPLEffNxlrL5Bu
	 8AMekkDvcGYVVpTc6BBS8cuG17WvI/9i3Zk6jBV4Hyx+1vHXOD5VVHzThPvDy3TlU1
	 MOuiKbi5aUM5w==
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
Subject: Re: [PATCH net-next v13 5/7] r8169: add support and enable rss
Date: Tue, 15 Sep 2026 18:24:14 -0700
Message-ID: <20260916012414.1649482-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063110.1350-6-javen_xu@realsil.com.cn>
References: <20260910063110.1350-6-javen_xu@realsil.com.cn>
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
r8169: add support and enable rss

This adds RSS support for RTL8127: a new RSS descriptor layout selected
through tp->init_rx_desc_type, an RSS key and indirection table kept in
struct rtl8169_rss_data and programmed from rtl_set_rss_config(), and a
change of the RTL_GIGA_MAC_VER_80 interrupt request to a multi-vector
allocation so more than one RX ring can be used.

The commit message says:

  This patch adds support and enable rss for RTL8127.

[Severity: Low]
Could the message describe the behaviour changes that come with it?  A few
that are not mentioned:

rtl_alloc_irq() changes the RTL_GIGA_MAC_VER_80 request from
pci_alloc_irq_vectors(pdev, 1, 1, flags) to an all-or-nothing 30..32 vector
request with a fallback to exactly one vector, so a machine that can only
supply 29 vectors silently ends up with a single vector and no RSS.

struct RxDesc becomes a union with a second, differently ordered layout that
every RX accessor now switches on.

rtl_init_one() sets dev->features |= NETIF_F_RXHASH, so RX hashing is on by
default.

rtl8169_set_rss_hash_opt() enables UDP 4-tuple hashing unconditionally via
RSS_CTRL_UDP_IPV4_SUPP | RSS_CTRL_UDP_IPV6_SUPP.

rtl_rx() changes the NETIF_F_RXALL accept/drop decision for the RSS
descriptor format.

Also, "This patch adds support and enable rss" reads better in imperative
mood, e.g. "Add support for RSS and enable it on RTL8127".

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6e7a73f6bbb07..ad4ed3ffbec18 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c

[ ... ]

> @@ -512,6 +525,9 @@ enum rtl_register_content {
>  	RxRUNT	= (1 << 20),
>  	RxCRC	= (1 << 19),
>  
> +	RXRUNT_RSS	= (1 << 21),
> +	RXCRC_RSS	= (1 << 20),
> +
>  	/* ChipCmdBits */
>  	StopReq		= 0x80,
>  	CmdReset	= 0x10,

[ ... ]

> @@ -617,6 +633,22 @@ enum rtl_register_content {
>  #define	ISRIMR_LINKCHG	BIT(29)
>  #define	ISRIMR_TOK_Q0	BIT(8)
>  #define	ISRIMR_ROK_Q0	BIT(0)
> +#define RTL_DESC_TYPE_CTRL		0xd8
> +#define RSS_KEY_REG			0x4600
> +#define RSS_INDIRECTION_TBL_REG		0x4700
> +#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
> +#define RTL_DESC_TYPE_RSS		BIT(1)
> +#define RSS_CTRL_IPV4_SUPP		BIT(1)
> +#define RSS_CTRL_TCP_IPV6_SUPP		BIT(2)
> +#define RSS_CTRL_IPV6_SUPP		BIT(3)
> +#define RSS_CTRL_IPV6_EXT_SUPP		BIT(4)
> +#define RSS_CTRL_TCP_IPV6_EXT_SUPP	BIT(5)
> +#define RSS_CTRL_UDP_IPV4_SUPP		BIT(11)
> +#define RSS_CTRL_UDP_IPV6_SUPP		BIT(12)
> +#define	RX_RES_RSS			BIT(22)
> +#define	RX_RUNT_RSS			BIT(21)
> +#define	RX_CRC_RSS			BIT(20)
> +#define RTL_RX_Q_NUM_MASK		GENMASK(4, 2)
>  };

[Severity: Low]
This isn't a bug, but the same two descriptor error bits now have two names.
RXRUNT_RSS/RXCRC_RSS are added as enum values above and RX_RUNT_RSS/
RX_CRC_RSS are added as macros here, with identical values:

	RXRUNT_RSS	= (1 << 21),	vs	#define RX_RUNT_RSS BIT(21)
	RXCRC_RSS	= (1 << 20),	vs	#define RX_CRC_RSS  BIT(20)

rtl8169_check_rx_desc_error() uses the macro spellings while rtl_rx() uses
the enum spellings, so a later correction to one copy would miss the other.
Could one set be dropped?

[ ... ]

> @@ -2967,6 +3061,58 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
>  	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
>  }
>  
> +static void rtl8169_store_rss_key(struct rtl8169_private *tp)

[ ... ]

> +static void rtl8169_set_rss_hash_opt(struct rtl8169_private *tp)
> +{
> +	u32 rss_ctrl;
> +
> +	rss_ctrl = FIELD_PREP(RSS_CPU_NUM_MASK, ilog2(tp->num_rx_rings));
> +
> +	/* Perform hash on these packet types */
> +	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP |
> +		    RSS_CTRL_IPV4_SUPP |
> +		    RSS_CTRL_IPV6_SUPP |
> +		    RSS_CTRL_IPV6_EXT_SUPP |
> +		    RSS_CTRL_TCP_IPV6_SUPP |
> +		    RSS_CTRL_TCP_IPV6_EXT_SUPP |
> +		    RSS_CTRL_UDP_IPV4_SUPP |
> +		    RSS_CTRL_UDP_IPV6_SUPP;
> +
> +	rss_ctrl |= FIELD_PREP(RSS_HASH_MASK,
> +			       ilog2(tp->rss_data->hw_supp_indir_tbl_entries));
> +
> +	RTL_W32(tp, RSS_CTRL_8125, rss_ctrl);
> +}
> +
> +static void rtl_set_rss_config(struct rtl8169_private *tp)
> +{
> +	rtl8169_set_rss_hash_opt(tp);
> +	rtl8169_store_reta(tp);
> +	rtl8169_store_rss_key(tp);
> +}
> +

[Severity: Low]
Is the ethtool RSS interface meant to be added later in the series?  The
driver now generates and programs a key and an indirection table
(rtl8169_init_rss() fills rss_key via netdev_rss_key_fill() and
rss_indir_tbl via ethtool_rxfh_indir_default(), rtl_set_rss_config() writes
both to hardware), but rtl8169_ethtool_ops gains none of
.get_rxfh_key_size, .get_rxfh_indir_size, .get_rxfh, .set_rxfh, .get_rxnfc
or .set_rxnfc, at this commit or at the end of the series.

So ethtool -x, -X and -N return EOPNOTSUPP: the key cannot be read, the
redirection table cannot be changed, and the UDP 4-tuple hashing enabled
above by RSS_CTRL_UDP_IPV4_SUPP | RSS_CTRL_UDP_IPV6_SUPP cannot be turned
off.

[ ... ]

> @@ -5160,8 +5431,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
>  
>  			if (!(dev->features & NETIF_F_RXALL))
>  				goto release_descriptor;
> -			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> -				goto release_descriptor;
> +
> +			if (tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT) {
> +				if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
> +					goto release_descriptor;
> +			} else {
> +				if (!(status & (RXRUNT_RSS | RXCRC_RSS)))
> +					goto release_descriptor;
> +			}
>  		}
>  
>  		pkt_size = status & GENMASK(13, 0);

[Severity: Medium]
This isn't introduced by this patch, but since the accept/drop decision is
being reworked here and a second acceptance branch is added, can pkt_size
underflow for a salvaged error frame?

		pkt_size = status & GENMASK(13, 0);
		if (likely(!(dev->features & NETIF_F_RXFCS)))
			pkt_size -= ETH_FCS_LEN;

With rx-all enabled, a RUNT/CRC descriptor reporting a length of 0..3 makes
the unsigned subtraction wrap to roughly 4 GiB.  The following
napi_alloc_skb() does not fail in that case, because it wraps too:

net/core/skbuff.c:napi_alloc_skb() {
	...
	len += NET_SKB_PAD + NET_IP_ALIGN;
	if (len <= SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE) || ...)
		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX | SKB_ALLOC_NAPI, NUMA_NO_NODE);
	...
}

0xfffffffc + NET_SKB_PAD + NET_IP_ALIGN wraps to a small value, so a small
head is allocated and skb_copy_to_linear_data(skb, rx_buf, pkt_size) then
copies the un-wrapped length into it, followed by skb->tail += pkt_size and
skb->len = pkt_size.  Would a minimum length check before the ETH_FCS_LEN
subtraction be worthwhile here?

[ ... ]

> @@ -5817,6 +6098,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static int get_max_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MAX_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static int get_min_irq_nvecs(struct rtl8169_private *tp)
> +{
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
> +		return R8127_MIN_NUM_IRQVEC;
> +	return R8169_IRQ_DEFAULT;
> +}
> +
> +static void rtl8169_set_rx_ring_num(struct rtl8169_private *tp)
> +{
> +	if (tp->irq_nvecs >= get_min_irq_nvecs(tp)) {
> +		unsigned int rss_queue_num = netif_get_num_default_rss_queues();
> +
> +		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
> +							    tp->hw_supp_num_rx_queues));
> +		if (tp->num_rx_rings >= 2)
> +			tp->init_rx_desc_type = RX_DESC_TYPE_RSS;
> +	}
> +}
> +

[Severity: Low]
Since tp->num_rx_rings can now be smaller than the number of RX vectors
that were allocated, does rtl8169_netpoll() leave the hardware mask out of
sync with tp->irq_mask?

rtl8169_netpoll() iterates min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1)
entries and calls rtl8169_interrupt_msix() for each one.  For a vector with
message_id >= tp->num_rx_rings, rtl8169_poll_msix_rx() does no ring work,
completes immediately and still calls rtl8169_enable_hw_interrupt_msix(),
setting that queue's bit in IMR_SET_VEC_MAP_REG, while rtl_set_irq_mask()
deliberately only sets ISRIMR_ROK_Q0 << i for i < tp->num_rx_rings.

Would bounding the loop by tp->num_rx_rings be more consistent?

>  static int rtl_alloc_irq(struct rtl8169_private *tp)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -5837,7 +6144,11 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		break;
>  	}
>  
> -	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
> +	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp),
> +				      get_max_irq_nvecs(tp), flags);
> +
> +	if (nvecs < 0)
> +		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
>  
>  	if (nvecs < 0)
>  		return nvecs;

[Severity: High]
This is the first time tp->irq_nvecs can be greater than 1 for
RTL_GIGA_MAC_VER_80, which activates the MSI-X path in
rtl8169_request_irq().  Can that dereference a NULL tp->phydev on the SFP
variant?

rtl8169_request_irq() registers vector MSIX_ID_VEC_MAP_LINKCHG with
rtl8169_interrupt_other() when tp->irq_nvecs > 1, and rtl_set_irq_mask()
sets ISRIMR_LINKCHG so the vector is armed.  The handler does:

	rtl8169_clear_hw_isr(tp, MSIX_ID_VEC_MAP_LINKCHG);
	phy_mac_interrupt(tp->phydev);

while the single-vector handler treats a NULL phydev as an expected
configuration:

rtl8169_interrupt() {
	...
	if (status & LinkChg) {
		if (tp->phydev)
			phy_mac_interrupt(tp->phydev);
		else if (tp->sfp_mode)
			phylink_mac_change(tp->phylink,
					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
	}
	...
}

On an RTL8127 where rtl_get_sfp_mode() returns RTL_SFP_8127_ATF,
rtl_init_one() skips r8169_mdio_register(), which is the only place
tp->phydev is assigned, so tp->phydev stays NULL and the first link change
would dereference NULL in hard IRQ context.

Related: even with a valid phydev, rtl8169_interrupt_other() never performs
the phylink_mac_change() notification, so would link state ever be reported
on SFP boards using the MSI-X path?

[ ... ]

> @@ -6531,6 +6849,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (rc < 0)
>  		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
>  
> +	rtl8169_set_rx_ring_num(tp);
> +
> +	if (rtl_hw_support_rss(tp))
> +		rtl8169_init_rss(tp);
> +

[Severity: Medium]
While looking at rtl_init_one() in this series: do the two allocation
failure paths added further down leak the phylink instance created by
rtl_init_phylink()?

	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
			      GFP_KERNEL);
	if (!tp->rx_ring)
		return -ENOMEM;
	...
	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct), GFP_KERNEL);
	if (!tp->rtl8169_napi) {
		kfree(tp->rx_ring);
		return -ENOMEM;
	}

Both run after rtl_init_phylink() succeeded, and phylink_create() is not
devm managed.  The neighbouring failure paths in the same function do clean
up, e.g.:

	rc = register_netdev(dev);
	if (rc) {
		phylink_destroy(tp->phylink);
		goto err_free_napi;
	}

These two returns are still without phylink_destroy() at the end of the
series.

[ ... ]
