Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522089;
	b=ppb4xog2ruy3ACVXja47o6Sx2pmxFcBOobGWRhXhy3T2ANMibe30JfA9uga9xpPpR0zj
	 nZ2Dq42XJUavhAdosKG0FgRGKaXa8CBULG2tju3LLZ4g06oS/DhSZkS4b0y8MYYTkSv6Z
	 VIkX6OXKG6MBnwLZd05f3XRzCE7Ju6vcr1wNx3gXiXsW+X8cu3m+dOAa3EwByb4+8Ih06
	 LfTteNxQ5yIc8Q+frukuDpt8YqucBy4/NrnNM8fqUnDpkbEmbL7lQGfkfTOM/V76J/iLK
	 6PqSNApiXxJ0MmcyuNeEoG1Kt2cxf0MWUUr84V100/cM6HUPvBV9BA06DMmPLde4MAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522089;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ryOGIzWANYk795wucbwRaaM2psKG1cATfQ6kt+6oYVQ=;
	b=k9FUvhVMomfJTrO02EfUWGLtAFozf+Uxi1HyJ3FjXVPJ160QlysR7kPG2S1U3AEEzoK+
	 LnBVThP1niVwX5CCvwmFCOCPBBBjq2A5XfR1FJ09VRv1wq+LvWJPYOsnoS+vZivtM/Sxp
	 DeIQRumGbedWQ40Tr2Zuowj9YAFR3qaB7+AY64V6jFVdXV8K4jLGtfgxmyl/ZD1Uf9558
	 i69ogEulJm4XjfO/xafaSppNaD9OCII81HGwadRxtkuyiHwn0V7WIQJiQqnscfMF39r2D
	 swEGf10KLrXAX6k2ejcOGCI3nDkyrX+/jYqyUOsudSyDEnzLmIY6+NUazjlamwt3Ckg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Xbez+FtK;
	arc=none smtp.remote-ip=209.85.214.228
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B03606A884
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2B03606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Xbez+FtK
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2ede7cb02daso10749605ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522088; x=1795126888;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ryOGIzWANYk795wucbwRaaM2psKG1cATfQ6kt+6oYVQ=;
        b=jL45+fKtcAkHY2woMksDp2y0BcqfQUMIAHmLNYE8O0bSRTcNoff21QqGDyygvpnbKU
         czrdgyspz8Zw/Mv3+Xzk69LvcZfyi5LHyI9UnM3hlfoVY0Uswbqx8N9v4T7KiItWsmg2
         ByDmUZ0DQoAq7oUAP2XcunTiqCLTKTWlYDQkY5PJjfHACoXuTkGB9xYclQucKfLB5zSx
         VvvcQmwVzZ6Gz6GEgFm40c+Fqc79vp1yuQRwX4ZTqD/g/R7Iyq2ITKQILxcIQ6ta9fnk
         om1fOl/qZErr2CFsrCNioqKjSuHN7GON9n8v5BqSQLUDA6FaxuA5dQMAvJfhcmjkYx08
         9LjA==
X-Forwarded-Encrypted: i=1; AL+hErHduPwX8fPVREW6fJu1QLpHcCY8CoV3ohVq5Yb4Wq44/VmgltpvDppMLOQxM1zo3ymV66IEy/A=@vger.kernel.org
X-Gm-Message-State: APuU4Z88lMht0UxZhRMdsOwur7TZNMcg1KfbIuIV/sjCjdJ6YbvqM5d5
	SK/GRESj2sbjK8GDfInNGL4zYhdFaVLZ5RXSfY7zO5Yta1GzFRKUB6LskPmo3B1xf1fu5N3TiZQ
	oadGe+HD2zSQGXlUe/zie768RggR4AIYoDtVpBZJFG7dPbbF6tQn68AbGRHhFpAlhe3YBbFaamP
	LmtISS03HOsfS3jEC+BGroSRqxO29j12aKOasGpSQsLyN8sn+WQRqPgWdvRstmqh7M0D53vlTI4
	ACYuDkKLqjZu9qB
X-Gm-Gg: AYBFou1qGzSyo7F1r8QKhqiXQauz7E3R6iTgM75+DHLcoub7Lds5Cvpv17HadWR+Sp7
	RwGPl6MZHYn/eSjOdvq9unk1Vpp/tK3kPJ84actqgs3MvkMXONCYco0BsrIYBf81reGRZLVs3Z4
	sQ1YKE9rhzUsQCVt8kefr1beJLHaWESudIAWX9dEkkslvBkgo+h4Zs9anxanBPIdoTtEPnWgzZn
	xwS24ugPr1sb4gF5gnOm85SzZeNx5qq80pIzd24aIDRu64FRE45mT1kV6M/hiCwfL7U5EOkiqfr
	YPu6zPYYj0XPL08Ch5/YXy1bnZncXwl1GsiUb/Eo6oy9SZakoHMzYjP9ndv97zN4vT9tpK3lVsl
	mKXAE1D0BVeUPTPNiVSPRHMfHaY72bnkwSWn3/x4dsoDbwDcm6kPjUfQlcjaQGOzyFeH2EkF574
	7ap8JYOJINRM+JXIzk0Tq4fIdNh6qC2h84G9nsw6X1
X-Received: by 2002:a17:90a:e7c1:b0:3b0:9409:6969 with SMTP id 98e67ed59e1d1-3b1b0b94eaemr228211a91.19.1794522087886;
        Thu, 12 Nov 2026 14:21:27 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b25dd0e1sm198827a91.2.2026.11.12.14.21.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:21:27 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a065d0e9deso204490b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794522086; x=1795126886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryOGIzWANYk795wucbwRaaM2psKG1cATfQ6kt+6oYVQ=;
        b=Xbez+FtKbFsQUfi9+XwqBxNfdXjUj4/Sv3i6aThTVP3JaumR2yE7SqUYYxNCbLU/Yq
         Znu3874ct7moOlcXwY2lafxJFQImVme2EIOwV8tdI3D44xetlvOajEI7Vkojp+rwFF4D
         Bbsn+of6oI1IsMs209zTAlS8gIbWpr0U+N9uo=
X-Forwarded-Encrypted: i=1; AL+hErEIcoit46Mgxl9utkp2vpTQUdxUlJmuUQxmTrG3BlasHsU2PZKmQHH2NxsxPDsOkSqAeEUGOjQ=@vger.kernel.org
X-Received: by 2002:a05:6a00:4b52:b0:878:3704:e0f6 with SMTP id d2e1a72fcca58-8beb7a2536emr537598b3a.28.1794522085879;
        Thu, 12 Nov 2026 14:21:25 -0800 (PST)
X-Received: by 2002:a05:6a00:4b52:b0:878:3704:e0f6 with SMTP id d2e1a72fcca58-8beb7a2536emr537584b3a.28.1794522085400;
        Thu, 12 Nov 2026 14:21:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1d6207fsm187440b3a.32.2026.11.12.14.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:21:23 -0800 (PST)
Message-ID: <742a9b5e-0ef9-4ec7-9073-ba3b4689aa65@broadcom.com>
Date: Thu, 12 Nov 2026 14:21:22 -0800
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
Subject: Re: [PATCH net v2 2/6] net: bcm4908_enet: drop a TX frame whose DMA
 mapping failed
To: Kordian Chmielewski <kudzo51@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261112195051.597102-1-kudzo51@gmail.com>
 <20261112195051.597102-3-kudzo51@gmail.com>
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
In-Reply-To: <20261112195051.597102-3-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/12/26 11:50, Kordian Chmielewski wrote:
> When dma_map_single() fails, start_xmit() returns NETDEV_TX_BUSY with
> the queue still running, after it has already stored the skb in the
> slot. Documentation/networking/driver.rst treats NETDEV_TX_BUSY under
> normal circumstances as a hard error, and a driver that returns it must
> not keep any reference to the skb. Here the stack requeues the frame
> and retries it while the slot still points at it. Drop the frame
> instead: free the skb, count it as dropped and return NETDEV_TX_OK.
> Map the buffer before the slot is touched.
> 
> Found by reading the code.
> 
> Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
> Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
