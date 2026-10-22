Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792706811;
	b=uxCXrH+QPBLHLBFN7OQLP4/ACenHctLuHdMLaaZ2nAbJvAm21j6j5cdbE18QktJ/xhFw
	 NDc1G0OlGFPcw+EDKJVxmk77drCFK6InTDqrgKTmgbb1iisNakmvXOq2l/bccBsNEFECe
	 h1zIqM2AyQvKILEM+++MG7/BqLPIWtl3deavgbPAPB6KNTnwxe8kZuRcGm6b5Qb/AaqFH
	 j1NdqhIUCGnioKQlaLV4CJ6keSe2/X/XFzjK1dDzyey8hemIloZ39okHdqSIup51EmZ3m
	 2ZenZN2u89bVefec5ferpiUZ2O2GVagQNZE9Vlbdgg/+bwK61Kpr4cEvoPiiWS6A8AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792706811;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=Iia+/3SGKV6BH0FuXkiJp6KPLJIcRH5RkOpfzGcqdio=;
	b=hAcYRwWx49XQYQLL3jOKcgCl8pA8hgiMWoN6DQnUXKtD0MWGzKgBjRWu0pNcLOf/oHA8
	 pLUarIXeYF1ALe5zGNGiofDjR9MslhgfGfIqUU+WNzMwoi63Z4pUVOprSnQTqEVj3T5Vw
	 F1HJZ5kEoG7KaWGuibsS2evh94Oj4pq2lI4rXiqnpizCUdOAEa5FCypndkZGvBEfHhwut
	 tP84B1e+Pke0/cgC3jrzVS6whuUc8nfXUOXzjbHAGm45Iik4NVnXAj/+ndgJWvyLJOcPi
	 zB41ph/4k9HOK8au10s1o03Bm2oKe4IeqCjHHsegayfXo9iVfvdNw6CgD3kqb0fIHHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g9KJ9C2+;
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D146606A320
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D146606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g9KJ9C2+
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so170405a91.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792706811; x=1793311611;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Iia+/3SGKV6BH0FuXkiJp6KPLJIcRH5RkOpfzGcqdio=;
        b=XwGKdp26gWyUT9NqhrOynq8znEhJF2JOkMlPgYFp+9QH5FJE+EoY3qcd4PEpKWOIC3
         f+YUwGqjJqeI1ncDf8UU4gB6iRk5YQ2Za9w5NX6koX4NQSmTvk3R9SL/ddi7GKN2lQev
         /HqlKy7Doxkp1zhFuZk1WnrF5ZnVy3rtPRHkeWuLdQQJjmTNwHn4Yv9uoMyznMiOOTtV
         KHsIIIn6v8gNc8Lt+bew44hNkTpfpJ6C7Gc+AQ3mtYSEicQCDmzkbFdixXSj6fteUVDJ
         FGfoAoZEDS0DJQsPa3057kHD9b7JW9AsgmEiiJRCTgC0idHDnkVzVFzbGHssOX/gJ5Ay
         CO/w==
X-Forwarded-Encrypted: i=1; AKwUvBxehk/1tzqIqzin7PHq2U4mwEk1wIchUjij98ZN1hpAZMJtPyNsQJI72icspc+BcUYUSXg8Ouw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJb/v6qvsbBW990q0DBnl7GsFQnu4qB6mQ0eKoMbLYxntfpDZnE
	ZDt10j2gDCakvETUVsh13Um9CcjUzEL3gFZWwdqA9AVrDVwV22Eceo977N+W/fK4ABmZItLyz/C
	eRC/wC45on+/QYZq3yn/jSzSG3PknrY7CyfPvJwCZxQrhMkQKgMRojBi397QwYDOq5gQgypJpLe
	f8hM0RTTF64TM8RfAzXZRlD08jc6EnBpB67CkGsintMJMUasBqdkYDczcq/heOupKiEJmNSF9i0
	U6tNv1h96Jyvkfs
X-Gm-Gg: AYBFou0313a9IiBUKamI75Bh7W0FyKuNz0cMKllT5rzTMHLqlG6JmDTlX02mThAXZ1s
	0MX0YMCYk9tH2rCAu6zKlWzW7AdNatEu9S5DkxsAwx1LnYnlpghPbJnzZRoGA588gRcnZgZYJAI
	gGT//qbllSFNIM63eYd1lfPfLP4Ux4WwvMIrYTmGD2dIclp0BIt36DV80ujtgr/YO5vSEXGzXoJ
	SfnKQzoS5Z4vGbS6BNLNO4tkJk+N8jP3e2nfegCThx3YnRgcK8rcq367SwMu/9EmZNUP6N1Fb3Q
	G1XbCcgr54gzHK05JH1j8foQbdRpt59tX7XsjzhRTgl51ipL9ASWaaBfPisnALA/Fa3KqFSTz0D
	H2Wx6rlBwhI87pdaozKmrgalHKTY+FGrb1aCees0DfearMvvjW9L16Lru+GmMAWqK+1pWoyeplU
	tkmFPFsutM450tauDjtpSGVmBjLvnjqCg91dh84wWz
X-Received: by 2002:a17:90b:268a:b0:3ab:f38:2b3b with SMTP id 98e67ed59e1d1-3adce5e9355mr142230a91.21.1792706810603;
        Thu, 22 Oct 2026 15:06:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adca634dbasm353271a91.2.2026.10.22.15.06.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:06:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5363fa3d3e4so4578671cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792706808; x=1793311608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iia+/3SGKV6BH0FuXkiJp6KPLJIcRH5RkOpfzGcqdio=;
        b=g9KJ9C2+soB4zORwsKBW92UABfqqADgY2mxC7pYTqnmc11G0gxpiUgEytzqF55tmEA
         D7fKw9o+f0iSoesU61pxWCQPtPa3hIesuw+WDIoBdg1nZU+MRENxAggABnCiJz0mTX9s
         6IegmS3kejn76oID82AtoYa6Tc4QTR2AasmBk=
X-Forwarded-Encrypted: i=1; AKwUvByMT3JNtDRMmSPpp7i1D2cUMK7wQ/J+HZZtmifraypAFDO9BygvNAKJQ2el+gMQGlCwJex//Is=@vger.kernel.org
X-Received: by 2002:a05:622a:5c10:b0:516:ed02:c85d with SMTP id d75a77b69052e-536c2694d64mr4475521cf.3.1792706808570;
        Thu, 22 Oct 2026 15:06:48 -0700 (PDT)
X-Received: by 2002:a05:622a:5c10:b0:516:ed02:c85d with SMTP id d75a77b69052e-536c2694d64mr4475031cf.3.1792706808133;
        Thu, 22 Oct 2026 15:06:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c1835c23sm3113161cf.17.2026.10.22.15.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:06:47 -0700 (PDT)
Message-ID: <8b061dc1-73a9-4823-abb9-535eb4677b13@broadcom.com>
Date: Thu, 22 Oct 2026 15:06:45 -0700
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
Subject: Re: [PATCH net] net: bgmac: rate limit RX error messages
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261018231629.39734-1-rosenp@gmail.com>
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
In-Reply-To: <20261018231629.39734-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/18/26 16:16, Rosen Penev wrote:
> When the RX ring is full the RX FIFO overflows. With RX overflow
> continue enabled, the DMA engine then writes one frame with a bogus
> length (always 0x45c2 on a BCM4716), which the driver drops with
> "Found oversized packet at slot %d, DMA issue!".
> 
> Under sustained overload this happens on every NAPI poll. On an Asus
> RT-N16 a 950 Mbit/s UDP stream to the router printed about 1450 such
> lines in 20 seconds. The messages are printed from NAPI context, so
> with a serial console the router spends most of its time printing.
> 
> The frames are already accounted in rx_length_errors and rx_errors.
> Rate limit both RX error messages. With this change the same flood
> printed 60 lines while rx_length_errors counted 14297 dropped frames.
> 
> Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/ethernet/broadcom/bgmac.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 1835266fdd09..b3a92ae95de3 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -447,16 +447,18 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
>   
>   			/* Check for poison and drop or pass the packet */
>   			if (len == 0xdead && flags == 0xbeef) {
> -				netdev_err(bgmac->net_dev, "Found poisoned packet at slot %d, DMA issue!\n",
> -					   ring->start);
> +				if (net_ratelimit())
> +					netdev_err(bgmac->net_dev, "Found poisoned packet at slot %d, DMA issue!\n",
> +						   ring->start);
>   				put_page(virt_to_head_page(buf));
>   				bgmac->net_dev->stats.rx_errors++;
>   				break;
>   			}
>   
>   			if (len > BGMAC_RX_ALLOC_SIZE) {
> -				netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
> -					   ring->start);
> +				if (net_ratelimit())
> +					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
> +						   ring->start);

No objection, but the issue is that we are going over 
BGMAC_RX_ALLOC_SIZE, and I believe the check should actually be 
BGMAC_RX_MAX_FRAME_SIZE because we have the skb_shared_info at the end 
of the packet, if we start overflowing that, we will call 
skb_over_panic() very soon.
-- 
Florian
