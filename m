Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422313CF20C;
	Thu, 24 Sep 2026 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215285; cv=none; b=UjalGl65q1USfUShgqpY38SVy0SKMOxZNJZVcuBj9MdC4pq1/J20NyebyMfCgJ5BqCxFNJmK/bnWb9XcZM4XokC1DfQhE4i+dHVrKFyzsmMBIx9GaHPIZ+5pyBS9ke7Dn2qZvnXb4EXrqVMxsK04mQP8GGCP4zaUwyviKwXiQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215285; c=relaxed/simple;
	bh=gR1OtvQIaidQ5PcbvE8GLL80OTY5WLaEfg9hnNizUss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LF4n31SPxUU4nrqSavA1UmBH+KJYgwIfGk1v9qZhcuEOi+MaVQqt6wHxAEIIaAwszu20hof+QwxohSdxfhAju/2EA7Id85KCyrC0mU6FOraDEVfmKhg5vEJ1dh3fxpt9XUDw9YWPVYLn2pe5bPeP2T62s7s592jD7QcVdWJ9xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8k/AAOW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8k/AAOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F11F000FF;
	Thu, 24 Sep 2026 02:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215283;
	bh=zMFgQZoU+cMQgG0ZwZpmuwa6cPFAqYbYoJClTqTO+1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V8k/AAOWUnsBW9k6DYRK6YSV9jooly6cYLwhSGOw9VjyM/LwduQ3bNytckJPHWHWR
	 Iwlt8qlJd8rsfcQ6Mb2jML+2V5wc/+9yS8j10LpHso4DiDW5RJl4WLvgPiQGG7LV62
	 nfCiZi6RSV3KlNUOlEzTorOFq1CaOexTQe/1Ty9popAHmXk+Qpe+EJKauFbrZzBtG0
	 gAm++T5fuEJSC7nB5weBpzYbQ69ewSQkR/Han3i2AjrqzRKENUvkG18h3kP36TWNEy
	 znLMmlAHfwK1ipCiKuRawBK3+IAUifFmlkTLWNActImT9EZdzExHtII1Pb/4ErXazG
	 yOTjQhrtNC1WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C1739E9611;
	Thu, 24 Sep 2026 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs: ABI: OCP TimeCard: use literal blocks for commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021521313.1274904.2314460885871180013.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:00:13 +0000
References: <20260921044830.95981-1-rdunlap@infradead.org>
In-Reply-To: <20260921044830.95981-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 jonathan.lemon@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 21:48:30 -0700 you wrote:
> Use literal blocks for 'echo' commands to separate them from
> the surrounding text. Otherwise the lines run together, without any
> clear break before or after the commands.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - docs: ABI: OCP TimeCard: use literal blocks for commands
    https://git.kernel.org/netdev/net-next/c/dbb8d2dc0d2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


