Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0A3D8901
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165035; cv=none; b=j78cEp5Tnshwk09LZB+cP97PtErqtrlqf51Pvx6FZmru84eEhuZXhTPY+O6VPe5DR8qQDpVak+IVj0SZxSGMRXnI/SZzVUR9HB3F6PsbUYu+6cuZiAeMOrMUN38Kfb96H1aU+exxOS0vqbvv2jALOAd/bzcji3x/dnE8Hm/7Cpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165035; c=relaxed/simple;
	bh=H8SgpNPWiVfJfsnOu70c7RZ2c9BK48LxjUKKlE0afgo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YhboYUIqYlqEs8qDZA1285/JuedcYnsVhZpTu/+/KqOA9FekecsulHYMUA3eSjpFBmoAi6kYt3BBFJzL25SUOWG7hb0Y5s7JaKC+jHzOZg7NS9zSGSVcSj+X+rPian0+dKL1jaljexZYkBnNSg21usxZqdk4XOvMmHPUvjRv0nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndcyXoIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndcyXoIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB44EC19425;
	Tue, 14 Apr 2026 11:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776165034;
	bh=H8SgpNPWiVfJfsnOu70c7RZ2c9BK48LxjUKKlE0afgo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ndcyXoIkvODXfFWV3+Pb++Eh1X1PJC1WdKGY2PFggdoNQ62J1wnNKX3WQ4mTni+bx
	 LWoMksC2ChxBQscir0wbBmmIsiTC4u0ucAtMnkzxuPnJGFlpahMgS8DzUYpCOfbN1/
	 fNuBphFw0V+HQ/sZaz3uyQvH3N0wp9obF3x5geUuealwzq5+BTKnZWrpiPd1/6X7Wy
	 7Zz2PSKGlVLPpOQ2rkocswy4/gy6fElliMPMj+xBuUpug+MoUbSfOt9Bh+n93xqOlf
	 EiL7R37Mp+TnwXz7iEfgWkfrSuMCQ7sQR8oVEb2nhNVfwCGMa+A2nWAS6Agf1QM0vv
	 yOZH6wjyo0Hmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D9A3808205;
	Tue, 14 Apr 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: strparser: fix skb_head leak in
 strp_abort_strp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177616500555.830755.5928809017900797018.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 11:10:05 +0000
References: 
 <ade3857a9404999ce9a1c27ec523efc896072678.1775482694.git.rakukuip@gmail.com>
In-Reply-To: 
 <ade3857a9404999ce9a1c27ec523efc896072678.1775482694.git.rakukuip@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 nate.karstens@garmin.com, sd@queasysnail.net, linux@treblig.org,
 Julia.Lawall@inria.fr, tom@herbertland.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 rakukuip@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Apr 2026 23:10:10 +0800 you wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> When the stream parser is aborted, for example after a message assembly timeout,
> it can still hold a reference to a partially assembled message in
> strp->skb_head.
> 
> That skb is not released in strp_abort_strp(), which leaks the partially
> assembled message and can be triggered repeatedly to exhaust memory.
> 
> [...]

Here is the summary with links:
  - [1/1] net: strparser: fix skb_head leak in strp_abort_strp()
    https://git.kernel.org/netdev/net/c/fe72340daaf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


