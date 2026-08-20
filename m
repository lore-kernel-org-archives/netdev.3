Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34D3B1031
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207767; cv=none; b=BCzZn5/pmXTEltM1NvNgxESyxXl8AwGjtLUTP9dw3zOd/bEO3Awcuwt/zgeF0arBd79T2ztgtzV0syK6+M/BZRbShKfo3/oBiC+njvzN7qVd35DreVVoy5V7or3OdvZLdxZqQghGSZoFPEc9CtVgv38URGdgJowcp79+Wj/oh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207767; c=relaxed/simple;
	bh=erYGrbs45+tNVdOHkrrsbCQ9YPahiUD+ygtc5SftmlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzMCAe5ANoSdTwmwETyUPX9tE4MhSX4YoVIMat9PN0ozIb97dt3uzBl3V2pAT7TPCsx2ZyTUyMDktj2eqqHHJnmZ4Lly4/9LzMrM5JjHXNz1SKqtFDJsK/E9oQtpXjplEN+JgL/xFdfmiCCm4RSZHN4bzbyYPd9qMxBKbDod/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWf2ghvz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lz1sOhm4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWf2ghvz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lz1sOhm4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6IJHI1027514
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iQjBHrZ6dsSgvYG4ecSVGh35N3+M+HZTXQgTlcFRvS8=; b=HWf2ghvzEe2qP20x
	SvV6r6A0PYqRmhfjJzkY9TT2kUE/HuvL+0J+/FKqbJyC8Uagcuuke/4w3zwTxsO9
	FdGG2J85zP8FJhyqEAxLIiKAiCIGa7ZVdgrJ/OzSbChT9eeUTWqJJo8H/V3VEIVH
	bRyRdxMn1CDSbqNe/7xff+xF9W9XoIi2TDVvSmPGFFOWhCmY44jsxtvZPIt1Lzbf
	L17o4lXf7QF210cyA9Shm6WZ60XrdlDC2orB5CbRu3rXoXiwd+op3Bzyospz6tDO
	vaECDW0SjadpuP5wrhs/zPs0YROhT3+fOqq4x6iY7QpDLWpxpi7Nx2MFHnpN5HeZ
	IiFCwg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es4kgf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:36:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3954def0191so3469449a91.3
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787207760; x=1787812560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQjBHrZ6dsSgvYG4ecSVGh35N3+M+HZTXQgTlcFRvS8=;
        b=Lz1sOhm4Ca4P/Sw6y/MuacU8FD8XWfX40uehMXmolFU77N1/IUeq39MQPnbrA9jLpH
         dMpMsu/BNPZksh9pH7IpigIkcFgRlYPICpnz3j/7yQqGhfUYXNbfAmgg+lVk7DVrl2Jv
         4TrkQxt94/eYx1mFwLe8P3vWuyV3h5u1JySXTSSFT1+QqKIeJX5TwhOgyntpFPiIZtRw
         0dIN5mdeG9oBWst4btOodo01JI7CmUi+jXYZMar2HzaN0ETNelnUbBBs2bb6YHeEr61o
         79AaBeuaYwnulNJ/o2IfhRYe/uCMGSqm1gOVxjxXgrrH086nd7L6ujHptA9dfB6HnvmD
         /qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787207760; x=1787812560;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQjBHrZ6dsSgvYG4ecSVGh35N3+M+HZTXQgTlcFRvS8=;
        b=N6qIMwvszFwjUsTgkdTQCXV22bYzIzrPV7AFqnFwKGfedWS4JbMDh61XkY3NTP80H+
         l3gkKM8gBpE55KMOnrYCFxShLcYierCL+UvqfexUcYkWyAePnx5yD0UgWpUFuINSdepB
         rTK3V4FBL6ZvJ3AfhJqKPpCIma3drkQUpwHjHZHrhrnoPug/5SrwEUmEqucbmL+NbbHo
         lYdrvhvPtzfWhT6CYslbpu8eE/ovV0mg+SkNcv4WxTDMDmZb1fxfhdWgDPs1ILCEn9+n
         dtvka73IgRsWFeQha+qabW/maqBStFz7GurVLp1j3AmRZSFr4v8irN/7PBqhLfnrA2N4
         ShcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrz/yBP912Dw3w74e/IrMl7OGL+5KDj3qwnHrvGUs9SRGUUyW9ZwUyfuJCxJkHzxit06friHSI=@vger.kernel.org
X-Gm-Message-State: AFuF++mFiynjQBmzJtSKUWfzHx7fZAcx0ecG3T5rNRQsGfZo0EVjWWL3
	wzCqUhRRp3CV8HrCblibgCLg+TUoqSE/kBW7JfPQTc9mFyFO1O5X1+JsLngdaUIBWcGlB9CtTwT
	4XC5g6azpG9PHKDG5+vOgm35wdDdPWmXCQeROJ4vViejmZM3XlzLM106W5i0=
X-Gm-Gg: AR+sD100ux1zDZUCJHpNCDkpiy8ENTNFQsDTZqY77qYDkMNgRmsxo5IKvPhJJ2xvTt1
	fj15LIyd1U5iQaT1IDlT/WnY5jadfFkpCKSGZozafhWtze6EHN0VXsE0jyaRMOcqBChT4YSXYU8
	z8JnwzAucDXTmi9V7dcoXBVnptj7GU+i4Gr5jaXNj7vbDKETiG5F+Ka8P4pN/B1g8uMSXCJEkjS
	xMP+soBXxfmvL6eeEcr2dJ9qWJlPEDuqzTgfHBQm2zd1LeDiDD8RbR6yihgPXoZJBEhW/DSuHeN
	pq8Nbg2ZwreRxMcjGQj+qUGstyq6CtJXPMFCzGPHeFYA04gyj8pkmaDpTOom0+H8TW3QtVysT8D
	bUGKL9XX4ZGoUOw5KqiQwiJvuXT+r4Vry4bsm
X-Received: by 2002:a17:90b:1e4a:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-39580ace5fcmr18433991a91.7.1787207760359;
        Wed, 19 Aug 2026 23:36:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1e4a:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-39580ace5fcmr18433908a91.7.1787207759901;
        Wed, 19 Aug 2026 23:35:59 -0700 (PDT)
Received: from [10.218.42.113] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbba811sm6020928a91.13.2026.08.19.23.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 23:35:59 -0700 (PDT)
Message-ID: <fc1c54e2-719a-4fda-a1f6-df1754046235@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 12:05:54 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: qrtr: Send HELLO message on endpoint register
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Lew <christopher.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
References: <20260807-qrtr-hello-on-ep-register-v2-1-a7f265a42f7e@oss.qualcomm.com>
 <6smj6xbr4gumprpplrrw46lhe6wj63wbmcfe3nadcyp6om5cbb@tk6xtwtfz55r>
Content-Language: en-US
From: Pranav Mahesh Phansalkar <pranav.phansalkar@oss.qualcomm.com>
In-Reply-To: <6smj6xbr4gumprpplrrw46lhe6wj63wbmcfe3nadcyp6om5cbb@tk6xtwtfz55r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Q8eV995O2nLcdontqv0YSsT0WfvURZtI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfX9/LjUgrIT2/t
 qMo8vyYso9qjO96PHjst4CpK7RgdHEmSIvMOzwtwRLKzV4qhZI7hCV+8pLbMlyB+UrwXi/HRm2o
 JCpGjoe8LKTjNppfqPn5rO0QU4Ah29YsSH6f8eFs8QLxn9AwAQ3jHKqKHJcyQkyYyr2Axw/RghL
 cLN3DaT+24x0YU9LkH8cn1sJC2tsUb4u0Yj2PEcNfWLaBYKJ9IX+2CpnkUNazc+CtM4w7USUzi5
 VvhDqC0COUM3VMbOlpZ+8HnNG4Pvjwb5TdnSupVH5femqjgeMEbiy1JRCLwVBIXbkZ+zbk2TaZ8
 ydoaugwta3BOyq2ZmWU1kWMJG1L9W1KaI4L090z3wBYVhbM+ahD0MYGzoWvd82Yi0eXFsZ7eZqE
 8BghWNZEyRO2VSmERLFvUTOoJIUawxAm8QaQUhuaatsoLBaHYNT2o03pdCyU2UFeWTZue8CH/9v
 hlMu5KEMAAWHprUZKmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfXzlbt9ygx8QQ6
 ekc5g1zuWUTH4yUd4rOX2XnQ+seMfe5A6Up7fLUuQvN3uHXh+f/JNZf/3T51ry2lSVBZPetvig7
 ++00YLcatQiM0rW819hvK7pRn+UobbI=
X-Authority-Analysis: v=2.4 cv=CN8amxrD c=1 sm=1 tr=0 ts=6a86a051 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=qc3QEUOGKWWRYTEpMpUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Q8eV995O2nLcdontqv0YSsT0WfvURZtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200046


On 8/18/2026 3:24 PM, Manivannan Sadhasivam wrote:
> On Fri, Aug 07, 2026 at 07:23:04PM +0530, Pranav Mahesh Phansalkar wrote:
>> From: Chris Lew <christopher.lew@oss.qualcomm.com>
>>
>> HELLO is currently handled entirely by the name server (NS): it is
>> sent once as a broadcast when the NS initializes, and again as a
>> reply whenever the NS receives an inbound HELLO from a remote.
>>
>> In a slave model, neither endpoint initiates a HELLO on its own;
> What is a 'slave model'? Explain please.

Some chipsets attached over MHI operate as slaves: they wait for the
host to send HELLO first and never initiate. Since the host cannot tell
which remotes behave this way, if the host also only replies, both
sides wait on each other indefinitely and no HELLO is ever exchanged.

>
>> each side only replies to one it receives. Since both sides are waiting
>> on the other to speak first, no HELLO is ever sent, stalling further
>> communication.
>>
> What about the 'say_hello()' called during qrtr_ns_init()?

That call fires once during qrtr module init, before any transport (mhi/smd/tun)
can register an endpoint, so qrtr_all_nodes is empty and it reaches no remote peer.
We have reviewed it and agree it can be removed as dead code in this series.

>
>> To fix this:
>> - Transfer HELLO handshake ownership to the core layer.
>> - Schedule a work item on endpoint registration to send a HELLO once
>>    the name server is bound, retrying on failure.
>> - Enforce HELLO-first ordering by dropping non-HELLO packets until
>>    the HELLO is confirmed sent, using bool hello_sent guarded by
>>    ep_lock to make the gate check atomic with xmit().
>> - Skip nodes with nid == QRTR_EP_NID_AUTO in bcast_enqueue().
>> - Remove say_hello() from the name server's ctrl_cmd_hello() handler;
>>    the core layer is now the sole sender of the outbound HELLO.
>>
>  From the internal QMUX documentation, I can see that a node acting as a slave
> should only send HELLO packet only as a response to a HELLO packet, which
> contradicts with that this patch is doing.
>
> Since the driver cannot differentiate between master/slave mode, it currently
> broadcasts HELLO during initialization and sends HELLO as a response to the
> HELLO packet received.

Agreed — that is exactly why we are moving to sending HELLO at every
endpoint registration instead of relying on the one-time NS-init
broadcast or reply-on-receipt, neither of which reliably reaches a
slave-mode remote like the MHI WLAN case.

>
> - Mani
>
