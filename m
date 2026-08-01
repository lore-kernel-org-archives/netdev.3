Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815F489863
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601677; cv=none; b=hTnBe2VO7RRp8Y+0Lq22co5MVAmxg8M2WkiGxi02b+uns4G/dkdTzuX/0NNFl9l1XCdQdTYmeJ2dAej+4qV0edZ6ynpNBzoDgjZPKltXMsjI4hbk5Qe1wfiqVB3BwaUJlqeFRDyvt6g/vCFJxxJ47ynfKnn6ChNMmCk4FtjJiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601677; c=relaxed/simple;
	bh=N4jwfZtGyKvIYXLG6f2s6xYg8+MeESB7wKlX2azzSno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWo2v43RhKyyirS3HH8SnhYpHAjlYmUb0qNAEEzmzfjBCmHutNj//KSoL5QQpokKzJUTe984AvXO8R315nz83Lmlzw2pY0oYTMBhGpEfMQzHHBMmhnVskF/E5VHsYbffAFI2GeZQdKwFqYxQcLuHd0pchrdTTVn8AfUnURdIH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=BULtA/nj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="BULtA/nj"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1306268a12.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785601675; x=1786206475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZYiUKxvF9GtOjEd/h2m4MxUMezPtkYsLarGGm+pGsA=;
        b=BULtA/nj+l2BFZTAqutuDaSL/rd4a1mDX2jdKApM+JfQVGEjuBV6Ng1nAFQxWeNLq6
         Zdc0OsGFn0MfaOCwhjv8gmftsi6CXhmXKAG9HP3GKWGgRfbF8MO1me24oSXEWkVFYwbj
         eRkKrH//3oPtjq698BZ2ykBQDN5bbEp+NLRbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785601675; x=1786206475;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZYiUKxvF9GtOjEd/h2m4MxUMezPtkYsLarGGm+pGsA=;
        b=XY09pXKA8qMLPCj4lUhruZTkxkAcI2UkbLs5xifgzyQaL1nUXR/2Q/4Rg26eWEx11k
         KD61wpW1OPno7i/1ns4/wDWhSYo19HAJVwRIp8TObr5LAdPTdf9OHgTIH0jpjhFjfxqE
         PZYLfA7NSC0yAZRzvnyAlSS8c6ot9rDKNymJwSE9cgAhyrpwC77qS2NHwE60oOcwwsu2
         SZNHQzqiyqTkLKWeAXqjQGIUsMefANwZ+CxseTMEO/rRNWqx7/yXjlXYsKmjOMr2hGeP
         OpNYnk+m++1z8eZjawEJuYfTH4qpTGXuyuikFQ4BoxiGLc39wpox0FGOGdhAc10k16u/
         8xsw==
X-Forwarded-Encrypted: i=1; AHgh+RpDPQSQYEOYO8/800tNVWsXhK6TlOTFXH/Lxcz6Tj/nzLwcuZ8gbQDAua73FkrsskG81XxUwsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXit71I7LOjOqoryJ2vkQzy37ARPMXlH5ZvFkkOmJSQr68KURB
	ClLOi53DpK3dQIqzpkywsRIp+JSoEz8zDHzbYXzeSO6MOvyJv2m3WvRWHGeXeLwUSA==
X-Gm-Gg: AR+sD11mkp04aRiu9rX5HRpAOeWsdvCbPuuLorUqjiZAL6rSe5fX9I3CAEtQxjb0/4P
	IT5ZId46ivUJsAOkOnSvZLGQ2eWjt0Z3olVaX0tgFxSw1x42GqLERpkerYplV0j+dLRkbal/XYw
	zywsBmw2/PqzGXq/YdrIsTSkpV7c1+noE7EDbdXV9ESYlkaDHQtxt9ecit4g3gZY2NzOEQiNR3U
	rv71Ufw1x8VM+5phOrPppXvmlHXhZxTlYLI/7KJ2cErdaGOOyBpJ8eumsrImO6UlVkLiy9Kyts8
	KLdTybV/OM8XUEQrNqEmoBm39C5l/RW+Q4njjb0luH0l5dfRpl1kTVTU/GVFn1wwkkoAbwEC46h
	Oy0tRXywE35yIY0Seo3JHX+cG3vvvOS3sA+1zKdQf0YqSt3Z6dVYcyI3WaCA3tGnw6ggp/it5Il
	4VQBIWuiOMtNtGMvp1gpXW3Sk7LakYn8L7rHOICUV9xAkfiMzpjWjUeCaR/7lYXEumDyoHKA==
X-Received: by 2002:a05:6a21:4e02:b0:3c3:a722:59cc with SMTP id adf61e73a8af0-3c92a53edccmr4024344637.22.1785601675338;
        Sat, 01 Aug 2026 09:27:55 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c54:4d67::2000? ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e5c7sm21682784eec.5.2026.08.01.09.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 09:27:54 -0700 (PDT)
Message-ID: <7a0d6b21-a10d-4310-9202-4262bb50c354@mojatatu.com>
Date: Sat, 1 Aug 2026 13:27:50 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net/sched: reject overly deep qdisc
 hierarchies
To: Ren Wei <enjou1224z@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 vega@nebusec.ai, milkory@outlook.com
References: <cover.1785434373.git.milkory@outlook.com>
 <1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <1e9ab39597423fd5d13cfaaf52279b8ee3d9fc3c.1785434373.git.milkory@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2026 10:42, Ren Wei wrote:
> From: Zijie Huang <milkory@outlook.com>
> 
> Deep qdisc hierarchies can lead to excessive recursion in qdisc tree
> walkers and exhaust the kernel stack. The existing loop check does not
> cover the create-and-graft path, so a hierarchy can still be extended by
> creating a new child qdisc below an already deep parent.
> 
> Store the hierarchy depth in struct Qdisc and update it when qdiscs are
> grafted. Reject new child qdiscs once the parent is already at the maximum
> allowed depth.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zijie Huang <milkory@outlook.com>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
