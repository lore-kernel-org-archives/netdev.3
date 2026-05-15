Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C726B764
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808660; cv=none; b=h47QOGrYxLN3uEoJiuiS6ZHAFgEgwMc82C9INeAz0BgW9mzy2T7KSBRpKRkHUtGjIXzWyI5aps2k88MXqnKHJaSmQtEAMCrbiICQAIiRT0E05X99rzMiA67B1PlLXJrnDesYKqS5LgXKgpnkDxpgOaYIR8/aFZy2TIG8wOoOiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808660; c=relaxed/simple;
	bh=Nx8maYqKXC8dWzmTl3pxSQ6SP9oGIOi9zqWVNidoWYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kaSsBTdlH3wrZ1BlqzWNqW3inEJcDRCJ10ahilT4iS4sKiPIc+J6ytMwz4N3fSWQwp/K+i3owyuBmknYzqZuflgjwX3YPMElLR66e92o9JCc9WnV0sVdj+7ZbiY6rMNHxIZf9Uz2oR+XYlYjUZFHGs/81G2OiW4TmgF3XjEurpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvmOS1+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvmOS1+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7848EC2BCB3;
	Fri, 15 May 2026 01:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808660;
	bh=Nx8maYqKXC8dWzmTl3pxSQ6SP9oGIOi9zqWVNidoWYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FvmOS1+nFPtpElgSiv1e1liUCJEL1NtypM1uM3xUXuGftK7Vkntu3NA1zzjYWipwZ
	 GhqbS5MDjue0Rnszs0SaIefMwzl+q2KOkpkpf04oCRz8nLGsqO7N02NWn7pcrQdtSx
	 /up8hCR68u/M2bKVq450HLoGbuinBixSndDbzXkwfF8NLGy8tLFg0ZT13CgUz9AEbv
	 cambuUhgAMch4GhxDO11ZHaqyycK946mudQR6l0fdyWqJ6s2KJgrNx3FlZWDvRuqG8
	 u6T1HmWmuEXggmRDiF7yVp5MMHEeCsjuBSUZyzBY+NK7t5w1rHxlrWJVSSWIaE371E
	 yTPmf7wgL6quQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD0839E8A42;
	Fri, 15 May 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tls: Preserve sk_err across recvmsg() when data has
 been
 copied
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880860505.154016.6069051548145813677.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:30:05 +0000
References: <20260513125825.205189-1-cel@kernel.org>
In-Reply-To: <20260513125825.205189-1-cel@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 08:58:25 -0400 you wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The sk_err check in tls_rx_rec_wait() consumes the error via
> sock_error(), which clears sk_err atomically. When the caller
> (tls_sw_recvmsg, tls_sw_splice_read, or tls_sw_read_sock) already
> has bytes copied to userspace, it returns those bytes and discards
> the error from this call. sk_err is now zero on the socket, so the
> next read syscall observes only RCV_SHUTDOWN and reports a clean
> EOF instead of the actual error (typically -ECONNRESET).
> 
> [...]

Here is the summary with links:
  - [net] tls: Preserve sk_err across recvmsg() when data has been copied
    https://git.kernel.org/netdev/net/c/f508262ae9f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


