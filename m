Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639F21B905
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707608; cv=none; b=n9vB/i2/cxgJpf4P3sPYHXtdMODxGN1RQrl3gmJ/WzywokFZbDWSaQ0H4URitInijWMCCaNmrxj5CeTZOExk8/Vn436y/oDaNg068vUOck8lm20/sebyzMfD3WARDLVftoPsJ43CHxKoL9+dpW5gwuP8N2SyyFKovHZ93ifNHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707608; c=relaxed/simple;
	bh=LkjrxAHvFUoKpCxg3IqVT4d6iqgvu+QiKwQEUIRNqnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k0AGelVkWHB9ACFBRVMUi4oO/ZbVzQUekzaZXX3pu5UuBoDh5VojfR8EonG4heAUc/2F70WCMAcJKnNafTf8eQ0/IeF/coGbXEroMHHmN5NMSKs4hRMNZxl8y8ENrNLiqvzalimr2uqx9kdXb2YHTIPihKBoUS7menxGt06e/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJU+WOjB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJU+WOjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB6C4CEE3;
	Tue,  4 Feb 2025 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707607;
	bh=LkjrxAHvFUoKpCxg3IqVT4d6iqgvu+QiKwQEUIRNqnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JJU+WOjBZB3UnGZSTph60E3XmbTgVf7Ab0Qm6Q36S+LOoH36nEpa948alx8gC3Ini
	 TgkXfci6XLHmPMsV0eQT+mNUG4tG/1ixXFaRGjKA2UnKV8Z/LydLqEL6KQ68XQ8YFw
	 5duPmBsrYUSqirh/4hGEtheldqAal1+TkDnX+fDnGNl9QHAd/xuTCyRZTeuc67/8Ca
	 MVzMp02HIYxafcjuc8fvvn4z8Gdg+R1VUSu4er5JX52Wt0jVo/DYuzmMhutzQrxd45
	 fNExIDa8C1FXL0ojIdXyhKm/yDiUdjNAc9U0o2zqULFMT9DR3hRbTjLLzlwsTtM/eq
	 SOUQl+tTyM6ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34CF3380AA7E;
	Tue,  4 Feb 2025 22:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rose: lock the socket in rose_bind()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870763475.165851.2297396105073935308.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:34 +0000
References: <20250203170838.3521361-1-edumazet@google.com>
In-Reply-To: <20250203170838.3521361-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+7ff41b5215f0c534534e@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 17:08:38 +0000 you wrote:
> syzbot reported a soft lockup in rose_loopback_timer(),
> with a repro calling bind() from multiple threads.
> 
> rose_bind() must lock the socket to avoid this issue.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+7ff41b5215f0c534534e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/67a0f78d.050a0220.d7c5a.00a0.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] net: rose: lock the socket in rose_bind()
    https://git.kernel.org/netdev/net/c/a1300691aed9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


