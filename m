Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449B13B5B3;
	Sun, 20 Sep 2026 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863075; cv=none; b=UwQKM/dvwYisaF8b94i29yJKvPsGFNkioUGNsqkX/4LS4jYZB20IZc9xTkH+c34bsjtCu3OWioX+hBzpP6UhrxyMnbp4wlAIeRSs0q/Wd/GiMbAinvZsqq89NFHJNy5lBkIWGRnEhWxOVP9R2TpFzWes3tOZO29CVvZWg2hD2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863075; c=relaxed/simple;
	bh=BYgCPMFHF29JWmBq82HxgRTq4pLL7kRec/QcIK4D1fQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jjo+GlH4Qqah4U1WCdLxKe6Q+aLDNaxFs4bbDuJ7y1iE4MFpiP1CWx/8kckIODBXtv15HW7tNv0dXYzVF6/8/M3tk6zF84kFp1e1VwtRMMRj6n3fAEeANnV2zDLIzBbDZmP7vS3NmCxI9bQKpb7gEdOfx0KcgBaV2MBYQdvCndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYrv0iT8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYrv0iT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6862B1F00893;
	Sun, 20 Sep 2026 00:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789863074;
	bh=cx0kXwuVHHHhqAHal21fuMTMFNIbXY0B3VikkFKkjLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kYrv0iT8I58gs7jnYnXY2uZqscNXsnn0D4SAKQwWjswp83G1VcDzrYFcF516qJwbH
	 IV2yRf9qDoozBY+mRNGR+TPZxhq1XKbVM9osXsjTW//l2LJxB/rGpBcXcyML5Sf/2z
	 c3k+9KyLAGQMAG9V7BfgJYdnGHSd9JYmbTuL/G3A5T0AfqECNtolHTOvLW9o992XID
	 7u+J/Ol2qGVqYXd3A+C0bH8Hca3+AjwVp/5isPTTr2B259LGfj94YqskEzLqQZckS2
	 MWs1d9LQP/d9bs0cyUqIyl60/jkXo9e6d7AWKgINUwCSX6xY+vlvmA6CPmI9h6CCi/
	 7c4bG0fgla+Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988E3924A46;
	Sun, 20 Sep 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hibmcge: fix spelling mistakes in comments
 and
 identifiers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986300664.1499536.13577301366145990985.git-patchwork-notify@kernel.org>
Date: Sun, 20 Sep 2026 00:10:06 +0000
References: <20260915132341.1138610-1-shaojijie@huawei.com>
In-Reply-To: <20260915132341.1138610-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, ningwei15@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 21:23:41 +0800 you wrote:
> Fix several typos found in the driver:
> 
>   - hbg_irq.c:    macro parameter "ndde_reset" -> "need_reset"
>   - hbg_txrx.c:   macro "hbg_queue_next_prt" -> "hbg_queue_next_ptr"
>                   (and its call sites)
>   - hbg_txrx.c:   function "hbg_ring_page_pool_destory" ->
>                   "hbg_ring_page_pool_destroy"
>   - hbg_common.h: comment "after rest" -> "after reset"
>   - hbg_reg.h:    register macro "HBG_REG_BRUST_LENGTH_*" ->
>                   "HBG_REG_BURST_LENGTH_*" (and references in hbg_hw.c)
> 
> [...]

Here is the summary with links:
  - [net-next] net: hibmcge: fix spelling mistakes in comments and identifiers
    https://git.kernel.org/netdev/net-next/c/5ac134441dc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


