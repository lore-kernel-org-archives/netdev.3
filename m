Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7042051C076
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753321; cv=none; b=r4A/z4VlhdOqhG680+Ut/KQ/6dmN/+eueQhkYKvk8k2Kr+U2IdR73vAdaS3bp+K6/HBGYuaQz7o7VksgRg6isRCf7k8Q/Jw8CkP5wOyEGvMu0iZCLCmWMMzpoGJFlQhtimbOFRV4NqJoplPdIDjtAHNRPLGvz5UjW/1k8zs9As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753321; c=relaxed/simple;
	bh=+isudBCsCI+8QRhr/NaUqSPzjNiQcWhaERtf4h61Jmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYuBxbz+c4+9pJ4nFohnaTlE2PXz5WsQe0mcm0PG44uaAQVY0aoapti2VGHhkqmmK2HKqJQFN8eFlAGCqIgv5EMYtCBPjcNa2gVwmtYObfvvk6Ze6e4g5BPdqeHAqBSRqtTBMUuIgOdi6YjqV96Cm8TAZYHYZCcW8Si8N5EZffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eg3H6TfT; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eg3H6TfT"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso230658a91.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753318; x=1790358118;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LTw8O/yK91y4RheqROz1F5sp+F9hbbCwTxlZ78Kfrtk=;
        b=uDEHzSizDd2AiVvnoxXkFDETa4mMylgWxtSSZI8qtVZGfB3cKRFUxqrwY3bfVQXox/
         gos6Z0WS+3nT0O1TKeSSfurU53O5PePvENsO8kqxiyN7bpRU52EZLYdUBIDdQYD9jvWy
         wE9ZDBY+NEyBeYUOGrhd7NBtmSUJh7doXr9FEzPDlrr9aF0N5e0D69jqRdsdzugze0U1
         B3yaVEsnD1wbEaTMEyIK9Mp7SOw99dBNo514HOeSChr+3duETzQsis1vNVSF25F8UG7Q
         9M6V+aKz/qzXQ5/OoMrAWM9Vbq4KQiSqzFFO5A21myn8NmF+uSD0WQbFo8VRNVDe3HQr
         yj5Q==
X-Gm-Message-State: AFuF++mbm2J3b5UrGEfrIocCA1d5MhDugL3RQjm6BGAdffzO9uHTDuS0
	/lGwdwKA8NFrN6C2l/EuFDvWkFE/Dzok6InFdOrLbl/PCLRChmD1U7HjvDS4kg8v7EN1Eewkw24
	o6n+v1Ox3TPQu84Z1Xb78eX1OB+xG3uQ955Pa8j/AMbBrkz2J1BrW/KSIecrtvq8YUl4W/22Sti
	tUOEwFxS5c+zglm1z8Kj2s8p8hbMti9N//W9WkaYabHXPsxB+/a33Vixy7I38USbODmOzFFhMAy
	pfhZIFS0W6zXf0r
X-Gm-Gg: AYBFou3bEyi3MmA/tKUwROak2bzbH8prcAqajhE1AUUHJoo6RUQNnpG+jRXW4ZmsSRY
	2lCfStFmDwAPHPP5ToML4xXEP68bE3ydhl3CH4MJTjPtLdbqXn7bVQNfC9i7O/1eE0d+Hw4n8IP
	JKVW6foYqQBUjfxC1aTpZtiTPpjJac8LnEFA8DSoZ/OJSwb8P8PrUHrwO7Bko4YxkllkPH2rUWb
	Lov9odTJ235O71W0pc9RmTvzxr3HQ0aB5pMAYscRykzO42OirOJbyhTrI3ZTfsWZ/Y6rjS+czXY
	PG5UJ9itu5+wYBN1D92apsG1biDfqZpr0lfPlVTN7olXecGsnyATYL45z4McU+bUauA8oksU7mM
	qIIAo6F/Vt761x5B9Eri/MRzVX5mKOFBOSvBXTWd5U+i/Q+ID7DSBMENShW6I5x7herZhpcMCQ4
	bD1h0D2eOeNbGx2GEkXS0FpIXTuVWUyvBaDxK2b7NS
X-Received: by 2002:a17:90b:56c5:b0:39e:4c81:6c66 with SMTP id 98e67ed59e1d1-39e54dc1a3emr7367228a91.33.1789753317877;
        Fri, 18 Sep 2026 10:41:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39e6c61c8fbsm156964a91.8.2026.09.18.10.41.57
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:41:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc7337e2a7so13245285ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789753316; x=1790358116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTw8O/yK91y4RheqROz1F5sp+F9hbbCwTxlZ78Kfrtk=;
        b=eg3H6TfTNektoKL+Gi8E2YXI57wi7+N57S1K0cYyjneuyyBR/LMhecpOF+SV92dgjj
         MX19CFpdDKSa/U2/vk7QdqAg5gYpOIFH1gspSFenivd5z+pMukYOWCuKNCocS734WVLA
         qRGLE6YDvX196FGWZwihms6BMffca0zpZliuU=
X-Received: by 2002:a17:902:f611:b0:2db:2376:6e8a with SMTP id d9443c01a7336-2ddb1ab5841mr69288835ad.9.1789753316085;
        Fri, 18 Sep 2026 10:41:56 -0700 (PDT)
X-Received: by 2002:a17:902:f611:b0:2db:2376:6e8a with SMTP id d9443c01a7336-2ddb1ab5841mr69288345ad.9.1789753315540;
        Fri, 18 Sep 2026 10:41:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba30dsm322255ad.46.2026.09.18.10.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:41:54 -0700 (PDT)
Message-ID: <d954c225-ed1f-4849-90c8-51891b1976e9@broadcom.com>
Date: Fri, 18 Sep 2026 10:41:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/8] net: bcmgenet: zero-initialize Transmit Status
 Block in bcmgenet_add_tsb
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Cursor <cursoragent@cursor.com>,
 Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260918000732.276506-1-florian.fainelli@broadcom.com>
 <20260918000732.276506-8-florian.fainelli@broadcom.com>
 <f8918542ababe3af39ce6f2f5ee55948@tipi-net.de>
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
In-Reply-To: <f8918542ababe3af39ce6f2f5ee55948@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/18/26 04:03, Nicolai Buchwitz wrote:
> Hi Florian
> 
> On 18.9.2026 02:07, Florian Fainelli wrote:
>> bcmgenet_add_tsb() pushes 64 bytes of headroom onto the skb to form the
>> Transmit Status Block (TSB) but only assigns status->tx_csum_info when
>> skb->ip_summed == CHECKSUM_PARTIAL. For packets without checksum offload,
>> or for other fields within struct status_64, the status block contains
>> uninitialized stack/heap memory from previous skb operations.
> 
> The MAC only reads tx_csum_info when the descriptor has DMA_TX_DO_CSUM,
> and bcmgenet_xmit() sets that only for CHECKSUM_PARTIAL.
> The stale value seems to be never used?
> 
> Did you hit an actual failure?  Otherwise this would be a 64 byte memset
> on every transmitted packet.

Nope this is entirely theoretical, and one could argue that this could 
create a slight drop in performance, happy to drop that one as well 
since we never really experienced any actual issue.
-- 
Florian
