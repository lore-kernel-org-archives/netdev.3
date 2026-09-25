Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C73E0081;
	Fri, 25 Sep 2026 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380282; cv=none; b=WbztQ8oZWbGbeOp/6OA1YVm3m0DNCdgSaWimjFEU1q7cxQ6AWtXllMlWrpuI2mLHNklpvFvFrvwQEMg7YuC1gddnKZmN17Ux2PmeWqND2mEEuPObBHUxYqU3wrYwyzyGhChveSOP3cSsBY1RVFi1PzFIF3LEgfuPKTVYyWBqefY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380282; c=relaxed/simple;
	bh=kxoXZIYkx0R+9+sMxrk8MUwzoHZeQVJiRJWNj7PjlGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fsXhpYfzgiLi4+8mmmbH/KCcLRhgNDIUbgckiBFU4MzBh7cw9usdt8pDp1wSe08bN0YhRCTPoJziH7KdwiRPrNewvmwytdAIDFJbjyUQsyeEV0iefaudXw9pTqGB236zwuefFm2U3+FuPdu8uK0GSiOntuCDBmr/ZNpo506pb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMiRA0lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMiRA0lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120021F000FF;
	Fri, 25 Sep 2026 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790380281;
	bh=sMJbYuN8fyiAF/FnkbIJ7XZRLLaQrOPqRWfMIHMkbWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LMiRA0lrUgUBGiymOVS0g6xhAHkHC3urar97B8Aj8TekGkN/CHmY/xDEpHuQ8I26r
	 RJ7Efe/oc38Rt+qwe0hyyVhsHUoKl/yaRT+Z8zSFvOjOvmUx1AibKg2RGGoFFtG3F6
	 v6jgb9HxlF5tzLwhOtLwtATIoI+NUa4STNh99YZLcQ6vXzR8posfLdxoi3QZEsWgFg
	 tnEGsk4DPWbtGA5oxB6illJ8bWRmXdIDPfv5IJI2tJF167XC6U0seEcrhtAstTBpDg
	 ydjhPjOM7XaMcLC3b0nmnES8s5GM9RdHkzZ7GmnN9y8TwfQw4RHqmqKTEC32V7+IvI
	 bs/SloEoZry3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09303809A04;
	Fri, 25 Sep 2026 23:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/10] ravb: Add gPTP support for Gen4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038020845.3210501.7347729491663204858.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 23:50:08 +0000
References: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
To: =?utf-8?q?Niklas_S=C3=B6derlund_=3Cniklas=2Esoderlund+renesas=40ragnatech=2E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?se=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, sergei.shtylyov@gmail.com,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 19:50:27 +0200 you wrote:
> Hello,
> 
> This series is the second part cleaning up how PTP timer support is
> implemented on R-Car Gen4. Currently there is partial support for it in
> some of the Ethernet devices that can use it, but not all.
> 
> On Gen2 and Gen3 each RAVB instance have it's own private PTP clock as
> part of the RAVB register space. For this reason the PTP functionally
> was implemented directly in the RAVB driver. For Gen4 however there is a
> system-wide PTP clock shared by all RAVB instances, and on some Gen4
> platforms with other Ethernet devices.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/10] net: ethernet: ravb: Remove gPTP control from WoL setup and restore
    https://git.kernel.org/netdev/net-next/c/e8bfdd91469c
  - [net-next,v5,02/10] net: ethernet: ravb: Move programming of gPTP timer interval
    https://git.kernel.org/netdev/net-next/c/d9519789d098
  - [net-next,v5,03/10] net: ethernet: ravb: Simplify gPTP start and stop
    https://git.kernel.org/netdev/net-next/c/b9c1216c0156
  - [net-next,v5,04/10] net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
    https://git.kernel.org/netdev/net-next/c/b784f9ed2e3b
  - [net-next,v5,05/10] net: ethernet: ravb: Propagate error from ptp_clock_register()
    https://git.kernel.org/netdev/net-next/c/121cc8a3acf8
  - [net-next,v5,06/10] net: ethernet: ravb: Replace gPTP flags with callbacks
    https://git.kernel.org/netdev/net-next/c/14bf0091dd0d
  - [net-next,v5,07/10] net: ethernet: ravb: Add callback for gPTP probe
    https://git.kernel.org/netdev/net-next/c/9a85f9dfbc3f
  - [net-next,v5,08/10] net: ethernet: ravb: Add callback for gPTP clock index
    https://git.kernel.org/netdev/net-next/c/931770c1995f
  - [net-next,v5,09/10] dt-bindings: net: renesas,etheravb: Add optional gPTP phandle for Gen4
    https://git.kernel.org/netdev/net-next/c/ef488a9da66d
  - [net-next,v5,10/10] net: ethernet: ravb: Add gPTP support for Gen4
    https://git.kernel.org/netdev/net-next/c/2b240cfc6de4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


