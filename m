Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999E2EA47C;
	Sun, 19 Jul 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784495334; cv=none; b=nE3koVLYzKGadhAAKM10+gcMleSbRPknIswtVBbEdyqA8NeVzqjr3PiqW1g4uSZiEIifx7iVUtryb/LsqTLYy4KSCFpe8j3kmztRKqwlB5zT7bGnYqZnEz+VTaBElUFKhPYnuXrzJFOyz4JuzeXGUGeAJI9nbKvmOCrhcofeKm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784495334; c=relaxed/simple;
	bh=pxeRFVfDnpjbR2YwV92AOsp9ntT0SYj7sA4163+x/2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VsGYuN4ksr6jrW3CqHXnTq/h5JjBUo1eqc5zaUE/OYNwYfBF3pGajMSYVoXqWPdemcM8mIq2paK9XDnFTJBYfZbKdMatty2zWG7ZctPIbLy2DLkVIUAVEtdOjc9QSdsXDG9bNR7GnEi9MYftN4KrLyOfAd5reMtXjcsJMdRsFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThDHQ5Gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThDHQ5Gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0371F000E9;
	Sun, 19 Jul 2026 21:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784495333;
	bh=RICOYpYnUCJR+OAva7YtqDo1loJi8r47nVPTIDq+ptk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ThDHQ5GiMffGprzzgv6W9x0ORehZjkwMC7PxmQxdlJ4uhYytKlj8Yx4WLyjNC4ABM
	 92SRuMExLYy9dHhZ7ROBTC9lJyOQer8C9zXlZdKYLP12o53qj7EP6O3mhPkYvEZevM
	 4fXmuSrYQYz6LssSlnFbEpHSKdUslHaDS7BG8qkqvCrz5dWong1apnnSsfrqtMl4i/
	 5SBwOkBduYm1X3LUX59ke6b/vPZkVT7LQn17K24wFawLI7vRcj68k/kGjYNV9soooB
	 vmFBHR8R6AvGLeqe+XB8fdF2akxG0lljBYK2u62W3ONzGE0A6c7SyvfEBtLN06Z4Bk
	 cHPve4Bskiddg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1984F38119CA;
	Sun, 19 Jul 2026 21:08:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v7.2-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178449530364.2815364.3299739421604955970.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jul 2026 21:08:23 +0000
References: <20260717132610.363857-1-pabeni@redhat.com>
In-Reply-To: <20260717132610.363857-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 17 Jul 2026 15:26:10 +0200 you wrote:
> Hi Linus!
> 
> This is one day later than usual, due to concurrent conferences. For
> the same reason it's also dominated by subsystem PRs. Still for the
> same reason, the next week's PR is expected to be larger than usual.
> 
> The following changes since commit 2c7c88a412aa6d09cd04b414211b4ef8553b5309:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v7.2-rc4
    https://git.kernel.org/bpf/bpf/c/e13caf1c2658

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


