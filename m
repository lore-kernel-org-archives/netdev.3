Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4B349CFD;
	Thu, 10 Sep 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002673; cv=none; b=J9i28RnpjS2xDzDmfR938hoESCcBo+5OlK2aJ2kO8axNG4lO4vO/aSa+ctxdatoG8PV2Vz91sMmN6ZJMx067um7bNnMSsbJ2rEdBsZHYcO1F60My2awy+dqhCKh34ozEeLTMFoYYBeFWCFWinZmh1VCU6fg4hWEemI7lL+vtmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002673; c=relaxed/simple;
	bh=sAgfaSoinSOxv/t18tFlGhPfph8YTIg/aRuXwFChmP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AuvgEFSAmJYiygHlyRZANTRr2EOYQHCFEZxYPenOLYSN+25MUY5hKnutESLBvtFoyeEYuMgQQDwfZvl3OtOAHZaR+TsNfuZCqR9ulq2jZDWcpDWyPCucY+lPdqClrFNrX1nOng6M+aYJ7qugi44F7vwCGBok+GmsPdbauNBEWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amT6mMm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amT6mMm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97E81F00893;
	Thu, 10 Sep 2026 01:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002669;
	bh=Lq1ZSQ5OiKJOZAKVWzU4ajEzPsfifED1P8AzxkwcmK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=amT6mMm0BRmNkuHu8qIzOOx2QUiGlw81PN81ZUpO7e7nndB9JRAbxuEnfC8hpEH4U
	 gHTOO/ffFEWr7PlTx4hUgBfM61nfVpjoX9FSY1BdanLq35HdcjW/P1DKGieotqUzEC
	 4UQ4RXxT7E+s4WuaLnV5DVkMT3oy3aD5/rN0JNQutWAIBrGSVblMylnOnJu76zBkaj
	 lNgK6Vk35GqtRrwV40A3y0mEZQ48niOM+SewvjNjrupeeY7AA+QfBvOCDfSxpKZl8j
	 pY8rhT7sVA9tQJB2a5BOzQVzjw7nAE1RiJJ6mgaN1TOIUvKao3eq54ipGLQsKbQqST
	 VPd4tSUDO/Kgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0904380CEC5;
	Thu, 10 Sep 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: mctp: Fix the struct net_device name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900260737.1135028.12058111504003480364.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:10:07 +0000
References: <20260905095116.42147-1-kmehltretter@gmail.com>
In-Reply-To: <20260905095116.42147-1-kmehltretter@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 netdev@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
 skhan@linuxfoundation.org, rdunlap@infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 11:51:16 +0200 you wrote:
> struct netdevice does not exist; the type is struct net_device.
> 
> Use it.
> 
> Fixes: 6a2d98b18900 ("mctp: Add MCTP overview document")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] docs: mctp: Fix the struct net_device name
    https://git.kernel.org/netdev/net-next/c/a07a9480298f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


