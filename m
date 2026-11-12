Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508809;
	b=pFN9JueNjTEQbWQiOCS1Zcq7S45n1TfblE+eUOkPHoY3AqwP5gymwBfPEXimzTGuMPlu
	 N7YWU4Gp6B+L403wOgpbxs+9etQOhmyta+IseQAd9vHmXjurhM8Ubl26BdkkPgN3eX6oI
	 hqCHA/mQvxVKj5RweXFVY1d4IQ0Ezfn2gMyHMuFEnVOCHHBvoHxIKlY8mPJbT6JJ1N58I
	 NrDRTuS7KGrImnr/7fNljVBtiin6WurhmhlvpToZHmmERehHyAvnXlnEA9SErdVbQuHHk
	 C8PIlqljTg3049SmFSB0nFGVzap/3sARLo6eeV+XRr86LC3rlOJjt1sOoDnTGT8Tx9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OAIkw6rCIhMoz1r7TO6vR7yffvK4hXnx21iyJ/EHltQ=;
	b=p79uJWDoIHu4yRXHupo3pXcv1GZ+L6B3qFhe6PB+cze39MCs1gKTMJiajeZG1zuxkPfp
	 t6MHKOmvO5RTPKRfBnoJzZVAky/HoZHEtuMlcANgb78e9ilNecKQw1+BbN+gzqw8TXAt/
	 60HHlqIJ+oh4XLi7gF2sLEJPZJgSXifS1XnLakJmB5Dd6V1jrr7eZgCzf66Lfnb1A3B0C
	 Mrk8Rf/flLHmpVO8jZVdCxVIgumdR0eaoTcLrfMdCvkjMe2009bzL9CdtCRNSqZbzL0A6
	 2ilZ2aZb1E6uH8gsTk5DCco/C6RZh17BG6KugP07CoavtKhhtg7DsI/6kmNN1gRaGDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW3TDUyV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F99606A32E;
	Thu, 12 Nov 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW3TDUyV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4575A1F000C4;
	Thu, 12 Nov 2026 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508809;
	bh=OAIkw6rCIhMoz1r7TO6vR7yffvK4hXnx21iyJ/EHltQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SW3TDUyVZHG9XU+aYqqnDeaTZi5wx2RU29TD0tD8rFECwra5QdmrzmC2//aZ0FheL
	 VawBgcsTltOH6Jr6JyVPHzMfrlybd7dIINVXcNmCSnLorSIBzCKAnnqLwMWY48pJSB
	 Ba0BH97C6HoaR4FNRdjtUrQTkztmO/t29Dst4Hijp6boBNcMQsIEk+BUKFgDACN2xk
	 ITzDEZDnM+lKt5pfKgoawNOZV3CHmJbFunKsrgusITkQmEq/ALPLHT74hcmCkGXD4N
	 guHul5ANi2ZkcAgaLegQKc6EvEXCWro0zgLowpXgbkrOcJdczaO5V/cLC1WA4xZ1hQ
	 qUgxeUshTdyaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A36A380AAFF;
	Thu, 12 Nov 2026 18:40:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] vmxnet3: stop DMA mapping the adapter
 structure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450880777.585389.73990303934312950.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:40:07 +0000
References: <20261110154048.143227-1-kapoorarnav43@gmail.com>
In-Reply-To: <20261110154048.143227-1-kapoorarnav43@gmail.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+8eed6f83440ecdaf4be6@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Nov 2026 21:10:29 +0530 you wrote:
> vmxnet3_probe_device() maps the whole struct vmxnet3_adapter with
> dma_map_single() and passes its address to the device as the "driver
> data" (misc.ddPA/ddLen) in the shared area.
> 
> The adapter is the netdev private area, and alloc_netdev_mqs() allocates
> it with kvzalloc(). struct vmxnet3_adapter embeds 32 tx and 32 rx queues
> and is well above PAGE_SIZE, so when a high-order allocation fails the
> adapter ends up in vmalloc memory. dma_map_single() then warns
> ("rejecting DMA map of vmalloc memory") and returns DMA_MAPPING_ERROR,
> and probe fails with -EFAULT. syzbot hit this with page allocation
> fault injection.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] vmxnet3: stop DMA mapping the adapter structure
    https://git.kernel.org/netdev/net-next/c/42abea827cf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


