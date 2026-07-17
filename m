Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99373E92B5
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784282436; cv=none; b=po2HiNuciQUfvTlRK4xcRgAqfdWPWL1U2OUI7uBjl2TZjHvefKyuXkgO3Rh8yvlru15C2HVomkROvzT6rQWlFoTvzqJeiEkiMKCdRaMYBqtLeEEApFSebNDF5+LQvzuXVHooeCp6T9/kvlcz/l4RwtIKCJCB/Xtrwbx9ZtndN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784282436; c=relaxed/simple;
	bh=iE88DFvYmHvsFXuRdxp7hX+WEHYMdl3Yn8SnsyCdSaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ol4cfGMUJx+68rVFAQFwuV1pIuHPK8i7LwnfH81cKX8Ggb1T8VlT7E9/UvVL48NB6kfN3V1QYlrslfkOoJT0sDAebol8HG70u3eY1qeHpm0EbOZ2aipCG7o33xk4no2lYrGD65NnmRXoW19eyTYBieyiey4u6rbePQO/rGQ7iug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoW3Qab8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoW3Qab8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874171F00A3A;
	Fri, 17 Jul 2026 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784282434;
	bh=PMoEnUqOQhZktcnlaFF6SjKOI88IKnybY0UJfbgpKZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UoW3Qab8gMaLXPDVjmDPAT5HF4qY6/CTAcMcsa/KbE6f70DpYFskkvdYK8qUBvf3K
	 agaKwy3cj0c+iJ35yNV+mfBYRkrsOTvSKaD/TSqBI7OmbDVP5r5d7joMjbVSsYYQH0
	 U7EOZyq9Uvx6I+nEqg5vl25l9u2hpUueRsSnFtTbFP7Lm6/sZpwRVPG0dXYAIpjL6m
	 N8ll1H962GtIYp6V9SqSErWl4ygUffQCNDgrv822/rhxuSrSu7QIpxjD5SkBuI8mjl
	 onRqcFZU/YMxuZijJBElt4GAF+qxZvZhJrBXkHk/JnsPubOAgtd7Xa90qhKXroCCt8
	 cSMEwFQ/H814w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4F2BC380CED1;
	Fri, 17 Jul 2026 10:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix TIME_WAIT socket reference leak on PSP
 policy
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428240688.1642910.2009696290227196221.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 10:00:06 +0000
References: <20260710181317.4060230-1-edumazet@google.com>
In-Reply-To: <20260710181317.4060230-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel.zahka@gmail.com,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jul 2026 18:13:17 +0000 you wrote:
> Release the TIME_WAIT socket reference and jump to discard_it
> upon PSP policy failure in both IPv4 and IPv6 receive paths.
> This prevents a memory leak of tcp_tw_bucket structures.
> 
> Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key exchange")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix TIME_WAIT socket reference leak on PSP policy failure
    https://git.kernel.org/netdev/net/c/2c1931a81122

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


