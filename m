Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D462931C0
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785674663; cv=none; b=iL6lPzN0dMv15XkqkyJM+g6aC9gqsXMETJcfRnoeeR6Fa/ryFSkIkuEQtQBrOyxMWKfgpiQTnVGO5MUtTWRzLdxMRm7MEGISqzrwFnscOdv7PQeifZ09pVMCa4VgPM3SBqCo+bSWl/k2D8unXJjf8fJujUqhr7hypOvBxu5tigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785674663; c=relaxed/simple;
	bh=XcszAyQS9veKAD+wJnA86waCq2jX238QhXL7VZfqklI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eGNH45jf5fwhWW8pJAey9B4/NonCvs1s6tWtk1fFYwFf8p7wJ6GUU8Th//vYyXPHkTGC1VC6wvMqdTZ1sp+ffj2iGl2Mbw0MPmDO22qlnDown+P4eBv0OU73rxSQ7cVvxwXYuGTPYpReg+Yxf5uwIOlOb4QsXzacn79SqgFXiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5Y5TjIv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5Y5TjIv"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2434786b3a.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785674661; x=1786279461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEzxytw4Rn+F+IHbaXW6sovp8fEtrN7cu+sf8aGga40=;
        b=X5Y5TjIvxy7q+AYyeJk1d5fUTgVgfGXhhHHm3z1esTlAPjR9FSmaEBxUpQQN7EsT7I
         tBa5bdA7inDbwV+7gY73l8mtJVuf1QlSCCYkj8U23nHdaHP7joFvKb4WlDDUuB/FjuGe
         BeoM+I9/L2rezwsvC2myNIvus7DGcPI0L8b0CKesPu0TS+abzRHxxpBLbAoK6wlJ4N06
         qerdBxeShJfsMloMo17OvQ3jKn049HLwRQeieiLXmsf/hajeaqf32VdHGtm2zC31Wa5c
         oeI/gTK1h0lT54NpCIsfjo880pc6YWXKUH9Nrp0NeHwB8fXAX44tSawwkqOORsoHGclc
         iYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785674661; x=1786279461;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEzxytw4Rn+F+IHbaXW6sovp8fEtrN7cu+sf8aGga40=;
        b=ILJb/lHihiF6aT41DeE1yt9uMvp59KGjTo17/7ZYvuFr270+T2eiG+T4k4JGKk2FJj
         BXItDcDlQ4Rbm9TjWAPo5Z6Mzsih2Uv1DaR7ub97gBvKE/fn+WmMBmHPZeMM1IpSaaxy
         HZR9XztAaGKWfRZN3EqQ2SytmMl4pWbLRUAObD04ROzGxB0pbWcvjAk0A5y8v47Z2HZf
         4cPsJpOcf43chfU3ShyjcCwCrWGPAS4415aIPgt1rqMcSnUeEr/CbDiiBefPPiyzGWFY
         K0f2EMI6OuYYwR2r9cT7xWlqQZS5J64F725wY63Ry8NDmSV2kbjyp/m0ojlveH8Sun+e
         80eQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbMD5GddXfSY2Z5g/xJEhLceTaBQ52MUs1UdkecZuAdCg4fTvWkKlwB7o8ZcAgG0AOluR2Q04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqrmzonJEJ0tPmId70HyG9e3x9OfRqzF7zEWI2JSaO7nO6l5q
	+mb15emi9EICSolHdcGMGHJax2CXMps3RmCl2+7x7A9NRJWloCRLUFAn
X-Gm-Gg: AR+sD1331qR/UPgnfaZBJCkf6+rEHsWWtfLau9pSjE0f4Qtnh3HVioNCMQcORXbHLgS
	UxvfU2HZ9SrW+pEEbIm+FCRYQ2e09JGIv6isCzOgovMlvjeUJTiHL9lCF87whtjDlmfV5pR5Yye
	aZ/8iFTZtd2HqoDV5AwAr53sX4qcbSOFLZUWFZfQDn8SZS5eXn6f68+xKfopueMoLdMxB5Q+mRN
	Qcj4c6ixnXi55W683wn4zUbe6QbX4qkEH2PaUZPx9OrgwUT1EKC6FzttluaDr9ffmgXSWTDi4xC
	JKGtEoSiKjewuj8dkVh9CAFBcTcQBo4Id54jIOxL5OBoO+OikrP6wvTn+YhBWO7Fex2GosaZe0f
	sNCy4kp9Bie7Q4aoahR1f6YdFGqUBMTNj3Bw3SD/Mq42HW5QOG5dECu9mvcjSgcy3BBaGyvqrLo
	fOK1Zv12ZSK9YaJLDloyQ8+HmaK1phpbyAsz8amTWOwYKrxGQRisGsDB5wyChgCgF2Fbhft3bqK
	nnRheQW8Vjl68Q84AOK8jTJBXr+ed7V0WHZqZNaHVHYu2N0N92cErKUGAKqDr5rrv7Xu7CIQvX+
	YmNi4kxEPaPcHdYen6/o
X-Received: by 2002:a05:6a00:812:b0:848:487c:ce05 with SMTP id d2e1a72fcca58-84ee47e4308mr5848339b3a.7.1785674661623;
        Sun, 02 Aug 2026 05:44:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963da88sm2563070a12.1.2026.08.02.05.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:44:21 -0700 (PDT)
Message-ID: <81e18535-e66a-498f-b293-3cb1c090fb9f@gmail.com>
Date: Sun, 2 Aug 2026 13:44:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/3] net: core: propagate unreadable flag in
 skb_zerocopy
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <11a640b6-46b1-44d6-aee6-872107f7f570@gmail.com>
Content-Language: en-US
In-Reply-To: <11a640b6-46b1-44d6-aee6-872107f7f570@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/2/26 13:33, Pavel Begunkov wrote:
> On 8/1/26 13:52, Mina Almasry wrote:
>> When skb_zerocopy() copies devmem payload fragments, it fails to update
>> the target skb's unreadable flag. This causes the target to appear as
>> readable memory.
>>
>> Propagate the unreadable flag if any devmem fragments were copied from
>> the source.
> 
>  From a quick look, it doesn't seem like the function would work reliably
> with netmems even with this patch, but that's a different kind of issue
> we can return to later. Curious, did you hit this in prod?

  	skb_shinfo(to)->nr_frags = j;
  
+	if (i > 0 && from->unreadable)
+		to->unreadable = 1;

Taking another look, if j != i, it'd also have the mixing problem,
and that can happen if it hits that head-to-frag copy.

if (!skb_frags_readable(from) && j > 0 && len)
	// goto fault;

Maybe add sth like this before the frag assignment loop?

-- 
Pavel Begunkov

