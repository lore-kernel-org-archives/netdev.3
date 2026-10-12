Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F94EDCDA
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841706; cv=none; b=szvilAMuHAlsMaLLWSX1uCF5YgtNEZEYSLZ9PYcM8dPPyojwPZipRMALARJ3WOlcLjRD8cSj60g9ocd1bA3i/GAiaZrFxHfL/we9mdHKoirw3YfrBSVRMRMXJyqZhLPJ8h5p63IW+YlrwnNW6Uh4AiG9ENU+2JS/k2DzZSQhSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841706; c=relaxed/simple;
	bh=aEfYHXPTmnEYYiYAPpFXHF3bUIqJKSeyUSykg9wsj4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcKfngCu/40rUVoQh/vIgYE8iMOmt/vvzWJTiuHM0mR3bguTNbMq7lasnNdupRcLKkgqYkreQFDg7XMEjQVLEiIAhI4Kd8BU7A8GmGzQK3Y9KoUEZ+SWRChjUO/uMBh377FiaKSkc206kJ/BC/B1iGw5UqDIWB6g1uecQCqV5w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UWIEoocq; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UWIEoocq"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac397836fbso181397a91.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841702; x=1792446502;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EPhs/xN5AxpRlyQU1w9jzIS5vduQg7Q2ac9dkdsHI94=;
        b=Tp6liKoUEWgU5My+U79tTNm0C+q9kZISYVdUBfY/U5rawlHrg3BDBBthXRKzk/vzAY
         bgVU4lbnCHpr0O2E+foy9np2X9+xI6IuaB7HghkDw9aG897AJYo+SlrAVsd7TCbtXtKi
         WI1g4QmFdOg0+a8kE9XzaSF7wN+EXBwlUigvDCEM14GCx9V6H9AR+gvAmRsWK2KjUowE
         H92aHzd30fIXm4S3k+qjsyWMkHr7cYMNl9CM0Wi3W3t+diCV6vsyYLTBcKk1cOTxRFlg
         1g5iC/KldRtb7UlmHT8rqv+VXS62JZ6oeZqnn57smX+y+irUWxmQYKQF8mNGRx50upkN
         PiGw==
X-Gm-Message-State: AFq9FYJoqsW17Ol7VKUabd2iR1diefZ/ie9k/JKybXnhCpCAsoYLJ1wv
	I66XPjw5rMTkApMFdVpViKWW2GeMc7oHLM03YOVQ3hN+A80/xkkRed/N7S9Xe3mM3GOAScgM91U
	sqCtQGqN3YHOPkRvfmvo1AAqWISKWhr71cPnxpxHAxJyp8Z59qxSVfUhg+Y2kwoUo+EeFfjIt6h
	Z0ArtbbijyXHRuZFd5NlZVSOVnUwvqsMlEI3IEd73zTlCs3aluzIouxI5qX6N+SAobsjnbwYM6e
	8xltkPCtkLlLF0R
X-Gm-Gg: AYBFou3yIRO6F4ZU5kFfIt8NpGYwrN0Zp5UlSrnV4qjxgzLPrqWwzgjxZo28FwPkQok
	xSd2l/ZOMVvBr+TO91RReNAKxsG/fCpWorLnuVNPTUa1ofRFk/IDOxctuWk/h2Gz/x6/5InDr33
	MVrGANU5+Slp66al44I4KQ+3Gox6I4/BsmQnmyyzPuFjpFKU3qLHeNKIUlsDL723SB/Rw7x1htk
	QTfqju40Edk4ymRSbHlbpC8AqKzZ/vyEjvsucSPBtYDgMdce9oauu6+L+c58quVt3G9YjppmtVl
	8rFS8mHliI1NpNPgnSq5W5v/EuNbDX1ym9f7gzFJvpN0XY5bN4MtXNRHcEDQlZvPmdHAuuzah5K
	q9pbm++276fcXf7gkwVLFeta+Uy9BBZj3wCBf8yHGetik8oP01LefwaN7xoRPRPOvu9ElhTEAr5
	0I7hOu2h//B1wGRqZ/p9Eynv+VMJ+sjnmaPUBWAHhqP/8=
X-Received: by 2002:a17:90b:4fcb:b0:3a6:dc2f:f07f with SMTP id 98e67ed59e1d1-3ab3a609f14mr8798464a91.10.1791841701559;
        Mon, 12 Oct 2026 14:48:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3abe588fa88sm2492044a91.7.2026.10.12.14.48.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:48:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3580c07911eso6124909eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791841700; x=1792446500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EPhs/xN5AxpRlyQU1w9jzIS5vduQg7Q2ac9dkdsHI94=;
        b=UWIEoocqiVLyE77Rwxbi08SSHsHlyVrWQSlPGtqhQI0WwEN17iHKqfD526idhLiKRM
         TfTo9/bb/TAUpvgHHjypmxCN+ir8pROfXXF2jEcEey9+9MdpcO8FZ+AdVswrhifomgU+
         AzaOAWSVVXAfpJ6BJFTFZ+/VSEwnScHsdjuEk=
X-Received: by 2002:a05:7301:77cc:b0:357:e9:dcea with SMTP id 5a478bee46e88-35700e9df2fmr12153450eec.15.1791841699606;
        Mon, 12 Oct 2026 14:48:19 -0700 (PDT)
X-Received: by 2002:a05:7301:77cc:b0:357:e9:dcea with SMTP id 5a478bee46e88-35700e9df2fmr12153315eec.15.1791841696960;
        Mon, 12 Oct 2026 14:48:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm34266609eec.6.2026.10.12.14.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:48:16 -0700 (PDT)
Message-ID: <93ce0204-419b-460a-a0dc-b7f124bf32be@broadcom.com>
Date: Mon, 12 Oct 2026 14:48:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Justin Chen <justin.chen@broadcom.com>,
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
 <20261012-nb-genet-mtu-nn-v2-v4-6-2e2e3bfaf8cc@tipi-net.de>
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
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-6-2e2e3bfaf8cc@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 02:00, Nicolai Buchwitz wrote:
> A frame that ends a few bytes past the transmit packet ready threshold
> stops the transmitter as soon as a shorter frame follows. Tx DMA then
> refuses to halt, so every later bcmgenet_init_dma() fails and the interface
> cannot be opened again. IP fragmentation generates that pattern on every
> datagram, full frames and a short tail.
> 
> The window starts one byte past the threshold and widens with it. On a v5
> it ends 28, 32 and 46 bytes past thresholds of 2560, 3584 and 3840. Link
> speed makes no difference. Pad frames landing in it to 64 bytes past the
> threshold, rounded up from the widest window seen. The threshold goes by
> skb->len, it does not count the 64 byte status block the driver prepends
> later, measured at 0x80 and 0xf0.
> 
> Padding must not push a frame past what the peer accepts. Linux does not
> bound how many VLAN tags a frame carries, so measure against the longest
> frame the MAC has to accept rather than a tag count. For the MTUs where
> such a frame would land in the window, lower the threshold instead. All
> other MTUs keep the register maximum, and at or below ETH_DATA_LEN the
> reset value stays, so an unchanged MTU keeps the threshold it always had.
> Nothing reaches either path until a later patch raises dev->max_mtu.
> 
> The MAC inserts a checksum only into a frame it holds in full. A frame
> longer than the threshold gets its checksum computed in software.
> ether_setup() leaves IFF_TX_SKB_SHARING set, so unshare before either path
> writes to the frame.
> 
> The padding is appended to the frame, so a protocol that locates data from
> the end of it, such as a DSA tail tag or a PRP trailer, sees the zeros
> instead. Nothing below an MTU of 3809 is affected, since no frame reaches
> the window there. Above it the alternatives are dropping the frame or
> leaving the transmitter stalled.
> 
> Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
