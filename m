Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF6448B97;
	Mon, 17 Aug 2026 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000459; cv=none; b=m562W80kHC6d4o52IoL0vEwmMj9/1wLUa62nFGTfgiWABHtkiI2eBf5Wi0MF42AfQ8hhY/f82s6OHekqDgwO2tVjLXJFd9S4cShsDmgRjZWNOf9tH2yMBEq6P010DuZBcDu0vzjqOmg35PR+0ai9W1Mxp6TNB1pvdD+EjQbC2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000459; c=relaxed/simple;
	bh=OA6GMVtFT272Gv+UVJgvIHpbCc39V3Bsm0g/aesdLUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eB44rXFukZQgBvX9aJ+xcVVf8aSYB8w3amZc/dHj5Gx1D8VWl663BlDGWIftAXu8VeEuJGv2PpTKOQ3+K/x5QmAna4DoBRsFN9bnrFqSODEDYD+fxptXiPiMcNc1p2gxybWxPbct3PKiNCmP8gXCkOdGpDSDgAwCxgXfFnUNZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDELkkQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDELkkQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450BA1F000E9;
	Mon, 17 Aug 2026 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787000458;
	bh=wuBmgzoNnBPVCJeDcaOjrJiXQuBClCzl+tztUYTJssk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TDELkkQL+8Ob0+YHTWJObacmMj9m2PCp3fNOr5tpLIh1B5+EDC4Lgch4MpCo76K47
	 IiCTFtBeZWTwB/KI9mDqIIW9IFPClm3ETuNHst6W3HtzFUBkJjC4sUx8S1oW2nbaQe
	 amQ/dhxgw2Cgmos1YW2T0XxskWBexwXzQA2ooGHccMrluR8+BKhE3ubcSPE85Pb1Vt
	 k7sWPmXIMJvdPNl7ZKVvPqYY6JkmAC8jLPJWqTom0MW0J5LIH4O0hjv/C5BTVf62qY
	 hy5fNMztSoixCd1MY6YIR087K+TJKKrYSC3fzX+/P0IOUfpigYvOZlWHVFNBs5UQKo
	 0dd/nIkaZTToA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2E3926265;
	Mon, 17 Aug 2026 21:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net_shaper: fix kernel-doc rendering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700041013.1735578.3422132046076853057.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 21:00:10 +0000
References: <cover.1786751700.git.kmehltretter@gmail.com>
In-Reply-To: <cover.1786751700.git.kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mchehab@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, horms@kernel.org, rdunlap@infradead.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Aug 2026 03:32:27 +0200 you wrote:
> The net_shaper_ops documentation contains a malformed ReST list and
> exposes a kerneldoc.py title-context bug which drops valid headings.
> Fix the list first because the parser correction makes it visible. The
> parser fix also restores three Xe DRM RAS headings already in mainline.
> 
> Tested with Sphinx 9.1.0:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net_shaper: fix kernel-doc list indentation
    https://git.kernel.org/netdev/net-next/c/09b7c00d55a8
  - [net-next,v2,2/2] docs: kerneldoc.py: preserve headings in kernel-doc output
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


