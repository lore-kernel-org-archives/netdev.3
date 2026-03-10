Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726A3195E3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108608; cv=none; b=Zab7Q7FsKJFqPM2aebUm9NfpU7neKPlyybF3e+GfszissWjQVgBwsuPv3iaUk0hIPpf20AX3SsuTqPTbhzQdRXy8Gt17JCzdnEn0ix52O0gt8ev51oWYLgt9U0oA8qtx86ivg9YasbCvuFxWxr8w7wjv2PuozqviNkQg1FeS46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108608; c=relaxed/simple;
	bh=Mq0WQ1/QkOn44NKIq4sfj3j5VwJnPxoCMulZcwnoh7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+B6ZJpP5LSG3bZMyCcH4WavXmZGCE14u4OHx2bhFD4xK8TSunD4kgpgVIXKHeOSMMyraAZjL7lOUHIij1O1mvG5M3S7DO4/evHlZyhtZ4p7Ph/Sx8rrx1XG0qe4sWD4nFYBdogputkrqf8DsxONLULY69+WQUCA6ITU2JYqP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUpUuVvz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUpUuVvz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699E4C4CEF7;
	Tue, 10 Mar 2026 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108608;
	bh=Mq0WQ1/QkOn44NKIq4sfj3j5VwJnPxoCMulZcwnoh7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUpUuVvz9cTZ1W4859A+ypg6KyiLluTsWNxhkdpEejMh6ULM95y8+Gy5VaJqU1yT1
	 h8Flja5qLVyb1kC80oPtxp2GKFVCsJvuwky0ou9+Zkwy+SqILONTGmaT6eOFWQmAA4
	 DayY9Ksw+tME1sct2NXzgUUQvoHIrGNPxnm9Sh41zudLnCyC5SUpIqNwLQISSdlxRU
	 C81Gs0etfrl+EL/13yfJiMQQhkJZu18KyKnolOmGPnx0+cFCUuzXuyKkAchBwETUD5
	 KVtk3Y25NKqc9OJWyX/NGM9a3e06zbT+E9qGjgO+ZPBwaKPZfxfELO1YhX+MNKVbQG
	 Ans37BdfapNeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF63808200;
	Tue, 10 Mar 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: include/net/tc_wrapper.h belongs to
 TC
 subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310860555.2026004.6573841943729666049.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:10:05 +0000
References: <20260307120607.3504191-1-edumazet@google.com>
In-Reply-To: <20260307120607.3504191-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Mar 2026 12:06:07 +0000 you wrote:
> include/net/tc_wrapper.h changes should be reviewed by TC maintainers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] MAINTAINERS: include/net/tc_wrapper.h belongs to TC subsystem
    https://git.kernel.org/netdev/net/c/7a85d370bbd0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


