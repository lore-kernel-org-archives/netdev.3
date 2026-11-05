Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793861048;
	b=vJYhVgk8FmyfVCDABnJKFx27Z3XympWzKdqJbI/hs5hIWQv8gnArbdLdoE7SgoJ94Nlm
	 c527o7knz6lHUoWRnydIr0rlxgnvGvXooMKBZ+czesqXogsHP/CHftik85CHo+qOsCNoZ
	 LxhX/RmonZ+5+zn8l3hGuv6n8/FrW/1c/uUr8YuqLCi/0tL0Kb23y6v5DaI0ZeR3hkfuT
	 lLj8dMpJ3ZnZlA5FRWyMzPgMzcyWKbY3hO1woHU1ZJTIAcPuLiEtsuJjwVIHXRN5vJjIu
	 WKCzMBwaGDrEZ4ujZD/J2L2iHDdu9F8sRgrMglakoQy6+q21FisRHcu9OsxNEe7W0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793861048;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CrKc9DfO0oB6G1+crXqAff0+L0ilSXeK3hIK0jKgHi8=;
	b=XZFa7rbkwMNs3SWS//ByoKlLuW1MZhJW0NF8ri0CtPVNW9Y0gQCmyhqQkg4mUXNFk/fn
	 LQwCep4o5TAQhr1/PcJzdzYqB7tIR858JcDdA/ADsx4rvi2rQ9wD4TR38m/A29WIX/zZf
	 SKsndMvgAKD78yypjzIUYORGlJNV8UU9d/tgPRyCBABO0NH1tdsQrIP3xzBc5ZNv2PQJv
	 7cSIC1hLCEztq6OdezGJ0iqucmjvBJoqA+Sv4rKk2FAVTai8aMNC9XkqJxbb4nLxZXPSX
	 dw31C2NwlWFhQQTkD517KLQKZSVdliW5f63eGSQGhLIB+4a2j65k/38mcE4raWBHDNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BoztfJzN;
	arc=none smtp.remote-ip=95.215.58.71
Received: from mta1.migadu.com (out-71.mta1.migadu.com [95.215.58.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EE606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 06:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC6EE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BoztfJzN
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AJvSBmpuKsm2r9LIYiiIAUw+HB9piFiuKi7K/Txgm7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793861045; v=1; x=1794465845;
 b=BoztfJzNPiVh+7x92vF4NWxOwffKnY+NxmzoebKLg2ETMEZH02hgpbQjKkL7kDxH5K5GAfhq
 dtbEMSxr1cwYrTApsARnNj1Qa2S9hV57KAi/Hc2BOOygnYTJBKuFJWcsYI2XdruGSTd89QoET0q
 xIMlsP69PW7IBKyM3vLxcJ/Q=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0b95db6ca7641e0f;
	Thu, 05 Nov 2026 06:44:05 +0000
X-Mizu-Trace-ID: 0b95db6ca7641e0f
X-Migadu-Flow: FLOW_OUT
Date: Thu, 5 Nov 2026 14:43:52 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] bonding: fix missing down path on speed/duplex
 failure after FAIL->UP
Message-ID: <auwlqK01oV5jfwWW@fedora>
References: <20261101150240.66292-1-timur.stukan.linux@gmail.com>
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
In-Reply-To: <20261101150240.66292-1-timur.stukan.linux@gmail.com>

On Sun, Nov 01, 2026 at 05:02:39PM +0200, Timur Stukan wrote:
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
> Fix this by dropping the loop in bond_mii_monitor() that applied all
> proposed link states before bond_miimon_commit(). bond_miimon_commit()
> now applies each state itself: UP after the speed/duplex check, as it
> already did, DOWN in the down path, and FAIL/BACK directly. So when the
> speed/duplex check runs, slave->link still holds the previous state. If
> the check fails for a slave that is FAIL or UP, take it through the
> regular down path, including failover. DOWN and BACK slaves were
> never brought up and are still just reverted to DOWN. The down path is
> moved into bond_miimon_slave_down() so both callers share it.
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
>     Changes in v3:
>     - Drop the loop in bond_mii_monitor() and apply FAIL/BACK in
>       bond_miimon_commit() with bond_commit_link_state() (Jay, Hangbin)
>     - Also take the full down path for a slave that is already UP when
>       the speed/duplex update fails (Sashiko)
>     - The 802.3ad notifier issue reported by Sashiko is fixed separately:
>       https://lore.kernel.org/netdev/20261101145653.63648-1-timur.stukan.linux@gmail.com/
>     - v2: https://lore.kernel.org/netdev/20261028104758.299129-1-timur.stukan.linux@gmail.com/
>     
>     Changes in v2:
>     - Drop link_prev_state. Instead, don't commit UP proposals in
>       bond_mii_monitor() and let bond_miimon_commit() commit them after
>       the speed/duplex check, so no extra state is needed (Jay)
>     - v1: https://lore.kernel.org/netdev/20261022103821.89552-1-timur.stukan.linux@gmail.com/
> 
>  drivers/net/bonding/bond_main.c | 63 +++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7019e5d8fdc8..d6b6c125470f 100644
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
> @@ -2807,10 +2828,22 @@ static void bond_miimon_commit(struct bonding *bond)
>  			err = bond_update_speed_duplex(slave);
>  			netdev_unlock_ops(slave->dev);
>  			if (err && bond_needs_speed_duplex(bond)) {
> -				slave->link = BOND_LINK_DOWN;
>  				if (net_ratelimit())
>  					slave_warn(bond->dev, slave->dev,
>  						   "failed to get link speed/duplex\n");
> +				/* Coming from FAIL/UP, the slave may still be
> +				 * in use and may be curr_active_slave, so take
> +				 * it through the full down path. Coming from
> +				 * DOWN/BACK, it was never brought up, so just
> +				 * revert it to DOWN.
> +				 */
> +				if (slave->link == BOND_LINK_FAIL ||
> +				    slave->link == BOND_LINK_UP) {
> +					if (bond_miimon_slave_down(bond, slave))
> +						do_failover = true;
> +					continue;
> +				}
> +				slave->link = BOND_LINK_DOWN;
>  				continue;
>  			}
>  			bond_set_slave_link_state(slave, BOND_LINK_UP,
> @@ -2839,28 +2872,13 @@ static void bond_miimon_commit(struct bonding *bond)
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
>  		case BOND_LINK_BACK:
> +			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
>  			slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
>  				  slave->link_new_state);
>  			continue;
> @@ -2894,8 +2912,6 @@ static void bond_mii_monitor(struct work_struct *work)
>  {
>  	struct bonding *bond = container_of(work, struct bonding,
>  					    mii_work.work);
> -	struct list_head *iter;
> -	struct slave *slave;
>  	unsigned long delay;
>  	bool commit;
>  
> @@ -2917,13 +2933,8 @@ static void bond_mii_monitor(struct work_struct *work)
>  			goto re_arm;
>  		}
>  
> -		if (commit) {
> -			bond_for_each_slave(bond, slave, iter) {
> -				bond_commit_link_state(slave,
> -						       BOND_SLAVE_NOTIFY_LATER);
> -			}
> +		if (commit)
>  			bond_miimon_commit(bond);
> -		}
>  
>  		if (bond->send_peer_notif)
>  			bond_peer_notify_may_events(bond, true);
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
