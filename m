Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A51A682A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791428004; cv=none; b=o2E1uFErY/uAIUQ3U7kKvcYg2v3WNtroMJCrczMii9wzCwzGTQSEiVT9364m88ihCK0kROWOtPiirQh7geisB340MERxkw8A9i63RhQiu701LoRbSorHm7VsILkaGNAYxhS5inbl3dwLzTx6FJwGF7l2chhT95QRO1CSnomAD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791428004; c=relaxed/simple;
	bh=8Jm3Sfv6QIgwyRXbORb/sB+6fKV9F4Zlc5ADycC2Adg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8Ipg154v++wl0t/3r72My6wCuMc74nMWg29PiDyjV6pjXkAz12r7Kr1r60qMWBBX/802rbpha9TnSj+bUb/+z+ngbbGRdFI4YVTC7+KQl2lLlSsWkUU2PePUDtHlL5I7OtIh7Z/wAH0CpXRESvo0M4n2+34FFr4Lr3JFDdq51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p/XH6+KA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p/XH6+KA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=SHYrS9UCU5iSkDAN0Cv8GGacKvWyGYGdteAuE/Pq8gU=;
	b=p/XH6+KAyhnmvu4NI6QF3l8q7IN7Jv2wptIFFsiMFWM9mmQBi0ZvwFAS/RaLKU
	QgEPW4omBRlo0ryJ32r7ILGKRxDxkyv7tnJjCK3EQIW7UltX2JXm/6/7i+60RbSy
	A1kxUgmanPqOjNAxsXrcb7b1SHD+WsR0eXtHtDcHlKTI8=
Message-ID: <0ef3f90a-9832-4392-87f2-58513e0f7e2f@163.com>
Date: Thu, 8 Oct 2026 10:52:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bonding: 3ad: select a port when the TX array is
 empty
To: netdev-bot+sashiko@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20260918090137.66515-1-luyun_611@163.com>
 <179006864570.2160803.16949905511627036501@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <179006864570.2160803.16949905511627036501@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXvIVyBcdqYjivDQ--.31093S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF45AFW7urW8Jr1DJF1rCrg_yoW8JrW8Ko
	WfXw1fuF4UtF15Ja47AryxGFZ2gFZ8C34Iyr1rWrs8t3WIqay5ua1rA3yUZa43JF10gF4U
	Jr17Ja909ay8J3Wrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUb7KsDUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xPpuGrHBXMW9AAA3Q

Thanks for the review. The v3 has been posted:
https://lore.kernel.org/all/20261008024031.16224-1-luyun_611@163.com/

Main changes in v3:

- Drop the pending latch and all mode_lock usage in the transmit path.
   The fallback is now lockless, so both the contention drops and the
   recursive-TX concern are gone, and the latch handoff race no longer
   exists.
- Eligibility uses the same criteria as bond_update_slave_arr() (port's
   aggregator active + bond_slave_can_tx), with one aggregator object
   pinned per transmit, so selection never spans two objects.
- broadcast_neighbor packets are replicated to all eligible members of
   the pinned object instead of a single copy.
- The commit message now states the remaining scope: XDP transmit and
   ndo_sk_get_lower_dev are left for follow-up changes.

---
Thanks,
Yun Lu

在 2026/9/22 17:17, netdev-bot+sashiko@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 2 · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] Incomplete fix: the new empty-array fallback is wired only
>    into bond_3ad_xor_xmit(), bond_xmit_broadcast() (broadcast-neighbor…
> - [Medium] bond_3ad_xmit_fallback() abandons selection (returns NULL ->
>    bond_tx_drop() in bond_3ad_xor_xmit(), or a NULL ndo_get_xmit_slave…
> - [Low] Documented behaviour vs implementation mismatch for
>    broadcast_neighbor.
> - [Low] Residual drop window from read/write order asymmetry between the
>    array publication and the latch clear.
>
> --
>
> bonding: 3ad: select a port when the TX array is empty
>
> This adds a boolean latch (bond->slave_arr_update_pending) set by the 802.3ad
> state machine and cleared by the slave array worker, and uses it to let the
> transmit paths pick a port straight from the active aggregator while the
> usable_slaves array update is still unpublished.  The fallback is wired into
> bond_3ad_xor_xmit(), the broadcast-neighbor case of bond_xmit_broadcast() and
> bond_xmit_get_slave().
>
>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
>> index b8e4b4d68dd6..1fe499ade439 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -2614,6 +2614,8 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
>>   			break;
>>   		}
>>   	}
>> +	if (update_slave_arr)
>> +		WRITE_ONCE(bond->slave_arr_update_pending, true);
>>   	rcu_read_unlock();
>>   	spin_unlock_bh(&bond->mode_lock);
>>   
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index a9bff7663eec..1144281912d3 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
> [ ... ]
>
>> @@ -5093,6 +5094,8 @@ static void bond_slave_arr_handler(struct work_struct *work)
>>   		pr_warn_ratelimited("Failed to update slave array from WT\n");
>>   		goto err;
>>   	}
>> +	/* bond->wq is ordered, so no newer request can race this clear. */
>> +	WRITE_ONCE(bond->slave_arr_update_pending, false);
>>   	return;
>>   
>> err:
> [Severity: Low]
> Can a packet still be dropped in the window this patch closes?  The worker
> publishes the new array first and clears the latch second, and the transmit
> side reads those two pieces of state in the same order:
>
> CPU0 bond_slave_arr_handler()
>      bond_update_slave_arr(bond, NULL);   /* publishes non-empty array */
>      WRITE_ONCE(bond->slave_arr_update_pending, false);
>
> CPU1 bond_3ad_xor_xmit()
>      slaves = rcu_dereference(bond->usable_slaves);   /* old, count == 0 */
>      bond_xmit_hash(bond, skb);                       /* full dissection */
>      bond_3ad_xmit_fallback()
>          if (!READ_ONCE(bond->slave_arr_update_pending))
>              return NULL;                             /* latch now clear */
>      return bond_tx_drop(dev, skb);
>
> The gap between the two reads on CPU1 spans a full bond_xmit_hash() call, so
> CPU1 can observe the stale empty array and then the already cleared latch.
>
> The re-check of the latch under mode_lock inside bond_3ad_xmit_fallback()
> does not cover this, since the clearing side (bond_slave_arr_handler()) never
> takes mode_lock; only the setting side in bond_3ad_state_machine_handler()
> does.
>
> Would re-reading bond->usable_slaves after observing a cleared latch, or
> reading the latch before sampling the array and re-validating, close this
> remainder?
>
>> @@ -5289,9 +5292,67 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
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
>> +/* Called with RCU held. */
>> +static struct slave *bond_3ad_xmit_fallback(struct bonding *bond, u32 hash)
>> +{
>> +	struct slave *selected = NULL;
>> +	unsigned int eligible = 0;
>> +	unsigned int target;
>> +	struct list_head *iter;
>> +	struct slave *slave;
>> +
>> +	/* Limit the list walk to the array-update window. */
>> +	if (!netif_carrier_ok(bond->dev) ||
>> +	    !READ_ONCE(bond->slave_arr_update_pending))
>> +		return NULL;
>> +
>> +	/* TX may recurse while mode_lock is already held. */
>> +	if (unlikely(netpoll_tx_running(bond->dev)) ||
>> +	    !spin_trylock_bh(&bond->mode_lock))
>> +		return NULL;
> [Severity: Medium]
> The trylock is needed for the recursive TX case, but does it also turn plain
> remote-CPU contention into a packet drop during exactly the convergence
> period the patch targets?
>
> mode_lock is held for the whole body of bond_3ad_state_machine_handler(),
> walking every slave and running ad_rx_machine(), ad_periodic_machine(),
> ad_port_selection_logic(), ad_mux_machine(), ad_tx_machine() and
> ad_churn_machine(), with the latch published only at the very end:
>
>      spin_lock_bh(&bond->mode_lock);
>      ...
>      if (update_slave_arr)
>          WRITE_ONCE(bond->slave_arr_update_pending, true);
>      rcu_read_unlock();
>      spin_unlock_bh(&bond->mode_lock);
>
> It is also taken by the LACPDU receive path in bond_3ad_rx_indication():
>
>      /* Protect against concurrent state machines */
>      spin_lock(&slave->bond->mode_lock);
>      ad_rx_machine(lacpdu, port);
>      spin_unlock(&slave->bond->mode_lock);
>
> and by bond_3ad_handle_link_change().  Since bond_setup() sets
> bond_dev->lltx = true, transmitters are not serialized by the device TX lock,
> so a transmit on another CPU landing in any of those sections (or racing
> another CPU already inside the fallback's own two list walks) fails the
> trylock and bond_3ad_xor_xmit() drops the skb even though the latch is set
> and eligible ports exist.
>
> Would having the state machine publish a fallback slave via RCU, so the TX
> fast path never needs the LACP state-machine spinlock, avoid both the
> recursion problem and the contention drops?  As written, the new code also
> puts a mode_lock acquisition plus a full lower-device list walk on the
> per-packet TX path for the duration of the window.
>
>> +
>> +	if (!READ_ONCE(bond->slave_arr_update_pending))
>> +		goto out;
>> +
>> +	bond_for_each_slave_rcu(bond, slave, iter)
>> +		if (bond_3ad_slave_is_eligible(slave))
>> +			eligible++;
>> +
>> +	if (!eligible)
>> +		goto out;
>> +
>> +	target = hash % eligible;
>> +	bond_for_each_slave_rcu(bond, slave, iter) {
>> +		if (!bond_3ad_slave_is_eligible(slave))
>> +			continue;
>> +
>> +		if (!selected)
>> +			selected = slave;
>> +
>> +		if (!target) {
>> +			selected = slave;
>> +			break;
>> +		}
>> +		target--;
>> +	}
>> +
>> +out:
>> +	spin_unlock_bh(&bond->mode_lock);
>> +	return selected;
>> +}
>> +
>> +/* Use this Xmit function for 3AD as well as XOR modes. The usable slave
>> + * array is formed in the control path. In 3AD mode, fall back to the current
>> + * port state while an empty array update is pending.
>>    */
>>   static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>>   				     struct net_device *dev)
>> @@ -5302,6 +5363,8 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
>>   
>>   	slaves = rcu_dereference(bond->usable_slaves);
>>   	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>> +	if (unlikely(!slave) && BOND_MODE(bond) == BOND_MODE_8023AD)
>> +		slave = bond_3ad_xmit_fallback(bond, bond_xmit_hash(bond, skb));
>>   	if (likely(slave))
>>   		return bond_dev_queue_xmit(bond, skb, slave->dev);
>>   
>> @@ -5327,6 +5390,16 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
>>   		slaves = rcu_dereference(bond->usable_slaves);
>>   
>>   	slaves_count = slaves ? READ_ONCE(slaves->count) : 0;
>> +	if (!slaves_count && !all_slaves &&
>> +	    BOND_MODE(bond) == BOND_MODE_8023AD) {
>> +		struct slave *slave;
>> +
>> +		slave = bond_3ad_xmit_fallback(bond,
>> +					       bond_xmit_hash(bond, skb));
>> +		if (slave)
>> +			return bond_dev_queue_xmit(bond, skb, slave->dev);
>> +	}
>> +
> [Severity: Low]
> Does this branch match the documented meaning of broadcast_neighbor?
>
> Documentation/networking/bonding.rst describes the option as:
>
> 	Option specifying whether to broadcast ARP/ND packets to all
> 	active slaves.  This option has no effect in modes other than
> 	802.3ad mode.  The default is off (0).
>
> and the descriptor for BOND_OPT_BROADCAST_NEIGH in bond_options.c says
> "Broadcast neighbor packets to all active slaves".
>
> bond_3ad_xmit_fallback() is a hash-selecting single-port helper
> (target = hash % eligible), so this sends one copy on one port and returns
> before the replication loop.  Since the port choice is
> bond_xmit_hash(bond, skb) % eligible, the same neighbour deterministically
> leaves through the same port and the other eligible members of the active
> aggregator see no ARP/ND for the whole update window.
>
> bond_3ad_xmit_fallback() already enumerates the full eligible set under
> mode_lock.  Could the broadcast caller replicate to every eligible port
> instead, to match the array path it mirrors?  Otherwise, should the
> documentation describe the degraded behaviour during the window?
>
>>   	for (i = 0; i < slaves_count; i++) {
>>   		struct slave *slave = slaves->arr[i];
>>   		struct sk_buff *skb2;
>> @@ -5432,6 +5505,10 @@ static struct net_device *bond_xmit_get_slave(struct net_device *master_dev,
>>   		else
>>   			slaves = rcu_dereference(bond->usable_slaves);
>>   		slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
>> +		if (!slave && !all_slaves &&
>> +		    BOND_MODE(bond) == BOND_MODE_8023AD)
>> +			slave = bond_3ad_xmit_fallback(bond,
>> +						       bond_xmit_hash(bond, skb));
>>   		break;
> [Severity: Medium]
> Should the XDP transmit selector get the same treatment?
> bond_xdp_xmit_3ad_xor_slave_get() reads the same bond->usable_slaves array
> and still has the unconditional empty-array return:
>
> 	count = slaves ? READ_ONCE(slaves->count) : 0;
> 	if (unlikely(!count))
> 		return NULL;
>
> so during the same window bond_xdp_get_xmit_slave() returns NULL for
> BOND_MODE_8023AD and bond_xdp_xmit() aborts the batch:
>
> 		slave_dev = bond_xdp_get_xmit_slave(bond_dev, &xdp);
> 		if (!slave_dev) {
> 			err = -ENXIO;
> 			break;
> 		}
>
> __bond_sk_get_lower_dev() has the same count == 0 NULL return for the
> TLS/socket lower-device lookup, so two consumers of the same emptiness
> condition now answer differently.
>
> The commit message says:
>
>      If an skb transmit or ndo_get_xmit_slave query finds an empty usable array
>      while the latch is set, select a port directly from the active aggregator.
>
> but it does not state that the XDP transmit path keeps dropping frames in
> that window.  The only mention, "leave XDP for a separate follow-up patch",
> is in the v2 changelog below the --- separator, which git does not record.
> Could that limitation be stated in the commit message itself, given the
> Fixes: tag makes this a backport candidate?
>
> [ ... ]
>

