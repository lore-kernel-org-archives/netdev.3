Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741733;
	b=15b9gKpQR0DjBNVFfGN9lEv61xG0x1IpelDivzOQlAOSIz/m3YVyLH5K/3hIn+5HS1Wh
	 0YAAeqJwumnpoSkvzwxvaVpP0uLZY5Um7hxTN9obDunYbk7gjCqOLX/vyJkabnKJheMdm
	 kx85uirQZVkKG3+AssnXjo2Le17Ml3oysw/X5Tn3oo6Pd4H1NIiEMZlGvksWybGOF4ZWC
	 KseldWDKrwmRbGMQp4ehQkzXamnmA1ar2aNF60TrB34IVi1Ytt5bvpdl3ukogLZHBWTON
	 3WIuwVT+Qbrv8wd4Dnfh1kIR1BZK8/DzvLnc6Zjp+2E+6Jmrwpi4Qd9xwx8OoYhOlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741733;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bfPE62FlLN/egcHfCSCBNP5XR/zJLO5pn7FeFIIyaXI=;
	b=iGPZT1sb64LspFE+BbWZXafgmnHdvAnUIDduczwCAqeGQlrkTLuNLf1XzVJXAMrZiuzL
	 4D6u3LCWANHATXjaHhk98fNe7P8aBgd11qX9+JHTsaRGdAGSTkTiFCpcyDEEXRsdJ6FgG
	 IW5hQunIh8idnWMzFr30uIBT5pXKTfHH0k2KiGaymGn3oKk6Q+Hdbr5u89Bvt47Fmb+Bt
	 YGaSX2FQS6IT1XSjjzrbD0oaYB/mSliY6Iqmq/N0fmpUtL4mI344Q6p3AhQThhcZYziRo
	 jgWSQYcVMgM52c0BSarw6II14tb964sNVMz7Ydyb8muqePuULSk4dgHDOL340yI4LFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=okFutr01;
	arc=none smtp.remote-ip=95.215.58.192
Received: from mta1.migadu.com (out-192.mta1.migadu.com [95.215.58.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA4606A338
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9CA4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=okFutr01
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kQHMs3C0Pwk4XnxoCJ6mEPI/OsvCcahIVnwyiihsmKQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792741730; v=1; x=1793346530;
 b=okFutr01VmDqzjcHjd4gE3d4xUWGajTJ2qfI1UDc9JhVJHwe+I0VcqkLtlOG/pFTyRnmlMgi
 mFqitA+O6TmsFXgnOQJOGqtyNKQMwkerhDz/Z8LuoVJmMTz+cXime6c1MBTMUY1HTyWu0WXpASD
 BXjZBIk+sD2dDKKyxt5glzPU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id a5aea95c2b268905;
	Fri, 23 Oct 2026 07:48:50 +0000
X-Mizu-Trace-ID: a5aea95c2b268905
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 15:48:43 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Message-ID: <atsRW-aYHeB-cEgi@fedora>
References: <20261022103821.89552-1-timur.stukan.linux@gmail.com>
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
In-Reply-To: <20261022103821.89552-1-timur.stukan.linux@gmail.com>

On Thu, Oct 22, 2026 at 01:38:21PM +0300, Timur Stukan wrote:
> In bond_miimon_commit(), when a slave is proposed as BOND_LINK_UP but
> bond_update_speed_duplex() fails in bonding mode that needs speed/duplex
> (802.3ad, tlb, alb), the slave is set to BOND_LINK_DOWN directly. This
> bypasses bond_set_slave_link_state(), bond_miimon_link_change() and
> failover.
> 
> This is fine for slave that coming from BOND_LINK_BACK, which was never
> brought up and is not in use. But since commit 1899bb325149 ("bonding:
> fix state transition issue in link monitoring") the commit phase also
> handles BOND_LINK_FAIL -> BOND_LINK_UP which means a slave that is still
> in use and may be curr_active_slave.
> 
> If the link recovers within downdelay and goes down again before the
> commit phase reads speed/duplex, the slave is silently marked down while
> remaining the active slave in worst cases. In alb/tlb the bond MAC stays
> on the dead port, no failover happens and TLB/RLB state is not cleaned,
> so the bond stops passing traffic until that link comes back even though
> other slaves are up. A non-active slave is affected too, in alb, RLB
> clients assigned to it are not reassigned and become unreachable.
> 
> Reproduced in tlb and alb mode with miimon=100 and downdelay=10000 by
> flapping a slave within downdelay and dropping it again before commit
> (a longer delay was added between inspect and commit to make window
> wider and easier to test):
>   bond0: (slave enp0s3): link status down for interface, disabling it in 10000 ms
>   bond0: (slave enp0s3): link status up again after 3400 ms
>   bond0: (slave enp0s3): failed to get link speed/duplex
> 
> procfs then shows the active slave with "MII Status: down" and "Link
> Failure Count: 0", and all traffic is lost.
> 
> Fix this by recording the link state before the miimon commit and when
> the speed/duplex update fails for a slave coming from BOND_LINK_FAIL,
> taking it through the regular down path, including failover. The
> BOND_LINK_BACK case keeps the current behaviour. The down path is moved
> into bond_miimon_slave_down() so both callers share it.
> 
> After the fix:
>   bond0: (slave enp0s3): failed to get link speed/duplex
>   bond0: (slave enp0s3): link status definitely down, disabling slave
>   bond0: (slave enp0s4): making interface the new active one
> 
> Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
> Signed-off-by: Timur Stukan <timur.stukan.linux@gmail.com>
> ---
> 
> Notes:
>     sizeof(struct slave) grows from 608 to 616 bytes due to padding.
>     I kept link_prev_state next to link/link_new_state for readability;
>     it can be moved into the hole after 'delay' if preferred.
> 
>  drivers/net/bonding/bond_main.c | 53 ++++++++++++++++++++++-----------
>  include/net/bonding.h           |  1 +
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 09aa45d71fab..602ad697a9c2 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2779,6 +2779,27 @@ static void bond_miimon_link_change(struct bonding *bond,
>  	}
>  }
>  
> +static bool bond_miimon_slave_down(struct bonding *bond,
> +				   struct slave *slave)
> +{
> +	if (slave->link_failure_count < UINT_MAX)
> +		slave->link_failure_count++;
> +
> +	bond_set_slave_link_state(slave, BOND_LINK_DOWN,
> +				  BOND_SLAVE_NOTIFY_NOW);
> +
> +	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
> +	    BOND_MODE(bond) == BOND_MODE_8023AD)
> +		bond_set_slave_inactive_flags(slave,
> +					      BOND_SLAVE_NOTIFY_NOW);
> +
> +	slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
> +
> +	bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
> +
> +	return slave == rcu_access_pointer(bond->curr_active_slave);
> +}
> +
>  static void bond_miimon_commit(struct bonding *bond)
>  {
>  	struct slave *slave, *primary, *active;
> @@ -2807,10 +2828,21 @@ static void bond_miimon_commit(struct bonding *bond)
>  			err = bond_update_speed_duplex(slave);
>  			netdev_unlock_ops(slave->dev);
>  			if (err && bond_needs_speed_duplex(bond)) {
> -				slave->link = BOND_LINK_DOWN;

Hmm, this issue only happens when link_state is on

	netif_running(slave->dev) && netif_carrier_ok(slave->dev);

while !netif_device_present. Should we set the link up when device detached?

>  				if (net_ratelimit())
>  					slave_warn(bond->dev, slave->dev,
>  						   "failed to get link speed/duplex\n");
> +				/* Coming from FAIL, the slave is still in
> +				 * use and may be curr_active_slave, so take
> +				 * it through the full down path. Coming from
> +				 * DOWN/BACK, it was never brought up, so just
> +				 * revert it to DOWN.
> +				 */
> +				if (slave->link_prev_state == BOND_LINK_FAIL) {
> +					if (bond_miimon_slave_down(bond, slave))
> +						do_failover = true;
> +					continue;
> +				}
> +				slave->link = BOND_LINK_DOWN;
>  				continue;
>  			}
>  			bond_set_slave_link_state(slave, BOND_LINK_UP,
> @@ -2839,24 +2871,8 @@ static void bond_miimon_commit(struct bonding *bond)
>  			continue;
>  
>  		case BOND_LINK_DOWN:
> -			if (slave->link_failure_count < UINT_MAX)
> -				slave->link_failure_count++;
> -
> -			bond_set_slave_link_state(slave, BOND_LINK_DOWN,
> -						  BOND_SLAVE_NOTIFY_NOW);
> -
> -			if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP ||
> -			    BOND_MODE(bond) == BOND_MODE_8023AD)
> -				bond_set_slave_inactive_flags(slave,
> -							      BOND_SLAVE_NOTIFY_NOW);
> -
> -			slave_info(bond->dev, slave->dev, "link status definitely down, disabling slave\n");
> -
> -			bond_miimon_link_change(bond, slave, BOND_LINK_DOWN);
> -
> -			if (slave == rcu_access_pointer(bond->curr_active_slave))
> +			if (bond_miimon_slave_down(bond, slave))
>  				do_failover = true;
> -
>  			continue;
>  
>  		case BOND_LINK_FAIL:
> @@ -2919,6 +2935,7 @@ static void bond_mii_monitor(struct work_struct *work)
>  
>  		if (commit) {
>  			bond_for_each_slave(bond, slave, iter) {
> +				slave->link_prev_state = slave->link;
>  				bond_commit_link_state(slave,
>  						       BOND_SLAVE_NOTIFY_LATER);
>  			}
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 598d56b1bc97..b2b102946fe1 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -165,6 +165,7 @@ struct slave {
>  	unsigned long target_last_arp_rx[BOND_MAX_ARP_TARGETS];
>  	s8     link;		/* one of BOND_LINK_XXXX */
>  	s8     link_new_state;	/* one of BOND_LINK_XXXX */
> +	s8     link_prev_state; /* one of BOND_LINK_XXXX */
>  	u8     backup:1,   /* indicates backup slave. Value corresponds with
>  			      BOND_STATE_ACTIVE and BOND_STATE_BACKUP */
>  	       inactive:1, /* indicates inactive slave */
> -- 
> 2.43.0
> 

Checking slave->inactive is not enough when user sets all_slaves_active, so
I'm not opposed to adding a new link state. The code looks good to me.
But let's see others opinion.

Thanks
Hangbin
