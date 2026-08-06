Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB96379ECD;
	Thu,  6 Aug 2026 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976868; cv=none; b=newnBfpyA3xP7zQkDKG4kn8scR1bCes33DBG6LzQuoRkWZ9yg3RqwAe7D5QoJ48uympaY2u6dsOYvmW7ijNOjFscjfxlQ2Kpims42AG/+FjxWjNJHMHNBFrAhtxzhOB/xR+YimBNc5hM3WX3VGKJyJh+8V2ItB9tEkvK8P54ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976868; c=relaxed/simple;
	bh=ju173BdDbT+Ev/PMKbF6iQnsHv3B8IEIyIQVRjTYHNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ND2n6U23GHy5NSjZlIiDa1RWwtdu7by8sQgl08QWxGX1idIrol3YTtgzM6PUtNwsQZObMJE8dApq3epE87W5IWUEnnmeyp/zOk/SVs+XHWVXXM6txA17RFTLPczjxdVVxhucBwSbakxTw7Ldyryt09Vtqm0665OCKzTNvyGcPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBjW0dtL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBjW0dtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CA11F00A3A;
	Thu,  6 Aug 2026 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976866;
	bh=exKj1ib4rr8spf+qr2+slTw/eEVsvhgpswVeOyEQtr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EBjW0dtLQ9MSANlhVzfAqQPP5GFJbMKXYLeZwxpusnhyf+ma5yVE2hECA/+GIC88c
	 6qaA6fY7aR2wlLmhRlbguOSWRVAuMRlr2PGB1alFB2XXBvjr/0CjhYhcNWgjq+Jzkx
	 HO3G02y4CrJWk5YUq8/Y3CevBDe3SZlYMyUiUvxnSJX3OVjQWm/cHLa7Q1qRgCujoa
	 MAQv84xlPYUKWHu9EyKZgvHtlLSO0P8bKEMFuJ6ucV4VrZLPINSI9zlaqnHjc1fgZQ
	 d4nhpEavS/XHLCYJDKsBCfAOv7ZdMmwa+VCUYTj+/NFZT9/xvjsz388fF0JMfhA8tO
	 leNTcRJHb3LfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC3392FFD8;
	Thu,  6 Aug 2026 00:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] qlcnic: drop unneeded semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597682613.580024.14297387249853061360.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 00:40:26 +0000
References: <20260801191002.1383835-5-Julia.Lawall@inria.fr>
In-Reply-To: <20260801191002.1383835-5-Julia.Lawall@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: shshaikh@marvell.com, kernel-janitors@vger.kernel.org,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Aug 2026 21:09:51 +0200 you wrote:
> When a function-like macro expands to an expression, that expression
> doesn't need a semicolon after it.  All uses have been verified to
> have their own semicolons.
> 
> This was found using the following Coccinelle semantic patch:
> 
> @r@
> identifier i : script:ocaml() { String.lowercase_ascii i = i };
> expression e;
> @@
> 
> [...]

Here is the summary with links:
  - qlcnic: drop unneeded semicolon
    https://git.kernel.org/netdev/net-next/c/376608d9210a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


