Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85043344DA0
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113777; cv=none; b=EGK67TWt06KKfU6a9Ym3ZqSbGkPUa0kDz20tGHOw3V759+ZmOo7RgC7d+0WH8o0fWcDJXSeJNii2+VwP/WiYa+bFguau+0zQ7Ogzm5vd4DtSDSDbBnxFQ4DRjqju6KeFQt8uia+J/uyQRJd0RpBGECZXc4WCFrD4QC34kyMfoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113777; c=relaxed/simple;
	bh=I8p8NLZ7n0a0ZhYIcf5U8sfTtsYgcEG5Gh+8jJ14UE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctI4VwH0WQMi9bdDE4tdh8342ZtIz9PxjWta0k5VYrw537Y2AzeYs2uzSv1Z/85NmVMKDtVRszOEz8q/+K6O6gpFTS3oY+TeNLNCfOOS5vW6nVtutCFHGxMRn4opyD+kXq+4YiEgwQEwf2nTKIb2R1UathvP3Dp4PVonvRhML5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d2oSGTRe; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d2oSGTRe"
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc515912c17so80343a12.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790113763; x=1790718563;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D5fNDU55mUorFuQpr3GUhF5FUnjGuiiBubGQRo004z4=;
        b=tW4g95DwWaqhqHlntv6tn8AoZbhuaZiCdQI4KmyW5TJVnNT/dg0VK8fTdkwToQG5qd
         6Z+pOBYrRvjDOlTlnYHcOv1knRLFZUHgkkzRutJ5TLf07cBvxxYeoK/o9djng9SC+A1D
         FTLdNhJILJqerBmsSGRPoaknbuIuNHQw4VefPtpVKY4zrH8AbscwDz2mnWvSFjGbUo/Y
         N9j/2SsfCzn8BAIsm5Hqo5tbm673j+hPbX6Bz4nOFPmR3BBbkObaZp49KPeY9mLhmkGt
         ZZVRLL10VBu711j2xYg3dkvShjGm/W5SHDqTifcuf7edCcN3y0rxCzzEJN4QhrJZYGxk
         5thA==
X-Forwarded-Encrypted: i=1; AKwUvBzfSH8LUp/u4U71B8H6M1PqlRxUIrRd+XU9ht0q6NlnqVG17GleiZJXlZxbAtBDcadzpYRwWWk=@vger.kernel.org
X-Gm-Message-State: AFuF++nWS2q2q2gkRrjeBDAOlLWV3bndG8FXpSYdPD3bGvuFEeUD0K2A
	uGc2BeBqbQcNXuNt7QBTHpOtJc2eAAlK19ES4dghQ3TLQ6kxdBIcNsAqiBlvVoYXntIo6IpJtzI
	Am92ZAvQvFZdh+mP3hP8C+Pw4bcl9f2vBAe4mt+cRRuljV2AQUxFphpgC6zLZ6GMu9w+2iBETCU
	jIrce72EIsTp0dAPJUM3R1WD/3iTSC1y1t+S9lGCo4mnxxGSUYkHpe39KaW8Vp4vpzps5AlqTqq
	h2j9LwCj/dBjyMG
X-Gm-Gg: AYBFou0vlNsAZJlRd7Ow3MvCnTNyStIcVRmD3VEqosZJiAB6q2oGVY6ohmO7URqyRgN
	CZmPpVy38PRczCjCFPxmirueRHaVboD9BmQntwbZ4fSw4oPfEdjAyszeN6FIt8a1r/i5jZB78XE
	VIq/OWlZT7pIgMZkWbBy0m+VY43nnrbyt6HT9beW0FZfXJzUW6ebCR860Vw4pW+VNSM6p1/Dgzl
	++FZF0xxw9dL5nmk35wHMTmfYmbziasZWPLKyukRV2Fx3iVcKjsYdlx0NHY1g8zJhPh9sJ0daG1
	RDO9xuTAgknIGvlVrw8yvcpvW6/CfvH7G0qY+FYiLL77jl37Q56ntU1vDxIf8Z6pO+O6kTbqOWl
	Rvm5s8ULfGaptjpKqpzfNXYD7VooWk2hAEoa4PKMI3Qf5myerhfKQgAm+K2Wbe0MzlcqM5RGlmo
	U7Mz7OewllgmOlanmOXBIXZamfziNymke6Cg5DDvs4
X-Received: by 2002:a05:6a20:72ac:b0:3dd:a197:cf2e with SMTP id adf61e73a8af0-3ddf82dd848mr710911637.82.1790113763258;
        Tue, 22 Sep 2026 14:49:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-87d2026cc10sm397252b3a.4.2026.09.22.14.49.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2026 14:49:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32861f5448cso821859eec.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790113761; x=1790718561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D5fNDU55mUorFuQpr3GUhF5FUnjGuiiBubGQRo004z4=;
        b=d2oSGTReXSmrYvwTXs0LsaZtCQMZMz+4f0Zx34blYDOGbo9BLA0tguiOOdgj/zPikb
         veHjw6gW/ly2bgQ4pn+BwU5h4cDoDMHzAQTfSQoYUebbCuxZMjbq+DN3FnoXlgdD5z6r
         7+/1dHm1iZn84t9fOnGXtrZtRjkseGS5iIbmE=
X-Forwarded-Encrypted: i=1; AKwUvBw6+SFi04wJ0vscBE5+3ykxHGrKhjfIbYJuHj4oe24I1gB9r32DCOaZpY9cWufm6UWI9Hqtuhk=@vger.kernel.org
X-Received: by 2002:a05:7301:2697:b0:338:5c05:2027 with SMTP id 5a478bee46e88-33e8b88cc55mr663629eec.2.1790113761602;
        Tue, 22 Sep 2026 14:49:21 -0700 (PDT)
X-Received: by 2002:a05:7301:2697:b0:338:5c05:2027 with SMTP id 5a478bee46e88-33e8b88cc55mr663596eec.2.1790113760933;
        Tue, 22 Sep 2026 14:49:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm1124428eec.4.2026.09.22.14.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 14:49:20 -0700 (PDT)
Message-ID: <d2fc46b1-b13f-4bda-a727-5099061f9b58@broadcom.com>
Date: Tue, 22 Sep 2026 14:49:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/5] net: dsa: pass PHY flags when
 connecting shared ports
To: Yongzhao Chen <yongzhao.derek@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, ansuelsmth@gmail.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, jonas.gorski@gmail.com,
 woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, hzyitc@outlook.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
 <20260922202653.1153-2-yongzhao.derek@gmail.com>
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
In-Reply-To: <20260922202653.1153-2-yongzhao.derek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/22/26 13:26, Yongzhao Chen wrote:
> DSA calls get_phy_flags() for user ports, but passes zero when connecting
> CPU or DSA port PHYs. Pass the callback result before PHY initialization
> for shared ports too. Drivers without the callback still pass zero.
> 
> Keep bcm_sf2 and ksz88xx shared-port flags at zero, preserving their
> existing behavior. Document the extended callback scope.
> 
> This lets qca8k pass revision information and a SmartSpeed quirk to an
> internal PHY used as a CPU link. The remaining patches supply that user.
> 
> Assisted-by: LLM
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
