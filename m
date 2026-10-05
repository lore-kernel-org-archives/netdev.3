Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A00391E6D
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241518; cv=none; b=Le0gHcfva5DZ2olW/CbObKMvdIkvdExpnq2SFJUx1hKcFP++dVn2eYDWecMNWhbM15tinFQdZ+sPwzPfInSpitVm7yxVORuyL5cb5WEpV46mYL7VKqFvlN9RXW3N2ckqIa4MyiJZwEDUxmSg8OOAKOFGrdZKB+t/jd5FWEpaXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241518; c=relaxed/simple;
	bh=/pBUVYjz+dhlHjNGfMXZJzY6we/DMekTnDKv6B0HtEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBFyYN9TK/RLSWesuLC414kv/pHtSFUNGVoBBJScX9Lpl1Eg1ooZLf6B1n9S52WOzBQwgDrYx9aNABVD8HqyUXyyNf0cXxEB4EYMBr0FN3R9y4iI9E21eYf1HUwsen+Dq35zsNJJ+UYa51Y9PtONS623bxIaoe0xwGcKmYOop4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B4c42AFW; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B4c42AFW"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a706146559so468355a91.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791241516; x=1791846316;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iW6L5TqJ9/IRRgok0g4xFXuyQiaTucPylThbHh/H7ZE=;
        b=JqqQzmIU9Xtzw0PMuI93jZ1ZtU0MFQD05w7qtP3OJE12/gx3lLvTnaRFaNkVs02Mh0
         LlsRkbPcO8z81miVUAbtHnuv0Xs0OBKGqYGo9NDQ6L5SLSfDkrCb+uZZyPuXgiDjqEHk
         SqGsDtN1e9hVJvH/+t8x2zPkMNGAOnlPXqhhDCaUvDYU/ZrWDM+WEo/rL/Ym6Q7Di0eX
         LbM1BSx4613uFKDLHKV13azQSaJy4aon7B5TfwXOrsNxDh2l6+mv9faPZgTv32ZHEjH/
         /lelB+2D4v0RBZ1e62eVMOYGNSuCcYeeJFk2+ft9x55AcFt6YsDS/hG2CHrFuLmoCfuh
         QJzA==
X-Gm-Message-State: AFq9FYIVOt0qQyokqkpXfEPnf0kjqaYN4ne4RF1+RGIrjWvXGQuckjnN
	jitFdVGfmydzIhOT99772mcuLEBZvP/hOOiqfq1cmJwblCrp828c15rfygBCwGs2LqXKrTdZuJd
	YZ7itNLglpHXWGWVJfVaEe/MVi6oGAiLnl+uhUksVnkRyY92zRe43ENTn4EiLmLPv2jRSkCF5K+
	Xx+KpaacBrCx3nbFQ4WHdV1KEV55GCk0buRQFTC5wIKcHjzY1Qah9mQPrpXaLdyWhc1bNGBOU5X
	8/yOwvAEKlI/X8c
X-Gm-Gg: AYBFou0qiDWJ8Fzt6vwkFyAJYSh7ArX9uAGJp+jv87gDXbX7cormGLjdpQ1zbuEm1k7
	0G+cGW83qu0EF3nFCx0Zev73kG4Av1BZsH0OnuF7mpnlthllDknNxsZvfIXFcbzSAYO78PT3sun
	NAkzrvlSUPq7OppN1DgpxShAxAjCgbWfjC5Xn6myJpIqEofdwJc7G5bDnW3+FbnLy3HXSlmONSM
	TNX7kKQIZ2M2ZtxLyFnhRclVgX2mJ/yWvDl5Ks31hqjGnIJUP37A+PvJsXiEL3lL+3PQxzCbNZ9
	9za2lej2WZsQXyQr0KydlrkNWZKqMtF/++25pdfxd25eUMKN3C0iTTs0uZCGLeFtfjcUB9ShutH
	9dUNM4wtSktgPfBoMfOgGOvplm3ulaCYmsqBghExhqGIndowLBxNhdFbEX7AwArB0L9yOOxDqK3
	AMObP7Z6gQgUO5I3pSnPkzgt+e2cY8Q+0cl4c9gMjhcro=
X-Received: by 2002:a17:90b:4c52:b0:3a0:5413:49b4 with SMTP id 98e67ed59e1d1-3a6ce7fba39mr10234783a91.39.1791241515513;
        Mon, 05 Oct 2026 16:05:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a853e5dc1csm458929a91.3.2026.10.05.16.05.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 16:05:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338f659170so34482881cf.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791241513; x=1791846313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iW6L5TqJ9/IRRgok0g4xFXuyQiaTucPylThbHh/H7ZE=;
        b=B4c42AFWZs8W0gT9wNOEZoG2RdYtG21maUouS74dLN0dWB/vP+ZuX70G1Qf2BdaXu+
         jff+Yi213ry7Ssmg9tmRvQSbp0lHpakPLoTTAFKGiNBSyyzvB0O8fu0cY5F2QwJrI61A
         y0Et/aYr47G+9xmPb1WmM5LwWgmEeqg0QH6Hw=
X-Received: by 2002:a05:622a:1314:b0:535:181a:ce08 with SMTP id d75a77b69052e-535181ad143mr136766861cf.42.1791241513143;
        Mon, 05 Oct 2026 16:05:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1314:b0:535:181a:ce08 with SMTP id d75a77b69052e-535181ad143mr136766151cf.42.1791241512649;
        Mon, 05 Oct 2026 16:05:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5353d78c3d6sm11404021cf.2.2026.10.05.16.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 16:05:12 -0700 (PDT)
Message-ID: <d340d589-78fd-48ad-bee5-ff88cfbb8b3f@broadcom.com>
Date: Mon, 5 Oct 2026 16:05:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: bcmgenet: allow a continuation
 descriptor without the alignment pad
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
References: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
 <20261006-nb-genet-mtu-nn-v2-v2-2-c4be21151912@tipi-net.de>
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
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-2-c4be21151912@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/5/26 15:24, Nicolai Buchwitz wrote:
> A frame longer than the packet ready threshold arrives in several
> descriptors, each with its own status block. Only the first one also
> carries the two alignment bytes. The length check assumes the pad is always
> there, so a continuation holding a single byte looks a byte too short and
> the whole frame is dropped.
> 
> Account for the pad on the first descriptor only.
> 
> The MTU cannot produce a frame past the threshold yet, so nothing hits this
> today. It is preparation for the larger MTU.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
