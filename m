Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206770;
	b=MwxxScXPtBnlSkYlK4oVYAaHSRXBfiBN8CUpsSzT+ukgVT/yAXACyMTkZK6+XjyKPyvf
	 9cmb1lOZYQfSXDrLtw7YBhJKXD5ipENg/DrQvI0txXVYc69+jQk7qmVfjtOEKdYQrvLR3
	 dNcTHM8dFYrFa159Sxr3ngos+XJ5ihW0Ispuhy9iA21vdPwmxnPEx3v0tHLREyqd/A5op
	 FtKEGcDrtrQVy0uWJAAb2dMnBb85OUTgd+x/jOpvhDxacwlKZcigK6EmKRQU3lMne7abw
	 3WeGCJcmqliqSatHbqwQ9R2h4FbFQMHok7YONlZuKP/8WGxfKCUAVOBYgKeiA37dBLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206770;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=lGonB01guIIGKoLNrv9eYTfZoqRD0V/CPM1UeDgx6uQ=;
	b=lAyHgNhVtpVpLNrNJvEVIkPNEpZ0bVoYh1tOAyYJkY8GLpBKn5oE7dc69s6ez/Vpb1Xo
	 dY7BuJIoibANbdgD3J6i7xlu0LJm08Bwl2LNNFxS6YVdSb5vHaWE2/QG/7WV63BZx505P
	 WK/ZE3rg2ox/yL02T7CN0F3qWvWN+OviOMGTacVhVbVlNP0dM9zLJ7UKK2oosY4jvUcG6
	 C+IvFAChsk828B216qwVgAP80f6MVHL2YBqfRfDIPkal6xDacZ2ixJw0PIfVyIo5Nzsn3
	 r4mrlFQJgl10XMfht6t436RR+wEVrXSGUw9K+5EsOFts/STINa34zLcH5cRI/L4fWnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="aUhAI/LD";
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47F606A31C
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D47F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aUhAI/LD
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so603249a91.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206769; x=1793811569;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lGonB01guIIGKoLNrv9eYTfZoqRD0V/CPM1UeDgx6uQ=;
        b=rlMhbSWtZUriMEUzfQUM2pFjKCJoC7YrN/YCw5yZny9q2Yt9ijgJU9UptpGjtjMc7D
         E04mVp4Dnvcr51I647D/gufdAKR0IDU6KHLrFtVn452O6r8Zu0Auz3GyInda47RdqrRJ
         y0gyMXQRJH6UJMg+1P/kE7pdYOGX0B/zBTeW/SPVVM81Pv5sV4F6Dwn/Is8p99/wWZsi
         00WrJtBI0+iL1BMA5gPtTdOeJ45FcdJZgoeYUbvvtCE4aghmbQpIwop4bV+VdzbxVLVi
         27n9dKUK3ZlAZfT194AFDaCqSpXdOd3aZ8GLyZwQuH1aSSx8kIC3ERR4ZjhhHw7vKqT0
         7tMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxR0pusiRJ3gAVe/FOjUb9+/J31kC3j1NxbcyvSeyJURfAfKvo3W/1QzVLlMEfm0WgfN+MzFCk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfuChkwdbPZzQ35N/rUO7ji9HFDTuTjErpztLSRc746rLJAnd0
	FFGYuWaqhPg0JHDdF9Qz41iilb3kxFp5gEawuqdxsAynLTh9ngH0zoVw+Z0fkl2y3HaU/8Njs2j
	LmQK4i2a4DSV7gTwuwCYf23lNNTmOXPAVzsPNzhWRBhK+uDoPPVtntxuzJy48G7Le6S7MUXGCy6
	tZYzX0rgqnlDElwz2k7ESB3c7mxtVetnrzwbknCzEa5zw0oNqTQ8PC3fc7R1mrrhX+KJRB1qJC2
	INh6BtCLSrK2HKT
X-Gm-Gg: AYBFou2W6edVztxmnMm3YD/zl3IGaQm9wjGe0mmgaD8S/MEWBtCR7DcI3JrinjUWQjo
	L2Tm9Ak1zFeebNhzdUhLZBcjzld65LZ76r65VQ9lNZzbbaW565ZlBv6HmYzDN7DZeNO6WlSEEp9
	wPP2N/4m7zX93c4ufbu23+c8UWlinWRJe9pMFUB4SLDX5PIwodOsmE365nArtCaY3D9+VN67qmk
	nom7BEU1lOUBm/M2jSSyiNtuzpUMXAb9TgMJXp4nl/jZeJ/iK+iMiZ7DiUvHd7QhpNjgbt8RcbZ
	Hffs62bOl1hlCJupf1Ysyuwo1qpBRI8foMvRzvMPBWmAeK4LV9T4i8xFBbxJtHCB/TWCJ503eI0
	VNb81ZCVvG2KdXQeFifgz4sWyIK6CyH2YkiaxbzapkkkjgFGXN1CijerceEU7PewLmRvJOezFe5
	+kalDxN1iS3hIVqu8S1xMkw2loD29Hwh4B5yvQGF4X
X-Received: by 2002:a17:90b:17c2:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3ae581bbdcbmr2020086a91.51.1793206769286;
        Wed, 28 Oct 2026 09:59:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e8b50f9sm128334a91.8.2026.10.28.09.59.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:59:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f5844e383so176200585a.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793206768; x=1793811568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGonB01guIIGKoLNrv9eYTfZoqRD0V/CPM1UeDgx6uQ=;
        b=aUhAI/LDeW+p9k0OFCoax1q7g2cpAyqHf1wdzeeQg+k/WDAnoU+zCLDMp/G9pIH13d
         fWQKO/8ABzBF6/QHPmD5NqrflrOXlQ6itDALYnVip5R1u/Lq0dVdw8waCbw3Z8V1EN7P
         6/ZtjorWo2ekKDIWqYEfB4nsD7FxUTwvD3Gb0=
X-Forwarded-Encrypted: i=1; AKwUvByvuSboEb2lYZB1S4FhpygS0BlX3gJgqLiLUA6BFihj+pIONla67q8nZ+tHYz4kRqS4VXEvnps=@vger.kernel.org
X-Received: by 2002:a05:620a:8015:b0:93f:34b0:4880 with SMTP id af79cd13be357-94408a26c0emr438956285a.22.1793206768104;
        Wed, 28 Oct 2026 09:59:28 -0700 (PDT)
X-Received: by 2002:a05:620a:8015:b0:93f:34b0:4880 with SMTP id af79cd13be357-94408a26c0emr438952085a.22.1793206767618;
        Wed, 28 Oct 2026 09:59:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787fe4sm1324046985a.27.2026.10.28.09.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 09:59:26 -0700 (PDT)
Message-ID: <5a1fab74-38a8-41f6-b577-21a501961624@broadcom.com>
Date: Wed, 28 Oct 2026 09:59:24 -0700
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
Subject: Re: [PATCH v4] net: bgmac: fix TX DMA unmapping and slot cleanup
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@openwrt.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261028164839.28605-1-rosenp@gmail.com>
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
In-Reply-To: <20261028164839.28605-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/28/26 09:48, Rosen Penev wrote:
> When mapping a fragment fails, bgmac_dma_tx_add() unwinds with the
> wrong slots. It passes the failed fragment's slot->dma_addr, which
> holds the mapping error, to dma_unmap_single() for the head. The
> fragment loop indexes from ring->end instead of ring->end + 1, so it
> unmaps the head a second time as a page and leaves the last mapped
> fragment mapped. None of the affected slots get their dma_addr cleared
> either, which includes the head slot when mapping the head fails.
> 
> bgmac_dma_tx_ring_free() unmaps every slot with a non-zero dma_addr,
> so tearing down the ring unmaps these addresses again. It also frees
> the skbs of pending TX slots but leaves slot->skb and slot->dma_addr
> set. The slots survive a down/up cycle, and bgmac_dma_tx_add() only
> sets slot->skb on the last slot of a packet. If a slot with a stale
> pointer is later used for the head or a fragment of a scatter/gather
> packet, bgmac_dma_tx_free() frees the old skb a second time when that
> slot completes.
> 
> bgmac_dma_tx_ring_free() also picks dma_unmap_single() or
> dma_unmap_page() by looking at slot->skb, which is set on the last slot
> of a packet, while the head was mapped with dma_map_single() and the
> fragments with skb_frag_dma_map().
> 
> In the error path, unmap the head and each mapped fragment from their
> own slots, and clear dma_addr on every slot the failed packet touched.
> In bgmac_dma_tx_ring_free(), choose the unmap function by the SOF flag
> of the descriptor like bgmac_dma_tx_free() does, unmap every slot
> before freeing any skb, since a packet can wrap around the end of the
> ring with its skb on the last slot, and clear both fields.
> 
> This was found through code inspection by an LLM while hitting other
> bugs on an Asus RT-N16. It did not hit these ones specifically.
> 
> Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

This version looks good to me, thanks!
-- 
Florian
