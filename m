Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21BE53C3A5
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985010; cv=none; b=YpW0JixB/FpMyjKAEUtNAuyQYLMDWdj+aeqrBWBgX7PgqT2X28cyfulwIOULucp9/G1MnpObnoqourWl4ko92k0AAzS4ukox1mIc2oSIUrZo5mUN21ptnYG8Wyo4VK6iTM/yRfv4tuPnn1IjDgwwI+BU6Tuf33f6y+7sQRqr3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985010; c=relaxed/simple;
	bh=N+oq3Ijs9SOOq5CootAwMaDw0HUY/xdJQ6LdDDk52Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6ZS0Ok9tWkiyZ2K2QTlYpaQRuYeQsxPWSAiKMhp29HleK9BE8dkRvkvfuEX+FHVAglix3jbzmcbU3F4nGTmIgrWm94XRz415EoVY+P66GT0kWBiJqI5CCNMSkG+z3+bS5lNOuHRZWA5yHKwFRjjqbnDeRso7rbg/RGwf/CvetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKn4knAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKn4knAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEB41F000FF;
	Wed, 14 Oct 2026 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985005;
	bh=flTJf7udDn3iok7xarpzKa5cXgx48RzdBTP+3YCrmWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iKn4knAXFQZp3vQZlmWYi3X+6RmVAM3L5H3CDSszy1ju8cc79g8V+5yta0s5JgZeN
	 xPfRcI1HVSJHcLT8UKAZSoGEMFghF/hE6P4c+9nOTIMqIYNVHteY9/vLjM7UVETZH4
	 QBoirAQjvIHhiU3daMCeMDQeFwtvjNPPPQLEhljIGgGhyGAHOIJKJPfK8EeGm4f7wf
	 5iClq7X/BdaNPHgG3dMc97SrisHUyJ7kNUuF4IdvdEGsj3Avs9Ix46PCPaKlsD6rCn
	 ENXkBC8DMGL+dmAy/rWGXgcyvuBqmfUN0aAXkGc9se+aIIYNgMhIw3zUJ6W0phN4eZ
	 viwallRUmJIOg==
Message-ID: <8be92dde-b8c4-4573-aa1e-4ae240b9760a@kernel.org>
Date: Wed, 14 Oct 2026 07:36:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] ipv4: Do not pass netns to
 fib_table_lookup()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org
References: <20261014082612.1280756-1-idosch@nvidia.com>
 <20261014082612.1280756-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261014082612.1280756-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 2:26 AM, Ido Schimmel wrote:
> Commit c436a624f89e ("ipv4: Pass netns to fib_table_lookup()") added the
> network namespace as an argument of fib_table_lookup() so that it could
> be passed to the fib_table_lookup tracepoint. However, the function is
> called in the data path and the namespace is only needed when the
> tracepoint is enabled, so the additional argument is unnecessary
> overhead.
> 
> Instead, pass the namespace that is now stored in the FIB table to the
> tracepoint. This way, the namespace is only read when the tracepoint is
> enabled. Revert the signature of fib_table_lookup() and its callers to
> what they were before the above commit. The tracepoint itself is
> unchanged.
> 
> No functional changes intended.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/netdev/43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@redhat.com/
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_fib.h     | 12 +++++-------
>  net/core/filter.c        |  2 +-
>  net/ipv4/devinet.c       |  3 +--
>  net/ipv4/fib_frontend.c  |  6 ++----
>  net/ipv4/fib_rules.c     |  2 +-
>  net/ipv4/fib_semantics.c |  2 +-
>  net/ipv4/fib_trie.c      | 16 +++++++++-------
>  7 files changed, 20 insertions(+), 23 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


