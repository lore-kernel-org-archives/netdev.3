Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A724AE8B5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822339; cv=none; b=liCZtJqBjajTSVg332kle9u3sOlzIg+JQE57W/qLR/WVR6K1Txi9k2PJRtUf1+bSlozoZWSQivgBcZBRh/gf6w1SjIzOqezkt7biKe4K/f5FKNi4uldggcv9/D+I/eHDzLvUO9+O/LgidmlEwEIRe61zCy/fjAeCKpjl5aDS8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822339; c=relaxed/simple;
	bh=mBs4xcS8dNmUCHa5Evfs9Hz9UI5u4DLOlRr3yyuKOVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebqST6DH2p6CITJX1rCOJQTUq4XMQHrSO5Yd7ZKPfeifuwAOYE7QpQKp9Dd54IPU9JPis1Z6nMfb157AcYKRgA4xbUfG2rMuuH8dHtwC/9bYuH98qsG1i9CgyRhm1PIPGiJm40oylaHxJbdkcT2XI7QOopztwq+31jceWOYqHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WjQgEpJ1; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WjQgEpJ1"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso1357650a91.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791822337; x=1792427137;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mS3/Mn2v6ufVRhNcMhsDhpYJ+oCy4Mka3ofoduPCzB8=;
        b=jwpytcq3gfQCfwtvVjTw0weGBl34VAC4MjgvbE7PvqwhOy8j81DeQ+MFwjxOcHvkUi
         Irl8uNbvdmnsTZAvxKq35QOnxwmY24psNvKWmBYRNkXKnMLrghUgop3EWhsM2jWny8QH
         Vv8bGLQ0Uf+yaXV6/b4TBlBKCHsTPkFc0MBtmtzXJxltpTXWWBTcfpxGE1EIoTztXX28
         tI2PlLgBCIBxOHDtnApoFZXsXofwiaQjCmLM86uuR+/LTi6S5Kl4+ygKklby/dnnbOov
         L5dZn2uxIyiBM170ssKDuLbJZf3JM7UuvgIkNWGECa4nMIbbE8scITE1nQzH9Z78TVkr
         FCXw==
X-Gm-Message-State: AFq9FYJGL535b9p83i5QfIYoxzYIGoxrhay+OqiPId5kIrvvl6Lx1Hyn
	1JPjZXLrYGIsQ84nbJdB5X1PlvlPuqKizptAF5D1T+74/Op3x5f/A9jhfq7oAczdqw6V/zPpUhl
	qiauB4ZnVShX3R2fh/+2CasczbM42s3d3Tz3nGSAFYqEsiCG4AIWI7KtHS/SHPLQ8YREgVADuVA
	6i9eAE4P5wXqDo5dzRgMJLOSox/GMwtkemop9M432x0Aj1NWQOWD0qHl4oHNbdpY3Gf/VChn3H3
	UWV+nywVSvQ9EX6
X-Gm-Gg: AYBFou3zNyTwKvVWWQkD3JWJ1jYSoHGYyjKxSXhIdssJQjZi+Y6vHd2jmyN0tZpuWTb
	5vQuL0wVNM8/8cIyh9MMeciPIHU0wRKjfcW/+ww0dqfAzxiHauoNWTDNAkTINfis1Sji4YibwfE
	dpnplv0/Apq9ki6AWul0XH2ad+bz1awURRtogSUZpDjhX7t2iHTYsjYfjjYnl/v6PsmcQnU4ow7
	awjrQ3ohRF3jV3AE5ZOgxpMVrl0WCRJzVZufXQFM10bvOQO8c52ZB6NqTKcqHV9MJGiqgmBQndr
	7MSkyuWJ5PazLcqRnUOdes7BjIylwqROpq4o5Z9Va718kOCYP+oayP5M70+01/3kfQdbHrLf6JO
	AosDp0yCeyRHRsI0eFqirPnFOe+dV/ZTuEzjyLu0n1p6cFrb3ByEVpKKk7wEACe0RaLp5PqV8ly
	/DiSZZh8gaYkubSpGOHcl9I2hmxRs8zP2OdMxiF95p
X-Received: by 2002:a17:90b:1d48:b0:3a8:a1e3:32a1 with SMTP id 98e67ed59e1d1-3ab3ab24b1dmr9001589a91.45.1791822337155;
        Mon, 12 Oct 2026 09:25:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d7945fsm5596322a91.3.2026.10.12.09.25.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:25:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4250607eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791822335; x=1792427135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mS3/Mn2v6ufVRhNcMhsDhpYJ+oCy4Mka3ofoduPCzB8=;
        b=WjQgEpJ1GHmC7NrZ5Oa35Lke77bQDW3N4iJeZq8l+s2qYCs7DCRBUMMubd7ZO4glBd
         52F9Og7YJ2yfs4H3RuMYDRqMEqi4s0tiaQgi2/wMxtA9FAsYvpf7+rBPgDniUervKuzh
         fj4P9csQYJZAi05xpAbdt2SQDUTKRslAYOES8=
X-Received: by 2002:a05:7022:5f14:b0:168:6ad8:e89f with SMTP id a92af1059eb24-16a56c9dd9dmr13272681c88.3.1791822335010;
        Mon, 12 Oct 2026 09:25:35 -0700 (PDT)
X-Received: by 2002:a05:7022:5f14:b0:168:6ad8:e89f with SMTP id a92af1059eb24-16a56c9dd9dmr13272595c88.3.1791822334090;
        Mon, 12 Oct 2026 09:25:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm38765513c88.16.2026.10.12.09.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 09:25:33 -0700 (PDT)
Message-ID: <bd3f62e0-1d12-4fb0-b02d-8e0b5e3fbdc0@broadcom.com>
Date: Mon, 12 Oct 2026 09:25:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/6] net: bcmasp: Collection of fixes
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261012135100.n5fsyqsvwieq2q7y@DEN-DL-M70577.microsemi.net>
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
In-Reply-To: <20261012135100.n5fsyqsvwieq2q7y@DEN-DL-M70577.microsemi.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 06:51, Daniel Machon wrote:
> Hi Florian,
> 
>> This patch series is a collection of bug fixes accumulated during a LLM
>> coding session. Thanks to Justin for the internal review and helping
>> with the last patch.
>>
>> Changes in v2:
>>
>> - address Sashiko's feedback and correct the commit messages and code
>>    accordingly
>> - add Nicolai's R-b tag where collected
>>
>> Florian Fainelli (6):
>>    net: bcmasp: fix mib counters struct alignment with ethtool stats
>>    net: bcmasp: unmap previous DMA mappings on TX map failure
>>    net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
>>    net: bcmasp: fix OF node reference leak for phy_dn
>>    net: bcmasp: account for offload header in TX short packet padding
> 
> I tried to apply the series, but it seems like this particular patch got lost. As
> a consequence, it cant be applied with e.g. b4 shazam, and PW did not run the
> sashiko check.

Yes indeed, not sure what happened there, let me re-submit with 
Nicolai's new tags, thanks for taking a look Daniel.
-- 
Florian
