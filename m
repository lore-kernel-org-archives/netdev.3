Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388805;
	b=dk7RccekJa7mOOLi9Xqdv+0N42rCShBilQ10P/LcdaG5G2qBr5zGGhsgB9bBQfT7YLXJ
	 aLM5xJpjGIRUJZUnLXzzGCB6GhK/o1Y9wKjLR/Th2OEM88humsoLEcVV+jhBlhqg54rMB
	 dtZc0XpOnvXwod2e9HqKLO3kL4VhSIZll1pC7Anmf1fSK+wczFk+w5/NIw3NI0RKq3Jjx
	 CwDReS98KltNNyNwr/XiVlN+e++mhep82+Um2qdv6a/kQ7w23cSZ1U08FvKp2Fo2A9gjq
	 JrVHjPf5QWfyw1ejgi+vj8PMHs+joFgiHwDzJYib9Ev7LU7j16Oh8ZeCOF5g2vsW++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388805;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JSXD+Gnog5ZZQIgrbdkm3vJ1FDAWBa1N9ebDHfaThpU=;
	b=Ia1OBCWtJriwshQe8JVYtAfgcriNZXTDQGpLqrIDoqsC+x5Y1Rgu2FWyaTh5s1Qex+Pf
	 aBIu3HLT6O5Qt8n2zRv50BOn/S2yPIexP7InHKnsrU3YbBdV3Vp+zk/7tDn+ZoF5E9aJM
	 LSfuNxWAQ1pZE/pGE6nnntrkudCAeOdZieQ+RjhsrQd6jNxP7/Z+QO3mdzIJpB9MqftJM
	 FDnMbII6QgZkllrj3XW+wDQMhbKyS6rdfwTo2tfUxDnGJx8GKJZDEE5yXQyM5x6/vJuGx
	 GyvtVntT78q9ZIzLrTncXD10CTl6MpJyGCoe/VEMLTMd+O8gbgegKA+u3flv79neXjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPGShUiB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E3606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPGShUiB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668A81F00A05;
	Wed, 11 Nov 2026 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388805;
	bh=JSXD+Gnog5ZZQIgrbdkm3vJ1FDAWBa1N9ebDHfaThpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oPGShUiBX1pXaO2vH1Z5L/uIEi7dpQ53JJ3Kh8rksmyGLixx4g+wrPSAV5Ld4E6rO
	 /4DWn/LsN9IXtu9WEFggX1b4kI+MqWT07Im+ay4MaW5UVcbDnsUUSvwL05PKCyep7v
	 jIkWiOLPJlceHoHx4Z1aVqnIRWBQpcp/sjxgGX54+35MBFSonyWU0HpOFwdwyNHrHq
	 ZDW1Qy2hIYhSFGp6ZPcQcuNOaQq+m+1VbdeoeTDL3hSiEhBTzFXSdupk3DIYu7yI0s
	 Ao1i5RUv6qaNbdfDQMAnRfW8o2AxkRWtEulI6V7X2611/nxxX4UE8bQ6d10n3gONTa
	 j6v8LNtDe6w0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E32138007E9;
	Wed, 11 Nov 2026 09:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net] udp: check frag_list IP family before using
 skb_segment_list()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179438880431.814450.7452118974410716503.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 09:20:04 +0000
References: <20261106141727.2303218-1-edumazet@kernel.org>
In-Reply-To: <20261106141727.2303218-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org,
 kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri,  6 Nov 2026 15:17:27 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> UDP fraglist GRO uses SKB_GSO_UDP_L4 for both IPv4 and IPv6.
> 
> __udp_gso_segment() reuses the frag_list skbs when the geometry of
> the head skb was not modified. skb_segment_list() keeps the network
> header of each frag_list skb as it was at GRO time and only adjusts
> the transport header offset.
> 
> [...]

Here is the summary with links:
  - [net] udp: check frag_list IP family before using skb_segment_list()
    https://git.kernel.org/netdev/net/c/22b7cb932c6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


