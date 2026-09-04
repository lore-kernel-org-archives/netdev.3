Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F20255F52
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483069; cv=none; b=uAUj/jxKniTw4pc3Yf1JH0F/5lKBDYtwaHEHULD4dZJyzaEX7obsn2mb7HG6gk/QzN+Q+zXhsKNzMNQoThJkd1F8zaLir2aVR7Ams1qR31H87cAUA+A/QOGpdEIGhlDq1vX5lFPxfkg0TL1nV4y3wR01D13yEzFO0BtYDJsE36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483069; c=relaxed/simple;
	bh=ioE0Lic0g3CZ7/QGRU079wxD0YiAb2loJK+vCzlOlc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WH8kdiJvCo2MnKBjsJYQqTGVEml1rxIdZfM1a11HlzVxzmSj0DomghHW4t8Mmyx2rpQJTema/h3mFxWAY5RrPT1YY7yO7rEohF3c0PS3xGJq4ekEaByKOT8QxXLXgRrknaSKUAOFhTAtvLbE4aoOPEOviQC6zOlbWYb/exe1kRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kySHdvYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kySHdvYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EB01F000E9;
	Fri,  4 Sep 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788483068;
	bh=3ylrrDlisa8P4S/qCRaSEziEnRGadzu8PcxWqZtqaag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kySHdvYWF7afX2dsDsH/IYfKCsgbTf16C4YNRV3c8Q5vR7EFLE+IlFRcjgeihxkKL
	 /O0Z3v/pQTyBVUhoq6gwxeMbE4Idm1j9XEk8fMTMEjbhNmnPjgn1DFrHKt7SLLzq2Y
	 /t9X9Z1BH2a8AGxoCoXMuecb2JcZSRMJwt1g1BFi2VqS3X2UTeyV/yMzQMqdlJ2PI6
	 KSJ4MtdQufw2ea72TYyll9oRjnQQTlxPhZNmzf/j5tzkcxIYv1zZTN4GrSFGPZ3Gqn
	 S8hYL7YNj0uzjGvv2W2xaftxsYhWeHf3D3QARx4t9cOLsi+1CucdLgkpFMAtB4aqx3
	 ersSnxU/xnekg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C8638119E3;
	Fri,  4 Sep 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mailmap: add entries for Lorenzo Bianconi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848300893.4094353.4013169154490931549.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:50:08 +0000
References: <20260901-lorenzo-mailmap-v2-1-0ee832de0caf@kernel.org>
In-Reply-To: <20260901-lorenzo-mailmap-v2-1-0ee832de0caf@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, akpm@linux-foundation.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Sep 2026 11:21:24 +0200 you wrote:
> Add the active email address for Lorenzo Bianconi and map the old,
> no-longer-used addresses to it, so that git can attribute his
> contributions to a single identity.
> This is done to avoid bouncing emails sent to email addresses that are
> no longer active.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mailmap: add entries for Lorenzo Bianconi
    https://git.kernel.org/netdev/net/c/a09ceadff95b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


