Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133030;
	b=4DVFCq8tztXoU8X9ACn9icigi0ck3d1pBD1l6p/f1QSUeUFLMenunyL0UeZ+qKd+8UdU
	 F5y+qKCpmTVb38eQoxIf0CXc/rsOjDDYWtWo1S+r7wkJGx6M171OAILPrb1/IzlaqI+xs
	 e8RcKc1HtnCqwCeOXBa+0AOtwGlwYmGz7iJaHs2PGpZtIASPviU0vBjXCEKw7VuEFLOUO
	 D8tFKMZpfsXRg42hMUZ91Ef/x8GQrIQdT+GH9vdtD6A8KWNhojMy7Pv6ZMmp48NuniqI8
	 /NvCzv3l2b2T3RbfsLOLYpT4v4nFkEZdfiUVrGRxB/rWTUx9n+xaalKR1daOnnDfebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133030;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=w74HKg/oDTjmjEJFvFMQJp2IljljHah9hQnQWOM3p64=;
	b=QseAgyeollWbVNJpRYOqYTKPi7TWWpeIRcXmu8vr5+HKqqIs0qN0eKj+lpyIQxsceEwP
	 AwKNmAREs2QPTA3GBmwjVMDPaiVN8g+9Q8nPTfVmP0YtjWehT7QM/WPGSSFkHSbXCa/J6
	 8LXNOobzEzuvisp0JHOwlayDipXwKGYhoddw0SqgVCJyuwfhCWzDbRtXilai21lZIVrRl
	 DRK3DfBS4Bf00eymnQwAF4qpChYB0QuomHk3oj3mlpAnTzfYIvfv71B6aCrbC1gC6z8Xe
	 xdFWHvTBGlurfxcNgT3SXJ/odpWURwzlMX5DRBIwmFmXntHkCawBoHRWXhPJpKq0iXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ARUEyRAE;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7323606A31E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7323606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ARUEyRAE
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93efc0452b5so15642685a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793133029; x=1793737829;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w74HKg/oDTjmjEJFvFMQJp2IljljHah9hQnQWOM3p64=;
        b=JrXbXd3yQlgF9BsJVnoQ7ns6tGN6RqMV+vkWO73SJDN3Nu0boyFjQT+HroCcLdl6FF
         lbnBrxea2X+lgoWGRxgKWAS4gXxJ3Sji3lgjnmTHAhEiEvdpIKC4fbNw1dXE/DaURkfT
         NwMQFhHoavfSpnodxmdcbaCax1ipFE4Ku4sJfCyFNx311jmN3/LvHj/AXN9+I/B3pfpb
         ALzoKCvrlI4Af8mIBJgT4EquczE0BSCO6lbBtv1BdgU+E4dK6SqOUIbIHDWRkdBiVoE/
         3pAMwPNUu5SYQ9sx0exHyL2ME36qraP2t6gh9wZqDXnlhnljliKZTimTSMjRO1i53RZM
         caPg==
X-Gm-Message-State: AFq9FYI5JW4k6/8S5K+aXo91M1+XJhFk7FvCZiXY3g6ilt97TUI65Qfh
	q/uNLZrBQjBqzLyYkh04GW/tnOGM6+4KeZQRlKJREiq9ayS6m23W8nwjH0/gictN0HB9RPauKw6
	yWMb68GtSSS6j380FNZRTfhduYJWJ5cYvfpXBRtRQu7DlS1lQpoluEUGIWqDGX5xGAkxlhB1Qqu
	5InnRaufHO6YpX9pQlecAN4PVpdg1GjL57BpQn3JDOiMl6wvG2tlhwRf6xrT1HB4yy3FO/oq3r3
	xSVdCoPAFsKfZK72NA=
X-Gm-Gg: AYBFou28qIe8sg0GMpX6OH3k9TaqyAaxsSzZ5YscAcwh6GRJnQsFt4O4Xaa2j4zbMgM
	H3HtvLrzNNyvVxFNRs5kLVXgwgIAWVUdEvdCDP2fpnTrAq9Cw2RmTq49ywT+GO7Ac4fXgsGp6Gu
	qld+hhs6nMqSHr9k5rc94vO10cHxyoa2yLzr9DMKXWE+hUAGtctdBzUEKH5VW+rMn/QDkKdnt0h
	PpkAx7ZSOEmgAphibaFzmA+sJVOsnWMWrSAnMU2gr2wwoNrWR5d2XYW4HeSfenZN06oJSFLAaJg
	I5/mnQMsiejrFHaJps95OhuXZ/5WO+BSUhFZwrhu8TMZQMrzxTeB+vVvv6VJTNTZz6lD+AcemhF
	n1m2gl5IPc74k0DubZFlzNgKtZ4C9TKTfNW1IyPv2mRcDzNQsY5H+x1TnrLET3gQGdhkV0rOgCp
	r4SDk9xMMXJ1boPSUiBTt91eBGiY2rrfqrVf19bjFe
X-Received: by 2002:a05:620a:280d:b0:93c:68f0:f09b with SMTP id af79cd13be357-944089393d9mr18644085a.5.1793133028567;
        Tue, 27 Oct 2026 13:30:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f0a75ea7sm151165585a.16.2026.10.27.13.30.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:30:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad98380ccfso511672a91.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793133027; x=1793737827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w74HKg/oDTjmjEJFvFMQJp2IljljHah9hQnQWOM3p64=;
        b=ARUEyRAEi+ZEDQaisK4hJ3kBucGmoOalxcZA/FimgjzpTSvIYhmJEJ7DjeCPfAA9Z1
         hyIyMNRGatkKSvLQakz3mw7bgsJptKHQeoCIJbN6c1lbqSVlSgBM8En51ZTbHuuab03o
         mVYhvIQFUSARmUbvIN78+84kROSGGFOuFCSms=
X-Received: by 2002:a17:90a:d00f:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3ae580dd6c5mr164202a91.43.1793133027282;
        Tue, 27 Oct 2026 13:30:27 -0700 (PDT)
X-Received: by 2002:a17:90a:d00f:b0:3a8:5d1f:59ad with SMTP id 98e67ed59e1d1-3ae580dd6c5mr164171a91.43.1793133026771;
        Tue, 27 Oct 2026 13:30:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578f19b3sm398088a91.17.2026.10.27.13.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 13:30:26 -0700 (PDT)
Message-ID: <057b41c1-4952-41a6-8e7c-d1549d9213c7@broadcom.com>
Date: Tue, 27 Oct 2026 13:30:24 -0700
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
Subject: Re: [PATCH net 0/5] net: dsa: b53: Preliminary fixes
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com>
 <179313278971.3327.16155760995395298868@kernel.org>
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
In-Reply-To: <179313278971.3327.16155760995395298868@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/27/26 13:26, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
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

Except for issue #2, all of the other issues did trigger in testing and 
needed to be corrected.
-- 
Florian
