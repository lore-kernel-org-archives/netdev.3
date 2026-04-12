Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910F2E8DEB
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012042; cv=none; b=p5wBUyywtIbcRhPF22e1x5i5Ys29IVdL257P0H2k7ZnVyZtVOgv9clZtU2WfClnVs1pM80JY/4HyjArUl4uxp5/l5kurIYB1xpnqnBgGgy5Mjew5Y4mnohSHjC3l4E9k85LZ/Lxy3yYQ2f+QwCA/mxD3i/lwcAtyN8C0QmZ8Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012042; c=relaxed/simple;
	bh=GSv6BBfjghzGpejPdtnwXNFUboMvhYjgLmuQWf5faAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cdZe6bIbWQJbSjv8t5B/gZze+3Msq6sFcC40c5qtSxKqzTv97Sm0P5nK/CbX7+TIsjXOsSBgboHsCVUY0I31lANDX2McDU5u2M/pklv9LJImt9FxIeMhvSlwTgnVloucVPSERL2/BWqWr8tjX5U0aLFEc0neJFMvuC8peBz4+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz3G633M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz3G633M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002A6C19424;
	Sun, 12 Apr 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776012042;
	bh=GSv6BBfjghzGpejPdtnwXNFUboMvhYjgLmuQWf5faAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tz3G633Mbd75AqoyFS3Rx/HQw195JD+jHs2JlHobZzPk27Jf05h+FNZpyhbPp/YEe
	 lqGnkNIAhUt4/Dd6kryteljyl/w40kXENyi8sFYy7FXS86y+X4Zgq+P3Gxrid3Dy+G
	 RAd47fR6MxHZpk+WL8SX6155yFzncmxDO9Ef5qSCfZdqtX3xs/yoExMN+34t/pFMuS
	 MS1tRO34cu6ys6UYyHhoRfFyiISExpmMk9vDdDcjWJ1qEB4xkCToZnTQmJ+4P/DjHU
	 d2VDk/Mh6+w/j8yfSUvlPnd/Fl8uc1M7Lq8HBa3sibH44Um864XJPPmKPG8sSd9iqu
	 d6IIYZKHBS9IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DEB3809A8C;
	Sun, 12 Apr 2026 16:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: act_ct: Only release RCU read lock
 after
 ct_ft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601201454.3337647.14530153251926228394.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:40:14 +0000
References: <20260410111627.46611-1-jhs@mojatatu.com>
In-Reply-To: <20260410111627.46611-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 zdi-disclosures@trendmicro.com, security@kernel.org, victor@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 07:16:27 -0400 you wrote:
> When looking up a flow table in act_ct in tcf_ct_flow_table_get(),
> rhashtable_lookup_fast() internally opens and closes an RCU read critical
> section before returning ct_ft.
> The tcf_ct_flow_table_cleanup_work() can complete before refcount_inc_not_zero()
> is invoked on the returned ct_ft resulting in a UAF on the already freed ct_ft
> object. This vulnerability can lead to privilege escalation.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: act_ct: Only release RCU read lock after ct_ft
    https://git.kernel.org/netdev/net/c/f462dca0c841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


