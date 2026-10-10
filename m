Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268A298CAB
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639247; cv=none; b=FbRXkjMFgthGwgnL7NRctEiseRmcCdJYul2t6JI5Z60BqGlAY+PGDwmo9h8oaM6yBrdPrQQlRmAt0tC/lZKCMgK6O0UESK80IELP+WHGZy7YBZrxyStncx4cPBPl4Pt8uDYuM3fT5MrRp41k7gJ79GLgzAdFV+X1px15NTZwUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639247; c=relaxed/simple;
	bh=0FW8t9ZBkQy3zNJDOFSQlfapGF7siBhBw9CMgFYWLpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/HwygcBtQ7vkBFqDIBr3dPWwQX31Fo/uvqxydPLwXG+TwCoWeXYoQVcIIpJFlzT0ULUd2kFxI2ck+ea/+z5lfjEvEJ+tI67WaoQWySQzEibcu9XUJuuABk51yOjmbdcgUf5Ce4dIsc9Ac3733hNkeZprXvQADEm7qvKqPxGEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMwEYkCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMwEYkCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F209E1F000FF;
	Sat, 10 Oct 2026 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639245;
	bh=EkUlwaVc4wdGZN8BMKhaD2tkYCp4SyIbCRE5qKkmCSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UMwEYkCAMw2JrYA4jW4ZlpP7ErkWoCYKgnDeZ6uMhZMwpdtaGM4oCkrQvu8L5Xhtr
	 aYBLdyl2kDsIsbPdSXnB3fwgCYntDIM8xf+q0SqVFg8sRqaGqNG4P0B8tmptkIhzXv
	 cB95Cip2qL8MWb1eOgYYzPrBphZB0+LzBFd/qoLYE6h+yedzPzTXMk8XUbKgm/bYDR
	 YJS3Cc8edTKjln+tD+kt3e6hjPtjjGB7t9B3Np/h5guftQFJ4vsbS8b0xZ08TLaNhZ
	 XRoTX2CB6nw1GZ9Y51eTcQitAqjolOAn9oPUWNbEftZJlm8j+w3ELVyXt5Nyj5VYPr
	 aN2aH823nBpuw==
Message-ID: <0caf7eb8-e4de-40cd-bd5a-c1a1d96a82a1@kernel.org>
Date: Sat, 10 Oct 2026 07:34:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] ipv4: Pass netns to fib_table_lookup()
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, daniel@iogearbox.net,
 petrm@nvidia.com, ferenc@fejes.dev
References: <20261008133158.1438907-1-idosch@nvidia.com>
 <20261008133158.1438907-3-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261008133158.1438907-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 7:31 AM, Ido Schimmel wrote:
> The next patch will report the network namespace cookie in the
> fib_table_lookup tracepoint. As a preparation, pass the namespace to
> fib_table_lookup() and from there to the tracepoint, like the
> fib6_table_lookup tracepoint. All the callers already have the namespace
> at hand.
> 
> Add the namespace as the last tracepoint argument so that the positions
> of the existing arguments do not change and BPF programs that attach to
> the raw tracepoint are not affected.
> 
> No functional changes intended.
> 
> Assisted-by: LLM
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  include/net/ip_fib.h       | 12 +++++++-----
>  include/trace/events/fib.h |  5 +++--
>  net/core/filter.c          |  2 +-
>  net/ipv4/devinet.c         |  3 ++-
>  net/ipv4/fib_frontend.c    |  6 ++++--
>  net/ipv4/fib_rules.c       |  2 +-
>  net/ipv4/fib_semantics.c   |  2 +-
>  net/ipv4/fib_trie.c        | 14 ++++++++------
>  8 files changed, 27 insertions(+), 19 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

