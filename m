Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68915225A38
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509673; cv=none; b=H8t0ZbWQgZan3sTYCWAzYRvFl9GTI2HdTM7XeW98XL94P9iMel/dCoo1thxsq9+swSB6RG4uUAqQeo9G7KVQzwrhSlsev5EbpSiXC0RM5P3NN8xYshn6ytzTNR6WN5daNarx0WynI/n04IERVi03UxoA5p3pDTEHujKW1qAaIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509673; c=relaxed/simple;
	bh=02jmAMaLq1hJ+vJjr1w67RdObn0L+PaQ1CNwxrBQ1kU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WY9w+p70NCNusK6s4ixJn4p/WWBtC3zt5KBem+mv0VQxcRLfysYdE0GNigPQQxzoNyNLNT7pH3Yu4XlFkJefcsg6omiVz0r3aWMt59vDHtq2fhDZoXxUg1bliGqa5rpxK/udeh9VTlscvsptwm5oRHBjGmFPcqHCWxbVSvUQGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg8nbc7l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg8nbc7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D843C19425;
	Thu, 30 Apr 2026 00:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509673;
	bh=02jmAMaLq1hJ+vJjr1w67RdObn0L+PaQ1CNwxrBQ1kU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wg8nbc7lPdadyVCZLJ4FETNt55/XVg9YpQJ3wX9VLvA0/610A8nRK2J2djIHgMLz6
	 /D9UwX7d6Gl57AS89PPHj+78lMDw8BFH34ZZzfyXUl2cWURYU4cS3d6u+vGuhLO4Jz
	 EXgIPacXaSHIr0PIEjtrIcHPaYxRd6VyQvawdsJxz1NKWzrmDzbolCVjcDH2qrPduy
	 s3utsliRD1I/GeTwOYl6JuDypuslwWMTRuhndm0qHbk6nCDXFc4v80DugajLylcNkK
	 E9C2rllNMzcecywwp3iW//dQhQdsbJKq4Gv9c9xdtQVDTrXCoVpgnAdbcd32nESe4i
	 bRD85EE2iBh9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDDA3809A2A;
	Thu, 30 Apr 2026 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] net/sched: rename qstats_overlimit_inc() to
 qstats_cpu_overlimit_inc()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750962804.2238701.5137939654561621956.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:28 +0000
References: <20260428070919.3109557-1-edumazet@google.com>
In-Reply-To: <20260428070919.3109557-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 07:09:19 +0000 you wrote:
> qstats_overlimit_inc() is only used to increment per cpu overlimits.
> 
> It can use this_cpu_inc() to avoid this_cpu_ptr() extra cost
> and avoid potential store tearing.
> 
> Change qstats_overlimit_inc() name and its argument type.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
    https://git.kernel.org/netdev/net-next/c/52472519ef61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


