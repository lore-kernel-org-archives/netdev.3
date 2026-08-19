Received: from mta0.migadu.com (out-243.mta0.migadu.com [91.218.175.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4596282F26
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787105247; cv=none; b=ODCAz/wYr/dtwhjGz5ULFMBrnK4aWt8OXZIRNwgfdJWqyS2gyO7z61XVY+AUmdFWf33JZ3CM5cXXFGawwvI6nqN5YIT2iDEeHLvyXfLECdv5QzSbWSowl9c/HliWP0ZXFZQrFh96PwsJQJsSNdaaZGpT4ZyUkFxDV+aUw5eqAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787105247; c=relaxed/simple;
	bh=BW+3hsCCLau5i5wnXi/cTTMAsl/Q7NqkA3vzta9zCBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2kmvK1fZzD7BqrQ/xaG2ChQeVNmZACSKzax/LjCi4xTV5w/SwaQTwehPnVkr0jRJrZY8paIEt898FMUylnKghVPJmaz4yAm5QcrdL1D81Z+1GY7LXK00myHjIimWo84bdKn6X96aJ4Yuy3RSe09Oio67UUtND2Ax99T97+U/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J4f2RUWq; arc=none smtp.client-ip=91.218.175.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J4f2RUWq"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BW+3hsCCLau5i5wnXi/cTTMAsl/Q7NqkA3vzta9zCBY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787105242; v=1; x=1787710042;
 b=J4f2RUWqo09E66XvhOpUXlaFNEVASRYbQP100I+b/49hL7ZEK9J05JHaI63D/D8yNvKMSDmV
 onJKBpR3SbRAyERWC2wsa3yFNnDMzeedm7QBbxWvCgFX4mYJrcxD77FR9ZGjY+PgJNZmFXqjDpV
 RlOrFFMaVRx7SreyRFtVdRYo=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id f5bed5f7b8ab5953;
	Wed, 19 Aug 2026 02:07:22 +0000
X-Migadu-Flow: FLOW_OUT
Date: Wed, 19 Aug 2026 10:07:14 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <aoUP0sLeEhCPxukB@fedora>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
 <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
 <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>

Hi Nikolay,
On Tue, Aug 18, 2026 at 02:51:31PM +0300, Nikolay Aleksandrov wrote:
> > > > @@ -1344,8 +1355,14 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
> > > >       if (!tx_slave) {
> > > >           /* unbalanced or unassigned, send through primary */
> > > >           tx_slave = rcu_dereference(bond->curr_active_slave);
> > > > -        if (bond->params.tlb_dynamic_lb)
> > > > -            this_cpu_add(bond_info->unbalanced_load->tx_bytes, skb->len);
> > > > +        if (bond->params.tlb_dynamic_lb) {
> > > > +            struct unbalanced_load_stats *pcpu_load;
> > > > +
> > > > +            pcpu_load = this_cpu_ptr(bond_info->unbalanced_load);
> > > > +            u64_stats_update_begin(&pcpu_load->syncp);
> > > > +            u64_stats_add(&pcpu_load->tx_bytes, skb->len);
> > > > +            u64_stats_update_end(&pcpu_load->syncp);
> > > 
> > > this still races with...
> > > 
> > > > +        }
> > > >       }
> > > >       if (tx_slave && bond_slave_can_tx(tx_slave)) {
> > > > @@ -1529,19 +1546,28 @@ netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
> > > >       return bond_do_alb_xmit(skb, bond, tx_slave);
> > > >   }
> > > > -static u32 reset_unbalanced_load(struct alb_bond_info *bond_info)
> > > > +static u64 reset_unbalanced_load(struct alb_bond_info *bond_info)
> > > >   {
> > > >       struct unbalanced_load_stats *p;
> > > > -    u32 total_bytes = 0;
> > > > +    u64 tx_bytes, total_bytes = 0;
> > > > +    unsigned int start;
> > > >       int i;
> > > >       for_each_possible_cpu(i) {
> > > >           p = per_cpu_ptr(bond_info->unbalanced_load, i);
> > > > -        total_bytes += READ_ONCE(p->tx_bytes);
> > > > -        WRITE_ONCE(p->tx_bytes, 0);
> > > > +        do {
> > > > +            start = u64_stats_fetch_begin(&p->syncp);
> > > > +            tx_bytes = u64_stats_read(&p->tx_bytes);
> > > > +        } while (u64_stats_fetch_retry(&p->syncp, start));
> > > > +
> > > > +        u64_stats_update_begin(&p->syncp);
> > > > +        u64_stats_set(&p->tx_bytes, 0);
> > > > +        u64_stats_update_end(&p->syncp);
> > > 
> > > ... this here, as u64_stats_update_begin doesn't provide exclusive access, so writers
> > > must do that themselves, so you can't be sure what value will end up, the zeroing
> > > might not work at all and can get overwritten
> > > 
> > 
> > I meant - it doesn't improve on the current situation where it can also happen. :)

Ah, yes. I forgot this. The reset_unbalanced_load() could be called on any
CPU, which conflicts with other writers.

I re-checked the code. unbalanced_load is only called in two situations:
1. To rebalance the load in bond_alb_monitor(), which only executes once
   every 10 seconds.
2. !tx_slave in bond_do_alb_xmit(), which is only for multicast/broadcast
   traffic. This traffic shouldn't be significant.

So looks using spin_lock here is acceptable. What do you think?

> > 
> 
> Sorry for the multiple replies, but thinking about this - having multiple concurrent
> writers could cause write tearing for 32-bit architectures (the monitor is a writer
> and can write concurrently with tx) leading to invalid result.

Never mind. A detailed explanation is always welcome. I really appreciate
your review and comments.

Best Regards
Hangbin
