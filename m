Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA463B6346
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185766; cv=none; b=YGpCHggZFqwD/QYFbbP3/60KdfXOQCT+PhnfupJcjUv9uznj5AiNcrAuXeF070xMjibDDoiBkRQYNk9EaBrQHrZiylQJP/ktUMyqBik8Cqi5BN1FZEBFpERm0/M+A905iTmhnvMU69IyPrBpNQBbUlZe20GspsHXlNfwFZ0B0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185766; c=relaxed/simple;
	bh=hOlEdoxNEfW7/kBa8ui8Y0zxqfV5VbiQGdh+ymPkjZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye9bSepd00kRNzCf4yhcUuYVppBWTLTxZ119lJEgQN1Xba5t59v4s/z3BtUEADO9Q4tCzIitHAADMq0vy//Nn501dLxb8YH7bACPA3vEte3XcsR3/E5RhEb3TNLqE2/43aXzcoutQRrsjRazHzd69XqfnDosG5vXaIOvrNK/OZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EyOZ+IlU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EyOZ+IlU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678AVb3P4065866;
	Sat, 8 Aug 2026 10:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AsU0xm
	s9gnkMr5Lagcr6PJPecuNccEY9PFtYr+V61D8=; b=EyOZ+IlUpFH3LVSh6G+eO9
	e/3LThA0LxWd5V1sKlWYes70UyZ/cIlH9+A9fVmRSQG7EXnw3scYFyNPJz+kpX+1
	4Xj/QZKTKtLWoLbkDFLzMIEHd/dTO7lg4+PgP1C0L+d3txg1AfO2G1M948gjd9kz
	m7jcgZx0LxpQu9GoORr/pr8W4ifeYAD+WDQtYX7waIY2ZVcl7F7yGaoICB+CS2D2
	9LFnkgTLaBW+vEpa9iyqJsFvSgaJhlt/Kk/KBvBhkpS9jxTQ4pTTwHFlX0f5wqPv
	v+F7zbqEU0FlYZFtSt0imTL5F/DKmzsQR6cUfSoas4mZHCO9b/hfDZUQezaT5piA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2gup7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 10:42:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678AfL3I023162;
	Sat, 8 Aug 2026 10:42:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgu2g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 10:42:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678AgA4f17040044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 10:42:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE8958058;
	Sat,  8 Aug 2026 10:42:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F19A58057;
	Sat,  8 Aug 2026 10:42:05 +0000 (GMT)
Received: from [9.43.73.254] (unknown [9.43.73.254])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 10:42:04 +0000 (GMT)
Message-ID: <0854be23-b0f1-4e4a-849e-fb063568a2b8@linux.ibm.com>
Date: Sat, 8 Aug 2026 16:12:03 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on
 NIC queue count
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, kbusch@kernel.org, hch@lst.de,
        hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org
References: <20260731073918.614014-1-nilay@linux.ibm.com>
 <20260731073918.614014-3-nilay@linux.ibm.com>
 <amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
 <4d8c8d92-d39b-4721-a405-f03f01fbb95b@linux.ibm.com>
 <20260807160904.2eb1b3d1@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260807160904.2eb1b3d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a770803 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=lCtdQaFTb8nA7LsVnqEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _sF-0WFtf3DQxSYcwT38Ru9-b0G7G99A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDA4OCBTYWx0ZWRfX29VtNruy/AA6
 qGtDw1iXeLQNbCiWt+DZIwQRn5erEL9P9o18MaANKuQEfmirCuJnxKaFXFwIsqoG466pJLKhiuz
 unVW6oJ9HxZ7Y/c4MB7i3jbCzMIukk7TxMnuH3MqJpuazZUMPYlhF4JRAzvVkkwG6aRH3lJjl4n
 w+0k0AztZTZaR/RZ4dVCjiDxcryy/WNpEaPm63TPFGyo17yhGvbxGK8ZICyc48uakqzpIdLPuox
 afQEjpz13kDFWOi5Rgjxgkvet7oXecKMvtWFKz6GWQdO3BlwepbRO+63avVRPrP/6Ma0rp1iVLs
 CqYdsrdezYPDQD1kLir6PQq0mZA+uz5/0PD3rDVfFU2BgnDHQBqfSdwu9Dumvh0zviLI8OczzhK
 rt7FPOhCQcm8oTbht7lwTZDnxqD0Voz0OZwmqwyAF1JgfWe9bP4iDB7d0GLHa2l0E/p0yxbWfU+
 0T1oJxnpAiR+2+Ie98A==
X-Proofpoint-ORIG-GUID: wHGT-tI6ZL2b7vm3lXmXFR8mYGI-VII_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDA4OCBTYWx0ZWRfX4EBKXQhdO+Vr
 MAPtCEn5+V9VhbB1sBMWxlruwX6gA5WBkpPLvmE7vkF0sL3ASkNZgLQyT+dujxOilCbC42nRApD
 uli2yu8aAJEK76vCzWq+9N4UhiQyZsw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080088

On 8/8/26 4:39 AM, Jakub Kicinski wrote:
> On Sat, 1 Aug 2026 19:08:05 +0530 Nilay Shroff wrote:
>>> Looks like the userspace can already pass the preferred number of queues,
>>> so in this case, why not do all this netdev resolution and queue
>>> estimation in the userspace? Presumably most or the users you care
>>> about always go through nvme-cli, right?
>>
>> Yes, userspace can already specify the preferred number of I/O queues, and nvme-cli
>> provides an option to do so when creating an NVMe/TCP connection. However, choosing
>> an appropriate value requires userspace to know both the number of online CPUs and
>> the number of active TX/RX queues on the NIC used for the connection. Determining
>> the latter also requires identifying the correct netdevice. That may involve a route
>> lookup to determine the egress interface, particularly when the NVMe/TCP host and
>> target are not on the same subnet.
>>
>> So while this could be implemented in nvme-cli, it would require userspace to duplicate
>> the logic needed to determine the actual netdevice and its current queue configuration.
>> The intent of this change is to make the default queue selection automatic and avoid
>> requiring users to determine and specify this topology manually.
> 
> In another message you said you add ntuple filters. So you _are_ doing
> what you describe here as a problem. User space will know something we
> don't know sooner or later, so you should just add the uAPI instead of
> guessing in the kernel. BTW the queue count is likely to change after
> all of user space boots, so if you run before whatever configures
> queues for the machine in userspace you'll be using wrong counts.
> 
Well, that ntuple filter configuration was done looking at the debugfs
output which is produced in patch 4/4. The debugfs generates the
enough information including queue count and per queue flow information
which is then programmed into ntuple filter.

>> An explicitly specified "nr_io_queues" would still take precedence, so userspace can
>> override the default when desired.
>>
>> Just for the note, this change also follows the general approach used by nvme-pci, where
>> the default number of I/O queues is constrained by both the number of possible CPUs and the
>> queue resources available from the controller.
> 
> Not sure that maps well to networking. For TCP at least there will be
> a protocol stack that runs between the device queues and your queues.
> I guess that will depend on the network and the details of the
> benchmark. But again, better to let the user tune to their workload
> and machine.
> 
> Consider patch 1 nacked.

My motivation here was to improve the default behavior for the common case
where nr_io_queues is not explicitly specified. So if the preference is to
keep this in userspace, would you be open to exposing the required information
through a kernel interface (if something is still missing) and implementing
the queue selection logic in nvme-cli instead? That would still allow us to
automate the default queue selection without embedding this change in the kernel.

Thanks,
--Nilay

