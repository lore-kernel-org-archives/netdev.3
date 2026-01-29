Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4068364E8F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658628; cv=none; b=NfIN1Tyjc4QvyOJTGulpJwriUYU69sQH9upn2MpBH4lCCG2pC44VguhN76Ifla76jh8QM8najXDvtPIIx/TOQCjeriMC5HwTQOke83zOtzFaG/Zpwm4yXs6jFROf1KZx+A+1ckhKcbDPCM5cGCwWHzPX1sgP2QSTEzCP66ty8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658628; c=relaxed/simple;
	bh=qwSp57aUe23x7RGmRDBoTYs0OSC1V4V/FuzL4SoDNaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BW9qu8Hiy6s51KEgnD7P7rorQqoMU0nPAhZ+xQ0pnvanZArpO9Ps2rtTN9FECOR3Jzc/sjJm8EiWF1LU+v4s9VEcqCVrrhvIkrQfhKS3hcjqo9yzDF9bD9XpLBLjjdV2Fe/FnfCsyKxD14X1kx68ziBxyztK4T3Qkwng1KwEHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMHcUXcQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMHcUXcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59287C19421;
	Thu, 29 Jan 2026 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658628;
	bh=qwSp57aUe23x7RGmRDBoTYs0OSC1V4V/FuzL4SoDNaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AMHcUXcQq/x+oLdmvPl5MM+vLD1uEDZs2RUbk+k/UeGzHs0CEf13W/GAyKzHR0IRU
	 qmzzBbbztiioqSjoH5txOQoLTdw/Mji2luS0fJrB+hlNFH1Mp0PtaNZZ5hgDrMhwZV
	 Op6o7lWeQywcMdk7sk6uAERXMKT/e2sMOCV2qmE9OM/KIXgQpkpa37uMkAdM4ZMGW3
	 RXTb6k6letDhTLBWv5/db4mNbAqA5XAzTKDoYxCGZUPLKQP9mvjwzW3YdubUoOSZNN
	 0s6WHObBLxEKC6TbCPlKSCxXn3nvGriaRW6nda+69izp7iloDvl2aEIkkiEooI5xJ0
	 jqWfFS5GfdoQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C1D380AA61;
	Thu, 29 Jan 2026 03:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: remove __inet6_csk_dst_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965862159.2339773.16983410630098572652.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:50:21 +0000
References: <20260127211203.1524339-1-edumazet@google.com>
In-Reply-To: <20260127211203.1524339-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, dsahern@kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 21:12:03 +0000 you wrote:
> __inet6_csk_dst_check() is a very simple wrapper with no value,
> it is used only once.
> 
> Directly use __sk_dst_check().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: remove __inet6_csk_dst_check()
    https://git.kernel.org/netdev/net-next/c/2f80b2797a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


