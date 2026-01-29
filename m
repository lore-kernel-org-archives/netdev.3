Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB828D8F1
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658626; cv=none; b=r38LK/W9KsxUP8HGg97ixg7L+K7wvGqfSdXHYwvbFXrruRNhTJjPws/QJNhaRSpVg1epJpNSMX70Wc/oR7MFm2mBHFLrDuAlGSkt1edycI/dOAeSp1gndtTWUt4EewAjzv5+ltqc5C2+89PlMyeoHwO3KYeLQoGFj4SjZ7uRg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658626; c=relaxed/simple;
	bh=pQauKN4KlT4d/if/gdzSPPNxKmMDmVAum4+iETofnx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boC0HaTkGznI6vxvOZOBndAenUgXQ7w7W6xGztRKkVFth+p2xYGINPK0ZzJ8+856PujHNx4ZNXiLd0MFKnBAPLMRBkCFxdnTiVyCuYCUcaCoDNnw5o7AGFM24fLxVPS308aJKMyL8uxjlC7+iV4+iTk5z/wktG/rHdVpWSxh3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0bZvEPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0bZvEPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E86C116D0;
	Thu, 29 Jan 2026 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658625;
	bh=pQauKN4KlT4d/if/gdzSPPNxKmMDmVAum4+iETofnx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0bZvEPtoNgrOBzHS3PPj6+Mqch59FSkzJ6GMVGC6NwtsiXZkH4EJNz8Fx5YNWTS3
	 t9wbvj2NWGxkAsxbotf/8Hx+Cj9hoIXLz82AYODG9gQplDUqMBsQUOFzOfSny0AxmL
	 JvwTGkAezmA62gSR2t2D63ee5yPknBvSeVn/2q4tAuSS3HajE1InHC5DOzj19KvRz0
	 lHP5VDHBxyRFoToDtMHXFUbSOAofCwLRWqLh5VdMewui5fLTDl92Qot707nlQbU+yO
	 TMssEupX8G8aJfZk0e7bXVRwJjc/bmhcuP2WFZ++DCxvvgeldQ03aj5owXjn5s2n1H
	 hSausNJw1TNoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4ECF7380AA61;
	Thu, 29 Jan 2026 03:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: make tcp_ack() faster
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965861910.2339773.11861882373028938798.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:50:19 +0000
References: <20260127032147.3498272-1-edumazet@google.com>
In-Reply-To: <20260127032147.3498272-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 03:21:44 +0000 you wrote:
> Move tcp_rack_update_reo_wnd() and tcp_rack_advance() to tcp_input.c
> to allow their (auto)inlining.
> 
> No functional change in this series.
> 
> Eric Dumazet (3):
>   tcp: mark tcp_process_tlp_ack() as unlikely
>   tcp: move tcp_rack_update_reo_wnd() to tcp_input.c
>   tcp: move tcp_rack_advance() to tcp_input.c
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tcp: mark tcp_process_tlp_ack() as unlikely
    https://git.kernel.org/netdev/net-next/c/773a70021313
  - [net-next,2/3] tcp: move tcp_rack_update_reo_wnd() to tcp_input.c
    https://git.kernel.org/netdev/net-next/c/629a68865abb
  - [net-next,3/3] tcp: move tcp_rack_advance() to tcp_input.c
    https://git.kernel.org/netdev/net-next/c/d5fb143dbe8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


