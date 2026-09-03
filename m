Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841DA4052DA
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428547; cv=none; b=CPLVWYYULuw1zr0edrV6FZehoRjKaWGK8L6u6+AdoOhlMRaT/U6Tz7xZy3FqxXdmwQXDWHlq9IXNBQfEkPaIl16+myzDotWg9Tlp4jdlHKLEOzog3C82DyRWtdLCJnniI4fEgmqv2KPoXCl559aiHklHd09UFcogxrnRGLeOiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428547; c=relaxed/simple;
	bh=Vxp9ZHlgNpAzBAfB4yGSmAaUvFpdlujsbCNr92pOTdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bARpNddQJ/Rzqvx9sV2GKfYv5YfcHI0bOL6Em8xaWKALLYcKXn7oCGwVJ3jDlho2QV4zY+s6pNOZSKhMXPk2/tbdMOlNIezkdsr0LfhuvVGLrFUhjoLPw3Epqd8+x69k313Q5eShZMiGBNFXBdvXDv08SzFT1OmhPqQeEBwh2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vXu4j8Ll; arc=none smtp.client-ip=91.218.175.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vXu4j8Ll"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vxp9ZHlgNpAzBAfB4yGSmAaUvFpdlujsbCNr92pOTdg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788428543; v=1; x=1789033343;
 b=vXu4j8LlTDjKEa3PGJWUvJKUbtUQta8g4HK4mNmTvrvwKaJmxdLKfyAD0/GfVESi1V+6sF/0
 ezcRYDnIoTTBv9nURRlZaQnee59RT06N+LhQ88hnYmndSi1iBJvE6cmSh+GtJbxiBuC9si2Rkyr
 mPHHYfamLrIDvgyt5n0jwFbg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 795b0095eeb9568e;
	Thu, 03 Sep 2026 09:42:23 +0000
X-Mizu-Trace-ID: 795b0095eeb9568e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 17:42:11 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Jay Vosburgh <jv@jvosburgh.net>
Subject: Re: [PATCH net] bonding: use skb_cow_head() in bond_do_alb_xmit()
 and rlb_arp_xmit()
Message-ID: <aplA83k_kZIi1k7w@fedora>
References: <20260902125809.2910366-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902125809.2910366-1-edumazet@google.com>

On Wed, Sep 02, 2026 at 12:58:09PM +0000, Eric Dumazet wrote:
> In bond_do_alb_xmit() and rlb_arp_xmit(), make sure to unclone
> skb head via skb_cow_head() before modifying the source MAC address
> (Ethernet header and ARP payload) to avoid silent corruption if
> the skb is shared or cloned. Avoid caching the header pointers
> across skb_cow_head().
> 
> In rlb_arp_xmit(), also check that
> tx_slave != rcu_access_pointer(bond->curr_active_slave)
> before modifying arp->mac_src. When tx_slave is the active slave,
> arp->mac_src already matches its hardware address, so we can avoid
> an unnecessary copy and head reallocation.
> 
> Also, we should not assume mac header is set in output path.
> 
> Use skb_eth_hdr() instead of eth_hdr() to fix the issue,
> and remove now redundant skb_reset_mac_header() calls.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> ---
>  drivers/net/bonding/bond_alb.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 654f051d0023929a48536c378996e0ef39b75d88..5f750f08a144791589b5ed0f44b1b68ab99e6e61 100644
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
>  		netdev_dbg(bond->dev, "(slave %s): Server sent ARP Reply packet\n",
>  			   tx_slave ? tx_slave->dev->name : "NULL");
>  	} else if (arp->op_code == htons(ARPOP_REQUEST)) {
> @@ -1340,7 +1344,6 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
>  				    struct slave *tx_slave)
>  {
>  	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
> -	struct ethhdr *eth_data = eth_hdr(skb);
>  
>  	if (!tx_slave) {
>  		/* unbalanced or unassigned, send through primary */
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
>  
> @@ -1375,8 +1380,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
>  	struct ethhdr *eth_data;
>  	u32 hash_index;
>  
> -	skb_reset_mac_header(skb);
> -	eth_data = eth_hdr(skb);
> +	eth_data = skb_eth_hdr(skb);
>  
>  	/* Do not TX balance any multicast or broadcast */
>  	if (!is_multicast_ether_addr(eth_data->h_dest)) {
> @@ -1428,8 +1432,7 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
>  	u32 hash_index = 0;
>  	int hash_size = 0;
>  
> -	skb_reset_mac_header(skb);
> -	eth_data = eth_hdr(skb);
> +	eth_data = skb_eth_hdr(skb);
>  
>  	switch (ntohs(skb->protocol)) {
>  	case ETH_P_IP: {
> -- 
> 2.55.0.966.g6673acef38-goog
> 

Looks reasonable to me. Thanks!

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
