Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039693;
	b=hrCkktP5LE7DNGtqzqua6fhUfXLTFgIakmK83AcdTAffPr9J3n7dKsQ8yuV+aRmOpYJ/
	 4ocQN2cgH9WCoF2QOw9dr3boiIXRwu/kUMIvSMBNKf0cnTl0mOCu/54S3hAQn1ARxFt4d
	 eJ/ca6ctXeReS76C5qccbGrdHAmqIJoxcWzVT6tNPIJ73yk/ADU2x8VIZfL6JWZSceu/1
	 ZjF1j4j5gMwnAVfvUl+ECmF30OzDaPfeI8a6lPdICH9FFhTx/LNCud1nhw5sYlnYnT4RS
	 atj7S/+EGjHTkolwiWUACcUc2ygyDfyPJQl4Pj4mspVBzXqhY7+czx5vsbAgyUkyqXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039693;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=dRw8LpiQcAPkVI8lNgkCIMe+p5IntnocuWacHPuFlko=;
	b=pGrrJk/bfrqU9pdirIrfNZV6w5rwktjUeRbE4t1TIVyQDu9AevaBk/Evv5NYPlG6FInM
	 TfbwvgZClmGgm+qwaL4a3ftWemJjzEb9polODvG3djDhqtEVSDcVdkvqT0BvIXldZrqsh
	 ySDNQVDA1tMF81R3a6p1oUoqRXvCApLsRSJ6+zbAQ50Rz+7Sjhcc4Q14WJEgA3FVXBfvW
	 94+kYzYTmkzjXupck/PaGR7i3c3xoOahNkiaIgo7nLxRGWkcWJID0FgWC5GxiZi5KQkiR
	 qtKN88W2jk5UAU/xqeSj6Z42iKZxkUPlL+uDCezVhsZtovG3fFKmrTcKFM6Bo4odL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hXLQSWTD;
	arc=none smtp.remote-ip=209.85.160.98
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036C606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 18:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7036C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hXLQSWTD
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-49e5f85ce89so1394707fac.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039692; x=1793644492;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dRw8LpiQcAPkVI8lNgkCIMe+p5IntnocuWacHPuFlko=;
        b=HCNfQyJb4mitb2o4EhGqP1t3sO4pg7jyAF+9//aRxSeRQGi15M9XeAKFYzIVSm1UoS
         7YJkZj94mXRP3sDTOLpf23EKZWQDGxncoIZVhsYCr71g/M7vNiv9Bo/UP/f2TodOrpik
         3EJzJzicbjdSDZWdzF9wgY1qlEeMfUI1lyZfz+gIr1ZD1OsN9C0dmKskDHj9HTXkmWFk
         LNPLnP9arRjCmAEBzuJ/AH+KURZVfgZ3Bu9yrMgF75E3+Lif/H6X29oTT2Zfgvi4AMm5
         kxjTV7NKaAm5vO49ngTJmBBOgWkRXzF3/3Fbnrz/UN4xEQCZZxqcsY/xkn56JjTQsCwB
         yXSg==
X-Gm-Message-State: AFq9FYJwn85JzB7ZbSH9/j4YP+OI2yJlCE3gYaKdGmC5dXDGP5bPHu9P
	82VIPy3eQGM9ooUNeHrVqVLhKGEMpiF7QYzTevogklcpF5i/hGocb1uUvX4s+Xdlb+2yP37m0zE
	JYFmgM8rxsPmdxrISREWhD0coEYxVeuG1lX4xMc6rqryjoGB7ujKuKjHfnYDC7eWDYy3gRMhWsY
	6zCYI24pUGGYbh+OSOT8uPjMKlPm063j2VPCyFD/FpqGvGGF52gJmdceXRTrofIYO3AZ0c3WuB9
	WDhnn7sM5El5YVpI30=
X-Gm-Gg: AYBFou0cdknK2qSZBxQH3beZfabpnxTZR0mrpyWdpjBBZ7kAQXpJOeLRrSkrQ8/Yzf1
	RzKShdkJiO5oyWlpeK5wcBzguPre70WR3EW5XKTycos7OlyVuqvSttJcN6wyJAmWzIpVqh1Kult
	0xcTdStfmhsnTi9WRjclmY4F1pn3y5dD/IFToUc25rh9UyX05/BrTpxiwkHabMniSWX8QKMbasw
	Bj40cGM7ocrelUllx4mdvjKdwyMpuFS4A8peRse82TWDIqCNgBHw9ADlmcdTDMYep9u1oSffsip
	+ZIGnyLwYZIeGN37qjTOQuFDPEqxq8r6kuSsF1IGKbMaJacTPDwjS4OP/SKKoPacjjGDGkVhWVT
	ENAwqKdW4OdPEGs3nJ8bbl6ZjWTLg+SMGc3R3vcx8p+06s474KZHeTbIHiDl4Q4lqbciA1Fn6B5
	0Xeif1TSdbZkT+0yhIh17jZtfYYWZNhjtntLZkeJ37
X-Received: by 2002:a05:6870:8919:b0:485:d31b:775b with SMTP id 586e51a60fabf-4a83f55e601mr4613962fac.25.1793039692285;
        Mon, 26 Oct 2026 11:34:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4a8428f5570sm57372fac.0.2026.10.26.11.34.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:34:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad840053c7so3280817a91.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793039690; x=1793644490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dRw8LpiQcAPkVI8lNgkCIMe+p5IntnocuWacHPuFlko=;
        b=hXLQSWTD7Jr0K1XovDHxrzPul/M6iOov+3jez6TkK3Jc8grFRY0yze2xhMsSyfdcMR
         Bntw7SMq0GSs6zw0b8ATS1021BVL1CduXuBCK8Kx9TmANGqIwMRJ5O1yvb8WcAgnBZdc
         LAUqmxgdDBDXRZHNj5SXSXTxPksuyoeV1Q4ds=
X-Received: by 2002:a17:90a:ec8e:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3adeb0fb5fbmr5796917a91.41.1793039689893;
        Mon, 26 Oct 2026 11:34:49 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8e:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3adeb0fb5fbmr5796899a91.41.1793039689475;
        Mon, 26 Oct 2026 11:34:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40427782sm516108a91.4.2026.10.26.11.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 11:34:42 -0700 (PDT)
Message-ID: <47511aa5-3032-4bd1-bf8d-bcb1a2280367@broadcom.com>
Date: Mon, 26 Oct 2026 11:34:36 -0700
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
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
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
In-Reply-To: <CAOiHx=nXKnzqB+-BvYg7rgxpLq9p2JP2xk8JchK-3+fqzpG7nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 11:31, Jonas Gorski wrote:
> Hi,
> 
> On Thu, Oct 22, 2026 at 11:11 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> The Northstar Plus IMP port uses the switch's proprietary 2 Gbps mode for
>> its internal link to the AMAC.  Its fixed-link description reports 1 Gbps,
>> so applying that speed clears PORT_OVERRIDE_SPEED_2000M and leaves the two
>> ends of the internal link configured at different speeds.
> 
> Sounds like the devicetrees are wrong. Shouldn't that fixed-link
> description be updated to be 2 Gbps then? ;p

That's a fair ask, however that would require introducing 2Gbits/sec all 
over the place, and it's not like we really have a good way to report 
that even through emulated PHY registers. This would not be a bug fix 
however, which this patch set is targeting.

> 
>> Force the 2 Gbps mode and flow control for BCM5301x and NSP CPU ports.  The
>> mismatch caused switch output queue discards on both copper and SerDes
>> ports, with one discard for every TCP retransmission.  With both ends
>> restored to their high-speed modes, iperf3 reports no retransmissions.
>>
>> Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/net/dsa/b53/b53_common.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 0880310c9ce3..1f4964c28fc5 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -1663,9 +1663,13 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
>>          }
>>
>>          if (mode == MLO_AN_FIXED) {
>> -               /* Force flow control on BCM5301x's CPU port */
>> -               if (is5301x(dev) && dsa_is_cpu_port(ds, port))
>> -                       tx_pause = rx_pause = true;
>> +               /* Force flow control on BCM5301x and NSP CPU ports */
> 
> The comment is now outdated, and is missing the forced 2G mode.

Ack.
-- 
Florian
