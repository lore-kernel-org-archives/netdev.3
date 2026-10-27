Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141646;
	b=fhYyh/C8ASfW2lojML9plOBpNGHBlHyTEkU1iZCe/aYU7rGfEwdwBndU2cbHYa+JcXJ9
	 ESVhhDnUJGdiFHco2gj5tTD+uu7wgoNKKUnLX8E8fKIKC7fFkGdgnt44Nb1dCt9mPDoRy
	 gWYnvG3xf65Wyj7QJPaQuJ0pFmSzDah0fR2elRW9HvKf3J3d8ikvn8En29JZroDrCe7nG
	 wtMaG51tzudbW9zVLM17tfy2ZtRarSud9JRqjJepM4tk9oLg0XAvnHWH9Qru89gAGgbEC
	 PpBO4nkBYYaYZN+9rUvTJBG9xPSaDzjqCdS6pTPfKVlvRepwi4wXUJOfKB08Ekwb1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141646;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=MJ12W+V1c2kGuzSt6dZzDqWFazbeGqN8f71r7KadZSc=;
	b=wdEHTXe3kiPLGe3SGTRypK166+PGs1wAbhKSTnp8VW08sXMUcoKyM6VnmCrG9uNloCAs
	 CF1eqVsFgNzJeCW+E1JTD3yVJUuGCJpqjKES9UOs7gIu7uzx07t7NIbYjh77hEBuEdINz
	 vDwEJpxvPPpavUqGz/JsYZjCdS84J9WaL40nurb1UDIGYm4KNv8m6EV183awtyhBEBTN1
	 F7ot2x6XacVFf1hRDJv0pyWkCgbuxNAwaDxtez5s5ttcpW0g7syEef02BfPsJLfJtWDVU
	 DZQNWNfXbo0DJkCzBIsiJXoIeZneBsSRtOlzTqXsJSLxG5L3URO/prR4WUkicxx1k9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cV3mgffL;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8C606A329
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B8C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cV3mgffL
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso259236a91.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141645; x=1793746445;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJ12W+V1c2kGuzSt6dZzDqWFazbeGqN8f71r7KadZSc=;
        b=LLe5ZBrVTDMP2e+mGFdCqZJ+onR5muoCR11b/PqexheFwAJAd0V5v/rGVUDv0LG4WW
         mjmnNkCCHcsu1RFI9BOxHtQfvJn6+2Ro65SSeHJ8bFv1KvZ+IlP3FRdZHYdtpQghNMey
         zneQuYOKGnRZ2iVhAsy7g95lv+bhDpwgJVsFV2Dn0lDtthXjHgxufpCnxxDOSFJJDUst
         wDkCajEJ2e3m8THKcRjETcvF1XzZmuvcsRoMbL2cenQIsSlpBXf6ma2NEL9VWXj72GRg
         KEEvfyd21lkHxdhWGoee0rEKOPooQSOKHweO7XiusuHApopqVSqn02GwCtShNO2k03EB
         QBLA==
X-Forwarded-Encrypted: i=1; AKwUvBxcliCFQ2KGOsCzAZS6fuezliZaVnXkC2KXk1VBvIAEXEnHoSKFiWrJlrwCygg3A4JQUAxy9V8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKVdnxKdFUJJG0Z+7ELdYnUeyf6Ir/dIb0EobitOGgmGtMlMpQ
	aSoKUbHwCVP4D6ylBzj2ibLRGzMan5LHZyt7U5zbpTxrkki0/NnMww++eSqVE7bWeH1uVREum8h
	5N9pqlrFIcNb6Mlg2ZYbTwjmGvt+AGr2fFJE/X7L4B2azU62J4uWt42izoIoSHYOWe5lQJ7/K1D
	1wCxjzl0k1GaFE5be8iQAwBVmISD6ZvF9/fIq0N0ylcAUiPoFDiKJtEfZnXgvEhoezt/3EwFmXB
	sZJ/CPSkQNh5c77
X-Gm-Gg: AYBFou2Fh4t+A37Fw435lO+6UZSwHKAt696IQVnAE5ewL+4+E576IH/BTo5v0E/9ls/
	NelQvJf2P8RdZC9yTF0Jt6aA2aNIdKCSwgL3aI0+t5U77vCM6BTFsq54dFN1IgVm5jJcSvof5bi
	diyCjHeti0bxGp8FBCfbSLNgKeo/KSKJ9xcrWf/DUxKGNlC4S/6/pOmMm/Mac0dgTEYmq4f9YhK
	OE73aoK1ft9+QIBa35vymH/dgiK88UQ2dFnkEGs8DRmjDGe5eNqvnZjp+udyZYEiWXUNYrdWT3k
	n8f7Yq5OPoKkXNJEhx2dzZzPcBm0IKA1NwVHlykcPEY8eL/Nkj2BhB5ZM74RNtgf2Rw4SsQ0MEw
	vqSDQJ2D1SehW3dKUR/zuPN78XNPHdpF5V1C61jhweLcY7phPo1JVDB2EyCpnes3198xs5ZxyzN
	qmA8grmMteHi3778ubx8S1lFLmQZZy223YUTFPI3vb
X-Received: by 2002:a17:90b:4a45:b0:3ac:8741:e2e8 with SMTP id 98e67ed59e1d1-3ae57e34ec0mr364452a91.8.1793141645013;
        Tue, 27 Oct 2026 15:54:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae5ac3b58bsm121858a91.7.2026.10.27.15.54.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:54:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so469598eec.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793141643; x=1793746443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ12W+V1c2kGuzSt6dZzDqWFazbeGqN8f71r7KadZSc=;
        b=cV3mgffLHEfp+PLsQbVofDdVNTy0btEAyY0wiLC6XMB0qv6ro2V6HHjwnGbnOdPAgB
         qAzz42PpK1zHbHiZwwQjWTwVLF18exi52JoLtAJFOrZT8ZcSOoEjLn070rW2kJ4D9a1i
         Qmax2dNTiCR0jBi8YoWFMc8lcRwIa5LY4LY4g=
X-Forwarded-Encrypted: i=1; AKwUvBywFHjlaJH2Ko4fRDlEgjCMfuQSC6BbSHbjH1ZhXt25qsw3d3vRBzFcywPdEHY1La32vVCT4bg=@vger.kernel.org
X-Received: by 2002:a05:7022:3803:b0:14c:c947:6afb with SMTP id a92af1059eb24-1a6cd3a17edmr765459c88.15.1793141642895;
        Tue, 27 Oct 2026 15:54:02 -0700 (PDT)
X-Received: by 2002:a05:7022:3803:b0:14c:c947:6afb with SMTP id a92af1059eb24-1a6cd3a17edmr765428c88.15.1793141642227;
        Tue, 27 Oct 2026 15:54:02 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6da729ec9sm1114181c88.20.2026.10.27.15.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:54:01 -0700 (PDT)
Message-ID: <3b1077cc-4694-4cdc-87b8-f3c0c7481fc3@broadcom.com>
Date: Tue, 27 Oct 2026 15:53:59 -0700
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
Subject: Re: [PATCH net v3 0/2] net: bcmgenet: fixes for a failed resume and
 the ring rebuild
To: Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
 <20261026163656.5c1e7a38@kernel.org>
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
In-Reply-To: <20261026163656.5c1e7a38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 16:36, Jakub Kicinski wrote:
> On Thu, 22 Oct 2026 10:54:05 +0200 Nicolai Buchwitz wrote:
>> Florian, Justin: if you have a board where the WoL irq is actually
>> wired, I'd appreciate a run on it too.
> 
> Florian, Justin: could you LMK if you'd like use to wait or apply as is
> and test later?

Give me another day to be able to test this, thanks!
-- 
Florian
