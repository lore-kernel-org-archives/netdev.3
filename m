Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D4472556
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663449; cv=none; b=q7EiYk5OSbCx5fOA2byKgsfUFjGfoYAaXs5s02GMke8AbWZV/w3KAnTUqoJzkqZqgVLyc+tEavLRn0BoAM0LhoMTWPsqFVAAHRRIhL/TFaFNSPPrm1OA9UdoIqY3SkBkkVMFi6xWknH0/lwVCF1Z7aCgHvGx9ze9r5/kjyLYS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663449; c=relaxed/simple;
	bh=VKX4l7lrmwYMevUaTSKggBGE1qtpZ4LXhckeTNwNF/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y+2oCTqvFitMbwkJkhrcQA+HnqkYKz+Jvo5i9hBEKYYS18hXSqPUEqHAizCrmykCnIgdsGoFcROPgTlgFaUiGJtEkbwTe4NDeMGlbTvrvjcOQTgAAMibLNYdHuP42AJEJQ/8J8IZpegWNY6dNyTUzdcG0K57H40TfpTKD1YrYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny5vNE1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny5vNE1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241801F000E9;
	Tue, 21 Jul 2026 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663444;
	bh=MdfsmQB6+9OejxXPhy0eW86GFX57lVYNDxXJEE1il7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ny5vNE1UTYzowdpo7lImkQUz42DksYQoT6e7nHFT3BVKRX2iT8oDLPYz/DTJ4olEg
	 V8a+79E9DULWOoHtXVXy4yRYpmgHWMLNTepUf3b44GIV4QXxeveylEc1Qi9XFqG2Er
	 dXKda+O6SRmlx2Pa1qB/FBBxFGpniHz2lb7Cg5DzQRC0SJtL/n6pndmjaUcFXR1HEB
	 NRzZjNGNSTD8os4/bUQAKnCQ/tF0aRFoyv/EBVdRaBKR9ICJrLWRqzcREpAOm+Pjlz
	 N6p70TfRKn/b/s51onolr0G2Sk186w4qBPli7oSC5zd5/b3B3kSZjXM8WISDWAgRTj
	 fiin5wPnIFunw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09CE3926242;
	Tue, 21 Jul 2026 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: yield the CPU while waiting for the adminq
 to
 drain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466341341.1010442.3843988900904755195.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:50:13 +0000
References: <20260714201456.1776153-1-nikhil.rao@amd.com>
In-Reply-To: <20260714201456.1776153-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 20:14:56 +0000 you wrote:
> pdsc_adminq_wait_and_dec_once_unused() busy-waits for adminq_refcnt to
> drop to one:
> 
> 	while (!refcount_dec_if_one(&pdsc->adminq_refcnt))
> 		cpu_relax();
> 
> The refcount is held by pdsc_adminq_post() for the duration of an
> in-flight command, which can wait up to devcmd_timeout seconds
> (PDS_CORE_DEVCMD_TIMEOUT is 5) for the hardware to complete. cpu_relax()
> is not a reschedule point, so on a non-preemptible kernel this loop can
> spin on the CPU for several seconds, starving other tasks on that core.
> 
> [...]

Here is the summary with links:
  - [net] pds_core: yield the CPU while waiting for the adminq to drain
    https://git.kernel.org/netdev/net/c/a11f0b8a2042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


