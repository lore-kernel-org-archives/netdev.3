Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1E43C8C55
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649615; cv=none; b=o2woU4Wr8FcrUxoEe058Mv9yCVyjjllXFY84FiJb7Q/OUme81NnM7e/x1++GF+O7glbUh+8kh89GtriIebBxdvfu2+C4wrFXgRLWPBXLAbkeoLf6XsfJbniBM2SuyWT1SOuK3W5eMkLfgGzRZKKMsE/U4ov+mtPKY32GuJMra3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649615; c=relaxed/simple;
	bh=9/isol+lG66aLHX4F9S+XqJFuU9j7jyi0brDaJqvhJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AV3cATW35qdr2eYpdIxC6NPpskMK8bWQurBsdyJ/6p59q3YMbgVGlgsH9ljl23rOm+JR1tQWxfv6+PBR3+vunil+Ul7ituyncoLx1jeOG4G6FsdgVY0VyoOruFlFU0U6D4iAB/kw5SL7t9agljw3vcZgIdwqqH+vV81LBfnW2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nztX1ced; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nztX1ced"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084101F00893;
	Tue, 29 Sep 2026 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649614;
	bh=meO9rWisp09j0YXCWvjH5HgWG4EBGtFVwZcNLTsQZPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nztX1cedYrChREGt/+Q5xI79E5sVbpB8MVVoJClEhULfa4UElIK/9lzMwrGh+D3xo
	 2sbxDhj9AxXXZtfFNUzrQ3fO8Lc8VKFZ/YtnhEUuer/w9i7lhl7ZaoleOfHb1RFj2m
	 0LM3HSLd/Y2jf51/QU2g9cB/5lqBb0eLLKsyiQ/kJZZybx9MEZdqQatC/3bf6GN0cC
	 IVrU5L4Ke70C9awL44hh/cryztvLuKWKZBnf4HiFuwa84A2F0a0vZLWqkIZcfHPh8M
	 sIryX6GgRw+94/zPxqPou9rpDDPD3x/hPnLxjBLCNP3QLT3RxLaolgbQm44/7lwtrw
	 mLINsTuSGTSUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15E63924FF2;
	Tue, 29 Sep 2026 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] ipv6: Remove FIB6_EXCEPTION_BUCKET_FLUSHED.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064961253.229594.418185835475433731.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 02:40:12 +0000
References: <20260926033355.3295550-1-kuniyu@google.com>
In-Reply-To: <20260926033355.3295550-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Sep 2026 03:33:52 +0000 you wrote:
> The FIB6_EXCEPTION_BUCKET_FLUSHED logic has been dead since added.
> 
> Commit 0346ec2f080b ("ipv6: Prevent rt6_insert_exception() for
> dying fib6_info.") restored the original race protection in
> rt6_insert_exception() by reusing fib6_info.fib6_destroying.
> 
> The flag now prevents two races for per-cpu and exception routes.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] ipv6: Remove FIB6_EXCEPTION_BUCKET_FLUSHED.
    https://git.kernel.org/netdev/net-next/c/c66d93e68728

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


