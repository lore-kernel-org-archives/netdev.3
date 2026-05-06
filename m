Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17026CE2C
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029867; cv=none; b=G+pVNH5nw6NnTEpG3jm3N7O61R/MmpPg1YttnhO+0PbATkGpjbw7gLtsET5vDEd1IAoWQJwgV6RV6OYm5fLvQiNFpEQSl2TUSiiTUxq/n8GeKUkfOWDLYYr3R5LehhXpg/jQYfpiuVnEhL9VwKC8XQKTT7pdHBgFnxJXq8m+4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029867; c=relaxed/simple;
	bh=wRRp6lq7s4MtElJhVW6H76sRGKbenK2M3GhnV+DmuBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y/yu4SrKq7G4ru13enLIPS9tlxdz5abCsUwvTnFHjDrik+LueT4YtKAe3BNGsPX2bcqn7iMvJAVlENoyEHf7AGAo9XScsIdt2lG8dWpN4nxRk6cpdo+jD5UzMbWUEUUWV3xyThKraiCgYGauwBOXjrbyXvq+H29d3PZ16DL+AqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ7QRbtP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ7QRbtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28830C2BCB9;
	Wed,  6 May 2026 01:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029867;
	bh=wRRp6lq7s4MtElJhVW6H76sRGKbenK2M3GhnV+DmuBA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OZ7QRbtP5JqHBaBJkBPCuSlcWsTDjwuAo4U+i1IX2K6VFfH2kPW0HrAoqUEc4yy7F
	 ANDMGNcBv9U9wWexpp9LMi+djg2Q4DO9FDJ2q/iiE8N7HjMg12up9yga0MclIy+m9C
	 mJgQo9BtSV2v/KCaNODo20gnukCnXtxRoX3PtXV3/naBZH0pphMKR3v5a/Sb1OIBv8
	 8eqz616T6ox53DPqKiWNcFeB/JYnh/5YBwwdFaVoW/HABMwMEyeP4kJ4yP4bCOBG55
	 Eavu5bA2cJPuB6vH57Y7o89HmG6mvKnoFlOebJoI+LtT0LQBVFIQQst2KaAQz4lm7C
	 2PrK6ttONbCBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE293930780;
	Wed,  6 May 2026 01:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/sched: sch_fq_codel: annotate data-races from
 fq_codel_dump_class_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177802981704.2332967.13911347758725802168.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 01:10:17 +0000
References: <20260504163842.1162001-1-edumazet@google.com>
In-Reply-To: <20260504163842.1162001-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 16:38:42 +0000 you wrote:
> fq_codel_dump_class_stats() acquires qdisc spinlock only when requested
> to follow flow->head chain.
> 
> As we did in sch_cake recently, add the missing READ_ONCE()/WRITE_ONCE()
> annotations.
> 
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] net/sched: sch_fq_codel: annotate data-races from fq_codel_dump_class_stats()
    https://git.kernel.org/netdev/net/c/f83e07b29246

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


