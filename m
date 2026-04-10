Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D932692C;
	Fri, 10 Apr 2026 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792441; cv=none; b=PDVH4xE91LgjacQMhRX1fEjoN5xJ6Z9/N3rWg6oMM/ZbRQf+kowwrt447zHtIoc/KHpExmzoWZ0tl80lG5QFQlGY1XoZQ8/glm+SwceVO8mroDViylIwi72E7WeS4cGa2u7jt9mHU5TyFJoSaG4AFOtqBzNWbL7E1QKQLgP8Qds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792441; c=relaxed/simple;
	bh=47XOPo0Emw0+KM/NUPQa56Op6psTg3p+6Rwhf22g+Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cm34zreyRDdEGEhXayyWzOwfrx+U+3/M3hn8+/CS68jKPgDgDJ+HQb8LdgRrw0ibpdYhwfibq08FukXlS+xtKXbyEVoGWtxRFtdoAZ1pSLwrrliV4TajrnAXm8XkRf77T0/Qne4YHZB0Qa5cp7ybaiZfBOaIN4XF1ujMpG5t3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+PL5e+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+PL5e+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D10C19424;
	Fri, 10 Apr 2026 03:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792440;
	bh=47XOPo0Emw0+KM/NUPQa56Op6psTg3p+6Rwhf22g+Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c+PL5e+wk7L9UJjKREsfhqdg4gtPFrYi5PWgPJ0Zh2q6gmDaITyYDm2wDZ2VJC47e
	 ZQ9af45kBEGA6vIv/8BUMMpR6nJ8vEvx2KgiDE/3gB/dDDG6j4cubwdVfpwz1KqfCL
	 WK+OWTgSAa0zjY45QK50nxVb9cNmekIvZCNwPk1Qnz6OqvX7P0pm1N8kOt3FqEedgZ
	 VOzOzbfmXyEQiM4xGsQTv38oPOYooF2k+uXwl5uFHxT0qklWYakzmOgDI6z1kY/Dh3
	 e2xgX/GlYU6q/Ka+b/uupbxmZXpgEDZP647wgcrsqsD75BIdRxB0Or3eNDB+XL5scg
	 1fl06f2G9ftfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE3C3809A22;
	Fri, 10 Apr 2026 03:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: Use wake instead of start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241604.1854480.10464243149429133196.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:16 +0000
References: <20260408002415.2963915-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260408002415.2963915-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, dg573847474@gmail.com,
 edumazet@google.com, horms@kernel.org, jacob.e.keller@intel.com,
 kernel-team@meta.com, kuba@kernel.org, lee@trager.us,
 linux-kernel@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 17:24:15 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> fbnic_up() calls netif_tx_start_all_queues(), which only clears
> __QUEUE_STATE_DRV_XOFF.  If qdisc backlog has accumulated on any TX
> queue before the reconfiguration (e.g. ring resize via ethtool -G),
> start does not call __netif_schedule() to kick the qdisc, so the
> pending backlog is never drained and the queue stalls.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Use wake instead of start
    https://git.kernel.org/netdev/net/c/12ff2a4aee6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


