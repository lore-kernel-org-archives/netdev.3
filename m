Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059807;
	b=tjU4fIP7Ib+0fOJI5aRXNB8kfClkk+t30/i3aEOfGPbXYHOUvofPFFYpIx1D5MvoK72A
	 c1+MAdA+2Vk+aTB0vv5vkW2VJrGxngqo5biFrG+s+P0gzNik04xi4zcLQViHob9TQ3rcM
	 SYQnzwg2FWi3Fb0oIPeQsVDu5RxwQp+fX0NyO8++5HFCiA/tJGGJ41MsJ95EU7geK4w0I
	 80gR8CO85QF3keaS3rIASXcQvo1oBvA5sVC7Vn23xX+BRj5u8hyFUumxcqPno6ODqccVC
	 pPToYDpXsgLshPzb15OUL6a7v9AjJRh1FU7TWUTbzga/2pYJ4XsJl/HJWB7ntt3IaXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6wr5OplgaTCmPsnxGn9xJWW8dX6APwERj0LVWwgQejQ=;
	b=EoeMss0kA8ruirOTxA+3Y+jlnGLIt6PEehVTKiA2fVShaWtUnesC3Ilm0XA6tgBO+LZQ
	 nzXkT79FcPZmhfXYLiFyMlBwla9LvaRrQE6Vyez5itBsPyEWU32J7GaqHNq7qr3msLxuh
	 mVwXfozc6w5CUJno+rl6hUDRIzhkFxrgXUBJU47OMQ79Y+rcQ+Nxb15lCdfdJkU8IoX+u
	 oAZLhXFEkaAb6hK7gbiTM4qqP1bKNrfJbUdgIQmB7M0YiX/B/5cWx1EZvo2olwpzT16JQ
	 Ww+MvQw+qvZpACYeKW/J2H3JaYlD1utz8/BcJByVcAHOlUW3J8cWNLV5Qk2l7pB9lRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGhCuqfP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865C606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGhCuqfP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91201F01828;
	Tue, 27 Oct 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059806;
	bh=6wr5OplgaTCmPsnxGn9xJWW8dX6APwERj0LVWwgQejQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HGhCuqfPoQCzDBZbZ7OZGwR1VPhlyqb7mP1gCMIBVVC3/TRrcPDyMLqdOjuDkqny5
	 xjj6yMXfrq0lXaQNDwacdt37kBOVtgWwH62vNlBP7eSJAXkex0grm+KPkF0jz7aFon
	 TXGJIYSmy5b9KMsVqQdn1airWBg/N7R4UndF0AaN7BdNnrWw3hMIkG+5pARs9fAt61
	 OvNkxcfVvfmwLtu7CHHTq3NP/R8wijZnzV2w1pcWOEY2qWzkIW/zRvmkmb78GO80fP
	 MwtXPr88dqjAaqHQnQJYpesuvCKjdXnwNjEsM1uCC+nv90HRQz5jzfxLoK/b0Dy8oR
	 Au/EtIppGiOug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE6773AA80F1;
	Tue, 27 Oct 2026 00:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net] gtp: hold RCU in gtp_genl_send_echo_req()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305980557.3474387.10359987067161813120.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 00:10:05 +0000
References: 
 <ed27d133fe73afd377d3fa4e553c34e7987b6dd9.1792744478.git.pabeni@redhat.com>
In-Reply-To: 
 <ed27d133fe73afd377d3fa4e553c34e7987b6dd9.1792744478.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, pablo@netfilter.org, laforge@gnumonks.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, wojciech.drewek@intel.com, anthony.l.nguyen@intel.com,
 osmocom-net-gprs@lists.osmocom.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 10:44:09 +0200 you wrote:
> Such function is invoked in process context, performs an RCU device
> lookup and dereference the found device with no additional protection.
> 
>   =============================
>   WARNING: suspicious RCU usage
>   7.3.0-virtme #7 Not tainted
> 
> [...]

Here is the summary with links:
  - [net] gtp: hold RCU in gtp_genl_send_echo_req()
    https://git.kernel.org/netdev/net/c/a204e9c001df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


