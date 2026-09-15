Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2430B53F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434089; cv=none; b=UuS8pBmEHxAOPFR4CSvsvb1mI9U+ZtZf0XX6NhKhYKVr4fMSAVjDftpLeNJyq4gRyo5JkIduqZUlqyS3/jFcfAaryPE8HUNaqQi9VnZudnW9erO2MIePbQKftCD8xSwFLU9nIUeJlvj5SD582caMFM5FmWPvWvbYCyrBpSkZelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434089; c=relaxed/simple;
	bh=V+PxcjuyKsKEVWAFKqRlX6pIwjK1cNqbgpWXDUpwFws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d5w3WBeeaGb84MgMhIQA59yER24DEkyNhkWa9iX2OXrFQaOFaae+SlUvYa3VBWXFei35UDx0NGFSF6BdHaDuTfDacSFaD0QdWGQSJMvMQ9ayi0hTYcw2VrnkcPUG8Sa3eTHBL3IZKDxYIqCtyyw6oWzqRwX/PO9kvvXgmhJRd1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm91TzSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm91TzSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4EF1F000FF;
	Tue, 15 Sep 2026 01:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789434088;
	bh=gEclKRt+0Ne0pMyhhIaRs1WBzlFl7Ml7PhE7A+h4VeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zm91TzSsFCkFbGwYLDUt5Uz8dB7wYnyzOFMkrDaFG8FTvcCH+MjhCJK326Kgfjms4
	 3lyw6QNigNIN4TRukdDsajnXarP3lNb1zqdGxoNGI4qrrvGT1Mi451RKuECMVq391S
	 vZXvF2h/4vu+kZsh0RNPpYzrYnRZ0CbGtdpog+gLDQ28SpOJJx34tVU/0R7BXgyP9z
	 /XnG/zrBpFrponam/MIT/dGrG8V0+nlym083C0AB8rMSI6sIVQoUyeh1bPqnXKVqBI
	 4606TpPGBTqP3iZWy7IPtcXfZXCzcdQX7FHIxf6OC2hitnJXJoqDy3YmAGPpw70w/P
	 6npuEvsfSG9rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A203924FFC;
	Tue, 15 Sep 2026 01:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/7] hardware pacing offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943402313.1293783.12761319138494735353.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 01:00:23 +0000
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 13:10:19 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Enable safe hardware pacing offload on a first device (idpf), plus support.
> 
> - Add rtnetlink support for admin control over the device feature
> - Add device support to the idpf driver
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/7] net: rtnetlink: add pacing_offload attribute to net_device
    https://git.kernel.org/netdev/net-next/c/f2109e90a5aa
  - [net-next,v9,2/7] net_sched: sch_fq: check device pacing offload
    https://git.kernel.org/netdev/net-next/c/8036cbf026b5
  - [net-next,v9,3/7] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
    https://git.kernel.org/netdev/net-next/c/e628a85c69ab
  - [net-next,v9,4/7] idpf: support pacing offload
    https://git.kernel.org/netdev/net-next/c/4aa8b5cadeb3
  - [net-next,v9,5/7] selftests: drv-net: refactor so_txtime errqueue handling
    https://git.kernel.org/netdev/net-next/c/2d5c630e6cd5
  - [net-next,v9,6/7] selftests: drv-net: in so_txtime tell apart sw from hw pacing
    https://git.kernel.org/netdev/net-next/c/4e50c0265f2f
  - [net-next,v9,7/7] selftests: drv-net: extend so_txtime with hw offload
    https://git.kernel.org/netdev/net-next/c/ac48ee533902

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


