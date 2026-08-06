Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B433955D0
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041838; cv=none; b=o2A0yPmFUdYqkxtZBTWK7uhEORmdaxwfmwLqjztG7OrVFWPRAKttNox/JYyfc7jhHQvhcfKTbafDol20NjHMyx+cACmCA/sWCzeVTmpDQdbi4dMZ7vITUT1XiL9bUJ60I56EzxbiaAM45WVZVt3rHu/mpfzrTROLrmPZK/UZMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041838; c=relaxed/simple;
	bh=1rNQuFiOhOt37dJ+cNPkGEJONxyExx/izUhY78wCnPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxfxnZqIaj6aEoL0BUkB8MXcG9U9KLw/w4boPxfEuxuYE917lfD6iA6kR81liuNB+fhEt8BnK1CHLqH+El7cF6afGhqcvojxmS0RRdy3DydodpH69WcW9AhfYUyM24z7/n307pzkdTSrtOx4EMOdeoWWJ+jabv4cAuqkGUtiA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=LRi2ZfiC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="LRi2ZfiC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so32999425ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786041837; x=1786646637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fn7BhnQqlmz5vpie7E8GOeB3W2csN7XIMYWDpfqkT7g=;
        b=LRi2ZfiCEQ7+sp1iZRW1nfzOLSGMHP3L9rmqMcd0ztHW4xSa46TlxuMTCLPOFzB2u8
         Rm+Ph3KsRbWUhgT9wP8UIq/Jgp/rF4T7Uhx7JLnmkgTvvsOvy0duE8gzfmUyTrweJ4jL
         YCr5azyKU5VtAxnbfmgMP8ttRDqKUxPBRc/1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041837; x=1786646637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fn7BhnQqlmz5vpie7E8GOeB3W2csN7XIMYWDpfqkT7g=;
        b=iRoJ1J3BAFtUwKzPkaLAzB++DrbaNBSPrBEcKVWY9Y5LJdJoWI/qWzW3BV5X67shkU
         j3j2MUrO6MOCQfD8Op4Dg6NrvqRKXOPVUP9jF92U+IXaHYYh+8plUHwC8OhtfQg7vs09
         T9qcZVBvfprn3KEjO2Go0bS1BA1nAlvZr4k2rv5dd5mkMEpjTnphxW5Mp2X9XIz7QqHC
         kY73T99ILeJxQvfJdMfN52vtz6Rozsfhn9x99Orso24CVNpKEiTvHZ4pK2U50byzfOcW
         2TDW8G2rT3OqDlzLMg3/hrNpu8bxbsKSnQabFUYu/IzuAVr1f9H4N8NHzeztcV+RtiJK
         0BXQ==
X-Gm-Message-State: AOJu0YzIUuA8HEYssfWW+nuH4b1sP0rp5sUC/uiKlWQEBtujQ8qrv95s
	AaeoI4Diwe8Ni6aKfxaj2ztE7wybAY8RD9BgKfApgftlDCafdrVaAHzogsHY8E+k0w==
X-Gm-Gg: AR+sD13CcfUDq7DROszYZhVFTHak4/cc7r6t2kMTSoNp0dMEASoq13gifAkoOaIb5Aq
	uD/BzP1/HPr6E8zCaWotH+zzXAd9xN386M70ztFUzsbCXkNu7nW0bssKPTa1OdC463Xo4lrih+M
	DavkPmrjlvd70kiEhgK+P/SRSWvHxKZ9bJxbwYiHGKTrqjYS4LrV1UXjT8/HpSljbga26uTwwzX
	ourtDf4jPONvlSgDae6Yolx7A8H4Mej7qYTxq87vAIfy4M5pxpMM7zUzLaRxoPN40zu4LkL/AMU
	5imrVpdgFtSwmoJd+wzHqphwDT7EBZJmZzJBwFZ21a3bP5CculprzpTadB3G33/t5akLbIFth45
	HorkWZAD4/FEvUXFdN3q3S/rfiF7SVYMq+blS1i7JnQshGHzmzZNeVb8cFEwtzYI6qpYAqiD/pd
	0kZz7RRleuZtLwTR7vSZjNTZSVHy1GaSQC2oCRQHFu3ZsNFoTXzeHJKl4payR1+/V2u9qCPY6/M
	lXi2Fe+
X-Received: by 2002:a17:903:2b0d:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d0ca7afcc1mr206063715ad.4.1786041836673;
        Thu, 06 Aug 2026 11:43:56 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d120c12f10sm648545ad.62.2026.08.06.11.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:43:56 -0700 (PDT)
Message-ID: <86bdf738-6b23-4a13-870d-8f3403d806f7@mojatatu.com>
Date: Thu, 6 Aug 2026 15:43:51 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: tc-testing: add act_ct test for
 malformed header handling
To: Hyunjung Ko <hj351016@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Tao Liu <taoliu828@163.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260806101235.809370-1-hj351016@gmail.com>
 <20260806101235.809370-2-hj351016@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260806101235.809370-2-hj351016@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 07:12, Hyunjung Ko wrote:
> Add a tdc case covering the leak fixed by the previous patch.
> 
> The test attaches "action ct" to a clsact ingress chain and injects ten
> IPv6 frames whose nexthdr says hop-by-hop but which carry nothing after
> the 40-byte header, so ipv6_find_hdr() fails and
> tcf_ct_ipv6_is_fragment() returns -EPROTO.
> 
> Before the fix act_ct returned TC_ACT_CONSUMED for these packets, so
> tc_run() never reached its TC_ACT_SHOT arm and the clsact drop counter
> stayed at zero while the skbs leaked. After the fix the packets are
> dropped properly and the counter reflects them, which is what the test
> matches on:
> 
>    before:  Sent 476 bytes 11 pkt (dropped 0, overlimits 0 requeues 0)
>    after:   Sent 400 bytes 10 pkt (dropped 10, overlimits 0 requeues 0)
> 
> Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
