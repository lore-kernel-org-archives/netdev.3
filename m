Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445806;
	b=3BTouWnad3QIHWpxO5e95U0bU5/IaGAM74mGVCn5lR/esTT2QRNO3IcWJB3U0C4YtUn7
	 cXW/FupAriQwXmNOhRlq2K9CXGWXIXwQRmoutYWAfD6oASQGBHZ1pQZ0rFVPKRvPe1udi
	 nceMbrxuGfWqTWLKLoF6IcsxrNUyR0hb1KJx3RZSWXE4UuwAKaHs3kWTsvuv6gJKMClQK
	 tAfVw/46I9t2RzRbfh1dIgkGBDsRbEiQl1+TCq7Ql/SxW9JWagoWM586HRSW/zKe9i7mn
	 tD0CAUdlK+dBvObO/MOZ7RB9NZBzrgJ/djWTE9HFvXEScKivYxfOqVYmOp31zwm4eJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6fxkIUEUzyle7Zrx0jGwr/lUnjzRkrMVgN4T1ImT6Jc=;
	b=3RLN/YnkWTTX5xKP08sJvWma7WIGuUMhewjmAtb7zlVcycPIt6zHqxX8g6AfLjc2UnP1
	 TITLFNAb3kQYAAEPlDiUHvLNdUq3xpmAtL/zobnDPKklG+Llb2kMGXXieJlOXpw/8v737
	 Em8Jn+D/GA9UCLSrCJF+qLydZo+ZsSZUJb2fFFH3+budJkiktL9a/7ybQQAC2Kr8sR48t
	 5m50pqPLBdr2e5SlJS7O93a4bwPwPYqnxqa+yqVd+YZqF1hCsUBh7kU3m47TKa9DvBKPQ
	 1iwoM4SpW2QGnT7FRIZFrVVZL8JCqNIB43mhN7hTGBfGAOLzYRels/LMaDfTmIlzNbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAhhY4wF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58C5606A321;
	Thu, 12 Nov 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAhhY4wF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F4D1F00A05;
	Thu, 12 Nov 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445806;
	bh=6fxkIUEUzyle7Zrx0jGwr/lUnjzRkrMVgN4T1ImT6Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KAhhY4wFOOxBP8prpZlGgBOJbPW4zgteWYiawD5UK33yphoZwDr/DaWfPoaDKxgXZ
	 ghgDS7vtkU+oi/IdWXpOanuSxDPxr3DSugKZpUIFwvePkw3aU+5EDtEHhgt8l9/SoX
	 /rZLM285Beh57SQkprl5oXYGEwA9zGvzgbgVt1dM/fjTHpajYz4LWJQLX69opD3Rzz
	 i29z/3exIdHyaGxAIeAzV6+OXuvuKhyAQyVqPp+Tr+expPns8ZR1j82s9bU2D5Yl2a
	 SWGeC2gR1vIhCzIPmWHttu10yQ+rqDj7vXeSU2eNX1o/7YdeaFDPP9dg5TvKa3q477
	 MLsrnUHWTtR6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E0BC391AFCE;
	Thu, 12 Nov 2026 01:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net] tls: fix async encryption race on weakly ordered
 architectures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444580518.1745669.12722897429288810023.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 01:10:05 +0000
References: <20261108-tls-async-tx-ordering-v1-1-f9a1844ca88e@xsightlabs.com>
In-Reply-To: <20261108-tls-async-tx-ordering-v1-1-f9a1844ca88e@xsightlabs.com>
To: Ofri Zangi <ofriz@xsightlabs.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vakul.garg@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, guyt@xsightlabs.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 08 Nov 2026 21:12:57 +0200 you wrote:
> From: Ofri Zangi <ofriz@xsightlabs.com>
> 
> With async encryption, a record can be transmitted without its TLS
> header on weakly ordered architectures such as arm64, because the
> consumer may observe rec->tx_ready set while still seeing the old
> scatterlist entry.
> 
> [...]

Here is the summary with links:
  - [net] tls: fix async encryption race on weakly ordered architectures
    https://git.kernel.org/netdev/net/c/a2fd526d6442

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


