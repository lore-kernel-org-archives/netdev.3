Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545A386C25
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597473; cv=none; b=d6FrJOAAjAZpvUODniL41UJyS5iPt+unQCWgRv0KR346wA+n71DMrJGZOyazYqLt/SpR8lkRNIc5HXJNccWweamTGUuiPKJ2lxDZ6bRTAWz4hhKfmtPiLko9ctdnUKeDni9TcQbPi+TMI7m7La99vC1ySQv4ACJqmDwFhN92DtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597473; c=relaxed/simple;
	bh=NNx6iFVSWdF1SIjoHBv6J+izdzJBLnjayh/M3FCDd7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bMwQIJR3A+mNGMHG9vGqrPSxwa1ij1BdUBDyaS/gayU45yr/bJnULFIZ9M429MSYZIPaHe61iEr0hp1e1/Pf74S7QwXFB1mygtV/Zv/UTMVLjGXBon4z6zBWECPHweLBGvQGzCf8LdDeWJJwJDmh3ug6j+JsIhUiy5s5+nDLInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkboAzTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkboAzTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A83B1F000E9;
	Mon, 24 Aug 2026 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787597472;
	bh=sv0cQhIXoHM2HJjY/tjxUWURVlfOBd07q0Yx6t9ls2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JkboAzTYhSUlp2WmFbmFFBOpWURSPPAEwfw+GiujbeVjOyqy4TkwF7os7j1C7qJZa
	 +/g9AJmGTOetvx+7zcavU2JG7hvlyCR30gvW9PHujuZO7+YtF7xVnfB+IdqT2TlB+t
	 yMptxAVmtDVBztWxLn+L7WZvkRJMfO3j3IvLIa1qFyqUXqnsWIK5XyIOLCrV/rw1qb
	 dPExrFuV8jHhthb8e0e80n/AdWknTbuYaDaCrTGZrsgLZhK/TWx5YLdQeBGrnii8uP
	 OPIB5GptljAo1o2dK7PPRdxr4YvL7usOOALYLDSJF/cZk3rUohap4Dw4uwadx1Kr9Z
	 Dg3em0yKIfsyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A9F3924A4C;
	Mon, 24 Aug 2026 18:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/1] net: l2tp: do not propagate multicast
 notification
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759741938.3062482.8274115990086952612.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:50:19 +0000
References: <cover.1787247008.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1787247008.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 18:40:27 +0000 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a issue in net/l2tp/l2tp_netlink.c. The bug is reachable by a
> non-root user via user and net namespace.
> The failure is observed on the unpatched kernel, not theoretical: the original PoC
> returned ENOBUFS after publishing live objects and then accumulated sessions.
> Here, that reachability statement refers to the finite state-commit trigger;
> the OOM transcript below is a separate root initramfs leak-mode run (UID 0,
> PID 1) used to make the leak and panic deterministic.
> We've tested it, and it should not affect any other functionality.
> Regression coverage includes the root namespace and an unprivileged user/net
> namespace, with notification-queue pressure and successful ACK paths for all
> three state-changing PoC commands; tunnel_modify was reviewed as a
> notification-only command path but was not a separate PoC trigger.
> No broader regression suite was run.
> The finite fixed-kernel runs returned ACK success for all three state-changing
> PoC commands in both namespaces. The leak run returned ENOBUFS and reached OOM
> after 41984 hidden Ethernet sessions.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: l2tp: do not propagate multicast notification errors
    https://git.kernel.org/netdev/net/c/af20e269f745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


