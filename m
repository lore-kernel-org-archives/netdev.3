Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73C2F8BEE;
	Thu, 20 Aug 2026 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787258460; cv=none; b=RilC1On9JRNeVHAkgSheyJDVUUQk/CWeAKBzlct8thy1ylq3bM8n0f+phtFwFW7FEreMNx0FHkgJWlFXTC+fDUx9MJmFZa2H1mnbvIW4F1/DhwSfCksWCVUhikCvxYT+vr2sQPCbMHPTFU0rB4SZ38XO8SIkvPIo8dYSaW2H7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787258460; c=relaxed/simple;
	bh=f+F8wueMZRY2eKfCj5swaNFLFLDtV39ubF6kXqs3Yws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hdC1bdWCqQStXRFla/a+2eYcwZHk6G7xbVJxrPd16D9KMCRiAutT5CunVo9Q5jKXW2H9QoZa2FrftCaGx33Znyk5X+hc2VCKB6cbN9yQpinV+m1SM2s/xvaH4e+YnfUOcbRZN6gR54B8V3puvOWmUlvX18/ZsItnLK4T3HKu1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKKAk37X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKKAk37X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8B21F000E9;
	Thu, 20 Aug 2026 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787258459;
	bh=qqP+SSWdls5e1FUAdUoSJnW5I4+HiKIwc4mQ1q5Sdm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FKKAk37Xz/CvttQRuxTok8T281gqxdEvWTwyycjmxDBdZCdq30LsmsBYrtN+HdXb7
	 77AVy+Ota+OIDgOXHqsYwPiV1ZyouTAf+B2TMtpCu47mkiXfYe4TGzUv3szA1JdF9y
	 dCd6kYMorAxH5unkCMtDP8VGi9Br+jPYJ4Qb6PCoo97Fd7bz1ZStxjq5JIyz09+B8C
	 lThbq62eKg8SVCbOpD+eZyo+LaQa/k1f4yPgmjqhJxuYvXQ/xeu2F/IHpaSqix6MXY
	 dxTCYsCT0LLHjEOyZwWupTPyqQwe1xC2Lj8KDMH3nWqlfg8w3oxe9Wu1xiGoc+9WHU
	 6AarhbWv14uTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93968392445E;
	Thu, 20 Aug 2026 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: oa-tc6-framework: Fix link to specification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725840914.473641.12825316399503851545.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:40:09 +0000
References: <20260818135958.17311-1-wahrenst@gmx.net>
In-Reply-To: <20260818135958.17311-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: parthiban.veerasooran@microchip.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Aug 2026 15:59:58 +0200 you wrote:
> Current link for 10BASE-T1x MAC-PHY Serial Interface Specification
> doesn't work - it returns 404. Update the link to the working one.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  Documentation/networking/oa-tc6-framework.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - docs: oa-tc6-framework: Fix link to specification
    https://git.kernel.org/netdev/net/c/8197c180052f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


