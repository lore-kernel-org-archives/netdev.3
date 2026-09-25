Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AF377566
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317969; cv=none; b=GIJHKn9hFfQG2zDNHwwVxjgz7vovejzBHw/c9/WwtDEHNF/teXzMKpRoJyZnV5cZCVxIl7qjpJX8XA+CWT/mdF9JFSXSID3gBdgg2Fu/gdKzv0xCSjx5H16/zTXDbYv6drbJMxQR54TrBVFjg3cLewFDD61dkxVzKBjfikyXd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317969; c=relaxed/simple;
	bh=fm/3M5mAtPvG7VsZk7fDi4sR3JVWU92RpK+KkyNlFhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzH3CZqNL1njPZ8ryzFmkxpQB8qoLt5nnfNs0Huu0tIwi3Aerz9FDo5aX0ycnhzgmRlyKtOkNUF6XjCyPZvW3XPRy0o8B4JPw2Q4xz8ODVm2dp0DUIVHzolDRI7hY2Bm5Qn+wIMfSxi5SbIopSiWBRzWhidgZ0mGdDj8OU0UaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kVm9/7jA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kVm9/7jA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a27q102333;
	Fri, 25 Sep 2026 06:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m/ANME
	YPgG385PQSInkNPJDmbPIupCxAlee0x0YGUyo=; b=kVm9/7jA17F7MCQmkGTJ3u
	G5FkvOYvuOwVoJiq42AlRURaD/sehrbNTkzSUmvuRQJyEKkwciW9iHFpF0dVjzUL
	1Jh37NF2vBBlFI4cpesgdSZsoCLVb7GiYx1XiM0x4kvnDPwBzYtbhEivYVgbGlSG
	xYmp7HlQcWfy5r5T90p7I+YPV0EA9kzzAMjylvlfLHjFwogMfZtd2pmjk8AV3CB5
	5COCNQbxjnUqdlq3BSI7Np98Li+HEmlmsQP4BtQ2pU6tEHhx6MSynPSONwi+PTsz
	EhsZ7FFtGw9PjsC4si0/M37Yimo7AUS/WNu3Hupeb+x+nSxWa/Fqpm2/seQAhUVA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvmns9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:32:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lYUd1959522;
	Fri, 25 Sep 2026 06:32:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7edjmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:32:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P6WM6062652672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:32:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 825D058065;
	Fri, 25 Sep 2026 06:32:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C882158066;
	Fri, 25 Sep 2026 06:32:19 +0000 (GMT)
Received: from [9.67.88.81] (unknown [9.67.88.81])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 06:32:19 +0000 (GMT)
Message-ID: <e8d863f8-fd53-4533-9313-ca062bb741f2@linux.ibm.com>
Date: Thu, 24 Sep 2026 23:32:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v6,08/15] ibmveth: Add queue-aware RX buffer submit
 helper for MQ
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <67e54ccb114103077cff17be317440d3a869045d.1788102125.git.mmc@linux.ibm.com>
 <178845903725.3394541.11473132587510780583@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <178845903725.3394541.11473132587510780583@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lmfHARuI9gIXQNs-j6wByafjmwMQXXR5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXwJxo7O1ScbPC
 fOB1N5vfRc/uOb4VpzAHWTvk6rkmu3cY8LOBtADWupeGDPuPWoKNVqJ+R/snRlwt8fCcpv02u+l
 WNhkRtUe8AeDXC+mtsxb48s/kAN8uAU=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab6157a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Gz3F54sD2VatwCWgPb0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AbDF4q0w7INAEQCSBGNcPO4owNQb8I0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX/Lr8hfkGmpBg
 BYxItGGNY54KWcbm2njEYWiNiN5ObKGWi/7CrdKfhtwcEGPIZmhkAH2tgCnqXhxI1745IFCy5/v
 VIfCgYvHVswhAHfgkMeHLszdNiPL1ZDlvjMBaBqehEhRg/8IbJ/SqhPpzpKWY4uoQ3TKFrbqO6+
 bk9z351VP4stysf/9XbLlr8cd/k+GvW5eTFnBpYTedopucsKXd+U00P4vRHyaUypd8eRiH1sDku
 4jLPd4LKea4O0voIfI/7kG9htPCB6+KVDcT69XNa8tazTcHfOSokmpaNPqcdts47p9Zc1vg/ykB
 5eXTF9gKUC8U9sIAm/466PBATv7I70m+4tcFcm16XkLUMccozlAi5zqJNblfK/DfQpDZZbNT4HZ
 8xX+SeRoxRqUKFarV1ROyG6UrkepDNpGfMvW8xvKn92KfPcPbWXS5vDp5DPY6VppY8iDpZz7Rb7
 BcjpUUQ0L8+rwLsHmFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250024


On 9/3/26 11:10 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider:
>
> Critical: 0 · High: 1 · Medium: 2 (1) · Low: 3
>
> - [High] (Discarded — resolved later in this series.) In ibmveth_poll()
>    at this commit, when ibmveth_rxq_get_buffer() rejects a correlator it…
> - [Medium] Removing the WARN_ON()+schedule_work() recovery from
>    ibmveth_remove_buffer_from_pool() leaves one live RX path with no…
> - [Medium] ibmveth_replenish_task() wraps the entire multi-pool replenish
>    loop in spin_lock_irqsave(&rxq->replenish_lock, flags), so up to…
> - [Low] The patch contains a user-visible robustness fix (replacing the
>    correlator WARN_ON()s that could take the partition down under…
> - [Low] The hcall-failure log in ibmveth_replenish_task() reconstructs
>    the wrapper name from fail.batch (`fail.batch == 1 ?
> - [Low] The kernel-doc Return block of ibmveth_remove_buffer_from_pool()
>    still documents only '-EINVAL - correlator maps to pool or index out…
>
> Pre-existing issues:
> - [Medium] (Discarded — reachability closed later in this series.) The
>    new per-queue replenish_lock is taken by the replenish producer and by…
>
> --
>
> ibmveth: Add queue-aware RX buffer submit helper for MQ
>
> This adds ibmveth_add_logical_lan_buffers() so RX pool replenishment can
> go through H_ADD_LOGICAL_LAN_BUFFERS_QUEUE in multi-queue mode, and
> parameterises the RX accessors, harvest and replenish paths by queue
> index. It also adds a per-queue replenish_lock, converts
> ibmveth_replenish_buffer_pool() to return an outcome that is logged after
> the unlock, and replaces the correlator WARN_ON()s with
> ibmveth_rxq_correlator_valid().
>
> A few questions on the correlator error handling, the replenish critical
> section and the failure log below.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 465330464f916..46f68f5b52e70 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -712,11 +722,100 @@ static inline void ibmveth_flush_buffer(void *addr, unsigned long length)
> [ ... ]
>
>> +	} else if (filled == 1) {
>> +		rc = h_add_logical_lan_buffer(vdev->unit_address,
>> +					      descs[0].desc);
>> +	} else {
>> +		/* Legacy 8-desc hcall; probe/mq_fallback keep batch <=
>> +		 * IBMVETH_MAX_RX_REGULAR.
>> +		 */
>> +		rc = h_add_logical_lan_buffers(vdev->unit_address,
>> +					       descs[0].desc, descs[1].desc,
>> +					       descs[2].desc, descs[3].desc,
>> +					       descs[4].desc, descs[5].desc,
>> +					       descs[6].desc, descs[7].desc);
>> +	}
> [ ... ]
>
>> @@ -899,21 +1000,85 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
>>   }
>>   
>>   /* replenish routine */
>> -static void ibmveth_replenish_task(struct ibmveth_adapter *adapter)
>> +static void ibmveth_replenish_task(struct ibmveth_adapter *adapter,
>> +				   int queue_index)
>>   {
>> -	int i;
>> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
>> +	struct ibmveth_replenish_fail fail = {};
>> +	unsigned long flags;
>> +	int i, rc;
>> +	int need_reset = 0;
>> +	int batch_fallback = 0;
>> +	int hcall_fail = 0;
>> +
>> +	if (queue_index >= adapter->num_rx_queues) {
>> +		netdev_dbg(adapter->netdev,
>> +			   "Skipping replenish for freed queue %d (num_queues=%u)\n",
>> +			   queue_index, adapter->num_rx_queues);
>> +		return;
>> +	}
>>   
>>   	adapter->replenish_task_cycles++;
>>   
>> -	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
>> -		struct ibmveth_buff_pool *pool = &adapter->rx_buff_pool[0][i];
>> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
> [Severity: Medium]
> Is it intended that the whole multi-pool replenish loop now runs with
> hardware interrupts disabled?
>
> The lock is taken here and released only after all five pools have been
> walked, and ibmveth_replenish_buffer_pool() allocates and maps every
> buffer inside that region:
>
> 	skb = netdev_alloc_skb(adapter->netdev, pool->buff_size);
> 	...
> 	dma_addr = dma_map_single_attrs(dev, skb->data, pool->buff_size,
> 					DMA_FROM_DEVICE, DMA_ATTR_NO_WARN);
>
> With pool_count[] = { 256, 512, 256, 256, 256 } that is up to roughly
> 1536 allocations plus iommu mappings with interrupts masked on a cold
> refill, for example ibmveth_open() -> ibmveth_restart_rx_queue() ->
> ibmveth_replenish_task() where available is 0 for every pool. Before this
> patch replenish ran from NAPI with interrupts enabled.
>
> There is also a second-order concern about the netconsole rationale in
> the commit message. ibmveth_poll_controller() calls
> ibmveth_replenish_task(adapter, 0), and netpoll_send_skb() has already
> done local_irq_save() by then, so this CPU can enter the region from
> netpoll. DMA_ATTR_NO_WARN and moving the logging out of the lock cover
> the iommu and the driver printks, but netdev_alloc_skb() for the large
> pools takes the __alloc_skb()/slab path, which is not blanket
> __GFP_NOWARN. If that allocator warning is emitted while netconsole is
> bound to this device, can it re-enter ndo_poll_controller ->
> ibmveth_replenish_task() -> spin_lock_irqsave() on the lock this CPU
> already holds?
Yes, it can: the whole fill still runs under
irqsave. v6 already moved
the driver logs out of the lock and passed
DMA_ATTR_NO_WARN so the iommu path cannot printk
under it. netdev_alloc_skb() can still warn, and that
can re-enter.

Shortening irqsave here is the same leftover as
locking free_buffer_pool() and calling
netpoll_poll_disable() on close. That is a
lock-protocol rewrite, not two conditions.
poll_controller already runs with IRQs off, so
this is not a drop-in lock_bh. Doing one of
those alone just moves the race, so I am
taking them together after this series.
>>   
>> -		if (pool->active &&
>> -		    (atomic_read(&pool->available) < pool->threshold))
>> -			ibmveth_replenish_buffer_pool(adapter, pool);
>> +	for (i = (IBMVETH_NUM_BUFF_POOLS - 1); i >= 0; i--) {
>> +		struct ibmveth_buff_pool *pool =
>> +			&adapter->rx_buff_pool[queue_index][i];
>> +
>> +		if (pool->active && pool->free_map &&
>> +		    (atomic_read(&pool->available) < pool->threshold)) {
>> +			rc = ibmveth_replenish_buffer_pool(adapter, pool,
>> +							   queue_index, &fail);
>> +			switch (rc) {
>> +			case IBMVETH_REPLENISH_RESET_MAP:
>> +			case IBMVETH_REPLENISH_RESET_MQ:
>> +				need_reset = rc;
>> +				goto out_unlock;
>> +			case IBMVETH_REPLENISH_BATCH_FALLBACK:
>> +				batch_fallback = 1;
>> +				break;
>> +			case IBMVETH_REPLENISH_HCALL_FAIL:
>> +				hcall_fail = 1;
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
>>   	}
>>   
>> +out_unlock:
>>   	ibmveth_update_rx_no_buffer(adapter);
>> +
>> +	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
> [ ... ]
>
>> +	if (hcall_fail)
>> +		dev_warn_ratelimited(&adapter->netdev->dev,
>> +				     "RX %s failed: filled=%u, rc=%lu, batch=%u\n",
>> +				     adapter->multi_queue ?
>> +				     "h_add_logical_lan_buffers_queue" :
>> +				     (fail.batch == 1 ?
>> +				      "h_add_logical_lan_buffer" :
>> +				      "h_add_logical_lan_buffers"),
>> +				     fail.filled, fail.lpar_rc, fail.batch);
> [Severity: Low]
> Should the wrapper name here be selected from fail.filled rather than
> fail.batch?
>
> ibmveth_add_logical_lan_buffers() dispatches on filled:
>
> 	} else if (filled == 1) {
> 		rc = h_add_logical_lan_buffer(vdev->unit_address,
> 					      descs[0].desc);
>
> So when adapter->rx_buffers_per_hcall is 8 (firmware with
> IBMVETH_ILLAN_RX_MULTI_BUFF_SUPPORT) and the fill loop stops at
> filled == 1 because remaining was 1, netdev_alloc_skb() failed or
> dma_mapping_error() hit after the first descriptor, the call that failed
> is h_add_logical_lan_buffer() but the log prints
> h_add_logical_lan_buffers. fail.filled already records the right
> discriminator.
>
> Related: fail is a single struct reused across the pool loop while
> batch_fallback and hcall_fail are sticky flags, so if two pools fail in
> one invocation, do the printed filled/rc/batch values only describe the
> last failure?
v7 names the wrapper from filled, so a
last-buffer single add prints the single
hcall. One fail struct is still shared, so
two pool failures leave only the last
filled/rc/batch. That struct stays as it
is in this patch.
> This is still the case at the end of the series.
>
>>   }
>>   
>>   /* empty and free ana buffer pool - also used to do cleanup in error paths */
>> @@ -948,6 +1113,12 @@ static void ibmveth_free_buffer_pool(struct ibmveth_adapter *adapter,
>>   		kfree(pool->skbuff);
>>   		pool->skbuff = NULL;
>>   	}
>> +
>> +	/*
>> +	 * Keep probe/sysfs geometry (active, size, buff_size, threshold).
>> +	 * Only tear down runtime allocations; open reuses active pools.
>> +	 */
>> +	atomic_set(&pool->available, 0);
>>   }
> [Severity: Medium]
> This is a pre-existing pattern and not introduced by this patch, but with
> the new replenish_lock it is worth a note.
>
> ibmveth_free_buffer_pool() kfree()s free_map, skbuff and dma_addr and
> does atomic_set(&pool->available, 0) without taking
> rxq->replenish_lock, while the new tests in ibmveth_replenish_task()
> and ibmveth_rxq_correlator_valid():
>
> 	if (pool->active && pool->free_map &&
> 	...
> 	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
>
> are check-then-use against that teardown.
>
> Tracing it through, the window looks closed at the end of the series:
> ibmveth_poll_controller() returns early on !adapter->opened,
> ibmveth_close() clears opened first, then calls
> ibmveth_cleanup_rx_interrupts() and synchronize_net() before
> ibmveth_free_buffer_pools(), and netpoll runs ndo_poll_controller with
> hard interrupts disabled, so a netpoll section that observed
> opened == true is waited out by that synchronize_net(). Would it be worth
> documenting that free_buffer_pool() relies on the opened flag plus
> synchronize_net() rather than on replenish_lock, since it writes state
> the lock otherwise protects?
I am leaving that undocumented for now.
free_buffer_pool() still does not take
replenish_lock, so a comment that says it
relies on opened plus synchronize_net() would
overclaim. close() does clear opened and wait before
it frees the pools, but that is not the same as
holding the lock. Taking the lock in free belongs
with shortening irqsave, not a kdoc line here.

>>   
>>   /**
>> @@ -1088,35 +1259,74 @@ ibmveth_free_buffer_pools(struct ibmveth_adapter *adapter)
>>   		   adapter->num_rx_queues);
>>   }
>>   
>> +static bool ibmveth_rxq_correlator_valid(struct ibmveth_adapter *adapter,
>> +					 int queue_index, u64 correlator)
>> +{
>> +	unsigned int pool = correlator >> 32;
>> +	unsigned int index = correlator & 0xffffffffUL;
>> +	struct ibmveth_buff_pool *bpool;
>> +
>> +	if (pool >= IBMVETH_NUM_BUFF_POOLS)
>> +		return false;
>> +
>> +	bpool = &adapter->rx_buff_pool[queue_index][pool];
>> +
>> +	/* Require a live pool with allocated arrays before indexing.
>> +	 * Inactive pools still have size from init; free clears skbuff.
>> +	 */
>> +	if (!bpool->active || !bpool->skbuff || !bpool->free_map)
>> +		return false;
>> +
>> +	return index < bpool->size;
>> +}
> [Severity: Low]
> This isn't a bug, but this helper is a standalone robustness fix bundled
> into an MQ feature patch. The commit message says a malformed correlator
> with panic_on_warn set "would take the partition down", which is a
> user-visible fix that stable trees would want, and the WARN_ON()s being
> replaced here and in ibmveth_rxq_get_buffer() came from commit
> 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are
> detected").
>
> Could the correlator validation be split into its own patch with a
> Fixes: 2c91e2319ed9 tag, so it can be identified independently of the
> queue plumbing?
I am keeping the helper here. It is wired into
the queue-indexed harvest, remove, and get_buffer
paths, so a Fixes: peel would not be a clean
cherry-pick of just the WARN_ON() change. There is
no Fixes: tag. The commit message already says
WARN_ON() was the wrong tool.
>> +
>> +static void ibmveth_rxq_advance(struct ibmveth_rx_q *rxq)
>> +{
>> +	if (++rxq->index == rxq->num_slots) {
>> +		rxq->index = 0;
>> +		rxq->toggle = !rxq->toggle;
>> +	}
>> +}
>> +
>>   /**
>>    * ibmveth_remove_buffer_from_pool - remove a buffer from a pool
>>    * @adapter: adapter instance
>>    * @correlator: identifies pool and index
>> + * @queue_index: RX queue index (0..num_rx_queues-1)
>>    * @reuse: whether to reuse buffer
>>    *
>> + * Context: may run concurrently with netpoll replenish_task on the same
>> + * queue; takes per-queue replenish_lock to serialize free_map /
>> + * producer_index / available against the producer.
>> + *
>>    * Return:
>>    * * %0       - success
>>    * * %-EINVAL - correlator maps to pool or index out of range
>>    * * %-EFAULT - pool and index map to null skb
> [Severity: Low]
> Does this Return block still describe all the -EINVAL cases?
>
> ibmveth_rxq_correlator_valid() also returns false, mapped to -EINVAL
> here, when bpool->active is 0 or when bpool->skbuff or bpool->free_map
> are NULL. That is a deactivated or torn-down pool, not a correlator
> "out of range", and callers react to -EINVAL by advancing the ring as
> if the slot were corrupt, so the distinction is visible in behaviour.
>
> The two updated tests, ibmveth_remove_buffer_from_pool_test() and
> ibmveth_rxq_get_buffer_test(), also exercise none of the three new
> predicates: they allocate free_map and rely on the pool being active, so
> they pass identically with or without the new checks. Would it be worth
> adding cases for active == 0 and for skbuff/free_map being NULL?
>
> The doc block is unchanged at the end of the series.
Yes — -EINVAL is also an inactive or not-live pool,
not only "out of range." v7 names that on the
Return line. Callers already skip both the same
way. I am not adding extra KUnit cases for
active==0 / NULL-array; v6 already gives the
fixtures a dummy free_map so the range and
-EFAULT paths are live again.

>>    */
>>   static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>> -					   u64 correlator, bool reuse)
>> +					   u64 correlator, int queue_index,
>> +					   bool reuse)
>>   {
>> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
>>   	unsigned int pool  = correlator >> 32;
>>   	unsigned int index = correlator & 0xffffffffUL;
>>   	unsigned int free_index;
>>   	struct sk_buff *skb;
>> +	unsigned long flags;
>> +	int rc = 0;
>>   
>> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
>> -	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
>> -		schedule_work(&adapter->work);
>> -		return -EINVAL;
>> +	spin_lock_irqsave(&rxq->replenish_lock, flags);
>> +
>> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
>> +		rc = -EINVAL;
>> +		goto out_unlock;
>>   	}
>>   
>> -	skb = adapter->rx_buff_pool[0][pool].skbuff[index];
>> -	if (WARN_ON(!skb)) {
>> -		schedule_work(&adapter->work);
>> -		return -EFAULT;
>> +	skb = adapter->rx_buff_pool[queue_index][pool].skbuff[index];
>> +	if (!skb) {
>> +		rc = -EFAULT;
>> +		goto out_unlock;
>>   	}
> [Severity: Medium]
> Can this leak RX pool capacity permanently on a bad correlator?
>
> The goto out_unlock skips both the free_map push and the
> atomic_dec(&pool->available) that the success path performs, and the
> schedule_work(&adapter->work) that used to accompany the WARN_ON()s is
> gone from this function.
>
> The callers treat -EINVAL/-EFAULT as "slot skipped, keep going".
> ibmveth_rxq_harvest_buffer() advances the ring anyway:
>
> 	if (unlikely(rc)) {
> 		/* Skip a corrupt slot without claiming pool ownership. */
> 		if (rc == -EINVAL || rc == -EFAULT)
> 			ibmveth_rxq_advance(rxq);
> 		return rc;
> 	}
>
> and ibmveth_drain_rx_queue() counts it as drained:
>
> 		/* -EINVAL/-EFAULT already advanced past the slot. */
> 		if (rc == -EINVAL || rc == -EFAULT) {
> 			drained++;
> 			continue;
> 		}
>
> The invalid-buffer recycle branch of ibmveth_poll() is the concrete live
> path, since it never calls ibmveth_rxq_get_buffer() and so nothing
> schedules a reset there.
>
> Given that ibmveth_replenish_buffer_pool() computes
>
> 	u32 remaining = pool->size - atomic_read(&pool->available);
>
> and ibmveth_replenish_task() only refills while available < threshold,
> does each occurrence permanently shrink the usable ring, until replenish
> stops firing for that pool altogether? For the -EINVAL case the
> DMA-mapped skb also stays in pool->skbuff[] with its free_map entry left
> at IBM_VETH_INVALID_MAP until teardown.
>
> The pre-patch code performed a close/open reset here, which reconciled
> the driver bookkeeping with PHYP. Should these paths still request a
> reset, or correct available, when the correlator is rejected?
On -EINVAL/-EFAULT the helper does not push free_map
or drop available. Harvest still advances the ring.
I am not putting schedule_work() back in
remove_buffer_from_pool: drain runs from close and
resize, and a reset from there is wrong. Patch 9
skip_bad already resets when get_buffer() returns
NULL. Recycle and drain stay advance-only.
> At the end of the series this is unchanged in effect:
> ibmveth_poll_harvest_slot() returns true for -EINVAL/-EFAULT and
> ibmveth_poll_recycle_invalid() schedules nothing, while only
> ibmveth_poll_skip_bad_correlator() schedules the reset.
>
>>   
>>   	/* if we are going to reuse the buffer then keep the pointers around
>> @@ -1127,75 +1337,88 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
> [ ... ]
>
>> -	free_index = adapter->rx_buff_pool[0][pool].producer_index;
>> -	adapter->rx_buff_pool[0][pool].producer_index++;
>> -	if (adapter->rx_buff_pool[0][pool].producer_index >=
>> -	    adapter->rx_buff_pool[0][pool].size)
>> -		adapter->rx_buff_pool[0][pool].producer_index = 0;
>> -	adapter->rx_buff_pool[0][pool].free_map[free_index] = index;
>> +	free_index = adapter->rx_buff_pool[queue_index][pool].producer_index;
>> +	adapter->rx_buff_pool[queue_index][pool].producer_index++;
>> +	if (adapter->rx_buff_pool[queue_index][pool].producer_index >=
>> +	    adapter->rx_buff_pool[queue_index][pool].size)
>> +		adapter->rx_buff_pool[queue_index][pool].producer_index = 0;
>> +	adapter->rx_buff_pool[queue_index][pool].free_map[free_index] = index;
>>   
>>   	mb();
>>   
>> -	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>> +	atomic_dec(&adapter->rx_buff_pool[queue_index][pool].available);
>>   
>> -	return 0;
>> +out_unlock:
>> +	spin_unlock_irqrestore(&rxq->replenish_lock, flags);
>> +	return rc;
>>   }
>>   
>>   /* get the current buffer on the rx queue */
>> -static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
>> +static struct sk_buff *
>> +ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter,
>> +		       int queue_index)
>>   {
>> -	struct ibmveth_rx_q *rxq = &adapter->rx_queue[0];
>> +	struct ibmveth_rx_q *rxq = &adapter->rx_queue[queue_index];
>>   	u64 correlator = rxq->queue_addr[rxq->index].correlator;
>>   	unsigned int pool = correlator >> 32;
>>   	unsigned int index = correlator & 0xffffffffUL;
>>   
>> -	if (WARN_ON(pool >= IBMVETH_NUM_BUFF_POOLS) ||
>> -	    WARN_ON(index >= adapter->rx_buff_pool[0][pool].size)) {
>> +	if (!ibmveth_rxq_correlator_valid(adapter, queue_index, correlator)) {
>>   		schedule_work(&adapter->work);
>>   		return NULL;
>>   	}
> [ ... ]
>
>> @@ -2161,34 +2384,41 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
> [ ... ]
>
>> -			skb = ibmveth_rxq_get_buffer(adapter);
>> +			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
>>   			if (unlikely(!skb))
>>   				break;
> [ ... ]
>
>> @@ -2265,14 +2501,18 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
> [ ... ]
>
>> -	if (ibmveth_rxq_pending_buffer(adapter) && napi_schedule(napi)) {
>> -		ibmveth_disable_irq(adapter, 0);
>> +	if (ibmveth_rxq_pending_buffer(adapter, queue_index) &&
>> +	    napi_schedule(napi)) {
>> +		ibmveth_disable_irq(adapter, queue_index);
>>   		goto restart_poll;
>>   	}
> [Severity: High]
> At this commit, can ibmveth_poll() spin here forever after
> ibmveth_rxq_get_buffer() rejects a correlator?
>
> Unlike ibmveth_rxq_harvest_buffer(), ibmveth_rxq_get_buffer() returns
> NULL without advancing the ring, and the caller just breaks:
>
> 			skb = ibmveth_rxq_get_buffer(adapter, queue_index);
> 			if (unlikely(!skb))
> 				break;
>
> rxq->index and rxq->toggle are untouched, so
> ibmveth_rxq_pending_buffer() is still true, napi_schedule() succeeds and
> poll jumps back to restart_poll on the same slot. The reset queued by
> ibmveth_rxq_get_buffer() cannot break the cycle either, because
> ibmveth_reset() -> dev_close() -> napi_disable() waits for this poll to
> finish.
>
> The following patch in the series, "ibmveth: Harden RX poll path with
> helpers", replaces this bare break with
> ibmveth_poll_skip_bad_correlator(), which schedules the reset and calls
> ibmveth_poll_harvest_slot() so the slot is advanced, so the loop is gone
> by the end of the series. Would it be better to fold that handling into
> this patch, so the intermediate commit is not bisectable into a softirq
> loop?
>
> [ ... ]
Folded into this patch: when get_buffer() returns
NULL, ibmveth_rxq_advance() advances past the slot
before breaking, so poll makes progress and does not
spin at this commit. Patch 9 then refactors that path
into the dedicated skip_bad_correlator helper.

Thanks,
Mingming
