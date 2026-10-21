Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545607;
	b=SURWLzC3bowFhmy3o61CMqNHwq2FOjjLnNNLmkU6Lp2eI4q6ADAh/v5V3DoaI/kNcX8j
	 9FevbHP9DoyZsp6F2PeDg/RjnEXoJThmomW+i0unYelDIR3PT4AQdy0B7Ja+YAyj5dYl8
	 fUZEqXYJRQDqBAdx8CnhXDt4tDWyld/uO+yQVJVSm9VzvjtO5M5RuALi6dxHXaz71Wkz3
	 /VHnU6k+j/0htnx+MiCxykYxaEvbVU4rLNaZXzOhXNE7pPjSRxGEmy/oxcxnvCOiMPHuU
	 TWI2JuMKAeIhjJnWRKd09k7tUbX8uv7vtBR/6LJ2gH74vK5c95isfpcMOHsXrx43xKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qHESLjhchNy7l8qwRK/+9EbJjdKO9HPT/BSZ3WC2Vyo=;
	b=LwIwPxxUZWtXp0OTULwI9O6P1nPVEEBx1+phSkxj6/KuWmosbknnHmn3jn7rnJ0ZH5k1
	 5SjSE8NCnmI4MMli3CG9/04hIw8jMcWQwyDZOp2NX6aEPPNVJtfaZG36/uvoNBVpNOENE
	 6ZaEM/RJOJWalmhf3NbH7qzV3afW10GNORKdw+B7umlVImYwCkRQvYrOPNfseWXCh6gob
	 fVYQdvnFFOhoPVW17mfHCi3HnBhkPDf7bzR68qMOix8shQIhQXbpHR4WEIWbKha0d6a+d
	 romkY4li7VEdMNtgYLlnR5tfHKQyMtO5H/XLimMFwI0ExxW7xpomSGiIddxZ+r8S4FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2MDpnk5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9768606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2MDpnk5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8851F000C9;
	Wed, 21 Oct 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792545606;
	bh=qHESLjhchNy7l8qwRK/+9EbJjdKO9HPT/BSZ3WC2Vyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i2MDpnk553dXZv+nDNWoYwZ7p5Mn7sgzgctj3fiIOhXGjy0CNVvcXs2qJdrjQiyZq
	 Qfkc8Vn5eS8+0nNv33ieZhgAYIxUO3pssuiXWUniibu22a5WCL9yZZapJP7/0FQ4NP
	 mPxMmIPT61fSFuP2I6x+szeK5E22EC6eav3HxAn5peiH9fNloztlo73Lv8BVt2DDus
	 l704eP95L9f5BMjf8VWM7iQmB8+C5Ixg7wae9yNNGQ0oNh+morjCNptk9Ry5NNd2z1
	 twbhuOMQKVVVBZRUg/V/N7NdklSfIM7pbNhplq/vvuBuZC0ZBU91GN9ehiWmfZiAM6
	 0IlWnz0Q50Xpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774A33809A0C;
	Wed, 21 Oct 2026 01:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net] MAINTAINERS: Update Michael Chan's email for tg3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254560528.309122.14333911319097896174.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 01:20:05 +0000
References: <20261020225358.1130051-1-michael.chan@broadcom.com>
In-Reply-To: <20261020225358.1130051-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 15:53:58 -0700 you wrote:
> My old email address doesn't work anymore.  Update it to the current
> working one.
> 
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] MAINTAINERS: Update Michael Chan's email for tg3
    https://git.kernel.org/netdev/net/c/746d0e7e851e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


