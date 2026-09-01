Received: from mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6647AF66
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788257203; cv=none; b=pZiCxedPtfzqklVFaMxpXhVcKaUZXwhHEoj+dn8zhxc8QSXEJk8OzNi9DllDFpNrOdXtMUULoRHJ81KpGYZot94DjwwDiecfP0GOOa/iNryBb+6qwtMIlha9ogxTS2HfVKnw+94ryZxycXDLk7T04kziGIJaBUCSA6nWSUC1g0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788257203; c=relaxed/simple;
	bh=hvgjdps/TihSmTabsE5QrskZ4Q0ejDbhhbVKTu2Na8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0F7GyXyPllu5hxZ0pxkN1oDjGaYrJ+7amwNbRg3VuTU7mmeKjLKNg+9SKOHWNW2w7cP3bIaFRaOpxYeqI8uNGT2TzFA4wItWapGJKVNbPyWdsNV+SKR8drkhJAJIdy5MQxWKb6zXh3n5KyweddWOSoRsuvmgxZgCoHvF8IzP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpUJ957O; arc=none smtp.client-ip=91.218.175.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpUJ957O"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hvgjdps/TihSmTabsE5QrskZ4Q0ejDbhhbVKTu2Na8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788257199; v=1; x=1788861999;
 b=rpUJ957OqVFc/cigQoiODU5lH2at1bhlBUWxaNV3H4Nw0I+/XAPSl08nIS3AYMLJD/SOY38/
 GEhyrMYtDBB+LvOmjXEqx8/i8cT+KApyoILtpp1rkXIAPhH8GMyUOMkByjRCUEpXg7mDEbaPuZi
 82PXAOUPggLErOkh6OcFMgLs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 48c4bda9c4b02c5b;
	Tue, 01 Sep 2026 10:06:38 +0000
X-Mizu-Trace-ID: 48c4bda9c4b02c5b
X-Migadu-Flow: FLOW_OUT
Date: Tue, 1 Sep 2026 18:06:31 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Tonghao Zhang <tonghao@bamaicloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>
Subject: Re: [PATCH net] bonding: avoid ARP flood on RTNL contention in
 active-backup mode
Message-ID: <apajp0rQT8wwFx3Z@fedora>
References: <20260831090937.3342052-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831090937.3342052-1-edumazet@google.com>

On Mon, Aug 31, 2026 at 09:09:37AM +0000, Eric Dumazet wrote:
> Commit f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one
> fail") changed bond_activebackup_arp_mon() to reschedule arp_work in
> 1 tick if the second rtnl_trylock() fails (for sending peer/slave
> notifications).
> 
> However, by the time bond_activebackup_arp_mon() reaches this second lock
> check, bond_ab_arp_probe() has already been executed and sent an ARP probe.
> If RTNL remains contended, rescheduling every 1 tick causes
> bond_activebackup_arp_mon() to re-execute bond_ab_arp_probe() every jiffy,
> flooding the network with ARP probes at HZ frequency (e.g. 1000 pkts/sec)
> instead of respecting the configured arp_interval.
> 
> If rtnl_trylock() fails at the second check, do not change delta_in_ticks
> to 1 so that the next ARP monitor execution is scheduled according to the
> configured arp_interval, matching the behavior in
> bond_loadbalance_arp_mon().
> 
> Fixes: f1986b3a9f2e ("net: bonding: skip the 2nd trylock when first one fail")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Tonghao Zhang <tonghao@bamaicloud.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> ---
>  drivers/net/bonding/bond_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index ef9eb0c53c66..c23cf18a996a 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3871,10 +3871,8 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
>  	rcu_read_unlock();
>  
>  	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
> -		if (!rtnl_trylock()) {
> -			delta_in_ticks = 1;
> +		if (!rtnl_trylock())
>  			goto re_arm;
> -		}
>  
>  		if (bond->send_peer_notif)
>  			bond_peer_notify_may_events(bond, true);
> -- 
> 2.55.0.897.gb25b4bd76c-goog
> 

Thanks for the fix.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
