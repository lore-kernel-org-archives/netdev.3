Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83254E1C89;
	Mon, 19 Oct 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416323; cv=none; b=NEeBdD42cud4Dz9INPFzQ0zvH5ik7VVMXzS12KgOR9E9yaAruhIBCrT9OdR5EzImYFig6QyKXFfYL8awL/szEjcOrr6vbCaqfiA0LVj+krA2BqhZShl7zoVAYndqiSX7QHm8e6B8zKAcsEbUOGkJhh783lRxu9KfXzS/MNnhFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416323; c=relaxed/simple;
	bh=ciGkzYf7HS6uGLjHRuHBjASnQc1bHyOvMs2kKwQPtxQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ovfmuef/PN3k5pX3HVG9O6E0tcIFWCIWWuKJhuin+PpoAx4r3dRgM17nnAWUwXwm88ULKHkZbE77RrZovVj8vcADjhG+PRadoX/7LoPLFgLapNzkqgcnENWrQ1mJUxPUrqGvWcf44p+aRT7YP6Z8FwuhVUd6qwck3pLO+nPIFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=O6uIyf6H; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="O6uIyf6H"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IuyFyFTfK91dFEs1eeytp1vHwe7TSh0ZYXlX3z8DGxM=;
	b=O6uIyf6H6O0QdK9Kd3k09DrgE9OHMT8QRQ1hKw0eM202gANuv4s1hPNJkhh2EGeQ5h6sG41Jo
	/H6nkQaIMSeIyNg/GvSm7qd9Qs8eIkjQME7XLw/t9zT5If/JlVV8ikR4YGsEePCszLDc6D2zlLa
	AWo+DW1xbY8D/nN4unW7jNQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4j7brQ0N9Bzcb48;
	Mon, 19 Oct 2026 21:25:10 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9857E40575;
	Mon, 19 Oct 2026 21:25:16 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 21:25:15 +0800
Message-ID: <65b3d30b-8f40-4441-a290-10a45004b054@huawei.com>
Date: Mon, 19 Oct 2026 21:25:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: fix use-after-free in debugfs read
 during reset/unload
To: <netdev-bot+sashiko@kernel.org>
References: <20260915132434.1141742-4-shaojijie@huawei.com>
 <178983224991.22033.11290112238743369174@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <178983224991.22033.11290112238743369174@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/9/19 23:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 · Medium: 3 · Low: 1
>
> - [High] On the PF side the new locking is inoperative.
> - [Medium] The commit message justifies the change with "The seq_file
>    refactoring of hns3 debugfs removed the per-file entry state checks"…
> - [Medium] The new device-busy gate is added to only one of the two
>    helpers that produce the output of the single `vlan_config` debugfs…
> - [Medium] The reader/writer handshake the patch relies on has no
>    publication ordering on the reset-reinitialization side.
> - [Low] The Fixes: tag cites only eced3d1c41db ("net: hns3: use seq_file
>    for files in queue/ in debugfs"), which is the correct origin for the…
>
> --
>
> net: hns3: fix use-after-free in debugfs read during reset/unload
>
> This adds a new mutex (dbg_mutex) to struct hnae3_handle, has the debugfs
> show callbacks take it plus a device-busy state check at entry and per
> loop iteration, and has the enet teardown/ring-resize paths take it before
> freeing rings and vectors. Two hclge (PF layer) debugfs callbacks also
> take the same mutex through hdev->vport[0].nic.
>
> Closes: https://lore.kernel.org/all/a0853cd9-cab5-441d-b181-8ba97f2f58b0@huawei.com/
>
> A few questions on the commit message and the code below.
>
>>      The seq_file refactoring of hns3 debugfs removed the per-file entry
>>      state checks. Without them, debugfs show callbacks can access
>>      priv->ring, priv->tqp_vector, and ring->desc while these resources
>>      are being freed by reset, driver unload, or ethtool ring resize.
> [Severity: Medium]
> Does this description cover the hclge_debugfs.c part of the patch?  At the
> baseline, grepping hclge_debugfs.c for HCLGE_STATE_RST_HANDLING or any
> test_bit(HCLGE_STATE...) returns no matches, so there were no per-file
> state checks there to be removed by the seq_file conversion.  The two
> guarded PF callbacks also do not touch priv->ring, priv->tqp_vector or
> ring->desc; they read hdev->* and hdev->vport[] and issue firmware
> commands, and hdev->vport is only freed in hclge_uninit_ae_dev().
>
> The selection also looks arbitrary.  Of the roughly fifty
> hclge_dbg_dump_* seq_file callbacks registered in hclge_dbg_cmd_func[],
> only hclge_dbg_dump_umv_info() and hclge_dbg_dump_vlan_offload_config()
> gained the new guard, while structurally identical ones that read
> hdev-owned state during reset (hclge_dbg_dump_tm_*, hclge_dbg_dump_fd_*,
> hclge_dbg_dump_mng_table, hclge_dbg_dump_mac_uc/mc, the register dumps)
> were left alone.
>
> If the PF layer needs this protection, should the rest of the callbacks
> get it too?  If it does not, could the hclge_debugfs.c hunks be dropped?

Right — the commit message omits the hclge_debugfs.c changes

Will be fixed in v2. The hclge_debugfs.c hunks will be removed entirely
(see High #1).

>
>>      Fixes: eced3d1c41db ("net: hns3: use seq_file for files in queue/ in debugfs")
> [Severity: Low]
> This tag matches the hns3_debugfs.c (enet) change, but the seq_file
> conversion of hclge_dbg_dump_umv_info() blames to 9e1545b48818e0
> ("net: hns3: use seq_file for debugfs in umv_info and vlan_config"-era
> sibling commit by Yonglong Liu), not to eced3d1c41db.  Should a second
> Fixes: tag be added so the hclge_debugfs.c hunks can be mapped to the
> commit that introduced them?

Resolved by removing the hclge_debugfs.c changes in v2. Only the one Fixes:
(eced3d1c41db) remains.

>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
>> index 4286af9239b01..e94cc33da8643 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
>> @@ -944,6 +944,7 @@ struct hnae3_handle {
>>   
>>   	u8 netdev_flags;
>>   	struct dentry *hnae3_dbgfs;
>> +	struct mutex dbg_mutex;	/* protect debugfs against reset/unload */
>>   
>>   	/* Network interface message level enabled bits */
>>   	u32 msg_enable;
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> index 1347edac76993..7d913302f4424 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> @@ -389,6 +389,12 @@ static const char * const dim_state_str[] = { "START", "IN_PROG", "APPLY" };
>>   static const char * const
>>   dim_tune_stat_str[] = { "ON_TOP", "TIRED", "RIGHT", "LEFT" };
>>   
>> +static bool hns3_dbg_is_device_busy(struct hns3_nic_priv *priv)
>> +{
>> +	return !test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
>> +	       test_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
>> +}
>> +
> [ ... ]
>
>> @@ -504,22 +524,16 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
>>   	struct hns3_enet_ring *ring;
>>   	u32 i;
>>   
>> -	if (!priv->ring) {
>> -		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
>> -		return -EFAULT;
>> -	}
>> +	guard(mutex)(&priv->ae_handle->dbg_mutex);
>> +	if (hns3_dbg_is_device_busy(priv))
>> +		return -EBUSY;
> [ ... ]
>
>> @@ -604,9 +612,14 @@ static int hns3_dbg_queue_map(struct seq_file *s, void *data)
>>   
>>   	seq_puts(s, "local_queue_id  global_queue_id  vector_id\n");
>>   
>> +	guard(mutex)(&priv->ae_handle->dbg_mutex);
>> +	if (hns3_dbg_is_device_busy(priv))
>> +		return -EBUSY;
>> +
>>   	for (i = 0; i < h->kinfo.num_tqps; i++) {
>> -		if (!priv->ring || !priv->ring[i].tqp_vector)
>> -			continue;
>> +		if (hns3_dbg_is_device_busy(priv))
>> +			return -EBUSY;
>> +
>>   		seq_printf(s, "%-16u%-17u%d\n", i,
>>   			   h->ae_algo->ops->get_global_queue_id(h, i),
>>   			   priv->ring[i].tqp_vector->vector_irq);
> [Severity: Medium]
> Is the reader/writer handshake ordered on the reinitialization side?
>
> The teardown side does what the changelog describes:
>
> hns3_reset_notify_uninit_enet()
> 	test_and_clear_bit(HNS3_NIC_STATE_INITED, &priv->state);
> 	guard(mutex)(&handle->dbg_mutex);
> 	...
> 	hns3_put_ring_config(priv);	/* priv->ring = NULL */
>
> But the reinit side never takes dbg_mutex and publishes with a plain
> bitop:
>
> hns3_reset_notify_init_enet()
> 	... rebuilds priv->ring, priv->tqp_vector, descriptors ...
> 	set_bit(HNS3_NIC_STATE_INITED, &priv->state);
>
> hns3_reset_notify_up_enet()
> 	clear_bit(HNS3_NIC_STATE_RESETTING, &priv->state);
>
> Non-returning bitops carry no memory barriers
> (Documentation/atomic_bitops.txt), and since the initializer never holds
> dbg_mutex, the reader's mutex acquisition pairs only with the teardown
> release, which stored priv->ring = NULL.  On a weakly ordered machine can
> a reader observe INITED set and RESETTING clear while still reading the
> stale priv->ring, and then dereference priv->ring[i].tqp_vector here?
>
> The "!priv->ring || !priv->ring[i].tqp_vector" test that used to absorb
> that case is being deleted in this hunk, as are the "if (!priv->ring)"
> guards in hns3_dbg_rx_queue_info(), hns3_dbg_tx_queue_info() and
> hns3_dbg_page_pool_info().  Would either keeping those NULL checks or
> having hns3_reset_notify_init_enet() publish under dbg_mutex (or with
> release/acquire semantics) close this?

All priv->ring writes and NULL assignments happen under dbg_mutex. The
three paths setting priv->ring = NULL (hns3_put_ring_config in uninit and
reset) hold the mutex. After the mutex + busy check, priv->ring cannot be
NULL — the check is redundant.

No change in v2. The if (!priv->ring) checks will be removed.

>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 0c088feae03ca..bae8b32ffc5b8 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> [ ... ]
>
>> @@ -5875,6 +5880,7 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
>>   		return 0;
>>   	}
>>   
>> +	guard(mutex)(&handle->dbg_mutex);
>>   	hns3_free_rx_cpu_rmap(netdev);
>>   	hns3_nic_uninit_irq(priv);
>>   	hns3_clear_all_ring(handle, true);
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
>> index 9a4e29bfa1666..1e9d3e08b7ded 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
>> @@ -15,6 +15,12 @@
>>   #define hclge_seq_file_to_hdev(s)	\
>>   		(((struct hnae3_ae_dev *)hnae3_seq_file_to_ae_dev(s))->priv)
>>   
>> +static bool hclge_dbg_is_device_busy(struct hclge_dev *hdev)
>> +{
>> +	return test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
>> +	       test_bit(HCLGE_STATE_RST_FAIL, &hdev->state);
>> +}
>> +
>>   static const char * const hclge_mac_state_str[] = {
>>   	"TO_ADD", "TO_DEL", "ACTIVE"
>>   };
>> @@ -2621,6 +2627,10 @@ static int hclge_dbg_dump_umv_info(struct seq_file *s, void *data)
>>   	struct hclge_vport *vport;
>>   	u8 i;
>>   
>> +	guard(mutex)(&hdev->vport[0].nic.dbg_mutex);
>> +	if (hclge_dbg_is_device_busy(hdev))
>> +		return -EBUSY;
>> +
> [Severity: High]
> Does this mutex exclude anything on the PF side?
>
> Grepping the driver for dbg_mutex after this patch gives:
>
>    hnae3.h:1
>    hns3_debugfs.c:6
>    hns3_enet.c:6
>    hns3_ethtool.c:1
>    hns3pf/hclge_debugfs.c:2
>
> hclge_main.c has no matches, so no writer of the state these two
> callbacks read ever takes dbg_mutex:
>
> hclge_reset_service_task()
> 	down(&hdev->reset_sem);
> 	set_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
> 	hclge_reset_subtask(hdev);
> 	clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
>
> and hclge_reset_err_handle() sets HCLGE_STATE_RST_FAIL the same way.  The
> only reset-side acquisition is hns3_reset_notify_uninit_enet(), which
> covers priv->ring and priv->tqp_vector, not the UMV counters or the
> per-function VLAN offload registers read here.
>
> So isn't hclge_dbg_is_device_busy() here exactly the check-then-use
> window the changelog says the mutex removes?  A reader admitted before
> RST_HANDLING is set keeps issuing cmdq queries across the reset boundary
> and prints values sampled from both sides of it.
>
> Two follow-on questions:
>
> Does the comment on the new struct member, "protect debugfs against
> reset/unload", hold for hclge state given the above?
>
> Does taking dbg_mutex and then hdev->vport_lock here create a new lock
> order that the writer side is not aware of?

You are correct. The dbg_mutex protects enet-layer resources (priv->ring,
priv->tqp_vector), not the hdev->* fields and firmware commands accessed by
the PF callbacks. The mutex in hclge_debugfs.c adds false protection.

Will be fixed in v2. All hclge_debugfs.c changes will be removed — the
patch will focus exclusively on the enet-layer UAF.

The lock ordering concern (dbg_mutex → vport_lock) also goes away with this.

>
>> @@ -2831,6 +2841,10 @@ static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev,
>>   	int ret;
>>   	u8 i;
>>   
>> +	guard(mutex)(&hdev->vport[0].nic.dbg_mutex);
>> +	if (hclge_dbg_is_device_busy(hdev))
>> +		return -EBUSY;
>> +
> [Severity: Medium]
> Should the gate be in the show callback instead of in this helper?
>
> Both halves of the single vlan_config file run from one callback:
>
> hclge_dbg_dump_vlan_config()
> 	ret = hclge_dbg_dump_vlan_filter_config(hdev, s);
> 	if (ret)
> 		return ret;
>
> 	return hclge_dbg_dump_vlan_offload_config(hdev, s);
>
> hclge_dbg_dump_vlan_filter_config() issues
> hclge_get_vlan_filter_state() and
> hclge_get_port_vlan_filter_bypass_state() for every function and emits
> its section with no mutex and no state check, so reading vlan_config
> during a reset still runs that half against the resetting device and only
> then returns -EBUSY from the second half.  Since seq_read_iter() resets
> m->count to the record offset on a negative show() return, the output the
> first half produced is discarded and the read fails anyway.
>
> Also, unlike the enet readers, this loop holds dbg_mutex across
> 2 * (pci_num_vf() + 1) synchronous firmware commands with no
> per-iteration busy re-check.  Given that the reset path reaches
> guard(mutex)(&handle->dbg_mutex) via
>
>    hclge_reset_rebuild() -> rtnl_lock() -> hclge_reset_stack() ->
>    hclge_notify_client(HNAE3_UNINIT_CLIENT) ->
>    hns3_reset_notify_uninit_enet()
>
> can a PF debugfs reader stall the reset, and rtnl_lock with it, for the
> duration of the dump?  The changelog says the per-iteration check keeps
> reset latency bounded, which does not appear to apply to these two PF
> callbacks.
>
>>   	seq_puts(s, "FUNC_ID  PVID  ACCEPT_TAG1  ACCEPT_TAG2 ACCEPT_UNTAG1  ");
>>   	seq_puts(s, "ACCEPT_UNTAG2  INSERT_TAG1  INSERT_TAG2  SHIFT_TAG  ");
>>   	seq_puts(s, "STRIP_TAG1  STRIP_TAG2  DROP_TAG1  DROP_TAG2  ");
