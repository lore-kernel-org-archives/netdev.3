Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC556298CAB
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639189; cv=none; b=Isfb+9Hxkges2h7Ie3d7/nh5pWbWN+U7OKG+FDTKQi5tVJN0yrvKyrSff2rcSUahvL9GwyqJ/1BybaIEaZt5Gh06Gtvd0p3yOG9q9Okhbyxh/zBmDQoiHR3nyQ15sL3DVP3kXr7nKuuSlKXq0b3DVqQqelcdzI0IvBXK6e8zmko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639189; c=relaxed/simple;
	bh=s6ynVHDDva3Mo4goMbPQ49wNqrtQYRgUKBB37EJOhII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ6sQxZR7c8bV3QT9/HPnCzOOTS6Ob1p0UD06x2yGL+bxC55xEWxvFW9hsD3p6m5Ztzfw6J7PpBP15FVU5uSiniU21yVcKnME0Vyu6uqH0j2MJyKPM+EaMrJD0EVNxmtlbJySb+dR1IgwtZSpKU2f1iT2+l42Xx6eGCjStp339g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIQV6jFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIQV6jFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34EA1F000FF;
	Sat, 10 Oct 2026 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639188;
	bh=76j6DBehfiXQ1IJ2xBzZWMxYnD8ukNISfK7pxqxjLxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZIQV6jFJ3LSMollwqURLPOwa5ZN9RIJ6Zx+F1B0QtO7qC9TWDE65yzdhQlD1Ts9mT
	 fhFrkrQ6J3wKorg7Mw2JXqoZJMwk+SVzMiDhJwXn5Ku0fWs6xARknnSUKS/gn7OxtZ
	 2UP7R3zkBXSQ6tDf/NwL45eau0/F0u4ZxI4kWOA6NQqpTJ/JRx6fw+DHScrXkulWGD
	 4eZB+9j5PLHmHMefnbuyzymXtNLibBvZASUlZIba4L1EyI3ej3fYqGZfz2Bnnckjqr
	 +6xuNTATwWlPXvJIAXJfB2AfSf0IiDq/SyTQ/9NrBaI9nAIKwNltITy0xLjCPCk6kH
	 UoD5g5pHlgI9Q==
Message-ID: <35dfb32f-690c-41cc-a12f-156bf5eef7e7@kernel.org>
Date: Sat, 10 Oct 2026 07:33:06 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] ipv6: Report netns cookie in
 fib6_table_lookup tracepoint
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, daniel@iogearbox.net,
 petrm@nvidia.com, ferenc@fejes.dev
References: <20261008133158.1438907-1-idosch@nvidia.com>
 <20261008133158.1438907-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261008133158.1438907-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 7:31 AM, Ido Schimmel wrote:
> The first argument of the tracepoint is a pointer to the network
> namespace in which the FIB lookup was performed, but the tracepoint does
> not report information about it in the associated trace record, making
> it impossible to tell apart lookups performed in different namespaces.
> 
> Report the network namespace cookie, as commit 27cb3de7f43a ("net: add
> net cookie for net device trace events") did for the net device
> tracepoints.
> 
> Assisted-by: LLM
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     Sashiko: There is a pre-existing issue here regarding an uninitialized
>     gateway address. I will take care of it separately.
> 
>  include/trace/events/fib6.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 


Reviewed-by: David Ahern <dsahern@kernel.org>

