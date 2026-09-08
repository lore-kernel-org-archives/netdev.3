Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D9526AB4
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865270; cv=none; b=mrx3105E2n1aI2k60RyEJ6X/7HfJRQBqM3PhygisGpZmJDCNydrwcES8Y2RJSCE/AyIxVKb+mw0wdE2WIyxXpTXXca38c/TbL8zAdF8fQX8UHqPxBOWwURSfL+TJZnmNs1mPkh2LQitkYMjehd0xb3I5FxXbEZDYCxe2PJcP+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865270; c=relaxed/simple;
	bh=UWuEqYwGE5MmpL5zjis4FxNrXwupnArLEqMDE7rLU/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eb6n8HqwKhK+0sAaMBmYQyzrTf7sZnGY/R0Q1G3RByxJ62zwA9MBAPcjDB/t7rpe2BheHWJrm5h0jjcX9CNEeKKw+1lTseqhUtqrtJ70ST9BzhD1DTqycd86OxtngqcYQjzy5Ga11nkARWlK5txB49QityfJhF+64+zvA8hFpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpO6epjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpO6epjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D9A1F00A3A;
	Tue,  8 Sep 2026 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865268;
	bh=Pq7F95RS2Hq1xpGa/UY6lYyjF2oMExbFptXccdsKl8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lpO6epjz0hyNXBj9Zx1VJsJaUWm8Nb+LRVsthTrsZva66cpVtSoCPGiDfcXCgNZRR
	 zT7d4YxPYCX9fQrbNyAvFBeujNDp8araYV/vzHk5bRPfSXqg4glwcU2UXP1z9boKFG
	 Q3BucHbTmBv0fStjBNNDg3mwZYg44sDP0htBnnFxni2NBl1X5NDYLOSRED1lU+tMxT
	 rssOerZU9cx5T8VO+pGchXMqEGNwyxoiSW7lr0Dpl5mzhBaeE5sFTu/vu5EW2puk/3
	 ece971G1CLOHvgPCLLHdUAalLxDZWLUd3SYG0NSgtAHgF/F3yOUUfEpucX4rV3zvjq
	 5qw17M3hAi84w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D239E960E;
	Tue,  8 Sep 2026 11:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] netlink: specs: fou: spec tweaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178886520663.3465195.10699530926011428253.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 11:00:06 +0000
References: <20260904191412.3872344-1-kuba@kernel.org>
In-Reply-To: <20260904191412.3872344-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, kuniyu@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Sep 2026 12:14:09 -0700 you wrote:
> FOU was one of the initial families I used to develop YNL against.
> It's not using YNL features which were added later, fill in the gaps.
> 
> Jakub Kicinski (3):
>   netlink: specs: fou: add af to the shared attribute list
>   netlink: specs: fou: local-v4 and peer-v4 are big endian
>   netlink: specs: fou: link the type attribute to the encap-type enum
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] netlink: specs: fou: add af to the shared attribute list
    https://git.kernel.org/netdev/net-next/c/fc7aa4b30acf
  - [net-next,2/3] netlink: specs: fou: local-v4 and peer-v4 are big endian
    https://git.kernel.org/netdev/net-next/c/3f4285d741b4
  - [net-next,3/3] netlink: specs: fou: link the type attribute to the encap-type enum
    https://git.kernel.org/netdev/net-next/c/1859a0cc3adb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


