Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE139525E
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704806; cv=none; b=HK0SufZeJX9ewdkIRjLs9wW+toPZ7+h2uFdDYpRolsj35jJoodO8g/bDoNflf5miSovMsJWK2uupstQC1Fk+tGta0e04om9zfkeddm5KovNUj6oXTkALSxL9KI7R9ZC8hCrKN0fL8f1LxxYLe0o7SFigpBVpoY1RD2X1ANSyvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704806; c=relaxed/simple;
	bh=yJHv+VG7GOi+MWuL/S44MaQHbx2eCAX+0xU+GMwaxEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy057Ret1K9zwHEMZrNRCwAypQZtGWd5QJi0NeUdHy2lhsrvY+PqqrrpTuZ57zg4y/ieYukOugilrTtgs2Yc/15SGIEA+Fevzcfg19ZhjxtxVcgBRppz8I3Zgp5GxcvAJmOaVpm9Xfd/0OU/c6E6h97yo4HA+qOxMb4A5cIyGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SPMtD7wq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SPMtD7wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=JJ/5H0eJk40OZwjtlxwBZWgROUSPlEVB081OFoH7vSc=;
	b=SPMtD7wq43xMngg/oVdXscA2uzeAOLQJnxC0+72U4q2BbRAw7y8aTnCykCyWQj
	lQKchSvNuIR3qff4UYfMN5HX3MrOu3up58wn7gX5ssTHox/d/LTo9jzLwEb7xlim
	S121JlKgscZhWgoykfFsFVgwMrkMarvVATuBbwvp+U6A8=
Received: from [172.21.20.151] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnp5LpbmBqgNWxKw--.24251S2;
	Wed, 22 Jul 2026 15:19:07 +0800 (CST)
Message-ID: <cf669fdd-48d6-4ebc-b39c-161600ea046f@163.com>
Date: Wed, 22 Jul 2026 15:19:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: skbuff: optimization of net_zcopy_get()
 call in pskb_carve helpers
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 kerneljasonxing@gmail.com, kuniyu@google.com, willemdebruijn.kernel@gmail.com
Cc: mhal@rbox.co, bjorn@kernel.org, jiayuan.chen@linux.dev,
 netdev@vger.kernel.org
References: <20260708055454.9167-1-luyun_611@163.com>
 <1e76e0df-9b73-4e15-a117-4244aa3be9c6@redhat.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <1e76e0df-9b73-4e15-a117-4244aa3be9c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnp5LpbmBqgNWxKw--.24251S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1ruw4Duw18ZrWxXryDGFg_yoW8GF47pr
	WFkw4vkFs8Jr4rCFyku3Wav3WfAwnrtFsxGFyFvasFvrn8Grn0kFWfK347Aw4xC3yIgFW7
	XF40kay8GFy3ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR573PUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wuIV2pgbuuszgAA3S


在 2026/7/21 17:39, Paolo Abeni 写道:
> On 7/8/26 7:54 AM, Yun Lu wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> Commit 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
>> pskb_carve helpers") introduced two calls of net_zcopy_get(skb_zcopy(skb)).
>> In fact, skb_zcopy() has already been executed once before. When calling
>> net_zcopy_get(), skb_zcopy() always returns skb_uarg(skb), which results
>> in adding some unnecessary instructions in skb_zcopy.
> I'm quite surprised the compiler can't generate the same binary with the
> old code. blot-o-meter seams to agree with me.

Thanks for checking with bloat-o-meter — you’re right. I did the measurement

I should have done earlier: I compiled net/core/skbuff.o with and without

this patch (gcc 9.3.0, x86-64 defconfig-based build) and diffed the

disassembly of pskb_expand_head() and pskb_carve() (into which the two

static helpers are inlined). The generated code is byte-for-byte identical,

so the compiler does fold skb_zcopy() into skb_uarg(skb) on its own.

>
> I think that the consistency argument is enough here to justify the
> patch, but it would have been better to double the above guess with some
> actual measurement.
>
> /P

This patch is only a code-consistency cleanup, with no instruction-level 
optimization.

Thank you for pointing that out — I’ll be more rigorous next time.

