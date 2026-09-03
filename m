Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04631327F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399707; cv=none; b=L3UOeUoR9gN1B29qEYgASACtrZtWnk55F40toelfObFBIYPN+3vx49qjLEg+EtLOKwAXun3sfoNi8L3eydLX02Iw0k0KrndQ762vEUuPSqQ0fEsXePuoeouOrf52B85FY7wzLmD/jIhwS+Dx3rlzJJxrQPeqJbfL/kC74rIrX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399707; c=relaxed/simple;
	bh=s2R5rNQGr4W7uwJ3L3Q4BQwpWg4YG7Ve5EcD6Tao9XQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V+UmveYbHm+YLY4mvxN9ZaDCDejIeqvFC3kKDKnLrH+jFDvr5wcunsCoU/GGLp6OHqmKURPeKoeDBmp2bfPWYZjZ9o4YMEsG2MeLoeIrr9/+X1CpBVILxCYw3tP2l80TBTYUicUOZs2psHCpkLlIs956rIZ5lgeWB9b9LNcKg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exjhs4iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exjhs4iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C541F00A3A;
	Thu,  3 Sep 2026 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399706;
	bh=A04hIG9piFzu9exbjg8uUx4CuFraW3yLcnZ8vTd3hh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=exjhs4iu5qeGk5rrLT7KeoAy6WXS0+7oGIBaqPTPA/9lu+y6nbk62GxpWP2mIYYXo
	 iz8llb98v7PnupmGSswseYnhPxRn1bNgxrPLVqVQNz+0pMbHOYsAUhuCys14Z+aTsK
	 +oRz1vvr0ZtKRL+FvFYQeZclsEuBSjD2GCL/PNpUTkFXF0mKfxsukNqXkswli+yAxK
	 QJB1qmAK94n9LJStno89GMqxGAx6Nb9F+tKX8YZFvuEyo67O1U637dldBJ5Mr5xCLX
	 1FmzFXO2Uuv7r2SZFdxIUy+jUziyknndXIoerd3PNDtiy3QA5kAFWYaMK9drEhj1au
	 EBtzGgwxrWD9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569253927054;
	Thu,  3 Sep 2026 01:40:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: optimize netif_is_l3_master() and
 netif_is_l3_slave()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839964789.3035212.13147032522474883082.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:40:47 +0000
References: <20260831154129.4048178-1-edumazet@google.com>
In-Reply-To: <20260831154129.4048178-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 15:41:29 +0000 you wrote:
> IFF_L3MDEV_MASTER and IFF_L3MDEV_SLAVE flags are only set and used
> by the VRF driver (CONFIG_NET_VRF).
> 
> netif_is_l3_master() and netif_is_l3_slave() are called in multiple
> performance-critical fast paths (such as GRO, IP routing/FIB lookups,
> TCP/UDP processing, etc.).
> 
> [...]

Here is the summary with links:
  - [net-next] net: optimize netif_is_l3_master() and netif_is_l3_slave()
    https://git.kernel.org/netdev/net-next/c/4187c29c2abd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


