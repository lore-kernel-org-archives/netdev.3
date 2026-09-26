Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD42E06ED;
	Sat, 26 Sep 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383280; cv=none; b=UpzGsNBDYwBkRQg7W3Av+d72kq3xnSQRQLwq+BUWgbKDOCmu//9pvqz/w0ovbiwc44GjKfV2qw8dBz2R6OHFKGvKjjcmX3Y+BacGY8icSqR93M+fDuYLp2n8e4Rlewx51YX2aXFZtw7ZUfIT4wx2OC28Kb5Zjok8+RPLPNsDBso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383280; c=relaxed/simple;
	bh=z3GAY2vLpPv659LHJwUIWnHBnS/gr9hhj0XVHOKpVh0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKk6mHCKYrpqdevXrgqlCROvoZljyLMBQ9jHZpCSiVF5HbvlnR8ig0U0BgbNT31Qb1y3bDb23ogU3Uetby+oa0gt5cFuinKT5YnPZvrLn3ZpplhpJX7hBUKjTiqeD07+LTR28JGnYJNs6Rea0fG6gr879cmiNW1ikeJ1ctdmWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQF2L5mB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQF2L5mB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF401F00893;
	Sat, 26 Sep 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383278;
	bh=xzZcGR0uctUY0cT10StTMQOgfOeApizwhxwluootulg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OQF2L5mBnPm+1dA5D97MvOveguwHgywPqRH7Uw8y3jIEH7shM1T+vuBox3yKrX5a1
	 yPqTc3bnfVdmQ1JkaYWXRjIC0ZlyBDSyaibSVQwHbMLx2gHHWTzOpfg4ti4w9E0IVG
	 9GJJ5ThW0GWW4MMqCuQGUMX53zv92iNpoyYBRakJQyYLKNwc1p4rlmlzHfyIa4t6n0
	 sFgBze7A233pffgT+fOhUX0FuamSjUTJdh4XWBDVpAr9akuwtpcrkKOmuuUr46GXiQ
	 VbaKv1qsHOUSwVBkL3mLzMcGFSsFvdI34NAPIrNiD/LTzAxbXDNZUIpAVc7YkZJcYj
	 J+YpD+xRZXMxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B2A3809A04;
	Sat, 26 Sep 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix prefix route expiry in
 modify_prefix_route()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038320614.3221981.9219867414631543230.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:40:06 +0000
References: <20260923132048.3272878-1-lqs@lqs.me>
In-Reply-To: <20260923132048.3272878-1-lqs@lqs.me>
To: Qishuai Liu <lqs@lqs.me>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 13:20:48 +0000 you wrote:
> modify_prefix_route() is given the lifetime in clock_t relative to now,
> but fib6_set_expires() wants an absolute jiffies value. So when a
> permanent address is changed to a finite valid_lft, the prefix route
> ends up already expired and GC removes it.
> 
> Steps to reproduce:
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix prefix route expiry in modify_prefix_route()
    https://git.kernel.org/netdev/net/c/a7bfaba4823e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


