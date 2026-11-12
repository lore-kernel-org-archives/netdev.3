Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511213;
	b=wfoKxVzLdtsXghf+tdfVoSgs2WL95mpBa5a3PxHuL0EFOZdxHFFDgObA2k5BLMOrt9NI
	 Ycfd+FBzQ6r3BlPapMzCdtTacM1WMDyV1wMWVhK+RI2LSw+xgvYX7Bvyua0RqIuQiS36Y
	 yzbeO217QSSmyled+ZB2AHi7kbqkxZnybmyHpqLF8sTeULCno3TOxSmtn7Ywqmrv1MIEv
	 ZoUMMtu5ubPxdLgm6P4mFf4Z79OETCuyaubA0ysDyISVpgdupeAT8Np7mfppqmwg6fcBU
	 gVd/nR/3IeglETkis9E0IW5yYSezM+GQ+Yn2+ah9AqkDx06s0AEJadZ5KjCHlzRZouw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6m0jb+42bLB8LuKMpGgRNsw9nHlOHHRHCPu/r8lmSNo=;
	b=2YKa7dWH+z0RYRfedQFi2eRsQpqnKYwxT23rdRMXtIgWdMDLxSGxlJZR7nxNBGSdr6XE
	 w1cKX2EhFEmpVzqW7JIkHL1z94DHJYakPqeGBcXgdsMfy8OQNb9jll08YojZA/UuCwYRD
	 aFL46aNSPuCWyRb8RXbcjGm1VDUdjiXpQzZMU+tcSoaGsHwJbkpNNvQ/KsuHCioRbXSr8
	 X+J+GhTufxrfCPrkInBWo/M/U7QsY2n50FsCHsUwbIgFIwZ7rrRfgucGbeK0vPQV9A8LG
	 PuDv0Q8lneQGSQEiuUuU1r2XHc4axoSx0pB0bDNOvzLgMwyWfOtlcMbv+nWh4C3MfiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaiuZyvc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF9606A33D;
	Thu, 12 Nov 2026 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaiuZyvc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085091F000C4;
	Thu, 12 Nov 2026 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511213;
	bh=6m0jb+42bLB8LuKMpGgRNsw9nHlOHHRHCPu/r8lmSNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kaiuZyvcCIolncEDEueqVuLsyDvf+OkQRQFmNQkiDPMH9BEnfxvyvJkFmG1/OVFJu
	 ER/V7FqY+ViZcr+3y7G3ugGYgVke+oG9yeaVS+zjspfJujw+wtvuEPE4wuTCNujJQF
	 Gdv4gR4gEDB5ugco1G8matkSn9721H5gei3q3D3w/Hb6lpCP+6oL7yvcPvd5V8hLeK
	 SuK0JbiWATcFPGQnZlwzce984Ol0gPfoPLdb3GmwC2d/p2C7yT32xllGHkMcg5q2F/
	 86dH8veqZACgpDzypS+6QayLHrZOeL9XS1OdfbZXI8qIhjuHjF3z+iaUJqwrfqlGzz
	 C0JC6nqTtf9MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16EB392624F;
	Thu, 12 Nov 2026 19:20:12 +0000 (UTC)
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
Subject: Re: [PATCH net] ppp: restore uncompressed fallback during CCP
 negotiation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451121152.604801.16504171266860549530.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:20:11 +0000
References: <20261111155112.149204-1-qingfang.deng@linux.dev>
In-Reply-To: <20261111155112.149204-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, leitao@debian.org,
 tristan@talencesecurity.com, hataegu0826@gmail.com, norbert@doyensec.com,
 Brice.Goglin@ens-lyon.org, akpm@osdl.org, Matt_Domsch@dell.com,
 paulus@ozlabs.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev-bot+sashiko@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 23:51:11 +0800 you wrote:
> ppp_ccp_peek() enables SC_COMP_RUN when sending a CCP Configure-Ack,
> before userspace sets SC_CCP_UP. Data traffic during this window can
> reach pad_compress_skb() while CCP is still negotiating. If compression
> succeeds, len is positive, but the SC_CCP_UP check fails and the packet
> falls through to the error path instead of being sent uncompressed.
> 
> Deflate and BSD-Compress have already advanced their compression state
> by then. Dropping the packet can desynchronize with the peer's state,
> causing decompression errors.
> 
> [...]

Here is the summary with links:
  - [net] ppp: restore uncompressed fallback during CCP negotiation
    https://git.kernel.org/netdev/net-next/c/f03ef07adfae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


