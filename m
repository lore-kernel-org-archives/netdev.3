Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0F27B340
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690358; cv=none; b=lFoyh5k9jRP9YiaKaHl315cIzGPWOcTsS5Qy9mYg6zJ8R5utJw7liFA6bcLZcaG+jD72VWMPYyQqCJ4bgE4pY4JvO9yM6sV1eNAK5TaWxblCZBpaIXA+NaVAtH6fTo4kyeDS0u1F6Y3QV5UDTmkN1aYkpsk6BfZfQ6d1gxl8DBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690358; c=relaxed/simple;
	bh=S6WTitiZhScsse4BNwexQE4nUZiiH9qflpERhRHNTQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIed1OlNgTYK5V7aXe1LD/w0SjxQ+5VTvk0oTG79vQe0Z1oL7UlUs/JpDfEna8+4bY/edDmmXld8jMPUQTi5o/4v2M6FwZDOyUf2RH8m/NhShbrgjpwrsSpPQI50rS9ja2vrOKc3YeCjW0PyzKCwJtr3o5fCmvtqBiO1o8i7xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bCq//u8V; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bCq//u8V"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so2368241.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789690349; x=1790295149;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8mYgUWzPauMPI8KvHgXl8UKMbYZ2jyU3o9Br39MOIhU=;
        b=cy2mWAX1uyL+l95IHAxif3zF4SG9aTqbtQq97I2T089kCQyQnDQkZM99SmGB1lShUw
         7Ksg7xUcGyD1zm+6DoZreeAu1uyyxv4TZgtqz6PGS0m5nbHdtXiYjqlGpDNNNISlB+1F
         bEJyA9I4re/zhdELRgz5iAulwtFy/qG7FFcFiSA3TZbMr7wQCzOKEdxTDh+MqAuAPHVO
         JGGIgzwtWmp+SjbX6a4eq0ywkt9VQv+kk2CSowBdQFLF52t7L5UpRMQUgAjX7bn3wbGU
         bP+wrzgNLpEJGBQ7rLfUQAT44eBg96TJpRXQjDshJBxd79wiZO54gTkPOZRxPyPjXgWA
         uWtg==
X-Gm-Message-State: AFuF++mMkk8ojtyBWsjfJ+y52+umK5Txw2EX89g89TLe5t/eLzjwqGit
	ft9jU3uiZ9ZldFEl0KL0bxE0+ezZqDwrGW3yz5Y+zfLAfDpoZjEp3mvGYXCzBLxegdwfpaJy8j6
	1WG3mMt2fLVS5Qg9SHL+dFZBFyzpmzgNPYLqgdS5qN8g10OHs+yTkSz7xH4bylu9eL7lUSOwqgh
	3/nL9UOiRcOvGCVEIL0J78a/thpJ4sVmKsyLSrCpMJnFikz2nj3XhYJOgfHx1Y90rTScpcHPytn
	Oirgdw0K0XGxfDW
X-Gm-Gg: AYBFou0guoduBpkOEoehO9T6sfmfUaY+ZKjObRe8rJcKTcWjGKdLXlE8vqW1viS+85O
	kkJIdMG2Qh2KUfVqEf8vWngdJYnjutV6gzPkVOVKb99ynlPxET0rUoeYwqMQgiXDwew0qrDZHlr
	COJFqUEQRJqE106/pY9Nl6r+xtYJyaTjN5ZPkVXi2lMleRXtZdz5BODCgPdfdoqQsmY9lzK910/
	Fl8RJ48rRyj0ED6cCHtO1pNZtKZoi5Wcf42hpL1PNnFcJNPAA8aok5Y4dZ4d/mRZF2LbcFjcwVf
	ZRGQKGztA/CiXojgNIiBx0bGH6Y3yGD9+xV6nCELt8yAFNxMKi4MRB8Uuce1xS2+yZh4xtdpCHo
	pHh05g9iAvUHNopyhHYfpHtnHKYy82c5HqdAts0s07havydawzYTY/MFgyYi+Oym2SuSDiMfq1H
	dqInf7LbjQMqMeK7mawHbDQevqaQ/B5hDkJQDWw6lf
X-Received: by 2002:a05:6102:418f:b0:7a2:1f78:c5a6 with SMTP id ada2fe7eead31-7a55cc75695mr337307137.17.1789690348746;
        Thu, 17 Sep 2026 17:12:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-98337aa92f5sm40218241.2.2026.09.17.17.12.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2026 17:12:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-869553205a7so1969197b3.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789690348; x=1790295148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mYgUWzPauMPI8KvHgXl8UKMbYZ2jyU3o9Br39MOIhU=;
        b=bCq//u8V6Jfq3XywAdaDamwtAxuj29ijtHOZk//3GRsSbV80nerk6lrDJU9rVThuZ3
         wviEliEj9tJSJs2AsOFrrh2YjdGjzVpdAtseA8lwwqKFnfQTjbbNhhVWlo0lKAFHyrO+
         ro+3WEjyIfwDmp06LQR8AdO2WNffrKPlS8UiM=
X-Received: by 2002:a05:690c:386:b0:884:c89c:ae4e with SMTP id 00721157ae682-89732278bb5mr2414897b3.6.1789690348122;
        Thu, 17 Sep 2026 17:12:28 -0700 (PDT)
X-Received: by 2002:a05:690c:386:b0:884:c89c:ae4e with SMTP id 00721157ae682-89732278bb5mr2414727b3.6.1789690347550;
        Thu, 17 Sep 2026 17:12:27 -0700 (PDT)
Received: from [172.16.1.139] (107-214-104-235.lightspeed.irvnca.sbcglobal.net. [107.214.104.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8978bb53ef7sm902147b3.35.2026.09.17.17.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 17:12:26 -0700 (PDT)
Message-ID: <fa38279f-0020-472c-93ee-7f4c1740cc81@broadcom.com>
Date: Thu, 17 Sep 2026 17:12:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] net: bcmgenet: Collection of bug fixes
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
Content-Language: en-US
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
In-Reply-To: <20260918000732.276506-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/17/2026 5:07 PM, Florian Fainelli wrote:
> This patch series contains a collection of bug fixes found during a
> LLM-assisted coding session.

My bad, I forgot to remove some tags while the patches were sent out, 
will wait for feedback and repost.

> 
> Florian Fainelli (8):
>    net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit
>      systems
>    net: bcmgenet: initialize u64 stats seq counter for all queues
>    net: bcmgenet: do not skip WoL power up on GENET V1
>    net: bcmgenet: clean up RX NAPI on bcmgenet_init_rx_queues failure
>    net: bcmgenet: acquire ring lock with BH disabled in
>      bcmgenet_dump_tx_queue
>    net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
>    net: bcmgenet: zero-initialize Transmit Status Block in
>      bcmgenet_add_tsb
>    net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT
> 
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 34 ++++++++++++-------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 

-- 
Florian

