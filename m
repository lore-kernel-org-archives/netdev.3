Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4228506C;
	Fri,  2 Oct 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790900412; cv=none; b=kZ7tG6ZAi4t1GGhgpvgOe/IrcEOLaasnvj9hEbkphmvlBeaqyeZEOsERfJbVQtXA65J+ZyxBebcjtvcY1xkG997WbNQ+fNJVHD6ECWuss4h1JpMy7w5S0qBgH9jqRdQpC4sZRtq7gwIBfPZBRJ3YvCG9mSHAiR7kfCnAWvM/uDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790900412; c=relaxed/simple;
	bh=hCuFnxKqfMd2ajAMkg3oWrIC9MXNYy9nsMsmK6r97CU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KQ7XTzN/Fdkhkcy7i/TYrR/CQl9rditK69jKjgeFKdl3hdIo6p5X6N5sD8MyHws65KJAXrn9PTa3V1WW2pGp8gQHtR8Da4UrpKKEjoSwgc8HTvUUVotJOENhGdVqDuNVcCjaL2LU1wq0SCGC1mmix65RzEvWqmVSCtSyhfKVZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzn3lVmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzn3lVmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD51F00893;
	Fri,  2 Oct 2026 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790900411;
	bh=nyklionKzrBQyyZnCe5fl/d7ic6+ldmVcLUoXLTeuvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Dzn3lVmi6fc3C1IrchTl4t/ot6VHKydpbqcfI/o5li3UCQ46GmEbpi88NPe8EDPsM
	 7/vkJjq6v07FJjNNBKhf0SbXDEkTp4xPw2NB0fmXbNsxSN5ge3OWXCb4+XfBxw7oHi
	 LNWCJrKkljBnKhHWo67qEekFTzIyztxU7xluGuxjNmmjGSmDd5pGJtOGe6VfQBGlKX
	 Z72ZEys4n9Ic+zDSwxrNvo9XgrRtHI5QzwyJbaOK4/86gHGNhDAP84lb2tgsPqRjUE
	 Tu+CB+RbwFSIT4detJp5GrUb3JJyxsLGnME98Wv3OaTPGAwJmnFZNpetUUhrPCpJgk
	 hXaG8TGKI80yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F172A381197C;
	Fri,  2 Oct 2026 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] dpaa2-eth: devlink port number from the
 DPMAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090040952.3154315.10446376601962228804.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:20:09 +0000
References: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
In-Reply-To: <20260928-for-upstream-dpaa2_ports-v2-0-1cda148530bf@free.fr>
To: Vincent Jardin <vjardin@free.fr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 13:22:44 +0200 you wrote:
> dpaa2-eth registers every DPNI as a physical devlink port without a
> port number, so all the DPAA2 interfaces report the same
> phys_port_name "p0", including the DPNIs that have no DPMAC behind
> them.
> 
> Patch 1 uses the DPMAC id as the physical port number. The attributes
> of a registered devlink port cannot change, so when the DPNI endpoint
> changes at runtime a warning says the number is stale until the DPNI
> is rebound.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dpaa2-eth: use the DPMAC id as the devlink physical port number
    https://git.kernel.org/netdev/net-next/c/526025d552ba
  - [net-next,v2,2/2] dpaa2-eth: mark DPNIs without a DPMAC as virtual devlink ports
    https://git.kernel.org/netdev/net-next/c/aed5a323ec37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


