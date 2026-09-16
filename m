Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BC39478B;
	Wed, 16 Sep 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521856; cv=none; b=gimgfQUsMWoPReBR/7HlZngKX0H+5QI8VqWraD0j1qUX3AjtNEangIcDf+TUtCwEFUvq4zXRyLbxJJgkfipQ6PrH9hPdE63lNkgJxxTX2iFADmtpa3R2A9Tr/aMtcaBOh4Ic830qgWYynfSI0Yb31xW5v7jJWFIgLd5gAKW+m7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521856; c=relaxed/simple;
	bh=zglPmBO7cBPZaWC/m8QWeq/mwORcCJoxpG2l1ZUDPIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9hgC5yqknTLrtjK09ZuwagqGpSxd39bq8UEXuyx4YK80xOsAA0OHqZqlKLFVbUOxbsP6dnQlQoC3zMLEKU3zcu9gJQhExxFnbtBD3ZWGJAVMOgLAC+dzvuVdKosBjkRKUfNbJEwJaO1+OPpz3F0EG4rbDP2K5qbpgiEUlfbPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOddys/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOddys/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8B61F000FF;
	Wed, 16 Sep 2026 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521854;
	bh=PkJdWvr+Qd4MH6IiOIVkLo2BYUggEfdzWltXvvAiliE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOddys/uPq+msMNWWFol0c80P0pB2RlAZaYE2qdiKgue2KDMQNC+GdFeDukcaP50H
	 E6jMEPWtGxoSKqlSz35qie2pTTxNgMuWvW7pgcKTa+mM6jJVmXOxxGvxBHCeFlRTBv
	 LSu+qJKnD1scENfkP8PTkPGP91wa39qp+gTZLBhzrNjtT/Jbpx6kbd2K6cTiLTvkRw
	 SKdjS1/iYZnfe4zCbfo1oFzaDF6twgEM46dGXEq2U4477LJHh3mBCM3YPHWPq2l//s
	 mtzLOap1QkCjnEP4Y3KsFXSzZkgHeXU7k7XuSqwDPlmfw2eKOgJkiKQ68B2Y8b1Ilj
	 jyLEcDSABeBvg==
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
Subject: Re: [PATCH net-next v13 3/7] r8169: add support for new interrupt mapping
Date: Tue, 15 Sep 2026 18:24:13 -0700
Message-ID: <20260916012413.1649432-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063110.1350-4-javen_xu@realsil.com.cn>
References: <20260910063110.1350-4-javen_xu@realsil.com.cn>
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
r8169: add support for new interrupt mapping

This adds the vector-map interrupt registers (IMR_CLEAR_VEC_MAP_REG,
ISR_VEC_MAP_REG, IMR_SET_VEC_MAP_REG) and, when more than one IRQ vector is
present, switches to per-vector MSI-X handlers and separate Rx/Tx NAPI poll
functions. A dedicated handler is registered on vector 29 for link change
events.

A few questions below.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f80ad229ae5f8..361e833354233 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -477,8 +477,12 @@ enum rtl8125_registers {
>  	RSS_CTRL_8125		= 0x4500,
>  	Q_NUM_CTRL_8125		= 0x4800,
>  	EEE_TXIDLE_TIMER_8125	= 0x6048,
> +	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
> +	ISR_VEC_MAP_REG		= 0x0d04,
> +	IMR_SET_VEC_MAP_REG	= 0x0d0c,
>  };
>  
> +#define MSIX_ID_VEC_MAP_LINKCHG	29
>  #define LEDSEL_MASK_8125	0x23f
>  
>  #define RX_VLAN_INNER_8125	BIT(22)
> @@ -609,6 +613,9 @@ enum rtl_register_content {
>  
>  	/* magic enable v2 */
>  	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
> +#define	ISRIMR_LINKCHG	BIT(29)
> +#define	ISRIMR_TOK_Q0	BIT(8)
> +#define	ISRIMR_ROK_Q0	BIT(0)
>  };

[ ... ]

> @@ -5198,13 +5221,66 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  	return IRQ_HANDLED;
>  }
>  

[ ... ]

> +static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
> +{
> +	struct napi_struct *napi = dev_instance;
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +	int message_id;
> +
> +	tp = netdev_priv(dev);
> +	message_id = napi - tp->rtl8169_napi;
> +
> +	rtl8169_disable_hw_interrupt_msix(tp, message_id);
> +	rtl8169_clear_hw_isr(tp, message_id);
> +
> +	napi_schedule(napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rtl8169_interrupt_other(int irq, void *dev_instance)
> +{
> +	struct rtl8169_private *tp = dev_instance;
> +
> +	rtl8169_clear_hw_isr(tp, MSIX_ID_VEC_MAP_LINKCHG);
> +	phy_mac_interrupt(tp->phydev);
> +	return IRQ_HANDLED;
>  }

[Severity: Critical]
Can tp->phydev be NULL here?

The existing handler for the same LinkChg event, rtl8169_interrupt(), guards
the pointer and has an SFP fallback:

	if (status & LinkChg) {
		if (tp->phydev)
			phy_mac_interrupt(tp->phydev);
		else if (tp->sfp_mode)
			phylink_mac_change(tp->phylink,
					   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
	}

tp->phydev is only assigned by r8169_mdio_register(), and rtl_init_one()
calls that only for the non-SFP case:

	if (tp->sfp_mode == RTL_SFP_NONE) {
		rc = r8169_mdio_register(tp);
		...
	}

For an RTL8127 in fiber mode rtl_get_sfp_mode() returns RTL_SFP_8127_ATF,
so tp->phydev stays NULL (rtl_open() likewise does
"if (tp->phydev) r8169_phy_connect(tp);").

phy_mac_interrupt() dereferences the pointer straight away:

drivers/net/phy/phy.c:phy_mac_interrupt() {
	/* Trigger a state machine change */
	phy_trigger_machine(phydev);
}

with phy_queue_state_machine() forming &phydev->state_queue. Since this runs
in hard IRQ context, wouldn't the resulting oops be fatal?

The vector is armed regardless of sfp_mode, because rtl_set_irq_mask() sets
ISRIMR_LINKCHG for every multi-vector configuration, and vector 29 is
registered whenever irq_nvecs reaches MSIX_ID_VEC_MAP_LINKCHG. On RTL8127
get_min_irq_nvecs()/get_max_irq_nvecs() request 30..32 vectors once
"r8169: enable new interrupt mapping" lands, so the trigger is just a fiber
link up/down, e.g. plugging the module or the remote port toggling.

Should this handler mirror the tp->phydev check and the phylink_mac_change()
fallback? As written the SFP link state also never reaches phylink even if
the dereference were guarded.

>  
>  static int rtl8169_request_irq(struct rtl8169_private *tp)
> @@ -5215,8 +5291,27 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
>  
>  	for (i = 0; i < tp->irq_nvecs; i++) {
>  		napi = &tp->rtl8169_napi[i];
> -		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
> -				     NULL, napi, "%s-%d", dev->name, i);
> +		if (tp->irq_nvecs > 1) {
> +			/* RX: 0~7, TX: 8*/
> +			if (i <= R8169_MAX_RX_QUEUES)
> +				rc = pci_request_irq(tp->pci_dev, i,
> +						     rtl8169_interrupt_msix,
> +						     NULL, napi, "%s-%d",
> +						     dev->name, i);
> +			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
> +				rc = pci_request_irq(tp->pci_dev, i,
> +						     rtl8169_interrupt_other,
> +						     NULL, tp, "%s-%d",
> +						     dev->name, i);
> +			else
> +				continue;
> +		} else {
> +			rc = pci_request_irq(tp->pci_dev, i,
> +					     rtl8169_interrupt,
> +					     NULL, napi, "%s-%d",
> +					     dev->name, i);
> +		}
> +
>  		if (rc)
>  			goto free_irq;
>  	}

[ ... ]

> @@ -5648,10 +5752,16 @@ static const struct net_device_ops rtl_netdev_ops = {
>  
>  static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  {
> -	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
> +	if (tp->irq_nvecs > 1) {
> +		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
> +		for (int i = 0; i < tp->num_rx_rings; i++)
> +			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
> +	} else {
> +		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
> -	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -		tp->irq_mask |= SYSErr | RxFIFOOver;
> +		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> +			tp->irq_mask |= SYSErr | RxFIFOOver;
> +	}
>  }

[ ... ]

> @@ -6197,10 +6307,63 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
>  	return 0;
>  }
>  
> +static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct rtl8169_private *tp;
> +	int work_done = 0;
> +	int message_id;
> +
> +	tp = netdev_priv(dev);
> +	message_id = napi - tp->rtl8169_napi;
> +
> +	if (message_id < tp->num_rx_rings)
> +		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
> +				    budget, napi);
> +
> +	if (work_done < budget && napi_complete_done(napi, work_done))
> +		rtl8169_enable_hw_interrupt_msix(tp, message_id);
> +
> +	return work_done;
> +}

[ ... ]

> +/* RTL8127 MSI-X vector layout:
> + * Vectors 0 .. (RxQs - 1)		: Rx Queues
> + * Vectors RxQs .. (RxQs + TxQs - 1)	: Tx Queues
> + * NAPI is only allocated for data path
> + */

[Severity: Low]
This isn't a bug, but does this comment match the code below it?

The comment says the Tx vectors start at RxQs, while r8169_init_napi() keys
the Tx poll function on the fixed constant R8169_MAX_RX_QUEUES, and
rtl8169_request_irq() states the layout differently:

			/* RX: 0~7, TX: 8*/
			if (i <= R8169_MAX_RX_QUEUES)

The hardware defines added in this patch also point at a fixed boundary,
ISRIMR_ROK_Q0 = BIT(0) and ISRIMR_TOK_Q0 = BIT(8), i.e. Tx is bit 8 no
matter how many Rx rings are active. With tp->num_rx_rings typically 1, 2 or
4, the comment would place Tx on vector 1, 2 or 4, which is where the code
installs rtl8169_poll_msix_rx().

Should the comment also mention the third handler this patch registers, on
vector 29 (MSIX_ID_VEC_MAP_LINKCHG)?

>  static void r8169_init_napi(struct rtl8169_private *tp)
>  {
> -	for (int i = 0; i < tp->irq_nvecs; i++) {
> -		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
> +	int napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
> +
> +	for (int i = 0; i < napi_num; i++) {
> +		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
> +
> +		if (tp->irq_nvecs > 1) {
> +			if (i < R8169_MAX_RX_QUEUES)
> +				poll_fn = rtl8169_poll_msix_rx;
> +			else
> +				poll_fn = rtl8169_poll_msix_tx;
> +		}
> +		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
>  		netif_napi_set_irq(&tp->rtl8169_napi[i],
>  				   pci_irq_vector(tp->pci_dev, i));
>  	}

[Severity: Low]
Should this loop bound be derived from tp->num_rx_rings instead of
R8169_MAX_RX_QUEUES?

With MSI-X this creates 9 NAPI instances (8 Rx + 1 Tx) and calls
netif_napi_set_irq() for each, while the number of Rx queues reported to the
core and the number of rings allocated both come from tp->num_rx_rings:

	rc = netif_set_real_num_queues(tp->dev, 1, tp->num_rx_rings);
	...
	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
			      GFP_KERNEL);

tp->num_rx_rings is rounddown_pow_of_two(min(netif_get_num_default_rss_queues(),
hw_supp_num_rx_queues)), so it is typically 1, 2 or 4 on machines with fewer
than 16 CPUs. rtl8169_poll_msix_rx() appears to acknowledge the surplus
instances with its "if (message_id < tp->num_rx_rings)" guard, and still
re-arms those vectors through rtl8169_enable_hw_interrupt_msix().
rtl8169_request_irq() also requests handlers for those vectors and
rtl8169_netpoll() kicks their NAPIs. Is reporting more NAPI instances to the
netdev core than there are Rx queues intentional?

One more question, about code outside this diff.

[Severity: Medium]
Do the two new allocation failure paths in rtl_init_one() leak the phylink
instance created by rtl_init_phylink()? These call sites come from the
earlier patches in this series rather than from this commit:

	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
			      GFP_KERNEL);
	if (!tp->rx_ring)
		return -ENOMEM;
	...
	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
				   GFP_KERNEL);
	if (!tp->rtl8169_napi) {
		kfree(tp->rx_ring);
		return -ENOMEM;
	}

Both return after rtl_init_phylink() has stored the object in tp->phylink,
without calling phylink_destroy(). The neighbouring error paths in the same
function do release it:

	if (tp->sfp_mode == RTL_SFP_NONE) {
		rc = r8169_mdio_register(tp);
		if (rc) {
			phylink_destroy(tp->phylink);
			return rc;
		}
	}
	...
	rc = register_netdev(dev);
	if (rc) {
		phylink_destroy(tp->phylink);
		goto err_free_napi;
	}

With 30 to 32 napi_structs requested on RTL8127, is the napi kcalloc()
failure path worth wiring into the same cleanup?
