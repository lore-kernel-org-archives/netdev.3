Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291292;
	b=45wr2LLt8QGjihVFp+QJAGAO+SKsvu0TTsoSCrqSMD6/PVy1qlU335FceZgQSMWpp/Mw
	 Cy+K16CHClzTv8IwZdASSRKQsnPgyp/s7iaiCjEmYrl1zf+6oranX4sDQPVlJaoz8lqCK
	 HTrqwIsYYK3X//g74uStQj+fXGWGyuLsVF25jZCVetfZkl7VW5fp6rliVKckpAGQ3IB3N
	 qXuOBx2yf5MDWX1lLuo4qa4aWxXm3QQoegCAYahiJhDELjcBX+odP8qjKcSg49cgRE+F3
	 yItpcpJcphiQubRYJUSLLf1YfV2owV0AAJmpaDaVk4IMYzbkDDGLgc1J+Nel7dC9apg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291292;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=1n/DTxfwG3+4AvUgAHXRBVaekZr8PTubGZCustmH49E=;
	b=ObmYBhZI7QumcWGp9Hg0QDLoiJjK0oW1+gPdHgETgjW4QPSDSTCDvQ6dndIQ4ro7W15G
	 FPmAgUmuvxqinYCUqdQWmNP2jNZEPmZ1T9kkhZMSUe+3jQo87JodZI/cUmlKsNHCQkjml
	 K603728USQQ9HIlexR2TwxLS7AIVDmN3PZbi8CTP2bgScUEZ7m5TboWaFj0LKDFmwOIn3
	 vWf1QecMAe3tMNiBEZXzYag8W6k+Ef3bLmLyTaii0wLKy6DzQKLsObuz7vg9KJU67eWyU
	 +yNRAqio+Z2vtsdN2I4cD7Ph1HxIPOEI8fugtF2PqfFqe/XCQirDEEwrWRPqf+fwOMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LBMU1OSx;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D0606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 790D0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LBMU1OSx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=1n/DTxfwG3+4AvUgAHXRBVaekZr8PTubGZCustmH49E=;
	b=LBMU1OSxx+NubOK0e1ebqzoT6AArG/fuQ5BdFJFHTXm+L8rLKX2O5aoulQxpQR
	YOlZ+cM1tFXJgtYBB3KJYyhUJ7tqa2Q0p2o4mMCEJlWK1OJndwG/mhhpDtRFhAGm
	x8qm84erVlerb/YUi2RzXBCfJbhMBSYriAmmJ3fkpB1cY=
Message-ID: <259ec87f-9c56-4bea-b2ea-6627b1913ef0@163.com>
Date: Tue, 10 Nov 2026 14:13:57 +0800
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
Subject: Re: [PATCH net-next v6] bonding: 3ad: update transmit arrays without
 waiting for RTNL
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
References: <20261105070132.385853-1-luyun_611@163.com>
 <avKIelQZ4rf0G7BN@fedora>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <avKIelQZ4rf0G7BN@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXU5cltvJqyAIeFA--.546S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZryrXF18KF45urW8GryUZFb_yoW8XF15Co
	WfJw4xWr4rJF15tayDA34DuFs2gayDC34ayr45JrnxuF1vq3429F4fX3y5CF9rXF18Kr4r
	Z3s7Jas0qay8J3Wrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUb5l8UUUUU
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AcO3Grytic2kgAA3U


在 2026/11/10 10:59, Hangbin Liu 写道:
> Hi Lu Yun,
> On Thu, Nov 05, 2026 at 03:01:32PM +0800, Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> During 802.3ad bring-up, packets can be dropped despite carrier being up
>> and LACP having enabled ports for distribution. This was observed on a
>> machine in real use.
>>
>> The LACP worker enables ports before queuing slave_arr_work to rebuild
>> usable_slaves. The transmit path keeps using that array, which can
>> remain empty while the array worker retries rtnl_trylock(). Unrelated
>> RTNL contention can therefore prolong the packet loss.

Hi Hangbin,

Thanks for the review.

> The root issue is the usable_slaves are not available before LACP worker,
> right?
No, the real root issue is the delay between LACP enabling ports for
distribution and publishing those ports in usable_slaves.
>
>> Rebuild the arrays directly from the LACP worker after releasing
>> mode_lock and RCU, and remove the retry worker's RTNL dependency. Retain
>> delayed work to retry allocation failures.
>>
>> Use a per-bond mutex to serialize array allocation, filling and
>> publication, and walk the lower list under RCU. Keep upper link/unlink
>> notifications outside this mutex. Exclude new slaves from both arrays
>> until all fallible setup, including XDP propagation, succeeds and
>> commits array_ready under the same mutex. This keeps concurrently linked
>> slaves from overrunning arrays sized from an earlier slave count.
>> Release completes its final rebuild or allocation-failure skip under the
>> mutex before waiting for RCU readers and freeing a slave.
>>
>> Retry failed final updates for running bonds. Also rebuild broadcast
>> arrays on open and retry failed open updates. Protect the
>> peer-notification array reader with RCU now that RTNL no longer excludes
>> writers. Updating the shared arrays also covers XDP and lower-device
>> queries without changing their selection rules.
>>
>> Tests used an RTNL holder, userspace LACP peers, slow notifiers and
>> test-only allocation failures under KASAN and lockdep to check recovery,
>> concurrent member changes and teardown. All 16 bonding selftests passed.
>>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
>> ---
> [...]
>
>>
>>   drivers/net/bonding/bond_3ad.c  |  8 ++-
>>   drivers/net/bonding/bond_main.c | 90 ++++++++++++++++++++-------------
>>   include/net/bonding.h           |  8 ++-
>>   3 files changed, 63 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
>> index d91533b80996..d5db0070f44e 100644
>> --- a/drivers/net/bonding/bond_3ad.c
>> +++ b/drivers/net/bonding/bond_3ad.c
>> @@ -2616,8 +2616,8 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
>>   	rcu_read_unlock();
>>   	spin_unlock_bh(&bond->mode_lock);
>>   
>> -	if (update_slave_arr)
>> -		bond_slave_arr_work_rearm(bond, 0);
>> +	if (update_slave_arr && bond_update_slave_arr(bond, NULL))
>> +		bond_slave_arr_work_rearm(bond, 1);
>>   
>>   	if (should_notify_rtnl && rtnl_trylock()) {
>>   		bond_slave_state_notify(bond);
>> @@ -2816,9 +2816,7 @@ void bond_3ad_handle_link_change(struct slave *slave, char link)
>>   		  port->actor_port_number,
>>   		  link == BOND_LINK_UP ? "UP" : "DOWN");
>>   
>> -	/* RTNL is held and mode_lock is released so it's safe
>> -	 * to update slave_array here.
>> -	 */
>> +	/* mode_lock is released; the array update may sleep. */
>>   	bond_update_slave_arr(slave->bond, NULL);
>>   }
> I still don't understand why we use such a complex approach to fix this
> small corner-case waiting issue. Can't we just wait for the usable slaves
> like the following way (not tested)?
>
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index d91533b80996..39ecf7f569d3 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -2555,6 +2555,8 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
>          struct port *port;
>          bool should_notify_rtnl = BOND_SLAVE_NOTIFY_LATER;
>          bool update_slave_arr = false;
> +       struct bond_up_slave *usable;
> +       unsigned int count;
>
>          /* Lock to protect data accessed by all (e.g., port->sm_vars) and
>           * against running with bond_3ad_unbind_slave. ad_rx_machine may run
> @@ -2564,8 +2566,12 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
>          rcu_read_lock();
>
>          /* check if there are any slaves */
> -       if (!bond_has_slaves(bond))
> +       usable = rcu_dereference(bond->usable_slaves);
> +       count = usable ? READ_ONCE(usable->count) : 0;
> +       if (!bond_has_slaves(bond) || !count) {
> +               update_slave_arr = true;
>                  goto re_arm;
> +       }
>
>          if (bond_agg_timer_advance(bond)) {
>                  slave = bond_first_slave_rcu(bond);
An empty array before LACP enables any ports is normal. Waiting for it to
become non-empty before running the state machines would introduce
a circular dependency: those state machines must first enable the ports

before the builder can populate the array.

I agree that we should keep the fix as simple as possible. Regarding this
corner-case, any suggestions are welcome for discussion.

---

Thanks,
Yun Lu

>
> Thanks
> Hangbin
>>   
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index 7019e5d8fdc8..46fe74372cb8 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1175,7 +1175,6 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
>>   /* must be called in RCU critical section or with RTNL held */
>>   static bool bond_should_notify_peers(struct bonding *bond)
>>   {
>> -	struct bond_up_slave *usable;
>>   	struct slave *slave = NULL;
>>   
>>   	if (!bond->send_peer_notif ||
>> @@ -1189,8 +1188,14 @@ static bool bond_should_notify_peers(struct bonding *bond)
>>   	 * It is safe to only check bond mode here.
>>   	 */
>>   	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
>> -		usable = rcu_dereference_rtnl(bond->usable_slaves);
>> -		if (!usable || !READ_ONCE(usable->count))
>> +		struct bond_up_slave *usable;
>> +		bool can_notify;
>> +
>> +		rcu_read_lock();
>> +		usable = rcu_dereference(bond->usable_slaves);
>> +		can_notify = usable && READ_ONCE(usable->count);
>> +		rcu_read_unlock();
>> +		if (!can_notify)
>>   			return false;
>>   	} else {
>>   		slave = rcu_dereference_rtnl(bond->curr_active_slave);
>> @@ -2332,10 +2337,17 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>>   			bpf_prog_inc(bond->xdp_prog);
>>   	}
>>   
>> +	/* Publish only after all fallible setup, including XDP, is complete. */
>> +	mutex_lock(&bond->slave_arr_lock);
>> +	new_slave->array_ready = true;
>> +	mutex_unlock(&bond->slave_arr_lock);
>> +
>>   	/* broadcast mode uses the all_slaves to loop through slaves. */
>>   	if (bond_mode_can_use_xmit_hash(bond) ||
>> -	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
>> -		bond_update_slave_arr(bond, NULL);
>> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST) {
>> +		if (bond_update_slave_arr(bond, NULL) && netif_running(bond_dev))
>> +			bond_slave_arr_work_rearm(bond, 1);
>> +	}
>>   
>>   	bond_xdp_set_features(bond_dev);
>>   
>> @@ -4399,8 +4411,11 @@ static int bond_open(struct net_device *bond_dev)
>>   			static_branch_inc(&bond_bcast_neigh_enabled);
>>   	}
>>   
>> -	if (bond_mode_can_use_xmit_hash(bond))
>> -		bond_update_slave_arr(bond, NULL);
>> +	if (bond_mode_can_use_xmit_hash(bond) ||
>> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST) {
>> +		if (bond_update_slave_arr(bond, NULL))
>> +			bond_slave_arr_work_rearm(bond, 1);
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -5068,35 +5083,24 @@ static netdev_tx_t bond_xmit_activebackup(struct sk_buff *skb,
>>   	return bond_tx_drop(bond_dev, skb);
>>   }
>>   
>> -/* Use this to update slave_array when (a) it's not appropriate to update
>> - * slave_array right away (note that update_slave_array() may sleep)
>> - * and / or (b) RTNL is not held.
>> - */
>> +/* Retry failed array updates without requiring RTNL. */
>>   void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay)
>>   {
>>   	queue_delayed_work(bond->wq, &bond->slave_arr_work, delay);
>>   }
>>   
>> -/* Slave array work handler. Holds only RTNL */
>> +/* Retry failed array updates; the builder acquires slave_arr_lock. */
>>   static void bond_slave_arr_handler(struct work_struct *work)
>>   {
>>   	struct bonding *bond = container_of(work, struct bonding,
>>   					    slave_arr_work.work);
>>   	int ret;
>>   
>> -	if (!rtnl_trylock())
>> -		goto err;
>> -
>>   	ret = bond_update_slave_arr(bond, NULL);
>> -	rtnl_unlock();
>>   	if (ret) {
>>   		pr_warn_ratelimited("Failed to update slave array from WT\n");
>> -		goto err;
>> +		bond_slave_arr_work_rearm(bond, 1);
>>   	}
>> -	return;
>> -
>> -err:
>> -	bond_slave_arr_work_rearm(bond, 1);
>>   }
>>   
>>   static void bond_skip_slave(struct bond_up_slave *slaves,
>> @@ -5128,7 +5132,10 @@ static void bond_set_slave_arr(struct bonding *bond,
>>   {
>>   	struct bond_up_slave *usable, *all;
>>   
>> -	all = rtnl_dereference(bond->all_slaves);
>> +	lockdep_assert_held(&bond->slave_arr_lock);
>> +
>> +	all = rcu_dereference_protected(bond->all_slaves,
>> +					lockdep_is_held(&bond->slave_arr_lock));
>>   	rcu_assign_pointer(bond->all_slaves, all_slaves);
>>   	kfree_rcu(all, rcu);
>>   
>> @@ -5137,7 +5144,8 @@ static void bond_set_slave_arr(struct bonding *bond,
>>   		return;
>>   	}
>>   
>> -	usable = rtnl_dereference(bond->usable_slaves);
>> +	usable = rcu_dereference_protected(bond->usable_slaves,
>> +					   lockdep_is_held(&bond->slave_arr_lock));
>>   	rcu_assign_pointer(bond->usable_slaves, usable_slaves);
>>   	kfree_rcu(usable, rcu);
>>   }
>> @@ -5147,26 +5155,28 @@ static void bond_reset_slave_arr(struct bonding *bond)
>>   	bond_set_slave_arr(bond, NULL, NULL);
>>   }
>>   
>> -/* Build the usable slaves array in control path for modes that use xmit-hash
>> - * to determine the slave interface -
>> - * (a) BOND_MODE_8023AD
>> - * (b) BOND_MODE_XOR
>> - * (c) (BOND_MODE_TLB || BOND_MODE_ALB) && tlb_dynamic_lb == 0
>> +/* Rebuild both transmit arrays for 802.3ad, XOR, TLB/ALB and broadcast.
>>    *
>> - * The caller is expected to hold RTNL only and NO other lock!
>> + * Serializes writers and array_ready commits with slave_arr_lock.
>> + * Walks the lower list under RCU; membership may change concurrently.
>> + * The caller must be in sleepable context without mode_lock or RCU held.
>>    */
>>   int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
>>   {
>>   	struct bond_up_slave *usable_slaves = NULL, *all_slaves = NULL;
>>   	struct slave *slave;
>>   	struct list_head *iter;
>> +	unsigned int count;
>>   	int agg_id = 0;
>>   	int ret = 0;
>>   
>>   	might_sleep();
>> +	mutex_lock(&bond->slave_arr_lock);
>>   
>> -	usable_slaves = kzalloc_flex(*usable_slaves, arr, bond->slave_cnt);
>> -	all_slaves = kzalloc_flex(*all_slaves, arr, bond->slave_cnt);
>> +	/* Enslave counts before committing; release updates before uncounting. */
>> +	count = READ_ONCE(bond->slave_cnt);
>> +	usable_slaves = kzalloc_flex(*usable_slaves, arr, count);
>> +	all_slaves = kzalloc_flex(*all_slaves, arr, count);
>>   	if (!usable_slaves || !all_slaves) {
>>   		ret = -ENOMEM;
>>   		goto out;
>> @@ -5188,8 +5198,8 @@ int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
>>   		agg_id = ad_info.aggregator_id;
>>   	}
>>   	rcu_read_lock();
>> -	bond_for_each_slave(bond, slave, iter) {
>> -		if (skipslave == slave)
>> +	bond_for_each_slave_rcu(bond, slave, iter) {
>> +		if (skipslave == slave || !slave->array_ready)
>>   			continue;
>>   
>>   		all_slaves->arr[all_slaves->count++] = slave;
>> @@ -5211,17 +5221,21 @@ int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave)
>>   	rcu_read_unlock();
>>   
>>   	bond_set_slave_arr(bond, usable_slaves, all_slaves);
>> -	return ret;
>> +	goto out_unlock;
>>   out:
>>   	if (ret != 0 && skipslave) {
>> -		bond_skip_slave(rtnl_dereference(bond->all_slaves),
>> +		bond_skip_slave(rcu_dereference_protected(bond->all_slaves,
>> +							  lockdep_is_held(&bond->slave_arr_lock)),
>>   				skipslave);
>> -		bond_skip_slave(rtnl_dereference(bond->usable_slaves),
>> +		bond_skip_slave(rcu_dereference_protected(bond->usable_slaves,
>> +							  lockdep_is_held(&bond->slave_arr_lock)),
>>   				skipslave);
>>   	}
>>   	kfree_rcu(all_slaves, rcu);
>>   	kfree_rcu(usable_slaves, rcu);
>>   
>> +out_unlock:
>> +	mutex_unlock(&bond->slave_arr_lock);
>>   	return ret;
>>   }
>>   
>> @@ -5986,6 +6000,7 @@ static void bond_destructor(struct net_device *bond_dev)
>>   	if (bond->wq)
>>   		destroy_workqueue(bond->wq);
>>   
>> +	mutex_destroy(&bond->slave_arr_lock);
>>   	free_percpu(bond->rr_tx_counter);
>>   }
>>   
>> @@ -6073,7 +6088,9 @@ static void bond_uninit(struct net_device *bond_dev)
>>   	mutex_destroy(&bond->ipsec_lock);
>>   #endif /* CONFIG_XFRM_OFFLOAD */
>>   
>> +	mutex_lock(&bond->slave_arr_lock);
>>   	bond_set_slave_arr(bond, NULL, NULL);
>> +	mutex_unlock(&bond->slave_arr_lock);
>>   
>>   	list_del_rcu(&bond->bond_list);
>>   
>> @@ -6486,6 +6503,7 @@ static int bond_init(struct net_device *bond_dev)
>>   	if (!bond->wq)
>>   		return -ENOMEM;
>>   
>> +	mutex_init(&bond->slave_arr_lock);
>>   	bond->notifier_ctx = false;
>>   
>>   	spin_lock_init(&bond->stats_lock);
>> diff --git a/include/net/bonding.h b/include/net/bonding.h
>> index 598d56b1bc97..71ded1491c41 100644
>> --- a/include/net/bonding.h
>> +++ b/include/net/bonding.h
>> @@ -23,6 +23,7 @@
>>   #include <linux/etherdevice.h>
>>   #include <linux/reciprocal_div.h>
>>   #include <linux/if_link.h>
>> +#include <linux/mutex.h>
>>   
>>   #include <net/bond_3ad.h>
>>   #include <net/bond_alb.h>
>> @@ -177,6 +178,7 @@ struct slave {
>>   	u32    speed;
>>   	u16    queue_id;
>>   	u8     perm_hwaddr[MAX_ADDR_LEN];
>> +	bool   array_ready; /* Enslave complete; protected by slave_arr_lock. */
>>   	int    prio;
>>   	struct ad_slave_info *ad_info;
>>   	struct tlb_slave_info tlb_info;
>> @@ -210,8 +212,8 @@ struct bond_ipsec {
>>   };
>>   
>>   /*
>> - * Here are the locking policies for the two bonding locks:
>> - * Get rcu_read_lock when reading or RTNL when writing slave list.
>> + * Slave list changes hold RTNL; lockless readers use RCU iteration.
>> + * Array writers and array_ready commits hold slave_arr_lock.
>>    */
>>   struct bonding {
>>   	struct   net_device *dev; /* first - useful for panic debug */
>> @@ -220,6 +222,8 @@ struct bonding {
>>   	struct   slave __rcu *primary_slave;
>>   	struct   bond_up_slave __rcu *usable_slaves;
>>   	struct   bond_up_slave __rcu *all_slaves;
>> +	/* Serializes TX array writers and array_ready commits. */
>> +	struct mutex slave_arr_lock;
>>   	bool     force_primary;
>>   	bool     notifier_ctx;
>>   	s32      slave_cnt; /* never change this value outside the attach/detach wrappers */
>>
>> base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
>> -- 
>> 2.43.0
>>

