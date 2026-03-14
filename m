Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B535DA44;
	Sat, 14 Mar 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520814; cv=none; b=JTYbRPteYryXdegEjeO2FNZ+WLPLsdrSXnI4hAAKskPfhAY9KRS+Hhz6AcqARFhGGcdCYRBrvnBi7T09HDD2o233M1AV34uF+w7threlLbLzAlwryamRvxcMCW7kbumixGi3P5q+oJ8BBermgBNdJdfby3qunmIfB8htrIpOZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520814; c=relaxed/simple;
	bh=fempJE/mQpNFCqifqsu6nND87jb6JXozp9C0WMm/rPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZ11jsOwM4lATx+h/66mVo4qdUJlIMXHWVTL3XVzbHwMQWBOqToG3z/a0aHHD2qyxj3V86F05UaWX5h+a90RZnlU4Yp1Gz5D83jOZCJXfR2Tz7L8G/hrmbmbu0xhcKc7noS5fDDOR0KA0D93gJrOhw3p9TDpwp2dy74ZC++5QFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKp/o6zq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKp/o6zq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3881DC116C6;
	Sat, 14 Mar 2026 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773520814;
	bh=fempJE/mQpNFCqifqsu6nND87jb6JXozp9C0WMm/rPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKp/o6zqNAJS9g6zeRkGVohWBYzkbZi6+VUQFJDjbpbfdx8HMank6FL7y9VcX6jv4
	 M0vpOYccKpAckDTZQxLbrqwLPjkWmgugM8sKcjWQpUaVFd5j2sAPZAyijrOrDWKznI
	 Jrz42703a/tJQyqiQ/ZxhJmZeIqbxkW06r8mka9c5Xd9v+5AEB7eF362En5UAE9E5N
	 NQvMOG3tJVaCVzTpBHOaazEVv1bb95us6YnoTzt7P2j05BSVgLPRMMPmzFVGB/sdaf
	 AHz4uN9uG27MEG8E93je9QlnhNfRMr4BuWE0dSuqE4xTKGtqcTgIwL7G57RpxMXO+8
	 Wml76X0yDgggQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D03B3808200;
	Sat, 14 Mar 2026 20:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 -next 0/2] dpaa2: fix config relation with
 FSL_DPAA2_SWITCH
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177352080829.1776380.3309607162699666174.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 20:40:08 +0000
References: <20260312065907.476663-1-caixinchen1@huawei.com>
In-Reply-To: <20260312065907.476663-1-caixinchen1@huawei.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 06:59:05 +0000 you wrote:
> When compile FSL_DPAA2_SWITCH, it needs to set CONFIG_FSL_DPAA2_ETH=y,
> otherwise it cannot be compiled.
> And as Ioana Ciornei sugggested, FSL_DPAA2_SWITCH included dpaa2-mac.o in
> the driver, but it does not select PCS_LYNX, PHYLINK and FSL_XGMAC_MDIO.
> And FSL_DPAA2_SWITCH depends on FSL_MC_BUS && FSL_MC_DPIO becuase it uses
> fsl_mc_driver APIs.
> 
> [...]

Here is the summary with links:
  - [v3,-next,1/2] dpaa2: add independent dependencies for FSL_DPAA2_SWITCH
    https://git.kernel.org/netdev/net-next/c/12589892f41c
  - [v3,-next,2/2] dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n
    https://git.kernel.org/netdev/net-next/c/97daf00745f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


