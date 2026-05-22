Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B533C1B4
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779488401; cv=none; b=FpQbmm5gL6Bb9BDnPjoNsoH0OaClwgNHdWYJLH4ZPfm2hQmO+E2JBSIZ85Y52+3yFYFG9W8ZYN5jS8oooT8jmmnwSRF0e8XEOUHQEZyHYt6gNUoXUHmLCiDdu0L2MVFF/dlRxBovF95KsF67wOc+kS55vSgR3CYl41Y3yvUZbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779488401; c=relaxed/simple;
	bh=l77Z+Cg1pcOf1lPAvAgHycPTcYyDFe8u8yOPxp+wLO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uYJD/btEx09LtZTU2aJ2fmWzECWArP6Tss7OoWuH0bsJG94JGtk4FfaeaZOI+eZMofnaJDYAwTeoylE0VHHTWIXj3AjZhL98NybiwjR0kafhQU3Ksqrnd490+z+D8h27nR6JI5JROuqZvD/o2kqBivsiNpSNEdu1nC/tyUu8DnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=newq1qcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="newq1qcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A191E1F000E9;
	Fri, 22 May 2026 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779488399;
	bh=lHXVDkkUx3LuoszodFrrMpYeTcoEPpacoX7Mb55E3Ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=newq1qcJfYjV7c7HHP4IJ2U3YvIS+yD9IW9RSpT/68TqOSOWOzjphAnK7GG4XBnRV
	 LAlz0GRNsf4wBBmoxiKubNLtVEVeCKgE3wrfNj7AOILb2esPyb0AW5mhOwePtnkv//
	 8S6mQD4IzzZuJOs91esH+mTYTUshQBKfEpUY/ZYCHYXglLanqMF7SeEvJjbOhXmNVP
	 uDbozAHQs3XcTriILCJowdL+WKcV8LHz+LE3r3ctbI5GBUwbqFVcHqCJcz4vSwTH9L
	 04tAKTPjtXTLQoa0n3w2WG/yOFPEkSlDkgYUGs5Gcx/j/sLkUYLwBu42UA0kaFOO3r
	 1ZawbS8nx5abA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E8B393100E;
	Fri, 22 May 2026 22:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ll_map: add RTEXT_FILTER_NAME_ONLY to
 ll_link_get() and ll_init_map()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177948840844.1388561.2773222852653465091.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 22:20:08 +0000
References: <20260520103043.1131213-1-edumazet@google.com>
In-Reply-To: <20260520103043.1131213-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 20 May 2026 10:30:43 +0000 you wrote:
> iproute2 can spend considerable amount of time in ll_init_map()
> or ll_link_get() to dump verbose netdev attributes, contributing
> to RTNL pressure.
> 
> Add RTEXT_FILTER_NAME_ONLY new flag so that rtnl_fill_ifinfo()
> limits its output to:
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ll_map: add RTEXT_FILTER_NAME_ONLY to ll_link_get() and ll_init_map()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=de91e928ff57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


