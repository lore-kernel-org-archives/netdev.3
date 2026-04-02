Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805FA29A31C;
	Thu,  2 Apr 2026 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094387; cv=none; b=Led/BVB+G3BA/r3z7RjUq6UjMyFeXCTbYJQLcS3m6LRvs0ODc5sml0doGBcPNGmRUJiaQ2GWhJzwBx/SvbtRBC5byEjRpJCgaMWGCk9nNImxPTvVeCUPEN4Nd9LO+o4cuGIR2bmrI1E9kfSTlyVYhNURGXrTwmUM6HJEbKeTT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094387; c=relaxed/simple;
	bh=n2NJsijKWP7KUmJwAnDExIYlko2Mj7kMqQwKaLZRz7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfOo/AYcHxUCk0jmsR0RM2Wm04uSIttFfoKgqxbpMHGoZ1NTi+K4xAE1SHt75B3gOoA1pZDxp+xvT+YEEfeqZTT8D4HFCbRhgerP52LUH7Y1+WWJlZ1GLB1FMWu6fGASbBhlhrO0MmlQoUAch+gqCcYcEjQz0UNS+j0nvK9weEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0x1tZq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0x1tZq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECA7C4CEF7;
	Thu,  2 Apr 2026 01:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775094387;
	bh=n2NJsijKWP7KUmJwAnDExIYlko2Mj7kMqQwKaLZRz7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S0x1tZq+3TVl5h6BfpIcdIh7f4Q7TmQrdygaYZZQg6b88sxdMnV6DRSo/9jBemZH/
	 wHC4Oh5ev71k9ZE/IgZcevTuveqXM1Pn9EPYbm6/BvYUH6r5O1FUSxyMcDldYm5iVX
	 XzmgiLFjyxNNWXfnF05824BKW/jIthbofBWOZgnysAxDUx0BgdPqpOgRe2vHPxwkz/
	 S7L+L5eWTmwKdbYe489mBNvhtjMNZY8zvt8BJ2/Mmoc1SO8WhjaQ1p6Z37SIWkxlhv
	 uNGvyyz6R9ejbiucdpIeOP1steqHIUohopfoYIz92gBOVdJhbc9ysDiW+pEbJHIwXP
	 hHYcvVSmsbBLw==
Date: Wed, 1 Apr 2026 18:46:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Mikhail Zaslonko
 <zaslonko@linux.ibm.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Masahiro Yamada
 <masahiroy@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Vasileios
 Almpanis <vasileios.almpanis@virtuozzo.com>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/4] gcov: use -fprofile-update=atomic globally to
 fix concurrent access crashes on GCOV-enabled kernels
Message-ID: <20260401184625.2641899d@kernel.org>
In-Reply-To: <20260401142020.1434243-1-khorenko@virtuozzo.com>
References: <20260401142020.1434243-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Apr 2026 17:20:16 +0300 Konstantin Khorenko wrote:
> 1. Build fix for CONFIG_GCOV_PROFILE_ALL=y - skb_ext_total_length()
>    BUILD_BUG_ON failure:
>    https://lore.kernel.org/lkml/20260331165125.959833-1-khorenko@virtuozzo.com/T/#t
> 
> 2. Runtime crash fix for zlib inflate_fast() - GCOV counter merging
>    with loop induction variables caused out-of-bounds writes on SMP:
>    https://lore.kernel.org/lkml/20260330143256.306326-1-khorenko@virtuozzo.com/T/#t

Why are you merging these? The should go via different subsystems.
How do you expect this series to be applied?
-- 
pw-bot: cr
