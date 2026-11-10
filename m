Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279290;
	b=vQQMPj58P5gNJUMN7IXYy20hRsI1qMKjGFXxQ4L31W2s2RbfuYKyD3njG+E1UzYVOIeG
	 oAaMBxcavaavVoi5HmUvATyvrcWrzuxNm5BcnB7qfJm2QDL7zFnhuvPzuQYSpLtEjaNuu
	 eP0kceOunhppOT/qBrTyDIdGKqt34PKKjVsosQC/5rmNL7f86WjilxAH1Aw24rW1HaPDa
	 gyT2tmvTxRZAUUzPMFL1BJqavjIboC2uO+mIjodknOon89ryA9XNmSxuADViAkWUZBw0O
	 g3oSPIqv64ixXFBiNRV5Mn05IMfAYc8/cAxlaKX/F2HOhLa8Yjv+W7SQwDC33slwcAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279290;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2bJUW4l49sLKtxAo1NUnTsY3j2u1ukhxvsoHbWHGuK4=;
	b=qO76Vyy8SCtjz9ma4eWY4T1Aya/f2vdebvnYIAtUdbh1jrEbJsJYM4JuQl0khrY4FHGm
	 gp0NnbW/jfmb9B3pdJyqS+VNwol6f/sx3npRkmgoaV/V46XWpJr2/P9BwRBUydkuqO54q
	 xfNxdRrKXVJpZwJYRw94JRAaGlxa5Z6EMI2rwi/7/DlnCDpme5oSVUW2Q5TByp52Dk2Bs
	 ocfN7JRi42WPoEar/6m0x10YjfKZxctyGQfTX+xq9CaTb/0rHJ9Qi3wQ4fJUAFbiiqmM7
	 2G/4rmrC6jcNQvwW6CetuNDS7pNiKtLDWLvwg676TxSeQJmYCzeIq4T2KJX13Jrs+DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njvlZ5og;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE6E60A381A
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=njvlZ5og
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50001F008A4;
	Tue, 10 Nov 2026 02:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279289;
	bh=2bJUW4l49sLKtxAo1NUnTsY3j2u1ukhxvsoHbWHGuK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=njvlZ5ogTHGuB5bmVWn3+R+Ysc9JAl0WGpi9L6yUwji0cmSH4Y6ZCIbcDupesv4jx
	 0JEKebzoUErZLLnb81A3qq1Kfw62EXBZvlxl0DdzWHHacPDHjQZCI1oHiFsp36p/9q
	 xiDhFeoUOozmNemMoE6KYmriDAzAjQjvioNv4681KXdbNdP7jYbytWcCF5GIh83pb2
	 hblZ09B3NdszXlyegt6j2dY1pzcenR7MIshgM2PploDyWWOMBy4cVFFTE6zi9udSL4
	 /LQKk5fFeGzYOBiD2Y5ePn+hAg/mMruUh6NCcUgeAt14KzdDdxbFnOoySlfGx3F8+z
	 eqHkDdYqd35gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B02B391AFCB;
	Tue, 10 Nov 2026 02:54:49 +0000 (UTC)
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
Subject: Re: [PATCH net] net: protect negative destination advice with RCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928817.3612825.14867042478896560539.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:48 +0000
References: <20261104131744.1056562-1-edumazet@kernel.org>
In-Reply-To: <20261104131744.1056562-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, willemb@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 14:17:44 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> SO_CNX_ADVICE calls __dst_negative_advice() while holding the socket
> lock. Connected UDP sends can still invalidate or replace sk_dst_cache
> without that lock. A concurrent sk_dst_check() can drop the final
> destination reference and allow an RCU callback to destroy it while
> __dst_negative_advice() retains only a borrowed pointer. This can cause
> a use-after-free while accessing dst->ops or running the negative_advice
> callback.
> 
> [...]

Here is the summary with links:
  - [net] net: protect negative destination advice with RCU
    https://git.kernel.org/netdev/net/c/4b77d2792c3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


