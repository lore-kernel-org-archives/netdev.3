Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE18318BAC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967182; cv=none; b=nQlWfhv0i2qM40quakij0vIrxlP2cl4xwlkZdnBdYUvKq9e9AL6eU+a8uaN4oHo8GyB7POBR70HMe0BHh0O+p4akWyLX/c3FusYa6XMJ7fEni3wj0SlhTQaEpxUCfMR1lTXpPK+rPz8lWzW4/qs8FICzQHKKok8CiRsmQ8dq4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967182; c=relaxed/simple;
	bh=UNTMs4HY65rUCx3FGGC6no9DF3VupsC4H4otkdJ/MKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBWAWv8eC1rmflvfON4ptm87wNChxglvJIME1Vk+51zbzj9pulLNYtyUOAZm/Nu66I8aU5t0uCAiw1H0gqxyvhEvHK+sYPo3iJtfoBDUUQpF6cMG8s8eBzFoIdDYTpiZt+eifPJ+An42CNiGS/cSzvi9oliTEXJ2ja0c8FOFOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vwBSQcmN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vwBSQcmN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c3259da34so3170797a91.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768967180; x=1769571980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRuq7cdSYizr1nEhJtCVuWq3DpoYkOwpDtOsi0u3UGI=;
        b=vwBSQcmNdTSGemK+y1b2/bi1l78Y0M55snA1j9sdRZjMN8vbEqctpQFjqvHEa0m/Ca
         V16z7EbvhJsrTbywNmuB7J3R5ah67UQIxSRc6kinRuLmRjTgU54yHzYswW7ee0q3AXmM
         msKxgEsN3XgECjzetqGyWu3sh53344ENco2xEuuJhF8V+3MaTO6t+1gaq5+/9wjxEvf5
         L1fdmVrnmdhFdZEK2WC5//kDyC1r1m121jOu1GlVBXB5dCov2ELEEo+oh4M8fB5cWHIc
         6DhO8+1MURH4JBcFBe7o4tKiUA/TPIidP2/3imPkXxd/AWrDCJJTV1q+2SeW17Rm8+1Y
         GZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768967180; x=1769571980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRuq7cdSYizr1nEhJtCVuWq3DpoYkOwpDtOsi0u3UGI=;
        b=wiCIz/2nKfU01vm8Q2vUxwiubkoSzGI3YWzEvr3L/ZKFdx5sXNPpmBrxMpdTioxCr9
         PqSngDFDwCHpOkSFK7pdpxzJ7DUPEGHw+cxW78WnkpNUBXhcSW3IsHQIrW5hxyrNQa2+
         idzlbebEoCgMz13yRSlqGCoHCnAE0WJwFCUMYATvhCD+7JMHWGzJZKZM1DMP2a8qWQfT
         aJvV1BE3e/f2V+9dbWXfurnSiuHDwlYZ2Rtc0YVYy7T3iPsbTg82VI6dX/bpp0nvVzs6
         GKMKysQxiYY8BZGkkkt+0lX0VfENRZ8sZzbQNDTVV+0jwtdznbpPu8UNPfnEqb1wx41O
         h9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwz3cEzp71olly5ZB5Je21IogpKSLtGKTsBQf2QwnKHbFd3RalqaCPRQHpalzTWOV0xUid298=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3/uyyR0HYRiK4epgRFkPBaDb0ewzgD3Kn/ph9wha4L3SlkpW
	LM8HdnvRjFXEVQJjFIZUN5tWQa5OhghAAirdzjpWLt+7Zy9tr4vQUFmJg/9Jp1rrgjQ=
X-Gm-Gg: AZuq6aLUtnGmmth2s0a5zCEw5qTtwxIaBnnsJKuUoNmzD7oyA8bt08hvf1HWjALGfxf
	0I6YIUQghUx7QVrs1rLJ16RYMiC4tAKPAHYSXxx/4t52n13YkQT2N0xHvhv+61tm1+wg7974vhh
	/MfkZsK97+fS+PAfRihJyU1qZBKEK4v4ghmSzT8RgGwetHjZnsBIC/nezQM0T5iueV1RbsL/hyB
	qOB9U0jRPJhefOFhL1lmCK9cHtwpY/ChzYQ2ncSTBt3GXWGXV466KkQJhTs6fuUqQTUHq7qjuCz
	rTWHqsyh92jFo1OlNRr0alsvUwh0k52BpUkE1RpoD7p+mioQyVoliTIerjQPmNgjkWvXBcb8KxO
	3eMj3RA6B3QHX3YIR1/rKE5TmgB9s94co4+d17HxM0lfvR7UYko9Od/pCHi+deEpGjb7NT664Zs
	QFlsMIRgvob/QP1yJJ2GZp7OqX1FJxk+gukoUPbXSSP5QQnwMKZLZUqy0Xif7eJNolYA==
X-Received: by 2002:a17:90b:3881:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-35272fcb836mr14613526a91.35.1768967180314;
        Tue, 20 Jan 2026 19:46:20 -0800 (PST)
Received: from [192.168.86.157] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527310210fsm6698391a91.9.2026.01.20.19.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 19:46:19 -0800 (PST)
Message-ID: <be76a258-0dfd-4fea-a0ac-b8d6fc6e95b6@davidwei.uk>
Date: Tue, 20 Jan 2026 19:46:19 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/16] netkit: Support for io_uring zero-copy
 and AF_XDP
To: Jakub Kicinski <kuba@kernel.org>, patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
 <20260120180850.45ae4214@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260120180850.45ae4214@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 18:08, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 11:50:25 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
>> Here is the summary with links:
>>    - [net-next,v7,01/16] net: Add queue-create operation
>>      https://git.kernel.org/netdev/net-next/c/a5546e18f77c
> 
> I'm going to revert this, I sort of promised Pavel I will pull his
> work and he has the cross-dependency with io_uring. Y'all can rebase.

No problem, that's the ordering I expected anyway.

> Plus what this series does to "the code I wrote" saddens me deeply.

Yes, that's always sad. LMK once you learn how to clone yourself. I
wanna do the same, too.
