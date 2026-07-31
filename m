Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31B3090C2;
	Fri, 31 Jul 2026 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785478281; cv=none; b=KBG6QcgwpxCOTveX9aT/KYtLB/Hvp/FDz6bYsPyqypaujrchWzjrpWHkn9fOPTll93zKjo67Tf436XovPzcPX4VSJeCBHnEPcGWT66SVdI/v92JC8RpxoDthKWZ8gibJoEkkm774QbIC8vw+YGHfJPB7zFH6sjJvy3dnfXjqoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785478281; c=relaxed/simple;
	bh=bb56yeAVEZvA7fGhAKHIlgLHg0r/vPCU0xHfPBnEECs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kdbk7mQNWrCi8IAX+2GtKLBkFqktj+F+ohtGOCPjTTn994EmK24O1qVIhnVvcVl7r3xODhagFvxB2TRU7miCYPbnG4DA/rEAwD1WIDHKECR65EmOgkIfiB4LcsiDAyCJUZvTBXaTWWZ6r4j4RCkuLDQxGH28RUe1gDrft6ineuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lIEmq6f1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lIEmq6f1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5HdUo853886;
	Fri, 31 Jul 2026 06:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0wFRj+
	p4FBHp9GPgyuiv6IYY2jAPyyQrtzPd4uBVoOQ=; b=lIEmq6f1E9oLIOKfYOcw+Y
	ySUj1zpk/dbgzLtbBkh0fR0rICZ/Y3pgizDOZYa6hwCz1AWSHrvrLEILqyMpMHPx
	4/nBDoRnxUYYBg0RL/uxQNVFsKa5yEi9I4zwjZVvBHfDm2INE1C1RhUhX73hvGUN
	zkgyXiGMoqJFxnb8sc2d8omKyMbr/H/C+HC+CTO5MBXpboaCzyRj9+U/WA0ghuiT
	YnU9+RwVEF7gCMMJKPOd519hLSpGblvblvgQBm9Fs4q+1ygMXpKVlMo0LiFO4Msf
	k+ghi/KgcaGIt7RWxZyVeLjm3KeMk22caTqd6jsjKFkyVdgzb5EQw9heHuNn41Zg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjjkeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 06:10:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V5uJBC025638;
	Fri, 31 Jul 2026 06:10:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwev4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 06:10:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V6Ad8D45416712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 06:10:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB94B5805A;
	Fri, 31 Jul 2026 06:10:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2645805E;
	Fri, 31 Jul 2026 06:10:35 +0000 (GMT)
Received: from [9.43.39.116] (unknown [9.43.39.116])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 06:10:34 +0000 (GMT)
Message-ID: <4a7eee2a-6b63-4a65-a522-ff04497a8ce1@linux.ibm.com>
Date: Fri, 31 Jul 2026 11:40:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: add helper for device lookup by destination
 address
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
 <20260727151652.3660476-2-nilay@linux.ibm.com>
 <20260730161521.22695fff@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260730161521.22695fff@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzNyBTYWx0ZWRfX2/2PvEAd5nnR
 6CPfzItEAjzMxQvc4md0sEF/N/PH45TtHMsirUhgQ5PtCpGGpMhuv9gykvt3YHVuGwquO2N87Ec
 4A3FUzDQxJgYlu+xp3RtfvK/KvROP5M=
X-Proofpoint-GUID: DenvK_pKDSC39pnJD23TFz6lakMiY3Dt
X-Proofpoint-ORIG-GUID: dUIDfTHkieRugOc337awhMmKZJ5W3V6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzNyBTYWx0ZWRfX4augOfr5YHIo
 4w4fWOl674h7l5/AI1BwNmS7id37kJIcLoTEr0DSwOlewg1AaLc1hq1ugSxZNJ0mdz79Et6ZWSj
 MG02gU3/RkenYmBG7+NyHj9RK2QTtvRMi4MGnemTl25yrBSZ06//0XJr7ahwqDeZF7dVsVer4Hq
 gMyXM8Ymcr5SO7SN5bfcSctroWwXQV5V6j33ik2JGcmyB1r5FIwVnDbrSNSH0S0wd69VvP30CcC
 pa5Wkq+ghaOGHRgMAO4Fs9V26ElMjvdRLhB5QVINxhEPuTQXD8wEZepxrCkPTrslZt34pmEITH1
 Oks/8FfeB/3QMLDMEPzafUncEBF7b9jQ75OjRGtiqVa1nxTWRK89re5gAbsu+/2cDuxdEXfhYDd
 T7KXpjBXyHWEErCnzefmz7IQuJlH0P7XVAUe+RUECW8VeSoevPExwK19X1LZm5ORuafXPmQXRml
 IX+elINv3jIhMLdY6YQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6c3c61 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=fTXjkXMZjpTdXAl4l6kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310037

On 7/31/26 4:45 AM, Jakub Kicinski wrote:
> On Mon, 27 Jul 2026 20:46:44 +0530 Nilay Shroff wrote:
>> Add netdev_get_by_addr(), a helper that looks up the routing table to
>> retrieve the network device associated with a destination address. The
>> helper also supports netdev reference tracking.
> 
> This does not explain why you're doing this.
> Please CC the whole series to netdev or write better commit messages.

Yeah sure my bad, I would resend the series including all netdev folks in Cc.

Thanks,
--Nilay
