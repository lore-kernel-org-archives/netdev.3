Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95039D6DA
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782494289; cv=none; b=lO/PyGZTUr/DWsTn0O1YOUbRIy7GzfnEhKD4H40pTTIxXRVpmJj37zcqyQY2AJBazBXBrZfWxd2vMk5HbYw8n+bCp2iCkB/DpS/WLTBBxWJtdnNyBxloUzIt/nXUJ4aVwUVrpodTJcx+izVUePX6I4jhk2IuvkbTI1WW+fr9HTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782494289; c=relaxed/simple;
	bh=EjLyYEXY+jT0+beeDAekbvlNUwzaCX0goMmbdDDv2JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hb2LKhCLduXk9cnMvw/0t01+ocxOiEByUHuSg4VERb2XgqdrsXaMVRpkqqdg0f3XGD9D70JYK7pBhUgRUSUUAxPpKeurewt6apSAH1wmvx2Pos3WaKzZtSDzo0B/kb/jCB9q1F8VYJNN+XhZs2ZcN/xrQwfttx4phhGMys81AT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=C06byR++; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="C06byR++"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-73413da037eso583786137.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782494287; x=1783099087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9VXl6VYO3SgtjDp+yfE7kugyX/R7fZfp1hlywtKsEc=;
        b=C06byR++tfXblrzfJUDOI76fcssjYePgY0IQjar+wMVMZ7/S+clVYJUyBcu4rmYt4C
         b2UDP7SMXbA2nL2PKiTCcwLzUl7gMIqR042XMTvkfSIneBMRoWKNJQLSxraSAImusnTw
         ku8JfBHp6nqvEHJwjlclJz5Hkmd2ilrVWdrPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782494287; x=1783099087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9VXl6VYO3SgtjDp+yfE7kugyX/R7fZfp1hlywtKsEc=;
        b=CL0NSgKHdy8KncQp6Ju+pLkzvrTEtvbsEB5dsJlBhrIxSj1hOWRv3EqkkCAieSFz1x
         THcJE7Fd9RQR4+TspeGXjs2+xqsbDocHPGJHwmFPzJ+dFN+YqEmul2uERW1wqbiMGLw9
         rWIJVyyUQpHMMElE16Qi+t18Ql4s2K0Cs3/w+nELWs75D+b+I4oFTYGa2WTI+wvmrngm
         CeTUXiIfCRXwOLNQ/1IN8Xky7iGg3hc/n9qD1trlnM6a8nXmqqT5YijyUqgbi3rdBx8N
         +6hdJK97orChuITY4d1fVF+xccCFTa72SCV6Tt7QZY+vz4HlDKrn3+fRIBIO89RWIxu6
         4K7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp9FjR/IqxDNcTYlYg6aac839JXljTpJEMocUQuuxwnmy2EeSlnJqMkHrRpxweBkYSysAwucTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJB6mpRwT6E5J61qRY4fPmlm3TIj9MzXvM8wZvpACz07kcaYi
	yMwz648ftMDoAtjnCB9sjcZ2eKJI4ZaJyJfQUiLp7L3fOXNWPU36q/156XI322Q4Ig==
X-Gm-Gg: AfdE7cl9K5lnG9UMI90qVCUVWbDGd8LbiN6KgK0a9Ox6FPooHD+ks6IBUd+U0fPspv9
	IOdNnYxy1XkIVFKJaeRkp5ZkbLCdS/mIJ9SDEp4tUOHfBFChLb6pytXwtUyxx7VqZ4267SdYUYN
	0W46JVZ3naKDCz2IwXvLwqDAVgV5de+ZtnSy8AMJeOcog3mavobVVZjeEDHxGI+vPkFeOlQJCSK
	jifC5psxovAOnJTULDLeLHamfH2rbCM7YW+xFba/q0NvGRP9gD6HK/hWIpgkyCEHEHZ8EcYgGvI
	yhygRsJpQrWHe4ByCJco6Glt5fzXdIym5uyjOacxoRJxU04smw4gBQ+tr2v2rCNNtXLGeU9c8qn
	Xsq9S5sLXMNad2XsMYdsq1OOCd2IWV4wCESkWV/ink7h6BOdB6/g2a6iBXTLG3IdepcXBk39Dx9
	NGzXAMhestVQldHDelg4keivUyVw2XcSZZMEhGi1yXc8ciUgvoDnd3lky3NgQvXOu35Q==
X-Received: by 2002:a05:6102:3e94:b0:633:f2bf:7de4 with SMTP id ada2fe7eead31-73434452a93mr4152791137.10.1782494287134;
        Fri, 26 Jun 2026 10:18:07 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67:f17:d82a:d5b8:20a? ([2804:14d:5c54:4d67:f17:d82a:d5b8:20a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-735697bb220sm1592107137.8.2026.06.26.10.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 10:18:06 -0700 (PDT)
Message-ID: <fc1b9963-2f69-4e47-bf59-6b668faedc0e@mojatatu.com>
Date: Fri, 26 Jun 2026 14:18:01 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/sched: sch_multiq: Replace direct dequeue call
 with peek and qdisc_dequeue_peeked
To: hexlabsecurity@proton.me, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Jarek Poplawski <jarkao2@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
 <20260625-b4-disp-31bcb279-v1-2-85c40b83c529@proton.me>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260625-b4-disp-31bcb279-v1-2-85c40b83c529@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2026 06:51, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> multiq_dequeue() takes a packet from a band's child with a direct
> ->dequeue() call after multiq_peek() peeked it. When the child is
> non-work-conserving the peek stashes the skb in the child's gso_skb, so
> the direct dequeue returns a different skb and orphans the stash,
> desyncing the child's qlen/backlog. With a qfq child reached through a
> peeking parent (e.g. tbf) this re-enters the child on an emptied list and
> dereferences NULL, panicking the kernel from softirq on ordinary egress.
> 
> Take the packet through qdisc_dequeue_peeked(), as sch_prio already does
> and as sch_red and sch_sfb were just fixed to do. The helper is a no-op
> when the child has no stash, so a work-conserving child is unaffected.
> 
> Fixes: 77be155cba4e ("pkt_sched: Add peek emulation for non-work-conserving qdiscs.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
