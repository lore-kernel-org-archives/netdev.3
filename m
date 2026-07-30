Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317827CCE0;
	Thu, 30 Jul 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369664; cv=none; b=lsQRqm4Nq14NIyl9x6mNfk6+3La8J4Jghiz79ijkE41kp0Hg51HsY3LKqmIH9WyrLGat6H0NMbqNl1cQApJFmQNEkWdtku160SP30x2/DsqE6yunOWjH9kOPL0hJ28gC6a2HSmnbq6TSLN4G0vscnqN3N+N76E3G+yYdlgZzgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369664; c=relaxed/simple;
	bh=xb/c31AwIJ+L9NQQAVbjcoFa6TZj7N6iRsV8FRuLPBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PqS6M054MJV7wvBU3RMrhYnsBjTxpulO6tcV6bqKB/ZLuUgSnwMIGt+NEhGFIMX0D4oJUHWIwzgvbtEUfy1lu/zPllS+NZPfKIgiWtxEYqZM8/1fJtNrXHSuTTcpnEZTSM8Zmnsm+y4urJweczlMGWILOroEOZrMZ/tlL17E9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D01E2Yqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D01E2Yqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE21F00A3A;
	Thu, 30 Jul 2026 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369661;
	bh=tzEvjkZNN7x0GZnU9q+XRke+7M1WypM4AXOG8+DibSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D01E2Yqhmd60neUroB0CRvQWpkXU72qLcwQyBDBc7yjxwRI7KUg0ML4KkqfU923OZ
	 2oY4ow1ZECGWr9UTwEV1qMk0m5aFfdQah4fK74kPC1+fZii33KrAgHzD7K/ruHTTMg
	 Fc7ply65z0YGNylOfC74Jo9DZEtY67aKNtc8UtwoLlkrYl1WZWdLRJnI0kH/TSR/Yx
	 v/wyrgnpcnYnZCtqOIDMfUV52HVQyVXopGUiff2fXMmFx2tw9ZiuPKk4s/PvA1F0/Y
	 G1De9l2O1jUQL6MImCN9bFufOaQkAhymRlURoVO/esrI/BkIl567lsRdmWi0BesdUQ
	 i6IkPj6cDjijw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BEE3926250;
	Thu, 30 Jul 2026 00:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: release fib6_null_entry on subtree failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178536962489.3288516.2722182097156925411.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:00:24 +0000
References: <20260727185339.1545169-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260727185339.1545169-1-shuangpeng.kernel@gmail.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 14:53:39 -0400 you wrote:
> When adding a source-specific route creates a new subtree, fib6_add()
> installs fib6_null_entry as the temporary leaf of the new subtree root
> and takes a fib6_info reference for that holder.
> 
> If adding the first source leaf fails, the code frees the just allocated
> subtree root but leaves that hold behind. fib6_null_entry is a per-netns
> sentinel and is freed directly at netns teardown, so this does not keep
> the object alive. However, it leaves its visible refcount permanently
> elevated and can eventually saturate the refcount on repeated failures.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: release fib6_null_entry on subtree failure
    https://git.kernel.org/netdev/net/c/93cad1f6bd1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


