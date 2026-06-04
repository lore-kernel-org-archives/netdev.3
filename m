Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDF356765;
	Thu,  4 Jun 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587612; cv=none; b=ZqveKE550+XqN4CXUHS4RzqQWvyQGSL/K0Wf1MKgUPDGW+giECBVTqelOzRph5eXHiuSeKH9eojpur11fWcXrArkFS+Hw/b5nAUrq10NuvgG4Xsf6hGyk0d1fpaPlCHSh+YKfUcnXOwTUWq6W1itXmzZVNqWPKUg7sU2qads8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587612; c=relaxed/simple;
	bh=I+zXD3fCsou6wp205kAa2H7w5pkxVHw6Gc5PQPzJJ/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PlzZS8SDhys8xuEUo+4KSxU6n2I+5jyr8bdqdZJ0e+BcMDHcR9pmXx47lZiRRONjJck+loCOz9EB/PG2VVye0hmqqTe6A3T1FCe4yu2CxXDMjllcCm4fio3CBB+P5guPLokrLKEbEhiQawRKvfBPsgdGqqiCmZdhdbi+T2UekT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iykPeG/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iykPeG/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EB91F00893;
	Thu,  4 Jun 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587609;
	bh=nNvEQY7/ZanMRiYKcGjHR08scMy0tMkJfWg1swlQF3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iykPeG/dx49r+oBr2Q69SXiT7xB3uA5oAJzYci4zAzPZUQ1+xFedQ396JvAm0RaSi
	 9MD6jzGiJe5lAlcJeaaGJfZJmjOEigQrwk8WAib1LL6sG5+NRQnrwblIyGUXeKrEhQ
	 cgXgQ8YMK51NGZhMYiDrumh8jsfGbeNKfgdQf8Z86wqoq083EoVTVN8SLYJV/xd4bp
	 ZV7fe6pwVV4ctKxu6AigpbTfj2a7RBlhfMk7B1/pyPKjEdnL6MJZzpU1Vp9XKqM7wT
	 6fhkkfGf/mxQ922gWo1ttxiX04+auZ+85y6i28IgHL/GEGj/rPaQhml6fXgA0N9kE3
	 919bqd3NaQ9PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2E39309B7;
	Thu,  4 Jun 2026 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page
 cache corruption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058760965.2484354.17011007371452142706.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:40:09 +0000
References: <20260531123221.48732-1-jhs@mojatatu.com>
In-Reply-To: <20260531123221.48732-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com,
 toke@redhat.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org, rajat.gupta@oss.qualcomm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 May 2026 08:32:21 -0400 you wrote:
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> 
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/1] net/sched: fix pedit partial COW leading to page cache corruption
    https://git.kernel.org/netdev/net/c/899ee91156e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


