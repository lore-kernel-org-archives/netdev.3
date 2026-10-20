Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528806;
	b=2BzpptSH7s8I8jZ77/fQ836JXilFQzmQFiN1dy+cDKWJsHL2BCDExh3dRLVvg1lLYE/B
	 5MHb6txwFfKFRxUKdjjCWcwdp1o93kyKevQBfFD4d+ZwGesqC2U/LfTSS70Km8wcyz1gS
	 t4lREQdG5BkNV3xLOcz2eohz9Or/Gu73Rbo19AXacq0tBB7Bx700D7EwdVAGGI9E8PaM2
	 PMWdG5z12MGxj8XHe2WXxSVJu/ea+DjGSR0Ye74dzvARYB1kQZ6hLUzVIP/s8jTm9zVIQ
	 K4c+xz1nX/3gqyEhgsF0ojby+Ta0+OJdJLgGeND6o0xX5ld7kDPoBbvsOYHB5SalIDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=flulyxbLP0UsSv1OFvs0YSLFEceTAtZ9GIeNv73cBYA=;
	b=QTHOz0DJPrUtZ07++k9BNHLYkLVZzRHArX+0rERi7GYKcukZ8rL8O/FBgCrgSLY+a3cx
	 eS+e72vqnIAybM9WPQOCaQVHKRre1Fg+lDI2UKvX7WMk7IA1EjSt9n66t2qerK8o5Ck1b
	 t9JQeTwvXEMKOmbtC8uVoIIG0ZHV+7KYHspTBNl7K2IoqkMrgvGl+2zrkNgWvfXeUdSFF
	 /S/BSSKYB6+UdGxgKBtoTN9lAuSyPmgNE7v2X8SabGuqmrm5vm0dCCX4BYhNQ+etCrdj5
	 4oruFoqhOsEVYHo0NSWsm2cN6rliqAJai9x2BDqVK1rgF7uIFT7Y2W2lSTI56QK2pWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+HoHJLm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A3606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P+HoHJLm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824171F000C9;
	Tue, 20 Oct 2026 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528805;
	bh=flulyxbLP0UsSv1OFvs0YSLFEceTAtZ9GIeNv73cBYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P+HoHJLmeGv690Je7Hm/2xUTHlXRjsNir2NbRq77s+29AnYZDk49MsIRZrQPGAb1k
	 +GMazyn/Y77d0JM+LN+iUB/hMOunzUL2wrFwxHQRvKsFCWg+nt/0vS/G5rXnaawyD/
	 sEUiM/4opCxtN1YuZbzfqsCZB2D1O40tULXXVUviTBp8/R5q7xZr3yqdqu4eF1FSRz
	 DSNQsIZyKDTA8k7hieVDzSqoV4wSBeB/kjxRtaLkusl0nbXhvSjFGIxVojbcSV77hs
	 GAkzmZ93Q176RIVfenaBjiH6VjpBf7D2ToLV19uMvToXN6BqLFV0D8IIj+ZJ4shWgO
	 QegeUvHi50v9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774063809A09;
	Tue, 20 Oct 2026 20:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net: devmem: allow peer-to-peer dma-buf
 attach
 for bindings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252880430.198184.9183453318719653530.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:40:04 +0000
References: <20261013210954.2170175-1-erfansh@meta.com>
In-Reply-To: <20261013210954.2170175-1-erfansh@meta.com>
To: Erfan Sharafzadeh <erfansh@meta.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com,
 sdf@fomichev.me, bobbyeshleman@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 14:09:54 -0700 you wrote:
> net_devmem_bind_dmabuf() uses dma_buf_attach(), a static attachment
> with peer2peer false. Exporters must then keep the buffer reachable
> without P2P; amdgpu does so by placing it in GTT (system memory), so a
> device memory binding silently ends up in host memory.
> 
> Use dma_buf_dynamic_attach() with allow_peer2peer set, so an exporter
> that can do P2P to the device keeps the buffer in device memory.
> Dynamic attachments are not pinned on map, and devmem cannot handle the
> buffer moving, so:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: devmem: allow peer-to-peer dma-buf attach for bindings
    https://git.kernel.org/netdev/net-next/c/69ab87acc614

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


