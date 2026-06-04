Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23D7261C;
	Thu,  4 Jun 2026 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535659; cv=none; b=K8GnL6n9UpifVZBAZjP2/99SSkAzRZm6/QFe64IgMiCcs9cFw0QTG6AkWhLWVv44qoV1z5/svM5ms/xnloDjbJEAuu3XpJknWMXwmOq76WXEg1HxBu6P/tsKBGWEmvweE3JIT877+POfDX3Bx0lrZfiizO28MRCLLzQhxM9uGjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535659; c=relaxed/simple;
	bh=m0JY9j1jrJGxguon6EA9o6IK0CyvDX9kCdJH0Et+kQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W1YkhasO5/lgvJAI+lBdLsssZG6AnCKiQFmzysL0wsL9XPWfT1nuG5nL9yAD7HRA60ipATbyrlWwJRve4VVDe+Nnis16tJWGILk65d+owMGuewXVHVR+iGJDTDjjuVVZyJU963Keqj9d0fyHkENuhtH7AItrBwgZCHSEhLfvKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJs3RyUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJs3RyUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36111F00893;
	Thu,  4 Jun 2026 01:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535657;
	bh=yPE0Nyv/KgTnVjzG/2No8SWrXIVPmBJhSxad9PYvHGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KJs3RyUqES/iZom1cpuPl4fHDkzJzHtXw8fr2gdIFYvNPO2MqikEE3qkGparSP1nQ
	 uQeqfLx4cHMJfDMmMif9nmNyVnlYXsaSuzt8cuz9CQTpzF1ZFzSxhp6uvzqvbrDck9
	 fEkl8Nld9v/eZnBP7IopQk+QybvAj1np65y6TNZP1cXM0cDbsI1nCgDtshJlVai22u
	 FRPfoDa317erRTkZ0kCZNI1tfZ1lz4wAhOW17JdnhNwV3eSWmDBJCLHafxFVDepDfV
	 PSvizIBdGC/4K/hQjLLwoNAUzoUw2CCoSvVP3JcpOI9kmaOfxu7kGItJrhyxIH7IaK
	 ug9BK8eARYWBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0239308DD;
	Thu,  4 Jun 2026 01:14:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] appletalk: aarp: zero-initialize aarp_entry to
 prevent
 heap info leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053565889.2042071.17791761648159069507.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:14:18 +0000
References: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260529105017.81531-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, hxzene@gmail.com,
 kees@kernel.org, linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 18:50:16 +0800 you wrote:
> aarp_alloc() allocates struct aarp_entry without zeroing it, but only
> initializes refcnt and packet_queue.  When an unresolved AARP entry is
> created, hwaddr[ETH_ALEN] is left uninitialized.
> 
> aarp_seq_show() later prints this field with %pM when users read
> /proc/net/atalk/arp.  This can expose 6 bytes of stale heap data for
> each unresolved entry.
> 
> [...]

Here is the summary with links:
  - [net] appletalk: aarp: zero-initialize aarp_entry to prevent heap info leak
    https://git.kernel.org/netdev/net/c/2cdeaba5a108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


