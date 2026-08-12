Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2137756A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558343; cv=none; b=uDbNXaewQucFYkKk85VRSbel7ZUMRMBzk/zYzeX8Mk5cxsd96Nr9Mw57jeW31XtwPkYp7XWQwELmRJkqQFZj7/uCdh3vcY4MWpPNwkXx6u3hG3G6ADRbKUTTzKLKq5gB7YXJ1N5Y13+p0FOqlkJXJGVJe+IVzpfg0s8CO3J5t54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558343; c=relaxed/simple;
	bh=Awuh55Dv2HbOa2GEwC1BBkM0lDLzmTCI2yjtGVJBDsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bdt90hFkxBpu8rVwXKF28ekhznQBaxyBZPTahHTh6ExhOjTV71mRaRHoTslWMBTxnYRJpcFbORECuJiEeoZ8PAzjx2a4HqBagHCG47A4SfhnlgFXl6AtAlQ1/MK0tlc9s+hASOl/2fPtOF9rV38RS+5HYKSTLVErc1neXIuQo+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R03a12vA; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R03a12vA"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso18283765ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786558341; x=1787163141;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AB1gvl/F2OQfJ4MVQmK+MbDvhJbmpEg921BEgoITqH4=;
        b=Q5lZizavBhP2m2L2S0I8Yu7NLGzXuLDaUe8JEDdheK5Juq3+LCUm6jpsHSZuaAVJ2x
         xyPlL2QznMpwvaFuFR+PECrOZtlnEh53qHCz1kIWQKt8uFoWBKwzGCnGWXbqGGLrEnv0
         gODe1dWF7jqar4OZwDFZeId4qUIAKTYVCl6/WVy9KQ4/zR2gyuRbC+8dJKniaIyR5lWc
         Txb4XQE6J8oiX/VRKaYwtHovt00IlKNXxjHmuLozqxJz9DGWaNpQq3n/aHn3IWt8Yl7N
         EblVCOmDYXbj2IjcGjqdeRDVfFAu/4kSi5sQSx+NDKmQ6dhtfCMZ8aeV3w5YgtolQ59O
         QWpw==
X-Forwarded-Encrypted: i=1; AHgh+RrzeMSloRM/KpgyEZ4rdUNdjiJ5JvM1p6Kb4WI7iDBKPj3XE0FxG5jVTbK9igUWXqFTexdzphs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6t80Xnk/yacu2PG/MsIWDTswU+nxbuAXO+EwtWLbzjpf5QQR
	DstL2JcLq5vm4fKj5iMSwj5AosCCJwODz4x4N6CCNCFqnQHwIkHSQb1XtPGAA/i1gSE6Ik1e2kG
	PurtbxgsaD9RWhaLw0biEWHEdOI+v1pW+NiYhHv+KMS+CpqASSKh4f5fmmD8fZpSuKrNNAzNbeb
	4G0bCGuzzFFCJJBSTSj7+yUZjrqN/hxhdsLo32W9P5imIH/+8gucar6AhGspO1tClLcgQ0Tpjrk
	hQ68Kt/vsvfus3H
X-Gm-Gg: AR+sD12m3+kP+Tueh27bOgt/YVmI1IIi6irhqiNQLxT8nEgVH+Ih0OCLq58zzn0zYpV
	5IMwsz/qXpjHnq0tY6b5Ua9zQJJjQ/NOhKUfZY+afEreYm28VWCCUGuEf+ZladjoXy8SbjFN8vH
	K1VUK9bEQNedzLxBCex6yN3H9/A6eaxUuCj0YyfAWVw8ZzWJr/NhDzRtOiXVXI9Mlz0yOpzfqq/
	DhkmLZAurttZYjFtKUK80DSWJAeixbAxDa1aSX50PkU3TfOZ4dUUcHCuVeUrhJMJdeZZn1kkiag
	oXE8VCMyQwkxsH7w6kp2dpoNHXRb9+XY0e6x6zJxhhQgMCLFCA9iD6Ght6FR3plBXcm1IYC9W0O
	W+XLNRQNC0lMubaujOZeQw37XVtAm1zxNy0pGJHVQBn6cbOBfveyg+D/XUiELzEFvgXQD+ezrO4
	FKDr754seWNHJC5y0dFNFqGd+CLERXlK0O8BQEhAKZ
X-Received: by 2002:a17:90b:268c:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-3931e27b831mr42527a91.19.1786558341236;
        Wed, 12 Aug 2026 11:12:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3931db1e79bsm1070a91.3.2026.08.12.11.12.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 11:12:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1c7f135bso21144221cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786558340; x=1787163140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AB1gvl/F2OQfJ4MVQmK+MbDvhJbmpEg921BEgoITqH4=;
        b=R03a12vAYFZJxtjeRI2/jEHvHAzHFU4EjVvc/7Gng5rWfiV1+rco043N07Qeoob+DS
         9pUlcn4yQnIZpLT9jcHtqM8TLBOgWfCrh2AtpFWMM7u8eue45DWzxA7snBUip5occX5m
         jWLOc9Wsk0nQXdC429Uga4wcLe1aLCPdEn3HU=
X-Forwarded-Encrypted: i=1; AHgh+RoQzrIRfI63hlCq6EQ8clfl4dlm++XD7i02hTPapdmbTYREzYhMZlRUyBgMp1bfppkO8PJx9lw=@vger.kernel.org
X-Received: by 2002:a05:622a:4d05:b0:51c:120a:91c1 with SMTP id d75a77b69052e-52d73c52ff0mr1191031cf.17.1786558339571;
        Wed, 12 Aug 2026 11:12:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4d05:b0:51c:120a:91c1 with SMTP id d75a77b69052e-52d73c52ff0mr1190391cf.17.1786558339093;
        Wed, 12 Aug 2026 11:12:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c2a05f3sm26630526d6.18.2026.08.12.11.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 11:12:18 -0700 (PDT)
Message-ID: <aba2dbea-b127-4604-b5a3-7c6c70368fb1@broadcom.com>
Date: Wed, 12 Aug 2026 11:12:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: dsa: let drivers offload 8021q uppers on
 standalone ports
To: Jonas Gorski <jonas.gorski@gmail.com>, Semih Baskan <strst.gs@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260806073119.387-1-strst.gs@gmail.com>
 <20260806073119.387-2-strst.gs@gmail.com>
 <20260806111523.gjlhjfmb526f2y4g@skbuf>
 <CAAsRjRnhdPJOCE5BwU7zUTJ0mtSYCOA3xLcF5ejZQT8OFjYiYQ@mail.gmail.com>
 <20260806124313.see74vgu4dlqqse7@skbuf>
 <CAAsRjR=RyiraYdLkOcHEagGKXK5+4zwQbT-Zq-1DwVkPiKUNpg@mail.gmail.com>
 <20260810120821.lykofvogbrn2y2ps@skbuf>
 <CAAsRjRn7qFWy4UBL8tWGQ9pBo5q3du4e=tU9gSKkSSd7K3RaDA@mail.gmail.com>
 <CAOiHx=n43MPXKxA7oxBjGh15pa4Uh5etxkPdrV+0GxACEnrRJA@mail.gmail.com>
 <20260811095828.xwb4nsmx74wtzjei@skbuf>
 <CAAsRjRn0LNMspFCbi_7QMQsNPBhMXeAZfcvrc40k-Y87F7jHmA@mail.gmail.com>
 <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <CAOiHx=mv9Ygywqbi9pR_K4vvu6tJtxdj9zObp_QB80wwV2zmCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/12/26 00:24, Jonas Gorski wrote:
> On Tue, Aug 11, 2026 at 3:19 PM Semih Baskan <strst.gs@gmail.com> wrote:
>>
>> Hi Vladimir,
>>
>>> Then I suppose the VC4_ING_VID_CHECK_MASK affects only what happens with
>>> VLAN membership violations (i.e. VTABLE hit, but port not in VLAN). Thus
>>> it does not influence the VC5_DROP_VTABLE_MISS=false case, correct?
>>
>> Correct, at least on bcm5301x, and this part is measured rather than
>> read from documentation: with VC5_DROP_VTABLE_MISS clear, all three
>> VC4_ING_VID_CHECK settings behave identically for a VTABLE miss (0 of
>> 7 delivered in every combination, standalone RX probes from the
>> measurements behind the cover letter). Whatever the check field
>> controls happens independently of the miss path.
>>
>> One observation for the "is there another bit" question: on my
>> BCM53011 the running value of VLAN_CTRL5 is 0x10. That is bit 4, which
>> the driver never writes and has no name for. I do not know what it
>> does, and it may simply be the bootloader default, but it is a bit in
>> exactly the register you are asking about.
> 
> Assuming you mean VLAN_CTRL2, this bit is described for BCM5325 as
> "When set to 1, GMRP,GVRP are checked by the
> VLAN's forward map" with a default of 0.
> 
> Since other bits (sort of) match with their meanings, one could assume
> it retained it, and now defaults to 1, but there is no guarantee for
> that.

On Northstar, bit 4 in VLAN_CTRL5 is described as:

EGRESS_DIR_FRM_BYPASS_TRUNK_EN: Egress directed frame bypass trunking 
re-direction enable.

1: egress directed frame from management port will bypass re-trunk 
re-directed rule
0: egress directed frame from management port will follow trunking 
re-directed rule

> 
>>
>>> If customizing/unifying the behaviour on VTABLE misses is a dead end,
>>> could we consider an alternative? Some switches support having the
>>> VTABLE enabled, but ignore the 802.1Q header from incoming packets
>>> (thus, all packets get classified to the port PVID). Is there any bit
>>> which achieves this in b53? What do VC0_VID_CHK_EN and VC0_VLAN_EN do
>>> exactly? Does B53_VLAN_CTRL2 maybe have some useful hidden bits?
>>
>> I cannot answer what the bits mean from documentation, but I can answer
>> what they do on bcm5301x, measured just now with two external endpoints
>> on two front ports of a vlan_filtering=0 bridge: neither of the two
>> candidate bits gives that mode. With VC0_VID_CHK_EN cleared, and then
>> with VC0_VID_HASH_VID cleared as well, tagged VID 100 frames still
>> deliver 0 of 7 to the far port and 0 to the CPU, exactly as at the
>> 0xe3 default, while untagged traffic keeps working in every state and
>> the default restores cleanly. So on this chip the 802.1Q header keeps
>> participating in classification as long as VC0_VLAN_EN is set, and
>> clearing those two bits under it does not change that. Clearing
>> VC0_VLAN_EN itself is
>> the earlier thread: it works but costs the VID-keyed ARL. I have not
>> probed VLAN_CTRL2 for undocumented bits; on my chip it reads 0x10.

VC0_VID_CHK_EN is not defined on BCM5310X, however bits 6:5 are 
VLAN_LEARN_MODE with 00: SVL and 01: IVL.

>>
>>> How badly broken are the configurations with only port 5 as CPU port?
>>> Is other management traffic like STP also not delivered correctly?
>>
>> It splits by the port's management class, measured on the RT-N18U
>> earlier in the thread. BPDUs ingressing switch port 0 reach the CPU,
>> because port 0 is WAN class and its traps go to IMP1, which is port 5.
>> Management traps from the LAN class ports 1-4 go to IMP0, which is
>> port 8, and are lost, because GMNGCFG has no "IMP1 only" encoding: the
>> driver's OR of the field mask programs dual IMP mode and port 8 is
>> down. So on the in-tree topology STP is broken on the four LAN ports
>> and working on the one WAN port.
> 
> One thing you could try is to mark all ports as WAN ports. The
> WAN_PORT_SEL register (page 0, offset 0x26, 16 bit) has a bitmask for
> wan ports. It may allow delivery to IMP1, but the description of the
> WAN port feature is also
> 
> "Select a port as a WAN port, then all that port’s traffic is
> forwarded to the CPU port only. The non-
> WAN port traffic from all other local ports does not flood to the WAN port."
> 
> So it may also isolate them from each other. Also out of curiosity,
> can you wan port talk with non-wan talks in a bridge? Because the
> description implies it should not.

IIRC, the use case on Northstar was to basically have one of the 
internal ports as the "WAN" port and the other one for LAN traffic. The 
idea was that this would double the bandwidth internally since each CPU 
port has allocated bandwidth and this is the scheme that is used to make 
use of the flow accelerator block (FA) which is not supported upstream. 
Now that generate AI is a thing, maybe we will see that at some point.
-- 
Florian
