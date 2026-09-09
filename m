Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CC423A85
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985272; cv=none; b=WjXup34X6/1XeRxt6XyTXMFFnfozUWroY5v96bax02Ky7tfQKQ2p39/9EvNGQ/dJFCV2K+n03wZyqBg3tgklM7Xmo38wVyFo+OjoFS/x5QQEnlOJTBboxW4dB6GpxrJ0SMPrkdz83G/ITmIvwNS5aZy+YoNofOhRAE091Awb5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985272; c=relaxed/simple;
	bh=zwB2ci1jeMsU+iZmcN40yuP4BEt29APrIG8Xaq5IJf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ny6UzHVwPyFwt5TjSgMbUOBlIuEwiXvVUKvHUhtZ0L4HqjruekyjnwgZLiffqMH9UeMmZ9Q679+COfqHKwImmv3iaac5/cuLl5mAvWcae2WNyK5osFcgHixKeVFaJTgWGprVRDmAuLMscJUhMldbzdiK8DM8JrHjm79veFSsSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl6PUa+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl6PUa+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A699A1F000FF;
	Wed,  9 Sep 2026 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985266;
	bh=BCkhr6vYKwVdjZkP5eZqr7piTQ78ISL15a5vvvvuJZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cl6PUa+GuTJDxPc1gNVK4pn6IDLsl3oQZMI7ue492ceRU/mWTtyjYoczXVRGTZU8t
	 ik6gCBkt69HlH1PkpbnSUpkByTaOVF16Ej6kLOzn9sMMbxtf+Vk2jQZskcTx7J98mH
	 WuH+do/K4QD1kM0UKkB9GE8O5vwPnqNTqMHYkKn5PtHqlzcp2nObDWD/mZ/E5CQeNt
	 TpUkFdNiapH4uMUF9aUq8wd+924UxH6yZ7GBcCUzd3l6WNie0/yr7HQgO+vaZq10WJ
	 ofCwJ/2npxMSKXc3sx/JztNwdKRr/60n47wxsLJfru2PKtGoSQJWPtAnBPOGAPnw52
	 fL0hrCuN+bZAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AC3380AA77;
	Wed,  9 Sep 2026 20:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: net: csum: filter packets by
 source
 address and port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898520464.1039792.426967472358673901.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 20:20:04 +0000
References: <20260908155537.813889-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260908155537.813889-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 11:54:29 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Add source address and port verification in recv_verify_packet_* and
> recv_udp: non-matching packets are skipped.
> 
> The receiver reads from PF_PACKET and UDP sockets to verify incoming
> packets to test hardware checksum offload. It did not validate the
> packet source address or source port.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: net: csum: filter packets by source address and port
    https://git.kernel.org/netdev/net-next/c/8342c68435dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


