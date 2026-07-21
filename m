Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94CF46D08A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650856; cv=none; b=fcMSDBG+t6RSmacUc6CMp7gZYaV+WRyGOD4ApOCtG9RHyMxgsCUsWJJn+xWW9aY5YhZGxWNAt+UtUTx692tvN3KVuZnn35l0YmUOOpo0qDCB4jf3w9GLViTNUSG7pPxhqiWE7fDqvdl/JoU9zqYbckSFwhxTrECFzQ0S5ej/y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650856; c=relaxed/simple;
	bh=yZ2p6buiMMgheEJOGYlgKXewQJ3Xw89Cb8q5qhOPT4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cPf20cYOa1i+zdiWJgE+xw9N4pTkURLyRu7vxG7K3HWDo1mlXF28qSn2cI/myCwR0qzpnnZm/w08Z4gAFTwAWaDykIB689bdkUVXO1wG6BtEY30ZxOrv0fyRANCsR+cqlXkf4mgBEzCKGQDASM5N8yr/rfWgXN+U/kR4Uoq5TUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knJORsjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knJORsjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749941F000E9;
	Tue, 21 Jul 2026 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784650855;
	bh=MqahxLhOPjc6VIv9hcdtZHGCJLhaUXVNE5ZSF3JLaLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=knJORsjXAdkOf6j9JhdBWuogDleGQQ+4RIa3f+XpNO4RIjC9Om92DnYq94I84IIZR
	 H108XCgrAkT1PaY5VQNJGTvLgRE4+JyXKn4jrMOzjPNkF+TyiJEqMUKvnY1tQzDYm2
	 4XK5BhKct/OoZQuP46bHL4Pb0VhV7jvVk9IbawUy7lBK5T6/YIvTWZn9ESW2ALJ8Dv
	 DvxPw+C5bzRe56Ax+cY+lQXUq9eDJfSsbmbSwsEC373w/Q1Y+42jMaUBctpTuaRq7r
	 c3+R/6ZryBQHGA1LeQV7Q8IomkUkuofIn4BihGKWZD5eyC2X7uluYrWb358tYS2zoe
	 wXESqIEJ/1Siw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4734C3924FFE;
	Tue, 21 Jul 2026 16:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Revert "gtp: annotate PDP lookups under RTNL"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465082489.386198.12380628393838059994.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:20:24 +0000
References: <20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org>
In-Reply-To: <20260708-gtp-rtnl-v1-1-218091f171bc@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Jul 2026 20:02:05 +0100 you wrote:
> This reverts commit 0be5c3f0fbef3679f50f345b9237b8f9ea5de4e9.
> 
> Commit 0be5c3f0fbef ("gtp: annotate PDP lookups under RTNL") added a
> lockdep_rtnl_is_held condition to hlist_for_each_rcu() loops to help
> insure that RTNL is held.
> 
> Unfortunately, as pointed out by Pablo Neira Ayuso, the PDP context list
> is actually protected by the genetlink mutex. And so the condition
> is incorrect.
> 
> [...]

Here is the summary with links:
  - [net-next] Revert "gtp: annotate PDP lookups under RTNL"
    https://git.kernel.org/netdev/net-next/c/860b693bca59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


