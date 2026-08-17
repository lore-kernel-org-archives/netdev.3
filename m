Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F934A797
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008679; cv=none; b=DY5WMknu8HT8vWM6Zbg3zVqhf75KGoDCgbUxRy7ttm8N76d+FlTc9jjGojgmzalEaSLyvHWq+apjw1TrODJOn1AnOaCKuStNZo4a1wVIVqxljS+7HRmL7cpnJyTIjOgj4OLK3h4Gid9Z9Qb8z3bGDXHhdQXLcge2qpPFfHeOAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008679; c=relaxed/simple;
	bh=66t1zrrtYpzpEh2clbpwp4w7Gx3hg5wTyeJMPL/cyT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzL/Mm5trrz3GMM9Wcgri5hV4ObtjzQluCHveU8x+0cxFzjsRD43N6Tki0+n2yTD+Ea9G7r5FJI5rWlNu5YX3A8TQgMcnsm8W5DjHHEbGOYgIM6Ur2I039+Tr3Rs5IlQl5OS0QxolYdNmyeA8nLbi28Ur6zKigzhSY4bmxSV36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkrxHe5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkrxHe5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03B61F000E9;
	Mon, 17 Aug 2026 23:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008678;
	bh=BeLurHl48k47YBXiRQrPwq6QLHKVeqckCwiB1xJKzUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FkrxHe5nI/WdOsL00EjFMtJLAdf6WxL4CFwmMqrlweIpfOwYZKQAmxSdcok838mj9
	 kYmFVHgJc9hMAaNsuJI5Rb0rWzfrtF8q4Ya7b/8suiCyDThhqMeM1JqsmEb6863mYR
	 j1aimzw9Dc93A4O12hqtbuDFFeylw+18hQNMPUmg6p1nG9SQpUTNlKj01hTFqVetne
	 6UUgSGXzVgAAit4X0HhvD0EK61LXnZEcFMnX+P/WnXg+lfR/1RZXU6Jxlt724/EHW6
	 ZbEvIyQ43ezP7BJEvOzOrRQrQZggS9Feb+7R4zMa9G42j98w7vpE/SeGumE3JfyKsP
	 ZrsfrMPH8lGmw==
Date: Mon, 17 Aug 2026 16:17:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, win847@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8] net: airoha: npu: use cacheline-sized buffers for
 mailbox DMA
Message-ID: <20260817161756.5fd2185a@kernel.org>
In-Reply-To: <20260817090601.1256389-1-pawlik.dan@gmail.com>
References: <20260817090601.1256389-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 11:06:01 +0200 Daniel Pawlik wrote:
> On EN7581 + MT7996 (Gemtek W1700K), mapping small caller buffers with
> DMA_BIDIRECTIONAL regresses NPU version probe: the mailbox completes
> successfully but WLAN_FUNC_GET_WAIT_NPU_VERSION reads as 0.0 instead of
> 0.1111.
> 
> Allocate at least SMP_CACHE_BYTES for each mailbox payload and map
> ALIGN(len, SMP_CACHE_BYTES) with DMA_BIDIRECTIONAL while programming
> the original payload length into the mailbox length register.
> 
> Tested on Quantum Fiber / Gemtek W1700K (EN7581 + MT7996), kernel
> 6.18.44, including two cold reboots and sustained WiFi use.

To me the fact that this patch helps only proves that the swiotlb
implementation on this platform is wonky, no?
IOW AFAIU we are avoiding the bounce buffer so things work, but
the bounce buffer is still broken?
