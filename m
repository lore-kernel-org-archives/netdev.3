Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4335FF58
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199142; cv=none; b=oqh8T/pMZcFRAzRsvcUTBmQf70Imn9eqAo3DxjS4hSGXKA975jONUF7e0/yVZqXrWr7C0ZNRhAxS9uwd4ZbACIIkwx27gqxVr49Ivl/JTPPpBwvUJ8XIBEEF1V/lccPvddI0JAo+xxJp7urwIpd27vVa/rE+/FIRSpqRyKycmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199142; c=relaxed/simple;
	bh=uMUA1jrqlo/LLP9I0avsLz2Q+TGZAjRotqE1nvYBaSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rN3S47PX1lXqYXLXOs8S1l/pfrEJ/ixtaitJZr/HwpvOk/Ymm8mt2lR68Ivmv09Vz4akelgRFq90i6+oJnzcCD2tMCL7qbS/6PsoLJ2cLj/hjrNrX5nfLZGH7IoW1ZGXpTtwGmASdivrW9+FrM3mXRfmPxtbF2sNr8TQNEzgueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DRwJ4Vu8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DRwJ4Vu8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VG1cwZ2743653;
	Mon, 31 Aug 2026 17:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BFzkAv
	K4B5NIvBtjMcthfPNkUY2fwwOCxqhgKC3xxWQ=; b=DRwJ4Vu8C7q8QGwqeVp3A+
	NcZOV2uZ+5+RwE/qpuIuFQ2nrXj3USVyfci2nqqc/BKsa2nJ1wFnIyuode11t281
	xjlSI+STVw60ShNN44RZzAH4njGDV6DjYYGUWaUTmC4l2PtbKR11M2jGouXw3c7l
	0RY9TWzK90LLl9Gw9MZjLEtQAdlCcsdGI6cOeZ4+pUsE81UBRVEGn/a93ZC+v6p9
	CvixMbZjN2UYfDIOQCWbNyaT1iEQ9b3/Xat/i1qfxoJbbsb2q+4bh/Hn5vsARfHG
	LUN/piHNm5BaIOXxshWAAHG+ADHl1bOR9efhNewUHQhdNg9WJplLH/6j81C22aVw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54k0bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:58:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VHuKsg011276;
	Mon, 31 Aug 2026 17:58:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7871-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 17:58:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VHwZ4c23200404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 17:58:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AB685805E;
	Mon, 31 Aug 2026 17:58:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2422B58051;
	Mon, 31 Aug 2026 17:58:32 +0000 (GMT)
Received: from [9.67.102.143] (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 17:58:31 +0000 (GMT)
Message-ID: <98b8a2d9-e17b-4956-aeac-0f41029e6fbe@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:58:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/15] ibmveth: Add MQ RX hypercall wrappers
 and call definitions
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, nnac123@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com
References: <20260814073642.24630-2-mmc@linux.ibm.com>
 <20260818014710.3853684-1-kuba@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260818014710.3853684-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1MSBTYWx0ZWRfX5ze/Lnw6LN3A
 kIAVLBqbMhum4sIyRsFKcwBDKdwW9rmaapdxVxJniMDbrFTvgxrzbJUmJzJ5tT0T4BXlDznL2sx
 QjRwdF0ptf7j6yd2sxlaBuHQNbnM1fngBaL3wIjghO4XhzbSlCfEm4ogyeDEoQS9SNV0erx4nMp
 3vFmsxgWO9xUuYcLh8ZbgzwgIOb5LIekS9h7Yr4SGCmdF/nIlZ59d7H1K7+zcGFDi3Vo6zyAg02
 QV6vRfPf61Iy5Mpek63oDYK/GnQW3jFqGrY62Np5CcXgpNT7RAIlDgGeLwEciWR2XTAwDc2S12u
 SvyenTb82XKoFjI6qHpM2WqetodJcGQM4o1+IdzFdEwtIgMCAwbXCgWhR6wQVMBxG3X/yYBWfss
 m6+UoHOOWsGBvWByoVH/YAs2B5Z2qwXvtZtCa0636j/xTztVjtLikkyHoihDumEkEwKLvDLgDl9
 MXBO4NenHx9ZnlfngpQ==
X-Proofpoint-ORIG-GUID: IhY81iiyXh_2gIsl9o9cBr4NGCNIfBz9
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a95c0d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=15AQF0vLuX4PtpEdo78A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GOiXZRYp4t2b1FHawhO-YYPPoPQ1IyJR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1MSBTYWx0ZWRfX3fohUyI3MSgk
 0i/m+WSAHcQt0V4YXZx88VnP1nK9eTr7fVp7RCNa3I4XLiVDID3MIzaBbijvn7mV6+0CJRiBtQ2
 DqirX5z6lx3HZDt1q/mKoLKrnRdiNNU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310151


On 8/17/26 6:47 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
Hi Jakub,

|Thanks for the v5 review. v6 is 
posted:https://lore.kernel.org/r/cover.1788102125.git.mmc@linux.ibm.com |

|Per-comment replies below.|

> ---
> ibmveth: Add MQ RX hypercall wrappers and call definitions
>
> This adds the PHYP call IDs for H_REG_LOGICAL_LAN_QUEUE,
> H_ADD_LOGICAL_LAN_BUFFERS_QUEUE and H_FREE_LOGICAL_LAN_QUEUE, raising
> MAX_HCALL_OPCODE accordingly, and adds matching static inline wrappers in
> ibmveth.h.  It is plumbing only, with no runtime behaviour change until a
> later commit enables multi_queue.
>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
>> index d87713668ed30..c0ef03cad9b9a 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.h
>> +++ b/drivers/net/ethernet/ibm/ibmveth.h
>> @@ -66,6 +66,142 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
> [ ... ]
>
>> +/**
>> + * h_add_logical_lan_buffers_queue - Add buffers to subordinate queue
>> + * @unit_address: Device unit address
>> + * @queue_handle: Queue handle from h_register_logical_lan_queue()
> [Severity: Low]
> This isn't a bug, but do these two kernel-doc blocks in the same header
> contradict each other about which handles are valid here?
>
> h_add_logical_lan_buffers_queue() is documented as "Add buffers to
> subordinate queue" with "@queue_handle: Queue handle from
> h_register_logical_lan_queue()", while h_register_logical_lan_with_handle()
> below says its queue 0 handle:
>
>   * Registers the primary receive queue (queue 0) with the hypervisor and
>   * returns the queue handle. This is needed in multi-queue mode to use
>   * h_add_logical_lan_buffers_queue() for all queues including queue 0.
>
> By the end of the series the second wording is the one that matches the
> code: ibmveth_add_logical_lan_buffers() in
> drivers/net/ethernet/ibm/ibmveth.c passes
> adapter->queue_handle[queue_index] for every index, queue_index == 0
> included, and that handle comes from h_register_logical_lan_with_handle().
>
> Would it be clearer to widen the add-buffers kdoc to say the handle may
> come from either h_register_logical_lan_queue() or
> h_register_logical_lan_with_handle(), so a future caller doesn't conclude
> queue 0 must use the legacy buffer hcalls?
Agreed. v6 widens @queue_handle on both add-buffers and free-queue so
the handle may come from either register helper.

>> + * @buffersznum: Buffer size (upper 32 bits) | count (lower 32 bits)
>> + * @ioba12: Buffer addresses 1 and 2 packed ((addr1 << 32) | addr2)
>> + * @ioba34: Buffer addresses 3 and 4 packed
>> + * @ioba56: Buffer addresses 5 and 6 packed
>> + * @ioba78: Buffer addresses 7 and 8 packed
>> + * @ioba910: Buffer addresses 9 and 10 packed
>> + * @ioba1112: Buffer addresses 11 and 12 packed
>> + *
>> + * Return:
>> + *   H_SUCCESS - All buffers added successfully
>> + *   H_PARAMETER - Invalid parameters
>> + *   H_HARDWARE - Hardware error
>> + */
>> +static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,
>> +						   unsigned long queue_handle,
> [ ... ]
>
>> +/**
>> + * h_register_logical_lan_with_handle - Register primary queue and get handle
>> + * @unit_address: Device unit address
>> + * @buffer_list: DMA address of buffer list
>> + * @rec_queue: Buffer descriptor of receive queue
>> + * @filter_list: DMA address of filter list
>> + * @mac_address: MAC address
>> + * @queue_handle: Output parameter for queue handle (may be NULL)
>> + *
>> + * Registers the primary receive queue (queue 0) with the hypervisor and
>> + * returns the queue handle. This is needed in multi-queue mode to use
>> + * h_add_logical_lan_buffers_queue() for all queues including queue 0.
>> + *
>> + * Return: H_SUCCESS (0) on success, error code otherwise
>> + */
> [ ... ]
>
> Cross-instance finding from sashiko-gemini (34d1289184ae332db8c101e251d3dec96e9969f2e8dee8d98c3efff05039c9d0):
> [Severity: High]
> Calling plpar_hcall9() with missing arguments causes an out-of-bounds stack read, leaking uninitialized kernel stack memory to the hypervisor.

Yes. Fixed in v6. Both new registration wrappers use plpar_hcall().
h_add_logical_lan_buffers_queue() still needs all nine args. I left
the pre-existing h_send_logical_lan() underfill alone; happy to send
that separately.

Thanks

Mingming

