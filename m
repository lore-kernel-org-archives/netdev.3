Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355808;
	b=VjMdnAFSqomxQIVKAJlL3Wq4IxA7+31uaWvetDr6zE2zkTlouYA+S98w3w+V/hsp9apg
	 zxVeJR/4afcnzMYAHe6ygY0dxrYXHEAV3lfP7gLvQFk+IkG3nryNYSTYn484NqvPi0cBA
	 1p5jM0z7lhiVbEbfXFrK4dLnjGot0As2R80EVUv6SWW/NrrnWl/kpJmUYU15AyRCkKRAV
	 ujFVLC7060dxNZgxctAvQ/kNDT7Ucyq4bFn7jWnXsUvrQMj4uvZhN8utP5bDbi0XGAtKL
	 WV75IT7YMDdjOA6g/B4fpbvjlrUkssgOP+zRltRVEs32Idm9piZ7RdHJ7koeWRmF+Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JipW3Ceb+7NCtvWMNFO/Z77o0FixeUdRl+2wilinppU=;
	b=shKbVRatVwrGQcQVRsEfKQ8tsf3Qn5jfTTFVfnynvozXBzy0gw9Usp5X2lOUUK3fA+i6
	 h4m0AOCeOui+87lQBDlHZ19D+oTfTMnqE9/yyrx4bLRIrDG33qCrj9ynZUjZMUdg7wUAn
	 v1m4vvi1Mn0jFNAUuOenqQpXnSjHlqIkR1KFZ61mPk9zbrwF0Ql2eqgVjUOPe94CSwxP0
	 HNIYUk9c3lGk0k4h7l9o2mPXh6zvEODQtOdDmf4xZdeqRWG6SXDgTkUBG8pLYKjetgEvu
	 GobGZBSLGJxLZI2NRwMWf+RPQv7Kw3N+d8k6yDw4ENxCSujVy9uYsUNBadLKA+LtIlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cExn50c4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53746606A332
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cExn50c4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35991F0093C;
	Wed, 11 Nov 2026 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355807;
	bh=JipW3Ceb+7NCtvWMNFO/Z77o0FixeUdRl+2wilinppU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cExn50c4y6Hcw0nVNUOlguKI1Yx0OG4IWVAB3z9UpJk57yMa8KZPc3VvPxIO3dzds
	 0mv8kBYbkZEBb3dZb6DrgNxfC7kz214SYSgXUrcN8B60/7kTrZqV/wQSXVfD68cVrR
	 rGM+nBwj3vNdLDSkbvq3DGuTQepS0MNDfAiSYNMkY+ZMruadMxNwsLnjkqREcDEx8C
	 kIodPrw70d2YnG/NuuJQIatT4rfUTkML4qyztbgOWMjGWaPtd6xYhL+OGF+AJTZk2G
	 cSZJRqGjRkN9ygpk3YXk7/rglcRNEgEWLvgaS/cUURLwyBm+R9tLo39AyCjWFMFsdO
	 XnnfehHafdbpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82D339E8A4C;
	Wed, 11 Nov 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 1/2] ip route: use the request size as the
 limit
 when adding encap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435580642.128546.15113726545917485391.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:10:06 +0000
References: <20261109053209.65753-1-kaquoin@163.com>
In-Reply-To: <20261109053209.65753-1-kaquoin@163.com>
To: Fang Jiabao <kaquoin@163.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  9 Nov 2026 13:32:08 +0800 you wrote:
> iproute_modify() passes a hardcoded 1024 as the size limit to
> addraw_l() when it adds the encap attribute. The request buffer is
> larger than that, and every other attribute in this function is bounded
> by sizeof(req). With a seg6 encap of 60 segments the request still fits
> in the buffer, but addraw_l() prints "addraw_l ERROR: message exceeded
> bound of 1024" and returns -1. The return value is ignored, so ip sends
> the request without the encap attribute and exits with status 0, and a
> route without encap is installed silently.
> 
> [...]

Here is the summary with links:
  - [iproute2,v2,1/2] ip route: use the request size as the limit when adding encap
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c4a39013ba80
  - [iproute2,v2,2/2] ip nexthop: use the request size as the limit when adding encap
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=1d64d3416d60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


