Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472B44237A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390834; cv=none; b=TZZcw2Wqlp9o2gHk0S7vD/lHGqLFRewj5eQIpSQOSjbYNXvDGFN4zisUoT7YAGbuSrWzATztMFwK5V4dP5UvNM/vCE1Ptd/sDAadLSSI8fMmt55w49WnjJu2qIZVksmndshBk/kGfnoZaM+oeeV9Hxr47bBqCNGgUVRs2Xqp3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390834; c=relaxed/simple;
	bh=DjQes21fwRAXgPVXccX0a1axS0lr/xS6VVRJL/Caels=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+79sOkUIR/7AlcVVklY15VDW9eSH/4xC4qawcDTLitiBvs3F3PyTtccvWLyFW3IxmO+MYaQRc9ZeG1aB6EjiggL4qapM9UDLml66c9+mzDzT6uHQO4Km8jez3XqaiNaQU3JqEbPjfyljwlNKnYxZuFibTo9oSbnIzaWrQtFjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cLh9VD8y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cLh9VD8y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2RgV614215;
	Mon, 10 Aug 2026 19:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EiK8Nc
	/8g9e5BOlFq1LqBdc5Znsmifsx/YVK5cFDjTk=; b=cLh9VD8y7khfvZlmolAg8I
	fBCt75i3MoTvGzb/W6MoXcDiPGVkTqi/AUFP5rT5eyMwdkstyDyTKNC8gNZH+3Nn
	lrjwKHnnvt6s9cvbMw6hSosM12tCdj4r51X0Q2gjfm7hC1sXCtf1xEl0wRHeSaNc
	ftD9Exx0Ac3y6jpCC+ZOis1ie11TYJwElzPFl7KsUy6nPslqLqIrav/Ey9F8wBNs
	SUnSNAnnPqne399JS1UpaA5NT3FTEzKmeK+WUQDnqahNKRQZ2s7rlZ65fAVGl2Ol
	Yt9J/+p8rBhkZwxC/FW6EUVHeEmDHUlw/SBfm5aukWrI3sakLD99ZZbSj5UTY9Hg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyssqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:40:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJQEHh031272;
	Mon, 10 Aug 2026 19:40:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxespxbea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:40:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJe72C65929722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:40:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E04B45806A;
	Mon, 10 Aug 2026 19:40:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D83258059;
	Mon, 10 Aug 2026 19:40:04 +0000 (GMT)
Received: from [9.67.152.96] (unknown [9.67.152.96])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:40:04 +0000 (GMT)
Message-ID: <5876f9ca-11cd-4184-b998-1415c4273b2e@linux.ibm.com>
Date: Mon, 10 Aug 2026 12:40:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/14] ibmveth: Prepare MQ RX adapter data
 structures
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, davemarq@linux.ibm.com
References: <5aceac43fd2da5d06bee7aba36e2983e1a7bc007.1785457143.git.mmc@linux.ibm.com>
 <20260806183659.3175041-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806183659.3175041-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX0CgBzmajG4k2
 ophgHpWx+QNHdzw9FhaiACNr6tKTp+xCy5HCYZTemq6cuhBwE2a43E6MWMv3vFLfoWVci4Vyv1d
 BzeiqnCURdNbwtFJ7tuh6ZLF8gt3z2ewZlI1lqJhz7WnIzc+GRYoHgHb+E5e1e52P47joa2N3St
 4wWHRhtKT1XHvfh0tm8WN922RLimOtRJMq5MIXod0wiU1nMP/HWrGZVHlP3lVBBi9Oqta/yULtb
 cuVzpb7wBEZ+XWEWi2EtXMFmmNGUc335zL3FiRTrwiSRyAmSpv4ENQuWxwIkgFkYerad0clgI77
 S5XqLii5K+ycnKgelDcJ0GYzdvd/nFvYvdMn7GF1qqFYtclChzFhJs1IDgRUrv9CneWMfWnNp1f
 aNxYMsUZpF3Kmi4K9XIHqDcoXH/MyjY5p5roMcIhC+1EG1mbeu0wv0WrRhsYPCsbmlVSlDNIkFp
 2koXRBry6SUBY9HBVzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX4t1Td4vTlY+S
 7s1W2YAZO+g2OlrirwmWyXxez6ft2Ne94j2izP1aRa1tSOppcXHNCFqWjx1XVBZp871ibiEviST
 ubwWqi94LShEiur3Lfy999g1IN4dSPQ=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a2919 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=TVwaTaYQaYbKLQx6PuUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vF8oThFOY9hjVpfRMMigIGkGMzKJylAN
X-Proofpoint-ORIG-GUID: nFn7Hny7cgJYZh4OcozixbeIZv9S2Q9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100166


On 8/6/26 11:36 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ibmveth: Prepare MQ RX adapter data structures
>
> This converts the single-instance RX state in struct ibmveth_adapter
> (napi, rx_queue, buffer_list_addr/dma, rx_buff_pool) into queue-indexed
> arrays sized by the new IBMVETH_MAX_RX_QUEUES, adds multi_queue and
> num_rx_queues, and mechanically rewrites all existing references to
> index 0.  IBMVETH_MAX_RX_QUEUES stays at 1 in this patch.
>
> A couple of observations below, neither of which changes runtime
> behaviour today.
Hi Jakub,

Thanks for the notes.
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 73e051d26b9d8..8e758362cb263 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -482,42 +486,44 @@ static int ibmveth_remove_buffer_from_pool(struct ibmveth_adapter *adapter,
>>   	mb();
>>   
>> -	atomic_dec(&(adapter->rx_buff_pool[pool].available));
>> +	atomic_dec(&adapter->rx_buff_pool[0][pool].available);
>>   
>>   	return 0;
>>   }
>>   
>>   /* get the current buffer on the rx queue */
>> -static inline struct sk_buff *ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
>> +static inline struct sk_buff *
>> +ibmveth_rxq_get_buffer(struct ibmveth_adapter *adapter)
> [Severity: Low]
> This isn't a bug, but the patch carries a few edits that are not part of
> the stated mechanical index-0 conversion:
>
>    - dropping the redundant parentheses in the atomic_dec() call in
>      ibmveth_remove_buffer_from_pool()
>    - reflowing the ibmveth_rxq_get_buffer() prototype
>    - rewriting the kernel-doc of ibmveth_get_desired_dma() from
>      "Return value:" to "Return:"
>    - inserting a blank line in struct ibmveth_adapter after
>      rx_large_packets
>
> The commit message says:
>
>      This patch keeps behavior unchanged by mechanically switching existing
>      references to index 0
>
> Could these cosmetic edits move to a separate cleanup patch, or be
> mentioned in the changelog?  As it stands each hunk has to first be
> classified as conversion or cleanup before the "behavior unchanged" claim
> can be confirmed.
>
> [ ... ]
Agreed. Those edits are not part of the stated index-0 conversion, so
for v5 I will drop them from patch 2. If they are still worth doing, I
can send them later as a separate cleanup patch.

>> @@ -1693,8 +1704,7 @@ static void ibmveth_poll_controller(struct net_device *dev)
>>    *
>>    * @vdev: struct vio_dev for the device whose desired IO mem is to be returned
>>    *
>> - * Return value:
>> - *	Number of bytes of IO data the driver will need to perform well.
>> + * Return: Number of bytes of IO data the driver will need to perform well.
>>    */
>>   static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>>   {
> [ ... ]
>
>> @@ -1898,10 +1912,10 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
>>   
>>   	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>> -		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
>> +		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
>>   		int error;
>>   
>> -		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i,
>> +		ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0][i], i,
>>   					 pool_count[i], pool_size[i],
>>   					 pool_active[i]);
>>   		error = kobject_init_and_add(kobj, &ktype_veth_pool,
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index c88dbeb7cd967..8eaa3942fc40b 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> [ ... ]
>
>> @@ -294,18 +296,23 @@ struct ibmveth_rx_q {
>> -	struct ibmveth_buff_pool rx_buff_pool[IBMVETH_NUM_BUFF_POOLS];
>> -	struct ibmveth_rx_q rx_queue;
>> +	struct ibmveth_buff_pool
>> +		rx_buff_pool[IBMVETH_MAX_RX_QUEUES][IBMVETH_NUM_BUFF_POOLS];
>> +	struct ibmveth_rx_q rx_queue[IBMVETH_MAX_RX_QUEUES];
> [Severity: Low]
> Is replicating the whole struct ibmveth_buff_pool per queue the layout you
> want here?
>
> struct ibmveth_buff_pool embeds a struct kobject, which is the per-pool
> sysfs tuning object.  Only row 0's kobjects are ever initialized and
> registered, in ibmveth_probe():
>
> 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> 		struct kobject *kobj = &adapter->rx_buff_pool[0][i].kobj;
> 		...
> 		error = kobject_init_and_add(kobj, &ktype_veth_pool,
> 					     &dev->dev.kobj, "pool%d", i);
>
> and only row 0's are dropped, in ibmveth_remove():
>
> 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
> 		kobject_put(&adapter->rx_buff_pool[0][i].kobj);
>
> So every row above 0 carries a kobject that is never initialized and never
> used.

Correct. Only row 0's pool kobjects are initialized; rows 1..N-1 carry
unused embedded kobjects in the current layout.

>
> Later in the series IBMVETH_MAX_RX_QUEUES is raised to 16U, at which point
> the netdev private area unconditionally holds 16 x 5 pool structs
> regardless of num_rx_queues, of which 75 embedded kobjects are dead
> weight.
>
> The follow-on code also shows that only part of the struct is really
> per-queue: ibmveth_alloc_single_rx_queue() copies size, index, buff_size,
> threshold and active from row 0 into each new row, so the pool
> configuration is shared while free_map/dma_addr/skbuff/producer_index/
> consumer_index/available are the genuinely per-queue state.
Only part of ibmveth_buff_pool is truly per-queue; the sysfs-visible
tuning fields are effectively shared in this series.
> Would it be cleaner to split the struct into one shared, sysfs-visible
> configuration object plus a small per-queue state array, given this patch
> is the one that fixes the layout for the rest of the series?

Longer term, splitting this into a shared sysfs-visible configuration
object plus smaller per-queue runtime state would be cleaner. I am
deferring that redesign for this series.

>
> Is it also intentional that the per-pool sysfs tuning interface now
> implicitly means "queue 0 configures all queues"?  If so, could that be
> stated in the changelog?
Yes, that is intentional for this series. Queue 0 is acting as the
shared pool configuration/template surface rather than as a queue-0-only
tuning interface. In v5 I will make that explicit in the changelog and
cover letter:

- only queue 0's `poolN` sysfs nodes are registered
- those nodes represent the shared pool geometry/template policy
   (`buff_size`, `size`, `active`)
- open() and resize copy that template into each RX queue's pool row
- queues 1..N do not get separate pool sysfs controls in this series

Thanks again for the review,
Mingming
