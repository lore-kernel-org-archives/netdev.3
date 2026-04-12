Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB031A3164
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009633; cv=none; b=aroXTgcEcQwIrdmSlJqykj54Hc53qqGJA9Pufny/eO4O1NQPcT7Qn6oe0WPlX6yALwqiTaO8/NY1wXR4t2PVgrd2pAudUOnnpLEausbkGHsW5++sTaZZ7F/WVxrR7ahSXugkKnFWzMzowm+gVijhjOLujridc8fYVF2phIzalaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009633; c=relaxed/simple;
	bh=owp6qGPOGlMuyriYkecntgmkvuclPl+fwS5LqVs2t7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V9WNSPqrl8tWgmq/Iwnrd2X89aLYGaiA4yzQOgAnxyPToXYmW3s74gl7zriuUozoTJvCCwzj/aFXnq0u0mUox5DNMEiITCnIMH84FWDJqsf4BiP724j/mc7dqRG06dZwM3/KOZysGdDQZXo8FK79nnXujrmM5DTfwAcoVHAY548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W++dJ+eW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W++dJ+eW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A5CC19424;
	Sun, 12 Apr 2026 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009633;
	bh=owp6qGPOGlMuyriYkecntgmkvuclPl+fwS5LqVs2t7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W++dJ+eW53675c296BmEKO/CbdOf5/cGWql+9UrWll2Ze+zR3ue6z2kGsUretLuDI
	 0MC1THjhI0NxNNHy0rTy0VZNzN7Spsuibol+fB4gO5kMo7o0tJJfkJQEv2oBmHnAwz
	 CLneMEqxhljYWp88UcIl+UVFrTi5Aq9f3CPoEA11SYHurtBwb2ijJHxiDqkN0UbSWf
	 q44+mFyeaQKDn0ms0oiVGqPdNFFhM98U4GmOQmvIBtGccPmQNIpaoybj23tvgFtVHU
	 xj8zcW66N8ReHKaEgB3L5FOS+bEeFNedizo26YYhD5HtJdMqEckTLmT4OZlayXCV5V
	 1G7hPJDQhgbsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EBA3809A8B;
	Sun, 12 Apr 2026 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/sched: cls_fw: fix NULL dereference of "old"
 filters before change()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177600960555.3326316.18419358454968114055.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:00:05 +0000
References: 
 <e39cbd3103a337f1e515d186fe697b4459d24757.1775661704.git.dcaratti@redhat.com>
In-Reply-To: 
 <e39cbd3103a337f1e515d186fe697b4459d24757.1775661704.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 xmei5@asu.edu, netdev@vger.kernel.org, victor@mojatatu.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 17:24:36 +0200 you wrote:
> Like pointed out by Sashiko [1], since commit ed76f5edccc9 ("net: sched:
> protect filter_chain list with filter_chain_lock mutex") TC filters are
> added to a shared block and published to datapath before their ->change()
> function is called. This is a problem for cls_fw: an invalid filter
> created with the "old" method can still classify some packets before it
> is destroyed by the validation logic added by Xiang.
> Therefore, insisting with repeated runs of the following script:
> 
> [...]

Here is the summary with links:
  - [net,v3] net/sched: cls_fw: fix NULL dereference of "old" filters before change()
    https://git.kernel.org/netdev/net/c/65782b2db732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


