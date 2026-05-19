Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA84307AF4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156616; cv=none; b=S5kkoBslGzkEEwnd4cxqty57nOsZeYMBPRkdmqe+cA/DeYDGnJdeFPZHf1Nf/teKaOLALtOM3D30Q+xIjQuKxXVaa65S+yzHacsITESXLoLPOsYihoP8KJd6r90aarsKP9dtkTTQdVI44l3CD5to+mLDYUj5wvL7N5FLBM2VE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156616; c=relaxed/simple;
	bh=KW61PPJBaOhKls0jG+RvFi49ZQ/M1qkl49BMobmaoz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hS0voQYuNuKEkGO/BJsdjDgy9kC1D9Wq7T/Dby8Tat/F3piDm1c2dL/xt8ACjcG8IgtwCDfiQTCkZjrdVlZXepgX18D4JLT62Z2pkrfS4pasxT1gsjcDDN0IGItilPC9/NAzu5Tnijzx6x4Bs2N2vJGw08RH57uwtcECwMppn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8j23SIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8j23SIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DACC2BCB7;
	Tue, 19 May 2026 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156616;
	bh=KW61PPJBaOhKls0jG+RvFi49ZQ/M1qkl49BMobmaoz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q8j23SIk57Kux7xSmLquhE99DGxOomC3IyY1kjMZ3UmLocYlWd0i9IWMeHUmOd6NN
	 vyTJn7kpK565480XkoaQFuUAdCuKrf5pFprvVVQoesrH3TC9MiSXfvRRCoozRNgZa6
	 6YlcrZxvazQ/2fjcjWTz1DyQnqfW7CCkyLUMyV9fDDN9tbl3JkyStGWz+EtpX5udg4
	 gMoU+9V47TxegyY1zYGgGCO3exCiESG0FpFkO7bDbnx5juw0LwfIpUGq1UItOjOwGw
	 H5r74fgC9aNv28OCuePxjis6QjfVQuo5roJ/hHJtcyCa6JSx+c28LwuZnoSycZsf01
	 B/Xyu+PYAQ74w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939E33930D10;
	Tue, 19 May 2026 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10][pull request] Intel Wired LAN Driver Updates
 2026-05-15 (ice, ixgbevf, igc, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915662713.2054007.16302820284961247848.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 02:10:27 +0000
References: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 11:24:07 -0700 you wrote:
> For ice:
> Jake fixes a mismatch in locking around wait queue usage.
> 
> Jose Ignacio Tornos Martinez adjusts allowed lower bound for VF data
> buffer size to accommodate low MTU sizes.
> 
> Marcin adjusts for -EEXIST to not trigger error path when the promisc
> filter already exists as part of adding VLAN Ids.
> 
> [...]

Here is the summary with links:
  - [net,01/10] ice: fix locking around wait_event_interruptible_locked_irq
    https://git.kernel.org/netdev/net/c/89bbff099bfc
  - [net,02/10] ice: fix VF queue configuration with low MTU values
    https://git.kernel.org/netdev/net/c/3ba4dd024d26
  - [net,03/10] ice: fix setting promisc mode while adding VID filter
    https://git.kernel.org/netdev/net/c/ebc8de716c9e
  - [net,04/10] ice: ptp: serialize E825 PHY timer start with PTP lock
    https://git.kernel.org/netdev/net/c/781ff8f2d575
  - [net,05/10] ice: ptp: use primary NAC semaphore on E825
    https://git.kernel.org/netdev/net/c/7b28523546c7
  - [net,06/10] ice: restore PTP Rx timestamp config after ethtool set-channels
    https://git.kernel.org/netdev/net/c/975b564d195b
  - [net,07/10] ixgbevf: fix use-after-free in VEPA multicast source pruning
    https://git.kernel.org/netdev/net/c/5d49b568c188
  - [net,08/10] igc: set tx buffer type for SMD frames
    https://git.kernel.org/netdev/net/c/5acc641e590e
  - [net,09/10] igc: fix potential skb leak in igc_fpe_xmit_smd_frame()
    https://git.kernel.org/netdev/net/c/e935c37b8a94
  - [net,10/10] e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


