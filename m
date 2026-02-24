Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF6238C3B
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771896602; cv=none; b=j7GiiAfBRgdlz9tb17GhsHmPBw7j3isMIHeA4Up+Xy8SIhCcJ+e02C5hIjobWRR1fmJ6dEOTH4wMyxUyZ3n1kbCzjSUZzSX9solYQrbg7F+O8X2RJPmtIlaV+ZN9qOWHl00iRXZa7bgcthSFVmpuLyBQqIdcsFN6hvsROiFYKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771896602; c=relaxed/simple;
	bh=3NhFLGfnYTea0ORsa+AKQNSUy+9QsioDknydC3zVQro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wh1L4IYg20nz/IwyIuAMaV5Hj/g1BnA/5J+WECyT5cdVFRfZL2R5bz2rup6lw0s+kDx2RcZAYBJdUCyLE2NokddGx4164/7qZChG+hjpf04kejbIaGF3VGXx/G02qeC2888lvs9fWnvyp/D0NqktYkayg+MORCVuV1doJjBhKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmC2pKCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmC2pKCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1AC116C6;
	Tue, 24 Feb 2026 01:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771896602;
	bh=3NhFLGfnYTea0ORsa+AKQNSUy+9QsioDknydC3zVQro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bmC2pKCkt3nxNgCHnI/yEwOzoD6qG1Qd6BqXfGGJCwUNIxTVO5ae9nDDWZMoe3EHO
	 TI4LT0k5r9rRz1R/KOpwZzFgaBsDHUZ82BvxEdnqJQyeuKtkUMbCS/fS5gaTN2/AFA
	 tx7ZbJl0B5OwwGEhoY7q8YDRWRTPnHFK5KhdxTT2LMrpNhdZHEcf7NALYPxJt2d7rB
	 /b7ACB0tZjCaIT6iy62csDrUQGH1RUEj6rqzFns6HKmAUaygHNQcAktDjoNugCF8BI
	 xYMQn2UgTU4gNBnqZa3Cejw6fz0/m4HROwv9LGq8XgQLAH8B3CM15V0fmkBnzy0AhT
	 o+VfPvkkjEEyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE5E3808200;
	Tue, 24 Feb 2026 01:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tls: Fix race condition in tls_sw_cancel_work_tx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189660805.3265070.3497248414183921475.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 01:30:08 +0000
References: <aZgsFO6nfylfvLE7@v4bel>
In-Reply-To: <aZgsFO6nfylfvLE7@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 18:40:36 +0900 you wrote:
> This issue was discovered during a code audit.
> 
> After cancel_delayed_work_sync() is called from tls_sk_proto_close(),
> tx_work_handler() can still be scheduled from paths such as the
> Delayed ACK handler or ksoftirqd.
> As a result, the tx_work_handler() worker may dereference a freed
> TLS object.
> 
> [...]

Here is the summary with links:
  - [net,v2] tls: Fix race condition in tls_sw_cancel_work_tx()
    https://git.kernel.org/netdev/net/c/7bb09315f93d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


