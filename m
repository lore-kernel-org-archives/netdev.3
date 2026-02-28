Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA132E7F32
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297417; cv=none; b=N0+UqDkuj2OLiTSnrBwlmrLJp5uYPIZrihswsp80zbaRh1Rk7kd6HEfrKp/KTs5YjWLKyvevt8raN5hbs50PTIFSGXSJQSLnIYIWWJeZL6C1vACwIHzDWo1yAzh9xzqeJGhDUE/fWj4KqrZ3rqCqHlggV2uwj00gX3jRRheMua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297417; c=relaxed/simple;
	bh=DkqIAj4ZSKiepaY8koiBEJSR/bA3+nTkIRWnCsfHGHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CvqY/GOtdZfN0cnY3PINOjxFI/IQzo2MqnBwXALyXnBYH4wkskU0IU4hHtDoH4uZZSlzh1VhJTzgQcnNXTcB/BGVT+XYstOF6ElUUj/invACnMb6VS6BUqoeuUGIofYn876sNXRoCU6j7e+NhZ/EIOmstXybnp6O3bPQaYcvUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCCcDjdc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCCcDjdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE0BC116D0;
	Sat, 28 Feb 2026 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772297416;
	bh=DkqIAj4ZSKiepaY8koiBEJSR/bA3+nTkIRWnCsfHGHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCCcDjdcJAeLxkDNc78/8DtrzqQCU3P+/ke831g3VeMGqjflB0cb928Xhg8atZJLn
	 lMn/jRNEAOhEhPBuuUKJQ9nuFEQKUsPCpzQ4+F9sNRAPAKUSyXna+61l4RPu3oBRyk
	 ykRsk/IPNedEGAtC+o41sCm9UA7Iw5aQSzfA8CIih3bBhaeFeVHSPPKjorBZHJH9CX
	 9xnu+EgXdvb8ak2rSvsarsjX73pyVN9buTi20lbACGElD5oo+vNz5l2ogYGxVmJtqe
	 f8q7REJGe9XvdumyUj8jZC7WHOp4Fy++hEcfnoFRj7P+/ilx2lNjzqI+rN+3B++38V
	 73UUDgoLcXkuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D4C39F2022;
	Sat, 28 Feb 2026 16:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/12][pull request] Intel Wired LAN Driver Updates
 2026-02-19 (idpf, ice, i40e, ixgbevf, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177229741979.3013533.12494944362372316279.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 16:50:19 +0000
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 25 Feb 2026 13:15:31 -0800 you wrote:
> For idpf:
> Li Li moves the check for software marker to occur after incrementing
> next to clean to avoid re-encountering the same packet. He also adds a
> couple of checks to prevent NULL pointer dereferences and NULLs rss_key,
> after free, in error path so that later checks are properly evaluated.
> 
> Brian Vazquez adjusts IRQ naming to have correlation with netdev naming.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/12] idpf: increment completion queue next_to_clean in sw marker wait routine
    https://git.kernel.org/netdev/net/c/712896ac4bce
  - [net,v2,02/12] idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
    https://git.kernel.org/netdev/net/c/d11e5da2d6d8
  - [net,v2,03/12] idpf: skip deallocating txq group's txqs if it is NULL
    https://git.kernel.org/netdev/net/c/e403bf4013a6
  - [net,v2,04/12] idpf: nullify pointers after they are freed
    https://git.kernel.org/netdev/net/c/bc3b31977314
  - [net,v2,05/12] idpf: change IRQ naming to match netdev and ethtool queue numbering
    https://git.kernel.org/netdev/net/c/1500a8662d2d
  - [net,v2,06/12] idpf: Fix flow rule delete failure due to invalid validation
    https://git.kernel.org/netdev/net/c/2c31557336a8
  - [net,v2,07/12] ice: recap the VSI and QoS info after rebuild
    https://git.kernel.org/netdev/net/c/6aa07e23dd3c
  - [net,v2,08/12] ice: fix crash in ethtool offline loopback test
    https://git.kernel.org/netdev/net/c/a9c354e65659
  - [net,v2,09/12] i40e: Fix preempt count leak in napi poll tracepoint
    https://git.kernel.org/netdev/net/c/4b3d54a85bd3
  - [net,v2,10/12] ixgbevf: fix link setup issue
    https://git.kernel.org/netdev/net/c/feae40a6a178
  - [net,v2,11/12] e1000e: introduce new board type for Panther Lake PCH
    https://git.kernel.org/netdev/net/c/5b644464eeea
  - [net,v2,12/12] e1000e: clear DPG_EN after reset to avoid autonomous power-gating
    https://git.kernel.org/netdev/net/c/0942fc6d324e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


