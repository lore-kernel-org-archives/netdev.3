Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705229;
	b=rVfAPj88jF81n2Ovzo14XC0M2UserBqFqC2P7OsNrwpMYOK2dHCWeH2sx2lcqB0Sn7QG
	 F7w0/Jbhpmxg+0T+od29PnV62omCGPAnyQCCFeMN5WrBdBOXc6O7wjoRRxTAmWHJ0zHA1
	 LZ1hodPii2InkBHNkWjX2v0jVE9UdEqVQoO/lfEgj8d7bT9nvEEcIXJDfVptT6Hcv0yJE
	 RZQZNpeXE3efmDodUyfPjkxczXEyZZO5aQZGjclz8R+qVyF9mARKJbocI8fSIAN60y28Y
	 fIyyFxfk27BQSk9DNWjztgDjGNyfXTKXu0sC1+fiJD5Wk5GpRgjIN5/5S3puvfCh/hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705229;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6ZK4MEp+1JhLWagJOOKQAnhmLtK+F9M0oYPH1JwAIqo=;
	b=dydHB1bIiBeTf5dwpTZpLZthWvuDOWRegnzUZnimFnTyTOIJP/T1vXvzc3SGOlf472TF
	 I+ovFllM9pat7jm7M7+rNNCx8StD1cCJTB25C9M7fZS9lVGTCQKXmQtixOb/rXIQpbxUz
	 u2MFlLCYdgy4mHHIWCIPdlKFW7jAUklFHB9wtWH/dRQNLa3D351hY7RP6dHKLpElmUWT7
	 NUNg2Bz4f+1Asz5EQ35dBdUD9USiakBGDmdxPIuNN+a75QX98wwDab/hJioS4Sk6wyuOd
	 CavEsTojSvm7mej++uO1j8vZbYhp/1Iw58D9CZcNxIyHZz1YNa1p8jNE0JJBWRxJXqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIzcpetq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kukZe6Tt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B0606C541
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 862B0606C541
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIzcpetq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kukZe6Tt
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAUw21594184
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 11:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ZK4MEp+1JhLWagJOOKQAnhmLtK+F9M0oYPH1JwAIqo=; b=cIzcpetqGekZWhko
	Co2+K+dm5h+cI5fi/8nw6oLUIG96JJLqdgMIv7NGTUM2mjyrvlC+tC9Wogfk3LbD
	llNJsjw8AxaCbmlETQHHOYe+TBTcN8+kT2Ma1k2AUyvkQmdo53PVLQqgih62+z+C
	RftpfmkTKG5akAJEcplZfu2As5jqi1qIgCk37ZHa1/UhRVP4NwMLZQOLaGiUTaIc
	QVPLT+I+uqiYP2EaEnkeAMl0ebIURbQxF6SNPdyJ9LnepZsW+id/u0NwtuyNTs0o
	vpWrKZscLisfT6kOfHb39fiPeRcsbY+ZDwlsgeEzfO8szWs9hJm2of1I1E8qMhAC
	YgnHmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq081ufg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:27:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaae8d29e0so35679115ad.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 03:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793705227; x=1794310027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZK4MEp+1JhLWagJOOKQAnhmLtK+F9M0oYPH1JwAIqo=;
        b=kukZe6Ttq7r6DYTXpBP3luW5XadHvVG/Cw4/pZUq+ndxgzPjTz0UaHtow28oVll1K4
         7AXjfpKnCDY/b/weD3d2yroSsOe/2vHgTqFwZJ0LRaPUnCQC1YswhZMsyXa+eeSMML6G
         wtaheiKtYiVwdCF3gbaBtjsTN8ir02qJhk7kVSP9hPZkVx7uK+MBn3fBIHZqgqLLmQTJ
         WZubkw1QI0DOL+ZkGgd4T5uKLnk6jmsl48kdVxSDhfEQFnFfdqMLggg6U+R+R5K5WgD7
         h5wscDONsyojqWWvZk5EfzDGH32gVHtP6/kxdbasNoELWxDBgedquHDZ8O7pR3w1zOI4
         A/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705227; x=1794310027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZK4MEp+1JhLWagJOOKQAnhmLtK+F9M0oYPH1JwAIqo=;
        b=KR6SEx5M7DRSGBQpWbB/nJwYG7p2lpfiG9xkuFn7yV8u7YByKnHEnZkr0b6+ExBdmW
         INfu+aCa80+fjgm5YbTK4L7+TFlwLVNVrgDhHIiL2UnihxJQP0HmxeGpharOwzAb3cXx
         pdMylZTyUP0hB7EO/O29u1XQzyI/Z5n0fpdRlrvH24TftN1t0nB6QJVhCdV0nuQFdYSd
         ztVQVlLdCG1083Y3yH09F3pAeQh02QEYD+Ztne2nuG0GsHFLa5WRv/u3sFU66fSLRFxE
         wWHdaKuQ2EUMRaq1mgcQo25hi9Atv3CtB400DWJ1xExFaEoIxLi4gAB8XaPMBe+pw2IW
         ALrg==
X-Forwarded-Encrypted: i=1; AKwUvBz1ajwfAyJ5ID8LcG7oguxlpFWRe7pyZVrCgKOFQy99tHwzglV5lSBe/tfK5CnH1vbneeKUqVU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UXyOXZimIpBe6Jgax/Afej+ENyBG44Zdwu/A1F5y6fRHG/RKe
	8fF7Ygxcx0P8h1Agzlygw1tFsmmYFFUR+I97ZScUeX64UBHlzoTeNwD3/N6irnrCflS47bK05q3
	nv9lNmdv1xblxA++QFdDV+UDuWJG1KE1HeRVqU5WkvrbdZQbm/qprir9HMyc=
X-Gm-Gg: AYBFou33/5Ae+dMGhbaCYvP4FqeRx7TQwKJnQx+Jpxhq5oW+SC9/fs3Hlrud+KaWP7k
	vFMMcvOZsPNZw229XJ+612OBxJ09l9mJbQ1sIiWElk8mEjSWCH68+NbXmSEjlFALpol6zDkEM/y
	5OU3I0G5WTdP6wrwcRVOMWIjpGy6jfNwp496GHUS/+VzmsCerE3is5Qg/yFIPBLt8NwOVSVCgL7
	HD2wcZLonF+N/KPX5vfqURmUjYHFuOdtHqv8iHqj2KWzgcLnVeGiZZh8fTHXYfkgvkXsFK418+o
	t2H7c48jTKm4CK4kpM5c2g8eMloe5NlzpYiv8QiTvRew5ji/IEu+W7HHFt4Q4iDTN6r+5OpJNrF
	rQhMDKePb3PsnHRN75EaWPBgxBC+rfEiVKymM806HvpyKrvkoVwo6NTgeud85CIvTGgGfwpyuX2
	nh75lppqiElJsB2bNTrClYHVR23RYJgkY1QKTLs4xFnSDnaU7aGRWJPV4ckr+5GT52D7kZNDQuV
	9k=
X-Received: by 2002:a17:903:2ac7:b0:2df:ab73:7e94 with SMTP id d9443c01a7336-2eb36475385mr99038255ad.51.1793705226872;
        Tue, 03 Nov 2026 03:27:06 -0800 (PST)
X-Received: by 2002:a17:903:2ac7:b0:2df:ab73:7e94 with SMTP id d9443c01a7336-2eb36475385mr99038125ad.51.1793705226361;
        Tue, 03 Nov 2026 03:27:06 -0800 (PST)
Received: from [10.149.127.220] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052effsm39701255ad.3.2026.11.03.03.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:27:05 -0800 (PST)
Message-ID: <9400d812-c0ad-404c-b1c2-50860865e336@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:57:02 +0530
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
Subject: Re: [RFC PATCH net-next] netfilter: nf_conntrack: add ct expression
 support for netdev egress chains
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, phil@nwl.cc, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261006085844.2694120-1-hari.chandrakanthan@oss.qualcomm.com>
 <asTd69Buuk6PisMl@strlen.de>
 <fe6fe48c-df09-41be-acff-bbae33454bd9@oss.qualcomm.com>
 <as0HMjsgUvKd7dAo@strlen.de>
 <67d8e88a-eff0-4c8d-a030-b29b5d86f450@oss.qualcomm.com>
 <atISKsTHeHwAXfZf@strlen.de>
Content-Language: en-US
From: Hari Chandrakanthan <hari.chandrakanthan@oss.qualcomm.com>
In-Reply-To: <atISKsTHeHwAXfZf@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfXyXmhbVPp5pJw
 rxVaPsWY3DqZaqoXyPst8T2Tdlm83bGI6I9q4PE3RygxmaPRAhMP8trduhZ2uPweRoybdDx62ek
 IIG/NT5jfJrm3huYOTHOleY9kkL4qL0=
X-Proofpoint-ORIG-GUID: 48n3177jhgAOLir2ImkkttBpDsh6Icxl
X-Authority-Analysis: v=2.4 cv=F73C5ahN c=1 sm=1 tr=0 ts=6ae9c50b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=saytb5X9iVpQGUYAlOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 48n3177jhgAOLir2ImkkttBpDsh6Icxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX2KPqP2tcRBkm
 elv21pW0MuNLUD4Y7SWTCqRWmvSWpXy6uT5lJfdSd9fv4umfrvKm4HCWtUADsZy1soIOGa7w7aC
 mZdtluhhScilZPw0O5PysxjUSQXkHv9ucNsIpYfEpshOVJXBzSnZWSAB7y8QB7hwlSqmyuHpDZ2
 uCSTPqVXbxRt+gnpC0NSLjXpfBtJQooi3fuJLYNnrvOmlB19UevWzw7fZ7btZAJgomhJuw9S1vs
 KyvY/22jpo1BD3k7yTuMnjPU1K2h+3mHHxGIkrYjPxsHQNHlPPuhIxiIihW9s5/XKirtNXKTaCw
 gpgyBdUf9Wcxwl3vBy04uwQXdVi/+HdacT0nRgzzcQoTsNJZ+dm796lqmkn2Wl2OAR8iSNGDLeM
 BCvvKMsBiBu9paFqkLhps5UzcLd2feTieqvIidFJhBKEkWyWWTW4m9plu245nHOcGXsClbLpPqO
 49PzgWxMTIL09niFSsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045


On 10/16/2026 5:31 PM, Florian Westphal wrote:
> Hari Chandrakanthan <hari.chandrakanthan@oss.qualcomm.com> wrote:
>> By netdev/egress only, I mean that the nft rule with a ct expression
>> (e.g., ct mark set) is present only in the egress chain for a netdev,
>> with no other nft conntrack rules in inet or bridge chains.
>>
>> For example, it may be possible that only rules similar to the below
>> nft rules are added at the netdev egress chain, with no other ct rule
>> in inet or bridge hooks.
>>
>> nft add table netdev qos_table
>>
>> nft add chain netdev qos_table wlan0_qos \
>>       { type filter hook egress device "wlan0" priority 0\; }
>>
>> nft add rule netdev qos_table wlan0_qos \
>>       ether daddr 00:03:7f:01:50:65 \
>>       ip saddr 192.168.1.10 \
>>       ip daddr 192.168.1.20 \
>>       ip protocol tcp \
>>       tcp sport 12345 \
>>       tcp dport 443 \
>>       ct mark set 0x10
>>
>>> Where are the skbs coming from, i.e. though what pipeline?
>>>
>>> Bridge?
>>> Routing?
>> In the use case that we are trying to address, the device is a Wi-Fi
>> access point router. It receives the classification rules from a Wi-Fi
>> client device for QoS prioritization of down-link traffic to the client
>> (n-tuple to Wi-Fi TID mappings) via SCS. We would like to apply these
>> classification rules on the access point router using nft rules
>> (ct/skb mark set rules) at the WLAN netdev's egress chain.
> I still see no reason to ever conntrack.  Is this for 'sticky'
> skb->mark ?
>
> I think conntrack for that is waaay too much overhead and would
> use a nft map for this.

   As I understand, an nft map would work for a fixed-tuple classifier 
requirement
   (for eg 5 tuple only), but the Wi-Fi SCS protocol  allows clients to 
push classification
   rules with anywhere from one to five tuple fields. In a real Access 
Point deployment
   with multiple clients connected simultaneously, each pushing their 
own classifier
   rule sets, using maps would require to maintain multiple maps per 
client and
   keep them in sync with client connect and disconnect events makes the 
management
   more complex.

>>>> To address this, as suggested by Pablo, we are considering enabling
>>>> conntrack lookup/creation at
>>>> netdev/ingress. This would allow netdev chains to access conntrack state
>>>> without requiring conntrack
>>>> to be enabled for the inet or bridge families, avoiding unnecessary
>>>> overhead for netdev-only use cases.
>>> FWIW bridge conntrack is already problematic (see recent RFC patch
>>> to refag in INPUT, conntrack is pretty much routing-only.
>>>
>>>> Kindly share your thoughts on this approach.
>>> I think you'd have to explain your use case.
>>>
>>> I thought you only want
>>>
>>> skb-> mark = ct->mark
>>>
>>> from egress. That would imply something else already enabled conntrack
>>> anyway, else you'd have no conntrack marks set that you could read.
>> As mentioned in the previous comment, in the use case that we are
>> trying to address, the device is a Wi-Fi access point router. It
>> receives classification rules from a Wi-Fi client device for
>> prioritizing downlink traffic to the client (n-tuple to Wi-Fi TID
>> mappings) via SCS. We would like to apply these rules on the access
>> point router using nft rules (ct/skb mark set rules) at the WLAN
>> netdev egress chain.
>> The nft rules at netdev egress chain achieve the below functionality:
>> 1. If connmark is not set on the first skb seen by the rule,
>>      perform flow classification (based on dmac addr and n-tuple) and
>> store the result in the ct's mark via ct mark set. Typically, this rule
>> will be skipped when the connmark is already set for the flow.
>> 2. If connmark is already set (for subsequent packets), copy it to
>>      skb->mark. Ideally, only this rule should be processed by the vast
>>      majority of packets for the flow.
>> There are three advantages we see in this solution for this use case:
>> 1. We wanted to avoid incurring the cost of n-tuple match for every
>>      single packet at the netdev egress hook, by applying the
>>      classification rule (tuple match and connmark set) only for the
>> first packets until connmark is set.
> Hmmm.  Conntrack has overhead.  Did you check that bringing
> in conntrack into the picture really saves cycles?
>
> If you assume conntrack is already active anyway to provide NAT, etc,
> then my point is moot.  But in that case all that is needed is to
> permit retrieving ct->mark in netdev egress chains, which is much
> simpler and doesn't require conntrack enablement.

I agree, in a typical AP deployment running NAT/firewall, conntrack is 
already active, and
that is the case we want to address now.

I will revise the patch to simply allow ct expression evaluation at
netdev egress chains without enabling any conntracks.

>
>> 2. Adding the rules at the egress hook of the netdev restricts the
>>      scope of these rules only to packets egressing the netdev of
>>      interest, without incurring the cost of processing these rules for
>>      traffic egressing on other netdevs in the system or other hooks.
> I think that IFF you really need to bring in full-blown conntrack, then
> Pablos proposal makes sense.
>
> However, I think that we really have to make many more changes to
> make this work, even to existing bridge conntrack support.
>
> As-is, bridge conntrack is no 'works out of the box' solution, it
> requires extra setup (conntrack zones) to separate VLANs or you risk
> unwanted cross-vlan-traffic.
>
> I think we'd have to bring at least the vlan id into the nf_conn
> entry and auto-separate such entries if request is coming from
> bridge resp. netdev hook.

Yes, we looked into this. Without VLAN context in the conntrack,
two flows with identical 5-tuples on different VLANs will share an 
nf_conn entry.

We looked at what is needed to address this: the VLAN ID needs to be 
carried
through the full conntrack pipeline — tuple extraction, hashing, lookup,
netlink support for userspace, and flow offload.

We will work on the basic support for this VLAN solution and submit the 
patches
once they are tested to get more feedback. The patch to create/lookup ct at
netdev ingress support would then depend on it.

Does this direction look reasonable to you?
