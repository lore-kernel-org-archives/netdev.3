Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418230;
	b=ACTb6FffHsSCXKyv3VFNtbpzkg51H5apy1Eevnd9XPI96QtIFAELNfZvyN0uZbrLBPtl
	 +bW+9yf8UKeaH7B99kT4BfEAUNmb27i44x4LHPKuIDOpxrn5HGHM8sxV+yij36ymLzXBN
	 4af0OzlRVlSRWOkWr+AxrIEAFRiHGUoKum+DBQpFSMFTsh3tIWZ5K3rBE37sivAgrQ4p8
	 bM9lTPNlhGApmH2JgqZ/qaKKsLTQIv0TJPuLf96HBkW8ZHJvt2I4rngXaYPU3NJfvlvoY
	 O8/mH3TwLiC+4JfSMxxuGlzArjelK9/XOMQHBtAN0Mf1s+wsXs23bYQzN564hOB3ENg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418230;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=zYxJ//h9TkoTOuTtOzfe+fHJ/lKOA8TAwom5eUId4p4=;
	b=bOFfxFIcgy1Djl1esu6DxQBRRz3qkbzZYeqsYfQ1XEaB8tXPri4nEboreS4HnSoH6zHa
	 O4QXyFUwlQF0aVichgZPB7yy4ZAVfVAmhSC8ioY/Pq2IxeVDpJVLbBpE8wSMGT/EwXIVp
	 1C2KG62K9siTWyMaPtq+TYflYE0rV1q+J/EVWh92p/FglUI/JG63uzkqSfc9TDRGy9pyA
	 lx1sGFcOelgL0spujWtIgFnB1fh/4GyNyU4vQoYqKZhhL5lFRkb1GsfKbLR20CU4gbp6a
	 e6Ud/0DP7NcYENQcqZDEhtETMjDWTIKouarmsUJdlMVSrB/XGcUo3bEC1y5iYvFsWiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4AU5aQe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730A606A324
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4AU5aQe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C16E1F00A06;
	Wed, 11 Nov 2026 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418230;
	bh=zYxJ//h9TkoTOuTtOzfe+fHJ/lKOA8TAwom5eUId4p4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T4AU5aQeVJ/o7kDecIoWTfGHZkKG21oz2F8yYgsDaZlIM/GLCuGLpn8OSS13+mWKS
	 Qbe/Rxfz5h3I34bVjI8kmLBCO5Brc8s41HeN2hb4I0KugfYRi3pOe791Kk9hfrYq4x
	 KTIZrmg7N52mnNEdTZ2l/XeCuUw3FnLNL3iTdt3Z1r6N0383+KRVoQCjcwvPlQTLMP
	 QRQCZ9rKUrIPie7/Ts4j7XBqN3sIYgVqV7KJs7z+f59WKZJAHZYfBITGn4xLyWjLqz
	 cv0RFskwkIYQaMWBh/mfsuz3SHt7t45vR23a9dnRgxue0EcHoxdDUidsLlJoxmrR2K
	 pdoSr83HeF+zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2115738003F4;
	Wed, 11 Nov 2026 17:30:30 +0000 (UTC)
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
Subject: Re: [PATCH iproute2 0/5] netlink receive path hardening
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179441822893.1074932.1529032760166557386.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 17:30:28 +0000
References: <20261109014434.115922-1-stephen@networkplumber.org>
In-Reply-To: <20261109014434.115922-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun,  8 Nov 2026 17:43:57 -0800 you wrote:
> Six scanner reports all landed on the same code, so they are better
> fixed together than one at a time. The time() seeding was parallel
> discovery: Florian reported it on netdev independently of the two
> scanner findings that flagged it.
> 
> The common thread is that iproute2 trusted whatever came back from its
> own socket. The sender went unchecked until after the framing checks,
> and in the ss -D case until after the datagram had been written to the
> dump file. The framing walk assumed every message in a datagram is
> padded. Any process with CAP_NET_ADMIN over the namespace could use
> that to inject events into a monitor, or to keep a dump from ever
> completing.
> 
> [...]

Here is the summary with links:
  - [iproute2,1/5] netlink: use a counter for sequence numbers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=23df79c6c71c
  - [iproute2,2/5] netlink: ignore messages not sent by the kernel
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=29548251e33f
  - [iproute2,3/5] netlink: connect sockets to the kernel
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=31232dbd684f
  - [iproute2,4/5] netlink: handle unpadded last message in receive loops
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=51d90a2d062f
  - [iproute2,5/5] libnetlink: do not read past datagram when recording dump
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=575421242b2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


