Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522032;
	b=vMV/PfTGFFQrAsybrZOw8RzXQhHtUYr5fhyZwJWMUlAsaga7lvg/cWdShXQvIaF9sVsq
	 Gp1Sjw/byzZogamdRqASVbj+pw8zr81baWzBjJ87nxQgerueBUiIx1MMeQ5F+MMca06hx
	 yWesqSjcPrtmuyr44uetCuCnGGnFO6Bu+YPtXJn81Qt55WCcgURFpN0zdfYg/4lgVWlvK
	 oC4ioPewdeLcxRD3yciAVNZIWS2vE5qZ9Inn3D0qFZs5xgYkNE3n4LnBJaqLqv69kLQQd
	 KsXsq3NpF1J9mkwnwjkx8bKLO8x0fD//joQGRM9Qc9FmkBdrBBHyROF2BlTYWHng7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522032;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=dMIN/jsvm9zebNFrjUksdeFOedRMnbi0KaBFP9e8FN4=;
	b=4miJhx0zQ2a2VmL6acD227OuBds6b2iotKAXJIO31av2Qtj4i5uKUZkhLfTqP5pChoaB
	 EzhBKgAPy/7kq/xNdq3pCU/PgOvt6AYUMlC5EUnM6IhtjKkWT50+8m4ahF1ZNVS8eNCtu
	 2XmfwBZqW/kReXr6IomCjte1GyQ2l1Yqyo8wVObPbzfMFN4owPkSE5qKlsTG+SHV8PyGX
	 H2/6WJGeg8CzAWuV1xy4zMhkxoJzcMisSw4Nm1HHC7fti4I0PzYQnLwnSH2xy2vHRluyy
	 N0+C2+wauODK1FmfZ8A83rd1jv5l/k1Le6yAvx+5j9oWXcEZvqEL1it7SjlrvYh2wgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DbqCBSQX;
	arc=none smtp.remote-ip=74.125.82.228
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAD606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DAD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DbqCBSQX
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-37600b0db49so1252026eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522031; x=1795126831;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dMIN/jsvm9zebNFrjUksdeFOedRMnbi0KaBFP9e8FN4=;
        b=ClzhzybVFCe/KGb1Qm+vf3DFhqwx2oGrQefhOJ8IX/xVx81ZXJkbyf1HO3N9ue19kh
         dfAEQ3ggikpYatEBpuTBt5l034Fpref8Zub+BiTvMicFOAtwra10wFINOyIL9fJduFfR
         g95/m99kM7yUbDGjG+3GztxKpCkH8QHm1uALdjsbu7+5nD2Ir5CpyHNVoYDKxMPlI3bL
         uSu2KaRhdHiDaJJDzoX6hVFm7sSGbVXsAc2SbNEHNOWPFFFy2lXhhvKO1dO2VlDE+r36
         n4HiX60oMUIYrfKVUWSt8S7nFOyZ09tQkwzT/U3VNGjSH7US8aY3avAz5HEU/8A8R0T8
         htMg==
X-Forwarded-Encrypted: i=1; AL+hErFikq1XDT5keMsM0SV1i21NymTF5SooJcARJy+Lba2NOQIYNata9urvC/c21hfaV6vdp8Wg1ag=@vger.kernel.org
X-Gm-Message-State: APuU4Z9An068ftZcHtayF5BSmny0v9cViNKlHONGYr5FQy+Bs4fyzn9T
	EFkw/0ld7Oqgzz5lT83dabSL1nOZIoNqkdTaYvRDLFk3sxKchSmgRhlw6RRu1fXQ/vj2+pbb4b6
	pE6dcHWlB4t0WqeTlbM2XW79NmndEQuNtkt3rHQPabRIpg2ymBEtsKP/5nH325www7XO1XZ1kMw
	QaRUBmByLBla4StPEDCPxADX+52z0RH8iHt2+sfgDg/r4JVqArBfBgg2CbHJmwUe4Ii+yW0QB/x
	k32OYkjc0m6i3Yp
X-Gm-Gg: AYBFou1ekdW8U9WX2kLgPZLSA7NXsZRX6uD0WE+WxVm/LQInIRCZqdnGK5kdJG4f0DI
	GvmX3DM0h6CbG/243V7ZiN9iPPfQ89/sKNfQbceILBlTmfafn1M0fP+Y8Aackr968xLL5947Uyx
	66AGbHA49SEmkq6GCTxn4qF8TayO1ea5q00j2hsdlaAkmZ84dIRIiosankI4qZQaVuV0Ms8ahkv
	RQ0RkfCMuxJ1K5/pa5ehFAra3xovNKr3oBMviu5pqjvpTi2GM4BhOs4omU630VjJG2fh4w7l2D7
	Pdl4mP8cBTNXdBQBXH8W1EgiQNqOKM2H6OiWTAEza55vD20VatrZRTG4Tc/AEE8rGbTWsY/+JPV
	pl+RgLVoWG7RoGipYJ2cMfG5atmCPnpNAImpGWqpfgi/JPLWAUT4zDKpiukGEXOqmRDlaF7e3v4
	iQHB1XngsPUwxpmhCQLbNabEdjI6tT/yNASOL7qNGj
X-Received: by 2002:a05:7022:eb47:20b0:184:ae11:51c8 with SMTP id a92af1059eb24-1b4f5f7fe1cmr3307368c88.23.1794522030540;
        Thu, 12 Nov 2026 14:20:30 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-37959abaee5sm38962eec.14.2026.11.12.14.20.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:20:30 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3724667bc16so168371eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794522028; x=1795126828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMIN/jsvm9zebNFrjUksdeFOedRMnbi0KaBFP9e8FN4=;
        b=DbqCBSQXZCrintuXQM5LV9lIFkPqmGjC5imc2e4RCeNXUZjEpQt0TJmL1UGzYVMG77
         Kw8oeskuttxb5A8RLrbw20tdNmY9HKD+hhydakD+WuGb4qvTvjk1Am/oSDDkP9y1TBOi
         B0bCtaM8InHef9E++jd4G/SB4tliC+bo1xeso=
X-Forwarded-Encrypted: i=1; AL+hErEcH06d3hlD5hNh8cMogZ9I+C97cNChXTwaucvxb2gODoB9YA0+WwUUg+Q6rVDGkWvF8fkq/Bg=@vger.kernel.org
X-Received: by 2002:a05:693c:87c2:10b0:36c:a3ae:936e with SMTP id 5a478bee46e88-377e093dc83mr3368463eec.5.1794522028412;
        Thu, 12 Nov 2026 14:20:28 -0800 (PST)
X-Received: by 2002:a05:693c:87c2:10b0:36c:a3ae:936e with SMTP id 5a478bee46e88-377e093dc83mr3368430eec.5.1794522027690;
        Thu, 12 Nov 2026 14:20:27 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795591f4f8sm1232743eec.13.2026.11.12.14.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:20:27 -0800 (PST)
Message-ID: <05d38633-4f68-4e1d-9e08-0c5c532da5ed@broadcom.com>
Date: Thu, 12 Nov 2026 14:20:25 -0800
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
Subject: Re: [PATCH net v2 6/6] net: bcm4908_enet: publish the buffer address
 before OWN
To: Kordian Chmielewski <kudzo51@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261112195051.597102-1-kudzo51@gmail.com>
 <20261112195051.597102-7-kudzo51@gmail.com>
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
In-Reply-To: <20261112195051.597102-7-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/12/26 11:50, Kordian Chmielewski wrote:
> bcm4908_enet_dma_alloc_rx_buf() hands a descriptor to the DMA by
> writing its control word, with DMA_CTL_STATUS_OWN, first and the new
> buffer address second. If the DMA read the descriptor between the two
> stores, it would write the next frame into the old buffer, which
> poll_rx() is turning into an skb. start_xmit() writes the address
> first, but nothing orders the two stores, and the descriptors live in
> coherent memory, where arm64 may make them visible in either order.
> 
> Write the address first on both paths and order it before the control
> word with dma_wmb(). In poll_rx(), read what the DMA wrote only after
> seeing OWN clear (dma_rmb()), as Documentation/memory-barriers.txt
> describes for descriptors shared with a device.
> 
> Found by reading the code; I have no test that shows the DMA reading a
> descriptor while it is being refilled.
> 
> Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
> Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
