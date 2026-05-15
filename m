Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47D188CC9
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803863; cv=none; b=HWKRbkgUtspI3us4RcXLESfPLiFDMjsyKXouyfC5W9mklOaQ8tLWe/EJJtXrF7drQJmvyrV7Kvfe2JyoU28VS1F6N0pdfT+P4OeZOU7pl75KgKU8Yw0KWI8hQdofpb9AE0+focWv7WONTHclnFX1tB/VEDMkB2sBLQ1wz4STE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803863; c=relaxed/simple;
	bh=blTBYFM8P7ZXCcYPI3QVuOhMWDdi+LR3Ql2njqgBaEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UiFC4pJkJYwRmT/HQg2xO6fLrF/EAUWi+PfnguAa0VlLecHmdIAHtPvBMzyG5XRF3t3SUwTZlxM97Bt5BNMzeLCTjvZx2XS9sg1Rxt/qoJQnK6U73eUo8CDBrmPILB+wN7Bu86vlDhrZb8tPdPAMQvaQILnMZondd/AyGE8ilQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXR99ll4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXR99ll4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E60C2BCB3;
	Fri, 15 May 2026 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803863;
	bh=blTBYFM8P7ZXCcYPI3QVuOhMWDdi+LR3Ql2njqgBaEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XXR99ll4oh9yOrpJRtz/1wTBL/hJFzC552YZJMcdKlWAE92W56tDdpZRtKbhPeNgE
	 sbZKepa//VmHtkQMQ0gcYbO/94n3bX9zq1DILUtaVIH0gAFStZ0wRdqXZh+s9K9vF9
	 uxmzYe95zHsWCG/hrB8kENHXkKHGKxNCMCKzBRHoO6exZxAInLhPLmdF1wqhUs7QwG
	 /GbPNhoeh8vD35QFTbKhLbbt6CURRiQShaOYs+TKz5u9BtJgxRp/rAIvfXmHay73Eu
	 48WvmrRttRglGkPcR0kqikEtKPsw4jpUf6O4BPKEm2oZJtKGrWquwd1Ct2wqwHK9H7
	 Q4cFm+7yUk8iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBB139E4DB3;
	Fri, 15 May 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: add one debug check in nla_nest_end()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880380804.132344.12529510216185317824.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:10:08 +0000
References: <20260512155244.4137851-1-edumazet@google.com>
In-Reply-To: <20260512155244.4137851-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 15:52:44 +0000 you wrote:
> Add a DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX)
> to warn if the kernel sends corrupted nested attribute
> to user space.
> 
> Offenders can be converted to nla_nest_end_safe().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: add one debug check in nla_nest_end()
    https://git.kernel.org/netdev/net-next/c/ff205bf8c554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


