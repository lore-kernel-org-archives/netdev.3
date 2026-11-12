Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522041;
	b=V4vhjA0+HE/z2wXSbMwhYDYaz9OB20qb/TV9S6ZgbyzqD90XxX056cMAsbtwp1VZzwKX
	 v6Xs47dPy+6ulcxh5lpgK2S8+MQ5fTbiKt1Yp+xVHfVRx+WD8hwdO/IfekKCcgaM5u/44
	 s+JkY93yKOKz5nhzK6UmddJOLj/PIZ6VYs6R1+8N/TVripyKGDZySBjQg/GeCWBVrULMy
	 G7LMC55afWBxSRW457EF+xUC7w7mvOvYF1L9+FPlLK3l76VG4v3RLyvAajsSydCvibU5p
	 rD3GWgcoffykKmwIj+U/1bxP4eL46xYD1XHNHoCBHOVaUw9BmiLLYVWcZLqEGqOGwiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522041;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=LoF4OTllmT9/8Bym4KO+EuEoV1VsIKNsPgJWXYwUKoM=;
	b=ktNnEA4yC1tttGlYC0zXW6dQRiFw9ah7WgnNDaN5EoIEoU2ewVprOzLn1r0rrFXhQ2cj
	 TkQcpati4k62LhEROzESJKiFU70/XZ85U+R+yWS+16Hf80YZ/vIOfduNXc+I68Q8GmIRP
	 MwzRKlJAvOIfVrBycK8exyAbqCvVJIELoo3AB0e2Zo+iMdaMaYGuOH9OZlZvhfZVwtqQR
	 Gb18r06mVdpLhnv74jH/wMejIgteY506EI/SffFew47D3E1XFe1OMhnokxgXu/LwSsvxQ
	 oARxTCrLJE4ElNhcC3ySYbzEvJ0QiRjrwbVRuKKXxtBY5vtXiPRUF2u/8HjAt7ejIOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=crLvQoBP;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AF606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=crLvQoBP
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so258658a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522041; x=1795126841;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LoF4OTllmT9/8Bym4KO+EuEoV1VsIKNsPgJWXYwUKoM=;
        b=WtD1J+MgoRxI0ImzuUzSbhKTNpem8fV3UXaQz16RXRY0yNgMkVABcHOxMQ482qN2LA
         NL25ZNszQdv/dU4nUWDqn+loswshHcI7gytme79hRHGvToTWXgyU9Tx8l4yyArketAcp
         bSjtGcD3xE1aiwMgxCwa6EVdi/muCfEmiJNqJ85ohnIzpGdStUWdOYxN9bgrQ+uEKLDl
         hS2+X5g6xJ52fwSJle+sJuYxePM9siuR3jV+tyjTy26rBtrIYqs7UDVK4O6IgrXojbtH
         Cm1WuHdY/3mPCuD9etmXdc2lJ58mLMnoblHVfHjvPSM70bJz4Hdx6AUKRe2Ow8Mw0Ath
         OxJA==
X-Forwarded-Encrypted: i=1; AL+hErF0gcETj6TNiOlJ6sNzIS8A6yfAcnYVazSRkdvjwf6RKtUWLOlSbxu8XMG5pBmKHBNx7UMryTM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tQ0BqiCq4F+NXX0QT8OnD4ssBNMnVTFyoFLldNM65q2siTttC
	kMFLUFQ/Z1NDnUyh8r8Gh0y3baT9VCrS2+NjAGsqMum4d8Qf4otOaySHFd7zdgbpov1AO4vur66
	ErnfR6z7iqk/QuuAQQNg28jiHwRni2k/d0AhMIBUJuxNAU8NKg7e69oRskmkOPIMAhDHAHsQpwd
	O+hu99qH4FYAY4O75aGeavP1BKTFKc2677uRF1HslFANI2GEQ5X0Ur+wXZYtreZ3khXzNuJADWm
	RnOwvF8fucU+tbx
X-Gm-Gg: AYBFou2vbKv9aGm2ownluYM4UhtKtXYjedEjA7B7K1CnthpN1tCb3Ip3oQsEeedwO+C
	cQPIdJXQaV3jLCaYSGrA8Wc4MsqEnNn+pcalvXHWV4l8qpc1bRBKG/nzoqgBrdo5LxeMo2TDJ5z
	BjACgl+0ok/UvF49/ZA97QBzzvHdf0laCLmKacQIBYMH/j6nO1eSc3s1GQw4UcxpzuNa0zqEIof
	vzyMZy+/w7XWm8bpXLWA9CrvlYdOZgqhYCjZTZeDKyZNuCLf0h9Mhh3ca62TqIZXund/AbmOkpb
	/aa8G1xbqtzopIjiHYOn7QLBp7UihCuHj1980CDRRkvkkoPebU295tmX/h4TMwmhI3XzqARjC3O
	MDnDUSme000MgvkzweyB5rP45trrRvwf0XK9DqgV9GaTtx1GH2tcY5KgwyC9lGkljJbhYvdpUWp
	U1XTZiGat2oz9R2s3fJRmjmN+gNkBDKCz3ouk2i6nu
X-Received: by 2002:a17:90b:3dce:b0:3ad:c482:ae9a with SMTP id 98e67ed59e1d1-3b1b081b427mr459143a91.1.1794522040407;
        Thu, 12 Nov 2026 14:20:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197ca0af1sm3699355a91.3.2026.11.12.14.20.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:20:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so915012c88.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794522038; x=1795126838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoF4OTllmT9/8Bym4KO+EuEoV1VsIKNsPgJWXYwUKoM=;
        b=crLvQoBPi2/uq0idbOwwMrf2bsPN8mf10vlkorFq6oSH4w+ceUUXoX+cb//jek1dOs
         QzUpYk/VZSUgbc9axYLYF3eVgI9wwqF9XgQyZ1Gl1NfLXhJdAbFJJk0FiB0F9J9fn9DP
         NfcYVa1Pp7Khqe4rsJ6xn8HL1cP3OXzOgz+Hk=
X-Forwarded-Encrypted: i=1; AL+hErEYgVygkiuvFIkUE6T5f53LZWew2xNDwHhmauZufnZSgwskCjUD5S+F3VN9ztK7YoQ2CcRmE1o=@vger.kernel.org
X-Received: by 2002:a05:7022:1583:b0:195:e4b9:d326 with SMTP id a92af1059eb24-1b503112a76mr766365c88.12.1794522037578;
        Thu, 12 Nov 2026 14:20:37 -0800 (PST)
X-Received: by 2002:a05:7022:1583:b0:195:e4b9:d326 with SMTP id a92af1059eb24-1b503112a76mr766340c88.12.1794522036859;
        Thu, 12 Nov 2026 14:20:36 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm1959526c88.8.2026.11.12.14.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:20:36 -0800 (PST)
Message-ID: <361df07a-d231-43da-91ca-8c507797bb1f@broadcom.com>
Date: Thu, 12 Nov 2026 14:20:34 -0800
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
Subject: Re: [PATCH net v2 5/6] net: bcm4908_enet: unmap RX buffers on stop
 with their mapped size
To: Kordian Chmielewski <kudzo51@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261112195051.597102-1-kudzo51@gmail.com>
 <20261112195051.597102-6-kudzo51@gmail.com>
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
In-Reply-To: <20261112195051.597102-6-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/12/26 11:50, Kordian Chmielewski wrote:
> Since the switch to build_skb() the RX buffers are mapped with
> ENET_RX_BUF_DMA_SIZE and slot->len is no longer set for them, but
> bcm4908_enet_dma_uninit() still unmaps them with slot->len. Use the
> size they were mapped with.
> 
> Found by reading the code.
> 
> Fixes: 3a1cc23a75ab ("net: broadcom: bcm4908_enet: use build_skb()")
> Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
