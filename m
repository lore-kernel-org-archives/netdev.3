Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30772C15A0
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214561; cv=none; b=Qly5I7nGr9Prxx2gdr4UCHWMjIyR5Pcx+RAelu5cAiCGuxCu5srmREjGdtvfFa9PTAKnw8dKdzW1xJFNKuTMqaTpYseqQ3oQloM0lL2oOYzXlBzngdkAQMksZw6oA+bVpCvaQA30XjWnszV7UBfxiMpb8lXNayonvGqDNKKi0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214561; c=relaxed/simple;
	bh=Tcqaa4bqXMU/Z4jGuu4RMTJjgw1xL0gh5E7zFg6CssY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9Xe+K1W1r2yHFUsYttJzKHD8s4Y4UtRZmFi2ENrCVUzgJB37AV+Wwp+joO6txFms9E1fbmarP0zpQDLLEcJ5XjW9/J0ZQE6g8Pl4KPtfaBrBQbx8NWulBl28XLWA2BOp7ig2tSfL7aIgBAIkq2doRL1Y+8AT3IyB1aPLOc5QIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PI5sRbII; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PI5sRbII"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVe7R3543497;
	Thu, 20 Aug 2026 08:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=13wrTu
	b/SodjGz2PB4pQRQjbsXMZr0p9z3daqZcn5VY=; b=PI5sRbII/6dKSEgoMTMMiz
	rkgoR4nd22lfinMM1QwHd3w/4QspBBCfd6QXt6jBXJHe+I7yMXzzsjjZZf6RcOnI
	YZDHhgYv7Nb68PqWBHfahz2g5xHVN1o9uwBgMpEZ+cg5isnF3n/YQQiNY7sVsmKr
	BJ4MPXSJM/yJUE63EVg8mPjKW/0rwSt4e1Z3U6rz/aIx9dim6OyAJ+aeLj3v8d4J
	THCCG8/kZ5mofO+/vjjZ3JZCvdiFc9NzXNG8VJmzRIYWCFIwtEdCIuHzpcnHNMbd
	WaItxvBRUW87bF8HXn2KrwmT89G87DJnN3mbknXx1SC8tWKAOOf9C8O8giN6r8fw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu28whk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:29:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K8QHKV014813;
	Thu, 20 Aug 2026 08:29:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngn8m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:29:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K8T6E746006762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 08:29:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFA5620043;
	Thu, 20 Aug 2026 08:29:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A280F20040;
	Thu, 20 Aug 2026 08:29:06 +0000 (GMT)
Received: from [9.224.90.36] (unknown [9.224.90.36])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 08:29:06 +0000 (GMT)
Message-ID: <9cad8318-049c-4ba5-9e3e-fe1d843055f4@linux.ibm.com>
Date: Thu, 20 Aug 2026 10:29:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: do not bond/team netdevices which use ml_priv
To: Hangbin Liu <hangbin.liu@linux.dev>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Jay Vosburgh <jv@jvosburgh.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jiale Yao <yaojiale02@163.com>, Aswin Karuvally <aswin@linux.ibm.com>
References: <20260815153938.187073-1-socketcan@hartkopp.net>
 <20260815090015.4a518a54@phoenix.local>
 <02333bd9-89c4-4952-8ae2-ff3c15dcd4df@hartkopp.net> <aoQwCj9AXNI1qfsu@fedora>
 <072004e8-d5a8-4f01-9dd5-da2d3aeaa447@hartkopp.net> <aoVzaHfKWG-_OJOY@fedora>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aoVzaHfKWG-_OJOY@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a86bad6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ivnOcfrofSNn3e7DLqgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vZaMPFWjpx8mVIlk78tCHvM8EPpCVpRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX5Ta3xNw8Ll8J
 loCUC5Mg5s15S+MC+lgZXTKePtaJSR3klAbscGtByLnk13Oi9lDFpVycyncWVBjHggHozC9v03i
 z+lzDH49qB6VqlgZIdAVNHtPM3k/GgDQcTUtTC3n4J/8mQg96TEC5bHN/hxNSq2AZ0UznxX/Njp
 F89CtMzsMUOOtukZphV1sKQV7UcNgptfDxUI+g076NT10Lz7GeuTHfjkB6WSsdlalI1YY4JqbEl
 KUUDbLNJUTAHQMc3UvS1mtzyEhsXmSc/I5Vy0Zlb3GIJPOlLjhoHU2K0H2Je/QSPK5iuguaIeXp
 yDNPnH+hDKz4ioEkR5WmYJG7l00ZTcYGAcq2kNyzDpnnKgG/mnWc2uaTjZPE9yMw1W/MXXVPVPE
 5+U6t3Zvdy+aoe8+LX1JJ0ESu6wQgl61T5nlzkduYWyxOo054So1pHMpuMbBivquW7eZnnhvCPM
 Pj9CQvsFxXWnqEYg8jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfXxfvP2eaovIeL
 t90KzjoB9Kpg+DZNvA3+AI5mVvInPORLC38OatAutfKap419ZOLmU6bmzJhHuNIe1snVK2iRMci
 YD22jKQw+ETleC9nh/5yGPCKFj9f68w=
X-Proofpoint-ORIG-GUID: qaqoQcGBSBKZwuE7jYe4q8mUDHvg0G2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200057



On 19.08.26 11:12, Hangbin Liu wrote:
>> The fact that the issues have been found by syzbot for CAN devices might be
>> through to the fact that the virtual CAN interface (vcan) can be created by
>> netlink commands and can be easily used in test setups.
>>
>> So what would happen, if the same tests with bonding/teaming/tunneling would
>> be done with real hardware drivers as the mentioned "direct ml_priv writers
>> still in tree at this revision:
>>
>>   drivers/s390/net/qeth_core_main.c:qeth_alloc_netdev()
>>       dev->ml_priv = card;
>>   drivers/net/ethernet/chelsio/cxgb/cxgb2.c:init_one()
>>       netdev->ml_priv = adapter;
>>   drivers/net/wan/hdlc_fr.c:fr_add_pvc()
>>       dev->ml_priv = pvc;
>>
>> plus drivers/net/ethernet/i825xx/82596.c, drivers/s390/net/ctcm_main.c,
>> the libertas main.c/mesh.c paths and
>> drivers/net/wireless/microchip/wilc1000/netdev.c."
>>
>> ??
> I'm not worry about cxgb2 or 82596, which are too old. But s390 qeth is
> still actively maintained (Cc the maintainers). Can we block them directly?


Thank you very much for the Cc I would have missed this otherwise.
While drivers/s390/net/qeth may be decades old, it is still the most used
network driver for the s390 architecture.

!!
qeth_l2 is an ethernet driver and bonding is heavily used by our customers.
So: No, please do NOT block bonding over qeth.

I see your discussion has moved on to other options, but I wanted to point that out.



qeth_l3 is a transport layer driver (arp offloaded), so I don't think bonding or teaming
can work at all there.
ctcm is not based on ethernet, so I don't think bonding or teaming can work there neither.
Aswin and I will put it on our ToDo list to find out what happens, if somebody tries.
Maybe we to add them to the blacklist you mention in a later reply?


> 
>> If bonding/teaming/tunneling might accidentally overwrite dev->ml_priv we
>> have to block all those devices. No matter if it is CAN or whatever ethernet
>> device.
> How would bonding modify dev->ml_priv?


Could you give more information about this?
I hope there is no issue for qeth_l2. There we use and rely on dev->ml_priv.



