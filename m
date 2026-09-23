Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D032A3E5;
	Wed, 23 Sep 2026 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790131278; cv=none; b=RcvNi0QwipIVg3eDTN5qzO5ZtgJfW210xSMIGBFw+HLhSwnV5WyHl/nCFigsVA1KnjTAkbCcp0HLYGhtgadM0BgRMWos+MWf3bcxDrwi2Z6Wz1IhE83t6TJVSiyXe2udpiyC8mbJLhFzTGDx1FllJPjHR8hMChxTclCsAZ73R50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790131278; c=relaxed/simple;
	bh=wgtQAxhk4t5qMxcxnUBLbmPT7gj9kyE8pwD0yrprDOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O0Q7VVUjTVIw1tD8lzDrDAf0hMedO/OeCw54EHpSoFEV0ooSGkQ87NH2FNXptHSq9HXIo7e8Ih0AmQRRofUZ5sGYM/txpZOvtZL0H2G4nb/+BdjfdB5DbbwQDpcZUmIbwebJskq4BHEQcBiqovNkYI5cPOtBpq1UfzB8Df3W7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goM/e387; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goM/e387"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74B71F000FF;
	Wed, 23 Sep 2026 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790131275;
	bh=2pAeZ7mayL/xUUp7mAaTVHl0iZ51HRzkW4TsQhycSZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=goM/e387QWGR5yjUWgyWPnslSacmCP7WoLTCgWTAbSy8FgyVeQE9TLeWJINSaX0Y0
	 ITLPSflCWfuUKnpEKpQo3Tt1rjUmoFkva9TLcqMDPiy1HzIKUKyWO7GoKZaPIA29BG
	 SGHwJi7aMDgS6sW9JJ02Po6Rr3a6lZXa6IdIf1pUHL4mySGV5xD2Yt63Jmha8xRty8
	 gDKjstt9Q2AUxXPttmDt9Bk35fAIX44EvbFmyUhRRrEo8T+y6IvmsXtjaSR+7LkD9T
	 WLmBkI2BBVxW5Z2LDx8J21wPDgwgxUagwx+WXG7RNkzIAfnkQ3KrcU3zrD7kxFmwmo
	 mil5Ghwhc+Ylg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939D1392447B;
	Wed, 23 Sep 2026 02:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: fix potential stack infoleak in em_text_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179013120603.186967.833705825472844888.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:40:06 +0000
References: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
In-Reply-To: <20260918133953.12494-1-bernard.ladenthin@gmail.com>
To: Bernard Ladenthin <bernard.ladenthin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alexander.potapenko@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 15:39:37 +0200 you wrote:
> em_text_dump() allocates struct tcf_em_text on the stack without zeroing
> it.  strscpy() writes the algorithm name and a NUL terminator into
> conf.algo[], leaving the remaining bytes uninitialised.  nla_put_nohdr()
> then copies the full struct to the netlink response.
> 
> KMSAN on Linux 7.2-rc6 reports two kernel-infoleak splats from this path,
> one triggered via "tc filter show" and one via a raw RTM_GETTFILTER dump:
> 
> [...]

Here is the summary with links:
  - net/sched: fix potential stack infoleak in em_text_dump()
    https://git.kernel.org/netdev/net/c/9c572a83037a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


