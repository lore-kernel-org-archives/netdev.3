Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0534FE2FB;
	Thu, 15 Oct 2026 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057809; cv=none; b=guBpym5ZC6U6R6YjCYjENew26bfa0TMb1b/Z8vsGlI0hT1iF1rBsfh0cRM2mbh0tI9/2IAGsN5tZX9rvIZArkhOhWVCou3KDKmYDUa+RllGCFy0qxQhO/vnHcWWfvmbodR1gkdhAOmuYpqvdICwPqhSURDtA+xFoCZ2BiHak2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057809; c=relaxed/simple;
	bh=Yne0y5gFv4MwhDmSfySW0YSn1a4sARhDOoclbUdv3NE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Td8DHx1tUHYMiFNlbRyOmH0tFupxG+SAAv2eh9XT3nriLu04D48i7pFEh3hkfUXtXzIZW7vdah4y2O3DmK8n6iXZaqO/tEidubOkDYA5/NcvM/O449I+VSj0O52YxwciMB0Hc/eSDx67+fPZydf5Nzqt6I7IxvRDffo1Axq0ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aos7YhxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aos7YhxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050701F000C4;
	Thu, 15 Oct 2026 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057808;
	bh=am61RifpFgTVpr14AuUY5V0NipF5OcpwiC3FTtCmIcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Aos7YhxZ553vM68I/LW0nbxYDRqbh8HXLJ8hK8N0eKfAi4Nm3JsFpkojwQ/2tk0fL
	 9lXc8t3dM8QSUPU/rM8qciMdgtjeFgLDWLY/1shKTKgqRamoCGAHSMoY3hg4mcFBB6
	 Ho95XOQVrBCCKnbF6ga97PCHlMP8IEgZthIjNMgMOrFmKloLyBlZkjsH6BwGIjcsqB
	 IRoPcHgeYYXVhVcInqhhuIGBaq00yJIXwjq/7A9QUJTyx0ZYY41VnbLmnzyqr13raL
	 Ui2jepvyNhGIPq99jDl58jMGPYBeEwNqeoz/MHc4vP0DuQbMcCjUz3r67YSt1EQsAt
	 yX7bH31vqiRbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14DE392EA49;
	Thu, 15 Oct 2026 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v12 00/15] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205780677.3318450.12435733762532516796.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 09:50:06 +0000
References: <20261006133011.531806-1-dhowells@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Oct 2026 14:29:52 +0100 you wrote:
> (This has been split from "rxrpc: Fix CHALLENGE packet handling")
> 
> Here's a set of  miscellaneous patches, mostly found by sashiko.  Note that
> a number of the patches have been reworked and reordered after the last
> sashiko round[10].
> 
>  (1) Revert patch to rxperf to expect the magic cookie at the end of the
>      request.
> 
> [...]

Here is the summary with links:
  - [net,v12,01/15] rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic cookie"
    https://git.kernel.org/netdev/net-next/c/870143cfdac1
  - [net,v12,02/15] rxrpc: Fix rxperf test rxgk key kvno to be 0
    https://git.kernel.org/netdev/net-next/c/a7c8c3ab0723
  - [net,v12,03/15] rxrpc: Fix update of call->tx_pending without holding lock
    https://git.kernel.org/netdev/net-next/c/7801c42c3bb7
  - [net,v12,04/15] rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
    https://git.kernel.org/netdev/net-next/c/af208f36ae22
  - [net,v12,05/15] afs: Fix afs to abort the rxrpc call on send error
    https://git.kernel.org/netdev/net-next/c/3e6af08a571f
  - [net,v12,06/15] rxrpc: Fix aborting in rxperf test server
    https://git.kernel.org/netdev/net-next/c/7f1592390986
  - [net,v12,07/15] rxrpc: Fix sendmsg length
    https://git.kernel.org/netdev/net-next/c/ef369cacbd52
  - [net,v12,08/15] rxrpc: Fix double IRQ enablement
    https://git.kernel.org/netdev/net-next/c/41eb0af096ba
  - [net,v12,09/15] rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
    https://git.kernel.org/netdev/net-next/c/18a71e111c75
  - [net,v12,10/15] rxrpc: Fix the cleanup of service calls when socket shut down
    (no matching commit)
  - [net,v12,11/15] rxrpc: Fix error handling in rxrpc_send_data()
    (no matching commit)
  - [net,v12,12/15] rxrpc: Fix packet encryption error handling
    (no matching commit)
  - [net,v12,13/15] rxrpc: Fix generation of notifications after call completion
    (no matching commit)
  - [net,v12,14/15] rxrpc: Fix RxGK key parser to check enctype is supported
    (no matching commit)
  - [net,v12,15/15] rxrpc: fix use-after-free in rxrpc_poke_conn()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


