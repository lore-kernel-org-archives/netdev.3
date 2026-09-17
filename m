Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9E3AFB11;
	Thu, 17 Sep 2026 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681871; cv=none; b=U25GFY6NL0ROtyWEZ8NeplSyYmqWS1eTUghyzeZI9ma5mtQhQbs678hl7oQ4i8vjWLADMMxKwRKoSuZqfq4YCUmUeK2bCaIsFlDt/IKQDRE2OCrxyhFhiCV+swuQd6u1OglwR7n6us2gIOOJQTwVtwrQJBjTAbTFNxAGcHlq8B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681871; c=relaxed/simple;
	bh=o7GiVrYU9HmZv6GGxeTgiMeaKRW9IHczCY9vp0acl5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iu+9lKXtWFJp4emKAKiZzHXQtGBA4ev1hKgdak4D3Ro1I+olJoa/UzzF/dAnW53lHNp/ClTNPLCASG2mHe/DXqT5pgU0P8tVGMrPKXCZiynfZSIKniMvWwyugJaYOZVEA6nQyW5i+31eTKXM1SKck+jj4T8HG48uRFYu1uc1C5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNrJhzGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNrJhzGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645B91F00893;
	Thu, 17 Sep 2026 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789681870;
	bh=kLmYYwC2+G1c8/ZxQqYgbvXovsBJx70fYFQYL1zgG+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UNrJhzGBcwOZya6yhPdFZbWG++1JZs9Lts2QyiJl2hVC1ngfiUBbZ1EA/Qm5zQdKm
	 tRtK+ADS86Q/RwrUrr6ul2M9uCIG8FBFAttCA6B9ROGflA9BDHdMFJmDFikzTg22BD
	 XzjT+oSJF1byydaCEj7kG2by8EXJnGkjYZLrk95gAKvPamFu8LU/RNuUhgKF6OijA/
	 4YpCgctTxuOo1jaE4HhbZt+bT1pbOBz7CJ1+uhV1QTY4fKggHswZ4B6/7uvUKw2B+C
	 kaV5AyZ+xSWTdO+Hv2oDKyAfvUuABrWnNdYfDs2wP8dyO4+0FvbeSnmBOKyTNx78GP
	 j6f8MfrjbmUwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1985938119C5;
	Thu, 17 Sep 2026 21:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mailmap: add entry for Wei Wang
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968180388.3889427.10193658279143911493.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 21:50:03 +0000
References: <20260915201412.2201757-1-weiwan@google.com>
In-Reply-To: <20260915201412.2201757-1-weiwan@google.com>
To: Wei Wang <weiwan@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, akpm@linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 20:14:12 +0000 you wrote:
> My Meta email address is no longer active. Map it to my current address
> so that git and get_maintainer.pl stop pointing at a dead address for my
> contributions.
> 
> Signed-off-by: Wei Wang <weiwan@google.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] mailmap: add entry for Wei Wang
    https://git.kernel.org/netdev/net/c/c0078f4d8c8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


