Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794010452;
	b=PRR/l6iC2CEw+HMTdYIlObZzL74Gc48T4YiVEZS8b29R1C+kjiK/1DFnulYkupSLsc8D
	 cU4BGuGFOQd3E2/4DGjmdjG4otxS9t+L9fe1Ra6bdJq1Gz5rFtJBBxjEZE12iLNUCIkdh
	 7MjK8CWE85fRU6MlegWl7ri1BskZRoXKW85oZ3BE33lP85azwq0xJHQeo3xLXs2NrYUnK
	 kEMvUNEumEqYnXugFfTwt0q/AmvHui7LDeNsiwlvKHFoMi7I6ZCgLdRkJvQXjEqEsh+TV
	 1eM0iaE3LmKDIHvfNoFU5t8R+ZbpOEu9R4pimtfBzRhYWfhHqZeN1RJ2OVAzNpLlgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794010452;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=q/U105SNNRyTR/n+MY44QFx9LoDHyERXeBVNElVmADQ=;
	b=USSCB+nsRGH+FKh0qQjFFq0RwAt671FJwy+k6b9w0e3fRAPZHGv1V7Xtegxuo8hQm5cA
	 t4wJKcNmAiTf+0nKU8EzGHr9tDHVlZNWnyQVDfa+xCvxsUxFZKYCn3M2Y3+iuMSgZvH7A
	 gxYhp199PCYi3vO4FKJtN0Q/LFn7xHKSQlH4/+T+pHqsqoAYmFDTXMEocm4gSW/eMs1Bj
	 bI4u5Bsy4qyBgXWeJhvsd7FWtYS5jDscdDf/OeHuFTNfJpeo7ePI6YM3cioeVHlfBD4Oa
	 micYxYmnbj6RkgqkBEkaYxR2u/g0nDQwvsdOeGzMVryoBOvEe1dxEb01E3zoostSFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Cs12vAGB;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51C606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 00:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE51C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Cs12vAGB
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-ccca948203aso528241a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794010451; x=1794615251;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q/U105SNNRyTR/n+MY44QFx9LoDHyERXeBVNElVmADQ=;
        b=YsuU1JdLDJCa852AWBurYkkeK3x1gaRxlmujsucfM6ePckRWN1iKTOXEPe1X4Gu7o7
         xZxt1Vgl7fyxGhxUNtOuKscM7AmCixzgkC6wj/o2BKZvS05bGjXZithw0nwZ9rYcWbDR
         W6yDHAdUbRso2P/vZE1kGL+Qc/onmTiSd4Y3wzl0ap+wuOZE5Rw5tdS8K1PQEyG6Bef+
         ABtRTieTTNaB5M64c6b4SALsZMrba+/Gyh9A8Syk9ie3vlaej12hYqP2UYGl5jpy0h3U
         qWUDg1Fa2UDU8BD1zRs9KG3ftYaDXht7+mZsnMdjqcU/Nl+i3x2JwqjVdR+bBr9mQ7/Z
         3MyQ==
X-Forwarded-Encrypted: i=1; AL+hErEokHeMHIJVQP/1vwkvAkBgiyRcmpe7pOaUTp3qELp+isT42Wdg0Hld8pLnW5VYSpVUBXAslG4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kqvnqns+IZRSJePPyNcdPvuKUE+HQropX+liDdIfl1RJzDevg
	klZThBJgmc5mA8xBjMMby0b1f0eN7moXgykhBmOsON2ue9hI/JdwZkDRCCCB1s3DyR5/S0IUJKU
	xalp9USyzDOyWoHwK0AI5DLlRNsSWWyVDvNyuDgI2xrwEoEdpWZNQNWrZAvEB+WZ4D/nZO7NRQr
	jNWd9e7Ll/3C2DoYXKQ5yEXPh6Lj2NEob3NGZxJWbIN5uRgSf8ukxJX75KwWdH1vII4gHZW34ix
	ShcnEXMxPpuZ8rQ
X-Gm-Gg: AYBFou3EiDynliLVMIjn9H5NZEnVVGGecblS325q6OF24L+Hdo2tYv8++shXCiJj+sn
	pI3Zhohz789i5fwYe8Za3Ug/qje7xKc3a7B6YeqPp7peCMVgawL/5JNSHEBPy4TRpVui6l9nJeH
	5TQekGUGz7DPt+4b6bHWG4qk42rBAKKtgzv5j9LuiS+mNTa4IQeb6ATw87+f4L1wCXcn2ayknPE
	5HtVG0fU1o+bulqJF1Y9xJaICxsqeSYHS1EBMWxJo+dtttBrgyoZ3ux/LYpVcWN6iKLjQ2Dsda0
	qWpKfPgEdrhfIS2QTgcaRooeWhMuFA2r2Fz4/YKNdh9ub8fOzeQ2OotPl/eoZk7VFjOUuhz+cwn
	6GuGdZObhM+wPHSjpWl8MfSI74zZuSOcZe7pQtkgIIsAC9f7WxECJcM2yinn/L1heZKHi/9yuxk
	Y6b3gMD3Jb9C2VJpYc1/06V1wfXF4E4FasTHyXSwJL
X-Received: by 2002:a17:90a:d647:b0:3ad:a232:4044 with SMTP id 98e67ed59e1d1-3b0db709158mr3469614a91.38.1794010451088;
        Fri, 06 Nov 2026 16:14:11 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0fc47d277sm343104a91.1.2026.11.06.16.14.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 16:14:11 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a71dd190b0so4131952c88.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794010449; x=1794615249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/U105SNNRyTR/n+MY44QFx9LoDHyERXeBVNElVmADQ=;
        b=Cs12vAGBXc6AiDJFlfq0P9GGtgmS1GukKeG/FRojDr5OxbPIcEu5oRYXvyOJP5LN4p
         8XCEk0RhNWKQJRrB9RQQJBlThtUJfuoJl3GEkS5c4SSVgtYzq8VMhLmuCfIANk5vGzwd
         Uh0zEMQAt8Pwqo8fBb/donyb1d66rBfk+OwhU=
X-Forwarded-Encrypted: i=1; AKwUvBw/Oohsile97Yh3AwTXt/ay3JrvrE3M5+nmjP695EwZEF/hfCJXuV0YG5F16Y9sugXof9ENHik=@vger.kernel.org
X-Received: by 2002:a05:7023:a86:b0:144:c127:dd1b with SMTP id a92af1059eb24-1b25d36f504mr6534742c88.39.1794010448939;
        Fri, 06 Nov 2026 16:14:08 -0800 (PST)
X-Received: by 2002:a05:7023:a86:b0:144:c127:dd1b with SMTP id a92af1059eb24-1b25d36f504mr6534696c88.39.1794010448086;
        Fri, 06 Nov 2026 16:14:08 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4fd2d6sm9201848c88.23.2026.11.06.16.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 16:14:07 -0800 (PST)
Message-ID: <1b33c10e-fa25-427a-92a6-d26669712f09@broadcom.com>
Date: Fri, 6 Nov 2026 16:14:05 -0800
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
Subject: Re: [PATCH net] net: bcmgenet: cap the Tx queue threshold at the ring
 size
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
References: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
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
In-Reply-To: <20261106-nb-genet-txq-thld-net-v1-1-53bbac647b71@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/6/2026 6:10 AM, Nicolai Buchwitz wrote:
> A Tx queue stops when MAX_SKB_FRAGS + 1 or fewer descriptors are free and
> wakes once there are more. Queues 1 to 4 hold 32 descriptors, so with
> CONFIG_MAX_SKB_FRAGS at 31 they would need 33 to wake. As a result the
> first packet stops the queue and it stays stopped:
> 
>    eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 3 timed out 2004 ms
>    eth0: NETDEV WATCHDOG: CPU: 1: transmit queue 4 timed out 2004 ms
> 
> On a Raspberry Pi CM4 only queue 0 carried traffic afterwards. The other
> four counted an error on nearly every packet.
> 
> Fix this and cap the threshold at what the ring can free.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Eventually we will have to decide what to do with those other queues :D
-- 
Florian

