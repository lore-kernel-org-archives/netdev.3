Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A34A33FA;
	Thu, 23 Jul 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815864; cv=none; b=LsTYycYvRV9w5BzHv5BXzkw5JD3Yqf90D20UrBHkKAmJtUtXygQXTRruXYy5vjIybqIXZZbO5V68Svrz8cRi0Dpyr4PjgvXUAv1MpiItYqMsiS3zVAf+EXqMCnpJW5hWx3z417NvIfWQmRDHyUYvB87zf2OnPkQ/duE1Rw2VsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815864; c=relaxed/simple;
	bh=mH5gn3oFegdO1hvPquEoFTa72T2EpHU+8iZYqygIqYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pLwOX/CEbkAznO0dy6Gyt2hsXmgkYvYymCtzeQcieyKlsyvv3elVms1yYxPNi2+JR3i9CfZ8fAHLmEi1r/hcQRfOJSR0e3MxEUdMObur8DeKgmUS6bYWpAZxw5BXeghiAGaKcux9xTY/XBVRUP6PAtaB6/iEqD5WkyQpNZREyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCaAd1Ef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCaAd1Ef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755711F00A3D;
	Thu, 23 Jul 2026 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815852;
	bh=+u0JpkVBE1qIi8uCsOxrtV4SVKL7Q5nbj4uVj//INKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jCaAd1EftInGh9wl/cN5uz62Epl8PWLiGBzw1UglI1L7G7EIKl0tb/p5NmmQp9YFT
	 dmtHe3rrxEbpghM7igxy7JQ0Aup0y61bzqS6+4WktfK2XvdO6UNWq3WEucQD0myKrB
	 iaAWFog8XHoDMAzFrnB9Op007LbdfEKAQfIHhzXtph3iVRnsifvFnU/t/zR94hOHs0
	 9vLLkxYsNHRf797GElD0NhEVT/spwBGjzC0o+slom9GNk8Kn0RiWrncMlJH6rAN7/P
	 KgDnJ9YQyvL6NALxRbSuJckO1WjCCpShpxwW15qXRFngydrpV2A2KbQ5rdDvOMXuDJ
	 RAcYlGTF0pN1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B4C380CFD4;
	Thu, 23 Jul 2026 14:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pppoe: reload header pointer after dev_hard_header()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481582039.2248593.12234026295292829000.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 14:10:20 +0000
References: <20260722093814.3017176-1-manizada@pm.me>
In-Reply-To: <20260722093814.3017176-1-manizada@pm.me>
To: manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Jul 2026 09:38:43 +0000 you wrote:
> pppoe_sendmsg() saves a pointer to the PPPoE header before calling
> dev_hard_header(). Device header callbacks are allowed to reallocate the
> skb head, invalidating pointers into it.
> 
> This can happen when a send is blocked in copy_from_user() while the first
> non-Ethernet port is added to an empty team device. The team's delegated
> GRE header callback then expands the skb head. PPPoE subsequently writes
> six bytes through the stale pointer into the freed head.
> 
> [...]

Here is the summary with links:
  - [net] pppoe: reload header pointer after dev_hard_header()
    https://git.kernel.org/netdev/net/c/e9c238f6fe42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


