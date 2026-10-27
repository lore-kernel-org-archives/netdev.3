Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059208;
	b=HJO+0uGQNbRuE/mNINHcrncVUX+o3p6TecDKrzqHYyxX/T9V3hG+CTB4lRv1Dbr5d5Fa
	 3MnlG5/CxwbjyuNOAxJPuRaax6AJ2Y7tM1FAXpYob8bVYM/aZ//bfwhfHuYY73mjZZY6P
	 xK4NK62leYdx2ci8IIm5pvC4Z3cW6Ks3M/IMTKObbUVCLBCrconpGubBFtPM+jzCDHSmA
	 hCjEa8OA67ShhWuDu0xtblQJHY2hihDw2wnDIfMXh+mT+6OXeA+eQH362YFBOBLpEikVn
	 XcRid+yxkyFka7MS94d4sTbxM92JiftrA2qRLlSnkDSx35tmpDTql7/nwsWFhr7rXiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zm8ylpdcLafJblvCWohl/7MgbUg4kZBMF3/uRyXqqV0=;
	b=FnH2Ezy0Or8LsdUQN7uu/M8VEd7wIpVLP3gU8Lz3moeVCJ7c84mq6HB6aLqa76DREooU
	 bom+RjMZ8gjUZfIUmS9yke8UMxgJa4XJHP5hUw4ddoB0N8UwYZfzZelQ7TkMNjmV/YkYM
	 JBsGeWYIKosljlnYkdvxz5SKE/QnKLN+3qVCFuWyYandGOkjgKMofjwKK+Y6eGk7GyJsX
	 C4hStNYHL4xMVCmK4O8i6MgG4P5NQrHgyX1TqQ9BZACg/X9smURAiGII2fK9n+jN2qde2
	 h0nmG8MCn7dYwhHJ6PkeklqNpefUoFSnTT7iMFqIU1P3TUMXJE4H2eV3bGfgeomPHdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCoQ9BOL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B8606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCoQ9BOL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62131F01828;
	Tue, 27 Oct 2026 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059206;
	bh=zm8ylpdcLafJblvCWohl/7MgbUg4kZBMF3/uRyXqqV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DCoQ9BOLv4ET6bWSw9KXdOTDjAAhZVdGjsbLQptaDcZeazyXxcXz7B+mEUN05vqEr
	 cg3C17gfOdiNHh8BlYawX6UwG5/JenRNEh3KoujViOqSLp2ztDez/wwd6ttzmrusz8
	 bj+luGdcOfryVpvP7IBmYB1r0Mvl82NwRsDWfPmjhTA6xX8MbAO7vDBIu1F25hg6tL
	 6BRsHylMwpNi7tlnMp36RnG3cxmaasvm5LWKcQmMzdZd8yagGUL8SjfvcB38dKiKV7
	 PK653QV21TKiMgBAnV8618yEbJ3tKGG9y2jv64gH2t+SeH0cAvZwxdW9pMTPUjMguP
	 XAkTIyX6au5QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE4B63AA80F1;
	Tue, 27 Oct 2026 00:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] tipc: fix refcount panic in tipc_rcv() when
 receiving
 shared skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305920532.3470272.8792419448364439414.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 00:00:05 +0000
References: <20261023052921.54220-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20261023052921.54220-1-tung.quang.nguyen@est.tech>
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net,
 syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com,
 ngocthang2710.1999@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 12:28:18 +0700 you wrote:
> TIPC assumes that the received skb is not shared with other users.
> However, syzbot reports a bug triggered by receiving a shared skb:
> 
> ...
> RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
> __pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
> skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
> tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
> tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
> tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
> tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
> deliver_ptype_list_skb net/core/dev.c:2533 [inline]
> ...
> 
> [...]

Here is the summary with links:
  - [net,v4] tipc: fix refcount panic in tipc_rcv() when receiving shared skb
    https://git.kernel.org/netdev/net/c/5308a2049b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


