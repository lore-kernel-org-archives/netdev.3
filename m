Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3833065D
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256685; cv=none; b=F3vQC9p+me8/vQpeoOWpnigsWwTUs59KDFhmDv2nM9UH7df2cwtY9+YP6pELQnahKmO8KPP/BetIW7FNF/0wmvj6365jn9gBYWiUXpI3/8/2ZUeyVT6+aM9qJ9HBROWablVqsuXRz0lh1yC8UmRNlF+ntSVHjf5Nj/gWRHqjhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256685; c=relaxed/simple;
	bh=IrF1e94MaXgB9sFAS7L5d5gBXHLC/cJr/axkbUzilwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gb6IobfkwrA/cIB8nEknk5ibLN/Kg+a5W+LY/8a2rwwA0HRMvsEyJLZAS0CmMXZU33J0OmfgFVLys8YiaSIVbq6xPwGDPWYPwelJ4v2I5U0GLmieTlyAcvW5CoDxw7mcQ4MO/Yxxt8HxtOfls6gfRqaM7JlF9lSGWmVGlU2dKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO/2RWPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO/2RWPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B990E1F000FF;
	Thu, 24 Sep 2026 13:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256676;
	bh=r64zJhaX91u30ma+6dmZbqpIYFfWggkisSXj9MuIV9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gO/2RWPP/jiaWFBn7vthnBgg+BWVSt3MDdKsw6UA1ihk45tRRfxeeeKQVtMdey0Mq
	 lUN2SEaOexj6eR4qHRq7YB/bZsV5Tr1hokAyURGl9Sr4tMFPWntGIg7NdGVK9CKJCp
	 xWAzKnlBo/Ol8y+/N1tZ229jP0h75+QD3SlBuosBx+kFOywoNtpmmkXpo0XQKAVjTg
	 M4Kx0q0/HRVfy/7Q8pVhEe8gicj8rmZcr+MUnX1hXQ0u6qnS4a1INJhwRnfYJsrY8+
	 n3ZAdI9vx8//21mz+Pgn9OUjvJWORR+nKEVSR8X4EHXTHoTzirjS1vjtobTDtmG/qj
	 2dAPokW/oYZBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1978139FD333;
	Thu, 24 Sep 2026 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: act_ife: validate metadata length
 before
 decoding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179025660590.1549224.1869511932861493218.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 13:30:05 +0000
References: <20260921125441.81459-1-fangxy@xiaopeng.com>
In-Reply-To: <20260921125441.81459-1-fangxy@xiaopeng.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, xiyou.wangcong@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Sep 2026 20:54:41 +0800 you wrote:
> skbmark_decode(), skbprio_decode() and skbtcindex_decode() read fixed-size
> values from the TLV payload without validating its length.
> 
> A malformed IFE frame can declare a shorter payload, causing the decoders
> to consume bytes beyond the declared metadata value:
> 
> [TLV type=IFE_META_SKBMARK len=4]
> -> dlen == 0, but decode reads 4 bytes
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: act_ife: validate metadata length before decoding
    https://git.kernel.org/netdev/net/c/d6ec384c87cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


