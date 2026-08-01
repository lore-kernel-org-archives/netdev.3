Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E720459A
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785591528; cv=none; b=GAbK/spbUsNtcMWYkurNyN0KNEjzRQ8J/zeV3D5NZJadK/xX6P5dOLoJvdpz3txhspsf4i6W3GrVA4oqmX6Ey7weDH18AoI8Rqppck0a9NEa4HJ54WGzcq3MWMeZNCw2OahqPcbV+Bee1yb2FQIRu5Tcx7zjxcB0ZE8vOZzhoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785591528; c=relaxed/simple;
	bh=zdrnQ3l9FKmt/jY+8TzkkZJiP8TjiI6cVjmJq7Xdm88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXqjgVUMkMTzUc4/KyE8j4/gYtBVblMzcpkS2f05m/i08h42LRq0LGmFAr23hVb3pkv1qtgi52fJ/JYBTP4fAnnLS2si46BbpTOOXvNbuADPt/0qDbSeKCUZUesBblIhO7fzsZ3nMXlixQtrj02FEmLgaN1MWewQUP1Va79NvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cGR+EkAI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cGR+EkAI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671CluLT530678;
	Sat, 1 Aug 2026 13:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wIESHt
	ogzn5j6i/lu2EnPyPcnJIkKFZQFvYcFmxNn3w=; b=cGR+EkAIdp7pUDdzlEOLXg
	pMU4xJk1w5Ja/eTauhU5hpqpRvUezIdi0DQSS+mbztoy1UFTInu0u7e1kkJv7Hba
	ICv9ot8duTalra3YHra8RKemqr9MvbCdRLAeQykZwZ/zEEnJQG+JRA91HwmFpW6f
	DUeSMoQ5u1/Ecyyh9c/C2mdl5vpA/IsE9NQqI8RAGZ39nBzM+Mf5iA3kITopWRqG
	YYFXT88pKbwDs7ZYGbJCjXt8bXmNdrWmhcXvqGYKdIwu9lsivYOk1o0wDJocgttO
	KtRq4+suzEEwuNIqPn8qXsaWHcGZ0jLHc/HtCzYfLoyGMZeXR60RImHaBFsIFkcA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fsjky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 13:38:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671DQTBV020454;
	Sat, 1 Aug 2026 13:38:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhuyqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Aug 2026 13:38:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671DcCmG26673724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 13:38:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2A55805E;
	Sat,  1 Aug 2026 13:38:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 508225805A;
	Sat,  1 Aug 2026 13:38:07 +0000 (GMT)
Received: from [9.43.78.15] (unknown [9.43.78.15])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 13:38:06 +0000 (GMT)
Message-ID: <4d8c8d92-d39b-4721-a405-f03f01fbb95b@linux.ibm.com>
Date: Sat, 1 Aug 2026 19:08:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on
 NIC queue count
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-3-nilay@linux.ibm.com>
 <amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDEwNiBTYWx0ZWRfX1m1wnhaP26qc
 w1QIo+k6ThPzOzHB/56LcZnzn2O9mvxfLEtWB8+NEON47Jy+fYIVI9sWUNrdnjC8LerwEv29agG
 6HrMhA5KeCzp4QYlQUR8mOHSMZ5nZvT/wfIPqAnDvF1UQX9GcSkI83SC4VSaOHGZqvOsFyz3G4u
 iduxHI4EHB7WgwF8PKZOp2Ux+oQ2h11QP4nnoeQKwtzbreYC7zdIZO+3fXjlxumL4n+e/vG3hux
 ndsIHmJQXT/alNwC2t0chwooXJ5ybCeQdx2JbywCfkV1FUrawOcdQ25xbU1pGQO3nwJalo+8q19
 8yYEuFB0nA8xDThzm004p6eKIYLToXJMG9W1VgoskwVmBwcObsdJEQZKNg/oJiEpJ+jGDmc7Whx
 bJU3AI4oJ9Gn5eoEAfdszn0k9naxwXEdhXlo8SmskNB8fKaaD3LZjcvQBMzRvExWohYTtneCvqp
 4bxr+k/xfaBLcjD0YOQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a6df6c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=aMWKNPPrY3l4frADnwgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0GINZJXb1emB-tyswGNAvS63eZgRzV9n
X-Proofpoint-ORIG-GUID: KKmcVjFBnMI5x9n-jRkuu5K0QyGirEaj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDEwNiBTYWx0ZWRfX3S2Diqhl2ELn
 ApCsYoWcQxAnuQB5SvDfRQR6vqF5/eedHB4d+jw5VbWk2UXZJ0f1uoV4loPXMlx7KTz3LPYn/9r
 ePM6ABqz2nUboPTHMFV1TDwUprkkmaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_01,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010106

On 7/31/26 10:11 PM, Stanislav Fomichev wrote:
> On 07/31, Nilay Shroff wrote:
>> NVMe-TCP currently provisions I/O queues based primarily on the number
>> of online CPUs. On systems where the CPU count significantly exceeds the
>> number of NIC hardware queues, multiple NVMe-TCP I/O queues end up
>> sharing the same NIC TX/RX queues. This increases lock contention,
>> cacheline bouncing, and inter-processor interrupts (IPIs), reducing I/O
>> efficiency.
>>
>> Limit the number of NVMe-TCP default I/O queues to the smaller of the
>> number of online CPUs and the number of NIC hardware queues. Aligning
>> the number of NVMe-TCP I/O queues with the NIC queue topology reduces
>> queue sharing, improves locality, and can improve throughput while
>> reducing tail latency.
>>
>> The number of NVMe-TCP I/O queues is now limited to:
>>
>>      min(num_online_cpus, num_nic_queues)
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/tcp.c | 61 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index ba5c7b3e2a7c..a2110287099e 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1774,6 +1774,50 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>>   	return ret;
>>   }
>>   
>> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl,
>> +		netdevice_tracker *tracker, gfp_t gfp)
>> +{
>> +	struct net_device *dev = NULL;
>> +
>> +	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
>> +		dev = netdev_get_by_name(&init_net, ctrl->opts->host_iface,
>> +				tracker, gfp);
>> +	else {
>> +		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
>> +		struct sockaddr_storage *src = NULL, *dest = NULL;
>> +
>> +		if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
>> +			src = &tctrl->src_addr;
>> +
>> +		dest = &tctrl->addr;
>> +
>> +		dev = netdev_get_by_addr(&init_net, src, dest, tracker, gfp);
>> +	}
>> +	return dev;
>> +}
>> +
>> +/*
>> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
>> + * be determined.
>> + */
>> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
>> +{
>> +	struct net_device *dev;
>> +	int tx_queues, rx_queues;
>> +	netdevice_tracker tracker;
>> +
>> +	dev = nvme_tcp_get_netdev(ctrl, &tracker, GFP_KERNEL);
>> +	if (!dev)
>> +		return 0;
>> +
>> +	tx_queues = dev->real_num_tx_queues;
>> +	rx_queues = dev->real_num_rx_queues;
>> +
>> +	netdev_put(dev, &tracker);
>> +
>> +	return min(tx_queues, rx_queues);
>> +}
>> +
>>   static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>>   				key_serial_t pskid)
>>   {
>> @@ -2165,6 +2209,23 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>>   	unsigned int nr_io_queues;
>>   	int ret;
> 
> [..]
>   
>> +	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES)) {
>> +		int nr_hw_queues;
> 
> Looks like the userspace can already pass the preferred number of queues,
> so in this case, why not do all this netdev resolution and queue
> estimation in the userspace? Presumably most or the users you care
> about always go through nvme-cli, right?

Yes, userspace can already specify the preferred number of I/O queues, and nvme-cli
provides an option to do so when creating an NVMe/TCP connection. However, choosing
an appropriate value requires userspace to know both the number of online CPUs and
the number of active TX/RX queues on the NIC used for the connection. Determining
the latter also requires identifying the correct netdevice. That may involve a route
lookup to determine the egress interface, particularly when the NVMe/TCP host and
target are not on the same subnet.

So while this could be implemented in nvme-cli, it would require userspace to duplicate
the logic needed to determine the actual netdevice and its current queue configuration.
The intent of this change is to make the default queue selection automatic and avoid
requiring users to determine and specify this topology manually.

An explicitly specified "nr_io_queues" would still take precedence, so userspace can
override the default when desired.

Just for the note, this change also follows the general approach used by nvme-pci, where
the default number of I/O queues is constrained by both the number of possible CPUs and the
queue resources available from the controller.

Thanks,
--Nilay

