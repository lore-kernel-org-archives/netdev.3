Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321011;
	b=Zp1S3jNLQajrwQgV9MTYNb7tfLUqstFKpRqIIQXw9PfY/0G695S/B/1gA5Ff1x48699o
	 T60MEMM4uFXGagX/xFkUlTaVtpNStlk10FqfgCeUJu6MfgvrdcFBSxkDN6DwYrNlGxZYC
	 2kg/x+Mh/Qllx8CNvLXRIwcgCzvVNCcmewj+Wrv2AadSbcWbKJDCE5bReIk/CSxd7Nfvp
	 O45rce6d+aPuohNPJeEoVSgPkSBYfnTbECQFQARPr0z1klzMKInhqjogWGys+IYRR/5/0
	 6Kfs6gEwVlrbD+jOyg6CpfFh5+nOmjjwmSrQQWe0t4rwqySA9l8FQLwM9Yqy2d6SbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=8FshiCFSAx/XUt9B7VmHTjgXNdsSNmtFZ8/eEUUTfnE=;
	b=09yutzbl8UuGU1L7dzjgUgdeb+LqJ6npohC53NZWZgA4TVYLXSCTyF0g1X2XKv0bZ4bR
	 +4Aj9oaXdgcGmfNJcHDt/IouvMqZO8ZX84QJ5xioNA/VdMqlT1CFb+eZW48Xwn9Mp8/vz
	 aLctv2GLYP1B3HBrtz2cI6jiCUdnKcFjK0PfK9sPn0ZKU298CXUva4apHRyh1Oj411e53
	 757ePz3I8fmONqI8M8YwoT7GyiS9Xw4mKrB9rmEva39cFQ/3Gp2ndSNltq1AR0kJGqD2j
	 kqlNoHt1znW8+1VAANt7B+2Lzf9m2ihzw1dFFZVlae5nvCR8RNs4ApGGLJ44HEtJQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPkkfwI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192CE606A330;
	Tue, 10 Nov 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPkkfwI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23631F0089F;
	Tue, 10 Nov 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321010;
	bh=8FshiCFSAx/XUt9B7VmHTjgXNdsSNmtFZ8/eEUUTfnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HPkkfwI7nretK/FFutLyDHNca//Bh/QglB+OsFjmsjUa0Y0Eu8CuZKrralE0P7ooe
	 WTh1xwjb1MRXkd5jMZlum4nYPsn3azsqxwRR9cxq49+4e8Jw1VG+GGpXpN9YD0n7BN
	 yPeeuWJyMcyTPpM8p+g+dMf+j1OfLa+vr54fUTkM++EgWzgUF+4Euq6awSXw+fA4nY
	 9BubMA/dm7ZPOKWUHBh4VT9aIOqL7/qTqlsCnNXRJc5Vgb1gwP9vK9ZE7UcrtZejIL
	 X5xZTGu14x89/WzQeaTWIvFH7OgBfKFlXZh9vER0qkoXPGc1Kweg02lMdjytTVLG3J
	 w9f6LsmU8YXFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D81F139D0CA0;
	Tue, 10 Nov 2026 14:30:10 +0000 (UTC)
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
Subject: Re: [PATCH v2] net: wwan: iosm: drop redundant skb->data check in MUX
 DL
 decode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179432100942.3999302.10401530919113980212.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 14:30:09 +0000
References: <20261103145925.69981-1-fangxy@xiaopeng.com>
In-Reply-To: <20261103145925.69981-1-fangxy@xiaopeng.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, johannes@sipsolutions.net, zhugl3@xiaopeng.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 22:59:25 +0800 you wrote:
> The skb passed to ipc_mux_dl_decode() through the current RX path
> always has a valid data pointer.
> 
> The only caller, ipc_imem_dl_skb_process(), checks for a NULL skb
> before calling ipc_mux_dl_decode(). The skb is allocated through
> ipc_pcie_alloc_skb() -> ipc_pcie_alloc_local_skb() ->
> __netdev_alloc_skb(), which provides a valid data buffer on
> successful allocation. Allocation or DMA mapping failures return
> a NULL skb instead.
> 
> [...]

Here is the summary with links:
  - [v2] net: wwan: iosm: drop redundant skb->data check in MUX DL decode
    https://git.kernel.org/netdev/net-next/c/66974df65a0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


