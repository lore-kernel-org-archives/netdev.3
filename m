Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA5514770;
	Fri,  2 Oct 2026 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971809; cv=none; b=OL99+xNjxKCanGuLkSCXEW94Dq+Cb9J4LiWQdw+R3hiGt3ZrQjeCQKG/UQddlJrRdnBovnSNv21V+XR5jSySm7cUQe7tDCO/Ymyuv5QOzVy8XMXHnsA3+Z42JAznlTqKl649kv/q2RmY88H55LM6zG9xiXOkbmsWUXmqaVGxUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971809; c=relaxed/simple;
	bh=AnexBTqckTGgnVZSbd9fIKKXIdiXvyqa+jK1d05HILg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PjD39MK1FOELTJR3ssxcarq4emQ/3s1hqXMztXBr0S12w3EZOfzqJOfXn+h/hfRCdA97DVstQPIRv2yjZnRBZ7l19WwS+dLfzstXPk6jl3IgjpVqefZsCI30fIrlozn6B4ti/by8CbbLMLyry+KMek0kTkFbx3YlPo+XSv7Juvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjuwagk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjuwagk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442651F00893;
	Fri,  2 Oct 2026 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971808;
	bh=jxjwPiIKbDU6MasNt4osX21VBe+cd6oHzOjlTu73SmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hjuwagk9La0PlJpyZlFaaLG/EPnfiL5Om9kQFRXuOpENKWtvlydE+l54pbq1e8tAr
	 m5T4DYAkPWbNsihZdAnQifeDv30oDgqgYPfOFQOBhnYr2NuOX8jbI43RKcFF4DZ1kU
	 e45gv0Z1tzsDmAAjvHs+POd4VDgrr9bJ/P8+ROSs3WiKUe/+oia367/AIGSE0bLJGa
	 +7jHzRgH5/SfWSam0ky2sK6uGXU/k6I/5jnWGH8xIPNsm10vHUB4gdVv1EqZ924bsU
	 l6sVvwJffF0zf/CtSH7l5QEJO27ouGPSe688DYesO9gLVHuEcaIXb9W9QFd0/3mCVn
	 9bzb+L9pMcxBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3AF3811A72;
	Fri,  2 Oct 2026 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: xilinx: axienet: Free outstanding DMA buffers
 on
 dmaengine stop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179097180677.3568371.6111049801339254960.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 20:10:06 +0000
References: <20260928184207.2361931-1-suraj.gupta2@amd.com>
In-Reply-To: <20260928184207.2361931-1-suraj.gupta2@amd.com>
To: Gupta@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Suraj <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 00:12:07 +0530 you wrote:
> In the dmaengine path the driver pre-submits RX buffers and holds
> in-flight TX buffers whose SKBs are DMA-mapped by the driver and freed
> only in the completion callbacks. On ndo_stop() dmaengine_terminate_sync()
> aborts these descriptors without running their callbacks, and the driver
> then frees only the ring shells, leaking every SKB still owned by the
> engine and its DMA mapping on each ifdown. With 128 RX buffers pre-posted
> per channel, the mapping leak can eventually exhaust a limited IOMMU
> aperture.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop
    https://git.kernel.org/netdev/net/c/bcf2573a68a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


