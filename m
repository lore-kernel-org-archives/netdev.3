Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00C38D3F2
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482408; cv=none; b=eJpXOfRWv74Lr7JOo/hIiRdCM4nCssH62ERTj/zxxzNh0yELT16AiRqPA+ECfEQpIq0jNniY+7+pz4sAuHp/qqSrNFLmWOL5pRAbgfoTKQmNs2ghmFWjfTSs34vMNMjsD8k90pAozahsIlrxfp8MO2NxKMsX4B05yfeqdcF0yLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482408; c=relaxed/simple;
	bh=NIKlJ9JlNvPwpyQsILEy+dQHzgjHKcV9U1zyWhmbTbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XhlDPgNWzCPZXrOnmeoO7DwvjqjwDAAfgSwR3p+ujIC+5OEZ8DyIWFkNKoNmOnpHgn26acveVgjGUfURLEHNp2VMQZEOBZHo2AJ/FnQ/LBdOkRCN6SYfkyjvmv5EnG3bbc0nT6aAu/5ao8i/EJT4CnLXHssOaY8r4suCDKMlCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3tL1Rfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3tL1Rfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EA51F000FF;
	Thu,  8 Oct 2026 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482407;
	bh=j3M/JcHaP+DIajYPUwR0IO5r3nM5YLh48UUKYsgxPog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j3tL1RfhF0DJaeExSAwYlU7IjyeLBYkX6EYCCiqFl6psCLWBC7XwpQakDnvChoODQ
	 SaLJXOTkjkigCvbKp6P/yYq0ECGLxwhIJKXPTm+LdCcSJoCkzkNdiRyyaOeWFxMePb
	 +NCx4MKuIfZrhFX8y0YkehCbyH/rqKKqo12Ub1bT/YZ20QwrO/yzJwiTQmlcNNFO7Z
	 kr5Cfn6sRXu4nxULzhrLJSsSMh/TgIEjfosI/7AAaefEX2kmfAI5X//RgyJfNlrcj9
	 ybT5e82ke4m0MWtdiCY+G7zMfSfH00jiDkf6lqpOaydOcl5EM9fWKHA1ixGNMb6EKq
	 Z77Be1ZZOOaNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F182F380CEC8;
	Thu,  8 Oct 2026 18:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mlxsw: Fix port range register leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148240553.372666.3460910775211213373.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:00:05 +0000
References: <cover.1791294384.git.petrm@nvidia.com>
In-Reply-To: <cover.1791294384.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 idosch@nvidia.com, vulab@iscas.ac.cn, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 6 Oct 2026 16:21:27 +0200 you wrote:
> When the mlxsw driver parses a port range template rule, it acquires the
> actual port range registers. The parsing is only done to determine the
> element usage, so the registers can be deallocated right away, but this is
> never done, and the registers are leaked. Plug this leak and add a selftest
> that would have caught it.
> 
> Petr Machata (2):
>   mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()
>   selftests: mlxsw: Test port range occupancy on template create
> 
> [...]

Here is the summary with links:
  - [net,1/2] mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()
    https://git.kernel.org/netdev/net/c/7ea07afb230f
  - [net,2/2] selftests: mlxsw: Test port range occupancy on template create
    https://git.kernel.org/netdev/net/c/71198b59df56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


