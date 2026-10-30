Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329204;
	b=URXkAwHHqEUr12Jplgv0zhnteSnFhSAkIqItPkOXEUSIndsVV9OQyfjqfy27TGBHoVNa
	 LAYYZMhCmB967WpEnJzGYoW59gjr5SPFFROcMVu7ke3/25qqCcIdtKhhNNoKrKntA5vwJ
	 ewF0tzB+VfVSIRpaXUJhqC4aDFzlw/ePwBdzOokUYYwtmaYFiBb0VZYeOU6Jft2DnCaVP
	 slzZSK2979fh0MW7c5MYwCx+0ZqYnRPNhzU6TZfYTsIFWcKwTEHxttMxDz+90hmRJjW0B
	 1GjbDy7JWL/isTQm0S4V5hAX25ezxYOjueb/WyT9zUEVRK+p20TDuwr5zR317638wgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329204;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hq/4YWC1b796zdvcvOcwCEmulCT+xUiahOe+NXgkySI=;
	b=Z+ObOQ4azSHy6ndMnoOEMnnD9CrtyLa+u/0ZdgzVw1/IJUgt7+c1xbteFFHRvqBFM4ya
	 vuNNl/b6l/SVS/suAgyxezfmpUWw0IsFY15uA3/P8ri9xz5n1AcLY49EnqOoQtz2QithI
	 f1uaIGxG4/2MQuz1tVz9uIVYwnzLdAphNrYAbqfIX0VeBXaWcnCmkAjeaSZbVDq3Gu29s
	 tEO+670GtQlAa4h66nlJfyMHjM0mIZNXirekxZ5Wg1T8X7b3Zg072Qzn2cl/XbyS27+aL
	 ATIjBrGTDBncVRPsoBgLu/I+RYDEwj1BO1ZhVIyekcTrneeMXhn1NfbJ9wnc6PJfNTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l4XMUV5j;
	arc=none smtp.remote-ip=95.215.58.71
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADF606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1ADF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l4XMUV5j
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p+cl6/IcAPPzRu6xYDnXuIfufAoXhxeNqlv/DOQSqyM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793329201; v=1; x=1793934001;
 b=l4XMUV5jqgBgZ6CG2vgItAxTbvy4TLETZ5ePvpddf2tKiLKZpRi7XkE5fy/MHXDcOrJEwTYX
 s7D2GTbSX0tv8bWxVfFOjOzT4h1oNrlQaz3Yif3cUIoeARSP65Gb5R0W3+hpQf1EZlSQDt7LGLi
 VAAvBT08ehqwOvtR7ehSqa1M=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id db5584a886e22652;
	Fri, 30 Oct 2026 03:00:01 +0000
X-Mizu-Trace-ID: db5584a886e22652
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 10:59:51 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: ramses@well-founded.dev
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Eric Dumazet <edumazet@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net v4 1/2] bonding: fix initial last_rx vs ARP-monitor
 slack window
Message-ID: <auQIJ731irNtKSFI@bogon>
References: <20261028-bonding-last-rx-v4-0-4d8e4cd47467@well-founded.dev>
 <20261028-bonding-last-rx-v4-1-4d8e4cd47467@well-founded.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-bonding-last-rx-v4-1-4d8e4cd47467@well-founded.dev>

On Wed, Oct 28, 2026 at 12:48:07PM +0100, Ramses de Norre via B4 Relay wrote:
> From: Ramses de Norre <ramses@well-founded.dev>
> 
> bond_enslave() seeds a new slave's last_rx so that the ARP monitor does
> not report it UP before a real ARP reply arrives, see commit
> f31c7937c254 ("bonding: start slaves with link down for ARP monitor").
> 
> The seed is one arp_interval (plus a tick) in the past. That was old
> enough when the up test was "jiffies <= last_rx + arp_interval". Commit
> da210f559019 ("bonding: add some slack to arp monitoring time limits")
> added arp_interval/2 of slack to that test without moving the seed, so
> the seed now falls inside the up window. For the first half interval
> after enslavement, bond_ab_arp_inspect() proposes a slave that starts
> DOWN as UP although it has received nothing. The up test always uses a
> single interval, so this does not depend on primary_reselect or
> arp_missed_max.
> 
> If that slave is the configured primary, force_primary makes it the
> active slave. ARP validation fails it shortly after (on SFP+ ports the
> PHY is often still negotiating) and the bond falls back to the backup.
> With primary_reselect=always the bond recovers once the port really
> comes up, but drops traffic until then. With primary_reselect=failure,
> force_primary is spent and the bond stays on the backup.
> 
> Reproducer:
> 
>   ip link add bond0 type bond mode active-backup arp_interval 1000 \
>       arp_validate all arp_ip_target 192.0.2.1 \
>       primary eth0 primary_reselect failure
>   # eth0: SFP+ (slow link-up), eth1: RJ45 (fast link-up)
>   ip link set eth0 master bond0
>   ip link set eth1 master bond0
>   ip link set bond0 up
>   # bond0 lands on eth0 via force_primary, ARP-fails it before the
>   # SFP+ has carrier, falls to eth1, and stays there.
> 
> Move the seed below the initial link state and seed a slave that starts
> DOWN two intervals in the past, outside the up window. A slave that
> starts UP keeps its current seed: the up test does not apply to it, and
> an older seed would only bring its down deadline forward by one
> interval. The initial link state is unchanged.
> 
> Fixes: da210f559019 ("bonding: add some slack to arp monitoring time limits")
> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
> ---
>  drivers/net/bonding/bond_main.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8e..bfa4cb97e647c 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2122,13 +2122,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  	if (res && bond_needs_speed_duplex(bond))
>  		new_slave->link = BOND_LINK_DOWN;
>  
> -	new_slave->last_rx = jiffies -
> -		(msecs_to_jiffies(bond->params.arp_interval) + 1);
> -	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
> -		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
> -
> -	new_slave->last_tx = new_slave->last_rx;
> -
>  	/* check for initial state */
>  	new_slave->link = BOND_LINK_NOCHANGE;
>  	if (bond->params.miimon) {
> @@ -2159,6 +2152,22 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  
>  	if (new_slave->link != BOND_LINK_DOWN)
>  		new_slave->last_link_up = jiffies;

Nit: This part could move down and merge with the "else" part.

> +
> +	/* The ARP monitor's up test includes arp_interval/2 of slack, see
> +	 * bond_time_in_interval(). Seed a slave that starts DOWN outside
> +	 * that window, so it stays DOWN until a real reply arrives.
> +	 */
> +	if (new_slave->link == BOND_LINK_DOWN)
> +		new_slave->last_rx = jiffies -
> +			(2 * msecs_to_jiffies(bond->params.arp_interval) + 1);
> +	else
> +		new_slave->last_rx = jiffies -
> +			(msecs_to_jiffies(bond->params.arp_interval) + 1);
> +	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++)
> +		new_slave->target_last_arp_rx[i] = new_slave->last_rx;
> +
> +	new_slave->last_tx = new_slave->last_rx;
> +
>  	slave_dbg(bond_dev, slave_dev, "Initial state of slave is BOND_LINK_%s\n",
>  		  new_slave->link == BOND_LINK_DOWN ? "DOWN" :
>  		  (new_slave->link == BOND_LINK_UP ? "UP" : "BACK"));
> 
> -- 
> 2.56.0
> 
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
