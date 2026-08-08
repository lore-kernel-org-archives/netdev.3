Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBBA286417
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151457; cv=none; b=atBGui0wueTRHqJtrqaXmS8T592j6jAARNdVnVnZ9BPphHYDDLHfyzttFrPr7l3kCtvG/E75BonJOU3Wp2Y0HBQJcFQfcvgSXZajO+ZQCJ3PhY0P12PCec9b8nr0Oe42AWMuNZr9kETLr+kmRhhki/Bj7F4CXwgeQb0D/xiPxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151457; c=relaxed/simple;
	bh=KpTicIeNMa0H3D1iI7HjtoVXB8q6KHKN0kKJhLXe2sQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G7w8yfcsgAS7J0MkFtZwbpApA4hhNSqfqZmp6kOY4OdPvaKZC7ARAcWiTVzY+1RoDTbtepao0q1k6opUAW4KmKhvEPRS7yfh6YAIZ2BoXL14cYG0Q+ewww0sSqoY+7mDBaAMbhXP2+kOcDCM9JVhf6FHcoKvxdY+vYGOuTaJdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR8zOcYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR8zOcYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED28C1F000E9;
	Sat,  8 Aug 2026 01:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151456;
	bh=s+bIma+TaHDHFUh1npFcaH1EeVVflPQY7qzmk9O0L/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mR8zOcYSGT64mGST/xTA6OCPoHuMhplXRKBI5Cr1JDEYNkux8U+vbrpWoPLzwoDL6
	 kWHU7NAY9qI8YUcp9yOlIfeGYQdlKj6+GYgkBg8fg9edayHzjwVO04xYUZKanz+2ba
	 F48fcQRj2Ao+rzce+XBR3/KfoPshYOs4UwM/jhyoBdxkBX/n3jpVDEnBxCpI3tUxUY
	 LSZ7rlPsxcA2OwyI+7FBvMpUb9xyTFAvkPGqMGqGzGccTj2jCNR1QEUVh5JDsSWmUd
	 m94exNXtDEybZaTO1kADGETkXuN3gqFW6Dx6m4/FZfrwHofKb0vbL1o5n9Hg1iZaDY
	 7SORq9DIicsPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E9380CEE4;
	Sat,  8 Aug 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_api: fix teardown of an adopted proto
 on
 insert-race loss
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178615141414.2487956.8805241969467933628.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:10:14 +0000
References: <20260805134049.927864-1-victor@mojatatu.com>
In-Reply-To: <20260805134049.927864-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 vladbu@nvidia.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Aug 2026 10:40:49 -0300 you wrote:
> In tc_new_tfilter() the create branch sets tp_created = 1 before calling
> tcf_chain_tp_insert_unique(). When the caller loses the race (another
> request inserted a proto at the same chain/prio first), insert_unique()
> destroys the caller's own tp_new and returns the winner's proto with an
> extra reference. tp_created was never cleared, so the loser's errout
> path treated the winner's live proto as its own and called
> tcf_chain_tp_delete_empty() on it, silently unlinking an active
> classifier that the winning request already advertised via
> RTM_NEWTFILTER.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_api: fix teardown of an adopted proto on insert-race loss
    https://git.kernel.org/netdev/net-next/c/d4e359b3608a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


