Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7C3AEF34
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523489; cv=none; b=ZE0NZrEeEdX8AUWiSdT1GfumsWt5f8wuy1R0Oi73VbCIo7Lx0QNobqjJLumQydAiExOevfqV3tZTCbIJ0y1Bs8zWmv6fnK4o7450X/g28grFVNiB2gFizlz214B6hY1LhKy1ndB1CfXLXXBMg0uOvjVxCJfAyHzpWACF1y4IFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523489; c=relaxed/simple;
	bh=zsDePw4UurWYdYi1GeWbU4dIdy2imxbk4jv8M9lE8SM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rHYvZO9VPm9+OMlq2uLWsTp/dg2/Sj3Y1exsRbp0SIiaWIwvU779KeV2mwXLSVy72epWDVNQ2/Eol1rb29cJbcaZb7KvaSKlHGNXcmLnGjGNRCSIaAwqbtHYHF4MR5WK9Y6Ho8A7t/JCl1l6/CA2VrUrIEuFx1uJolvyJawmnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfkD1u0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfkD1u0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BDF1F000FF;
	Wed, 16 Sep 2026 01:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523470;
	bh=WYzfTa7B/dKK+1UOwlwhbpCeNLBmLUSD35bS1WuR96A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CfkD1u0O/beAu9YjtNe7/4hlA5+ohuSGhdygsx8j+tfYRNejpbFKhxFpuyuzBc5g+
	 ruXkYu5kKcKHFD+sG3RPgKvzpSa7BKwmmFdXx56xGzx4IZ4iGARc6n+wQPnQ288c5e
	 etIILUlspyUrf5BkDlXMg2Und6wNDvZMql8AUagYjuxWcD9raNdpP0SYuTLQjMPeGt
	 /ralFTfDjlCcdPxJ/FTpMyjCRJ/zHpZR/MeU1oWllb5Zt0G9/n54l0HTK3LmDZmz9N
	 Ft7eZZn0cSIyxBlHM4luQUhDvmA3PR0mV2Dvu+mwnr1Nj/rJC4NI36WvwpwidfZidu
	 bWJx6COsrlV6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2C3927075;
	Wed, 16 Sep 2026 01:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: do not free nlk->groups while lockless
 readers
 can use it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178952340464.2355876.9608476266653618510.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 01:50:04 +0000
References: <20260911160804.917099-1-edumazet@google.com>
In-Reply-To: <20260911160804.917099-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jamesburton@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 16:08:04 +0000 you wrote:
> netlink_realloc_groups() uses krealloc() under netlink_table_grab().
> Whenever NLGRPSZ(groups) lands in a different kmalloc bucket, the old
> bitmap is freed immediately.
> 
> Two readers of nlk->groups / nlk->ngroups do not hold the netlink
> table lock:
> 
> [...]

Here is the summary with links:
  - [net] netlink: do not free nlk->groups while lockless readers can use it
    https://git.kernel.org/netdev/net/c/ceac0de741bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


