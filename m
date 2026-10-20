Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522819;
	b=zqbF7b138x+rhsbDzIqmPVVhrjKcJMWAcpzt3MX8gZdX9aTbxGUd/fpvCluHbK6oEnsf
	 0LrIuMMqb4fqf9PoTZbog4nJzMmo0NPa2AQrH71V49pjmU+SAmfp7Zzt12VcQXfEPXoa/
	 4wS48+UM4r91HU37hE13wB+Z9Jrifr3J0L8xYPM99uTE93q6hHR/FHiT+iU6qzZbJVyTs
	 4WT9g6px/P5Kzh2/mG4ZAwTEk70kKIgTFJINSP7x5O2EKCAo8Lnzq7xgbijQAA1Ku85Sc
	 ptGTqkvRS4SYCRpMI4vRG042/UYK/LeOBH/kaiQ63FnneQxf5rQxKTWGIuh+y18H7Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522819;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yy2a0wWxK67WUze20CjtV96ogmtIDQsm4F5crp0cZIQ=;
	b=JUlqCERFEsfE+rh6xpUePSAZtmD9wG+UP5VPwOlN6rQCLDPG6qo8dqOwZv39cxLiMbpg
	 jDNmMFg/n7I+64pCTfqYN6k553yaGz+Q6P+1sPNW7YH1xzMr54VsapbqaRawZn+magpn+
	 Ai/CBl3insX2p3v4+cN3MXsV5/3MpqCK1mF9JMh+xknjxUrNfb0d9RjEauACRHpNNttpG
	 g0z4vhiTzFV5JOccfyb4Ac+eXkFMkd9+vcvOJGbePS8UCRdYakO8avl7tqz4pevFXl7ft
	 A68pifUXTDW0e8/hqTiTbqJ++rn+FLHS+WARCku4a6rqOnTmQZKCBXLwrlevolAswkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgzWdJgq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D475606A328;
	Tue, 20 Oct 2026 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgzWdJgq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EBC1F000D0;
	Tue, 20 Oct 2026 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522819;
	bh=yy2a0wWxK67WUze20CjtV96ogmtIDQsm4F5crp0cZIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TgzWdJgq4kq+DxLpe0hmyuWoCSedEteiL2anRfrDp1Vw8gB33p94K21dsAOsUTNea
	 yecoZiEpQfnCYdIVtS/LnQcAU0sf2Pl3v1VUHiPiqonviOdY8KrkKaps+5IAXDBYJo
	 W/f9CAugqyPvhsXt8Uu3PYAMhR+xT7B5dn8nfuOc4bUboU6JLZ+q9o4zWIY6qndBxV
	 5hoSkivRQmyj4i1KKjYRZzu2hJNR+jz+C3YRwuKQ7594WtngHxvcdTYHE+BVHMsVA9
	 29IdCNKpKyPpOvb2NYQZ1jqfNS9OQYa3HWEf40bJQqA0z4226DZk3P4fMYCYHr5hCe
	 ZzEFG+9x9wMSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3873808209;
	Tue, 20 Oct 2026 19:00:19 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: Fix dma_unmap_single()
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281778.159319.2896252453326387708.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:17 +0000
References: <20261015140110.41988-2-fourier.thomas@gmail.com>
In-Reply-To: <20261015140110.41988-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sujuan.chen@mediatek.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 16:01:09 +0200 you wrote:
> In mtk_wed_wo_queue_refill(), the entry->buf is DMA mapped with length
> q->buf_size which saved in entry->len. However, in mtk_wed_wo_dequeue(),
> the same buffer is DMA unmapped with length buf_len which is set to
> SKB_WITH_OVERHEAD(q->buf_size).
> 
> Change the size to q->buf_size.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: Fix dma_unmap_single() size
    https://git.kernel.org/netdev/net-next/c/ff5a2a7acec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


