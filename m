Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206700;
	b=y5OmGgjZhROkJf/XAXdm7Lda87FueK4bErFi80MvzW0NC9dmuxak66cGUA9Yf3zBI9Dy
	 wUBQOCiSx0HSe1EVRu15eDL+JMdY/oun3H1Uiup9l+AbZWI+ofZ2yR+XOXjDFhvajdwxB
	 aP3E1CH68nuv43mOhW9GuiySyPKN4jbfmtI2ZdkyIno8FkT5Qk624kYOv7rn4emyS3s4i
	 8BuKkk3EcG3IWR+M/2qysf7eXdIQnBz2bqALd2PW3Rc/hRtgs8LIg2YrV0PKyZW1fCtv7
	 qHK5JiBhClwkX3V9VBFemwQwdYiuZwlulNgB+e8QsL4En9jr2/U3nO7ED9vzfGG1jYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206700;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=/fQIsnXR3qpPiAPZg7Jk/FIpBsbfkQ7V9JvvLYl+Aqw=;
	b=wsHP+u1E3IdwXGJwb26T38V3WJIjyHCVNrVF1+EeYwAMAKWXEpUZuHmUbKHXNcFLV/yb
	 38WuEk+u+A66cnsubHb27js1QfAfRmAbqy8PJc8FYe6eDyF4l+e6RY2qrH0Ezk7MGuJaA
	 tYWVZhIvRALQi3VchStxz2VouiR+M03I1u/EeXIxNRMGixVo4Ucp2gZGitMTyfBs8NpTu
	 JCgkVirFyAPTrwMLX+oj9nZGZCNbUsOb24KWxF0ipvoR+JWJ+55uzqnNtM+R3p9hHosDW
	 ArL1OXIvsJqJE7niZV/xhT1sdCPg3zTfBqLiGOtBLo8ClGkU6ArrWJuCUQ5uv/3QvHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MUdiEcIO;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24947606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24947606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MUdiEcIO
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso271540a91.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206698; x=1793811498;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/fQIsnXR3qpPiAPZg7Jk/FIpBsbfkQ7V9JvvLYl+Aqw=;
        b=glEmZM9M23jrdFYhxc4wTL7huEcAXm00DLen6d7w0f2j6ZtQ/FwAK8GdqP8G6PGabR
         0BfMO15tREQDbOz9/wWG/P9H5kqN/kO/dZvRmuuJYIVZl5tXyB29f8kBIuiilld6/Zyl
         CyAOazccZoqe+018J4JBxF8AG30yt+ZhNdIF2NXEmvIVsodvpdRNzZyNknYJKgHQW6Kd
         JWwK2Gob2linASKts/HdRPUhm0Hb02YUeP3ZHX8iWbn0Xjp4Si2p400f89V9BAuRJCIg
         6bKZxANe5d3xnOhz6Blc9GPb5k7mw2wMLMBHzZZawqyDgMtHOZa0YAp/YWvIZ7qA5xuI
         PIPg==
X-Gm-Message-State: AFq9FYJmt1V8MyC4HMWsUAALGjYrO74CIIiVKib9Ufk8JAcQfy0NENhB
	iQWDOIgZuFqDJJY6Ce6zG2Bo8UUZHWz7cA+ml5ExzlCn4ohb0bYbJXrT1Zmi5kvKpMPTTofmHhv
	QvrjO5RCvJjvUVpv39dN2Vk6pXMFJZOOKbKC+m0lFOW9jswUQh07ooTf2UkYHs7kczesmHvhxOJ
	LH52COi16AHXoKm11OjinqZYLJiAvM+wqnutK6H2KKMotaOu65yiSqaULQeK2Mvp8trs8oDsApj
	bUxT2ZUVG5Efmq8
X-Gm-Gg: AYBFou2wKgeg0FP4Qq/3vKNAxJ1vdH38lFP9y6bgJ0QwIF8aCPd7qLKinjYOTZOG9Us
	xCxDngrYyDr/DIDqPjmqTpfQyaOnWpiLKoqn2N3TF2r8RPNxISLXJyspIGmD9rmjdmEyhJb0YA8
	TlowPhGE05n7B71JEMFax3YyEuFamhc4taCaVKLK7zNK5PzPQNHUXIiOqLfrbnaNKBxuGvPdc0h
	NSRCMjTQ/yXT+FDaLw7lTgaLEuEBCF7S3FO3X7HHke/3gC3PoYrVZYp0UU+I76ckPluAExBES9p
	cxujHNU3D16tGZDE4ts/aj2poAw1eKpyYdxEpRZ+M15DPEe+YXmucoz2IupNYzcFjh/pV5/vZ4a
	hPCENh7HojI7frPcG9KWfPA5puqPZWTi6hEjYBhR552/QSLIAV04neN5GDgqGHhOYcZ/bFF8HGb
	MZJPBqH3jThEY691eQyET3QgbsysnItuiEtH7hmLGw06s=
X-Received: by 2002:a17:90a:d60c:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3ae6ed455damr49229a91.23.1793206698414;
        Wed, 28 Oct 2026 09:58:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e84adc9sm118606a91.5.2026.10.28.09.58.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:58:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844cb60so241041985a.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793206696; x=1793811496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/fQIsnXR3qpPiAPZg7Jk/FIpBsbfkQ7V9JvvLYl+Aqw=;
        b=MUdiEcIOvKQz0F+pTXiifrXrWAT2jiTavUa3R5hAo6uq0v6ZfR0uw78TRh8spXQ3sw
         F5OKLu+0ja4uZzgDWQyHt5G+DsHhZGIKfeFBYnNyQUZmDZYOrAbjsSK8f185nAxthWg9
         QPc0eJNswSnvv0fArK90IvKXlNs4QoiUIh8FM=
X-Received: by 2002:a05:620a:3185:b0:943:e872:f521 with SMTP id af79cd13be357-94413358c99mr22449785a.9.1793206696088;
        Wed, 28 Oct 2026 09:58:16 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:943:e872:f521 with SMTP id af79cd13be357-94413358c99mr22447085a.9.1793206695624;
        Wed, 28 Oct 2026 09:58:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067c2e2sm1300362085a.18.2026.10.28.09.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:58:14 -0700 (PDT)
Message-ID: <839ca732-c2a5-451b-bc9b-58afaaa01121@broadcom.com>
Date: Wed, 28 Oct 2026 09:58:12 -0700
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
Subject: Re: [PATCH net 3/5] net: dsa: b53: clear stale state when creating an
 ARL entry
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 open list <linux-kernel@vger.kernel.org>
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
 <20261027202230.3539646-4-florian.fainelli@broadcom.com>
 <CAOiHx=kFqW3AgzQ3_zJBxkdXcokg8j3-Ry1meV6h-RKb5mcTgA@mail.gmail.com>
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
In-Reply-To: <CAOiHx=kFqW3AgzQ3_zJBxkdXcokg8j3-Ry1meV6h-RKb5mcTgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/28/26 02:52, Jonas Gorski wrote:
> On Tue, Oct 27, 2026 at 9:22 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> When an ARL lookup does not find the requested MAC and VID, b53_arl_read()
>> returns the first free bin index but leaves the entry populated with the
>> last bin examined. The multicast add path then ORs the requested port into
>> that unrelated entry's forwarding bitmap, potentially forwarding packets
>> to ports which are not members of the multicast group.
>>
>> Clear the entry before creating a new one. Also return without writing
>> anything when deleting an entry which is not present, instead of making
>> a new entry from stale bin contents.
>>
>> Fixes: 5d65b64a3d97 ("net: dsa: b53: Add support for MDB")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/net/dsa/b53/b53_common.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
>> index 559d4b360c82..0871a10d8cbc 100644
>> --- a/drivers/net/dsa/b53/b53_common.c
>> +++ b/drivers/net/dsa/b53/b53_common.c
>> @@ -1992,6 +1992,10 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
>>                          addr, vid);
>>                  return is_valid ? ret : 0;
>>          case -ENOENT:
>> +               if (!is_valid)
>> +                       return 0;
> 
> Should we return 0, or should we pass on the -ENOENT? We failed to
> remove the entry, so implies there was a desync between hardware state
> and software state.
> 
> If we don't, we should at least report the issue. If we do, we don't
> need to, as dsa will do that. Though we then should also report
> -ENOSPC && !is_valid as -ENOENT.
> 
> Likewise when trying to add an entry that already exists.

Agreed, returning -ENOENT seems preferable so the missing hardware entry 
is visible to the caller. I'll propagate it for the -ENOENT case and 
translate -ENOSPC to -ENOENT when deleting.

For additions, finding an existing MAC/VID is not necessarily a 
desynchronization: an FDB add may move an entry or make a dynamically 
learned entry static, and an MDB add may extend the port bitmap. So I 
think we should retain the existing update behavior rather than return 
-EEXIST on a lookup match.

> 
>> +
>> +               memset(&ent, 0, sizeof(ent));
> 
> Just bikeshedding, but semantically it feels the memset should be
> below the comment/dev_dbg().

Yes, I took that change.

Thanks!
-- 
Florian
