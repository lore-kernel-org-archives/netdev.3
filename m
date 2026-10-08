Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16602439328;
	Thu,  8 Oct 2026 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497107; cv=none; b=JJEUm4BLdExf+Rchm3eI6mNiqdU3Q6IMvwDTh7wBUsTKMDycwEk/XFJjWPJEcdj6zTd9UBgZxz7wy5mxfApnlRwgbJmgrsGT8NEXkXIpJtB1KTD0IY+CNJY+u+eLr30WBHl0WevlKvGQ6vrZy5F46iWZ3yii/83XWi68Sm9gTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497107; c=relaxed/simple;
	bh=whDHzBrcOJnbcmH7UyWA/+cj9G/KyYiM1IY6AvZbTxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ixwu8BU7iPdTg8b0iOLd/oNHlV6DyJtBkSuEKepG+buZ3nY30cmKGXArE7GOvDlo/QjrWqbVIOuym02j3+V/LRJYmESz2HhAF3k8F2Ghqgon7xCbYDzX6DqorgEP0sBZbjLFFzCe7ZTuRT/4dmf8HLfN5jP0gW6h68xuuN7rcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jV07AHcX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jV07AHcX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698L5oxf2443821;
	Thu, 8 Oct 2026 22:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IHKgAB
	gdFPhYFQF1m+PcsfFtt5k4tAnlDwgAPavZFF4=; b=jV07AHcXjDvxKhdi0KPs/W
	wY5WogHt90YIrR/v9u5LNttEkLljIa6weuIex+ik1jDxEDRvjY2ZbG+AlBQphbYB
	9TxamdBZG8xuN58Vo5DZwO4SzS0aHK2YGWxpJRUM//kJ7HLGoB7qbNzjKje+3pMu
	Sr7DdqwCYasxz06gXsaHPOw80oRpbN7njK/UZPDciayJlB0DbqMF4KdmHA3rjSPX
	mX1bs+8dCI3KhBuNfcunjGKOJDVmyQBfbOiMYMg0vr3hOHIxkH3QDXl/fjw6BLve
	CE2xXms6Qu0A/yUeKy8nj43NaZsJqpvxMwGi/gpJ8kGs6Cx++UKlPpss2XYdHCOg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvpcsn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 22:04:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698L2XrE4079100;
	Thu, 8 Oct 2026 22:04:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsngd28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 22:04:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698M4cmP6160906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 22:04:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 140E958066;
	Thu,  8 Oct 2026 22:04:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AC558054;
	Thu,  8 Oct 2026 22:04:34 +0000 (GMT)
Received: from [9.67.84.15] (unknown [9.67.84.15])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 22:04:34 +0000 (GMT)
Message-ID: <55aa1573-770e-4f56-8465-5258dad862fc@linux.ibm.com>
Date: Thu, 8 Oct 2026 15:04:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/8] ibmveth: step past bad RX correlators
 instead of spinning or oopsing
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, horms@kernel.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, stephen@networkplumber.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <26003e69cff6824798d289d67c163f868bfbefc1.1791178212.git.mmc@linux.ibm.com>
 <179149372321.434549.3176990477501610987@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <179149372321.434549.3176990477501610987@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4GWNH2G5VheRFm8OT2F56i1JPVU5_hcs
X-Proofpoint-ORIG-GUID: 49WTNBN92ZaJ99uLXvjwoKzQ4vkCVbNB
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac81379 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=tBi60Mc56AIRnD212JMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NiBTYWx0ZWRfX0G1jKPVN0EWJ
 I4UBLp8r7ZOgNxEJNrQ3mTYEbXrOxhbH1BAtKFspymPqqA+la5+ai5DJw+ACldjZQ+xJxNEgMZU
 f4tqHMqBMpTpPaQEE5VIXKrpDQN+rPY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NiBTYWx0ZWRfX1EOuWF0oDm6r
 MrfDfcgz5HtSQTwmYMzn26G1pwWoEYiToKfoU1VPUCAC6WPQZH21lBIJLnQauvdhRXsOMXMgG8t
 kQLuEJG7iB/154y1BV1nmaQtH+FPZgeycjU7nX3T2f8uBKazzvA8cIir2RTD1WE6hysuVM3Tgd4
 57Jx+VCyf/7+YmyXi1llA4pHCpshgSYwXnpXf/RBRzEHxiJ1mWgTFIg/SmEu0h2e8fbDvIDv/1a
 lyp54Gg8izdRS+aaw3VlNu1ECIn1LSLFDixe+WlLBr8aDBzw/ANy386PidMJnETkdtqFQeYt/v6
 O45ULlQJ836x2QJC8kFjtOl4oFAzJQ4qjwmbFX/6bzt/J9mWOJ5WBzQIIlQKr5qScxjDATDo2lK
 NBOOOlHUVfblEd2J7NGpS1Vv01AO157yOSGONMkWhr6XlgQFbWwmKgWhthnCtmM0xDi7DO/s5rI
 Sd7mV8xseHtq2LyT2KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080086


On 10/8/26 2:08 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] net: NAPI list corruption and panic on bad RX correlator
>
> Pre-existing issues:
> - [Medium] Not introduced by this patch, but ibmveth_poll() takes the
>    frame offset (flags & IBMVETH_RXQ_OFF_MASK, up to 0xFFFF) and length…
>
> --
>
> ibmveth: step past bad RX correlators instead of spinning or oopsing
>
> This patch moves RX correlator validation into one helper. The helper also
> rejects pools that have no skbuff array, such as inactive pools. On a bad
> slot, ibmveth_poll() now advances the RX ring, counts the drop in
> rx_dropped and schedules a reset, and it logs with a ratelimited
> netdev_err() instead of WARN_ON(). The patch also adds and extends KUnit
> cases for these paths.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index d269599f5a990..3bac6cabbbb4c 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> [ ... ]
>
>> @@ -1515,12 +1556,19 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>   				if (rx_flush)
>>   					ibmveth_flush_buffer(skb->data,
>>   						length + offset);
>> -				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, true)))
>> +				rc = ibmveth_rxq_harvest_buffer(adapter, true);
>> +				if (unlikely(rc)) {
>> +					dev_kfree_skb_any(new_skb);
>> +					netdev->stats.rx_dropped++;
>>   					break;
>> +				}
>>   				skb = new_skb;
>>   			} else {
>> -				if (unlikely(ibmveth_rxq_harvest_buffer(adapter, false)))
>> +				rc = ibmveth_rxq_harvest_buffer(adapter, false);
>> +				if (unlikely(rc)) {
>> +					netdev->stats.rx_dropped++;
>>   					break;
>> +				}
>>   				skb_reserve(skb, offset);
>>   			}
>>   
> [Severity: High]
> Now that the ring is advanced before each of these break statements,
> can ibmveth_poll() leave the loop with descriptors still pending and
> go down the completion path before the budget is used up?
>
> After the break, frames_processed is below budget, so poll calls
> napi_complete_done(), re-enables the interrupt with h_vio_signal() and
> then finds ibmveth_rxq_pending_buffer() true for the next slot. It
> calls napi_schedule() and jumps to restart_poll without resetting
> frames_processed.
>
> If the restarted loop then uses the rest of the budget, ibmveth_poll()
> returns budget after it has already rescheduled itself. The NAPI core
> expects a driver that consumes its whole budget to leave the NAPI
> state alone.
>
> In net_rx_action(), __napi_poll() catches this and only prints the
> "Budget exhausted after napi rescheduled" warning. However,
> busy_poll_stop() calls __napi_schedule() whenever poll returns
> budget. Would that put napi->poll_list on the per-CPU poll list a
> second time and corrupt it?
>
> A burst of traffic right behind a single bad correlator would be
> enough to get there.
>
> The !ibmveth_rxq_buffer_valid() recycle path already keeps looping
> after it harvests a slot. Now that the ring is advanced on every
> error, is there still a reason to break here rather than continue
> with the next slot?
>
> The same restart_poll sequence can already return budget today if a
> burst arrives right after the interrupt is re-enabled. Should the
> restart also avoid returning the full budget once napi_schedule()
> has succeeded?
*


Yes. Those paths already advance the ring, so the break is wrong.

The respin continues and counts the slot against the budget.

The re-arm can do the same thing on a normal burst. Once

napi_schedule() has succeeded, the poll will not return budget.

*
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch. The patch
> hardens ibmveth_poll() against bad correlators from PHYP, so should the
> frame offset and length from the same RX descriptor be checked as well?
>
> ibmveth_poll() reads both values straight from the queue entry:
>
>      int length = ibmveth_rxq_frame_length(adapter);
>      int offset = ibmveth_rxq_frame_offset(adapter);
>
> offset is flags_off & IBMVETH_RXQ_OFF_MASK, so it can be up to 0xFFFF.
> length is a full be32. Neither is compared against
> rx_buff_pool[pool].buff_size.
>
> On the rx_copybreak path:
>
>      skb_copy_to_linear_data(new_skb,
>                              skb->data + offset,
>                              length);
>
> Can this read past the end of the RX buffer? If so, nearby heap memory
> would be copied into a packet that is passed up the stack.
>
> On the non-copybreak path:
>
>      skb_reserve(skb, offset);
>      ...
>      skb_put(skb, length);
>
> If offset + length is too large, would this reach skb_over_panic() and
> BUG() in softirq context?
>
> As with the bad correlator case, this can only happen if PHYP reports an
> offset or length larger than the buffer it was given.
*

Offset and length should be checked too. The respin drops a frame

that does not fit the pool. That has not shown up in the field, so

it has no additional Fixes: tag.

pw-bot: cr

Thanks,

Mingming

*
