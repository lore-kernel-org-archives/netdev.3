Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380926158B
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616589; cv=none; b=VT7nwpO7YBnDixRrdHfoWpEWrU5JtpJlqGwLMvCunTaTvMIZzwJnYad4Qrok/vwZHQ0E7awZu2ExfDpfvHth1Xx9Km38lylsZJqsJGPCYeKjMtTwvYoyu3LoC02BuVQSzlvBDxA3zuyeF2JHNqXom1/MzMjSCYcBnpfYvkZ9Lec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616589; c=relaxed/simple;
	bh=0GcwPiOxVtl0raHQB5CmMQPRpFKz6ZZcGhB4J4dKloI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+uWW582O9p7bgKpPNBqzHRU/oLkDY0VgNBMclWCxWofga3u9RjsYWm708GeyuwiH1v/ZSplyHODV5NLELtJ0f65PD2KWhiOajAwDzGOClBJxhTpwit2FDpADbaX7iFz5uS/USO4QO6Pmo7/tzvHGmt50Ss6kubuwKHJQwUHz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HE67YzTx; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HE67YzTx"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93c599b76adso59327785a.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616586; x=1791221386;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H81x9I9KYzkC7TOrHn3LvMxYaFObihsB8yMmyGfgDlo=;
        b=QcPtT9Woz5fw0V0CrZgGhLfRJMAS75pqs3Ln41kf4IeMteouR1RKgqudBvM82CaFyE
         GW3StICvZUKn5LI+nT2amy1nyjO9LONVZ/POwZcFNJwYFtRLFuRVg0mT8QBgIVE7ReaV
         DaT6kW84TE/8MJGTsCORtnOBHt/VYKXgqh5MGrbfA3mDsXHVx1HzOHyxfSR5RmMZfKaj
         DWh3AazsqPWnl8wz+e7nlSGBdfbe0MMMl6u4tam5O+8tNDdhOMIjq2QWjntCO/c+1RZW
         U/z4DUJ0qD6WqvSzXdORWBqh2ZYtW5mqhKkiL+ZFYTl6O+SfLA/2IwTTTKaBDyY4weum
         9UfA==
X-Forwarded-Encrypted: i=1; AKwUvBwkcy5AD65ynuBaMz7s75R1jHR1vvc7+HnEq2FSa+CnAFawPdf4pxDJV2mhjpK/75H3tBpiykw=@vger.kernel.org
X-Gm-Message-State: AFuF++nDfA7rHoeWh0hQbtuahr9K7phqdX6xHnV7y1AImct89qBeDvBn
	E8WMoy1QMtz/UhNX8Rp6MqT2vUXZHUtBPI3Dyp/FDwuEaoZ4XKosjQvzpRXoEc/Cgevkf1ZBKg5
	F7+kZxErdCijfuMQEi1Yr1/Im6CLhXd8c3+htpyEztGlF4WTh3nbPKl8JFL2Wqz7uyJbETsfDq7
	MCigvOWnRiaeCtKpGlqrPNNN9ovFDks2djWlADWrznb+ceAmsEKRdM2Y85bqc2Rk/SHhY55fDG4
	FBv17kfGHxKhGib
X-Gm-Gg: AYBFou2O7oas5XAbOvSJj9vs9JeCNc36W6p0jYu10JQBGYnPiRFLPYDxDk5s9XimTEq
	2jrDzPcyIY7fV3rgIjma1ewTKbIttaYuEWK/1cZbzhTMCf2cPuCK5NMEJMhhmaZ853XIXVnGX3N
	sFMMYGIyN6ZyNhGh454c+nFssI0v9QXLGGDjrj1+iAU/cFDun/JGu14yhI24Loaages5ZJkkLvG
	udanVq/a/2BAw7e0m7hhmwuAm1aIUtuLrIE2TjkaBXP52RTyp112tP40Yzb973CDRLfBNG922KC
	Oe+9LzvLhDjQ1Puqxl2WZT3K1aS7UUSCDkwWPIF1IAwxtiSX3ukwaEHhZNOuoo2pKMP0WI53tLO
	kiqZKwZwfioyiQ0pzWQ81MiOPwMKAnxyLqIPn9BnIb2xh+v3oqpKxTc8zEL//65E/1sh185W4Mh
	BaR1Eo8c51/6ZPB6AqNFmjJZrvkiYtQyKu1jwdVLinRso=
X-Received: by 2002:a05:620a:4107:b0:939:e93d:a66e with SMTP id af79cd13be357-93c43cd4a8cmr2186718385a.42.1790616586285;
        Mon, 28 Sep 2026 10:29:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91430dacc33sm497666d6.17.2026.09.28.10.29.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:29:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86917d18880so2402786b3a.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790616584; x=1791221384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H81x9I9KYzkC7TOrHn3LvMxYaFObihsB8yMmyGfgDlo=;
        b=HE67YzTxN9EUshZQq1a3Z/59PpTtzhqigjOypSgLWMaHSOcTQ9kvpD7azI2p1QzoU+
         wli8yjW9vh5CNdqme9Y86lnpGbOBUZb2jOTaQ2jbdhXeDwrf4Ui3IWTtyPMPm0aJCy5F
         28WqAQRp9o1APA640RXdfPhBhfdRVSHoTpCNI=
X-Forwarded-Encrypted: i=1; AKwUvBzTo9l8xw/IS/yQSPQzinfpIjIubq6WZcrzOEnIk1KnueqhzzHiQchQelsIH4nT4kYmbacWI5c=@vger.kernel.org
X-Received: by 2002:a05:6a20:3d05:b0:3dd:a196:906b with SMTP id adf61e73a8af0-3de0e904ef2mr15311562637.53.1790616584207;
        Mon, 28 Sep 2026 10:29:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d05:b0:3dd:a196:906b with SMTP id adf61e73a8af0-3de0e904ef2mr15311535637.53.1790616583698;
        Mon, 28 Sep 2026 10:29:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7ac048035sm2416351a12.4.2026.09.28.10.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:29:43 -0700 (PDT)
Message-ID: <d2ea7c1a-dd3b-42d3-9b58-74c89c9f2128@broadcom.com>
Date: Mon, 28 Sep 2026 10:29:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: fix NULL dereference in set_coalesce
 before first open
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928105642.856210-1-nb@tipi-net.de>
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
In-Reply-To: <20260928105642.856210-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/28/26 03:56, Nicolai Buchwitz wrote:
> The Rx ring priv and index are only set in bcmgenet_init_rx_ring(),
> which runs at open. Setting the Rx coalescing parameters on an interface
> that was never opened, e.g. "ethtool -C eth0 rx-usecs 50", dereferences
> a NULL ring->priv. The oops happens with RTNL held, so networking
> stays stuck until a reboot:
> 
>    Unable to handle kernel paging request at virtual address 0000000000002788
>    pc : bcmgenet_set_rx_coalesce.isra.0+0x10/0x88
>    lr : bcmgenet_set_coalesce+0xe8/0x180
>    Call trace:
>     bcmgenet_set_rx_coalesce.isra.0+0x10/0x88 (P)
>     __ethnl_set_coalesce.isra.0+0x490/0x570
>     ethnl_set_coalesce+0x48/0xc0
>     ethnl_default_set_doit+0xf4/0x230
>     genl_family_rcv_msg_doit+0xe8/0x160
>     genl_rcv_msg+0x220/0x2a0
>     netlink_rcv_skb+0x68/0x140
>     genl_rcv+0x40/0x60
>     netlink_unicast+0x338/0x3c0
>     netlink_sendmsg+0x19c/0x3f8
>     __sock_sendmsg+0x64/0xc0
>     __sys_sendto+0x124/0x198
>     __arm64_sys_sendto+0x30/0x48
> 
> Set priv and index at probe. Writing the registers while the interface
> is down is harmless because open resets the MAC and
> bcmgenet_init_rx_coalesce() reapplies the stored values.
> 
> Fixes: 9f4ca05827a2 ("net: bcmgenet: Add support for adaptive RX coalescing")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks Nicolai!
-- 
Florian
