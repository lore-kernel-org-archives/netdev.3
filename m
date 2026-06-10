Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E809289E13
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055611; cv=none; b=Zy3ofsqm8v91bShjax8WPl5m594ZwFn26XwOXI8d4ApR151vnswd0aXmpjrCtW/kqLyTFCRhVxpKcWYXGXSzJ2QGszJPla1k3ufBOr1H65gk56ZG9VrreQBMnpYQ/fD2rBe+NkZ9SGeAsGxinYzWRmntNmNDdaf9P9+XSJxgLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055611; c=relaxed/simple;
	bh=QUg5sEOTOKQeaod+vkpige23G3mjuIfD+yDe4tsRtEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZFEve9cDfwjZAlOw+33QUfXNbb8EoIrOK3R0J0wt35JMybo25WTKfAWJfNl8IU/DfC9svJFCzFQyYtPLAsfTTGmdRKQgGBjXXEH9ZGOctzuk2PTS6ezeCM/cNIbWq9f33PIVKi9UGPiZlYe/LzINrh6zSYxoEQy296cIJaubvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nph6H4mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nph6H4mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F016A1F00893;
	Wed, 10 Jun 2026 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781055610;
	bh=+6SFWH1nclcSX4NXUMWwZUYwNq+QOIeK5PggdjWZfow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nph6H4mtTmXUkqk5T0lHsNYqIHYLQ7iLeIFPkSC22YqnTMS5SqznaR9BezNIBNAEE
	 NVk614ikXB+eboaGY33zLfia1kM6cmoZJL0fQ+MtoutD1KzyzIfhShKz0eeD8W/h7C
	 qJ5V8TGiX6WOw6iuvU42qTkF6WTp0++07JrmyrpU2I5Zjv44wtJsG9+63y7EoYQf9Q
	 It1bH01ZAk7gUV1j0AyouBmQeBukmwLvcjE+gUFAMCm2/hkrLOLRVafGtZXCpTi7/l
	 gUj2O+Db35gZgvMCWkCEE1WCk6sVRtiABoxJ/flpN0Y4B6KsryYDAKTuHtkOtHhASP
	 v/CDY6bDSdqgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680A3930A1F;
	Wed, 10 Jun 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_vti: set netns_immutable on the fallback device.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105560789.2786170.11425771545973631922.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:40:07 +0000
References: <20260608155918.787644-1-edumazet@google.com>
In-Reply-To: <20260608155918.787644-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, noamr@ssd-disclosure.com,
 nicolas.dichtel@6wind.com, steffen.klassert@secunet.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 15:59:18 +0000 you wrote:
> john1988 and Noam Rathaus reported that vti6_init_net() does not set the
> netns_immutable flag on the per-netns fallback tunnel device (ip6_vti0).
> 
> Other similar tunnel drivers (like ip6_tunnel, sit, ip6_gre, and ip_tunnel)
> correctly set this flag during their fallback device initialization to
> prevent them from being moved to another network namespace.
> 
> [...]

Here is the summary with links:
  - [net] ip6_vti: set netns_immutable on the fallback device.
    https://git.kernel.org/netdev/net/c/d289d5307762

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


