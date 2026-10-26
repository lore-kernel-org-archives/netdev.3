Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793043253;
	b=dohBfoSWntREEySOgTymIp4F3o3BwZIcApwetCspybgvDmAKr+jwZ7O9aZDqGLPIimty
	 IIKcXYqNb0iLXHEFI9WBUdoHJiWJBMogJ/ixz0PjYvXOgvNZtJHySr7OJJudGFWTIHj6m
	 9WdZWcoEWgBNH53GrBoe36Sn2NPmuaAqRbAIGbhbN20dJ59dl0TJIx61IUYFDHkHmIVKW
	 gz8qTqHumcBj5jI3L6KMH+qcQry3z52t0gPOR27qa3oxfMvlvUljMulDh05uziZmYb84g
	 q7WJTA9KCzUNa9PtwRFI7OWkOwqa752HmHMl9kOHDMK9RtPaGoqovgt+WanK2N8PL/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043253;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=HNU6ecoLDoNs5OZ6InUC4q5cc3Ja1sUxcVSSWoUZyrI=;
	b=Qst7eqiu/0JEhCG6w130nXzYhXSIIq9JcQ6MF+powI680kwZu6i+gEv6AnLc+aMMd9dq
	 ywrB2b6HO9zhRQkBUieMMYqUUOmzVOOjYTUsZOpRn2UmGW2eR0mQabQ/bGl2JINCjy7UB
	 a2N17v2DWDpVEXofEILLP4JO3AZp/GGMy5hVKAico3t0xiVxfjZLdZm7J6+i0rnU+rVLM
	 is0sToZzJieoq+dTi0P4DZy+IwU20OSTNLZo6a3WPtf+Y4badA2rA5kkHg+96fhoeBdaV
	 BuWARp1SsKkTelWtg0zFq88jLT/WfpbMeZbcqozixWvAF8A1eX5Dq6tAiFt/ok6tsQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Ir/uk0Gx";
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C590606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C590606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ir/uk0Gx
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-93f1ca4132bso286646385a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793043252; x=1793648052;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HNU6ecoLDoNs5OZ6InUC4q5cc3Ja1sUxcVSSWoUZyrI=;
        b=bDk2iDyMDEgAfxmIgjw/6gg9MR7rfRX4sGvQNEDKJNko5bvS0IBg0Zgymbf3vi7ifl
         tFScx5nDv3LQ9twt7C6JUGj1UoYOj5XIparoYLxhpBwPdcPUUnczG3c742xsQhj7Nh0m
         OzcXQ5eVfViKr+2x7H5PlLxYHRPMG19OWqlk+YpzvHRZhwmVX76idDo12FEe5Ln96yYF
         1+xxo7H37wxPwGEkCkiFCckZwwNTFDSupyVX1Lx0XzSRCuZjvZQLgADpJdwCAqRD+3cr
         ZCJP/Q81vx477P954FL0Fa31haqO09ZDsnArA4czyl7byjiMqasZ5lEfun5B/rdpn/0B
         z7Zw==
X-Forwarded-Encrypted: i=1; AKwUvBxTrVSFFSHtcERU9sDpyt/vehKwTUi5qaHpRs2cRCiyrwKDxhqB9NOnf1+h4XvhAlrOmpjjgN8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZrMm2hSejVb0i9siF9Ee+60yuf4+YB3q0l5uut2JUW2cREfsi
	OPZq2JoQyPQ0DAnqd/6/WB7YDw/A7Y3e9niFL8JhUTuJnfe52kbwCJySVMd9OxoJp4u3FKUVSvB
	lthk9/tfFqpMz4dcNzS+tONweEE5VUD0ZV+xfTi4TCWHEQ4bumOxWgan1kUc5oZS1yA8fIM40Fc
	/KZybvu+ZduGxEcoLAzCVJCGG623tcqqto082L86r0VR9nA7wQhz11ELPd+K1j7JqVvMW94vzE+
	CSc79MAg5/fYTRP5co=
X-Gm-Gg: AYBFou06/7gT8kPShZLWI8keH8k1tMZJmooqFZzBorGEU4/0jpc52iYcRzpkhZ+YuDa
	xVkk/1n5/BPr58bnXKUCARdtBW+thbzrkW5ZmrcOXdNx2JNoJbwIFpSiowEKfaah/3M+m+5w4DN
	ZAyz/syasL+crDpN2YdCIgTArJq08XESUosOPpRPKSpL3x8kPjBYKrVCtcTyNL+FfSUjajcRThn
	c3BxeEOfFxX9NddNl3+xfoItARqBvblX6f+zYo80PI8JpfWaSbQjuMvuiw4T5W99xlqStIwFfx7
	yHOXc6IpeGEjFNL7lqomNHw7MBtHyHG+xCBgOq5TlMCRTWONWyb0SYZtzF/XcyxRsg/LssI3t8O
	xvT/roTLTWNxAZb2ZsIs3uNkUpQdfZGjUjDlcQ/i+GjcDA6CYpzleB3Ev8NUjYZmY1ZnK2lc8/z
	hdgKWwIJ2BlcQWRhvkp99thRCqompWKMLlLoK1Fq/b
X-Received: by 2002:a05:620a:3181:b0:93e:56c0:bea9 with SMTP id af79cd13be357-940ef919ab6mr1202981985a.21.1793043251947;
        Mon, 26 Oct 2026 12:34:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f06747besm111737885a.8.2026.10.26.12.34.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:34:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1665200f4c2so3958094c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793043250; x=1793648050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNU6ecoLDoNs5OZ6InUC4q5cc3Ja1sUxcVSSWoUZyrI=;
        b=Ir/uk0GxG8T37f9eSr3mD9ZRkJi/bE5Xp/SwIx3VHTKSSz6A/CjDSnesUnGhaVVveX
         vUKGAQ6eZjQPOV5Gw/UES00H5i8tKY5uwrPIlGkKRspJPQB4MOWONneWTiqXWLD3jq94
         IH/28UEmmM+Er0AEXyo5G2WqLihBJ5RPPB8ZI=
X-Forwarded-Encrypted: i=1; AKwUvByzdQue2q0qEvHohTIhchtWZaEWi0wypDE2I85buadpp2kN8NgYMwmwe4N09DKGPd4Lq2BFDIo=@vger.kernel.org
X-Received: by 2002:a05:7022:2229:b0:144:fb87:5b91 with SMTP id a92af1059eb24-1993f202040mr16582421c88.44.1793043249599;
        Mon, 26 Oct 2026 12:34:09 -0700 (PDT)
X-Received: by 2002:a05:7022:2229:b0:144:fb87:5b91 with SMTP id a92af1059eb24-1993f202040mr16582364c88.44.1793043248777;
        Mon, 26 Oct 2026 12:34:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm25726491c88.3.2026.10.26.12.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 12:34:07 -0700 (PDT)
Message-ID: <9510382b-c726-41a9-8997-5779d991395e@broadcom.com>
Date: Mon, 26 Oct 2026 12:34:05 -0700
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
Subject: Re: [PATCH net v2 2/2] net: dsa: b53: restore the NSP IMP port 2 Gbps
 mode
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>
References: <20261022211104.2091128-1-florian.fainelli@broadcom.com>
 <20261022211104.2091128-3-florian.fainelli@broadcom.com>
 <CAOiHx=nXKnzqB+-BvYg7rgxpLq9p2JP2xk8JchK-3+fqzpG7nw@mail.gmail.com>
 <47511aa5-3032-4bd1-bf8d-bcb1a2280367@broadcom.com>
 <bab723f0-742a-429b-a22d-bd086ef35389@lunn.ch>
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
In-Reply-To: <bab723f0-742a-429b-a22d-bd086ef35389@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 12:11, Andrew Lunn wrote:
> On Mon, Oct 26, 2026 at 11:34:36AM -0700, Florian Fainelli wrote:
>> On 10/26/26 11:31, Jonas Gorski wrote:
>>> Hi,
>>>
>>> On Thu, Oct 22, 2026 at 11:11 PM Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
>>>> its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
>>>> so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
>>>> ends of the internal link configured at different speeds.
>>>
>>> Sounds like the devicetrees are wrong. Shouldn't that fixed-link
>>> description be updated to be 2 Gbps then? ;p
>>
>> That's a fair ask, however that would require introducing 2Gbits/sec all
>> over the place, and it's not like we really have a good way to report that
>> even through emulated PHY registers. This would not be a bug fix however,
>> which this patch set is targeting.
> 
> Hi Florian
> 
> As far as i know phylink fixed-link does not care what the speed is,
> and it does not try to emulate it in the PHY. So it probably just
> works. Assuming the DSA driver is using phylink.

Can we agree this is outside of the scope of what is being fixed here?

Without updates to Device Tree binding, swphy, phylink and the drivers 
that do depend upon supporting SPEED_2000, that speed is going to be 
rejected or not acted on at various layers in the stack.
-- 
Florian
