Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAC28CF6F;
	Fri, 19 Jun 2026 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830818; cv=none; b=Q5ejny8vqPE/kdezS/TE6G3SFbxLYuCvx/yL+R7Sc+SYvwe+y949AyAgaOoqNK6IhqBAr0fVPJPmdy1cdK4x2sgKOi28JZp/iyfEhncIG1jNG86u9Nz4jZVEEOZWkga2CFgpg1JWWKIZuMEObRTucepPXzLq6HWufGZpUaO7no0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830818; c=relaxed/simple;
	bh=G6kj1Mt7N+b0Pi4DrYrUBFQRwFLu6lrqTnm0cpyX8ro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WQDnpAAkdn21YBp/DL7EiZ6l6cqQegg00keDZJbDNkF9frI8/ACGezWsMuJmWMOfdNdUm+zsPOtLUN9dKt3ANMYfHtzJ8LOmK6/IFmo+XXZkNq49SGQHZKZYi1WkSBoKksSVAkax4HaOP4s/NqqiL8S8wINYJOWHqSJC4OU6FME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtVcVsmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtVcVsmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B4F1F000E9;
	Fri, 19 Jun 2026 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830817;
	bh=GURJwnNfl3cUpEX14Lp2pd7oRlB9yNJdPeyte3pWT50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MtVcVsmkARMky1o0yKvkBta51+3LPpi+WfS2L24aU+PgZxiJaFfdHjE/fMcCh/Yds
	 FTxehWNcRTUetKoQKI/LLz/4fD+gIcruMgL9EDHYvcMf5e0EMDYh5B48lQW5r71Osi
	 akgDXtJ9GDZwagi1FMu3zNxyAJHn7fVMgxnjEhcdDTi7o52Zg1mE7Kl6j+kWCAmPCM
	 VJWthBEJLhWvD/yKTi+pOqGVkjXHVLa+zclm7GPeaTyKXw5au1EX8H+f2tYrnTkHsg
	 09k48EUMGPzCsqZNjPq0fzM0T8Gw1M8UmcsHCyk0NRCXAouqOsTlo+b4xG1YlKq12i
	 2KXr1e5auZFWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A23A78A7C;
	Fri, 19 Jun 2026 01:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] dpaa2-switch: reject VLAN uppers while bridged
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183081013.3146201.10825137909731680053.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:00:10 +0000
References: <20260618092813.432535-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260618092813.432535-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 f.fainelli@gmail.com, vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 12:28:11 +0300 you wrote:
> The dpaa2-switch driver does not support VLAN uppers on its ports while
> they are bridged. The check which should have prevented a port with a
> VLAN upper to join bridge was poorly refactored and didn't actually
> return an error. Patch 2/2 fixes that.
> 
> On the other hand, the driver didn't reject the addition of a VLAN upper
> while bridged. Patch 1/2 fixes that.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] dpaa2-switch: do not accept VLAN uppers while bridged
    (no matching commit)
  - [net,v2,2/2] dpaa2-switch: fix VLAN upper check not rejecting bridge join
    https://git.kernel.org/netdev/net/c/ed2294f94e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


