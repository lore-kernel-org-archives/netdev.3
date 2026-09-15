Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D2457E47
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516273; cv=none; b=mJaB2MlJJQm5OZG9Zcxo+ssOqK+ARiLXsoPrQ6ghJvg2heffq8FkRNnvguI50bHGMtSaSFxZPMdz882fY/UBYGK38XcP1fqZa3bv8xRmVZfSsW5O9MgSiK61g6h/jmcr1Xkw87gY/2MVnJ5rJT28kN/ZSYQmCdLPF4tvxt9uIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516273; c=relaxed/simple;
	bh=uxluyVBF5GI4tVyYToI3fFmvxdnijnGWC4WeLyoUpRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ovetMYVGTkWfLvNI1rew4JQYfcb6UCnFfXvjlSf0Rn6UdoOWV0zRPYGTfHorWvZt/y1nJ180jArZkbJ7QXaHrDCH7yJbA/hFSOERsDtbOudot7rcoJi/QZZ14dwiA46fKsIyQhVz9ZUDrD438pwkU7w8zDXPIURidB5l4faGLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSRivCG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSRivCG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAFA1F000FF;
	Tue, 15 Sep 2026 23:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516272;
	bh=we8poFa9T4N4/kqYU2cDeGkk1ZBMldrgtduMlJ1PsmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aSRivCG3BjEFVQzcgInvady3PMRQ8E/UJC4R8QI7O0WMgp/P6NEBJywLp8FGdA5ml
	 L4HNWE59/N0qPU9hE2yCmUOWjj2VsmGsurjqW/tbAmR2cU4xGMa7GC6eRLltCsUN55
	 LKDpAmRRE8ZOFP7Dp70tBCmIW/JNDZXSOJ8jm1BaRkCywKGGtiMaUMF9OcjIHy0LRO
	 SOIa60N+ycNqsznZUGqubFwgketU+sor99WINm4wq2jinZoig1Z3VuuLvkrzLu4ptT
	 0XAZcxIz6/p+bOkYqEV5Og2Wv+Bfxqg1h47KXx+8qc2KQkEtQtXa1YoNRxCxwtYkGe
	 tEngv+rlQR7LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389D392706C;
	Tue, 15 Sep 2026 23:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] af_unix: Fix inconsistent scc_index.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951620638.2322156.1829619954847633957.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 23:50:06 +0000
References: <20260912030852.1467872-1-kuniyu@google.com>
In-Reply-To: <20260912030852.1467872-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 03:07:50 +0000 you wrote:
> James Burton reported that a single SCC could have multiple
> scc_index and unix_vertex_dead() fails to detect a dead SCC.
> 
> Patch 1 fixes it and Patch 2 adds a test case.
> 
> 
> Kuniyuki Iwashima (2):
>   af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().
>   selftest: af_unix: Add test case with mixed lowpoint in scm_rights.c.
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().
    https://git.kernel.org/netdev/net/c/4a4263dfeaba
  - [v1,net,2/2] selftest: af_unix: Add test case with mixed lowpoint in scm_rights.c.
    https://git.kernel.org/netdev/net/c/b645ccd41054

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


