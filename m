Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522815;
	b=eJ2U/gJv/pUBVJRAMrHttzpxKSV9qAsWbLdMITHqZoAjw/T+3f7Nl2ua7Of6egNA7GuZ
	 /TaGNA4WXLFMERd1krvGO6IuwSjbqVAUO0YJGcJF+rHI7jRBgPJmrBnZlT9gL6VuWFdER
	 9kL3bxSPfie2Fo9gzxYbhKaZ0ygLoxsmuHD6TKHNZ83hhx5Bwx/rs3b1VftQrSLdyqxJO
	 KAWWjNJf/zB6nHDWBYh1TanEDSURDAhs75ugf7Q2q4WijXujqhKFh7MP5HuzfcAYalt9f
	 vwJ7uPOpyzemaryYcgzfLxOBVJSxD1pGaSZM0LEWTa36+xNWsUpH8VGvogG0pZ0UBPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522815;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OALui8VPPsqtlTWoUZ805j+WxFMBzcSfNJPuSjq5U0M=;
	b=te4R/2OosAETMgYGvXmBE4h/PBUXFweHtazL8aIqBrBurZLBLZ8aPbSdoRHrjvLUk9Vy
	 Abc9fo+1Lhc5YOP0vRFn/p3exJOsiorhlHZbgxkBcI1a/ouxMdv1KuzouwuukQLfFYSTe
	 gT3zQCvz1paAYi0Jp2wP4akumjdGBZCJ2N0f7EojQhfotsFcguMxipjEAoCVN1ErcVKR1
	 KBS0JyZ1qFvJII6mOGqsQgRe/enSZixhVNTEJX9iVspArltb4zRiI4DN0hAO8YuwLgR79
	 CKGDEwz8T2FObDgchWH6et+d12HYff1gRUe0SQ9Qtg9NvHoQCNfKWKwvW43Bz9proxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUxkKKEO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005D606A31C;
	Tue, 20 Oct 2026 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUxkKKEO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBCF1F000C9;
	Tue, 20 Oct 2026 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792522814;
	bh=OALui8VPPsqtlTWoUZ805j+WxFMBzcSfNJPuSjq5U0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hUxkKKEOxHjhWNzs2TFQr8CPdhjUZlZHp2V3He/8XOu3DBWn2r97HuHEhV32Bc0os
	 3E8pSKe+diT1/XwtUBqK6xowOkrOJtsmSmnbKw16oEFkHf86JV+mPjmwVH/zFbd8qV
	 rCUTq/MFR2uz6aC7dURljavlvawo5FyciWlJyiahEsQuTg3q8vZgyTNe5uL4/mOOh0
	 lw5TZLWFZTiSprRn4FWtf1qvjdBsJA9hEZkVmndmQELUOk2T4omrd4ccJ63NmlCwgr
	 PbAdjexfU8eGkHBZ0Kpa3ghD5/62hk5f86Vqa2eAe21ufnDNIBtLCqt9P23t2kBV+5
	 PngutJKyu/sHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44563808209;
	Tue, 20 Oct 2026 19:00:14 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] drivers: net: xgene: Fix dma_unmap_single()
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252281336.159319.869202945975868338.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:00:13 +0000
References: <20261015124547.29996-2-fourier.thomas@gmail.com>
In-Reply-To: <20261015124547.29996-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 14:45:46 +0200 you wrote:
> In xgene_enet_refill_bufpool(), the skb->data is dma-mapped with length
> len which is set to XGENE_ENET_STD_MTU which equals 1536. However, in
> xgene_enet_delete_bufpool(), the same buffer is unmapped with length
> XGENE_ENET_MAX_MTU which is 9600. This may erroneously unmap other
> DMA buffers or cause other issues.
> 
> Change unmap length to XGENE_ENET_STD_MTU.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] drivers: net: xgene: Fix dma_unmap_single() size
    https://git.kernel.org/netdev/net-next/c/03977f8f1a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


