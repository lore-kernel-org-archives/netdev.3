Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290812;
	b=WIRICQSitf+50esVzdvr8tdOGLId9nvew8O5KjZJvlXioYZqoi3+W9L93pqX3vsuyOT3
	 tITvypUf8YkFphxLnaHfF3OlWYbdAb5OJYHfrb3jmeueCpKhxq7hZ82q+62+HddwPrqE1
	 fgz6ksuSNjcOmj3lFkAjOT+4qp8hAVZo/90HH0GeZdE5NES0Jx+tav7mRDn69F5lFExUA
	 lRZrfUUCuHcBY59JAx0uSpFNn7LrJhJZ33yRPTNWOZB+w4fMthhMM5DE+JfuJ/FN6Mdwb
	 oxzSNvBoIOoEBJRFl0eL9+YpJpn+Pn+zddfuWm2y3GlSVQbnJ+JDRk3gYoirH3eiGjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290812;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gx9e654A3UYxuJoiYjlz9SGwq2R+qNxHkw62mntxnnY=;
	b=AvPDPcUdeNGRc21t/ANE/0QCIW7jp9NejLb6Rp8GNFdMaHTN0H0qI1lTuptdCrFoN/uy
	 nQMnOuW8wY6JkQl0Tj+7XZtXmCVFIUlDqoNc9qKfBoI1DPRtOLGdru9zxhA4oZtlhtIMP
	 pk+h3VAeh5LbDBs105W+S7dBniTHfI3D/QJr/IrqiTrni0St5+CFpDCcWBm0r9Wz52uL4
	 XCRKjjK0iYdhzPtNQy3OBO3JqjF7ikfks2sp+F91vMwntRWX53o2KsxhazoMRYW17Yvqw
	 fOx0qsXQxgriQxYVTUWKbwGR5mlgyo7sayt/gZILiUi7mMw4Zej6x+P60oaw3Ydia8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZOT+kpJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CD606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZOT+kpJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C411C1F01816;
	Thu, 29 Oct 2026 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290811;
	bh=gx9e654A3UYxuJoiYjlz9SGwq2R+qNxHkw62mntxnnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jZOT+kpJMW74DJ4b1oe2UkIDxESUtmEOCmgGMBPPzGaVNsE5qYbS8RGUzx9+llV5R
	 /GoWd9FgKwmLACpeqJdG70zvyxuH/3yDBcHJKxE8Bf1pU2k/MQIxO2+DG1oKHcpl0E
	 Srp2D97/SR2c2guY2tzzWzw4Hv9+iIQx696rAEMFoU9yvItBxFlHqhLBxPKDZTTeu7
	 lCt1QxKu9PoIT6Svliphi1TVuHRZJAqi/4yvAL6YAnphls1FGdLYrpdduxULJzYsCx
	 DKM0skBa08LGIqha4B15mOh22uneMlSJj+j9BLBtOF6xErvwa6OHkSE7VwgJwkInN3
	 cuUKdFf3sLHtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2C53808221;
	Thu, 29 Oct 2026 16:20:11 +0000 (UTC)
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
Subject: Re: [PATCH net] tcp: avoid double destroy in tcp_abort() of an
 unaccepted
 child
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329081029.553408.14907389537067480114.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:20:10 +0000
References: <20261028160847.2170959-1-edumazet@kernel.org>
In-Reply-To: <20261028160847.2170959-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, ncardwell@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 17:08:47 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> tcp_abort() checks for TCP_CLOSE while only owning the socket lock,
> then grabs the BH lock before calling tcp_done_with_error().
> 
> For a child still sitting in a listener accept queue (which can be
> reached via SOCK_DESTROY or bpf_sock_destroy()), inet_csk_listen_stop()
> can run in this window: it only holds the child BH lock, and calls
> inet_child_forget(), which disconnects, orphans and destroys the child.
> 
> [...]

Here is the summary with links:
  - [net] tcp: avoid double destroy in tcp_abort() of an unaccepted child
    https://git.kernel.org/netdev/net/c/dbd62ad55a4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


