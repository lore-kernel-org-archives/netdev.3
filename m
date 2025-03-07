Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2908BE5
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307999; cv=none; b=fmZ+bwBueRFcFWk7EFxZAmVYFd0BZiVluJrHHQLQV/EaMYV1uwTah0Bg54wWAnclojfdCVzvn5PfqI248wg12kKQ7adg7Kej47v7QNWFVG+C0nlsPSE8TVtMpeLWtYWldhExBkemoR+WxA7emi/2cF5fnnlgJBRUhhwrQl0NgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307999; c=relaxed/simple;
	bh=esNIDo+l5hsA09KgBkkjv0dFVtOhOTgOFkj753O9IEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQUSOoqLSMRukrlwiySnk8SvajRkUjHi84fHUxB+mehWyoUQIRbQP+o438uVDy2UElh38TbsQGI0hLgEGufPWp1UsGlTpwYEJgxblGTJuliUydKGsinnPXkpoacXkkVqhMf47pb4tlhvK7SLPoJ5x3spyQVwlvzSLx225Rko2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE7b6jh5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE7b6jh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD37C4CEE0;
	Fri,  7 Mar 2025 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741307998;
	bh=esNIDo+l5hsA09KgBkkjv0dFVtOhOTgOFkj753O9IEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mE7b6jh5g85NKicJmTG2GgLLZHnktftmFGkOLZhFfrItSuR5dGuoBHbcD00nrSxfH
	 4tJf2EzX1Bup7YWpktXlQJ8w9Nph5G2ipnIObp67OwS/gxVvIAZCy3ovANT80YaIHY
	 Jf7Fm3toTY/8TJdtqUh6y/GHQU0zxmn8bh4U0Xg1ZS9UsejDgbqaTQj21u8OFHpAzp
	 bVaHufdyGaROD98IRAtYZxGXQnqDpIit7/2DHbXnupPyrmzhYtwC1ra4PLyIjN4ZVd
	 hFtZ/fi6BEfbv+C5cZra2UltVNK/hFKDEY6D6n4qapEQFrelwVONvCT0tIN6J7c6vm
	 V5NGpTn1RnLhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEA380CFF6;
	Fri,  7 Mar 2025 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2025-03-05 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130803200.1833062.11916759461989426391.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 00:40:32 +0000
References: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  5 Mar 2025 13:35:42 -0800 you wrote:
> This series contains updates to ice driver.
> 
> Larysa removes modification of destination override that caused LLDP
> packets to be blocked.
> 
> Grzegorz fixes a memory leak in aRFS.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: do not configure destination override for switchdev
    https://git.kernel.org/netdev/net/c/3be83ee9de02
  - [net,2/4] ice: fix memory leak in aRFS after reset
    https://git.kernel.org/netdev/net/c/23d97f18901e
  - [net,3/4] ice: Fix switchdev slow-path in LAG
    https://git.kernel.org/netdev/net/c/dce97cb0a3e3
  - [net,4/4] ice: register devlink prior to creating health reporters
    https://git.kernel.org/netdev/net/c/2a3e89a14864

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


