Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510812;
	b=Kd2TTqfF6hMWLABae3dae9ePBcXAouSEpxAnabVeOt65qxg4Y9uOcH13Ik20rpUHCFAd
	 aEyBffeYLdOknsNX8UOwjEwM9pC0c/XLt87yEXO88csxT2dPhT6H5qDg701Nf+m/GfEve
	 7SQEwhfMMocotGzxwOQVIzo+LLdiBcdmZSLd4i6DNTX8H4UuTj7C2wlUkxwb5KhsBWY0L
	 LDBMiRKzRCjY/Jfzs5d8ZPAULedOgW6merLz5oUfD2vP/c9hqEM/bW6+/uMChclSKA2E+
	 tVVxi5KONYJemFlxBEd0C1WM5h/c4iD72nvl/zTnOhXzvPJnnQPeFIaZQcI/ZgvlQvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510812;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=t5WjqSdg7bDbQWoXup3QhnjevPSo+9ekUEMkZZRcrjI=;
	b=MHdfDyoBt/2DAkjHatkSRaqKJHorwghoW1POxQAa9g2DzEu+DmzLLY2xX0ptYPcTeKJW
	 fAMNxubMytIinCXFh5YGjQdjNXBy9KxKm1MM8h5l0zioe2s6ODUZjButlJIXh57ip+q2i
	 WjoTHV4c727n95fUASNSnlupxk21eqIqsEIq6mWCAKoPRK7+1zWjl/YaKeysty0yoKgWJ
	 TPnSHaX6v3iN+raPqutsBkHMfI0SyoYaMfPk+UG9Lq6FYvk5Lf7eiPUokeyoC/T6Jl1LD
	 uhrBrd69wx6+qKtlb2N80CGuYrTVdNM4/Civ6TA6H2grabwosieFT4f1YnPZhoLuPkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aah81HL6;
	arc=none smtp.remote-ip=209.85.216.97
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A2606A325
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C4A2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aah81HL6
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so540821a91.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510812; x=1793115612;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t5WjqSdg7bDbQWoXup3QhnjevPSo+9ekUEMkZZRcrjI=;
        b=jaIbVG1Dt7JHBz4lej2VHw4CIyrzoA7HbFCeGYSgbuAb1UUNALrvm1AXMV/8PJRMvQ
         WHrBj6YnAzhZV7By4pknGoPm3U+QH29Eve6sCuLsznjRTeqc5ECzaVZn7xfCCDrxJ2Pi
         hyCNV1nUob7nzeyqly1+Kfrd3mshCQ/kLoCsaz5txxz+9jAMVrYY9KgMFAxJuXGFEhDG
         1BWrWm/hau4ic6wsqtEhFcBaDUyW5zLGuQwpPMqrcO1/9TOxgX8QEy0zCjmEd0iPmUzG
         6hbi8p6vRmjQn6COX+1cTESRLrLds9CnW/YOUZyYMOBf3Pals9FCEgPGfpKus3KiEDcp
         ChQw==
X-Forwarded-Encrypted: i=1; AKwUvBwDZSfYEiNa/KZkOkcw61qKFc2T74F5XtL95QHoyA7Sq3e2cdQk/4fylr/ItXmomaQP5FdsAKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJS3FuGjao/5/9WWT4kGWv51b+z9lHhT8omegewnuRCPKQcl4jm
	Ew08voBvALXi0TKJwJKIY5HDVcnZOzL1fQqKX/CJfovUpDTkup4HzgutJT0osQiKBKIcPbFqeJl
	0FKPD9R3QlnTQ91cDwIDN5Ep9ri55n7KjhaOHm7bWcG7rwI7TgNnyfupiHs5iZAJsPcU6OUwC7s
	jOkj3ER4WX8YSqq3iKUlmYPxFqL/RLvU0pvSg+76/PMI+RAZn2KczgC3AI2weerQ4cTY/5Vs+zS
	NkbRy0ZAs2113XN
X-Gm-Gg: AYBFou2p9YZMPoqUJzIfuGs8C/l36fpzD0yBE+PGb7gfCbsEtSIdR3U7k7QC4gA6wN3
	/0QQhuuOw3wPPVOzr5z/IOoGxN84Pz/lLkRjzFsOumPVAGS/KfWQEmLO1mR/I4hYy4eTgC3Y8Ob
	tyqUIZDQOEJUhC237fG4jAhDvCHlDgJRxjQ3axSqqKTX1ZaAqLZ0h3o+/T0/3wDA0/waaUqbePT
	PGltolniNQzIc2wE/n17eRu/rE4ztvBfr73P4n4+U+ZaauH2XKxi7HZ3rIlGnHlLgPFI2PkMQFz
	mE6mUNIfBtuMNMJcrOVHo3GUuDVwejaO0Kjaf6if3tKQ8Q7peLUuPOfcoT6tdQ0r3qlbqg6F6sC
	+bF9dmx6T1B5aSaYWoL1BTcK/lquxtqkV2CCXcnofagdSD9P9dlQIAK2r/ZYo1auOxqr8oZSh3G
	WIkpQLo9oEhXJV5NNDTLY4wdC4jCyzkWR45RwrUie9
X-Received: by 2002:a17:90a:ec84:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3ad64ce951bmr1637707a91.41.1792510811600;
        Tue, 20 Oct 2026 08:40:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad7ffb7993sm90793a91.1.2026.10.20.08.40.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:40:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9179a2035a4so16408926d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792510810; x=1793115610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5WjqSdg7bDbQWoXup3QhnjevPSo+9ekUEMkZZRcrjI=;
        b=aah81HL6gRqNXvrP5L7v6k5a+60qbmtQH03lk76ig8ZV9PVTj9aAnIIOxAMiAoXX2r
         Cq5Tca3pH1IhRpKTnSZiQSwfGeoRjVwrV30Wc/+8hlGstmMEsS4s1cUqGQiSjd38qH6N
         wFqdTQEXP10z3j1lhSmZVQLldfCr4BJWVXIP8=
X-Forwarded-Encrypted: i=1; AKwUvBzCMRk2N7w92/w6eJPBedPfOYZrA95HkHdOV8cPzTS/5zzLvRFogm3zJCbl0SG//KwXtJ9gcj8=@vger.kernel.org
X-Received: by 2002:a05:622a:4c11:b0:535:b545:e926 with SMTP id d75a77b69052e-53686f3793fmr33774791cf.27.1792510810378;
        Tue, 20 Oct 2026 08:40:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4c11:b0:535:b545:e926 with SMTP id d75a77b69052e-53686f3793fmr33774211cf.27.1792510809945;
        Tue, 20 Oct 2026 08:40:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5364de4d690sm92439221cf.3.2026.10.20.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:40:08 -0700 (PDT)
Message-ID: <6125aa53-4fad-46ed-b627-e0fce7df7b84@broadcom.com>
Date: Tue, 20 Oct 2026 08:40:05 -0700
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
Subject: Re: [PATCH 3/3] ARM: dts: bcm2711: give the GENET MDIO controller its
 clock
To: Nicolai Buchwitz <nb@tipi-net.de>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Stefan Wahren <wahrenst@gmx.net>, Phil Elwell <phil@raspberrypi.com>,
 netdev@vger.kernel.org, James Clark <jjc@jclark.com>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
 <20261020-devel-bcm2711-gisb-clk-v1-3-a1728724d0f8@tipi-net.de>
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
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-3-a1728724d0f8@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/20/26 07:58, Nicolai Buchwitz wrote:
> The MDC of the GENET MDIO controller comes from the GISB clock.
> Describe it, so mdio-bcm-unimac can get the real 200 MHz from
> clk_get_rate() instead of assuming the 250 MHz of the STB chips, and
> can put bounds on when an MDIO write completes for PTP.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
