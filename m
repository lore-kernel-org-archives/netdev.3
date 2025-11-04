Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4527707
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219833; cv=none; b=RxCluMa2XHxjwWnPYiGgtbFbM/gZ1QLR2IgHzN1tLLJmFI1TWKZ20sjywHZFN4yoYVXK3ZZ3yE4QpwE4i9lvHTWNxUIdy/Hf/Xqd4UcnaAclrF5z5XyVe7LLv+NqMmwmLUg3wVV225ejfyFqVj1w5uVUWxAnfLLWUC4NfEAs/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219833; c=relaxed/simple;
	bh=T7kk3Sb9baur8FVsf1DT6a/dyxOOh9NoMPij8wOGTfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b3M+BLHASBBcfft3outN5mfixl+NtdyISrZb4sGhX9Bhb4ASqMrKPixJwhXEDCOP51JKvwX/QJiM9jBYuAu+zrQrpe6YWOwe038nRh1xDhI3WjOWLBBEVcpDgbSMK+J08sjlgB+SyaVGaNd/5wKnCeMamB6QMBSePf5WwDihtDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9XPjHap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9XPjHap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD84C4CEE7;
	Tue,  4 Nov 2025 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219832;
	bh=T7kk3Sb9baur8FVsf1DT6a/dyxOOh9NoMPij8wOGTfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T9XPjHapmkyrxL7AEm45plAoQn5JpgV9KVfFsLHNytJPjRFMfycwYqpw+GQKRhBUS
	 ZOArgG14Lap/9R88rPbf+nIrq+bv8rAT8yFezW7WM5g4WXJRc91jzufNdiw3yIw/9o
	 VoA6e/Dx/zZfpCOfYfPcwuaqvqAm/EZp40JQ6BOrb8ALwobdNiZcZMKSwIZZtBQzyp
	 brHn6VYkoKsWC0gv6UZIuvrliIrk0sQMy0Gr3skynsHjTNLMODpKBvnMDnwHYWZkQr
	 jyqgvgZhcIrbB6lyDmBG1MASMDPqAo+sh9itMiCIMym7EbmvJdYN8Wbuwa/nx9Bnoj
	 HyQEZ6gRG8tfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECAA43809A8A;
	Tue,  4 Nov 2025 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: ionic: add dma_wmb() before ringing TX
 doorbell
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176221980675.2281445.11881424128057121869.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:30:06 +0000
References: <20251031155203.203031-1-mheib@redhat.com>
In-Reply-To: <20251031155203.203031-1-mheib@redhat.com>
To: mohammad heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 Oct 2025 17:52:02 +0200 you wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The TX path currently writes descriptors and then immediately writes to
> the MMIO doorbell register to notify the NIC.  On weakly ordered
> architectures, descriptor writes may still be pending in CPU or DMA
> write buffers when the doorbell is issued, leading to the device
> fetching stale or incomplete descriptors.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: ionic: add dma_wmb() before ringing TX doorbell
    https://git.kernel.org/netdev/net/c/d261f5b09c28
  - [net,2/2] net: ionic: map SKB after pseudo-header checksum prep
    https://git.kernel.org/netdev/net/c/de0337d641bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


