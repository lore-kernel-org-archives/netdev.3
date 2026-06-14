Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A58460
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781398212; cv=none; b=Hme5Rq6CCWYSR2154auOE2Fnn97SquEPWMI97rixOtkGH1UYdOAXIu4hp79tziZgoxqTHoteckQIlSSoBYF7HP6wREpv2pn9sGTiFPWEuLCJxh6nNiwy1q5AUJ+HIHsc+PfvD26vp2Vg5XCFRankOLUanEXcgbM5pjisFan7hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781398212; c=relaxed/simple;
	bh=l1RCpKzB1KpzWFvK7HoY2MJcQhpEjDL4Tv8TLaYsVPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ivGA43u5OxdbVe+/16bpnF8EAL7OznI6n5ZvzQCjianwphIaZpg8u0GZfbnDEJ8lLFQ8FzEw/56+yTDfaCEJMjK/yHO6mdmBeuzIgu8HTuKwk73nssIMMIN6bn4TnuB1oSwg5MAHkEKdxRospg8gftQOda1c9+2SfKsl2ZWqyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxwbBiEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxwbBiEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C5E1F000E9;
	Sun, 14 Jun 2026 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781398211;
	bh=lHA7+4OoR+zVlpJfxavU8nFPDfwyqQ4ScEcKWTbDI60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CxwbBiECXDcS4kLu7In/e9YV7ED8wcx3aMrVLdXvBWcDH49MGd6UimpRLPJEoJz7f
	 wAQzW9+ArXssobnluSYrtx3GUMycfi3p+uR6OfC/SAYX60sMZOf+0Ed6it8jmE0vDn
	 khF/Q2j1FkphXcBgitgKmQvSgdK254Lp8rj9i/f3Hf6RdsJ9hbVaj9DoC5Kl/wvM8s
	 mkHDOLyj4xX0ONuQlqmQu+6l/EDHQvdldWG9rXDJ/auYMpLWmMbWup6+KdaoXK/r8G
	 kHbZ7mG54pkcMLXFFsayu20daZepkToid6oR5765c/rBu/+E6UEiE8QWaNagzRgFPL
	 Wr9st+OZrloGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568753A54A32;
	Sun, 14 Jun 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: ife: require ETH_HLEN to be pullable in
 ife_decode()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178139820714.1641091.2899241191922395715.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 00:50:07 +0000
References: <20260610183814.1648888-2-n05ec@lzu.edu.cn>
In-Reply-To: <20260610183814.1648888-2-n05ec@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, yotam.gi@gmail.com, jhs@mojatatu.com,
 davem@davemloft.net, xiyou.wangcong@gmail.com, kuba@kernel.org,
 victor@mojatatu.com, yuantan098@gmail.com, bird@lzu.edu.cn, edragain@163.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 02:37:43 +0800 you wrote:
> From: Yong Wang <edragain@163.com>
> 
> ife decode may return after making only the outer IFE header and
> metadata pullable. The caller then passes the decapsulated packet to
> eth_type_trans(), which expects the inner Ethernet header to be
> accessible from the linear data area.
> 
> [...]

Here is the summary with links:
  - [1/2] net: ife: require ETH_HLEN to be pullable in ife_decode()
    https://git.kernel.org/netdev/net/c/9406f6012b73
  - [2/2] selftests/tc-testing: Verify IFE can handle truncated inner Ethernet header
    https://git.kernel.org/netdev/net/c/a4004aa0debf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


