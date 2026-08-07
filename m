Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C673D668F;
	Fri,  7 Aug 2026 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087899; cv=none; b=flzEnIem652wc0fEh+LGorKGJI4l3OnqTzSB1O7IEyTlDx4mgmZV4WcqfosMgaMmFv5ZJDlDv9S6TXU3+SelSLMWksRi+hNZ/ucB4NTEGyzEFiryXgX4EOqPzKuccOKyUanVa4vPDQwphE6xxdhurTbL7eaS+pESIGeCOuKff6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087899; c=relaxed/simple;
	bh=gWYMTravi6J1ujglmq43Nf6wA63KanIvyglqo75iMOo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nHpQcAVBA5u18jwOk04crJ8N71UfgogKRnnGALjy+Sr8zo+mSV2LCGdITCzFXD28GYQAwl9eodsItWllvn6F04Yu4UzUEqtb1wCrexcJvJWuPQGMmSkJ5whJU4d/voPikQXnq3NUhaOKkylQ3g8IqOmrz4uFEuwaFl+QaahzEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=m4+OYVBE; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="m4+OYVBE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XJfbMXmicAHDVkXqJ6RBetOoW0V/tdcBFHHBcJNStYI=;
	b=m4+OYVBEc9rThowjPO97CCSN+2PGeNFqBe1dfMBiyRuYqSuKaWwEs8c+igu9QtBuoOCXM4R9P
	p0YKElDlLPD4KJ2DWdXPXiYvZLcxVXCIBHRq/sjv3JQ/l42/0GqA6dEWrbKCFkjM4tjmEum0dB6
	1xfkAArbKnv1PqL3fEBQaHA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hGbDF1hnpzcb4c;
	Fri,  7 Aug 2026 15:21:17 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 20D314058C;
	Fri,  7 Aug 2026 15:31:15 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 15:31:14 +0800
Message-ID: <cdfb3eb1-2b11-4162-a875-7e39a356b2b0@huawei.com>
Date: Fri, 7 Aug 2026 15:31:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: hns3: use txqueue parameter directly in
 ndo_tx_timeout
To: Simon Horman <horms@kernel.org>
References: <20260804130933.880552-4-shaojijie@huawei.com>
 <20260805165236.606858-1-horms@kernel.org>
 <4fd1475d-8800-4402-862d-f8b12d48424b@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <4fd1475d-8800-4402-862d-f8b12d48424b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/8/6 19:39, Jijie Shao wrote:
>
> on 2026/8/6 0:52, Simon Horman wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> Full review at: 
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=3
>> ---
>> --- Patch [3]: [PATCH net-next 3/3] net: hns3: use txqueue parameter 
>> directly in ndo_tx_timeout ---
>> commit 0b583f65b44c7357ff4dab7e2ce6b5d624acc178
>> Author: Jian Shen <shenjian15@huawei.com>
>>
>> net: hns3: use txqueue parameter directly in ndo_tx_timeout
>>
>> This changes hns3_nic_net_timeout() to pass the txqueue index 
>> supplied by
>> the ndo_tx_timeout callback down to hns3_get_tx_timeo_queue_info() 
>> instead
>> of rescanning every TX queue with hns3_get_timeout_queue().  The old
>> scanning loop is turned into hns3_dump_timeout_queue(), which now only
>> prints DQL and queue state information for the given queue.
>>
>>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c 
>>> b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> index 6ecb32e28e79a..d0656289d68e5 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>>> @@ -2825,32 +2825,25 @@ static int hns3_nic_change_mtu(struct 
>>> net_device *netdev, int new_mtu)
>>>       return ret;
>>>   }
>>>   -static int hns3_get_timeout_queue(struct net_device *ndev)
>>> +static void hns3_dump_timeout_queue(struct net_device *ndev,
>>> +                    unsigned int txqueue)
>>>   {
>>> -    unsigned int i;
>>> -
>>> -    /* Find the stopped queue the same way the stack does */
>>> -    for (i = 0; i < ndev->num_tx_queues; i++) {
>>> -        unsigned int timedout_ms;
>>> -        struct netdev_queue *q;
>>> +    unsigned int timedout_ms;
>>> +    struct netdev_queue *q;
>>>   -        q = netdev_get_tx_queue(ndev, i);
>>> -        timedout_ms = netif_xmit_timeout_ms(q);
>>> -        if (timedout_ms) {
>>> +    q = netdev_get_tx_queue(ndev, txqueue);
>>> +    timedout_ms = netif_xmit_timeout_ms(q);
>>> +    if (timedout_ms) {
>> [Severity: Medium]
>> [Finding: main-1-0]
>> [Sources: opus-5]
>> Was the change in meaning of the netif_xmit_timeout_ms() test 
>> intentional?
>>
>> Before this patch the return value of that test decided whether the 
>> driver
>> would act at all.  hns3_get_timeout_queue() only returned an index for a
>> queue whose netif_xmit_timeout_ms() was still non-zero, otherwise it
>> returned ndev->num_tx_queues and hns3_get_tx_timeo_queue_info() returned
>> false, so hns3_nic_net_timeout() skipped reset_event() and left
>> priv->tx_timeout_count alone.
>>
>> After the patch that same test only gates the two netdev_info() 
>> prints in
>> hns3_dump_timeout_queue(), and the caller continues on regardless.
>>
>> The stall really can clear between the watchdog detecting it and this
>> callback running.  netif_xmit_timeout_ms() -> netif_xmit_stopped() only
>> tests QUEUE_STATE_ANY_XOFF, while netif_freeze_queues() in 
>> dev_watchdog()
>> sets only __QUEUE_STATE_FROZEN, and hns3_clean_tx_ring() clears DRV_XOFF
>> from NAPI context without dev->tx_global_lock:
>>
>> drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:hns3_clean_tx_ring() {
>>     ...
>>     if (netif_tx_queue_stopped(dev_queue) &&
>>         !test_bit(HNS3_NIC_STATE_DOWN, &priv->state)) {
>>         netif_tx_wake_queue(dev_queue);
>>     ...
>> }
>>
>> In that window, does this now request an hclge reset_event() 
>> (function or
>> port reset, so a link flap) for a queue that has already recovered, 
>> where
>> previously it just logged and returned?
>>
>>>   #ifdef CONFIG_BQL
>>> -            struct dql *dql = &q->dql;
>>> +        struct dql *dql = &q->dql;
>>>   -            netdev_info(ndev, "DQL info last_cnt: %u, queued: %u, 
>>> adj_limit: %u, completed: %u\n",
>>> -                    dql->last_obj_cnt, dql->num_queued,
>>> -                    dql->adj_limit, dql->num_completed);
>>> +        netdev_info(ndev, "DQL info last_cnt: %u, queued: %u, 
>>> adj_limit: %u, completed: %u\n",
>>> +                dql->last_obj_cnt, dql->num_queued,
>>> +                dql->adj_limit, dql->num_completed);
>>>   #endif
>>> -            netdev_info(ndev, "queue state: 0x%lx, delta msecs: %u\n",
>>> -                    q->state, timedout_ms);
>>> -            break;
>>> -        }
>>> +        netdev_info(ndev, "queue state: 0x%lx, delta msecs: %u\n",
>>> +                q->state, timedout_ms);
>>>       }
>>> -
>>> -    return i;
>>>   }
>>>     static void hns3_dump_queue_stats(struct net_device *ndev,
>>> @@ -2900,25 +2893,25 @@ static void hns3_dump_queue_reg(struct 
>>> net_device *ndev,
>>>                         HNS3_RING_TX_RING_EBD_OFFSET_REG));
>>>   }
>>>   -static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev)
>>> +static bool hns3_get_tx_timeo_queue_info(struct net_device *ndev,
>>> +                     unsigned int txqueue)
>>>   {
>>>       struct hns3_nic_priv *priv = netdev_priv(ndev);
>>>       struct hnae3_handle *h = hns3_get_handle(ndev);
>>>       struct hns3_enet_ring *tx_ring;
>>> -    u32 timeout_queue;
>>>   -    timeout_queue = hns3_get_timeout_queue(ndev);
>>> -    if (timeout_queue >= ndev->num_tx_queues) {
>>> +    if (txqueue >= ndev->num_tx_queues) {
>>>           netdev_info(ndev,
>>>                   "no netdev TX timeout queue found, timeout count: 
>>> %llu\n",
>>>                   priv->tx_timeout_count);
>>>           return false;
>>>       }
>> [Severity: Medium]
>> [Finding: main-1-0]
>> [Sources: opus-5]
>> With the index now coming from the caller, can this branch still be 
>> taken?
>> dev_watchdog() in net/sched/sch_generic.c is the only in-tree caller of
>> ndo_tx_timeout and it always passes an i it obtained from a loop 
>> bounded by
>> dev->num_tx_queues:
>>
>> net/sched/sch_generic.c:dev_watchdog() {
>>     ...
>>             netif_freeze_queues(dev);
>>             dev->netdev_ops->ndo_tx_timeout(dev, i);
>>     ...
>> }
>>
>> If so, the "no netdev TX timeout queue found" message is unreachable 
>> and its
>> wording no longer matches what the test checks.  Would it be worth 
>> either
>> dropping it or rewording it as an index sanity check?
>>
>> Also, the commit message only mentions "Use it directly instead of 
>> iterating
>> all tx queues to find the timed out one" and does not mention that the
>> re-check no longer gates the reset request.  Could that behaviour 
>> change be
>> described there?
>>
>>> +    hns3_dump_timeout_queue(ndev, txqueue);
>>>         priv->tx_timeout_count++;
>>>   -    tx_ring = &priv->ring[timeout_queue];
>>> -    hns3_dump_queue_stats(ndev, tx_ring, timeout_queue);
>>> +    tx_ring = &priv->ring[txqueue];
>>> +    hns3_dump_queue_stats(ndev, tx_ring, txqueue);
>> [Severity: High]
>> [Finding: main-2-1]
>> [Sources: opus-5]
>> This isn't a bug introduced by this patch, since the removed
>> hns3_get_timeout_queue() loop used the same bound and the same check 
>> before
>> indexing priv->ring[], but since the validation is being rewritten 
>> here it
>> may be a good spot to fix it.
>>
>> Is ndev->num_tx_queues the right bound for indexing priv->ring[]?
>> ndev->num_tx_queues is the hardware maximum fixed at probe time in
>> hns3_client_init():
>>
>>     netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv), 
>> alloc_tqps);
>>
>> while priv->ring is sized from h->kinfo.num_tqps in 
>> hns3_get_ring_config(),
>> and only the first num_tqps entries are initialized:
>>
>>     priv->ring = devm_kzalloc(&pdev->dev,
>>                   array3_size(h->kinfo.num_tqps,
>>                           sizeof(*priv->ring), 2),
>>                   GFP_KERNEL);
>>     ...
>>     for (i = 0; i < h->kinfo.num_tqps; i++)
>>         hns3_queue_to_ring(h->kinfo.tqp[i], priv);
>>
>> kinfo.num_tqps equals real_num_tx_queues (see 
>> hns3_nic_set_real_num_queue())
>> and can be smaller than alloc_tqps, for example with fewer CPUs than 
>> TQPs or
>> after ethtool -L.
>>
>> dev_watchdog() scans dev->num_tx_queues rather than real_num_tx_queues:
>>
>> net/sched/sch_generic.c:dev_watchdog() {
>>     ...
>>         for (i = 0; i < dev->num_tx_queues; i++) {
>>             struct netdev_queue *txq;
>>
>>             txq = netdev_get_tx_queue(dev, i);
>>             if (!netif_xmit_stopped(txq))
>>                 continue;
>>     ...
>> }
>>
>> and hns3_link_status_change() marks all num_tx_queues queues stopped 
>> without
>> dev->tx_global_lock:
>>
>>     netif_carrier_off(netdev);
>>     netif_tx_stop_all_queues(netdev);
>>
>> A link-down concurrent with a watchdog scan can therefore hand back 
>> an index
>> in [kinfo.num_tqps, num_tx_queues), since those queues have never
>> transmitted and have trans_start == 0.  Does that then read past the
>> devm_kzalloc'ed ring array and dereference a garbage 
>> tx_ring->tqp_vector, in
>> hns3_dump_queue_stats():
>>
>>     struct napi_struct *napi = &tx_ring->tqp_vector->napi;
>>
>> and in hns3_dump_queue_reg():
>>
>>             readl(tx_ring->tqp_vector->mask_addr));
>>
>> Would ndev->real_num_tx_queues (or h->kinfo.num_tqps) be the correct 
>> bound
>> for the check above?
>
> Regarding the bound check on priv->ring[]:
> This is not introduced by this patch — the removed 
> hns3_get_timeout_queue()
> loop used the same bound (num_tx_queues)
> and the same check before indexing priv->ring[].
>                       We have not encountered the OOB issue 
> internally. Preliminary
> analysis suggests it is not reachable in current code:
>
> - dev_watchdog() is gated by netif_carrier_ok(), and
> hns3_link_status_change() sets carrier_off before
> netif_tx_stop_all_queues() on link down.
> - netif_tx_stop_queue() pairs trans_start=jiffies with XOFF, so
> time_after(jiffies, trans_start + watchdog_timeo) is false right
> after stop.
>
> I will analyze the TOCTOU path in more detail myself. If a real
> issue exists, it will be addressed by a separate bugfix.
>
>
>
> Regarding the unreachable "no netdev TX timeout queue found" branch
> and the now-redundant re-check:
>
> dev_watchdog() always passes a valid index bounded by num_tx_queues,
> so the branch is unreachable. The re-check was incidental to the
> scanning loop, not an intentional gate. v2 will drop both.
>
> Thanks,
> Jijie Shao


Hi Simon,

I'd like to note that the actual v2 implementation differs slightly
from what I described in my previous reply:

1. The netif_xmit_timeout_ms() re-check is kept, not dropped.
  After discussion with colleagues, we decided to preserve the
  existing behaviour: if the stall has cleared by the time the
  callback runs, no reset is requested.  This keeps the semantics
  consistent with the code before this patch.

2. The "no netdev TX timeout queue found" branch is also kept,
  now guarding against txqueue >= num_tqps.

3. The bounds check is changed from ndev->num_tx_queues to
  h->kinfo.num_tqps in this patch rather than a separate bugfix.
  The OOB has not been encountered in practice, but since the
  validation is already being rewritten here, folding the fix
  in avoids an artificial split.

v2 will be sent shortly.

Thanks,
Jijie Shao


