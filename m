Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522282;
	b=whEL1ENfEPjBz/0pkfk5Nw8l2+FxGtjTflmPv1NOLh2Uv2ZjDGhovhk5iifiXrLKlnfp
	 saSQMFu2UeOj2h3p0gvlFWXVafNvpFgoT1jsK7cnT24suQGGXS+FElu4r4SduVZ5Qu4l4
	 u37nwVJnZfth5IiSedbdD5FmSlVziiDY9ohvks599RES8c5OsAHLz/IXciTcRXTvq84qE
	 l02TZ5w4VhiXoHtIvpEVGwU37C4fITC+KVHmN2C6g7vysal8WXIRdT5iikrnan+p6Bnqb
	 GwWzACZqsp71V84+TEWK99Q+AgWBhg++2+JCSnZ9xIXITK9etUPYdcCxMHE05aGW6XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522282;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=utoyl4Gvk+4k3dUQXqMIzJHQem3Qyf7xqEv4qj4AspE=;
	b=NgD04E8Xhrn0nvV2N+CM2YMHmq7W7am08D4FB+vsISgRsnErXqCXPJRJemcy7eS9DtSG
	 NW0I8JObdMI2qgyMc9KokQPpbzI46VeGwkgpt1V1daZHT/JgOMpZWxeefAX1l4sXDvGks
	 gQbejCMx6QmKdEjLAb8hKbD3qSI5vS2WZLG1UKSyKcqpqA00S/ZhTt7oC04wI32wIJPZu
	 h3UPQZTLweJh9ympBNdjOAwxiXYnOMCsx8g/qJY80FRmhycb0Rxw2Bcp/2RIxw84MHcxD
	 zMujqU+ogBn5L92kgX4t8yeeZoTtssqwh/VAdWnWqmS7vBbgCylr4xxQ52JzY/Y0QBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="cu9JQO/v";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43779606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43779606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cu9JQO/v
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so292079a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522281; x=1795127081;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=utoyl4Gvk+4k3dUQXqMIzJHQem3Qyf7xqEv4qj4AspE=;
        b=kpfFxk+cWDNLiOfhi50K3fd7UAUjwQ5NgmgX5C/MPzfKSJu3hnQfi8dTmR0gHrXxJJ
         f4+NsBCgypFJDnGP9gjWp/h7cECkkxM4kcDsHr1HnU+0bsmA9+nN85rAbqvjfDlOiieS
         paFRNQzjgtXU7gJm/CLmuUtlxnp9Smc+y24/idl/Ipvz17bbdzMc6hwg22SzXv9jpAeG
         spUXbO+VBSLrOg7VTea/FGYSGFM5dDx60RNOxp2aQ++/rWZxwGrYClIbWTp5eIwuhKMg
         DCSeXkTKwz8S2jyDAfvW8QOb0v7sBwOtuzGib6KoeIDi4q8fZog0TU+eM0ZXs0/c1nyV
         l8bg==
X-Forwarded-Encrypted: i=1; AL+hErGwBI0e9735PEL6yjqtPN9ytNpZMdrFf3WE/zOwlxvg4EMBpIHTxK9EIWm9AFW0RpogYc3e//0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VCXnF2huAbFohxJBvC48g5NHR7eb3IlUpI5d6S6Ggnb5WyGvr
	YknMokldrHSCzY2/94pwD5Lfk37OMIO+X3xEv1VBIZK01uJLvSub2xLvM1XLONDnHyR42tfPJ7T
	Py/L4ZL7COqmp5F4fI9jYBHiFeSCtVJazSLE/iejfj8C9hqZjsQdokznS3920UfCNwHdkI30x6i
	WtMuXgyeJrb1uEPpGPZGGPg3DebDdFTVNVKm2rN05Vz3i3xWe4tNeTxUn7gknMJQPa4b6ZL2bay
	sfysw6Tlyw/Ni5v
X-Gm-Gg: AYBFou2BoDTfFs2CS8Wrm/4qbhnXtj+qsfgtMxya1I/FKBB+DLJwS/7p7h391hYw2LH
	zX4PRpy+ESXao6SJ1nN4z8aqHiczUwZk2LNwCPUzwrNg1kxADepuz7lLR/tvJuYWsAL+i+87p/B
	UP3TAHW1L2PaBxj8GQNBzmTMfcQVpMdh7rNIcldwraCwneiTJCoWWnWXuTugXvL6Zmr7kANC4I/
	aaZsrqo8cx6YPRz3hSX6/e7lzuo6v7UJqE3MmCbKRM/NNQW7XIx9lr0sXzkpqgGlJ/i2TwhOj4a
	3wyw9LVeuEUr8vTd69OZ7NqQSpRyihoiqTKZmBC8T+wkuE313e44C03bXnffRL2ZJO8sFw4y7eM
	0Gjf+YhveTCogdxEanTOw0nj0bAOtSq0QtknRTT3URL92Fua/mZD2DYA1VTTLZgJcHNfMEkVYTy
	NtJjjWmpP60dWbkWNSyGCMB8nNrYGSF5quh5EjFDCi
X-Received: by 2002:a17:90b:4acb:b0:3ae:533e:7e40 with SMTP id 98e67ed59e1d1-3b1b0b666demr398947a91.23.1794522281153;
        Thu, 12 Nov 2026 14:24:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197c1a3e7sm3837513a91.2.2026.11.12.14.24.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:24:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91ea9e91221so6588016d6.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794522279; x=1795127079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utoyl4Gvk+4k3dUQXqMIzJHQem3Qyf7xqEv4qj4AspE=;
        b=cu9JQO/va45WT/Ajb6B0ZniN5LDMRPofz3N3YScsm2QHJ9cPFZT9DLjnFXENonLpG5
         aub0R1koHu3kwlf2WIFkZQuPz3r9gbReOhoovZ+hctbHw4wS7xuTkHujpUSMFL/Dm5GY
         U0gU+gW7ILgoKcDe/q2zYtgvClqyDMsfX3L+g=
X-Forwarded-Encrypted: i=1; AL+hErFJcQT7lcrqR4HSkWjtbomgF5f9x/5682g/csvPdRXTqAd29OoDtaGmQrNTdloCklU+S0uVHTQ=@vger.kernel.org
X-Received: by 2002:a05:6214:4485:b0:91f:11fe:ec6c with SMTP id 6a1803df08f44-91f2419c4bemr11356206d6.21.1794522279220;
        Thu, 12 Nov 2026 14:24:39 -0800 (PST)
X-Received: by 2002:a05:6214:4485:b0:91f:11fe:ec6c with SMTP id 6a1803df08f44-91f2419c4bemr11355846d6.21.1794522278614;
        Thu, 12 Nov 2026 14:24:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23b2e913sm6525716d6.0.2026.11.12.14.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:24:37 -0800 (PST)
Message-ID: <1bf6f3dc-ce61-4aa3-bb71-5e3a4330d474@broadcom.com>
Date: Thu, 12 Nov 2026 14:24:35 -0800
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
Subject: Re: [PATCH net v2 1/6] net: bcm4908_enet: fix the TX ring wrap
To: Kordian Chmielewski <kudzo51@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261112195051.597102-1-kudzo51@gmail.com>
 <20261112195051.597102-2-kudzo51@gmail.com>
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
In-Reply-To: <20261112195051.597102-2-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/12/26 11:50, Kordian Chmielewski wrote:
> start_xmit() wraps write_idx at length - 1 and sets WRAP on the
> descriptor at length - 2, while poll_tx() wraps read_idx at length,
> and the free descriptor count is taken from length. With read_idx at 0
> and write_idx at length - 2 the count comes out as 2, the frame is
> queued and write_idx wraps to 0 == read_idx: a full ring looks empty.
> The following frames overwrite slots whose skbs were never unmapped
> or freed, their bytes stay in BQL, and the queue stops for good with
> nothing left to wake it.
> 
> On a TP-Link Archer AX6000 this stopped everything the CPU sent to the
> switch under sustained TX load (about 1.3 Gbit/s through the switch's
> CPU port): tx_packets froze, nothing was logged, and BQL showed about
> 185 KB in flight against a limit of about 10 KB.
> 
> The same mismatch also lets poll_tx() step onto slot length - 1, which
> start_xmit() never fills: once per lap it completes that slot,
> unmapping address 0 with length 0 and counting a packet that was never
> sent. That one is from reading the code.
> 
> Use every descriptor, with WRAP on the last one, wrap both indexes at
> length and keep one descriptor free, so that read_idx == write_idx can
> only mean an empty ring. Stop and wake the queue with the
> netdev_queues.h helpers: start_xmit() stops it when the ring is full,
> also when it finds the ring full on entry, and poll_tx() wakes it once
> there is room again.
> 
> Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
> Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
