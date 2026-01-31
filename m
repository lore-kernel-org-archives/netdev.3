Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CB36999B
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769887225; cv=none; b=mz+jyxud6CDojNeA2Ja/XdgYztMKZWzpm1XkI+Qy2OIOnNDKtcFuPlfYZZtDlzP7arEvt8DH1g4UG1Wx7B+BvU1V+nMVer5IrmHEoYPFAjWEl/GaLLnXpBog+qtYpWMBN8IPFgqT5GiIL3QYs8rTkwjL+f53BR4uaUbAbj4ZhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769887225; c=relaxed/simple;
	bh=t22oOS86PnzqCAD+ypo161wnysdSUXoE67L2bereZg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RpWtmMrcTu1LrqMOoNnLVsZwdLZuUQG4yJTQSFZ2HLyGxxbHx9Q02iEvhmMVJnXdOlqTq2QjJ8543/PLRnOQjI5cyb0zRqv2Jgq6bjsfV8qGBKwE1njS5B/RQoPp6PxnVTA+BI1BIkNc6pouUkeKERD/fK/qE0DAb+ZLJFRQyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL8jnIVv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL8jnIVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92DCC4CEF1;
	Sat, 31 Jan 2026 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769887224;
	bh=t22oOS86PnzqCAD+ypo161wnysdSUXoE67L2bereZg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dL8jnIVvxfrZMCwKXkydtvVphqeJPnt8oF24VhXPw6DmQtZ4z1tDnWeHj7FRuCRCS
	 Q2RE1Xctx1DHrn11p5QOWePJw8a/2DqNy5YoCiTsKo3jfiDyL/lzg0YRJJVjepM8q1
	 h2PgVEoft2JpWp+ptXLASC4RNt4X/7euy308sNoY0SEnjZGjCYGSAsu4cr/cryuwGa
	 kTfO+voQhk13FTChDDjM+W5AfRU9Ym7iBvEEYKHx2XC6tRnDMjX0MmyRuGQEH2KUl0
	 dcO5u3vlk4imJcf4c/inUA+yXCrjst3NIKatBUY+VidYtBszp8Be72tOJvoSy6/lee
	 plsuh/dwOUINg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1190F380DBD3;
	Sat, 31 Jan 2026 19:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ss: fix grammar, articles,
 and phrasing in man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176988721660.4169653.8292887643483830988.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 19:20:16 +0000
References: <20260124200107.222116-1-stephen@networkplumber.org>
In-Reply-To: <20260124200107.222116-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 24 Jan 2026 12:00:41 -0800 you wrote:
> This patch addresses grammatical errors, awkward phrasing, missing
> articles, and singular/plural agreement issues throughout the ss
> man page documentation.
> 
> Main corrections:
> 
> Grammar and agreement (10 instances):
>   - Fix singular/plural: "connection" -> "connections"
>   - Fix "five kind" -> "five kinds"
>   - Fix "packet" -> "packets" (7 instances throughout memory descriptions)
>   - Fix "the retransmission occurred" -> "retransmissions have occurred"
>   - Fix "process using socket" -> "processes using sockets"
>   - Fix "thread using socket" -> "threads using sockets"
>   - Fix "socket option" -> "socket options"
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ss: fix grammar, articles, and phrasing in man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cd01762163b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


