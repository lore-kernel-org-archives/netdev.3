Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548007;
	b=B4aSsiNPnmXba2PvGdZInZQ+YWHyfoaEdjUUzwjhDANlvw6eJTyVBAW3/XPVV/L0neNc
	 6zYBAYEL7BIwfoJVRwT/2QuAGHxgnNloaqVVDw5p2W3qcSYl01qiPdxdjFUP9RPKny1r/
	 /1g3RAVMrf59UuvpAyLkn1olDb2jWeDVpSJodeL8ZYtm7tnO7cKDeuH00hskagrxDZr+H
	 2ap87Q2VHd13pM6Y94HhnPWTG1u67b6gD2hOLEUAnB+TyDaTbPzsBIa1X/pHD8hkQ41an
	 3DMRK5bdFbydROo9aM6mpdoZNeBPtZ0zz8vsOTUCiA3NCCzRoRsnsOVoidHzE9zGvJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0ezzVwOu0VoLVNOGHWkV3BBAKPLq8fzvzE339WEj3Q8=;
	b=CetDL2+2Bpb4VS1svLONcpf0mtdkQIndR7+nGGL5mVesDniIKiGOQ5aGNVYCGRtgS/2g
	 zG6KxlvSFxNLfKt3bTffLALUNgwCBcdLsDVmfFZ1pqEUTXgXYMl64LzS8xPPil+LTRsSz
	 3KMswtLyCRDuC4o5LfdEaZ+j/jewWJdBuMSaOJMtAaf05TnkkqCs7WRgZqc7tHpJgYde8
	 uWMbr2Xm3PqvlCg9YxjmCRcWqW+10pwQkDw1znG2tXIn0VLQwVFLsGFEbr9SktFPSk2Iz
	 mq+I1ONzGmBcSegsKvOsjNCIqXmd+vnSvWdI0gfsSKOGlSXkmk0jRCTDe9mTHc5HnYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AD4TBv6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0565606A31C;
	Wed, 21 Oct 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AD4TBv6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4745F1F000CA;
	Wed, 21 Oct 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548006;
	bh=0ezzVwOu0VoLVNOGHWkV3BBAKPLq8fzvzE339WEj3Q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AD4TBv6gzNVxhKE6serzLOd8oRNgmXsYn+B+hDwWYixGF+S7uo1YKCrnr9srM0mrs
	 VXd6VTtNL3Ck9JMoTeju2Ev4uVPsaA2ySHYEJSIu8Ni+5M09GxMl4zbouMPOQl37Rt
	 lY+TNCin3/XfqJhWlXV5vERC27EYywYryE6vUHUe9qsZLkboFgUZTnvAdKHZLA01bp
	 MUXqwdmDV7Q1WyENvgLflH1ZeZw0ySMKKLHR29MDT83g1uKlox4t8sQahTXnvFP7qr
	 TqnCX/DhkwTy4fSsrN/U0uqxDBZYDonvNRKGi49eMtclTU/Kh8xzEUp08PkDQbZqQh
	 8FbrX7Klxf0BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2B03809A0D;
	Wed, 21 Oct 2026 02:00:06 +0000 (UTC)
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
Subject: Re: [PATCH v3 net] net: skbuff: don't copy alloc_cpu in skb header
 copies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254800503.322903.6077235155996750199.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:00:05 +0000
References: <20261019174152.2932829-1-cjubran@nvidia.com>
In-Reply-To: <20261019174152.2932829-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 kuniyu@google.com, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dtatulea@nvidia.com, bjorn@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 20:41:52 +0300 you wrote:
> Commit 68822bdf76f1 ("net: generalize skb freeing deferral to
> per-cpu lists") added alloc_cpu to struct sk_buff and placed it in the
> headers group copied by __copy_skb_header().
> 
> This is wrong for newly allocated skbs. For example, skb_segment()
> allocates a new skb and records the current CPU in alloc_cpu, but
> __copy_skb_header() overwrites it with the value from the original skb.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: skbuff: don't copy alloc_cpu in skb header copies
    https://git.kernel.org/netdev/net/c/78d4bd22ec9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


