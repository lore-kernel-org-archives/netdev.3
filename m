Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208351;
	b=NR+ZTnM5zPraEvY9zbTNS8ivS/q9kpMnTULfPlzmIe0wx4FGyb4HSR47CryoFwnAL+hc
	 qIO2vtXUSh3UhD0NNfA7hbjNuSBgwvNyHXr7T+So6JeAncqGZpThpXFq09jw6D9UCTyDb
	 Mb+o+75K1AUs1llivh4bP6oGZftkaAz0qG1tSpsP+JUngG5qLrjJ7E6qgDsNRe8lukNId
	 dPNWkdgU2pTMcpR+56lPv4UwzL7Zw72sGpuBcCzydTdit9vxSdqg4xN5fpXL/zVdNtPml
	 X0j/VcmyWB67QDbTNG5XvGw2DPgifrgQuU+TXVpXNFLHFOiuYyTJDpmMqyJu1CmJICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208351;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=96REoSpqeOFESJkk5pNQFSDJAOzVBOi/GV9/PTsQSbc=;
	b=dmiZUxESjboS0FXyWqCSrFPQbeOX2rIXJWmmFs4EBjq0RFjpTBqR7kmLsvPCaGGjJJof
	 3Q+kdUnJV0pk23zykyzv9xMR270CQyZzyYz2krhHvTexmx09S3dnJEOvtleE8z1WPZnur
	 BihYbxfZTr7JcHcgP4vqwI4baeF0ThyylI2VIPva9COC4snBhSKKU/sSPawiKE8B1Pmwb
	 DqLXsjX2gx2msPSKu0bsqHbiPOCi5ZD44xeyDNcDTCJosPyx4RNrg0Xjb2ylg+/mfHZc+
	 ZXT3Ej7kCL3g0QGD4OKWhtM43xlSXH5NrSqBn5BwGCpoDWVBe9LS3kdGRM2fK9pM/2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BEqxhsK5;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD9606A325
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 17:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68FD9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=BEqxhsK5
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so562807a91.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208351; x=1793813151;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=96REoSpqeOFESJkk5pNQFSDJAOzVBOi/GV9/PTsQSbc=;
        b=oRBuD/MKIeUwcLA4T1VkJgQC0TGnHvDaUCkYpJGWkU2h3xfIpNLDaWQvAsJEtHVtLo
         U1lAXOEs0ZUY+2YpCYrIUUuEBWJqwPlZUqLDplQ6d45MF03SNtPFrR8IU0VW1mdLwxas
         osKDU1BqEEAL2shlFa3t3Cp4/pFn2Iry85QrWYB/hkdnN8vDiTeOV2kcV5eNik2IL+8v
         3wzK2U1IW1mVmo1p03Lt9jGFVxCeSOhc3/PrBG68sm00pYaoUznT2t905EGf2jrc+/xl
         TF/8sI/rngNeJ6MBlhY2CJcdVQu94lWkFOKFzKmI1CFY4GgUI9ikmjRLZjLf3VFCl6IK
         YTGA==
X-Forwarded-Encrypted: i=1; AKwUvBzXQtUcVTQyQyzQlJFfHZy/FAX4ElhNGc3vb+Jzs6DEVbKtvlciJ+tnluEsRurmrjB1EtUJ/dI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJW32jDDGAdHR0ps/t1b/wOk21oCRkc7zekOdTjJ3cw55YMhRBi
	GnIbx6/jKE7MTX1NdYdgQ1rLcaplK9zG3QPQZwTSwh/7g98BX78r8+9CJXYyAtoUyexh1f/fYGE
	vIp6ccqSHh3yA0RdUA2F5ujN02gaszB1y0bkHrbnS262j8tzg9vP83fIj7qTtZZbmKJRiWjhhrJ
	/FKP0vstaiJhUqYrLeYnPN5NA4vPCH9T9Spa8aBeU3LhO+qmREV8TEcCzBck5pRR8Ei53muRYj+
	cJMiAogjRlf9rpA
X-Gm-Gg: AYBFou16A82I9TCXBapH708dfxnN748LdXCqkeiDPI2ADjZcPe5BZMPQeztq7RW5BzV
	BWEgbNlXvO7WdxWD6hwaCgti59L6Jb7GuOUT0TyhZMDKTvM2+BY7kBGUBUie1AwXik6bF55F8hv
	wWgdYGa0T/DGwgLlvN4EdoLnnE6D6WOMa3RfQbzu5iAwVGLnKjXueIUWdKgRyo3a6IE1Kgv2m2f
	rPGk2qvJAQsRSMdIthUTuw0e4sV68OsHvm69XDMtix/hHAoKASN9qUvSM1evn5SYodyImn9QzRb
	1bXX+JJ/TSBCyakEJaLfgc9wUPL3AUHdYUZI/v68iudM1Vg9ZUAjGjRq1XTMAYmT9mGn5oE7xMl
	3Zxtf6WosMwx8GTB2kW5B6/unn2gdQ7FLNI4u2YvtUUpvG5RYnJ16VBdA8CSxGNtfu2rA+P3rKW
	w2UiTnvm9HjHIUyPIALYZ1cXNv4sLBdNFhnIThfXmA
X-Received: by 2002:a17:90b:2891:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ae58249fe0mr2199964a91.41.1793208350639;
        Wed, 28 Oct 2026 10:25:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae57b98875sm999939a91.4.2026.10.28.10.25.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:25:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91c861b562eso13740446d6.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793208349; x=1793813149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96REoSpqeOFESJkk5pNQFSDJAOzVBOi/GV9/PTsQSbc=;
        b=BEqxhsK59jMeZ/P+vbogXmNyK1TQYJ+V6OPYr4knROJEUV/HUo+dCwUbfPFtke0PMb
         NTlHEpsAKTULD6ZGvNrkaGP7xPgCqggrsbRb5Kor6R0gkRNIbEi+RwrdgwFVYwqgwzsa
         Ce1EZQpGNyszstAkAZw5/TiAvlXgVn/1w23/w=
X-Forwarded-Encrypted: i=1; AKwUvBy6ElDmBnD8jcMvoy5TOFDN9X8cNT8x81qHiOjL+EpCZIG0Zq/Rzb2ZOmxFISFQ124Kmyz6IEY=@vger.kernel.org
X-Received: by 2002:ad4:5cad:0:b0:91c:7c57:728d with SMTP id 6a1803df08f44-91c7d1c01c7mr50546446d6.37.1793208348832;
        Wed, 28 Oct 2026 10:25:48 -0700 (PDT)
X-Received: by 2002:ad4:5cad:0:b0:91c:7c57:728d with SMTP id 6a1803df08f44-91c7d1c01c7mr50546116d6.37.1793208348296;
        Wed, 28 Oct 2026 10:25:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c69e721eesm71446646d6.11.2026.10.28.10.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:25:47 -0700 (PDT)
Message-ID: <2f230d17-88ab-4456-89fc-b567c9147d6d@broadcom.com>
Date: Wed, 28 Oct 2026 10:25:45 -0700
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
Subject: Re: [PATCH net v3 2/2] net: bcmgenet: restore the Tx coalescing
 setting when the rings are rebuilt
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022-nb-genet-fini-dma-net-v3-0-6e9fc89c0156@tipi-net.de>
 <20261022-nb-genet-fini-dma-net-v3-2-6e9fc89c0156@tipi-net.de>
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
In-Reply-To: <20261022-nb-genet-fini-dma-net-v3-2-6e9fc89c0156@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/22/26 01:54, Nicolai Buchwitz wrote:
> bcmgenet_set_coalesce() writes tx_max_coalesced_frames straight into
> DMA_MBUF_DONE_THRESH and keeps no copy of it, while
> bcmgenet_init_tx_ring() programs a fixed 1. An ifdown and ifup or a resume
> then puts the Tx coalescing back to one frame per interrupt.
> 
> Rx keeps its value per ring and reapplies it on init. Do the same for Tx.
> 
> Fixes: 2f9130709d2c ("net: bcmgenet: Implement TX coalescing control knobs")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

