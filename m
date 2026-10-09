Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8734D3A9
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571042; cv=none; b=q2uTjB7WrxELn1nKDCGEDx1skbFYsv/uVzYLm0YyFs4Agxbk7qG41Klc1TyhR+URaJ2iWpBAdyckSF2sZcCySUrxd0Y6cLfxtDQA8JqfLJUXBl7RrVHoGYWn6E6rE2/8BKIASBLUKiYkM/mK5pfKXifYLQcP4dknJEyyCrOSlQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571042; c=relaxed/simple;
	bh=BwV1w/kBdih+sU8YWUK9wf123zjS2iGLeow+Rttl59k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfe6+AkyeIZdvNHvqXroCSNohAs1Ly3sY+JmN1moYRlPXW8PA72irwYR/VRw/BaBW4ALCA5Q/wHFW9VFMgMcfiuwyljAhBaQDplmMzuFQNvSJqdeC4JqgmEhvPRvDYMEQs4GCs80wvUp2Q64xOQwm+8ucHZUYbno9X4PdiYnmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gFMTaIXl; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gFMTaIXl"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1232277a91.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571034; x=1792175834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7PADv+tCmNjIHUGxn6O6/3F4aFPIb1RdHXRti7uDfyo=;
        b=nEzsyZZQzMqzSzkt7XfWekjAfKipTPuJXvR7549auWTJsmSwemshPdLp/Ypyy2WHEh
         RVwEmQbepXnopsUjrvyj65X7/x8VuiJda4gCcA3awnAXxfgbA1WWK1+GgnY1mWhsSV2V
         +n7u41IKzGRsTBwklsEkFkMamx/w6s8nCcTqzLMMjqlQUr0lKOz7ni56P8wBM0LdSmCk
         z3miydaFcJm9j0IeYQk1B/dY33/LHmGk9FTjTUsbMPeUQjVqLjbUze+NpqVAAcY+Eoot
         u8Jkjh23QQn60uSNV+XcJCZJ2/DVqCevnPjyYga1cfgVM8MJuYboNhTJLIJSjh5vIkZw
         RPFg==
X-Forwarded-Encrypted: i=1; AKwUvBwlLgYUCmGoCQCRQRbCpcJRtMB18SQ6PXVAb+wR2ciBPZmRaxQo70nuhPn3NMobWhTRmId73ek=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyMeMjVPv3ug+e4DbLoFB1FLzqnDeLXoFURJZU1PFukV/Kn8fO
	oI383PphQo6BoDuG33pEw4HQpW5NducoC7Se2d+W3K8lLFarhP4IRkdned4rVwti6zCdzCZNqZG
	xs+k4nE4s6K3pw/NcLCLybDre0UCmwr5vCEf1LNTUErsAp4AJNn/dAuXwkeIKqfrF7u4Q8J9ZHV
	qqrsw6sxE1BTJ+D5xE2i9/S8UNkvw65sW1XJaC4jEkd0YWiTg0DfMf1QumGU1heQzom2n/Zv/jD
	+98Tuw9Lg==
X-Gm-Gg: AYBFou2GxS1mtN/kuWkXldZ0uJgERRMZEgu4mWictFjrEjegHxOSbd8zA25blNOF88L
	ZwIM4ImDkL/mL/dTd7s2jwMieAjdq7gk0B3WIijbRXCLKAA77U5uhThMmtEDxc0lUwdEl6MRtN9
	ce7vnTLnc6Po1Jya5mbfRAWpoKeZrP7bfc64nHLrGMHLTBbaIbU5gKWDY+5XPsIAzpyJ0MJJ9tD
	BzLMLUYxZEW5g4npf4cw2wdby4TxYlBLeAESFG2UGyziSAQ/QOE8F41ZJp9QbA5TevocZiY7dT5
	t3TL50jQ7ODFzFIREqwYCPl2byPsRHCJP0z/0ofB6aCh0QoaJLfGp+Urtyxh88F14JsS8cjlVP+
	r9WVLRUBi8qIw7Kb/NPzaanf+7UaWAHU+TdB3wcgaOBx6xPkJOyph7/vP7Vwy4Dk3ndRupPfyGV
	Scwdi5xDiuleOS9h/UwdpZKX72ykvTXoOdAEP/
X-Received: by 2002:a17:90b:52:b0:3a0:b430:946d with SMTP id 98e67ed59e1d1-3ab3ae6d43bmr2474065a91.64.1791571033746;
        Fri, 09 Oct 2026 11:37:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36def334sm1606383a91.5.2026.10.09.11.37.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:37:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so10714362a91.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791571032; x=1792175832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PADv+tCmNjIHUGxn6O6/3F4aFPIb1RdHXRti7uDfyo=;
        b=gFMTaIXlcOJyLqD1gEdSSPYgQZN+xDEm9zqu1hOs/KQ5zsjnKPc1nUvi3EQNXaIx9S
         hDxCVH3gMwSgvTY2+NyBqr52a8B0UMtL/jtjOJkPIZiAtRWKTQA8j3S0IozXA7sQik4t
         SipdNSaWOO6nUHRB0NzSaNEiDLpJugnf7zckU=
X-Forwarded-Encrypted: i=1; AKwUvBwvge/gLPuImkCxDxwQPxBzIKrxMGWRWFnR8bHI1VqIyu4CUohR7Jbe6KEWXyhD6JVAlTFQ7R0=@vger.kernel.org
X-Received: by 2002:a17:90b:57ce:b0:3a8:6d4d:fb94 with SMTP id 98e67ed59e1d1-3ab3ace92e4mr2584915a91.49.1791571032191;
        Fri, 09 Oct 2026 11:37:12 -0700 (PDT)
X-Received: by 2002:a17:90b:57ce:b0:3a8:6d4d:fb94 with SMTP id 98e67ed59e1d1-3ab3ace92e4mr2584892a91.49.1791571031716;
        Fri, 09 Oct 2026 11:37:11 -0700 (PDT)
Received: from [10.14.5.199] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38b9638fsm4388474a91.3.2026.10.09.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:37:11 -0700 (PDT)
Message-ID: <345e2bc8-8406-4d5d-a73d-e54a888c98f8@broadcom.com>
Date: Fri, 9 Oct 2026 11:37:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 6/6] net: bcmasp: fix network filter lookup and
 wake filter pair allocation
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-7-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261008210621.1374785-7-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/26 2:06 PM, Florian Fainelli wrote:
> In bcmasp_netfilt_get_init(), when looking up an existing filter (!init)
> for a specified location, if the filter at loc was not claimed, the
> previous loop continued searching higher indices and could return an
> arbitrary unrelated filter belonging to the port. This caused flow get or
> delete operations on an empty rule location to return or delete an
> unintended filter.
> 
> Fix this by checking only the requested location on lookup and rejecting
> RX_CLS_LOC_ANY when !init. In addition, harden wake filter allocation
> and release by ensuring wake filter pair searches stay on even boundaries
> where both entries are free, checking that loc + 1 is free for positioned
> wake filters, and validating parity and bounds on release.
> 
> Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Justin Chen <justin.chen@broadcom.com>
