Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672302;
	b=PanL5NWCaYfK+xjxMavkcu/P6hmxvNnYy0RKfmzbmX2tus6jUPGtzLOP/F/jJwr/CA7N
	 zymn2i5LJU5XbejhYGl3ijQYb/jO5f/OGEZXohJx+vY2aOYCwbVh3D6WBnyAQG1xmchkw
	 NRdmJfBk7RFTqXqjpGqrV3R7tr6oBLCuE3gkTwQ+/ntbXbrwSbm91jHaIaA0fFLtc3dZl
	 quXc9pFsGvSgeOToychxoITTslI35S6PYsAmgUgNmnLA3P7ngymhYODusB1fUIrb+qpox
	 8+duB6MSkOGPIqITLFxC3NtVguSigTt1zfnMuaDECKSCd3F9ocnMFauVu+q2647VzFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mz4/hi2WNPAXh0HU7Nfb6rMI+2D9TUKroQYNpklEqeE=;
	b=b3biYxdoW/rdaWU8ttVNYFpTAr6c5uTvueLHomkH+HsNe24kZo0PEwkC4e5HSpWz16vJ
	 4gfyafzVPp+D/yhvwNhyqPcd/PYvCFPuLVxT40mAC0lHuaZRxPfdRzAxMou5cM6S6MqQ3
	 jpWm8TBSsstoCHr8sVitUc+TsYpsr2iRH2jhHEJdKwzoTAOIQvMNR2wcYQF4J/sPlilLH
	 KFJQzZZk5gUJcCe1UUlWkfWzt2ZEGOZTg8glDfsNU3O0avsJUQ6WZfdSv2faF2ZKwFBd6
	 ZwY6bUSmOQX2Tu6mOMw2aBZuqY7SDaAUKhj6PHFdKopAXo3LUOKzn0q79gvpx/70+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PnDHiuEE;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889E606A31B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1889E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PnDHiuEE
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20edd106so1228608f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792672300; x=1793277100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mz4/hi2WNPAXh0HU7Nfb6rMI+2D9TUKroQYNpklEqeE=;
        b=PnDHiuEEmcseEI/q7ujkH8xQerWkkFUITzE3FCwfLaKSnF3/MQP8JsLtzUVIkn8LdG
         h89TXk0eGdMmRcdGJTjLmNLN5CsJZRU+pr5bRjLuSxGMuY1TLj6M/5ELnkpc2GryPY66
         obYPAdTf4wRez6Wsm/oJ36K2RXxfvTZWDzRViFOqTHJBgL0KIm2HdXHp8CkVqvzsIjBS
         UE+erygC1ihyjbSg3ETnuTDifcZx8wWzzGUP+fF2+eORGHJH+Rn6EQcgfpNdp5sgIm5w
         IyQWqg3bOhRUOuN1kPqMs+VjxQIRYqhEjRHvtCOzRLBrWiWhSnHpB2rKyxX2oYX4in7e
         puMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672300; x=1793277100;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mz4/hi2WNPAXh0HU7Nfb6rMI+2D9TUKroQYNpklEqeE=;
        b=DPomQetQBQQFu/GJ1RHjBW3zanteFWq9ZE3gniQ35IsSeY6X6ubcWTsYBLzOSfI/Ub
         I7j3GDpuBwax2IKuZMf6F71yVbJ3z1hel/inOEHhQqAS/Msr9w0sGk+nATqbuoxKZw0M
         4V+EohgDONh0MYAop6fwn8lBRIE/DuwG0ZtXb5D8v9Dsi5ernW2D1FZwRwDZkfX1t3MG
         vg8rH9KDPXqyUCptw9W8cA6WMpfYlU+5p8EahksYJ6Vpu9ybCpEJjzRA+MOtJBApcgBE
         hHnionLy+/TsLGoBky9Ia09eCX01LFEjkdOewwfbiRsYC1Dc3ksNpxFkdZIqfRY5RqfP
         BG0A==
X-Gm-Message-State: AFq9FYJiVqbqwQAsCYWUmjq6vl/T1+gKae/hIz98dYzMe/6zztqncw2w
	GiKhZ+ZU7uG85KEgmrfhX7//bJ5FUnrIzDuPyrnUMsR0yD5zxKTuXf9eAObJ7cI/ZwGuSybEZgZ
	zQ6XOUxi8x3pHaQfkzoMPCeotV4Do9k/2ow/j8IlgSEVBXS8sAS0=
X-Gm-Gg: AYBFou0fb3QZ5VppmLZ2iaS1Jxa0ojbdz6pZO6k+HdepHLN8C9zHcLtj0plq83v1Rra
	44mLX2VdIes+gp3c7W5aA9Ta6gmjV5XLJKKPhvdWwrvMyFAO5xc35AmIOlXr/GZq8g2zFumTqin
	D+lb9xUzDIJ9Rc2WoaBiB3QjnNeJDK2M2s9k0LXgULu91+QHKANLgNQI/fhTxb2v2xEBh73dqw3
	/YQxSgcCsCHeBACIdIEjX/qWgvkFSc9Sp/V7ecmGL/dpNxvl4Fr5fNjBjDG1awK1ragxo2AyJXA
	ZO7D9MMd38gYJVlvMnMgE/nUQFUluGqqlXMw3PFhldBYurnC3bNsA/Ibw/Gj94Zc7SzEm4nNqOk
	TjHXnJnSHPToWNzWvQYcn6kzJV+MGk9FnmUsYWUxFiXEocITU/NaXyRlzkZgkO4HYjqHrbGDKg/
	y3oaB6fgYtUrcva4Av8PYdXJ9O3flrolKmrmCFtidef1t9Z5Cst1pORvJLqvwTbVphKF979Mp+E
	LWGh85FVPbaqYKff1025jPeqrRp+H4a2G3TikpsQqRYdKz8/DRXi2czyBAhO2wjnNCd2frXZIUw
	NTQV6/VcK8twpYYE/g==
X-Received: by 2002:a05:6000:41d2:b0:48b:4c8:7b07 with SMTP id ffacd0b85a97d-48e264e28b3mr10759766f8f.52.1792672300279;
        Thu, 22 Oct 2026 05:31:40 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:71ff:127a:8891:d8cc? ([2001:67c:2fbc:1:71ff:127a:8891:d8cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e2esm11859411f8f.30.2026.10.22.05.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:31:39 -0700 (PDT)
Message-ID: <2f0486ca-7570-4210-87f5-3b1e939fa649@openvpn.net>
Date: Thu, 22 Oct 2026 14:31:38 +0200
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
Subject: Re: [PATCH net 1/7] ovpn: avoid sending UDP packets with source port
 0
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
References: <20261022121606.732029-1-antonio@openvpn.net>
 <20261022121606.732029-2-antonio@openvpn.net>
 <179267180279.3290.16441907746812616677@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
 ifS0+hzvnPVD9wXa9kdjO+0H
Organization: OpenVPN Inc.
In-Reply-To: <179267180279.3290.16441907746812616677@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2026 14:23, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.

Patches 1 to 6 are fixes for pre-existing issues reported by Sashiko 
some time ago, that we confirmed after code analysis.

They are "theoretical" because OpenVPN in userspace is not hitting these 
bugs and we have not witnessed these issues in production, but other 
software may.

Patch 7 is fixing a crash in the selftests binary that we actually hit.


Regards,

> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

-- 
Antonio Quartulli
OpenVPN Inc.

