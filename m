Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968A2773CA;
	Sat, 27 Jun 2026 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525640; cv=none; b=qsbdNPlqezXyF2fY0RrwcMlbNzkD4E2wRj5W4CIXctAAZr3pe2cBk4jITlnfLsu8pL9HHUOjZUGsKsbZGra1KAEKAUJ/jZp1SvpNyFivEZ9sHhMkD0qLdxPdVkLkzWoGND3hNMcMDzg0rS+LatpAOO58CkP3pubWcOaD4rVzDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525640; c=relaxed/simple;
	bh=aBu7WwNSA106j04af2V3nMVbhEprCuCy37bfeSUemCA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ptZ49++rTu3DbZcLDAwtix72vujJRv77khkoyz/f6V1g9VB9T8YIIJqLhApO8TKgEgH3t602ZvHBb3uRDsDSE05DK/ncoLoy2Qc25RdUf7M2xNAozU3eGViQNesW8z6ep+DJMACvN7uA8Wgxatr83GdTk6LQptQ4Sq7MIuT6YBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyGFd9SX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyGFd9SX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35501F000E9;
	Sat, 27 Jun 2026 02:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525638;
	bh=4yHdHGfkrZLSnwfN25jAjiOc+CedmjCoRZsVINi5sNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UyGFd9SX/qOM10FK3ksdjzHPgYYDJ3r6uWWjT+yb/bUXEPRJW4lQyQV7dSMkivcDP
	 rXxUwf28Fn+7lotYbz1/sVKywCrnOODUYayjp4EW36/IK6x+nXVEUfHHljbdn6iHUM
	 oZfKxLVYpN3pcbCMF03Ym3Ibls5fVi0R897oveA7XDdgwdoSAWIm67gcNufO6Gk8bG
	 wKsWebiKy9yTS5Sv89SHHztGSFAb8Hf+iJ/xf5EE6LgAceVCl+RrQtJHjReteZsJDN
	 uqZAdcRNqgsMj1ln+I3rtKMUThgp566yL8lGmVX4Y9KN7LkPNSJ7lPfXlPhKTV3/Mv
	 rmRpgnbzWIVjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A73938C76;
	Sat, 27 Jun 2026 02:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] net/sched: finish the qdisc_dequeue_peeked conversion
 (taprio, multiq)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252562506.1167656.8248831428302845030.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 02:00:25 +0000
References: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
In-Reply-To: <20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: vinicius.gomes@intel.com, pabeni@redhat.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, netdev@vger.kernel.org, jarkao2@gmail.com,
 vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 04:51:18 -0500 you wrote:
> Commit 77be155cba4e added peek emulation: a non-work-conserving qdisc's
> ->peek dequeues one skb and stashes it in the child's gso_skb. A parent
> that peeks such a child must then take the packet with
> qdisc_dequeue_peeked(), not a direct ->dequeue(), or the stashed skb is
> bypassed and the child's qlen/backlog desync. sch_red and sch_sfb were
> just fixed for this; taprio and multiq still take the direct path.
> 
> [...]

Here is the summary with links:
  - [1/2] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
    https://git.kernel.org/netdev/net/c/e056e1dfcddc
  - [2/2] net/sched: sch_multiq: Replace direct dequeue call with peek and qdisc_dequeue_peeked
    https://git.kernel.org/netdev/net/c/54f6b0c843e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


