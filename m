Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699587;
	b=rSlwvFpez+ti0TwW6aW/uHVL0CoZWPN6gWMM9+sj/fJfgpokdh95LJpJYrTnU3DEfEXX
	 YpoLgFi13PKukiRFDNccePVLiq1TVhtg7tPANpAcZ9QqZVQ0g/ehRUo2HT8uRDLADJHvg
	 I0i9iaVZOdl+GxfG69zmEkmhJxgv8NVwbATx1BhSwjfNrJIJL8eY4Jd2u77AZrriYZ1RA
	 8czWbIKvqPG+1Al30vzCfJyiaTyHyOK9Dyaxqq12oT3yyhPCQdkWkoBB0YY2ns0hZxnlz
	 lFb2U6/OCKbDuH+A2jUEZ7EvO1Q4pBUurCDzKIUOGekMabdgOAmOWdvVmRycDbLwyFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699587;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hZmWQtRzeyLV4UH+Bt+diAh21mU4wEBzL5zcXhiZ100=;
	b=HUFQGOVRMIDu0D7e6VnXdKY5Qz2gyCoF8SrkpEIZwf5xOr6N3aYy+WNack2VNORTnWeh
	 XiGz2p+g98BbNiCLiwwKC9+sFCnwyzBkt7yAKPBAJ1jsTn3ZCmKD+odcfjuBdAwvAWdRv
	 pW8VnBEg/Haupp+TLq74K3MBZK3FBZJOCifLxXsQWDhX+6ki0njDVcuVZFSV1HJx9zPFj
	 0qGyzb/pQiqGI8jzPuCmz5ShWa+m5wpxRuYl79ZxBG7gtGaYcw0iWVFUIPVNe8ezzveQY
	 YZ+O1O/ikrz/pVJj5mUI+Ttl21VNzSqbXLuI8g5Dc93F/Jy43XLt9gydRsfNdGRs8mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C3606EE82
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82C3606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hZmWQtRzeyLV4UH+Bt+diAh21mU4wEBzL5zcXhiZ100=;
	b=DJcIU4FJvNft7j1M6mw+bTlR3ceFEfftUKpR21eXl9guksvlL172OgFuStOD5M
	qgZmTQoDGHxfdyP+IOuxKZYXfDc9WoZOl1AGFB1OsfblebLVO5MnT8RMm16QbymU
	joq9Hi67IMQZWQanXHsXE4b3I1vUkNBz7JA2f/Zw7dYX8=
Message-ID: <382013cc-4565-4c3b-b3a9-bf4240131671@163.com>
Date: Tue, 3 Nov 2026 17:52:03 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bonding: 3ad: update transmit arrays without
 waiting for RTNL
To: netdev-bot+sashiko@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, hangbin.liu@linux.dev
References: <20261029025411.1087287-1-luyun_611@163.com>
 <179358903930.3131.3436478454047787765@kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <179358903930.3131.3436478454047787765@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3L4PDrulqIV1VEw--.8919S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uryDCF47AFyruFWDWr43trb_yoW8Xry8Ao
	WrX3yxGw4ftFy5K34DA3ZrAFZ2qFWkCrySvr15Xr98uFZ2qryY9a1xZ3yYyFW7JF18KF40
	qw18J3s0qaykJa1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUbnmRDUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wXxwGrprsVgLAAA37


在 2026/11/2 11:10, netdev-bot+sashiko@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 (1) · Medium: 1 (3) · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).

Thanks for the review. We are reworking the patch accordingly; the
verified v5 will be posted shortly. The plan for each point:

>
> - [Medium] The new per-bond slave_arr_lock mutex is held across all of
>    netdev_master_upper_dev_link() in bond_master_upper_dev_link()…
  v5 will narrow the mutex to array allocation, filling and publication,
   plus the array_ready commit. The builder will walk the lower list
   under RCU, so link/unlink and their notifier chains no longer nest
   inside the mutex and the ordered workqueue cannot stall behind them.
   This also removes the theoretical self-deadlock via a CHANGEUPPER
   subscriber.
> - [Low] Several comments no longer match the code after this patch.
will update the builder doc block, the rearm/handler comments and
the bond_3ad_handle_link_change comment.
> - [Low] This patch initialises slave_arr_lock with mutex_init() in
>    bond_setup() (bond_main.c:6019) but never calls mutex_destroy() on it.
will add it in bond_destructor() after destroy_workqueue().
>
> Pre-existing issues:
> - [High] In 802.3ad mode, an enslave that fails after
>    bond_master_upper_dev_link() can leave a use-after-free in the…
> - [Medium] Only four call sites rearm slave_arr_work when
>    bond_update_slave_arr() fails: bond_3ad_state_machine_handler,…
> - [Medium] bond_enslave() increments bond->slave_cnt at bond_main.c:2295
>    (`WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);`) before the XDP…
> - [Medium] In broadcast mode, bond_set_slave_arr()
>    (bond_main.c:5147-5150) frees only the newly passed usable_slaves and…
>
> --

For the pre-existing issues, I prefer to fix them in separate follow-up
patches rather than folding them into this one.

pw-bot: cr

---

Thanks,
Yun Lu


>
> bonding: 3ad: update transmit arrays without waiting for RTNL
>
> This commit makes the 802.3ad state machine rebuild the usable_slaves and
> all_slaves transmit arrays itself. Before, it deferred the rebuild to a
> worker that retried rtnl_trylock(). It adds a per-bond slave_arr_lock
> mutex so array writers are serialized with lower-list link/unlink. It also
> adds a per-slave array_ready flag that keeps half-enslaved slaves out of
> the arrays.
>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 7019e5d8fdc8e..883d0cac07a2f 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
> [ ... ]
>
>> @@ -1714,19 +1719,22 @@ static int bond_master_upper_dev_link(struct bonding *bond, struct slave *slave,
>>   	lag_upper_info.tx_type = type;
>>   	lag_upper_info.hash_type = bond_lag_hash_type(bond, type);
>>   
>> +	mutex_lock(&bond->slave_arr_lock);
>>   	err = netdev_master_upper_dev_link(slave->dev, bond->dev, slave,
>>   					   &lag_upper_info, extack);
>> -	if (err)
>> -		return err;
>> +	if (!err)
>> +		slave->dev->flags |= IFF_SLAVE;
>> +	mutex_unlock(&bond->slave_arr_lock);
>>   
>> -	slave->dev->flags |= IFF_SLAVE;
>> -	return 0;
>> +	return err;
>>   }
>>   
>>   static void bond_upper_dev_unlink(struct bonding *bond, struct slave *slave)
>>   {
>> +	mutex_lock(&bond->slave_arr_lock);
>>   	netdev_upper_dev_unlink(slave->dev, bond->dev);
>>   	slave->dev->flags &= ~IFF_SLAVE;
>> +	mutex_unlock(&bond->slave_arr_lock);
>>   }
> [Severity: Medium]
> Is slave_arr_lock meant to be held across the whole of
> netdev_master_upper_dev_link() and netdev_upper_dev_unlink()?
>
> Those calls run the NETDEV_PRECHANGEUPPER and NETDEV_CHANGEUPPER notifier
> chains (switchdev/LAG offload, bridge, RDMA handlers). They also create
> and remove sysfs links and allocate memory. Every lock those subscribers
> take now nests inside a bonding-private mutex.
>
> This patch also makes bond_3ad_state_machine_handler() call the builder
> directly instead of queueing slave_arr_work:
>
>      if (update_slave_arr && bond_update_slave_arr(bond, NULL))
>          bond_slave_arr_work_rearm(bond, 1);
>
> bond_update_slave_arr() now does mutex_lock(&bond->slave_arr_lock) and
> two GFP_KERNEL allocations.
>
> bond->wq comes from alloc_ordered_workqueue(). While enslave or release is
> inside the notifier chain, ad_work blocks on the mutex, and every other
> bond work item waits behind it.
>
> The new slave is already in the lower list before CHANGEUPPER fires.
> ad_agg_selection_logic() sets update_slave_arr on most ticks when the
> active aggregator has no partner. So this looks likely during enslave.
>
> Won't this hold up the LACP tick and LACPDU transmission for as long as
> the notifier handlers run?
>
> There is also a theoretical self-deadlock on the bond_enslave()
> err_upper_unlink path. There, IFF_SLAVE is still set and the rx_handler
> is still registered:
>
> bond_upper_dev_unlink()
>      mutex_lock(&bond->slave_arr_lock)
>      netdev_upper_dev_unlink()
>          CHANGEUPPER subscriber raises NETDEV_UP/CHANGE/DOWN on lower dev
>              bond_slave_netdev_event()
>                  bond_update_slave_arr()
>                      mutex_lock(&bond->slave_arr_lock)
>
> No in-tree subscriber appears to do this today.
>
> The commit message doesn't discuss this trade-off. Only the lower-list
> change itself, and its ordering against the rebuild after unlink, need
> the lock. Would a narrower critical section, or a trylock-and-requeue in
> the ad handler, keep the LACP worker from blocking?
>
> [ ... ]
>
>> @@ -2332,10 +2340,17 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>>   			bpf_prog_inc(bond->xdp_prog);
>>   	}
>>   
>> +	/* Publish only after all fallible setup, including XDP, is complete. */
>> +	mutex_lock(&bond->slave_arr_lock);
>> +	new_slave->array_ready = true;
>> +	mutex_unlock(&bond->slave_arr_lock);
> [Severity: High]
> This isn't a bug introduced by this patch, but can a failed 802.3ad
> enslave leave a freed struct port linked into another slave's aggregator?
>
> bond_enslave() calls bond_3ad_bind_slave(new_slave) before linking. Once
> bond_master_upper_dev_link() succeeds, the new slave sits at the tail of
> the RCU lower list. bond_3ad_state_machine_handler() runs under mode_lock
> and RCU, not RTNL, so it will process that port.
>
> The port is not AD_PORT_SELECTED, so ad_port_selection_logic() attaches
> it to the first free aggregator:
>
>      if (!aggregator->lag_ports) {
>          if (!free_aggregator)
>              free_aggregator = aggregator;
>          continue;
>      }
>      ...
>      free_aggregator->lag_ports = port;
>      free_aggregator->num_of_ports++;
>
> Suppose slaves A and B already share A's aggregator. B's aggregator is
> free and is visited before C's, so a new port C joins B's aggregator.
>
> A later enslave step can then fail: bond_sysfs_slave_add(),
> dev_set_promiscuity()/dev_set_allmulti(), or the three XDP checks that
> goto err_sysfs_del. The unwind runs bond_sysfs_slave_del(),
> bond_upper_dev_unlink(), netdev_rx_handler_unregister(),
> synchronize_rcu() and kobject_put(). None of those labels calls
> bond_3ad_unbind_slave(). It is only reached from __bond_release_one().
>
> slave_kobj_release() then frees the port:
>
>      if (BOND_MODE(bond) == BOND_MODE_8023AD)
>          kfree(SLAVE_AD_INFO(slave));
>
> B's aggregator still points at C's port. On every later tick,
> ad_agg_selection_logic() calls __agg_active_ports(agg) and walks
> B.agg->lag_ports into freed memory. __disable_port() and __enable_port()
> can also write through it.
>
> One reliable way to hit the failure: attach an XDP program to the bond,
> then enslave a device that lacks ndo_bpf, or one that already has an XDP
> program loaded. The same error path also leaves slave_cnt incremented
> (see below).
>
> The new array_ready flag keeps this half-enslaved slave out of the TX
> arrays, but the 3AD state machine still sees its port. Should the enslave
> error path undo bond_3ad_bind_slave() and any aggregator attachment?
>
> [ ... ]
>
>> @@ -5068,35 +5086,26 @@ static netdev_tx_t bond_xmit_activebackup(struct sk_buff *skb,
>>   	return bond_tx_drop(bond_dev, skb);
>>   }
>>   
>> -/* Use this to update slave_array when (a) it's not appropriate to update
>> - * slave_array right away (note that update_slave_array() may sleep)
>> - * and / or (b) RTNL is not held.
>> +/* Retry array updates which failed, or defer them from atomic context.
>> + * bond_update_slave_arr() may sleep but does not require RTNL.
>>    */
>>   void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay)
>>   {
>>   	queue_delayed_work(bond->wq, &bond->slave_arr_work, delay);
>>   }
> [Severity: Medium]
> This is a pre-existing issue. The new comment says this work retries
> array updates that failed, but only four callers rearm on failure:
> bond_3ad_state_machine_handler(), bond_enslave() (when running),
> bond_open() and bond_slave_arr_handler().
>
> The other callers ignore the -ENOMEM return:
>
>    bond_3ad_handle_link_change()
>    __bond_release_one(), which only falls back to bond_skip_slave()
>    bond_miimon_link_change() for XOR
>    bond_loadbalance_arp_mon() for XOR
>    bond_slave_netdev_event() on NETDEV_UP/CHANGE/DOWN
>    bond_alb_handle_link_change(), which only logs with pr_err()
>
> If the allocation fails at one of these sites, usable_slaves and
> all_slaves stay stale and nothing retries.
>
> For example, take an XOR bond with no miimon or arpmon whose only slave
> lost carrier. Its array is empty. If the rebuild fails when carrier
> returns, bond_3ad_xor_xmit() keeps dropping packets.
>
> bond_slave_arr_handler() no longer needs RTNL. Would it make sense to
> rearm slave_arr_work from these sites too?
>
> [ ... ]
>
>> @@ -5153,20 +5166,25 @@ static void bond_reset_slave_arr(struct bonding *bond)
>>    * (b) BOND_MODE_XOR
>>    * (c) (BOND_MODE_TLB || BOND_MODE_ALB) && tlb_dynamic_lb == 0
>>    *
>> - * The caller is expected to hold RTNL only and NO other lock!
>> + * Acquires slave_arr_lock to stabilize membership and serialize writers.
>> + * The caller must be in sleepable context without mode_lock or RCU held.
>>    */
> [Severity: Low]
> This isn't a bug, but a few comments no longer match the code after this
> change.
>
> This doc block still says it builds "the usable slaves array" for
> 802.3ad, XOR, and TLB/ALB with tlb_dynamic_lb == 0. But:
>
>    - the function also builds and publishes all_slaves
>    - this patch adds a BOND_MODE_BROADCAST call from bond_open(), and
>      broadcast calls already existed in bond_enslave() and
>      __bond_release_one()
>    - bond_mode_can_use_xmit_hash() is true for TLB and ALB whatever
>      tlb_dynamic_lb is set to
>
> The new comment above bond_slave_arr_work_rearm() says the work can
> "defer them from atomic context". All four callers only use it to retry
> after bond_update_slave_arr() fails.
>
> bond_3ad_handle_link_change() still justifies its call with RTNL:
>
>      /* RTNL is held and mode_lock is released so it's safe
>       * to update slave_array here.
>       */
>      bond_update_slave_arr(slave->bond, NULL);
>
> The new rule is sleepable context without mode_lock or RCU held; RTNL is
> no longer part of it.
>
>>   int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
>>   {
> [ ... ]
>
>>   	might_sleep();
>> +	mutex_lock(&bond->slave_arr_lock);
>>   
>> -	usable_slaves = kzalloc_flex(*usable_slaves, arr, bond->slave_cnt);
>> -	all_slaves = kzalloc_flex(*all_slaves, arr, bond->slave_cnt);
>> +	/* Enslave counts before committing; release unlinks before uncounting. */
>> +	count = READ_ONCE(bond->slave_cnt);
>> +	usable_slaves = kzalloc_flex(*usable_slaves, arr, count);
>> +	all_slaves = kzalloc_flex(*all_slaves, arr, count);
> [Severity: Medium]
> This is a pre-existing issue, but this comment assumes slave_cnt follows
> enslave and release, and bond_enslave() can leave it permanently too
> high.
>
> bond_enslave() does this before the XDP block:
>
>      WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
>
> The XDP block has three goto err_sysfs_del exits:
>
>    - the slave lacks ndo_bpf/ndo_xdp_xmit while bond->xdp_prog is set
>    - dev_xdp_prog_count(slave_dev) > 0
>    - dev_xdp_propagate() fails
>
> None of the labels from err_sysfs_del down to err_undo_flags decrements
> slave_cnt. The only decrement is in __bond_release_one().
>
> Over-allocating here is harmless. But bond_xmit_roundrobin_slave_get()
> does this:
>
>      slave_id = bond_rr_gen_slave_id(bond) % slave_cnt;
>
> After a failed enslave, an id past the real count makes
> bond_get_slave_by_id() fall back to the first tx-capable slave. That
> skews the round-robin distribution. bond_info_query() also reports the
> wrong num_slaves.
>
> Should the XDP error paths undo the slave_cnt increment?
>
> [ ... ]
>
>> @@ -6073,7 +6096,9 @@ static void bond_uninit(struct net_device *bond_dev)
>>   	mutex_destroy(&bond->ipsec_lock);
>>   #endif /* CONFIG_XFRM_OFFLOAD */
>>   
>> +	mutex_lock(&bond->slave_arr_lock);
>>   	bond_set_slave_arr(bond, NULL, NULL);
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does this leak the old
> usable_slaves array if the bond is in broadcast mode at teardown?
>
> bond_set_slave_arr() returns early for broadcast:
>
>      if (BOND_MODE(bond) == BOND_MODE_BROADCAST) {
>          kfree_rcu(usable_slaves, rcu);
>          return;
>      }
>
> So the published bond->usable_slaves is never freed. One sequence that
> triggers it:
>
>    ip link add bond0 type bond mode xor
>    ip link set bond0 up      (bond_open() publishes usable_slaves)
>    ip link set bond0 down    (bond_close() doesn't reset the arrays)
>    ip link set bond0 type bond mode broadcast
>    ip link del bond0
>
> bond_uninit() takes the broadcast early return, and the usable_slaves
> array allocated in XOR mode is lost when the netdev is freed.
>
>> +	mutex_unlock(&bond->slave_arr_lock);
> [Severity: Low]
> This isn't a bug, but bond_setup() initializes slave_arr_lock with
> mutex_init() and nothing calls mutex_destroy() on it. ipsec_lock just
> above does get destroyed.
>
> Should a matching mutex_destroy() go here? It would need to come after
> any work that can still call bond_update_slave_arr() has been cancelled.
>
>>   
>>   	list_del_rcu(&bond->bond_list);
> [ ... ]
>

