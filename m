Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D378F4A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725863; cv=none; b=nsSMVqEE7P8FFWwLKVwCGU/o58kR7ZAWJXedPOByTVexWwlF3VOQZNN1VEk9dfYzRkqpr21O8jDCGee8GJ/L8ssLR0nUPg8IYYVRzr+GZKeS7ovEsaVMhjUojcRGYPIp8EacV15VvUGwe8RFo5n6isfS7yTVS7e5N9moZ16VdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725863; c=relaxed/simple;
	bh=QaY9eatydCPWfrZZLYRUVbtZ/rd9JwMuQhnjcHw9+YQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I9lfg1jcoBGnIGg1xTrONFTElWnhAEG/6mU7A3dVYjc2ONPLb9IshKrrsz3n4nQcx6w8q+gmyFvS08gFgWtnnIhPKqOOx2bIcfeXxvJfo1T4NQC+y95AeMxzlk1B6wSpOgs7R1lR0V0wHIrocHz4gtAqKeFAc2Ab8gBZ+6uViDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHWxHyIw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHWxHyIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283E6C19425;
	Thu, 14 May 2026 02:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725863;
	bh=QaY9eatydCPWfrZZLYRUVbtZ/rd9JwMuQhnjcHw9+YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BHWxHyIwdoYqO8dPDOKw5Vs8A7w6HpLGwRdn0h+k3E3DJqfY60TVdW7HVoJOgQKl3
	 naP6lQWenHoQQMIRUt4jA7YYyyvjF3oPj88PhOBeZrpzByqmSaSA4pOXI5LjWrJRxV
	 j3azEBlHPH7WEWGyKkPaQEFmb6MEOGhqJkhCIkrkvOGoGGELU8+dMvVY3ku9NDSvrN
	 Lat37cA8MH5sh5TWW199V2pTPZD6k6CIAoz9z1QWsLLOc/1etJHP6blVP6mRRAkFQ/
	 YCePRTPANvuBWnA7kqNX4jXWhDAE2uluiTZdfJzsxw8zKBpEwZdHk8R3cBrbthPBLq
	 KspyckoF4+Gtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8F382330B;
	Thu, 14 May 2026 02:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/sched: refine fq_codel memory limits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872580830.3927681.5359587387484533956.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 02:30:08 +0000
References: <20260512094859.3673997-1-edumazet@google.com>
In-Reply-To: <20260512094859.3673997-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, toke@toke.dk, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 09:48:57 +0000 you wrote:
> Packets that are associated with local sockets sk_wmem_alloc
> do not really need additional memory control.
> 
> First patch makes is_skb_wmem() available to modules.
> 
> Second patch uses is_skb_wmem() in fq_codel.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: make is_skb_wmem() available to modules
    https://git.kernel.org/netdev/net-next/c/f0de88303d5e
  - [net-next,2/2] net/sched: fq_codel: local packets no longer count against memory limit
    https://git.kernel.org/netdev/net-next/c/150061a20651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


