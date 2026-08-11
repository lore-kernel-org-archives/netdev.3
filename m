Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815B3B14BA
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474811; cv=none; b=qpaN284eGmzUwSpjf4eyPCnj8mBxCBLoN9Vza0VpBngfajUE+M6zb2yJaDwcsiBbSgs06IYXPLQluFrf2A9TCyg7AU8B9WtwZ7eZzu8GpL4uzOfG2yI6keu3Q89le3ziuQ3Oh0k+5uPeGt8KlGgzbIpBqJ/f8y3Y7/nI8Y3YR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474811; c=relaxed/simple;
	bh=zJ2yODuh5xrwNkjsG1VnInG53R87f0B3Y9vJ18mGLY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P467JZpZx5VXd+N6qbaF/tOZnOQ6ThND7TNrxopYD2LUYsy5PK7s8ynCMkEvUOSFO+WMvysf013XvLEUpUE58iDE5ilIqUHCYReKrgJgYi9VFOWTtD/cMi614V1U7wUAburSe8Mw2NgXrRCWqZQMrcb528FpbUQeoMFDJicDsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H0gWDBVW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H0gWDBVW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGWFZB965413;
	Tue, 11 Aug 2026 18:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zJ2yOD
	uh5xrwNkjsG1VnInG53R87f0B3Y9vJ18mGLY0=; b=H0gWDBVWvGImLWpD/0DDyE
	/bVONb+JaCgekpl6b7E5L5gCJkpJSl+/8lmpGyP7NdTwi9ETdq/MYb4rXL07P9rR
	AqA9tPAY4mk+xBDPyY6qdTxtSg/bImBXKuiN5RVpenYBaUTXqfQcb72GnE2UJcC8
	5Q2EGUeLsANYBr0nus1mHgffuWWrECAA8piwnDsmL89gpayw51vAz4tmsedvVKiP
	rXSJyB0ntdMc6Ejjv4Ecj9aRnxWZ0AEJl4qJDepmlJrsqdVMYv+EviYo6tpTPoOe
	KP8KNvTrXRMJHepazPmKhgsekbFbzlku7IHpb32tCtD2Ltb4g64SMCvIOKDs62cA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw5wtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:59:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIuHS5017827;
	Tue, 11 Aug 2026 18:59:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy2523-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:59:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIxolm60752204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:59:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0102D58057;
	Tue, 11 Aug 2026 18:59:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DB9858058;
	Tue, 11 Aug 2026 18:59:48 +0000 (GMT)
Received: from [9.67.110.153] (unknown [9.67.110.153])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:59:48 +0000 (GMT)
Message-ID: <23fd0f9d-b13a-4454-ad29-e6c4488b79b0@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:59:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 14/14] ibmveth: Fix MQ RX poll and shutdown
 hangs after queue resize
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, edumazet@google.com,
        pabeni@redhat.com, davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, simon.horman@corigine.com,
        shaik.abdulla1@ibm.com, Dave Marquardt <davemarq@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
 <6c687fce21930e4ded39610717ac05862b67e7aa.1785457143.git.mmc@linux.ibm.com>
 <20260806114928.3f4adfa9@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260806114928.3f4adfa9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b7129 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-0MhZtYOHlZKH6frF0wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NIYYau8TTnz3hEuyRNiwpXg6OeF97yUd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX9F1k/0UGw4vA
 RbzHf1JIcT/nf88QWC1W017LnhcyZDRprd02s8S1WHmqw73BSMluQUe7XhrC0IEi8SL16tHrOFr
 YTy9a3eZxKLxaMKAozP6dG1MAbRp57Ow0AEEvoaQIJy20uwi278qCaIaoQfLb/5H/1GQCZ2OaWK
 uU04gBuwVHcDL+ftdqeFjBqV9lBz3BQf1izwRWyRLpNqTkq/Qwz9+4eJqLhaxFgMSV+I2WMDFqB
 sYNe8v+qvLnCrGj7BY1C+PrKOyyCprn9h/9nLTTzbtOsxVzA/I4cJYejhKzBT01bdj/jMg3l7EV
 7VhgUWZjFTJBKrWWeKw5qfU5hot/ENzO6gN09J1pNN/U6PA8gdjHi3sdVaI99WPDyRNYShzx+XE
 eoffPHFI4xKxH/GPlQRRd87gKNLYMwoj+wfWOAaGklUmZsyoBLJjOCFox8Y7ZjbsHTkLkO9MLbl
 DOj3XUDqW6x7kiT53Jw==
X-Proofpoint-ORIG-GUID: 7_4BVz5zDQhHVEuNxDpic6IojvJfkOL9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXygjEICSa5qXf
 fI1V7UzYm3lQ428wOvbKymiPQ1eWDgchFWB/92dJjIvQPXKE8FBgU6CqJlxwOLEfos1Geykho0P
 a4j6x1lmEz5q/3CQ05u4/2Ra9ObAw1M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155


On 8/6/26 11:49 AM, Jakub Kicinski wrote:
> On Thu, 30 Jul 2026 17:47:17 -0700 Mingming Cao wrote:
>> After aggressive ethtool -L cycling, PHYP can leave a VALID RX descriptor
>> with a correlator that no longer matches the per-queue buffer pools. Poll
>> treated this as fatal: ibmveth_rxq_get_buffer() WARNed and returned NULL
>> without advancing the ring, then restart_poll retried the same slot
>> forever.
>>
>> Advance past bad correlators instead of spinning: validate correlators
>> without WARN_ON, skip invalid slots in poll (count as invalid_buffers),
>> and advance the RX ring when remove_buffer_from_pool cannot map the
>> correlator. Rate-limit the bad correlator message.
>>
>> Complete NAPI when the interface is down or napi_disable is pending so
>> close/quiesce can finish. Do not restart_poll in that window. Close
>> keeps hypervisor IRQ disable before napi_disable (via
>> cleanup_rx_interrupts() / related cleanup helpers).
>>
>> Also validate descriptor length against skb tailroom before skb_put(),
>> and after napi_complete_done() on the budget-exhausted shutdown path
>> return a value less than budget so NAPI does not immediately reschedule.
> This patch looks very odd, like there's a bug somewhere and instead of
> fixing it we're making the rx path more resilient. BTW minor coding
> note - you're adding a bunch of heavily indented code to an already
> long function. Please consider factoring things out. Similar comment
> can be applied to other patches.
Agreed. The main fix here should be in the earlier resize/teardown path,
not in a trailing resilience patch.

I’ll fold that back into the owning resize work: drain before
deregister/unmap/free, publish the surviving queue range before freeing
queue resources, and use the same teardown path on the scale-up
enable_irq failure path. The poll-side skip logic should stay only as
belt-and-braces after the teardown fix, not as the primary answer.

I’ll also move the new poll branches into small helpers so
ibmveth_poll() stays a thin loop, but keep those helpers with the
patches that introduce the logic rather than as a standalone trailer
refactor.

I think the same cleanup principle applies to a few of the other
patches as well, so I’ll fold helper extraction into the owning changes
there too.

Thanks,
Mingming
