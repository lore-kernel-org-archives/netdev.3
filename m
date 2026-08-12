Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6536B934;
	Wed, 12 Aug 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498871; cv=none; b=f2FpxJN42pcM49CYd5v++daJXWCuvxwPew06ePkp8RZ7v45nidy7/ANsPHYYKk3sV7Lr1K0o2XyQDwmNuQ2+ujdiXncPdVOjju4DsWO+wQLi+Ifyh9V1olGixjkmEgmznveooTNsTVzUx/Ts2p1QJWwVK+glpSp1HgFwcM87NTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498871; c=relaxed/simple;
	bh=DFEAgBcq9Rx5mQwy1+RNT0Zau6KfpE3zjnUkm1qTq0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eK8G/Lg0kl1Ar2d51IjQIz3qTz3njH6w8Mkr7aOb3Jx+OHWN11SsRPiEOVLv+gJyENqloCK5DqN1vFV13ks/xclaVfBPC1HFTvd1T/ZDI10Dudk/Wfj7Wqg2NkvhVtTY3i1GsDRdqbnIiKHT1W2d0UqSwMbpR5pSVLknMOIzvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXsy9fT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXsy9fT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3BE1F000E9;
	Wed, 12 Aug 2026 01:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498869;
	bh=DTqbF2gMTTrmR8Ocm1PWoYZeG+YyerThrsY5lc0u+D4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jXsy9fT0E37J4raf4RXaAB1/vxZ/G3E98wm3MHrGBYQwL1rWtWVTzvXsdAY61IMkV
	 O7/efAIQRxJuHbr5qZvyD3MCfpaAZ9JT/iMWSI7+DKhJiPQBeQasQ86VUNM1Tn9FUl
	 rtGfO5bj6BKKfjlm1hRyRLqfjunQlNBN//BF+AGqHPCQjh0nb0AeezIKrzrSGXOhts
	 raE9ZeYbi+AOC5NO86RxmxJ71U1imihVLPNbjmm8VkRS4MLW0M6DHuAbwb9d99SA6c
	 LT6FyEvc8+Sv+j13xW0sCILYT5cofpgB/DaclOZhKLS0snsfCuJwCmooiirxpy9Gux
	 wbZwcvyIiG1SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F73809A3C;
	Wed, 12 Aug 2026 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cls_u32: skip hash tables in
 u32_bind_class()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178649882538.1230679.17797134796377555251.git-patchwork-notify@kernel.org>
Date: Wed, 12 Aug 2026 01:40:25 +0000
References: <1786089038-36366-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1786089038-36366-1-git-send-email-zhangchangzhong@huawei.com>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: xiyou.wangcong@gmail.com, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Aug 2026 15:50:38 +0800 you wrote:
> u32_walk() enumerates both struct tc_u_hnode and struct tc_u_knode
> through the walker callback. u32_bind_class() unconditionally casts the
> passed fh to tc_u_knode and accesses &n->res, so when fh is actually a
> tc_u_hnode, which has no tcf_result member, this results in a
> slab-out-of-bounds read of res->classid in tc_cls_bind_class().
> 
> The issue can be reproduced with the following commands:
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cls_u32: skip hash tables in u32_bind_class()
    https://git.kernel.org/netdev/net/c/6d3724e616fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


