Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A127364959;
	Thu, 30 Jul 2026 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376244; cv=none; b=KXVwq5wS4X4lNp15B0hbHtH9Yw351XHCDk7VE0UAbyllyEizbLBCfEupSCfYdCCBktJP9WC+00WAnHgj7YXTgKpnOczzowlpmyTroVgUn4/AmQSpaXyM2xJ1ZaCPO/1yTH5H65PlfcvddY9/IbNQKka3Hl8PwRKtuXrFcCPB4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376244; c=relaxed/simple;
	bh=WQyzOnp6V1snj2eSi2sF0ZBSG4gfNpLRvWV1T61J0oo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=asdfSi8ffn69IXEUbcmEv5UDGx46HNKWR2VdMlTE6q3Pf2RqTOPzXOygCZNEbcB7X+aJYobiF3oCRLLvLn7+fmlxBFzskA7Bep6y0Ox/TSk2DjD78wahLS68WRyCELG0oLrSCzf8z8PQzv9F+OpkvBxaMti8Y4buz0h+LlPSvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edwzSbi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edwzSbi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA371F000E9;
	Thu, 30 Jul 2026 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785376242;
	bh=ugH72T2ENSyiyWsu6dR3ao4qeWLulWjlnMivyHhxhC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=edwzSbi8jQ4zcKT3PSLtVW1o51K9oWyVILHZLBwjE80ehk/4/ps6fwX+gxqRU35TF
	 os5mt8AQzY8iNiCkKEZX+hAyOJ8JuP/5rDGgp9FJOqYutCP+lPVDu7OCx/NCLKg9uj
	 oo6kVjiRJ0Paj/XODiXgiiHv/8JmXOI+Y+JD+NyFly2wv/ecGYxzSFQwSjQil9oPb+
	 EIPRNr9ClcuhQUHElAdw7o3ldP9iFtKoFC8tFcPaB6u7MiLZF4IHNp60RW9TchgHMi
	 Wctm6i8OwblUKdIplXL0I4ZH51NuHToHLf/quG1aLCa5q81FdunnRy+ijcxRVu6fnQ
	 3As91GZrG7sjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1A95A380DBEC;
	Thu, 30 Jul 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] atm: remove unused exported helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178537620566.3317888.1414673708397178238.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 01:50:05 +0000
References: <20260727054538.196437-1-eric91102091@gmail.com>
In-Reply-To: <20260727054538.196437-1-eric91102091@gmail.com>
To: ArBin <eric91102091@gmail.com>
Cc: netdev@vger.kernel.org, 3chas3@gmail.com,
 linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 13:45:38 +0800 you wrote:
> From: Xiang-Bin Shi <eric91102091@gmail.com>
> 
> Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
> ATM device drivers") removed the remaining in-tree users of
> atm_alloc_charge(), atm_pcr_goal(), sonet_copy_stats() and
> sonet_subtract_stats().
> 
> [...]

Here is the summary with links:
  - [net-next] atm: remove unused exported helpers
    https://git.kernel.org/netdev/net-next/c/ec83512ba345

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


