Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279318;
	b=jdb0YwN2286R3azqgPu1+Io3FFDyEyzamX3sHIiSXxTUgyZYfKuSsoCCwQSg3qvGSrvU
	 BfQ/1EGmRRq0spTDNg2a3tx5nEK8QTmFJlzklUkK1PuUeZtkWaTYobBuYLpAbRjHIeXkO
	 o716TZHBwPR7dd9y9WKfT37vKkHRQ825wH1zYQdGvZ+9nInHagFucyoBTwFlWIzB3widi
	 kCPOphhEG1f3q46xMdEgH0COP5ufMn77nJzylEsuo2+uowNjw/kNKOCNgjXD6QuWAYNmj
	 RYn2ISWwWX6XLVG7onUj0iZFcJ584bpDMBAZBTYDpGXYrrG8uh9wavk5dx3L4n9YmYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279318;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Ryr/YCOGfr9nvO+2suuQw9qH3lv+dRckup4q1WryHSw=;
	b=KcPjrWbNy17eZhGgGhTnNc18VId7XjHtBrD1EcYF5G2QFnYgcAIrwcddSOymS4kZrlju
	 k1MD3WY747ymkZI+BQmCxOA48U1xqV8moLm8Pizuf1IyZNu7POqf8GCCwvicY5E8eeZ88
	 DCRqhRNEuQ45vA5vBqIIA3c3BMAVlRyU2auPgctL/TUV4xXTQ3ywLXZnb7VlGDc+6LTOz
	 OusgJ0ms3WIfLM2QmkL/wnTLxhbuoO1dWzjfYo788Lud+w585s+6aFU6IB7JDhhz+vtaJ
	 FbH23DhAQUaUlaEwf+wziXJJ+nN5M/L6mB1rAMA52fmMJI1DNyrg65i+fFLj8kRrLAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6jxqqyq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F3606BADF;
	Tue, 10 Nov 2026 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6jxqqyq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41231F0089F;
	Tue, 10 Nov 2026 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279317;
	bh=Ryr/YCOGfr9nvO+2suuQw9qH3lv+dRckup4q1WryHSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X6jxqqyq/IgETTMLUb99phG6ZI2B7KwBOVeJkRE2MWOyqIkHs37JDWSpdU39dozn5
	 ybZhN3PoVAkP16CtDhdg5ZvmMH4Y4SAiLsomEVcVeVh3CblToPOWB+LalPpaeqhVnI
	 u4pYDvGzOh3YTkgc6B9gdZVz70yR2DxNIM+EIQ7rg3wyS06NRlVV+ZSZdoL/n0j32E
	 cGZFHiGMAj3ZUzzkeSc91llnHHev1IaJfZzCSdCKTE/G2j4JMVOKD1NTOp63qNJ3uB
	 Hu03GAHDfRC3HA7erTP3GyVPraA00/ktBS8FUTvXNlgQNxlUTCMd5Rb/NbMd1rE48B
	 FIDTGlGKFmUAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B200391AFCB;
	Tue, 10 Nov 2026 02:55:17 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] l2tp: bump tunnel stats before dropping the
 session reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931617.3612825.8081282959489295835.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:16 +0000
References: <20261103084249.1337657-1-xiaolinkui@126.com>
In-Reply-To: <20261103084249.1337657-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, michael.bommarito@gmail.com,
 gnault@redhat.com, alice.kernel@fastmail.im, kuniyu@google.com,
 nicoyip.dev@gmail.com, mail@david-bauer.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 16:42:49 +0800 you wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> l2tp_udp_encap_recv() derives the tunnel pointer from the session it
> has just looked up, so the session reference is the only thing keeping
> the tunnel alive.  Both error paths of the function drop the reference
> before jumping to the invalid label, which still dereferences the
> tunnel:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] l2tp: bump tunnel stats before dropping the session reference
    https://git.kernel.org/netdev/net-next/c/0276fa554ca7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


