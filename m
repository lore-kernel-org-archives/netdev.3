Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6F4A07
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114456; cv=none; b=q/9BazA3a/N4f9jigwUWBzvKI7+7c33v6uZFOUxiL6/ls0ZMnE6QHURcYYjo1JoeyqIblkkf1fpnrx88pi2OBqDmFGrn1cPWFmyPhRxswkMEvUEc0S8Ozqp6FuAzs6PC8U9hgaMw2t9FBZLJg2ZJKai3v1Li35uMjPPiPdGcNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114456; c=relaxed/simple;
	bh=I86N/BV5DsVD8OGYu3BdJNS1nik1aOKYwvET77Ii8Jw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LDe4KUsjrDKJkObrhDmfcdo7ilSOzyk9vVrqXKQL2pNPDS/WxbxGWe4RuhYMxcrya6gLAN7/fMb8aH1yFkpt6lUGe84Jo0f5OqVtEWWi9EYlD8HcKlsIV0GT9X0jCNTLpRXzq2Y2BdDsgfcTjc/Fmc9WJGerfmZfYz1wRoLilG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6Skg6Yh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6Skg6Yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB6EC2BCB0;
	Thu,  7 May 2026 00:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778114456;
	bh=I86N/BV5DsVD8OGYu3BdJNS1nik1aOKYwvET77Ii8Jw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6Skg6YhU5a86EzsY3MOUs0BeyJILrqSp87W61HcPvYu/P6C+d7o6Hd8z3CTpYa6W
	 AT+GWvBhAbtGxoG/zAAwZtU16bb9eHq37VTAVsZE3x3Mqg8QN8sISBQpARHeFHhZfz
	 zJkVbqNPyUaMFHTocf7VixYjx3jnK0sd1lneu0WIVRP5lJjco/A1vZC6TOCMaKJe/p
	 wcXmy0bHqEQc00AeuZl9Mptz5r9JsKN5eukIUCZ1U2nhGKPWiOCqb4V15GlnX4lvn2
	 6wrl1/QB1XXBNBNEhZkvde+2ghhQN1sGnFYxUgTLHpHw3RfiJVUpZ5yzJ1dzHG64O1
	 Ng7doCLitjDFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BEA393089F;
	Thu,  7 May 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix potential UAF caused by
 ip6_forward_proxy_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811440570.3278368.4185578549317990881.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:40:05 +0000
References: <20260505130056.2927197-1-edumazet@google.com>
In-Reply-To: <20260505130056.2927197-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, melotti@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 13:00:56 +0000 you wrote:
> ip6_forward_proxy_check() calls pskb_may_pull() which might re-allocate
> skb->head.
> 
> Reload ipv6_hdr() after the pskb_may_pull() call to avoid using
> the freed memory.
> 
> Fixes: e21e0b5f19ac ("[IPV6] NDISC: Handle NDP messages to proxied addresses.")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix potential UAF caused by ip6_forward_proxy_check()
    https://git.kernel.org/netdev/net/c/7aaa8f5e45a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


