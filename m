Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491E53B5E2
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918653; cv=none; b=pTVEi1W/UcpE23o+62cSMurjuI4kBcFjGWZ+LUzKQkKxhYi/xUwnoclpqgLi6nClU8ML6xjZWedIad2EOkPWQTJbejnLGMwJ1TZpqDFyVHfSYpqzInvLFDODzVVMl0cogk3XNoI/wQt/pLiuFGzoWkDOHo+7MDPUMrcNh+V/DRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918653; c=relaxed/simple;
	bh=sDsQT3AfqEqfRugBX4i89fJbXFP4E7+SwYASmhwyxdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccC6ihOE2IwYO/6TWeve4EbptK//AuBW1Let835nH8BMOkJPqUm9g4Xv8LiPqR3VMTeUFJbp5o7aZLRuux/7QaWi1muicH91y7GbGyBOoe+BKXOzszvGJ337KDVYzI6Rec0M0jtlm7oih8RKsWNBegwgUWXIQERVF7w6i3FLE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HF8xcNGL; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HF8xcNGL"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-533797e72e8so20121351cf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918651; x=1792523451;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=thEMyit2NIdqmp4Lhe+g/SnccxQ1rxgSd2hCwR0/uOo=;
        b=xOqJ+4ecTPUbfh+ghsN5IBj4SlKTlGmHOh/axSyDF5jGq5kY3S7M3Mb6SB+E5lEzNw
         QIZV90zcjcQ/Gmvtdv4ZHri2bk1RkJBcOWUkMEOvcwlzHojfsN6KBzUis9o8ZaQ46oH4
         1qDBkL+ellM1ft4HnNEMe+q6JoNU1GrCp+MSxRjKLrlL4xBb11cn7jkLcKZcMrBmwCOf
         nttPDbAa9ixo4s8efto0DMAg+Mu9Fm6ehrvXly7U2aCqQH/SkcUEDTFmwgzfxrMEit78
         nLnfWLScz/hWWTZxphOU+c8E4/YhMBLjGMSGqYaoWmPuW9rHHAraimkVflolthPX5Pc+
         un/w==
X-Gm-Message-State: AFq9FYJ8bnHHMGVGjbQgv54EK22BGyyGmUmqMLB1O4qA7nWNJuyH8+yZ
	HKnvPRsXlgq6f5ugwN4Vk/8fXBa1H1S9Ha0Ea9xeQ0pOxJ0cyTUIUhPFfGjorLuz2IpTC7B1fZ+
	KNdEOoBttPmudC9yGQ2IZ4pLd0l2+SBesvn9BMR7Jn98XpjKtZEyNGP2jsLtEkvX7rZ8EICw0eW
	qhBZbuFfiFoNUigfybt2RzaOBLbZWDn2cple9k8armfKgDMm/KcrBp/DgH84qDCNPj6qdlmvUo0
	eWnicL9XXERqMck
X-Gm-Gg: AYBFou3XvySFzbdlH3rafON92K1dUNWSUqy8OQvP8HK0cbn59aioVhzxWLdlmffn15y
	gOpMKrXWuVIovWiPfV1dhqOKgal8fNq20W/HFNpUe/UkjP+6tSTUDeItP6Q3rllSD+9WquCPlRA
	FoAJ5Sxd+qsdzIA0iNJne3qVrWE6lk3eNDDuR3yeNM6tp5zDTWd740sxhkM54mUlIqUAaMHv7hG
	hnwi6cAl3JfcN6tEfh5RkU1WiaL0lJTY6XugSxSYKB3gBe0kPH6Iz9vDX1FRQKqujvV5g9MVgq2
	b1omzTJ2Z6bgTJmqhCiKwrE7p7g86cw/pZ3cDnU+zCtH//ce48iIkS5GjUNnvH+aT/dcZobxzN6
	xoqVT+dn1evjuDRcpgwr+yuREhjXL0HLVNmavnHh3tfWkXC0hpUBrsQDuBG3TOKkZfd8mKGTPLF
	wsztW4P0BMyQ+lb6OHwvHBwQTSgtLGxgcl5xWK/i0mb9E=
X-Received: by 2002:a05:622a:e4d8:10b0:535:a5fa:ee0b with SMTP id d75a77b69052e-535a5faf22amr142119521cf.75.1791918650879;
        Tue, 13 Oct 2026 12:10:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5359b74551esm740841cf.14.2026.10.13.12.10.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:10:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f75c1219so3053135ad.3
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791918648; x=1792523448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thEMyit2NIdqmp4Lhe+g/SnccxQ1rxgSd2hCwR0/uOo=;
        b=HF8xcNGLDaQI5tnUfgb+lnFDtsO2AzGBWuvXmifwvw0+diJiqM3I0+XxfMYRKOa0Ds
         sT66KZ2yAYvshmAKMP2DAgAMPvq49IF2Kmu7YM3mk+sWzujP2xa4jsMvcQmNBWyBQThx
         D6oMfSOkyQ97imLwV69VVhpTsw514xGdiAX3A=
X-Received: by 2002:a17:903:1905:b0:2df:968d:f5bb with SMTP id d9443c01a7336-2e842822392mr117854985ad.5.1791918648483;
        Tue, 13 Oct 2026 12:10:48 -0700 (PDT)
X-Received: by 2002:a17:903:1905:b0:2df:968d:f5bb with SMTP id d9443c01a7336-2e842822392mr117854625ad.5.1791918647925;
        Tue, 13 Oct 2026 12:10:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8202sm58226155ad.51.2026.10.13.12.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 12:10:47 -0700 (PDT)
Message-ID: <1996265a-a5ad-4455-81b6-81afeaaf0f46@broadcom.com>
Date: Tue, 13 Oct 2026 12:10:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/6] net: bcmasp: Collection of fixes
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 09:56, Florian Fainelli wrote:
> This patch series is a collection of bug fixes accumulated during a LLM
> coding session. Thanks to Justin for the internal review and helping
> with the last patch.

Looks like lore.kernel.org did not receive all of the patches again. 
Let's try a different relay and resend those.
-- 
Florian
