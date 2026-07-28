Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD618BC3D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 01:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201060; cv=none; b=a8wy7KBynIsy4PWubfRZQHMEisXGov5LYavLxW7YiSqfIFa7cd2CXoGcNjCizZGcwDNpLlw2BNjeHVOY0keUWH5AB729OxvemJNF6lfwkhtoUvr8qN3ULF2BCaWbMhdZVzfxZF9u6dM0HJguv+nPIlW1KTHPcuvjDaWIWDRXz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201060; c=relaxed/simple;
	bh=lCs6tFRw3HiP7vUea/vc+js/3F/NvXxzmhhz6J/ZhpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKLr2OqMpU9xkeLv6bmwNoQ1L15RWckE9VpAwuidIM+ZrT3kKn2X/XUg2lpqUX65cJj6xWl7o4kAqFtypedVVYHk1pf+sU9eZ1lEt3qX6E9aW6YhFML4KoEH2iQZO9QQwQjFpb3tOHK87fKHXe77jHxiZga7A4SJzck0afpey14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVACzhC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVACzhC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99371F00A3A;
	Tue, 28 Jul 2026 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201058;
	bh=4uv29avWeMF7OGY1mpNf4grJothMX1JQxil/fWMRUpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fVACzhC9DHncxbbD9FLxZO1BNq7XO2fMla3T7Waa3nxT5JSAnuHTRX90R0r20ayzS
	 miggIg5/bRX14QV6j6akupNVjXmUMxYtg9ummGjJx+gz6EZP2KBeE0jOjEHMJMFjGp
	 CA9n5RoaXt3SguTXL/WBpl87f8BTMeaIF23isUSji8dOWY/UPUNYRQ2kpInfWA4JF1
	 ZA8z9GoCFYnmq0+1xtumfnPdWJTBtKg/nIM+7zXJrS2wVZRuVgbWjlaoKNF1xhj3JQ
	 xGgJcRmbW1M6tslR58lgoW7cRdCJEh2vXPPpzQbUvqxtZJGuP3BYRSaI3ib797mjN3
	 KqC0A0km82uMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AD2380CED8;
	Tue, 28 Jul 2026 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] docs: netdev: a couple of updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178520102363.1486027.2449791881889089692.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 01:10:23 +0000
References: <cover.1784884817.git.pabeni@redhat.com>
In-Reply-To: <cover.1784884817.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Jul 2026 11:24:03 +0200 you wrote:
> Explicitly covers a couple of relevant spots currently left out in the
> dark. Likely the first one was too obvious to ever spell out loud and
> the latter too new.
> 
> Both cases are increasingly relevant, at least to me.
> 
> Keep the update in the netdev subsystem, as others may have slightly
> different preferences.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] docs: netdev: clarify handling of idle patches
    https://git.kernel.org/netdev/net-next/c/7d394ab234f7
  - [net-next,2/2] docs: netdev: clarify expected interactions with LLMs
    https://git.kernel.org/netdev/net-next/c/c82ff94592fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


