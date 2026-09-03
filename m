Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945504B0CBF
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444582; cv=none; b=bNy5OqPn8wmiJhzs4UjON49pMlvzgV1e7r/7U3U3cGdI7HW69dmNl3+wGlqZPJNSitr5EOFJYBWnbedqySJD1WCUO75rHRL+IpO1vD5ytKTjg6CweZK2CSwbH03ZY7ZCe1W+DZ8rZloKGH1bD5/i6L2jVFn+DbfaJ+nb62/RqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444582; c=relaxed/simple;
	bh=9eP6sRHHIYHbk2l92ruUWjH8yhzSt82UzA7vaL409lA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=enVufBtibjlIwpkj9d36Y5fHnpmg9GAVlOXKXM1XdsuyEQLOBvq5a7CbnS47z/SB3vEWqI0ktDkgbblS94UCnRwR/2D9hBA7K5QoRmXVvYDaU058GWFnf8usqmk0xrt7FF7BEfjaRoyqo3qlarq9mxinpHY/oHTErhbMVS6G9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHvecmbR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHvecmbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E311F00AC4;
	Thu,  3 Sep 2026 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444576;
	bh=pz0utapClilhPvCvFjabifjHUhUyxNooV4aXV8dFLxU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZHvecmbRGCoL8Kzo+1TMyrj7qj/XqdtUGRPq+cflY1vDmo3hPO8MqpIhZjqGaGIb9
	 vLGz6hNdUcUSWSd8B7XBpFIxfRHNf1TCckw3NRRE/3WFXUglO6Y9O4mIOhIt94I3dl
	 EjgsR0vm8Cgg7sFuqbatJLSMrGn1bXMcGSmkHhMCXmWFZTYtLDyfPeGiAPUyRKs7sr
	 2+3FTnfNC58vrPpX+FD4Tzg3pcgvgbCL8h37Bz0gNFs7NHsvMwUZYLfUjz+7Fpr1Rl
	 Xli2Q0WeqkU25t1IRCwaeZp8uOoTVCHbLa30d6AY9Xt3HBqPJUU3BcL3WdMtOIWavj
	 nFgwgsCUzb64Q==
Subject: Re: [net] bonding: use skb_cow_head() in bond_do_alb_xmit() and
 rlb_arp_xmit()
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 jv@jvosburgh.net
Date: Thu, 03 Sep 2026 14:09:35 +0000
Message-ID: <178844457550.3394541.1019645216778443244@kernel.org>
In-Reply-To: <20260902125809.2910366-1-edumazet@google.com>
References: <20260902125809.2910366-1-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] In `rlb_arp_xmit()` (drivers/net/bonding/bond_alb.c:681) the
  patch adds `tx_slave != rcu_access_pointer(bond->curr_active_slave)`…

--

bonding: use skb_cow_head() in bond_do_alb_xmit() and rlb_arp_xmit()

This adds skb_cow_head() before rewriting the source MAC in the Ethernet
header and in the ARP payload, stops caching header pointers across the
cow, and switches to skb_eth_hdr() so the mac header offset is not assumed
to be set in the output path.  It also adds a new condition so that
arp->mac_src is only rewritten when tx_slave is not the current active
slave.

> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 654f051d0023..5f750f08a144 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -678,9 +678,13 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
>  	if (arp->op_code == htons(ARPOP_REPLY)) {
>  		/* the arp must be sent on the selected rx channel */
>  		tx_slave = rlb_choose_channel(skb, bond, arp);
> -		if (tx_slave)
> +		if (tx_slave && tx_slave != rcu_access_pointer(bond->curr_active_slave)) {
> +			if (unlikely(skb_cow_head(skb, 0)))
> +				return NULL;
> +			arp = (struct arp_pkt *)skb_network_header(skb);
>  			bond_hw_addr_copy(arp->mac_src, tx_slave->dev->dev_addr,
>  					  tx_slave->dev->addr_len);
> +		}

[Severity: Medium]
The changelog states:

  "When tx_slave is the active slave, arp->mac_src already matches its
  hardware address, so we can avoid an unnecessary copy and head
  reallocation."

Is that invariant actually established anywhere in rlb_arp_xmit()?  The only
check applied to arp->mac_src earlier in the function is:

  if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
          return NULL;

and bond_slave_has_mac_rcu() in include/net/bonding.h matches any slave, not
just the active one:

  bond_for_each_slave_rcu(bond, tmp, iter)
          if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
                  return true;
  return false;

In balance-alb each slave has a distinct MAC, so an ARP reply whose sender
MAC is a non-active slave's MAC passes this filter (for example an injected
reply via AF_PACKET with CAP_NET_RAW, or an upper VLAN whose MAC was set to a
slave MAC).

Can rlb_choose_channel() then return curr_active_slave for such a packet?  It
picks the channel independently of arp->mac_src, either via the existing
client entry:

  assigned_slave = client_info->slave;
  if (assigned_slave) {
          spin_unlock(&bond->mode_lock);
          return assigned_slave;
  }

or via __rlb_next_rx_slave(), which walks all transmitting slaves including
the active one:

  bond_for_each_slave_rcu(bond, slave, iter) {
          if (!bond_slave_can_tx(slave))
                  continue;

With the new gate, the rewrite is skipped in that case, so the ARP reply goes
out advertising a MAC that is not the RX channel just recorded in
client_info->slave.  Does the peer then steer return traffic to a slave the
RLB accounting believes is unassigned?  The early return above also leaves
client_info->ntt unset, so no corrective rlb_update_client() ARP is queued.

Note that rlb_update_client(), the other emitter of this field,
unconditionally advertises the assigned slave's address:

  skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
                   client_info->ip_dst,
                   client_info->slave->dev,
                   client_info->ip_src,
                   client_info->mac_dst,
                   client_info->slave->dev->dev_addr,
                   client_info->mac_dst);

so the two paths now disagree about what mac_src should contain.

There is also a failover window.  The comparison is done under
rcu_read_lock() only, since bond->mode_lock is dropped inside
rlb_choose_channel(), while bond_alb_handle_active_change() publishes the new
active slave before the MAC swap:

  /* curr_active_slave must be set before calling alb_swap_mac_addr */
  if (swap_slave) {
          /* swap mac address */
          alb_swap_mac_addr(swap_slave, new_slave);

During that window, can tx_slave == curr_active_slave hold while the slave
MACs have not been swapped yet, making the skipped rewrite wrong even for a
normally generated ARP reply?

Would a value comparison be a safer way to express this optimization, for
example:

  if (tx_slave &&
      !ether_addr_equal_64bits(arp->mac_src, tx_slave->dev->dev_addr)) {

That keeps the fast path when the field already holds the right address
without relying on the pointer identity of curr_active_slave.

[ ... ]

> @@ -1351,7 +1354,9 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>  
>  	if (tx_slave && bond_slave_can_tx(tx_slave)) {
>  		if (tx_slave != rcu_access_pointer(bond->curr_active_slave)) {
> -			ether_addr_copy(eth_data->h_source,
> +			if (unlikely(skb_cow_head(skb, 0)))
> +				return bond_tx_drop(bond->dev, skb);
> +			ether_addr_copy(skb_eth_hdr(skb)->h_source,
>  					tx_slave->dev->dev_addr);
>  		}

Related to the above: this is the same pointer comparison, evaluated later in
the transmit path for the same skb.  If curr_active_slave changes between the
check in rlb_arp_xmit() and this one, can the Ethernet source be rewritten
here while arp->mac_src was left untouched (or the reverse), leaving the two
headers inconsistent with each other?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902125809.2910366-1-edumazet%40google.com
