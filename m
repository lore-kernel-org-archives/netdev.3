Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3139479C;
	Tue,  8 Sep 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853658; cv=none; b=tjf2jVGVvpEXSrRNklzKdrBeYutJhA1ldWEbQjiHrwhVQQIZyVHib7UZbF/+8+C5Uzo+Zg+mvVeX6ojsoCabm1ljJ9Q9zAbD8YvV9MlwBIW3zU62Fnzgomy8ulH/VNx6sm7qayjja6xPNXHo0gRkcoF51nxpJ2L6xOAryT55jYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853658; c=relaxed/simple;
	bh=t1gL8WewAPQmhMdGJoYMpQRMSh5V+VzNAxeW03OTOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArZuVJLekh7Kt+fGUahewDATATdX5SITham8xVB2XDJ21k6so4XkEb9NjBxxItDLtiT3KzHf6X/KMMw9zO/C/PyUTQmksmV+tdme7gSZos6KX8rthIsXWliMzmq5lidmDtAwuStcyEVjMPN1YugMSVbA9SqG0yZ6Fcj+w/2EELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1788853590t7f02b9ba
X-QQ-Originating-IP: DFbcOUf05q228mnB/CQGTxyq+ASe9aup5OoXcqRzSYo=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 15:46:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14085937823580415014
EX-QQ-RecipientCnt: 10
Date: Tue, 8 Sep 2026 15:46:27 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v10 4/5] net: rnpgbe: Add receive mode support
Message-ID: <E95C6B9267D42328+20260908074627.GC507605@nic-Precision-5820-Tower>
References: <462BE38B6E2AFC58+20260831073608.401988-5-dong100@mucse.com>
 <20260904215717.4000021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904215717.4000021-1-kuba@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NaHUgbmuuKag1PT9F0PTmRHfIvGgmoMW1Oo1vJy12d4VlVmeilAcHFiA
	9xMx08Rd24Cxxi9lTk/Wr+hHpiUACXPk59+raNCIjTsCGTdEE9I5Y4u3Q7uNjmGIanCBmN5
	ilpW8/nZw9FWFPTW+A200zoNhXHxl6PC3kVGn8+BoHrDzTS2PH2DJ81QhGXGz8fNyrtcWLU
	vXId3ou0bPb0xrNy4ASehrkIQuNG5w/9ANa7DAi2xpmBxxmb3SciVYBQ3rdQ6zSNmReHmJR
	gRYPWPDKaQmgrLVUG1SfnD00EHhIVliFl/DzJCIU5PG+3YMfOuwEogpo6yZfYnbIRnrkvpc
	6P8+FY2d9WuEmuoelV5CYFLUsncxIVp8+TeCHBsOE4wDP2PZ6CdoFFNZVwmF99314XFg5Rk
	7QAKGs6K3dEIMpg+S2irOKKwazlCErbJvznRGOmQtwAdIpxJzz1b9KZxlvVxBWQhPRuWOJg
	VhT9k0+GeJ+Ghe1zGYWpE7m3c9eyQqYHy1jGnoGih9W64qitezinOCjEhauC5RgGcAj9yKB
	0NxsI2vR4b9ShLXkpTEpFr4kqiNXsANnEUjE7NdRf3E/3TzehRT0A9tEOjutBcqdSk8d4ux
	yPl7yOfc2poy2GcoXcZOBBptqyHV0AmSsJ2ubMynccIJVtlyOgxhNmPwZPcQT7wkTpeWGjX
	9JDu/M7+BEB5xMySLocNP9r/S4TwJlKm9e2XMwWtvqO4vSAdKiOrBOU7dxaIkXVcfosvoxb
	qFUOrWialqN0yRvx0Xl4XutMaX+9Tv1d6mN+QVHL0hk/C5fL4Hi22kGt+BWlKRTuRgfgRKB
	yrNRbrBDLECn+wauq0xu5z7VZwN682eol1Z9ulGGTCS/1IRwK34eeAM3AnIQIUvuq0M+fp7
	mKtcYVypAWYt74vIf2U5eCnv6i/AB3MapWfSvXy+/eLSgOzKO1y7GqE4JLKsH1TVYXP4wBv
	OSnaD3c+mmWGe+Kt2mh6FYyLzcx2QGrGFlm35KDYjm+AcR6E4wgV6OpofreHeauHtszG2OA
	iVCKuY//rgdwjbRO8QsR7EgWXno6lwW9yieZYhoIPrjDlHoCGJ
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On Fri, Sep 04, 2026 at 02:57:17PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: rnpgbe: Add receive mode support
> 
> This adds chip-level receive filtering to rnpgbe along with the
> ndo_set_rx_mode callback.  Unicast addresses go into the 30 usable RAR
> entries and multicast addresses into the 4096-bit hash table, with
> IFF_PROMISC and IFF_ALLMULTI handled through the filter control register.
> rnpgbe_configure() also calls the new function directly from the open path.
> 
> Two questions below.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > index 291e77d573fe..c7d5b53f6209 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> > @@ -149,3 +149,76 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> 
> [ ... ]
> 
> > +void rnpgbe_set_rx_mode(struct net_device *netdev)
> > +{
> > +	u32 mcast_hash[RNPGBE_RX_MCAST_HASH_ENTRIES] = {};
> > +	u32 mcast_ctrl = RNPGBE_RX_UCAST_TABLE_EN;
> > +	u32 filter_ctrl = RNPGBE_RX_FILTER_BCAST;
> > +	struct netdev_hw_addr *ha;
> > +	struct mucse_hw *hw;
> > +	struct mucse *mucse;
> > +	int rar = 1;
> > +	u16 hash;
> > +	int i;
> > +
> > +	mucse = netdev_priv(netdev);
> > +	hw = &mucse->hw;
> > +
> > +	/* RAR 0 always holds the interface's primary unicast address. */
> > +	rnpgbe_set_rar(hw, 0, netdev->dev_addr);
> > +
> > +	netdev_for_each_uc_addr(ha, netdev) {
> > +		if (rar == RNPGBE_RX_RAR_ENTRIES) {
> > +			filter_ctrl |= RNPGBE_RX_FILTER_UCAST_ALL;
> > +			break;
> > +		}
> > +
> > +		rnpgbe_set_rar(hw, rar, ha->addr);
> > +		rar++;
> > +	}
> > +
> > +	for (; rar < RNPGBE_RX_RAR_ENTRIES; rar++)
> > +		rnpgbe_clear_rar(hw, rar);
> > +
> > +	if (netdev->flags & IFF_PROMISC) {
> > +		filter_ctrl |= RNPGBE_RX_FILTER_UCAST_ALL |
> > +			       RNPGBE_RX_FILTER_MCAST_ALL;
> 
> [Severity: High]
> Can this secondary unicast RAR programming ever take effect?  I could not
> find netdev->priv_flags |= IFF_UNICAST_FLT anywhere under
> drivers/net/ethernet/mucse/rnpgbe/, including rnpgbe_add_adapter() where
> netdev_ops and features are set up before register_netdev().
> 
> Without that flag, the core forces promiscuous mode as soon as dev->uc is
> non-empty, in netif_uc_promisc_update():
> 
> net/core/dev_addr_lists.c:netif_uc_promisc_update() {
> 	if (dev->priv_flags & IFF_UNICAST_FLT)
> 		return 0;
> 
> 	if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
> 		dev->uc_promisc = true;
> 		return 1;
> 	}
> }
> 
> Both callers (netif_rx_mode_run() and __dev_set_rx_mode()) then call
> __dev_set_promiscuity(dev, +1, false), which sets IFF_PROMISC in dev->flags
> before ops->ndo_set_rx_mode() runs.
> 
> So for any configuration that adds a secondary unicast address (macvlan,
> ipvlan, a bridge port with a different MAC, VM MAC passthrough),
> rnpgbe_set_rx_mode() always sees IFF_PROMISC and takes the branch above.
> The RAR entries just written become irrelevant, and since the else branch is
> skipped the mcast_hash[] array stays all zero and RNPGBE_RX_MCAST_HASH_EN is
> never set, so multicast filtering is off as well and the adapter accepts
> everything on the wire.
> 
> That also seems to make this part of the changelog unobservable:
> 
>     Fall back to accepting all unicast addresses when the RAR
>     table is exhausted
> 
> the fallback is pre-empted by the core at the first secondary address, long
> before 30 RAR entries are used.  Should the driver set IFF_UNICAST_FLT in
> rnpgbe_add_adapter(), or is the exact unicast filter logic here not intended
> to be used?
> 
Got it, I will set IFF_UNICAST_FLT before register_netdev().
> > +	} else if (netdev->flags & IFF_ALLMULTI) {
> > +		filter_ctrl |= RNPGBE_RX_FILTER_MCAST_ALL;
> > +	} else {
> > +		/* The MTA index is the 12 address bits from 36 through 47. */
> > +		netdev_for_each_mc_addr(ha, netdev) {
> > +			hash = ((ha->addr[4] & 0xf) << 8) | ha->addr[5];
> > +			mcast_hash[hash >> 5] |= BIT(hash & 0x1f);
> > +		}
> > +
> > +		if (!netdev_mc_empty(netdev))
> > +			mcast_ctrl |= RNPGBE_RX_MCAST_HASH_EN;
> > +	}
> 
> [Severity: High]
> The comment directly above this line says the MTA index is the 12
> address bits from 36 through 47, but the expression does not extract
> those bits.  With the usual MAC bit numbering (bit 0 is the LSB of
> addr[0], so ha->addr[4] carries bits 32-39 and ha->addr[5] bits
> 40-47), ha->addr[4] & 0xf is bits 32-35.  Bits 36-39 are the upper
> nibble, i.e. ha->addr[4] >> 4.  Compare ixgbe_mta_vector() in
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c, which spells the
> same field for "bits [47:36]" as
> ((mc_addr[4] >> 4) | (((u16)mc_addr[5]) << 4)).
> 
> The placement of the pieces differs too: here ha->addr[5] ends up in
> the low 8 bits of hash and the nibble in bits 11:8, while the Intel
> layout puts addr[5] in the high bits.  The driver has to reproduce
> exactly the index the hardware derives, so both the nibble that is
> selected and where it lands matter.
> 
> If the index is wrong, mcast_hash[hash >> 5] |= BIT(hash & 0x1f) sets
> the wrong bit and RNPGBE_RX_MCAST_HASH() ends up programmed for
> groups nobody joined while the joined ones are filtered out.  IPv6
> neighbour discovery is the obvious casualty: solicited-node addresses
> 33:33:ff:xx:xx:xx differ only in the trailing bytes, so picking the
> wrong nibble of ha->addr[4] mis-indexes essentially every entry, and
> the failure is silent - traffic simply disappears unless something
> puts the interface into IFF_ALLMULTI or IFF_PROMISC.
> 
> Could you confirm against the hardware documentation which address
> bits the MTA index is built from, and then either fix the extraction
> or correct the comment so the two agree?
> 
> [ ... ]
> 
The hardware defines the multicast filter vector as:

        ((addr[4] << 8) | addr[5]) & 0xfff

The upper 7 bits select one of the 128 MTA registers and the lower
5 bits select the bit within that register. The current calculation
implements this hardware-defined layout, so it intentionally differs
from ixgbe's multicast hash layout.
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index e62366291b2a..817081e24bb5 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > @@ -43,7 +43,12 @@ static int rnpgbe_configure(struct mucse *mucse)
> >  	if (err)
> >  		return err;
> >  
> > -	return rnpgbe_configure_rx(mucse);
> > +	err = rnpgbe_configure_rx(mucse);
> > +	if (err)
> > +		return err;
> > +
> > +	rnpgbe_set_rx_mode(mucse->netdev);
> > +	return 0;
> >  }
> 
> [Severity: High]
> Is this direct call missing the address list lock?  rnpgbe_configure() runs
> from the ndo_open path with only RTNL held, while every core invocation of
> ndo_set_rx_mode wraps the callback in netif_addr_lock_bh() /
> netif_addr_unlock_bh() (netif_rx_mode_run() and dev_set_rx_mode() in
> net/core/dev_addr_lists.c).
> 
> rnpgbe_set_rx_mode() walks dev->uc and dev->mc with the plain, non-RCU
> iterators:
> 
> 	netdev_for_each_uc_addr(ha, netdev) {
> 		...
> 		rnpgbe_set_rar(hw, rar, ha->addr);
> 	...
> 		netdev_for_each_mc_addr(ha, netdev) {
> 			hash = ((ha->addr[4] & 0xf) << 8) | ha->addr[5];
> 
> Writers only take netif_addr_lock_bh(), not RTNL, and free entries with RCU:
> 
> net/core/dev_addr_lists.c:__hw_addr_del_entry() {
> 	list_del_rcu(&ha->list);
> 	kfree_rcu(ha, rcu_head);
> }
> 
> Such a writer is reachable without RTNL from an ordinary socket:
> 
>   setsockopt(IPV6_JOIN_GROUP) -> ipv6_sock_mc_join() ->
>   __ipv6_sock_mc_join() -> __ipv6_dev_mc_inc() -> igmp6_group_added() ->
>   dev_mc_add()
> 
> Can the walk above then dereference freed memory?  The open path is
> preemptible and holds no rcu_read_lock(), so if it is preempted while
> holding ha, a concurrent list_del_rcu() + kfree_rcu() can complete its grace
> period and the next ha->list.next dereference reads freed memory, possibly
> programming a RAR from it.
> 
> Is the call needed at all?  __dev_open() calls dev_set_rx_mode() right after
> ndo_open returns, which invokes rnpgbe_set_rx_mode() with the address lock
> held.  If it is needed here, would netif_addr_lock_bh() around it be
> appropriate?
> 
The filter tables need to be configured before RX_START is enabled, so the
direct call is required. I will keep it and protect the address-list walk
with netif_addr_lock_bh()/netif_addr_unlock_bh().
> [ ... ]
> 
> > @@ -149,3 +149,76 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> >  
> >  	return 0;
> >  }
> > +
> > +static void rnpgbe_set_rar(struct mucse_hw *hw, u32 index, const u8 *addr)
> > +{
> > +	u32 rar_low, rar_high;
> > +
> > +	/* The RAR stores the Ethernet address in reverse byte order. */
> > +	rar_low = (u32)addr[5] | ((u32)addr[4] << 8) |
> > +		  ((u32)addr[3] << 16) | ((u32)addr[2] << 24);
> > +	rar_high = (u32)addr[1] | ((u32)addr[0] << 8) |
> > +		   RNPGBE_RX_RAR_VALID;
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), rar_low);
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), rar_high);
> > +}
> > +
> > +static void rnpgbe_clear_rar(struct mucse_hw *hw, u32 index)
> > +{
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), 0);
> > +	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), 0);
> > +}
> > +
> > +void rnpgbe_set_rx_mode(struct net_device *netdev)
> > +{
> > +	u32 mcast_hash[RNPGBE_RX_MCAST_HASH_ENTRIES] = {};
> > +	u32 mcast_ctrl = RNPGBE_RX_UCAST_TABLE_EN;
> > +	u32 filter_ctrl = RNPGBE_RX_FILTER_BCAST;
> > +	struct netdev_hw_addr *ha;
> > +	struct mucse_hw *hw;
> > +	struct mucse *mucse;
> > +	int rar = 1;
> > +	u16 hash;
> > +	int i;
> > +
> > +	mucse = netdev_priv(netdev);
> > +	hw = &mucse->hw;
> > +
> > +	/* RAR 0 always holds the interface's primary unicast address. */
> > +	rnpgbe_set_rar(hw, 0, netdev->dev_addr);
> > +
> > +	netdev_for_each_uc_addr(ha, netdev) {
> > +		if (rar == RNPGBE_RX_RAR_ENTRIES) {
> > +			filter_ctrl |= RNPGBE_RX_FILTER_UCAST_ALL;
> > +			break;
> > +		}
> > +
> > +		rnpgbe_set_rar(hw, rar, ha->addr);
> > +		rar++;
> > +	}
> > +
> > +	for (; rar < RNPGBE_RX_RAR_ENTRIES; rar++)
> > +		rnpgbe_clear_rar(hw, rar);
> > +
> > +	if (netdev->flags & IFF_PROMISC) {
> > +		filter_ctrl |= RNPGBE_RX_FILTER_UCAST_ALL |
> > +			       RNPGBE_RX_FILTER_MCAST_ALL;
> > +	} else if (netdev->flags & IFF_ALLMULTI) {
> > +		filter_ctrl |= RNPGBE_RX_FILTER_MCAST_ALL;
> > +	} else {
> > +		/* The MTA index is the 12 address bits from 36 through 47. */
> > +		netdev_for_each_mc_addr(ha, netdev) {
> > +			hash = ((ha->addr[4] & 0xf) << 8) | ha->addr[5];
> > +			mcast_hash[hash >> 5] |= BIT(hash & 0x1f);
> > +		}
> > +
> > +		if (!netdev_mc_empty(netdev))
> > +			mcast_ctrl |= RNPGBE_RX_MCAST_HASH_EN;
> > +	}
> > +
> > +	for (i = 0; i < RNPGBE_RX_MCAST_HASH_ENTRIES; i++)
> > +		mucse_hw_wr32(hw, RNPGBE_RX_MCAST_HASH(i), mcast_hash[i]);
> > +
> > +	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
> > +	mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
> > +}
> 
> [Severity: Medium]
> RNPGBE_RX_RAR_VALID lives in the HIGH register, and both helpers
> touch that register last.  rnpgbe_clear_rar() zeroes
> RNPGBE_RX_RAR_LOW(index) while the entry is still marked valid, so
> between the two writes the filter matches the old addr[0], addr[1]
> followed by four zero bytes.  rnpgbe_set_rar() has the mirror image
> of the same problem when it overwrites an entry that is already
> valid: rar_low is programmed first, so for that window the entry
> matches the new addr[2..5] against the stale addr[0..1] - an address
> that was never configured on this interface.
> 
> This is not confined to teardown.  rnpgbe_set_rx_mode() reprograms
> the whole table from scratch on every invocation, walking RAR 0
> through RNPGBE_RX_RAR_ENTRIES - 1 with rnpgbe_set_rar() and
> rnpgbe_clear_rar(), and it is called on every unicast/multicast list
> change as well as from rnpgbe_configure() after RX has been started,
> so the window is hit routinely while the MAC is receiving.
> 
> The conventional ordering is to drop the valid bit before touching
> the address bytes: see ixgbe_clear_rar(), which writes
> IXGBE_RAH(index) with IXGBE_RAH_AV cleared first and only then sets
> IXGBE_RAL(index) to 0.
> 
> Does this hardware latch the RAR pair on the HIGH write, so that the
> LOW value has no effect until HIGH is written?  If it does, a short
> comment saying so would settle the question; if it does not, clearing
> RNPGBE_RX_RAR_VALID first in both helpers looks like the right fix.
> 
The RAR valid bit only controls address comparison; it does not latch the
RAR pair. I will clear VALID before updating or clearing the address fields,
and set it again only after the complete new address has been programmed

Thanks for your feedback.
