Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115382E7369
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639265; cv=none; b=lAFRBHol+fCdC+TPLfX00PABME0B1w22wzWLEiclOxNgZeCqNxoq07IUu5ziswZnzzEUtcmdcJ28qD5SkCjdsM+5nbanUOrNgyllH10tmZ1f1B1Q99byO6K8iSwuRW4Bg2fxk3lSNbYYmYAfU1ZgSRSjWjzfAFMAtRjMlzukpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639265; c=relaxed/simple;
	bh=zAptzHZdMyuwoseUlMTV/l9jwqQXDVdIsBT35oD5EiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMlVdX4qpxW/wcAAquSlZ8EOjSmA41AUOoKcrjo6eid9Tn9t5EdPKi6k8AquMvBnlc3IPw60MKSkbCH3/ktG1aZznkxMIZj/4Q7i80CUYFOfgzHIiHjfmxC7xcKV/06FReH0YoehQW2M1Nl46E4sCVED2eHyQ9zRo38P2ra0Jxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE9md2qW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE9md2qW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B991F000FF;
	Sat, 10 Oct 2026 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639264;
	bh=mbStRfl66LnN1iBZ1d74mbPcMMYGwqv35tUZ+ToFTM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EE9md2qWci91fMe9/GkcjOJ5+JhkonTWOPWbw1ggd4kAZMVirfgxpQH/TTHqXyAC0
	 cTmDKJCG1FlcLuIgiydCGVPHwQw/V7VE/pa8R/ZntzBvj6rSKqPHhzUAOEgZIJ5UIO
	 1KRhDmORutz5VKAzUdsLwyuyKITEIx364Ww57Z1IEjCh3Kjxul9mcDVcMbob3CfzSb
	 M0Sez5tO7HBOJy/jKm7DluSzY9lDV8ZeVdCmbg8/Wwj6aJlpKvoc6mYeQcqCYpH0vF
	 WnSjF4bj336jrnv2i3bj9gMavLiC6kW4zQUuKkJprUM5GDMr5QQVDI3J5Iz2qLwl5J
	 bD3/v5ajtNxyQ==
Message-ID: <9dc71ab5-9cab-4404-aacf-b05fa083e58c@kernel.org>
Date: Sat, 10 Oct 2026 07:34:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] ipv4: Report netns cookie in
 fib_table_lookup tracepoint
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, horms@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, daniel@iogearbox.net,
 petrm@nvidia.com, ferenc@fejes.dev
References: <20261008133158.1438907-1-idosch@nvidia.com>
 <20261008133158.1438907-4-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20261008133158.1438907-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 7:31 AM, Ido Schimmel wrote:
> The fib_table_lookup tracepoint does not report the network namespace in
> which the lookup was performed, making it impossible to tell apart
> lookups performed in different namespaces.
> 
> Report the network namespace cookie now that the namespace is passed to
> the tracepoint.
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
>  include/trace/events/fib.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


