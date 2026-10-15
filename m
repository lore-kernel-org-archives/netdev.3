Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D147DD44;
	Thu, 15 Oct 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049412; cv=none; b=b2neKly6bCrC0uEhsV/UBkQuYxegI5T6gaJ5zL3cbMRgCcjheYcVJl5o/S7IbgH2LYxoaNST8Uu6FisITciFxWLw/BNRuPI26x59Bgzv2X+wt9d6KVMdlU/Pe5Wx/+3C/dZnEPeLbUoFXcVhwbq9po0oSIDGnF5Ji/PSDvkNygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049412; c=relaxed/simple;
	bh=ZuCR9BfGncvngM6XQeTriZk1mtjJ/2Wb1S+cBUutNTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r/Oi6ak9DYRZqdB4rZvyHepZVjtpNgvp0CvHChL9j6eB9km9OqiZWh4RDEENgGe4RuapN7/Km9KKBDR3x2FZx1hWLEOgDnjWwXt0GBU7R5UXH+y2j+Ror4139zFGTYKACD/eEXLgEvh9gJexRxtMpi0nqZOEdILvYp0tVzf2Tiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXNrCSz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXNrCSz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC8C1F000C4;
	Thu, 15 Oct 2026 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792049405;
	bh=BAJzzdhvugzKkYVj8KyEXPZU8qeSPJVqLHbWNfyLaQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fXNrCSz0zq2geIvGS/pywMuHMsDLj1yhzBf4O6e9/XBzukiNkTy1BTyigOJCPhMP4
	 WW+FJSpnjGvneReRPWaKcAsHFAaz8mF5+TdoeVycQ6wlsfJpoZ6+rCovjM51UIwlCv
	 aJebFMJ/KskssLDZkdTwFY8hdnOaNcM1NGk4DF45M7Q7I317L6W9kH6uKoZ0fYqYWZ
	 xC6MqFaVPBYr806LnRENGyoDlU7dZkPBVQw5FJddKR3yljCs+sKfFBciQOVms7OWx6
	 FYZWtWia+4EsOwyK8Dg1STurD/HvZpaKvauVqev4IZlM0s6WDbE1b/wMdR9QcmfH3o
	 K+7GuDsyhkaOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B458F392E9C3;
	Thu, 15 Oct 2026 07:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: axienet: free outstanding TX buffers in
 axienet_dma_bd_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179204940452.3240332.8918425911650346441.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 07:30:04 +0000
References: <20261007034620.1360542-1-maimon.sagi@gmail.com>
In-Reply-To: <20261007034620.1360542-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@iogearbox.net,
 jacob.e.keller@intel.com, joe@dama.to, suraj.gupta2@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  7 Oct 2026 06:46:20 +0300 you wrote:
> axienet_dma_bd_release() walks the RX ring to unmap and free every
> receive buffer before releasing it, but frees the TX descriptor ring
> with dma_free_coherent() alone.  Any descriptor that
> axienet_free_tx_chain() had not yet reclaimed still holds its skb and
> its streaming DMA mapping, and both are lost.
> 
> axienet_stop() disables TX NAPI and stops the DMA engine before calling
> it, so nothing reclaims those descriptors afterwards.  Bringing the
> interface down while frames are in flight therefore leaks up to
> lp->tx_bd_num skbs and mappings each time.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
    https://git.kernel.org/netdev/net-next/c/0c20cb4cfb40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


