Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262478;
	b=lwqlcx+duGkD8d3UFuGiwJsBjIIBsNhgyYZ282tFsIZD/XtKSym6UC0nyjSRtlrPn4QP
	 owczosZeabNerQVcHT3InUocuP8r+iuc1CgZ0JS0/PoN7HgetqgwyglauuMymHiPDlHFt
	 GtSH87DNKvfhN2TEk+8w4KU1wmDeyT2H070bwXxhumcl+h1ARQNf+bgONNaHWHz5OI54B
	 0vPM59zS3Rq600BXZPeBmhlaHFiN5xcEvllL7OPx7sdnHj2YUR0JrLIrijunxUUhhgM2G
	 ZRExAYFo0Qq7A5g8qf3F7sBnUp1sQDg9sZyn4zok0cz49J66WYTDF7++x5dOjMNPf3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262478;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=m2la7If7oS8mGV9E9elp0qEy1slr4e68W5FdYtWr/CM=;
	b=2yuQ5QBZzr+nj3l4mwQ9UdC47sGDIThx/MzHJzdBKB6/PovPiVavwoCO7q90+9ze91Ck
	 0B27zqzf74/7vu0swU++2lUCTiRvCNjt0PT9rbcUUCg1hooZhYkxolbGqT0lWwE223E+J
	 ze836T1EFJ5aYbK96/iTSC5klV7a6dq4NZZn5doGSVePUlEv+aarJQvSSqAd+Aiu79hJE
	 xElXRzQczqjSR46iw2pYMv7rMzzRzYDCNvIMSs0ZjsvDSRmvJ4lewfg3wvWScistXR0mK
	 lqYka6IIDx1vXiGzPlfCSIr8To1js0k2+0LfnxajksYvEF9rZjZxFaI6vWYE199Zo/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZaYbnyy6;
	arc=none smtp.remote-ip=209.85.128.225
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27855606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 22:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27855606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ZaYbnyy6
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-8b0cf2c0785so13781467b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 14:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794262477; x=1794867277;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m2la7If7oS8mGV9E9elp0qEy1slr4e68W5FdYtWr/CM=;
        b=a/yNar45QcqBGYEJHaQyvXBB6XIahWHj6A5PkiDfrMIRWyhsebq5aIuMo48H4nCPps
         XI7cYz8kqLUSooIv0NCzfhKc59AiYPtK9qNh5FHoWOlBNiS1jo6cgOTSEnHfcfMAUOKR
         tljfEFeUEiYlfrJ7ZlRHmI+VKi/ODDC1pni0f/xs4agZGMaaxLpiZlM/+NvV52oU5Vhq
         CJCg7kJNUBHGkVSgMD9CY5QQpHBLJr/qHCItM/xRxORpFj+X65PpC2hZ4piXPE7B5V3n
         uzlMvN9d/Lpx4FA+MbiMbzrPPrwNSTLdN2fgJTx6cW/EgiX5ri6AMajDNoW3F9/r2bMs
         fGGQ==
X-Forwarded-Encrypted: i=1; AL+hErHPUFsQGE4PBYYempKTWdu8GISL8GMsos70JLhU5JD60zo2N9UFltvs05CrxetQq26TEEaOZB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MgOPvwqevaCqVdd8sb+QymFpgIDB7a76DpH3v22f28DKUlmZc
	UpEYMFF6F1s9Fp4Vu3Gk6l0rob6FrxEUQGsPmA34+CF7eZ8gZeophKiFMZlpQ/kPi2MszbVbrHx
	DQGuXGvTJjCSm3BjU3MaERDF++PDV0B1H625shCBon9T1zXpfXV5HG0c5Ggo0c0SWEz6BAPaAd3
	BPOC8y1xpUFUdJiZOhLZQNO4jn/72xtiqBdurn31rV229SNJEQOLrwnLDa2PcJ+BN6uadD1iAF5
	fagrde37pdqqGrF
X-Gm-Gg: AYBFou2qvwzEIo/8t0999/m/wVBslkHZPUta8/r057J17swW4hsx044JgKlz3qyvD+X
	BsyH99UYi7RjdpIGijNuUha2FfSacK2DgOc4Z0RD+4+VzyGxEdEWUfpwfJnzmRWuVXUNGBzmXSx
	dRczDIde+QGf7X6SqkPQu15ZcoTa8dXPkMFgteYThN6IWzuPn14HHQpcAuLWUcavSXcdWynMOVK
	MPd+MJSCzMd0uOmSK+fjz5MzjskpaOB7WuNNRsMF8wbFG38+JIN/SJz4ZHEghkHHuDvVk2nPCHd
	wG5Uv8LiRtEM6nuGH9/qwif1nfvypcdeoT+NlEsmMIpFAU9qWGCWSCIysDHUf9uaWU+k96ez2vY
	zBS+zQ20+adEzWMrM0uyxC3ipCy/v/6fWpudx9UsE/cRSIvbZWbcCE5h2sj8EiuYJKzUfUFhKtj
	daXw4zniv1/Yn9ygj0OFtQtecEz5dgjTRnabjxsxx9
X-Received: by 2002:a05:690c:f8f:b0:8b3:5f41:3c06 with SMTP id 00721157ae682-8b392b70ddemr3838797b3.18.1794262476763;
        Mon, 09 Nov 2026 14:14:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8b39338a0f4sm46887b3.23.2026.11.09.14.14.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 14:14:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso1726802c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794262475; x=1794867275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2la7If7oS8mGV9E9elp0qEy1slr4e68W5FdYtWr/CM=;
        b=ZaYbnyy6kadtq3xn0Knu0tWVKlADi3H1KOvvPZujx5l4i8hO9nj9/L5NnpaEoz7T2u
         QNxliIjePias9+ERexJDJM//pi4Fx56/R9FUYZaVZxZn46FIUv7TObsRFIW+Yz6O4/bi
         7nILuRtKJ/zcOW2u+rpH7zzT4I23RApGlWB78=
X-Forwarded-Encrypted: i=1; AL+hErFnYFx9es6RS9JPlYU56Mvc2SWdDkmjAxxjiimObhIB3QSCO0+ppIEtoqjuusZ6Bullh3t/WZI=@vger.kernel.org
X-Received: by 2002:a05:701b:4590:10b0:143:297c:276c with SMTP id a92af1059eb24-1b3b618ad61mr970035c88.33.1794262475387;
        Mon, 09 Nov 2026 14:14:35 -0800 (PST)
X-Received: by 2002:a05:701b:4590:10b0:143:297c:276c with SMTP id a92af1059eb24-1b3b618ad61mr969982c88.33.1794262474447;
        Mon, 09 Nov 2026 14:14:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b56c4e88sm1695896c88.0.2026.11.09.14.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 14:14:33 -0800 (PST)
Message-ID: <229e94bd-28ff-443f-9667-f8f304a2fb0c@broadcom.com>
Date: Mon, 9 Nov 2026 14:14:31 -0800
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
Subject: Re: [PATCH net v2 2/2] net: bcmgenet: flatten frames that cannot fit
 the ring
To: Nicolai Buchwitz <nb@tipi-net.de>, Doug Berger <opendmb@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109-nb-genet-txq-thld-net-v2-0-efd8f4be96f2@tipi-net.de>
 <20261109-nb-genet-txq-thld-net-v2-2-efd8f4be96f2@tipi-net.de>
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
In-Reply-To: <20261109-nb-genet-txq-thld-net-v2-2-efd8f4be96f2@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/9/26 13:53, Nicolai Buchwitz wrote:
> bcmgenet_xmit() wants one descriptor more than the frame needs. A 31
> fragment frame needs 32 descriptors, so it is refused on a 32 descriptor
> ring, even if the ring is empty.
> 
> As a result nothing is in flight which could wake the queue again. The
> watchdog can only hand the same frame back, therefore the queue stays
> stopped.
> 
> This needs CONFIG_MAX_SKB_FRAGS >= 31 and a sender which fragments that
> finely, for example MSG_ZEROCOPY.
> 
> Linearize those frames instead.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
