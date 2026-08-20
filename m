Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90439D6CA
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255464; cv=none; b=a0vpX8VhdJ9UfbGRLfti7X2cR2musJHo+UGXlc0h5wDizduq8LuFQEP0jF2FPcp3k49zIebXtNqjhxqgw1pMFobYhyZuapaJmZhXIG5L5gfCdDDUJyFq44ViRCzQYDZlwSgcSzvk0LKA1bBDe59jztwhy33/PHgPitADPwPgH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255464; c=relaxed/simple;
	bh=UGxe5IsITOYVsm8MFGa9OZEe9VtGLjqP+bavvTthmjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gDQ4V1ED2TYdy6/+T6cvPMzOcPRcGutN/R14CzJTYUFymbjBSZ4lAi2UmoJ1+bpGpRryQsGyNkb3uPLLChfZ/dZthw0BprefTZyxeib6nX7fTJB9dQqJ5lCKyzIRjkhssTqcEwjnYgiqWpkjF1xAuQi5EpNoEjZUe5j3GNrFcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO+G4IzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO+G4IzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA801F000E9;
	Thu, 20 Aug 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255462;
	bh=nQTwOUt3ZBVKu5oqjiP+HW4LZw8Uwn7fJ9WGHyOJ+TQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bO+G4IzNcCGnPf5siT0irXiLuqUZc0pr/QiCCbeMdKqejf5vqeQjk78JKeQ9OOsY4
	 7jDejeEET3TpgVpst/WXGFYqzwmwrH2rhJgppSLhDqUPeoK6udBMHkS/nkngAgg/sn
	 U5CMu0HVQTKcwc5RFD5mundEl+n0JyvqX3ptCmTaGCqKp9b78kHiuIPMloitWqf9oF
	 MKyvVD21t3zb4bl913SSwSvXFNJuWl/lhVvdmSLkymMQcWpqLdlQKJ9rvDeuJ6Z2W+
	 1uT71F1F/KOjdvt3I6T9mlTmnohi+qSpmPGT/CgNSkqHAI/G4ESTr/2H9e5NxjugO6
	 wHTqWkb3fIbHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A7B392445B;
	Thu, 20 Aug 2026 19:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: add missing ref_tracker_dir_exit() to
 net_passive_dec()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725541238.453960.865428404528698321.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:50:12 +0000
References: <64254d80-9248-466c-8108-95f43bd71117@I-love.SAKURA.ne.jp>
In-Reply-To: <64254d80-9248-466c-8108-95f43bd71117@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 23:08:15 +0900 you wrote:
> I found that trying to read /sys/kernel/debug/ref_tracker/* causes NULL
> pointer dereference crash when alloc_netdev_mqs() via unshare() returned
> NULL, for commit 9ba74e6c9e9d ("net: add networking namespace refcount
> tracker") added ref_tracker_dir_exit(&net->refcnt_tracker) to only
> __put_net() path whereas commit 65b584f53611 ("ref_tracker: automatically
> register a file in debugfs for a ref_tracker_dir") added
> ref_tracker_dir_debugfs() to ref_tracker_dir_init() path.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: add missing ref_tracker_dir_exit() to net_passive_dec()
    https://git.kernel.org/netdev/net/c/f85dc137aabf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


