Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C3389E07
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994125; cv=none; b=iume8Zq7PnUDvuz9/bBuqgE59Rswpdx3yNSiUUEg5qFcvodr+9uF1HijQYsJG9aO3Q9ibHpmhUPFnUcbbOpEoJDy2DW530WxBZq9tSizp7RmiRnnqvryyJuxbKgafaBbrA7z3kcY/aLDmx6/ofcMFVp8b7N+in7qw3Uuh07+mRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994125; c=relaxed/simple;
	bh=V+QtMJzJPNTgI4duhuoXDR9EwubyRO6fWld88OVjdeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqHMCVsrShVQERVgmm/+CpbwFuvQIRZZMvnEMX+TV5FYBrMllCZ/rZkFt26m7gjOxn1d5UcgZsZMgaPQfZcHCLdamlvFpsKU679Xr4OMIRg7lUfMwJQaF8l/xZuPPdB6JhMOyM4PZcHFQziCsny2hcvN/DaUoJJu5ain4HEfGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YOdQATMK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YOdQATMK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nn2LC1068575;
	Thu, 6 Aug 2026 05:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZGY3C4
	YMNFITS4/neg/qQRae7zDhrY4NYXElDGhkDiU=; b=YOdQATMKsKksJsrIs5fdVR
	bp1BGtrktdijAsKswngg54LcwXzHnZw7EuP8yL6YK7Zqqdl/3zJ+Hqx6sfsUvF2d
	69Nu8djMU654NBpSb/b/ghoCcEa8nJvFKcgaDaxiwnuK50mnYEnXgg3wxx/c7lGt
	16+RPjAeGcRRvuxH0mymBbbttsE0qRfkUi5VFkH/lkfZCycNTGACMQMby+pph827
	19olL3qH52MP6jQhTl7NG4FPiSTHM7r3cA6NbcW0XWu2DWX0TsLRf03MWfdDIH0c
	XFFxxOxTD+0ZihM4cirA+X+vjaLwacbDqnPwU0/tmpzMmRnuZOWr+Iy+F08G5cLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a46gys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:28:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765QKmN024383;
	Thu, 6 Aug 2026 05:28:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbghkxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:28:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765SUgP52822424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:28:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9319D58068;
	Thu,  6 Aug 2026 05:28:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2222D5805D;
	Thu,  6 Aug 2026 05:28:29 +0000 (GMT)
Received: from [9.67.83.170] (unknown [9.67.83.170])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:28:28 +0000 (GMT)
Message-ID: <22d2d33d-9118-4ccc-b5d0-0d41c2021eff@linux.ibm.com>
Date: Wed, 5 Aug 2026 22:28:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU
 values
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20260805224401.58791-1-mmc@linux.ibm.com>
 <20260805193832.645bdb30@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260805193832.645bdb30@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a741b82 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=7dpCjRRtK3qBi1irl1gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3FwmCuCqgCwBk1BaamNstPr3DnM7Llwv
X-Proofpoint-GUID: Q0H02W6Q0fjIgEAiOFKUhMoBG5rawV4r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX4sHbJURhXWM7
 JxemAeNzx0UT/qtdmvOG6ATIVJfFvF5wdu+rkvEuq/St4V3Kqk9Vu8qGDLEqBaygRyxpBzYKKgk
 s8X+rphZkWzJtNc4rkjLUjmpdreVFWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX9py2RWP4A5IF
 vCmrzyolw6y4+3h0hHq1a6jrc3p/4+S3p6M1KWAiH/0X/uB+GXM5BP2Iqyx6C5uCgmG6A0lkAYs
 3Kdl41YrQRdPtOQPXBL23wbGNQoMMCRnDG4Gu6N+lYEOLtzkjBVKlFb+WB4dlS0jTZjrW27DcBP
 ZeFEjFmYM2jR1azjAO4Wtyfd4WDyWPqNWcqdOfxkP3gj5Zq2WJTDr4rS4O2YmQ2F0N/LMCCipwd
 UuvpdXDvGSS/IpysKwfhwf4CJ5BjtBLB/zjJQiZzualRmL//N7HbGWwxX1bMPW/VDI8tAXna+LR
 Hd/yzj9VldPtyPEohdYKpJvjqWzd2/VeNMVBX8BTiLQM7htzaKyxG5ORsHXdwBQUNAf/0bPC+n1
 rYaNR9UUUPmK97En82lOKhJ9u0RKkbBQSrBha2FOmR3O8PxLf8c9fuwo9EA41IX+cqL37jQav/B
 WBYdiOGJQWGHQRbzIjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060038


On 8/5/26 7:38 PM, Jakub Kicinski wrote:
> On Wed,  5 Aug 2026 15:43:55 -0700 Mingming Cao wrote:
>> Subject: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU values
> Warning: drivers/net/ethernet/ibm/ibmvnic.c:1031 No description found for return value of 'rx_pool_entries'
>
>
> please DO NOT repost this until your previous series is reviewed and
> merged. Please read:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> There aren't supposed to be more than 15 outstanding patches form one
> person or company to one tree. We are flooded with AI-assisted code
> so reviews are slow. Your place in review queue depends on your
> credibility with the community so please help review other patches
> or just wait your turn.
Hi Jakub,

Thanks for the feedback.


Sorry for violating the outstanding patch limit. I wasn't aware of that 
rule, so thanks for pointing me to it.
I understand the review queue is already quite busy. I'll wait for the 
ibmveth MQ support series (v4, 14 patches) to progress through review 
before reposting this one.
In the meantime, I'm working through Sakashi's review comments on the 
ibmveth VQ v4 series.

For the ibmvnic MTU support series, I'll hold off on posting a v2 for 
now and will address the kernel-doc warning in the next revision.

Thanks again for the guidance.
Mingming


