Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13F43637F;
	Thu,  5 Feb 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310210; cv=none; b=eOsfA1gI5RccaRnFtTi9GXJjVSUzlV2e0Q+mOKmGRIFRZpL6us848Bqsxabvnsb8RYimSnBpoA4WlE1TpFYRpa3kxyGv9t7k/N74JvFZqrS+qUuL0mAG6cdxrmVmjsTHjoUPNaPYsXCYEHe2PaCKOYY8/GQrV9YT+HRyoSriqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310210; c=relaxed/simple;
	bh=bwROirWkTAfNjI2f2yJb9/uhK+9jithzoZYIkZdzG0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jGv/PgB/XFV7Xm8h9oIP7M0oP86E+tff/xpMbCL46Om8gBOOsvgts6JFrTfvmlDzU6eR860zdI+KYJs9aSe24p2TIvCU5qOERoiPMnQxKqv3ZV9C9u5ytQHhCLUKQnzEdZUdVu8FoN2e0RJ/AoivBDOqdxCU0D2LhRHFztiJCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg+uVnNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg+uVnNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F18C4CEF7;
	Thu,  5 Feb 2026 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770310210;
	bh=bwROirWkTAfNjI2f2yJb9/uhK+9jithzoZYIkZdzG0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rg+uVnNpwwOVIhqtll/3KZ5GyF6bmEbwlIhvqrCFGm9wRHSoH4yVW/YyOWMwEpS6U
	 CxsePIC5EGDMmJeuEuvTmfloTA7GBZJ0EyL2KhC4eN+W4ahxyehvDEgvkzWEeHrD+6
	 /yCIq3dtjg4uPjbAhBMDJXH18qVUrv/5ObDWjh2yElhCewEX6+Ec3gb74Ixwt2vW+c
	 BsSrTqseGpRWUIFVMgOzcH/4lUGdqhzKCat3KYSntPUR8UiHev32a5kwrgJ+NqPLbz
	 N+WFQnkWw4zo3OmHVVn6SV35WLnq6591Vhs8tj8eLF5Nb5LXUt+92+AN5zsakHz4Ls
	 cmFzY5AerHYhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1B83808200;
	Thu,  5 Feb 2026 16:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix ECMP sibling count mismatch when clearing
 RTF_ADDRCONF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031020757.485120.9003745936115169871.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 16:50:07 +0000
References: <20260204095837.1285552-1-syoshida@redhat.com>
In-Reply-To: <20260204095837.1285552-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, fmancera@suse.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 18:58:37 +0900 you wrote:
> syzbot reported a kernel BUG in fib6_add_rt2node() when adding an IPv6
> route. [0]
> 
> Commit f72514b3c569 ("ipv6: clear RA flags when adding a static
> route") introduced logic to clear RTF_ADDRCONF from existing routes
> when a static route with the same nexthop is added. However, this
> causes a problem when the existing route has a gateway.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF
    https://git.kernel.org/netdev/net/c/bbf4a17ad9ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


