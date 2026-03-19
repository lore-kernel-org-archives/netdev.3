Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E51FF1C7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928215; cv=none; b=DU/oasAwpKpwCpymg1BKTk41TR3Z6b2Sh+x5c2+Lq8lfcoZXUVwU2E1NzMHyymXer2RyepysOUMje4BBEz0f18SUWZFOy0zZOVAiYVeyJ+cLXBoA5Dif4XRyMSNwGD7pYym4SjUVblNSzkl4EmYnommsayUan9bX9kvzs65+WdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928215; c=relaxed/simple;
	bh=MBB7+7vxAZA2FvnIJ5AydlO5vQvdRBccGPDpR/uBxII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G4Jx96Lq2vWWCNd3FH7cDGJqyL727sr9Y3T7wrKrB4gxL0RRm1+lq6WArkOv6xdR0oBWMb3bhEcDGqSX0Nf2sZ4AN1lEwDsPNwyfO5O4Zp0/VJOEjgD8EVkGybkvXuHDo8W9Y/t03FmlqD9+XRdIKiNYf9Nx4ATAdWqpj+rCrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKXffowV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKXffowV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4062C19424;
	Thu, 19 Mar 2026 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928214;
	bh=MBB7+7vxAZA2FvnIJ5AydlO5vQvdRBccGPDpR/uBxII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CKXffowVZmhEQDmr5grOYS6Z5SXdnIn+adVEFAi57BLwuHLbRZuA+6il7sKT3AWH7
	 697jo3qVaUpyt5zCjBnnynWRdBMuy686l+5H1TA3nifzGexxvIeVnVizQqk9kNmQwl
	 bOCEad+hOs+Mn8mq09pC3e9gxwQLJQGWu1Q3KYhHs8wo+/zP4q483RFv/tcxt1EzJF
	 z8P0nFwJcc03V8d8WbGlgnjhtV6YoWd6Lx9/hMOy34e1h3WM9Mi/gVlJzWiJn8ZuD6
	 kMPLGo5SUu2g3HYdK28i0q3D+HPWI+wJtr2FvAEH5IjM/Ccxn6Ywm/tKjy943cBqZD
	 9gjH5QyZaU0vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CF6380693F;
	Thu, 19 Mar 2026 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: shaper: protect late read accesses to the
 hierarchy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177392820563.1208461.13325506803372802389.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 13:50:05 +0000
References: <20260317161014.779569-1-kuba@kernel.org>
In-Reply-To: <20260317161014.779569-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, chuck.lever@oracle.com, matttbe@kernel.org,
 p@1g4.org, ast@fiberby.net, jiri@resnulli.us

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 17 Mar 2026 09:10:13 -0700 you wrote:
> We look up a netdev during prep of Netlink ops (pre- callbacks)
> and take a ref to it. Then later in the body of the callback
> we take its lock or RCU which are the actual protections.
> 
> This is not proper, a conversion from a ref to a locked netdev
> must include a liveness check (a check if the netdev hasn't been
> unregistered already). Fix the read cases (those under RCU).
> Writes needs a separate change to protect from creating the
> hierarchy after flush has already run.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: shaper: protect late read accesses to the hierarchy
    https://git.kernel.org/netdev/net/c/0f9ea7141f36
  - [net,2/2] net: shaper: protect from late creation of hierarchy
    https://git.kernel.org/netdev/net/c/d75ec7e8ba19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


