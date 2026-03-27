Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B0304976
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576229; cv=none; b=FhmLo3NGUVvpEbqyAgLjDRfOsMbvx50ty/uAfGN1dW04NjQOnpxcpz79kQ8KSDzDqTItfoCxgyO3VrluT3kSfIIusz3nM5mfyjebexeFyXw7nJtiCyQ5GAYpNh2b+lAN2P0FOukPfXWL9dLC8U1p6P61S267fA1KsBBitCHZD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576229; c=relaxed/simple;
	bh=4kiiqE3D+wDv6J6hodZDyGsVtbfDqc3mqLBoh6regB4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjuR+mkwAMZznuNxWA9lwTwOqqN889Jd2WK4vo9lC08pLkUqi+Ndv85BfBAAoVmjtuOXkENhtAcuJE64x7Cnb6K7+Nd3T83ZgC70y/wy2dvUwBiZpluFXMUDGRYjJeHgMO3cjKQr/n/xeWMrn491j+IEviASKtVtih+RviZONcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXZ0u16V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXZ0u16V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FF3C116C6;
	Fri, 27 Mar 2026 01:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774576229;
	bh=4kiiqE3D+wDv6J6hodZDyGsVtbfDqc3mqLBoh6regB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qXZ0u16V+X586A5Gr1e66ujMPC/q07qOGhtzegAWFBvHizW0o0H1jhy3UwTgtt1YZ
	 s9nM4cV2MrjGZkuQliJrSqSa1UHWMZeIRVFL1uNhlPDqgAh85nca2bkqyixpw5DEu8
	 WcVBWMM1WLhqwi8y7jb7njNfFi77DHVCK496t0AGTT94Yjw3iG95wL1f1ms53liw7E
	 lcgGO/DZIxVGFdHjsH9juhDX/rzQqsoyJ5QbpA0ZvoSJ3V6HRABlYwadCPw+07q/Ou
	 tsLBoPkaXag8iWnWtQ7nvuUO4eZjeTMjVJg6em661YznP3mzDVHuLrQNa2UXHbOfGl
	 dzfHGDOzuFwMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF513809A07;
	Fri, 27 Mar 2026 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: avoid copy in fragmentation loop for
 near-MTU messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457621503.3256339.5338687081913402435.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:50:15 +0000
References: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>
In-Reply-To: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 yuanzm2@lenovo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 15:19:56 +0800 you wrote:
> Currently, we incorrectly send messages that are within 4 bytes (a
> struct mctp_hdr) smaller than the MTU through mctp_do_fragment_route().
> This has no effect on the actual fragmentation, as we will still send as
> one packet, but unnecessarily copies the original skb into a new
> single-fragment skb.
> 
> Instead of having the MTU comparisons in both mctp_local_output() and
> mctp_do_fragment_route(), feed all local messages through the latter,
> and add the single-packet optimisation there.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: avoid copy in fragmentation loop for near-MTU messages
    https://git.kernel.org/netdev/net-next/c/e1877cf62311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


