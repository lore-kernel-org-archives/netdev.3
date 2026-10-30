Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398289;
	b=rjKT6il3tubtt+z0L/DkZhCgeuhadpWpI5QiJ5UmyIJs9tRHvYo1XFx7xDrAgn1jaoYF
	 h42e1sZS52owo4u69oJKW+nQm4SVBKErtLfXDb43EaADwGIr3R9NpL/2jw4zra4kb7kkE
	 cdxCAdRdhcPeX4HC5ze2tV703Qgab19gDLVWOtBNi+sOfPmvi2RDjBqhJn6+HZ2DuzzXl
	 h40r6qflunZsqCi+mHdfD8+zZ0jv0WXa+KfCnKvVH6AOk85ihqe+ZsS9TULEsccB3tMkM
	 Unwid1jK3ZpdR6M55mT/QJemHG49wCYw0kXTZtwuN3qDJP78nPU95A8wpf/lRbygSmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398289;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=rc4SrQ0TK7BLfqKIW97TuJqq2gED56E31RIywFjvD0g=;
	b=e3XMA/tJlP0Lkl8d8DID9g7sOFJhO401pC1Wr/YWhQWbh2PlRtx47JOb5jxK+VKlM95X
	 Uvazs3Hh+AR7cx3OU1Gr54FY25WToiyiKkDqMpToRhUolMMIq8TssukupskwMU0q/Ppcr
	 gHScxs11RLKYCempdXrQngwhgA7NW3jkAcCV9+K8HqcHC8V27j0CDqxEpZHZONJHi45xl
	 XLrkKEVfis+08h1KY0wCB+wYucMUCv1h1mDfJl2BrugDaq/ym7VLurAiPdq/93IRq+HSF
	 JjuFyQ/hDibfbWE6ezuHdLc7ymwJay5VgYnfvGgPmeqNJ2LSFXiJNOs00dS4/CcfSqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="GbrBob/f";
	arc=none smtp.remote-ip=209.85.210.225
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A9E606A326
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 22:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A9E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GbrBob/f
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-89ff475a152so453429b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793398289; x=1794003089;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rc4SrQ0TK7BLfqKIW97TuJqq2gED56E31RIywFjvD0g=;
        b=wAwCkCG027iew4tAtKaO+pgkyNvUff1RZozzOHAor74UypagWywoZx2oQda9s9PMpK
         ccMdihecXuafTKpNBf54mIn0ymzJiOZEtEGEE5aRbPUO5qyALy1cvoCdw+vN9H/AIitr
         O6F80LgngQuRMCbQNkTb30j5MGQ3QK7XTgm1og10PY0wx0RWSRr6Zp8crvz9Kr/eS5Uc
         X4dFJ098nSNozeGg64wd8ICmzfsl0T8nY4ExGGKpSRSdiuTVP2nstQ4/lE1TU3vR8Y/+
         qvLVSZE79CnTebJ4lDbbYfbnE1PTzIYVQsl6oBMOiztJ1GhtLWQCLBzMOwG2NIrOKScj
         aI0g==
X-Gm-Message-State: AFq9FYIXYBh+lm5MxwBPgFyTqzFm93up1rEo4SV3BZq80udf4+yi2SzY
	EQ7ndDI/MN+VU+mix/Kvj3ov/rRaINlBmSuEHYsJIm51ocCxVN1QukZKAm+1SgHYJdEmYBKnaWI
	qax/zT/rg5WabQ+7GIf6nZSor3DUshjcRRcmnDiggQeuw21ZmRvkPIbJBqAF/tiG/oIds2BaPsv
	tqM/eglxgUqIIju8/DN1N1yjoPvfWLgYw1upjM4fMzkHfDPtZdPbViECt3KwpZDsMFc3yMW/wZe
	nfLlXznK902/yqBF0k=
X-Gm-Gg: AYBFou3TprJxgfOszH8NvFL+L7LiGcCmlD0Yq7FLU+Lz7S0fdm+A2dbEflad9PDz4jr
	Q8cO7rrcy4uYNyLpexX5q0W7NOsR13LTEHKA+kNcT4H3HOir3zltvRwKnj8/hszdO6/9zhD3/jG
	ZuU9rMTB88jtaqIHz6jql8Rb8DXhS9Cc2InDpeR2XQLLUIMwVJ3WXB574AMDXxgUg585wi2vV3H
	IVlPyXKq+3hhtUAD40kC6dxr8VhsP9XIQIhnUpXrgyexTiiVpdQatlXwVcOpyvh1zjAwRxEBZMa
	HPCOcQLq0r+Yx51yr+lMBm2O3A2imifQRd6ufu3UAx6ZUeuScW5Ezj9FJ1WacwhW1Lj5rlckhho
	m9Xls8ERzvRiBHeC4jP3ZxR0zG0mKwnRrf4wtUyCStq/BhdhTfUcgjFqbCIAakO+RjvEQCTqD1U
	SdGCYc/xQHNTceiMIk6l06imrR+KL0QCP9LxSo8CF3
X-Received: by 2002:a17:90b:518b:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3ae897b6653mr2815507a91.24.1793398288697;
        Fri, 30 Oct 2026 15:11:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae85e8f941sm970636a91.1.2026.10.30.15.11.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:11:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so2224233eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793398287; x=1794003087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rc4SrQ0TK7BLfqKIW97TuJqq2gED56E31RIywFjvD0g=;
        b=GbrBob/fQHyXDy4ONx5Y4k5n/ZGceMxyVnZSTCnmf+VsgqYdjsb3kGZlNq1sYalZPI
         Ap/g3T98ci1nko7lZwfHHdmjg4uajK4nilUSbpe0kE/JS1wavUkSh9awbRyDp/piijJ/
         6Epcmwn1VgoBjuT8ALKH+zhTqi/g5bffEtZoE=
X-Received: by 2002:a05:693c:65d2:b0:36a:1f4f:3e9 with SMTP id 5a478bee46e88-36a4238badfmr5088028eec.20.1793398286471;
        Fri, 30 Oct 2026 15:11:26 -0700 (PDT)
X-Received: by 2002:a05:693c:65d2:b0:36a:1f4f:3e9 with SMTP id 5a478bee46e88-36a4238badfmr5087971eec.20.1793398285637;
        Fri, 30 Oct 2026 15:11:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4291e38fsm11413522eec.15.2026.10.30.15.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:11:24 -0700 (PDT)
Message-ID: <3c3ba65e-1f9c-4afa-95c5-925b972e0e21@broadcom.com>
Date: Fri, 30 Oct 2026 15:11:23 -0700
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
Subject: Re: [PATCH net v3 0/8] net: dsa: b53: Preliminary fixes
To: netdev@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261030211617.288562-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20261030211617.288562-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/30/26 14:16, Florian Fainelli wrote:
> This patch series contains fixes to issues reported by Sashiko on the
> b53 PCS bug fixes being submitted, and then some more that came from
> code review and testing.
> 
> Except for issue #2, all of the other issues did trigger in testing and
> needed to be corrected.

Apologies for the double send, had a typo on netdev@vger.kernel.org.
-- 
Florian
