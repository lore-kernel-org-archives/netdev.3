Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EED2F261C;
	Tue, 24 Mar 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314618; cv=none; b=HpPvYhXqDzwAHCvRQMzKX80hgdYG35lD/gRrc3LTvQIVx45sIVCAuO3mENC8AZm/ZhiYonVyTiOvCM98eurZRtndFTDGCVWbHz99oPZQwn5ItI/+7oh2BrXX5zBEIkxdXK5FYWPT/3Et4ktvM+A/rwwMwOBbUHYPYm4Z8GhjWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314618; c=relaxed/simple;
	bh=w/TKBegW+FN/jmwHwVExO1LV3a/8xzxZXwshLmKB4+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IyT1Q5X5iR3SIu1B7AzLAEivlxW2b0rejseccHSk0ciC5gVn5Ge1bcQUNS8Ar9l42GyFoirqbbAUZ34FvJsjLOvXY6hc7lpNUMNfN90kjW+aSFXUx3PHQPrugxTDcPfoRvdRzpGyN+Pv/nw49RN1mBNqmwefZhJDKPt9ryOGSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvglgrJu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvglgrJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C994FC4CEF7;
	Tue, 24 Mar 2026 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314617;
	bh=w/TKBegW+FN/jmwHwVExO1LV3a/8xzxZXwshLmKB4+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZvglgrJuH/wRtMTRrMIb395xMlf8Em6bJYXpCE5/7WGE1quXzxjGM+R5Cxb7zfr4L
	 541I5sBZoJlaPUH9e9ZsmENMNEysRPBzChV3DtZORh7omnNe5BEekOgRJfWLskW1/k
	 pFmlo37IHmIg1qfivWVhmAAC/p2eVH0XKtfvKBQK0GnKRdsf9lcAVpuhEog9EUmheJ
	 RgDH0fn25L732uGmvRLADiDEjBTAdTgJgkz3Dq3hrgJRLjg3CYMIClcIaK36bRS6kk
	 PH9RG+X+72XOvp+F9uGCTFXo8elv25aZx8+K/YtyE8NSjOS87Y/yXj0sRq1WYTqR+9
	 ORfTMwVrhN/5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE013808200;
	Tue, 24 Mar 2026 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: add netdev_from_priv() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431460604.402502.16899859064277223855.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 01:10:06 +0000
References: <20260320075605.490832-1-dqfext@gmail.com>
In-Reply-To: <20260320075605.490832-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 aleksander.lobakin@intel.com, leitao@debian.org,
 przemyslaw.kitszel@intel.com, kees@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 15:56:03 +0800 you wrote:
> Add a helper to get netdev from private data pointer, so drivers won't
> have to store redundant netdev in priv.
> 
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> v2: update kdoc format
>  - https://lore.kernel.org/netdev/20260319022608.323969-1-dqfext@gmail.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: add netdev_from_priv() helper
    https://git.kernel.org/netdev/net-next/c/eb37011395f1
  - [net-next,v2,2/2] team: use netdev_from_priv()
    https://git.kernel.org/netdev/net-next/c/9027497a25e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


