Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F52FC876;
	Thu, 21 May 2026 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397927; cv=none; b=O0FeHJP/V0ZkkqbshSXgmas5Iu8KgC1pmaO98EIdriACNTrseBMaO8qt2ljRPlWWJYH9RIJ4quNb+k4m5hqOrGBRi9G3OMm94o46boBtWOn2qE5FkcipPncMbm+vAOK99cRc9y/J6ZXQDF4y0PY4rxOW5/vNMCVmgCfc4DMpr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397927; c=relaxed/simple;
	bh=WzSompHWZa+TXS/OFktCRwuPIyYbFpUDARQgVaKVV7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBtmXtXVNaYlS0QdJra1lrnR3kHsxNAKBvoF2W3KXnNgTymE/z1lT8lciwAqo//f5aHtSPbvzcDZYEIf9EUnVpxlfMd43X4Ln3r3hi5xKvrmp8Hsd4eT5EjcdppteCQMa/mu7oG8/1h5ewVbqQf4fJpaQyCmFCVA1gtcNNpwrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfmqoT+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfmqoT+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41C71F000E9;
	Thu, 21 May 2026 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779397926;
	bh=ObeRCQN+zlcP31xpZYcgGdti/iiyxcHhdVkYQKtl1Rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IfmqoT+UiB5T9t8gvFos4WTgZmNhjvfVaddk92FXEo4W9/hYStiDGF/7RMAJwADVB
	 ayn1i/MphMJBTqYH97TB5+ASvZqyLGb3C4dSHM1d5J4aBQoNwckcVUB3+jNiqXGBwh
	 C3TYSa+oMBCQADQi/R5Ec87NjcS7MnNWUt/DXnBNwYX92c1Xe+P8NYUIowpiup8Tlr
	 Zz8vEDp7eEEuXTk5bf++od5nnr6MjQXmXgNxD0/x7FdsbV5xAW/IPlmz3cOlwKc1/7
	 9R4FPCVevWqawJB+Ql6+7Kk8ESrSdFPqNglvL+jgiZ15Do1utNKwCFvKZ3Z0SjiWJA
	 DZM5FeajtJQMA==
Message-ID: <f0983d83-929d-421e-90cd-aa6962c6191c@kernel.org>
Date: Thu, 21 May 2026 23:12:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
To: Ali Rouhi <rouhi.ali@gmail.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
References: <20260520191943.73938-1-arouhi@sitime.com>
 <20260520191943.73938-3-arouhi@sitime.com>
 <48cc27ed-48e8-41db-8351-166774466a69@kernel.org>
 <CALFSGupB_eRHQ=h2PzwiLE1gTvd7kZbBP+eWOVWVxapVjzgeXw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CALFSGupB_eRHQ=h2PzwiLE1gTvd7kZbBP+eWOVWVxapVjzgeXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/05/2026 22:38, Ali Rouhi wrote:
>> Mismatched DCO. Use consistent identity or fix your commits.
> 
> Apologies — Gmail's SMTP relay rewrites the From header to my
> personal address (rouhi.ali@gmail.com).  I'm working with IT to

I don't think so. Gmail does not do it. Properly configured Gmail SMTP
should work fine with two From: headers.

> get corporate SMTP credentials so the From matches the Signed-off-by
> (arouhi@sitime.com) in v3.
> 
>> Same as last time. Why are you describing drivers?
> 
> Will drop the clocks description entirely — maxItems and
> clock-names are sufficient.

You completely cut the context. No clue what was there.

> 
>> Drop node. Wasn't here before, so why did you add it?
>> Drop.
> 
> Will drop both xo and xo2 fixed-clock nodes from the examples.
> 
> Thanks for the review.
> 
> Best regards,
> Ali
> 
> On Thu, May 21, 2026 at 12:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 20/05/2026 21:19, Ali Rouhi wrote:

Heh, you just top posted.

Do not top post ever.

Best regards,
Krzysztof
