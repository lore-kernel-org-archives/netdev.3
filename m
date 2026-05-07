Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864A26B74A
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117475; cv=none; b=acFl/+3jx1gDhhx2r94ZetxuZjEZ4UJ3HPW0h14oEfIa5Iy5uWcv1DXRmgCvhQ9PcMFZXaeZvnzl0wHaE4+Hma4bFw84QkWCglB3BCeZcIT3x1MVbLTzB20fjwKC33ajR+gwXv3U/v/pxmDhRd2IAiqJNgq2Aaraf1D7WfNMClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117475; c=relaxed/simple;
	bh=Fk2L2IGaN136P11NAApVrA7rAGlfBztANvE406Y8/tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsyByP8xdgarlqlP7vTZcdrMQAKHHSc9561ifyH4sTKd+3wB+5KPKGZvizCohS3A1I512Q4hsPQ58xaO04ennPQ/D1R948wPR4FDitwFa6f/pTcuc+F9ns2Vm2YZ6ypjtHYEinfARNtI3eCjjZ3VbBcx7St0NwU6wwQAjLxe1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6XI1XEQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6XI1XEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE01C2BCB0;
	Thu,  7 May 2026 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778117475;
	bh=Fk2L2IGaN136P11NAApVrA7rAGlfBztANvE406Y8/tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6XI1XEQkboDuYFWQgW9MwtrttEEkWNlYOXw9HxaKzwQxONVxuV+x65GMn7ELNsdg
	 ffKCa5hNPqBJLl8n8XC+d50EjD2TxURyAtsZZ+7OqCaBVLC0yhuTIYNiP9u9jBd7Nt
	 UrK8oVpQFQBCGR2/SMX7ZTrqBUA6+4ftkGwuph/h4v3K4zDfNASupiulnLZWxCvRVJ
	 53SGYydniiiaERk3NySgQbqycYEAMVXWFyTffUNiAGiiTMrGPh+V5K2/ZzcmEboIMK
	 2RjyIswgfU5/58PAFCyy8FUY7oyuxCIZIIpDaOGZjpgXzX1pNIWyy14bzHJ6Mbz6lZ
	 AVcVs5FTHVAKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DFA393089F;
	Thu,  7 May 2026 01:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: tcp_child_process() related UAF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811742454.3291094.16410058014129516825.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 01:30:24 +0000
References: <20260505153927.3435532-1-edumazet@google.com>
In-Reply-To: <20260505153927.3435532-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, melotti@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 15:39:27 +0000 you wrote:
> tcp_child_process( .. child ...) currently calls sock_put(child).
> 
> Unfortunately @child (named @nsk in callers) can be used after
> this point to send a RST packet.
> 
> To fix this UAF, I remove the sock_put() from tcp_child_process()
> and let the callers handle this after it is safe.
> 
> [...]

Here is the summary with links:
  - [net] tcp: tcp_child_process() related UAF
    https://git.kernel.org/netdev/net/c/c8f7244c8ccc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


