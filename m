Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F593B0AC3
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787958669; cv=none; b=Hlzs6N20HIa2Jh1AE/dM+lkhpzENRBf2qcPMce2aJ3HuXWkjqwLAWKvr+APVk8kzO2fCiof43rkSfcESiFFJCTgU/WGcYrHcawm0Ou6RLGuMGR33GaqUH8V0DqP78SihIpfkKEuhp6gr4Lrcm9luR+4aGEjod/7GhxcSOj85304=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787958669; c=relaxed/simple;
	bh=fu2hr0ic3f5SIYSc6OpIExA8pNQygxIspdD/f9shK/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HeoFr4oOf6yf5k37gihbHso975mvQr/7BSXFtPfSlbd5GX33/+BucnEukPP12WJpNJxIPM6/ztB7YzDcX7ywnc6NHXzEXDQknED9v/uEldCvMV3pYHNr7xaMrcr0xL/uz12/153QESqE6uOADdokXHDI2pxupRQlA4BWyKTlhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oniPe5od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oniPe5od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0FD1F000E9;
	Fri, 28 Aug 2026 23:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787958667;
	bh=+Lj+BugDp0kSP6pdIb0fbJmsJm7VM8W8VLy40n06hHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oniPe5odC7hLXs6GWODdLPczIo5qYoQRoM3XIR/pibqwJXOPRMAyU1UCh7vQQcN8J
	 B/vDCQd8gG7c2UIwgFXBYt3pc4KLuR1ktH8Mqr76xX5EQvqCCJGrHkdL2nbgH8B9j1
	 /J+LNhgIbCvxG+BaoojXBlF9kbWwkLlg03TLqiKTKv+9sTUZexTVr+oHhr4dzqSg//
	 Iw24MuStI68bGV5JFeaXXjUUjuWp1feg4X4WMVBOWMR8rsVbnuoh2s5aT3JttIBMyh
	 pBYKP+Ra8l/nXuwE+cT+PO+wDCAi40LWYwSuBEbl6uGolXuXQyDxx4q7TO9TeY91b2
	 t+qK7YnF5+kew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392D380AA69;
	Fri, 28 Aug 2026 23:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net/sched: Fix remaining actions notification
 accounting issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795861214.2836129.7637993004089359878.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 23:10:12 +0000
References: <20260824153903.4143642-1-victor@mojatatu.com>
In-Reply-To: <20260824153903.4143642-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 baowen.zheng@corigine.com, louis.peens@corigine.com, pctammela@mojatatu.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Aug 2026 12:38:59 -0300 you wrote:
> Commit 8e2efb3f45a5 ("net/sched: add get_fill_size callbacks for actions
> missing them") fixed the reported echo/notify skb overrun and noted that
> the pre-existing issues Sashiko pointed out [1] would be fixed separately.
> This is that series.
> 
> Patch 1 makes tcf_action_shared_attrs_size() a real upper bound again.
> TCA_ACT_IN_HW_COUNT and TCA_STATS_BASIC_HW are emitted on every action
> dump and were never budgeted; TCA_STATS_PKT64 was budgeted once but can be
> emitted twice; TCA_ACT_USED_HW_STATS and the rate estimator attributes are
> conditional and also unaccounted.
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/sched: act_api: budget all shared attributes in notify skbs
    https://git.kernel.org/netdev/net/c/13eb543cebef
  - [net,2/4] net/sched: act_api: size the RTM_GETACTION reply from the actions
    https://git.kernel.org/netdev/net/c/e9ca46ebc326
  - [net,3/4] net/sched: act_api: fix skb sizing and action leak on reoffload delete
    https://git.kernel.org/netdev/net/c/251367a0a331
  - [net,4/4] net/sched: act_mirred: account for TCA_MIRRED_BLOCKID in get_fill_size
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


