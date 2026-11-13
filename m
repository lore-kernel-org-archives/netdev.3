Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596410;
	b=NYIgdLm6f9fpEX2TqRHtAPCT7Xfc5qPG6eGLAF4+c1i0OpGSkxFMDMhBGxJf04mfVAue
	 S8seQ7Mlvq4t9I8SBXIXlwDdvIMge6VdPpY9WWxPict5PDZ816t+O4GLzZIesykHMxTN8
	 Fhde6DglOIKq5rMhh+DETqzAZi65R+KI7hCuxAYWHVurJjZ27FYb8sIt1RKvIsvMe/Or3
	 qWgp1gdSNqqQYeYOn5m/Dey3Ph2CBsblOrMrfWEb85SmGQKUOylU55Q4nxOVtHgCh+HYa
	 /ALTELoQLhPxD4LpI/BvneIWOEVwFcRWdAH5pf3HAKTUX73jT9bk9xeopHNLT7CAX7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596410;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qpITPoEciQV6nofIuyTNEcnISRATz13nf386UnTzo28=;
	b=Sz53zfpjd7ttgBi584OnF49t+hD4f+y8otRSkxsH1F37K2iPnO8Ua10e+mixyEXYrzeV
	 wVkaTB9GSx/76VAT2jDbtgDlvT38U4gojVwDf7Mh3ElkasATkxjI3uOS5L7pbb9eQOCke
	 xiw8W2pySUX6h1DCGw1DPmscmsLl9m+aTdWn5t4HZCfIEuZTOqkQe2VFzSdpIzyHArPhJ
	 RaZXiOjsnOL8r5OpRcBvjNvCiPK/Cz8SueKsVp/v5rAhqUCOr1jalVR7gd0Jq+98D55yf
	 HZJ28QegfRjeGbh5p1L9fJj4Zg9IHyIRQbKulu2md/WheGRBpfZuCBjukC53qelkSlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aDGY7FRh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A55606A33B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A55606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aDGY7FRh
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADIvct14124201;
	Fri, 13 Nov 2026 18:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qpITPo
	EciQV6nofIuyTNEcnISRATz13nf386UnTzo28=; b=aDGY7FRhfUZhYFdU2+47kM
	YKRaaXE4dHjw2Gb8zABJwJPBRS1EKG25hwtjPzUdLk3yOGYqVa2I47Ncgs4LnBZC
	dU+S/TCGFbRIPgzTND1zRgh1Ev7s6qY4D1ut7SZZ7rrNe8U+IMwP7PZ2L8ND4VMu
	7MUUQsnrqyDoRIFhb4SF9wxGUrkmiUGAbwSvYWSybXgFx2O5qmNlUhc9iATWde5m
	p9eYngkBKBsO0P2KKKsIMqVcAIuEPPOP/Xk83mIEI5ld8lCVYto0mctAAPHfNYuO
	2UsJeSzNhm9cebIuO6p/B04J5Ct0e+Oz3PdY0nlUy5uC3bFL0RmKyh5Mo/1aW8cQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6nab1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:59:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFYxAM1387094;
	Fri, 13 Nov 2026 18:59:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k9jbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 18:59:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADIxWXA3539642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 18:59:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E65258059;
	Fri, 13 Nov 2026 18:59:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4400A58017;
	Fri, 13 Nov 2026 18:59:29 +0000 (GMT)
Received: from [9.67.72.137] (unknown [9.67.72.137])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 18:59:29 +0000 (GMT)
Message-ID: <2eaacfe4-9770-4d04-87c6-bd5bf1be0728@linux.ibm.com>
Date: Fri, 13 Nov 2026 10:59:28 -0800
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
Subject: Re: [PATCH net-next v8 10/15] ibmveth: Enable multi-queue RX receive
 path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20261109235556.60604-11-mmc@linux.ibm.com>
 <179452782954.2199510.3698776944774316685@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179452782954.2199510.3698776944774316685@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eqJfK_tjmwH3UI9Ae_u3oK6aoicjNiN4
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af75e1d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=nQy6u8G_IQomnRaZso0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: l9Cg9ol4bEeBZwkHOItU6cNRzJoF1sge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX70VkKqddhBn1
 0Hl9RDCyXaS8t/t90eyu2DlwFr2CS26mVe0O63xYSzNxxmLta3+7upI5b4qKo+WXefIOHVo7Xgd
 25P+Z29pvLHmqtVqeB4fK3nAO0wCtmklPOP5kEnjfzN4lkKqQyEeBJa3skawDwj+HuhMuLr4wNq
 pOkhrXZ5/JxIIkZ544SU3D6c1Da6WED+P92ebeGWIf9KwheXdrZSFd1TyiJiApDJPsi/jhTWYh0
 VwKV3eH+9U9VjNIgAu0c+37sbY2Bw4bdvXQCwSpU39mLmnb5JFUx7m5PyxkJKn5aKH5Sg3U+fno
 gvCHDekseI6jLOCjryU+Mvck8wcEjvbNzgxggw0w+P2Ind2CyTpKLSvOpDkDi2Df+QD6tSFB9Yx
 eLeF0qu684IawfkJfnI3zvYljK3/FVdljM5YNSfkJmvm9+bdWZtt20QdbNUBSTsQ8kKnxuCm7xK
 TAdNt6ZVfI7MOEq4TWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX9UDBybXqFgEb
 ovYDZSuSfaYD4aB7JFcmOej9d0gU1Hugj2EqB8oF53YCWiKB7dfdhpRCdGkHQm+o3cuZMJGBbke
 7smESNvmfouil6WwAvSDaZYdQANCUas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130075


On 11/12/26 3:57 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The MQ teardown design is only safe if CMO and MQ firmware
>    never run on the same partition, and the code never checks this.
>
> --
>
> ibmveth: Enable multi-queue RX receive path
>
> This commit turns on multi-queue RX when firmware advertises
> IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT in H_ILLAN_ATTRIBUTES. Each
> subordinate queue 1..N gets its own IRQ, NAPI instance and buffer pools.
> It also changes teardown: in multi-queue mode, a hard H_FREE_LOGICAL_LAN
> failure now leaves the LAN memory mapped, and open() and remove() retry
> the free later.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index b12bfa1e485eb..a0c3c06d2b9d9 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1630,17 +1864,25 @@ static long ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
> [ ... ]
>
>> + * Retries only H_BUSY and H_IS_LONG_BUSY. Other failures are logged.
>> + * In multi-queue mode a failure other than H_PARAMETER (already free)
>> + * is fail-before-start: PHYP may still DMA into the LAN memory, so
>> + * return -EIO with the slots still registered. The caller skips the
>> + * unmap, and the next open() or remove() retries. Single-queue mode
>> + * keeps what close() always did, log and let the caller unmap; one
>> + * reason it cannot simply keep the memory mapped is that on a CMO
>> + * partition vio_cmo_bus_remove() BUG()s on an outstanding entitlement.
> [ ... ]
>
>> @@ -1654,29 +1896,45 @@ static void ibmveth_free_all_queues(struct ibmveth_adapter *adapter)
>>   	if (lpar_rc != H_SUCCESS) {
>>   		netdev_err(adapter->netdev,
>>   			   "h_free_logical_lan failed: %ld\n", lpar_rc);
>> +		if (lpar_rc != H_PARAMETER && adapter->multi_queue)
>> +			return -EIO;
>>   	}
> [ ... ]
>
>> @@ -3131,16 +3527,30 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
>>   		netdev->features |= NETIF_F_FRAGLIST;
>>   	}
>>   
>> -	/* Initialize queue count - always 1 for now */
>> -	adapter->multi_queue = 0;
>> -	adapter->num_rx_queues = IBMVETH_DEFAULT_RX_QUEUES;
>> +	if (ret == H_SUCCESS &&
>> +	    (ret_attr & IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT)) {
>> +		adapter->multi_queue = true;
> [Severity: Medium]
>
> The new -EIO path in ibmveth_free_all_queues() is only safe if CMO and
> multi-queue are never active on the same partition. The kernel-doc above
> uses the CMO BUG() to explain why single-queue must still unmap, and the
> commit message says:
>
>    CMO (Power9 and earlier) and MQ firmware (Power11+) do not coexist
>
> Does anything in the driver enforce that? Here multi_queue is set from
> the IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT bit alone. Yet ibmveth_probe()
> checks FW_FEATURE_CMO a few lines further down to pick pool_count_cmo:
>
> 	if (firmware_has_feature(FW_FEATURE_CMO))
> 		memcpy(pool_count, pool_count_cmo, sizeof(pool_count));
  The split comes from the platform support matrix, not from that bit in
the driver. CMO / Active Memory Sharing is supported on Power9 and
earlier, and PHYP advertises ILLAN multi-queue on Power11 and later. So
a partition can't see both FW_FEATURE_CMO and the multi-queue bit, and
the scenario in the example can't happen on supported firmware.

> Suppose firmware does report the MQ bit on a CMO partition and
> H_FREE_LOGICAL_LAN hard-fails. ibmveth_remove() then returns with the
> DMA mappings still live:
>
> 	if (ibmveth_lan_resources_live(adapter)) {
> 		if (ibmveth_free_all_queues(adapter))
> 			dev_err(&dev->dev,
> 				"h_free_logical_lan still failing at remove; leaking LAN buffers\n");
> 		...
> 	}
>
> Would the bus remove path then hit this BUG()?
>
> arch/powerpc/platforms/pseries/vio.c:vio_cmo_bus_remove() {
>      ...
> 	if (viodev->cmo.allocated) {
> 		dev_err(&viodev->dev, "%s: device had %lu bytes of IO "
> 		        "allocated after remove operation.\n",
> 		        __func__, viodev->cmo.allocated);
> 		BUG();
> 	}
>      ...
> }
>
> The entitlement is also mismatched. vio_cmo_bus_probe() computes the
> CMO desired entitlement before the driver probes, so it covers one
> queue. Probe does not refresh it, but MQ maps up to 8 times the RX
> buffers.
>
> Could multi_queue be gated on !firmware_has_feature(FW_FEATURE_CMO)
> here, so the driver checks this instead of assuming it? At the end of
> the series, probe still enables MQ the same way, and remove() still has
> the "leaking LAN buffers" path.
>
>> +		ibmveth_publish_num_rx_queues(adapter,
>> +					      min(num_online_cpus(),
>> +						  IBMVETH_DEFAULT_QUEUES));
> [ ... ]

I don't think this needs to block the series, since the combination
isn't possible. If there's a respin I'll add an explicit
!firmware_has_feature(FW_FEATURE_CMO) gate in probe; otherwise I'll
send it as a follow-up hardening patch.

Thanks,
Mingming
