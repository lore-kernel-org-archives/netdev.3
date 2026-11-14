Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794627590;
	b=WgkmLFrCuKii6gSFlobDodFwPsEU33HwWslOxp2VE7TJrHnNP+VXCa5AHN2KoQYR7WO4
	 ILJOyfLa6kHC7u0BaJQ7mr/1MZQmoyv6HszbJg6E8NOq0UXFN2kQyhvHA8snfRoyo6g1S
	 RvKPJWYtmVdoHEBGOxS1M8nKeWwIAUn/XWaIM8cLIRYXe1P9lMCoEg//gUlQbYvbdZQHH
	 qSJfGGwreLfMcxAZ3gqaORdvUCAl3pDAACOu7ojkXzs3m9hDcAaoRPYmSToxW543vzZhV
	 OHQumtPrI0VE1iYC5iedysWAAKjP5j3ua5lzowGBaXNcwVhJ2kmJRww3B+AbQ5Tb6pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794627590;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=4q+rNL4+kMH5WgLqhm6XoPTnEPb1gasQ3ZKASdNBy/w=;
	b=xuVoRUYJM3XpmA1DE2gdESoqTpwcCfwxGwcaIV4exfNfHp2kQupfvwsMxBYHbxfL98wl
	 haaBtir6b0P7i6WeexiZNw6TF0QCFVdAkZc9j7gEJZna6ZK6dRSEw1itAvpU88nM7B8IR
	 Ukan0Zyb4bMLSstRlzlh5REu8JFtoy4ycS/dfi2GMG8QdPp8fVhUZogEuLeYhLGoy/TMe
	 hvJ8AnwZzbgq/twwKX25iLpplyTgGwJ1jKdeU/WkdRSfKs4V1yT14v9HpqJpeBD/fzVwB
	 azp5Qk18Sdffz+XFXcp11CHCpn0EFd6do8rCcLXl8YBmEhv0Ym/UOl2BOeOyrvsrL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="SDFRs/j8";
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C8606A32E
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 03:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939C8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SDFRs/j8
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so926338a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794627589; x=1795232389;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4q+rNL4+kMH5WgLqhm6XoPTnEPb1gasQ3ZKASdNBy/w=;
        b=tmnOlpFO23KR01dJKIQ6qZVIkRjIaP9dVGGGO39KQ7pKtT6iykXDnP7mKPe3+UjViE
         GtHbatcMRpMBzyOxmze58KZdXxD1Pnq5foHTGAlg8ahFv9VbZVE9EeF+IJps1GlUjyCn
         LkSbJpyFonSXyiag/51P5ASZRhVeBOSsHwJBbZo919W7WMFBH6yHSGj3i5RHSunXxZJ4
         M7JrVbeVA3SNSdkCO0OJxJh8om8DPAtBjs0zJPom1eyI+zx8IDC3HQkRphDJXJ01hSo+
         TGBaSPE/m7vGXPeR/YMZCVmlH5fWU8ftYlGRkXnbgh/3d338mLuaUjviFf//kRjkf2+a
         QFlQ==
X-Forwarded-Encrypted: i=1; AL+hErFvFo4NuF37sUyJslsbaD8YDsXKtCPG5lm1I3BRwvDpw2cfJmV0XUZtSUMmuyMZJnVGsVjuQoE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wNQ/BDiOxHMjW5uxhd4dWnm2xR7p0d0e5Co1PKmWnsfsIEtPT
	F6GDsv16IyBYbtScZ8SVbmu9mExLQsUja9ZyV3DzvbaqyqG1HKkPWrhoUce0EQzheuppcD97OWL
	AYhdv4LqmrXSGHJmfoqkiogkalJTvIh/N84WkRAqXwKVqf8U4sutBQoOjPPx/+lSFyOX3RUA0Xq
	+EF5SRhYIPTjitbl7W/SpiEZj7IADNL2vNJxJXUmqSCRgZU/tjgXXTT3pnNy/QoYpChc2R8sHDc
	qQ+NCELiFvnx5zf
X-Gm-Gg: AYBFou2CsfcjtKoI0FOiumwbLa1tiiveFAFm/Hf4M0JS0r698rIRn7Lch6azU9i6+cN
	Lpw8Jom7xB7/Wu7Sw7JtredHpr6TSrVFhB5dT6yJf0/bAVYdTu+vwqIqM9JacjyMXDgrCpaTxA9
	CBMJIHvkROdNFpxY4Xbw6iOh2LhMxcTsSOnJsv09B5qRxvApYD7Xgc0st9tN36eXgbBhscFUcKn
	yG3XvY8eAhtbDY65wBOP92xoIwen2X0ym8KRuzPyDCH/fBDspNSCxFmL4J/xkjjz4qaPYFmDn1u
	RT0YhZpQPKpYvFYyk0ZGUtB97mWFBUlpBEnmhD71WJ9ahsaiv2hbo9dTdo56MnxqxAFJ0WZczaN
	EfmFPj8+KXd+kqVqNHSaKzVVVttxirHezmoLQTsvCAoH+O7cu4idg9hz/GKACYZoBuoZsHn+K+F
	ABDNxTB95LA8TzBLNak9hlUjBhngLbkajduzvVR8kEAhk=
X-Received: by 2002:a17:90b:2d44:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3b1b0b5c014mr2974046a91.10.1794627589025;
        Fri, 13 Nov 2026 19:39:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1b3c0a5a8sm2928598a91.2.2026.11.13.19.39.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 19:39:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so1221564eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794627586; x=1795232386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4q+rNL4+kMH5WgLqhm6XoPTnEPb1gasQ3ZKASdNBy/w=;
        b=SDFRs/j8g4/06YhWFLqs8QedRbXW2DtCqiGU7b62dfYehxGOBkoGNm0k1NhYXmxBwR
         Eyud54ZHdrV1F6CVpDOznznJ3vEHZ+0/7siXxTQdLJNUluOCCJ86hlai1MoVge1VcGcG
         s95ba3o4cFpRGrAM0uBLJQFQIip+xPkO1PpdQ=
X-Forwarded-Encrypted: i=1; AL+hErHgqcx1ckfcjZSpR3So9FPF7HBChszcjq3Y1ZFRFCjpM4QW75LVPJgZJ1fl53Xkm9kqyFqk6AQ=@vger.kernel.org
X-Received: by 2002:a05:693c:639a:20b0:36c:fdba:ee36 with SMTP id 5a478bee46e88-37966e3a566mr3720457eec.12.1794627585802;
        Fri, 13 Nov 2026 19:39:45 -0800 (PST)
X-Received: by 2002:a05:693c:639a:20b0:36c:fdba:ee36 with SMTP id 5a478bee46e88-37966e3a566mr3720422eec.12.1794627585050;
        Fri, 13 Nov 2026 19:39:45 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm12603206eec.23.2026.11.13.19.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 19:39:44 -0800 (PST)
Message-ID: <2e846fdb-32e9-4ba9-a6e7-ef67d24c4f8d@broadcom.com>
Date: Fri, 13 Nov 2026 19:39:42 -0800
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
Subject: Re: (subset) [PATCH 0/3] clk: bcm2835: describe the BCM2711 GISB
 clock for the GENET MDIO controller
To: Brian Masney <masneyb@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Stefan Wahren <wahrenst@gmx.net>, Phil Elwell <phil@raspberrypi.com>,
 netdev@vger.kernel.org, James Clark <jjc@jclark.com>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
 <179358503716.355577.9187303706042543606.b4-ty@b4>
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
In-Reply-To: <179358503716.355577.9187303706042543606.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/1/2026 6:03 PM, Brian Masney wrote:
> 
> On Tue, 20 Oct 2026 16:58:08 +0200, Nicolai Buchwitz wrote:
>> clk: bcm2835: describe the BCM2711 GISB clock for the GENET MDIO controller
>>
>> The timestamped MDIO write series [1] needs the reference clock the
>> GENET MDIO controller divides its MDC from. On BCM2711 that clock is
>> not described anywhere, so 5/5 of that series hardcodes 200 MHz behind
>> a compatible match, and mdio-bcm-unimac's clock-frequency handling
>> assumes the 250 MHz of the STB chips.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] dt-bindings: clock: bcm2835: add the BCM2711 GISB clock
>        https://git.kernel.org/clk/linux/c/af7994af5228
> [2/3] clk: bcm2835: register the BCM2711 GISB clock
>        https://git.kernel.org/clk/linux/c/ab94dbf30233

Brian, can you also take patch #3, or you would have create an immutable 
branch for me to pull from. Patch #3 depends upon the BCM2711_CLOCK_GISB 
constant being defined.

Thanks!
-- 
Florian

