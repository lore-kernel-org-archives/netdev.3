Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC4443C21
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241216; cv=none; b=CPPNYufWy5S50ND8HmWVjdPMK1hWouEjv5zepTE48gCyULQmhwJoXrGdd9B9Aj3Rz74e8+eMNqslc2VgpOq0OstQczOcsUOBJw44a8h2zae23YXpIomSvUu+46lFhVozIa0zNFrb+R7ep8o0POInKAN1YslGzBhqCnRIeL7SNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241216; c=relaxed/simple;
	bh=IiBcT8VAv7I0qgLc4A5WKTeiEjCf0u6VF+vLogtf7tI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0SF5NH43FIvAPDrM6/Z5rkUu3/Ide7FtsEPrqKCogseYi5DMtGujIcx+T43gGEzHhiOJTSZr+tnudmr8hlbUu7eV+fECfQx/ifd6MHHJEhds6hk4A6B5uDeD/3Cfkcnl++IORfWN06iKoWgS/ZHuYltBerdKV0OrfBqTao03pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBtUyZJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBtUyZJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B031F000FF;
	Mon,  5 Oct 2026 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241213;
	bh=yF/sa+pCWKMYzV0ZVIQYk9HD9I136qD9gHjxpTUikjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XBtUyZJ1k/AfpWARv8G9e0CX/BO8iW2AejXNupCettbuyC9XFRvwM8U4Ap5mpOrRk
	 fHzJPWYoVUrWzZEyW4IGiyVcsv7iqsFTPdSPHu78IkpVmgW1kHNj51IZMEBT5/1Je3
	 PILtojvf9CHb56ARw6fRbn06eWnf+lZF0TUXv839YvGGYJE1NwV6P/4fUMI0N2U22T
	 meaLkI7d3VDZO5qY0CxwRMRatOj0IEnkDPQCPcjNRQJQG+ztsHxg4aFNguwVULfF8C
	 cjz7ApsyAThyA0u4vplhGLQEOTeafsHLF5RnsaIyfPPiF0WYOBng2c0RVxdT0AQ1qx
	 rVPrzilv+oGjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A31C3926677;
	Mon,  5 Oct 2026 23:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv4: use zero IPID for atomic datagrams on
 connected sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124121177.1929441.16265751704473326299.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:00:11 +0000
References: <20261001155633.2562504-1-edumazet@kernel.org>
In-Reply-To: <20261001155633.2562504-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 idosch@nvidia.com, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 15:56:33 +0000 you wrote:
> ip_select_ident_segs() uses the per-socket private generator
> for connected sockets, even for packets with IP_DF set.
> 
> This was historically done to work around buggy Windows95/2000
> VJ header compression implementations, dropping every other
> packet in a TCP stream when the IP ID field did not change.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv4: use zero IPID for atomic datagrams on connected sockets
    https://git.kernel.org/netdev/net-next/c/9a550198d424

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


