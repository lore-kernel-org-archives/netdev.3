Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE915E5BB
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676008; cv=none; b=NktwqZ5q9o91Flss4EfYJnr3xo/n7MPTLQRuedL691ag1uOjly2GPpJlf6+711wy9YWLIjst/QgSmeIYIz2G3X/joK12cAHHGMoue9MwztAoi9qEGCaNjFV/bHG9WF2hQ7RL8PaQFqgLied+QTLTTTMYwcN39JmG1Cwry3QYhIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676008; c=relaxed/simple;
	bh=3oBIfoSoUNeNabF21znYYwU/gfSmDQseTw8Wo/LGTt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TDDQiBeE6STKc1RqxnIlUGedJD2sX0S7t/1nfHsEPfdh6fRMkp1Y141BnoG4hYWJ2eGnqwb7KRqcZxLk3AR3Qzg3lETuSAFaLnt1MrGQlVcWsUzi8T2T/ZFoG2TO8NX8kdOr4D69wGaj8qIMZJEme1PniPeL1PcEqCPioaXX0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUfogM/m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUfogM/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D5BC4CEF7;
	Thu,  5 Mar 2026 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772676007;
	bh=3oBIfoSoUNeNabF21znYYwU/gfSmDQseTw8Wo/LGTt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JUfogM/mtnlQkemzAabe81x0TW8vnZ3m4/i3brYkJqa3/pE6+zqW3MCtLD/0KQxah
	 Enz7yDbTS9ciaAl0T6tZ6YC0vNJFgYoqOgMj6vqyhYbNbLBYV6cRBS9EWetImAEgMe
	 99QVyzQv/Ve6tgZhW5fB5bXYfq511mJTK0HOP0KXK+t2rVsFmqeYoP0DNeJMYXyjdk
	 t/BZrV0f1YXUwD6U7rzDQEhbYdQ8fROFJqy41jc8GVelBbCtbIpvWxlAB0d86DKAWr
	 JrA5sZ22RudJ/tDsIKv+5cppCzgQHegGdJKv/T/Lg7hJF3mUT5lzO8q278YX5SasQb
	 ln/+RTcfZK5iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 400FB3808200;
	Thu,  5 Mar 2026 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267600779.2478763.12939988103290560852.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:00:07 +0000
References: <20260302205527.1982836-1-edumazet@google.com>
In-Reply-To: <20260302205527.1982836-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, w@1wt.eu, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, dengzhouyan_nwpu@163.com, fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 20:55:27 +0000 you wrote:
> This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")
> 
> tcp_tw_recycle went away in 2017.
> 
> Zhouyan Deng reported off-path TCP source port leakage via
> SYN cookie side-channel that can be fixed in multiple ways.
> 
> [...]

Here is the summary with links:
  - [net] tcp: secure_seq: add back ports to TS offset
    https://git.kernel.org/netdev/net/c/165573e41f2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


