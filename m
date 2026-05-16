Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA225A321
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778895001; cv=none; b=C6gGd8hZJVjbGKTDaOQ5LJVP924pWn2QYfWm77NYFYfS8m6ewsTM8fDxlzGoLTtLxD7ITde/8Y6rXuT3F8XPfbPFdnWBIJMMU6F2fZhZnyP5g4Ok9XQVU3FZLFTMbOulghinDxEzuw2hDe44d6mc5oWh7fIoEWPJQ0dZWrbR87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778895001; c=relaxed/simple;
	bh=Dv7vAwBbItaqf/Cot/SDJCPcwZYK28VcixpRr0NGgMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cTYsoCxIAozOhe9V+L6AFK+kDOWuW4Y9Tc8KSFcKA62svSFRLcc2hjVeM6Ze0XY2K+dHrDvXfTF63bReQ8UK+/IMBH6UTvxkt8+hDIv1plVs9+P5ET3so2ofW7sUuR8gZIK2+cy+t34QnHJcSW21UVc8HTiygWJz1i0ZkOHTFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcR/Y3lL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcR/Y3lL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012D5C2BCB7;
	Sat, 16 May 2026 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778895001;
	bh=Dv7vAwBbItaqf/Cot/SDJCPcwZYK28VcixpRr0NGgMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bcR/Y3lLN00YkTiF98HnJ4eoZTjzTMewOWxnZGTt7LoGmyqjIv4waG6syVhQ+Y3eS
	 4cwRGUWzFop9dSYgsEiv+0zWnM8iQUPNE4d6vpq2ABdyzhlisCaH+liZ9vlvBCOCLI
	 YPhS9wykj9eLiwfRK9/a4r4Wr2Lxcoo3pydUvImBz0TjfgmTyC4s1VVPBfLJ5qH0Zw
	 U7ZvV25wAhxo0JWOscd15UrgTg0J6jNIZWKJvYYFMGkEU/HDyhZLVXxxobJblmSHHd
	 ieXbF/mFJjZkMVMJzwndlNlVL7OKJAdtzI39h6TZ3WUVIOPOxlclibVrn2LDNwtiKe
	 nh/rQKRxWBA8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568A83930A23;
	Sat, 16 May 2026 01:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net/sched: sch_htb: first round of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889501388.218220.5253500706536857525.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 01:30:13 +0000
References: <20260514095935.3926276-1-edumazet@google.com>
In-Reply-To: <20260514095935.3926276-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us, toke@toke.dk,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 09:59:31 +0000 you wrote:
> First round of fixes in sch_htb.
> 
> I chose to send a small series, to reduce chances of multiple versions.
> 
> Eric Dumazet (4):
>   net/sched: sch_htb: do not change sch->flags in htb_dump()
>   net/sched: sch_htb: annotate data-races (I)
>   net/sched: sch_htb: annotate data-races (II)
>   net/sched: sch_htb: annotate data-races (III)
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/sched: sch_htb: do not change sch->flags in htb_dump()
    https://git.kernel.org/netdev/net-next/c/9b949fa69129
  - [net-next,2/4] net/sched: sch_htb: annotate data-races (I)
    https://git.kernel.org/netdev/net-next/c/e54c33503bf7
  - [net-next,3/4] net/sched: sch_htb: annotate data-races (II)
    https://git.kernel.org/netdev/net-next/c/55562d46621c
  - [net-next,4/4] net/sched: sch_htb: annotate data-races (III)
    https://git.kernel.org/netdev/net-next/c/e249ae717beb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


