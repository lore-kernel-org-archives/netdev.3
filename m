Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5C3563E8
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643994; cv=none; b=hT+2mNRA5PD7JUCS6tnZnWpFM0eDGUM50xPJ2pI6fsIGhjunNx3ZJEMYaEYzagIVmZsYsp93tXc1yDC80ok7Lux2mH8ZDpAwc2y4b6WZI7Ff5O2SmBVEm4TtltqyoFT7qmWonTtt5/rHoVCTbjGi93nnoIU/vugQt+go1/JoA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643994; c=relaxed/simple;
	bh=WZtIkqiJsaeL4Kf0gI8siB3RW9i+SNO2hAiv+CwmxL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ocr5FPyc7KR+CQOhN37BB/GEHEekJZoRBVQN2++Z7JnWS7yAA/QK3EFoZKov9u4YrwMZqb225v96jH8CLajEb74ss1HXlq0zv4eBmTE7sdEuxzVw3WTjlLdfiURqOwwtifXsxHO3u+JVSZhcWLc/VDthRtC3JJnHVvPYAhyjY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqlAmmW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqlAmmW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091CEC2BCC9;
	Wed, 13 May 2026 03:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643994;
	bh=WZtIkqiJsaeL4Kf0gI8siB3RW9i+SNO2hAiv+CwmxL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WqlAmmW1dZp51qlM4bLvOWuCRKESotWx3NY0xe/f+rVNf6DIijBdvMSSCIumG9Oxv
	 dcCxq2TziTBf+xSVEZgS3KQCqX+c3X8ycs957br33zwDkG/UbYrv0i+gDI51Zoh+Sa
	 oOdLRi9I482MzdaA9/MWyJ8aszhILYVFTqdtYIyJbEMGAYIXnncXF9ws6WMzpSAwyM
	 FTpqSt1zYmhzktR00VDgtwAmXFyAbAwCCPnPXLfIB9/3f946ZK+w/FjwDpdcHN9hNA
	 2q3dvmjB2mR6pMHdUhFcQL3zPbTXCZQXSPcuqVNN110yWwiEF5Q2q1Bqry8BIJpxJT
	 s2Dzx2aGL8jlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CAA3822D60;
	Wed, 13 May 2026 03:45:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864393954.3173643.6785318335975690741.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:39 +0000
References: <20260511070244.971028-1-edumazet@google.com>
In-Reply-To: <20260511070244.971028-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 May 2026 07:02:44 +0000 you wrote:
> iproute2 can spend considerable amount of time in ll_init_map()
> or ll_link_get() to dump verbose netdev attributes, contributing
> to RTNL pressure.
> 
> Add RTEXT_FILTER_NAME_ONLY new flag so that rtnl_fill_ifinfo()
> limits its output to:
> 
> [...]

Here is the summary with links:
  - [v2,net-next] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
    https://git.kernel.org/netdev/net-next/c/b588019e85f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


