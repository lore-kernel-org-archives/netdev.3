Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76FDDA9
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673994; cv=none; b=gJFjy7YNGP0/ltGU8LBUbYGlj4GcKECc1MdjOPfasY0ox9r05Rp2bWRuv1pPnAWY7HDz+FDnmOeMg3l+6ziDRJAIlE9rR1sFQF3ACey2cWA74GM7gTwS4wARuA7FhBbxgduoJnTX3ezAdGAl8K0tXhc2UFhUFuCfRZtnze6mhWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673994; c=relaxed/simple;
	bh=CqvVGKLWOhQZg6fkJf8NGKO+3amSVHYQ5JV3a8CpshY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZKnAqWP1NrP2XEuT0RagaFp77YalUpVejQx02xkTkz60lSSltl9MVHgKza2mFG8y/ePOzMcCiWUizMZJXtngQaOy3RK6v9gsSeG2FCnv2wI/M+It7ptO1Zae62fosdfz4ORweNdqfz7r0lrzG2wCogZyboD2tpxtSGfRSBobIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O22K2qWE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O22K2qWE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e27035206so2821985b3a.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785673993; x=1786278793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zLPXOlMQ3I1IqUDcfkevWnBWFBV8QBbEkwHgFssZeNM=;
        b=O22K2qWED4XFpp1RJWDgISeOObXVtblxrXQIpLGmOla3j/lhJ3t+lnfEXK00/4lo2q
         nbV/ioqMg4ohrDprFzu0otK/ONk6uTMqjPY2NDA6Pp88YhI6qXzcNpWqlgjq+6VzWypA
         1IXOkymK1iDSG2xVIrJa5TCKsvs2rkIt+Wr1VBUXk6PVuSrenc9BU/ftStB92OnUNycz
         b0b2plq/0xE8NDOVGZBy1lCEBis1oNHUz6lcKqy/i3be0JQSjMLbTnVD4ry4A2xkE8lb
         YlJfuJR4jMRM0LQhp6Nv7/E/7GyWXnsLDxwuJWq8YnXFiupotTtBy30iRmcTuVMlpYpF
         xKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785673993; x=1786278793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLPXOlMQ3I1IqUDcfkevWnBWFBV8QBbEkwHgFssZeNM=;
        b=nHgGct8V3FrVsXiG9Ma8kI7WTc03vHqZucDxX896iSCNVJMCrTXWMIS9O3Com65CwQ
         s5oGOIwKd//8LabES9fjCk+RleBRAtWb5ntbis+69rA04vjSaTMRAc49EpNqwWNpUmDu
         te/YvgzlkhOgHsFDIoKL4orcsOSRYwj+3TIx87EzvDyKyMpYLQ8S4v+h8QtqxGpNJ53B
         MYKNKPvV2j1q46qL8gSqkMqgRiJvZ9gQXzyS7FHvF9pEpQtdxW2epGxlxRmxeSd8brFO
         llmkIeKGI6ILPIPYPrpME7WGWzFSVPi6xKFfy7Jog9ADzQyAf9kYVi6MBuqbbdivR71O
         ZsaA==
X-Forwarded-Encrypted: i=1; AHgh+RrZJAs7oPWYVMLF5HAatY8q8Ven+bSyp2227lGC48e36ZUqbmIwpQDRGFSbD83V71cSxarWPyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6HYLR4AaNFop67OSiOE6JreJujB/yPD26xIlcbZ9sckbOy0U
	chB8kvTlGaCopjX05ZNnsNlRLbvCYnumHRrM5UFeKBiXoFQCnPXNuRMR
X-Gm-Gg: AR+sD12VsATYdYwvk6WtiU3X4FNIFEdzicullsQIewSzXR+J88XyNUJjW+Klw5eZBxQ
	MLz7TnOLBYlrbcX46MEPuFzejDtujDCvRtV6BNwuPG/9ok+fk6oNRKMLySsdRLeHH+Y3REEzs0K
	eDi8+LtS6E7rOok+lz+VVqLTmYSlAoaBsqTDeDQ2nvjrTr0I157aguZTBZmvGrbRB0BmMyuT/gr
	enRcRHZ0w4C3918vR5nlsGGTZBvi1ookNRzX9rHLlJessJhZWfu+qV95o9zJgJrD/ouVjJp+kxr
	gKuSObfi3dhM3LcWTuJfVzVhxK8WH/cPgFDi/CVsprwHMGGSWvb5jyei/cB9rGMmxTcGOrP+qha
	+RCCWLqpTUhYUYbSHS2gZLSKI6mCCvFcemQuL4rqEpatRnjd6XZj4+CLFciInMzDYgdb7sIpxOp
	ry1M/3fmSAZdCugCH+9UljE9pHcx7Y5uHzUaoVZIKQqricRKNzDnsniW5U7t4gXDi6t5Gb7WLgT
	2BwObv94z3zEuCT/7h93FUGduCqO/gR7LxHJafDXwUuL9xgP5Oep9GV/1BW64OZtMA8Bx5Ob5gP
	o4pive0BOkKJIdkYUpra
X-Received: by 2002:a05:6a00:1da7:b0:846:2f5b:c00 with SMTP id d2e1a72fcca58-84ee4903b73mr5347240b3a.54.1785673992675;
        Sun, 02 Aug 2026 05:33:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbd3a4b6sm2475959b3a.4.2026.08.02.05.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:33:11 -0700 (PDT)
Message-ID: <11a640b6-46b1-44d6-aee6-872107f7f570@gmail.com>
Date: Sun, 2 Aug 2026 13:33:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/3] net: core: propagate unreadable flag in
 skb_zerocopy
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
 Bobby Eshleman <bobbyeshleman@gmail.com>, Florian Westphal <fw@strlen.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260801125308.1342897-1-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260801125308.1342897-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 13:52, Mina Almasry wrote:
> When skb_zerocopy() copies devmem payload fragments, it fails to update
> the target skb's unreadable flag. This causes the target to appear as
> readable memory.
> 
> Propagate the unreadable flag if any devmem fragments were copied from
> the source.

 From a quick look, it doesn't seem like the function would work reliably
with netmems even with this patch, but that's a different kind of issue
we can return to later. Curious, did you hit this in prod?

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   net/core/skbuff.c | 3 +++
>   1 file changed, 3 insertions(+)
-- 
Pavel Begunkov

