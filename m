Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD116DEB1
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247499; cv=none; b=upEGGG2E5dsG/BZsVvLik0s3OlJWeNeUdVV3SxgiAyPpYlvDPw463cO2AASoYTltI/lVXWeFElOOrzhBX7aDe8SjBs0VEtjeqQN1iiIIb6HLGNZ2rqbCBPHLfdiHFt6G6GnkIpbCUMDhfgwMMwXBj338Vl86QUrbf6XKeL+OoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247499; c=relaxed/simple;
	bh=qCfFGwTcqMhI7DXR0ZKYX/A1m7GkOsS8HsNtURYQMiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0X9a1AeEMGCYRMuphSel2bZWrBigdm79eOaig6S/dbrsuLZlfwAj7F72FHpPETlJD2Z2J91nNAAk842QqNFP1n/6Lb7QkCgfXJ6fNVlwfrz75wgTCPGZ2+VAaJWZuSy2hYGHR9wiRpwSl8885wIc6I9ZzARnwLuFRvjDW06kJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XCzvnJYR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XCzvnJYR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNgF8v2751611;
	Fri, 17 Jul 2026 00:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4AdliL
	ziaxe3oWIP0QLOr4ptlmfg4nGfLqRA/ySQzcg=; b=XCzvnJYRxR/fsyi+EmOyzV
	twYAFkNcFWEk8mBGB3FlCG0xkxfmuIttxYE4xc+PfRsNCmCSjz8DvCcqd5eOjBkS
	LvwTm/TGCMmkvaEu4OLraVN2d3ceBRNavuayhrh91etKEFuIXj3e1vBl//NtDec2
	vd+F38aL74Gayb+jO2vWeR7ythTeGmqfal8MJ3GVFaGJCT0qBsxp/dJtBIg4bWt5
	2W/2+f5sc8p9oLZfL+vlbxK0SvO2XTkP7PhsR2QEuzRb6FgyahrMLTzzHmZH+Yjx
	+9DNfShmeLyY28B4d33mDaXWw/4TMjEkrqQvig/sdcHrDFkcTOxnWvxxMeuaf4AA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33m8hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:18:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H04ddj012120;
	Fri, 17 Jul 2026 00:17:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyf49k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:17:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H0HwRN24969760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 00:17:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1156B5806D;
	Fri, 17 Jul 2026 00:17:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E00D85806C;
	Fri, 17 Jul 2026 00:17:56 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 00:17:56 +0000 (GMT)
Message-ID: <053ed037-3079-41a7-9340-616d9ae052c5@linux.ibm.com>
Date: Thu, 16 Jul 2026 17:17:56 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, Dave Marquardt <davemarq@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-6-mmc@linux.ibm.com>
 <20260714124327.GJ1364329@horms.kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714124327.GJ1364329@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMCBTYWx0ZWRfX7q8wVXLxB1Nd
 8ErqQEU9sXKNhLT9ocdqSwMvk+NNbVVZlfN0wK+jOofRC86OKLMW7JU3/BTORAbq+BrK1B1Pgnj
 8CMAAc9sAyBWzTku7UJIaDQpVOJJIuo=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5974b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=F2C2ttmqdAMir2IvWxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TrkS95NrFAmGbjKqQSKH01RFt9_N5rTy
X-Proofpoint-ORIG-GUID: ckgN4CW2bdOQa9-Hbvep9iom1OIk4hFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMCBTYWx0ZWRfXy291Lp/PU4Ck
 K1db1nR4qZMfpWyFKi5kAIkKaX0tfnLViYjUTWU/a4U93eot697Mp2lE8VWxyAhvie0JPOKvuW/
 61U9a/7wG4oNAMZ03UW4bAzKx85ZG7cordcWkKjyZ2YwI5XuiOMI3/NCm7nEyKBZb8ZkWOk3eng
 nXF/vCqPqeySz6s+mAXo0iM3yxMYM8VuLQQVSGEa+Bc68ZbwmdfufPwNuIizLPMBs83c9tB2DMW
 d+30M6O7DcFKGIZ6d1DUjI+Ov0HUlxfzfTJy33Pxapr3P04o5ZouA+zZ2Lf2rXlrGa1pPPzb4r1
 puM3kGREBXO1GggFgIw7SPfONpQxwl7JHWpx6UP27xDdpuDKeSdfskRBr6/K+6aoIJN73b01Hho
 agnjK915LWHa+pbeSXK8maUc10WXcqPDpbyA5ZV+A7cvKRB3z2Tq3XK13b27YiAKBGsS9hxurwb
 KZlh0eZY9hyai1MFLAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170000


On 7/14/26 5:43 AM, Simon Horman wrote:
> On Mon, Jul 06, 2026 at 12:35:53PM -0700, Mingming Cao wrote:
>> Queue 0 and subordinate RX queues use different interrupt control
>> interfaces in PHYP:
>>
>>    - queue 0: h_vio_signal() after h_register_logical_lan()
>>    - queue N: H_VIOCTL against the queue handle/hwirq mapping
>>
>> The current code is single-queue oriented and cannot safely scale to
>> multiple RX queues in poll completion and open/close IRQ setup.
>>
>> Introduce queue-indexed interrupt helpers:
>>
>>    ibmveth_enable_irq(adapter, queue_index)
>>    ibmveth_disable_irq(adapter, queue_index)
>>    ibmveth_setup_rx_interrupts()
>>    ibmveth_cleanup_rx_interrupts()
>>
>> These helpers centralize queue0-vs-subordinate dispatch and make IRQ
>> lifecycle symmetric across open/close and future resize paths.
>>
>> request_irq() is wired with &adapter->napi[i] as dev_id per queue, so
>> interrupt ownership follows the NAPI instance that services that RX
>> queue.
>>
>> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
>> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

**

*Hi, Simon*

*

Thanks for the review of this series!

*

> Although it is added later in this patch set, I believe linux/irqdomain.h
> needs to be included in this patch so that irq_dispose_mapping is defined.
*

Thanks, will fix in v4 — move linux/irqdomain.h into this patch

where irq_dispose_mapping() is first used

*
>
> Also, I think it would be best to add these helpers in the same patch(es)
> that they are first used.  As this will avoid temporal compiler warnings
> about declared but otherwise unused functions. Similarly for patch 13/15.
*

Agreed — will fix in v4. Helpers will be introduced in the same

patch that first uses them (rather than ahead of the open/close

wiring), and I will apply the same rule to patches 13/15.

*
>
> Overall, please make sure that when each patch of the series is applied
> no new warnings or errors are introduced for allmodconfig W=1 builds.
>
> FWIIW, I exercised this using gcc 16.1 from
> https://www.kernel.org/pub/tools/crosstool/
>
> ...
*

Will do — v4 will be checked so each patch applies cleanly under

allmodconfig W=1 (no new warnings/errors), including with a

current crosstool gcc.


Thanks,

Mingming

*

