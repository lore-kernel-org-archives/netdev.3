Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABACF4C955F;
	Tue, 15 Sep 2026 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498255; cv=none; b=gpYU6Ow64UOCNJ6lSze2C5DO00Gljiwa3yhpWt9NlpzLGJp4Mm/VkHmiLqYZ2KXnAfwNLKptJSOViGXEw2SGrTJq2P3ji246Qqf84DPrfkvpkS/1BkI66gw+rZuHc3rpl7WXt96l/+QNRChBP3I/pIc4zQicTfagT2tGpuSdrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498255; c=relaxed/simple;
	bh=tbJyO1qSfQZ0pjEHRIQQPcppBex2tM7wt2X3DLWlaak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmdhsjB4gmLDP/T86+E5CWme+yqeDibQiAi/AZMZGlfqnI7iHjYYV5hiPFbe0HI9JHg7FLJvBZsFkIAIFsSRIdaDYwDCS/qyQUIxkJAj4j2rHXomcEkZj31XqBE1ObAcQcvsRFtg4bBdlMq4znlkqfJ6BmyPlXL45cliBVG+dEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HGXzba2J; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HGXzba2J"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93DD2408B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1789498251; bh=/rqDGNFB1EvMVZVpxGsWgt/E/NZkIXTIaDmimmq2Rhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HGXzba2JDGuMqzSPH60oln1TwZV00Bcn2Xea3xM3bWcFT0ZtzD7VUjGJ6jkB5Wpws
	 t2WUq+VhD+xI5gYCXaZgzAsNIUot3g7jgixehFBEJbzmmmRBjImlkebq0PxrdoSnMT
	 ++FCZE3TOP/1TNKmkkFLkK6VcPY8zwEcnknEtqnlKBngyp9m2SNvuln9RXvUbwIud3
	 2XSPbyvF6skwRkVyRudLbU46YDS7Ixw4YEquq2CRF0kkRyuYLcemmfuoS1Cv8xQPOK
	 oCNxDSmXttMerQvbNEkeP2gB5wRl+AJrtJf4Ht46aZMpTjBkFcusT0A5YY51IntLjK
	 Al3LVViCSybJA==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 93DD2408B4;
	Tue, 15 Sep 2026 18:50:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: skhan@linuxfoundation.org, rdunlap@infradead.org, mchehab@kernel.org,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 tudor.ambarus@linaro.org, emmaonana18@gmail.com, bvanassche@acm.org
Subject: Re: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
In-Reply-To: <20260914155127.21515-1-emmaonana18@gmail.com>
References: <20260914155127.21515-1-emmaonana18@gmail.com>
Date: Tue, 15 Sep 2026 12:50:50 -0600
Message-ID: <87mrti9wmt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com> writes:

> kernel-doc reports struct_group_tagged() members as excess because
> the macro transformation rewrites it to an anonymous struct and drops their
> member names.
>
> Keep the tag and member name when transforming struct_group_tagged(). The
> nested members are then recorded as names such as fast.order; accept the
> existing unqualified @order documentation tag during validation.
>
> Add a regression test based on struct page_pool_params.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/0cf8ea5f-418f-45f0-907c-3d1ed4f03e9f@infradead.org/
> Fixes: 2f07ddbd5793 ("docs: xforms_lists: better evaluate struct_group macros")
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  tools/lib/python/kdoc/kdoc_parser.py  |  4 ++-
>  tools/lib/python/kdoc/xforms_lists.py |  2 +-
>  tools/unittests/test_kdoc_parser.py   | 37 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)

This seems perhaps a reasonable fix.  Did you write this on your own, or
was there an LLM involved?

Thanks,

jon
