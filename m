Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7492D0606
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426808; cv=none; b=XbZGbNmXH5kpXY6DQQuoDFF4oUr0G0io8oLgSK4YyuEVPc97ElAFQngljB7Xn6BCwiv7JOohqzDlxK4R2wIyBXZLMc/9dSrFVSKcPqBtTDff4HVMn9+ggFMLXpPqoT4cLBhw/GCNSyUfMNZrENxC9qJbl4x6Cpu/K7/l6k0+X10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426808; c=relaxed/simple;
	bh=qMYyS/LIoLXHKo5dtMlToKYjYIBwcHtvCHj72hZ8kD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ML7hpP36gSxwrVJNolTFnJAfJZCoXAvdn3+xg801oL8VYmwuUbhFsWEVcFkVl+et8PcqI+9JSaoiAJCDOHPaX3Dpuk/JLOvhQyWc0v0w6An5r/8LYoWfJq0SstpJvIFUD7SSI6DHm1+QrLXBoiYJk+tMpY8nws3vbWUb0wa2zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkzjSwtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkzjSwtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9011F00893;
	Tue,  2 Jun 2026 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426807;
	bh=XiY1tufRpmNopS65pLHTuQn4T4B4bPdWy8n09JEVkqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hkzjSwtbD51JeWm7IJPjaIjVf6DaajsBfVEu4a+lYScWX10RWAbj6IUjIdULJL/fZ
	 YJTOHNdyGdiS6O8262geDp0yGSMrlb+8OXIVYFXMGz73ZlPVGkzplH6gsF3WvEaVZ8
	 hIJ4t+Zzuac6tdrejtBLDflgDovoUBp8L1aKNEcGOOz4qV1fvAy1JAcFlKcvjx/yDo
	 G/QiVxEuq5m6JbdjQqMqh57gUXAJ+dY0fU0MGZFDzwNSZf+SiPrLXQw4TyMmfPHmVb
	 IgZdgatTeEBmKjftJW4jGUaPYiEKY9b7Jv/Fu/WHnu2YSfWcAMc1BmhZJ3Z68Lnhmd
	 ddvCTob6RjXgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568BC3811A6C;
	Tue,  2 Jun 2026 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: Annotate sk->sk_write_space() for UDP
 SOCKMAP.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042680889.1007375.2504746674609068926.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:00:08 +0000
References: <20260529193941.3897256-1-kuniyu@google.com>
In-Reply-To: <20260529193941.3897256-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org, lmb@cloudflare.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 19:39:23 +0000 you wrote:
> UDP TX skb->destructor() is sock_wfree(), and UDP holds lock_sock()
> only for UDP_CORK / MSG_MORE sendmsg().
> 
> Otherwise, sk->sk_write_space() may be read locklessly while SOCKMAP
> rewrites sk->sk_write_space().
> 
> Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> 
> [...]

Here is the summary with links:
  - [v1,net] net: Annotate sk->sk_write_space() for UDP SOCKMAP.
    https://git.kernel.org/netdev/net/c/b748765019fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


