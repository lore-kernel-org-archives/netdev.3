Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97378388E49
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724298; cv=none; b=EvSollMwCN7UIOrxL0Kg4oSCOPbDfWF/r56O4CkmPbi0h4aZwofEXfmRGfFf9kLbYAjW+rmDLOaqWSYu/IU0uinTTIk8yiDU4zEvkvvj5FfPlsIJ4vAviRPQPQsl4KaUrqEoJ/zA4qrZ8cu5nXQUntOuH/SF922JuIztHuIVjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724298; c=relaxed/simple;
	bh=ZYhtlfAyv5QcpXchoUs/w6jnmX7ZrcYDPgFoVvB1Llk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jloPeBXoisRN0AniJgeEsCkRV8PhahJCs+tRkw11rjFu3Y1dX6njfEu9PkLkQ5Sf/zRlDLbNvNFuCxNkV2r5hPYv6niaZlufx67wCQgybNyV6I7rZb+pv7E3X0SaoRl5HiYGUp6iA4XvK7plmUfLMUyM6S/fz2F5I6nJ5IUx4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PtHr+s6e; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PtHr+s6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=5UL4AHRg7eTCsfTwngl9Yg3urym0noYm7/GfsUVTI4E=;
	b=PtHr+s6evluX+vanmOPW2DOAzxRLwza6XhzzsJ0ZR8ob1LJp8egQIZ0AvMxD5R
	oahvT0qkg5paTxvbEwuiqnx4OONcY7x7dq3YcXbmd3miTseJ+9BB1jbuSyjYY0GN
	Jow8EUCsHD9vKslAF4nH78HcsgaAqXNgzppSyTHtNlrFs=
Message-ID: <42452dab-2e70-41f0-a47b-9b583a7b324d@163.com>
Date: Fri, 18 Sep 2026 17:37:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: 3ad: select a port when the TX array is
 empty
To: netdev-bot+sashiko@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 razor@blackwall.org, maheshb@google.com, netdev@vger.kernel.org
References: <20260915090207.110987-1-luyun_611@163.com>
 <178967896086.22033.11312042231699088896@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <178967896086.22033.11312042231699088896@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXF8pSBq1q00jaBQ--.7825S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uryfCFy8Jw13AF1Duw4Durg_yoW8JFy3Zo
	WfXryfuF47tF15Jw12kryxJa1vgFWkCr1xZr15Xr45tF1IqFWUurWfZ3yDZa9xJF10gF4a
	y34xJF90ya97t3Wrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUbOJ5DUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwxObamqtBlPZtwAA3d


在 2026/9/18 05:02, netdev-bot+sashiko@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 · Medium: 3 · Low: 2
>
> - [High] Lock re-entrancy: bond_3ad_xmit_fallback() adds
>    spin_lock_bh(&bond->mode_lock) to the ndo_start_xmit path…
> - [Medium] New per-packet mode_lock acquisition plus O(nr_slaves) list
>    walks on the 802.3ad transmit path whenever usable_slaves is empty.
> - [Medium] Divergent semantics for 'usable_slaves is empty in 802.3ad
>    mode' across peer call sites.
> - [Medium] The patch's stated motivation is that 'ARP requests still fail
>    to transmit' during 802.3ad bring-up, but with the broadcast_neighbor…
> - [Low] bond_3ad_xmit_fallback() counts eligible ports in one pass and
>    re-walks the list in a second pass to pick the target-th eligible…
> - [Low] Undescribed hunk: the patch also reorders bond_xmit_hash() to
>    after the count check inside bond_xmit_3ad_xor_slave_get()…


Thanks for the review.

I have addressed the comments in v2:

- use spin_trylock_bh() in the fallback path to avoid recursive
   mode_lock acquisition;
- limit the fallback to the interval in which an array update has
   not yet been published;
- retain the first eligible port if eligibility changes between the
   two passes;
- apply the fallback to ndo_get_xmit_slave and the
   broadcast_neighbor path;
- document why the hash calculation is deferred until the array count
   is known.

The XDP path is intentionally left unchanged and will be handled in a
separate patch later. The peer-notification and miimon readers continue
to use the published array because they are control-path consumers.

v2:
https://lore.kernel.org/all/20260918090137.66515-1-luyun_611@163.com/

---

Thanks,

Yun Lu

>
> --
>
> bonding: 3ad: select a port when the TX array is empty
>
> This adds a fallback in bond_3ad_xor_xmit() so that, in 802.3ad mode, an
> empty usable_slaves array no longer means an automatic drop: a port is
> picked directly from the active aggregator under bond->mode_lock.  A few
> questions below about the new locking on the transmit path and about the
> peer call sites that were left with the old semantics.
>
> No Link: tags in the commit header.
>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index a9bff7663eeca..2cf280bf134f2 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5233,11 +5233,11 @@ static struct slave *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
>>   	unsigned int count;
>>   	u32 hash;
>>   
>> -	hash = bond_xmit_hash(bond, skb);
>>   	count = slaves ? READ_ONCE(slaves->count) : 0;
>>   	if (unlikely(!count))
>>   		return NULL;
>>   
>> +	hash = bond_xmit_hash(bond, skb);
>>   	slave = slaves->arr[hash % count];
>>   	return slave;
>>   }
> [Severity: Low]
> This isn't a bug, but could the changelog mention this hunk?  It moves
> bond_xmit_hash() below the count check in bond_xmit_3ad_xor_slave_get(),
> which is also called from bond_xmit_get_slave().
>
> The reorder looks like a prerequisite of the new design, so the hash is
> computed once (in the helper for the array path, in bond_3ad_xor_xmit()
> for the fallback path), and it appears functionally neutral because
> bond_xmit_hash()/__bond_xmit_hash() only read the skb.  Right now a
> reader has to work that out on their own.
>
>> @@ -5289,9 +5289,65 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
>>   	return false;
>>   }
>>   
>> -/* Use this Xmit function for 3AD as well as XOR modes. The current
>> - * usable slave array is formed in the control path. The xmit function
>> - * just calculates hash and sends the packet out.
>> +/* Called with RCU and bond->mode_lock held. */
>> +static bool bond_3ad_slave_is_eligible(struct slave *slave)
>> +{
>> +	const struct aggregator *agg;
>> +
>> +	agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
>> +	return agg && agg->is_active && bond_slave_can_tx(slave);
>> +}
>> +
>> +/* Called with RCU held when the transmit array has not caught up with
>> + * the 802.3ad state machine. Do not enable ports here: use the same
>> + * eligibility checks as bond_update_slave_arr().
>> + */
>> +static struct slave *bond_3ad_xmit_fallback(struct bonding *bond, u32 hash)
>> +{
>> +	struct slave *selected = NULL;
>> +	unsigned int eligible = 0;
>> +	unsigned int target;
>> +	struct list_head *iter;
>> +	struct slave *slave;
>> +
>> +	/* Netpoll can re-enter TX while the state machine holds mode_lock.
>> +	 * Keep the existing empty-array drop behavior in that context.
>> +	 */
>> +	if (unlikely(netpoll_tx_running(bond->dev)))
>> +		return NULL;
>> +
>> +	/* Aggregator selection temporarily clears all is_active flags. Keep
>> +	 * both loops under mode_lock to avoid observing that intermediate
>> +	 * state. The caller's RCU read lock protects the selected slave.
>> +	 */
>> +	spin_lock_bh(&bond->mode_lock);
> [Severity: High]
> Is the netpoll check enough to cover all the ways TX can be entered with
> a mode_lock already held?  The 802.3ad state machine holds mode_lock
> across its whole sweep, and LACPDU transmission happens inside that
> section:
>
> bond_3ad_state_machine_handler()
>      spin_lock_bh(&bond->mode_lock);
>      ...
>      ad_tx_machine(port);
>          ad_lacpdu_send(port);
>              skb->dev = slave->dev;
>              dev_queue_xmit(skb);
>
> bond_3ad_unbind_slave() does the same thing, calling ad_lacpdu_send()
> with mode_lock held.
>
> Bond devices set IFF_NO_QUEUE, so dev_queue_xmit() calls the lower
> device's ndo_start_xmit synchronously in the same context.  If the lower
> device is itself an 802.3ad bond (bond_enslave() only rejects non-bond
> masters, so bond-over-bond is allowed) whose usable array is still empty
> - the very bring-up window this patch targets - then:
>
> bond_3ad_state_machine_handler()      /* outer bond mode_lock held */
>    -> ad_lacpdu_send() -> dev_queue_xmit()
>      -> inner bond bond_start_xmit() -> __bond_start_xmit()
>        -> bond_3ad_xor_xmit()         /* empty usable_slaves */
>          -> bond_3ad_xmit_fallback()
>            -> spin_lock_bh(&inner->mode_lock);
>
> Since mode_lock has a single lockdep class (one spin_lock_init() in
> bond_setup(), no subclass or nest_lock annotation), wouldn't lockdep
> report possible recursive locking here and then disable itself?
>
> There is a worse variant: if egress processing on the lower device
> redirects the frame back into the same bond (tc mirred egress redirect or
> a bpf redirect run from sch_handle_egress in the same call), doesn't the
> same CPU re-acquire the same non-recursive mode_lock with softirqs
> disabled and spin forever?  netpoll_tx_running() does not cover that
> case, since these paths run with interrupts enabled.
>
> Would it be possible to avoid taking mode_lock on the transmit path
> altogether, or to move LACPDU transmission out of the mode_lock section?
>
>> +	bond_for_each_slave_rcu(bond, slave, iter)
>> +		if (bond_3ad_slave_is_eligible(slave))
>> +			eligible++;
>> +
>> +	if (!eligible)
>> +		goto out;
> [Severity: Medium]
> How expensive does this become when the array is empty for a long time?
> Every skb that finds an empty array now takes a bond-wide spinlock and
> walks the full lower-device list (once when nothing is eligible, twice
> otherwise), and is then dropped anyway.
>
> The empty-array state is not only the transient rebuild window described
> in the changelog.  bond_update_slave_arr() publishes an empty array
> whenever bond_3ad_get_active_agg_info() fails:
>
> 	/* No active aggragator means it's not safe to use
> 	 * the previous array.
> 	 */
> 	bond_reset_slave_arr(bond);
>
> That covers the whole duration of LACP non-convergence (peer switch not
> running LACP, all members down), and bond devices are IFF_NO_QUEUE so
> skbs still reach ndo_start_xmit with carrier down.
>
> The same mode_lock is held by bond_3ad_state_machine_handler() across its
> entire sweep and by bond_3ad_rx_indication() on LACPDU receive, so
> sustained TX bounces the lock against the very state machine that would
> end the fallback state.  Would an "update pending" latch, or making the
> fallback one-shot, bound this?
>
>> +
>> +	target = hash % eligible;
>> +	bond_for_each_slave_rcu(bond, slave, iter) {
>> +		if (!bond_3ad_slave_is_eligible(slave))
>> +			continue;
>> +
>> +		if (!target) {
>> +			selected = slave;
>> +			break;
>> +		}
>> +		target--;
>> +	}
> [Severity: Low]
> Does mode_lock really keep the two passes consistent?  It serialises the
> 802.3ad state (agg->is_active), but the other inputs of
> bond_3ad_slave_is_eligible() are not written under it:
>
> include/net/bonding.h:
> static inline bool bond_slave_can_tx(struct slave *slave)
> {
> 	return bond_slave_is_up(slave) && slave->link == BOND_LINK_UP &&
> 	       bond_is_active_slave(slave);
> }
>
> bond_slave_is_up() reads netif_running()/netif_carrier_ok(), which the
> lower driver can flip via netif_carrier_off() with no bond lock at all,
> and slave->link / slave->backup are written by the monitors
> (bond_miimon_commit()) under RTNL only.
>
> So if the hash picked the last eligible index (target == eligible - 1)
> and one slave becomes ineligible between the two passes, doesn't the
> second walk decrement target for each remaining eligible slave, never
> reach target == 0, and return NULL - dropping the packet the fallback was
> supposed to send?
>
> In the opposite direction, a slave becoming eligible between the passes
> skews the hash distribution relative to the array path, which does its
> single walk under RTNL.  Could the changelog's claim that "hash selection
> remains equivalent" be narrowed to agg->is_active?
>
>> +
>> +out:
>> +	spin_unlock_bh(&bond->mode_lock);
>> +	return selected;
>> +}
>> +
>> +/* Use this Xmit function for 3AD as well as XOR modes. The usable slave
>> + * array is formed in the control path.  In 3AD mode, fall back to the
>> + * current port state while an empty array awaits an update.
>>    */
>>   static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>>   				     struct net_device *dev)
>> @@ -5302,6 +5358,8 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>>   
>>   	slaves = rcu_dereference(bond->usable_slaves);
>>   	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>> +	if (unlikely(!slave) && BOND_MODE(bond) == BOND_MODE_8023AD)
>> +		slave = bond_3ad_xmit_fallback(bond, bond_xmit_hash(bond, skb));
> [Severity: Medium]
> Should the fallback live in the shared helper
> bond_xmit_3ad_xor_slave_get() instead?  Several other readers of the same
> "usable_slaves is empty in 802.3ad mode" condition were left with the old
> meaning:
>
> bond_xdp_xmit_3ad_xor_slave_get() open-codes the same lookup and still
> returns NULL:
>
> 	count = slaves ? READ_ONCE(slaves->count) : 0;
> 	if (unlikely(!count))
> 		return NULL;
>
> so XDP_TX/XDP_REDIRECT frames keep getting dropped in exactly the window
> this patch closes for skbs.
>
> bond_xmit_get_slave(), the ndo_get_xmit_slave callback, also still
> returns NULL.  Its documented contract in include/linux/netdevice.h is to
> return the slave the master will use for that skb, and
> netdev_get_xmit_slave() is consumed by drivers/infiniband/core/lag.c.
> Doesn't that now tell an offload consumer "no egress slave" for an skb
> the bond does in fact transmit?
>
> Two control-path readers still encode the old invariant as well:
>
> bond_should_notify_peers():
> 	usable = rcu_dereference_rtnl(bond->usable_slaves);
> 	if (!usable || !READ_ONCE(usable->count))
> 		return false;
>
> bond_miimon_inspect():
> 	if (usable_slaves && usable_slaves->count == 0)
> 		ignore_updelay = true;
>
> Is peer notification meant to stay suppressed, and updelay ignored, for a
> bond that can now transmit?
>
> [Severity: Medium]
> The changelog says "ARP requests still fail to transmit".  With the
> broadcast_neighbor option enabled, do ARP and IPv6 neighbour-discovery
> packets ever reach this fallback?
>
> __bond_start_xmit() short-circuits before bond_3ad_xor_xmit():
>
> 	case BOND_MODE_8023AD:
> 		if (bond_should_broadcast_neighbor(skb, dev))
> 			return bond_xmit_broadcast(skb, dev, false);
>
> and bond_xmit_broadcast() reads the same asynchronously updated array:
>
> 	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
> 	for (i = 0; i < slaves_count; i++) {
>
> With an empty or NULL array the loop body never runs, the skb is freed
> and NET_XMIT_DROP is returned, so the symptom described in the commit
> message survives for bonds configured with broadcast_neighbor=1 even
> though the active aggregator has eligible ports.  Should that path get
> the same treatment, or is the residual gap intentional?
>
>>   	if (likely(slave))
>>   		return bond_dev_queue_xmit(bond, skb, slave->dev);
>>

