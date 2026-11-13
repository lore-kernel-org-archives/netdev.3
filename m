Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608057;
	b=ZtZ9fKMGi2iSToelD9C54B2gB5V3NICX7eGZ+0cZr6i+F1kWtvuu9YfzHeL2Gw/8h7E3
	 xEmtoq4ttY3XoAErKB7xy20uQzkXbbkILybVRSauk9Hz8YiH064uKoxpwgJqSzibcElKY
	 LQi/inZV9Gawlwkca+HT2+C+JSzQ9ludH/Uw1R7++k4ibggO7drrUW0nUkSqF5mkuwnNc
	 e/hZCYRYO+fQV9JQmnXgKJu9QQ385MrXRrCSKrkZaxmkfWBeKyW5KAuzcRFPm5aCXgSj0
	 2XIuiJneFcXbOvrqg1epcIhlWF1pPFhYs2ioc7MSAljY3eHLVQFafdCd7/71JJ8/beQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608057;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ak2Wm9pxr1mRdtezE4lHs4tQ/HsTkmBnYFyE5Zyx9V4=;
	b=zE2B1pKQIAXO+DjtQuaPfI+CDveFwiVTS8Fguw0SQjivcKKfpeFSjIzL67xSO5uSujhU
	 GTo+TcEu1Sk9azouXUuhDaQvxjBA8uGoIgt+v/2sCgBH2ev8IUXhpTE21uNWINgs1oMiZ
	 QiYHKFQ6GHrseJKYIIFq8z1D4pKAH9RIyy/gkN6iFTtTkr3XLIoflye6ThK3+5W2tJCMY
	 Yym7EpJw8Epm2Yj/qSgz/BIb75j7pBg/aUnhID5J9XDf5VTsd9h2kXGKmKYsM9DIsd1sJ
	 USsTMoaPI8VCmy3iE6LFcsJztyfKOlKS/7DBdvo/ysrxdXcHgcxNW7IfuflmHb7QoMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cNZak7ic;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DC606A8BE
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3DC606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cNZak7ic
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1849658a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608056; x=1795212856;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ak2Wm9pxr1mRdtezE4lHs4tQ/HsTkmBnYFyE5Zyx9V4=;
        b=A4oznySZaksKUDElyJGV/UvOUQopyQ6aEYJ3Jb/CiowJhATNA2bBwHXnmfkkVFeB2b
         LsF/aqumBsdAaDD59+clEBb1Ot3uYknpJ2cp579HzzVD/GNLRy82RGV2yZijbTj0s079
         aIIV7QMtjHK/vJ+g75+oAjR0sxBNNEji7p305p1EDt/dBrUM1DqQQEsSKwIulcb5VvBG
         U7m6pQRKwCs0AZUzc6UfXmtKyj1WgJ2kLxZ44IPRD5bfmDeNizRVZrJf/ty1koqghUKf
         Mcq+z/NHtsATy8MlW3nGNwHOrIQBz8MipDJQHfVTDcLlFAI6NbVHs1sud3LfG6q+AYgL
         VpdQ==
X-Gm-Message-State: APuU4Z+aoj0psdT1tN+NJAi2zaIldmG/YJI86KWs2nfm3VYHDUaEytK2
	QPr8L8nD6SXhmZceN5G1eN09sr0fXgIKEDvb4uFrqjb/d4ieltutnVhLAcEhyV4Dw7MrJxXqwI0
	dPoKmmA4OLZ5M/7wsEk/1Q19b9CAIfxkQEQqtGccGEGjXIV2A0YNglU14T8ye3KalDpxPN/YVjc
	vJiwXFg4ERKQ3NsLdqupiPUt+lUCbzmPjgFTtu1ZRHfeKM8JdYlXJ3qzqxlEfRSTyg63FZ6LVIm
	+iUUxaUQTWavH0m
X-Gm-Gg: AYBFou2p+CDL8feG/qA2+KYJhh0xWlpUwoydkZhpLB25/Hx7es7RD7cn2TRlEnE8cVy
	LPP0kWloqnW+FYkpoXawFYtNd9/QupmHNi0tEghpMDmSpigJvusiPBoO0osvSl2iZH1guQutfMC
	qrdgzeGcKP+Ukb8C4cPKyWUZXqkJnf06x9fQj4EQSrRxADVnbF04zRKnXjJbrNZ1xJqkumNaaru
	H5S8SQyndM5dzvoCzYTo5NcjV7Rn+dnMBnBKdvUOdbTM3ufzV6a4PIOfixdUhWQTYMiPQEBgZdL
	V/m2MbbFz42vhhaekR+WSkD5JaVnU0zARfBgil0Lpgqk5NJEQpoWm64lm0YZ7n559+hzMwgTrrV
	g/8/UyBawOhegmw8KrlK8LHFYidiec59Wb0JvoT45NSzocFmOCr1eL9a7yBNg48eXyyVakpWTaA
	5POlAkNCOS9e8SLWyVFatAr3jU1uKFIyeZlbTSBwx73wc=
X-Received: by 2002:a17:90b:2d88:b0:3ab:36c4:b502 with SMTP id 98e67ed59e1d1-3b1b0ba38d1mr3762439a91.30.1794608056296;
        Fri, 13 Nov 2026 14:14:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b2188ff4sm1467184a91.0.2026.11.13.14.14.15
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:14:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5363b06bcb2so31779041cf.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794608055; x=1795212855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ak2Wm9pxr1mRdtezE4lHs4tQ/HsTkmBnYFyE5Zyx9V4=;
        b=cNZak7icpEAkVysJyZvhYXzuHvmiFnuIpE/HIhJ0tyrfN/avaOQeIYBCaM5fs+YHli
         25WKSkJvXzxbc5iWmV+Ny1N1gNkOAZR5Q0wNo36U1rwoau/uzrBEU147GVrjOu6pzPL1
         eu2FuMGKkNPW+8wXnh+Z/LMhNzFf86LXojpoU=
X-Received: by 2002:a05:622a:4d4d:b0:537:c478:70e6 with SMTP id d75a77b69052e-55ac755d4d2mr59848911cf.36.1794608054981;
        Fri, 13 Nov 2026 14:14:14 -0800 (PST)
X-Received: by 2002:a05:622a:4d4d:b0:537:c478:70e6 with SMTP id d75a77b69052e-55ac755d4d2mr59848581cf.36.1794608054560;
        Fri, 13 Nov 2026 14:14:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad14f1ecasm27491251cf.24.2026.11.13.14.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:14:14 -0800 (PST)
Message-ID: <98b20b6e-8268-4295-975b-8a290c00de23@broadcom.com>
Date: Fri, 13 Nov 2026 14:14:11 -0800
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
Subject: Re: [PATCH net-next 3/3] net: mdio: mdio-bcm-unimac: Add Clause 45
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Carlos Soto <carlos.soto@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>, Doug Berger <opendmb@gmail.com>,
 Nicolai Buchwitz <nb@tipi-net.de>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>,
 Mlody12 mlody12 <kudzo51@gmail.com>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
 <20261113211554.2058181-4-florian.fainelli@broadcom.com>
 <e4f0d156-a7ef-48d6-a034-955e01ef90a6@lunn.ch>
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
In-Reply-To: <e4f0d156-a7ef-48d6-a034-955e01ef90a6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/13/26 14:04, Andrew Lunn wrote:
>> +static void unimac_mdio_set_clause(struct unimac_mdio_priv *priv, bool is_c45)
>> +{
>> +	u32 cfg = unimac_mdio_readl(priv, MDIO_CFG);
>> +	u32 new_cfg = cfg;
>> +
>> +	if (is_c45)
>> +		new_cfg &= ~MDIO_C22;
>> +	else
>> +		new_cfg |= MDIO_C22;
>> +
>> +	if (new_cfg != cfg)
>> +		unimac_mdio_writel(priv, new_cfg, MDIO_CFG);
> 
> Is the write expensive? The bus is not faster, so is this optimisation
> even noticeable?

It's not really noticeable, with the firmware images that we have it 
saves roughly 30ms per firmware load per PHY, but it's a cheap 
optimization to carry, so I don't see why not?
-- 
Florian
