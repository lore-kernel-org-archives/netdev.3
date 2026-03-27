Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112239448A;
	Fri, 27 Mar 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613425; cv=none; b=cMd1q3fRsc8th4Y2avPUuLB8R2xz/eOVxEa/vbqRLNVKqSH8RS5oF7Kt5nNxhF8Xr4hkn8N5h9oTof8YRAQpSHQrTwoHRqIA/611xrhe7XINlidLao28xa4PcglQTyIH+pqmqPfSIVXA/9YXolYiIX9GLZXLflIuJyLX1EsMyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613425; c=relaxed/simple;
	bh=gyERVolTbKWBfp1nQTsZ988TQ/o2iZkKjo7Dv2xFKiY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1FssDklNieILwsnwa8bRFAE6cg4IqXBxnwZllxmVTQyqcc1PbaFfmTDNBEEadH+sSbra35qFB5JXls4HljrpZxa4p2xacDJtJCGPfNFkyNTynRGctYBAg2tiKENovAd39etlLSyAdIQoosavmVcLYHqVXDdCzM72gxyp4xYwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6AeUJsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6AeUJsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A262C2BC9E;
	Fri, 27 Mar 2026 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774613425;
	bh=gyERVolTbKWBfp1nQTsZ988TQ/o2iZkKjo7Dv2xFKiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W6AeUJsj5PeAntd7GY6g3UMaWEhq/fQjJ6I59V6h0Yjt1g4RMQhTpmCGQmpVemaPp
	 kFKb9Ee5+aOzMq2HoXjGPr1u84IGZSHGvBAiqtLPNEqrkHFvjX25h5hiLzqIlaPoO0
	 kggWRg1cfQnMAcZgMqKqZc/9NGq8QVquaIbCgPsvTDQtcGxlPRyfxDabJ2a6vwepBc
	 fHEuTO8NxWwTxAzp6nhsPfc9y0WEIlhaxUC3cwIi/wjwd6JRZpgm6wxoFDnrrmG1lD
	 n0RlxKAPA5qs0XiLLsdfXN+692BC01wul8LuiRINvjkFDJtcm35cjJXW8Y1bhOAZf0
	 +rcXIeyD/1Jtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2D6393022E;
	Fri, 27 Mar 2026 12:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/ipv6: ioam6: prevent schema length wraparound in
 trace
 fill
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177461341153.3453543.11122530396549000451.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 12:10:11 +0000
References: <20260325074152.17064-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260325074152.17064-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: justin.iurman@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Mar 2026 15:41:52 +0800 you wrote:
> ioam6_fill_trace_data() stores the schema contribution to the trace
> length in a u8. With bit 22 enabled and the largest schema payload,
> sclen becomes 1 + 1020 / 4, wraps from 256 to 0, and bypasses the
> remaining-space check. __ioam6_fill_trace_data() then positions the
> write cursor without reserving the schema area but still copies the
> 4-byte schema header and the full schema payload, overrunning the trace
> buffer.
> 
> [...]

Here is the summary with links:
  - net/ipv6: ioam6: prevent schema length wraparound in trace fill
    https://git.kernel.org/netdev/net/c/5e67ba9bb531

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


