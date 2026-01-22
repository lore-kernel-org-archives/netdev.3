Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D857421F0C
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054416; cv=none; b=FrDz38qmF9+Hws/l2l1Qp7o9iMGnf8Px4vhh8XWmlAw8ITKB6Lxx7tBHsPiO5Dju7KxBJ6JKh2sclyReV4FyjtuSENGtwiiy7a76/o7MY2NnOfY+hrpOFwfYDDFgyqgQqNJ8lbHars8SJPojnzjcrGCsksAnl3Ntb8lLN7roGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054416; c=relaxed/simple;
	bh=7fxpPiEjCwhSZ88wZMWSJMKBL3QLWM9pQIByympBgPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mj3zCue13zI4abfuozAXPpXbemq6wLWIModLLL8lpak9IvaeEnPD2eOzottaZ+HNDZQN/lJyE8nPFoGRjf4yuoUY8cG507Do+P08r91xFq12BYBlI8t7Ixn5JzjsBWbxKnqh/Y0K9APv5x9TKgnwHStgipVmYwV+vV0dl5ef5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVWYcsKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVWYcsKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37B8C116C6;
	Thu, 22 Jan 2026 04:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054414;
	bh=7fxpPiEjCwhSZ88wZMWSJMKBL3QLWM9pQIByympBgPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sVWYcsKSJ+JzphOwpwEHZon8hZmSnN+yU5w95tZQxl4osH61VkZD06vFUdqfak6tr
	 wcK2gjHsvyOmSOsQOHxDHSQvdK2qP3MgSyvbSLQesjY/fOWmaJlVYYRVqzeCO+jjzd
	 V5V+NR25br59Ov4krtgCx2LFMLEdQMu6Jk1rVez8cZ7/5lsmsK0CCPAGUavyoOLjQy
	 h5lWJkGT7+3xaB0rmMESLcKEiZK6Pp57SqaP2G9pP1TMbRB+3SQf0RfF1XFrd8RE8w
	 Xf+lxjWZQAKxRplxitCx1pTcMwt+FIwBzRjVTXxNU+gFXmXgfvVIMMMJXTvywpoidn
	 qBywqyvr+iP9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8EC83808200;
	Thu, 22 Jan 2026 04:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2026-01-20 (ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905441134.1550373.4628790252948348077.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:00:11 +0000
References: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 20 Jan 2026 14:44:24 -0800 you wrote:
> For ice:
> Cody Haas breaks dependency of needing both RSS key and LUT for
> ice_get_rxfh() as ethtool ioctls do not always supply both.
> 
> Paul fixes issues related to devlink reload; adding missing deinit HW
> call and moving hwmon exit function to the proper call chain.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: Fix persistent failure in ice_get_rxfh
    https://git.kernel.org/netdev/net/c/f406220eb8e2
  - [net,2/4] ice: add missing ice_deinit_hw() in devlink reinit path
    https://git.kernel.org/netdev/net/c/42fb5f3deb58
  - [net,3/4] ice: fix devlink reload call trace
    https://git.kernel.org/netdev/net/c/d3f867e7a046
  - [net,4/4] idpf: read lower clock bits inside the time sandwich
    https://git.kernel.org/netdev/net/c/bdfc7b55adcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


