Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D53DEAD5
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751366; cv=none; b=dJAVcj0CoEAjuN9uAx2kmfTpylnMfVAqzsohunqNVvI3CSbmL+Ou51lW9f+dcF0/GRUTR1fbcztz3pBbGvUxQBQ0tzsYMXDsRE1OZsl6Uv3vs70Mzl13Mi21zi7MflLjNa7F/5Scr+xTNnlbZHYgA7/O+mBYGA62cGDi86rWhOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751366; c=relaxed/simple;
	bh=Oumki9zWNDQlo4sxMbmCizLF8bgRDh3ABn6y358OUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6m0afN8yhkrZG/HwaTyezgJxCcdoCXOCCRjB9j3o6dDnVCQ4/tRrn9ELU93YpzyK2wP9ESEIMbW8vwwtwc6+z9fly+IbC2djG6OOlwh0qNiXLGfR4Bjut2VuDKvlYXpffZYpYEU2cop9/f46Q1nMeLXKqCPMnDQbZZJJkBp1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvpF/C7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvpF/C7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94C0C4CEF7;
	Thu,  9 Apr 2026 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751365;
	bh=Oumki9zWNDQlo4sxMbmCizLF8bgRDh3ABn6y358OUoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HvpF/C7ELLnu99U4oQSXbd7wEADnGuhVvHSEoJxzFoiFMCyuKCcj5LWeTd51ULu5C
	 xMXe67YH4nSSWKnML6txl0OtP0oFdYnMQXsb1XZEfGuLAYDu6TLhVZ+qMaKK7Zl4hL
	 uRmylBEFmA0nNd6Ybfptd0aq5Vou/92aPQ9P8Od6YKZU9qAhMj2EjtV/rG6yVd1Sws
	 siQxfRf3GhnjwzayGHN90JztZ3DOJR/5xS3QzxOaZy73ODg2kvUXVgizvVr9v2N/Cv
	 yZBi3yF5P5Qb4hITgeb41FdqVT0wodl3vOoxtAtekVNnLvzzWOAEkogOQLGsesMJvv
	 dK7w7jtcl5LsQ==
Date: Thu, 9 Apr 2026 09:16:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>, Jes Sorensen <jes@trained-monkey.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v40 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
Message-ID: <20260409091603.46d84c91@kernel.org>
In-Reply-To: <20260409122130.129416-1-xuanzhuo@linux.alibaba.com>
References: <20260409122130.129416-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Apr 2026 20:21:22 +0800 Xuan Zhuo wrote:
> Subject: [PATCH net-next v40 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor

I asked you to post not more than 2 versions a week:

https://lore.kernel.org/all/20260316195252.7fa24729@kernel.org/

This is the 5th posting since last Saturday.
I don't want to see any more posting of this driver until after the
merge window. If you violate a direct ask like that 1 more time you
will get temporarily banned. 

And of course this posting is getting discarded.
-- 
pw-bot: defer
