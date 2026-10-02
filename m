Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA830D3E5;
	Fri,  2 Oct 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904014; cv=none; b=L0ZAUoOKhmV5FYujj0zgxKvOLiVkzqMsPTYRkhIQuEMhUuvHTHXcsu9Unaqomk9Dk4GVKCKjp9owJoMbFNGn04EHI/gRL7n+CJc/vaQibh2nITlXiZF0Xhs5UvD+uSRN/LMTU2mmsZtLGnZLGS9oEd/YrTzwAv/hDsN9jkI8DuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904014; c=relaxed/simple;
	bh=7l4R2BwjB8n7rn7KpUWn5b/R/9pqju/c3y1TOfosqh0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GjkAvs+Ywi+/xwyD8o69gQ+6qj4Y1QWulMvggs+tt8okjX0cvoVSAprfTGLc1t1oeS8TYCOeX1+mwILi/G7mrXdVy1FP6z5C/SXhW1grsf3g1eiZr6gslEn3pIjk6GUcbT3K9U6DhGtaUY4FZ64cMqw6LVpfpyGGrb7/GZI4L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbyEbR9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbyEbR9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064B11F00898;
	Fri,  2 Oct 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790904013;
	bh=k/DSnFVf9hfflpuEdb4E3raz91RDs7CHcB9tQOdDCTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lbyEbR9OpykhLK9Z52w+Wcx2jZumFjs9LswjBESnBBbbY1DQeM4DsJZp/wD+1bvp3
	 a+KwGFLncrxuz0dS1eodR1gH13njqvrEqlic//mSPP3Ths+LX8on7Mz0PUh/U0oR/E
	 12dZdgWz593jyr4rUM0MYyvQWjyeMTjFCgSYAWXi/GnXMTj+bp5GPoAurGcI8P1T31
	 bCaGfxYF5Sn6Wc34BfKCkwOPoeVVeBYz0MdIefxe0D1apgHgROsnxJEo+SJPu2L3/p
	 prYTjMZ6SH1SGS1Nr6hztYUSmx/uAzgF2NtKPa+Jwbgf7iOF4qNndNoeW+Gbgjsp++
	 EKH9tWIATH4tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1344381197C;
	Fri,  2 Oct 2026 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] docs: netdev: additional info requirements
 for
 bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090401158.3168550.5697609746965304897.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 01:20:11 +0000
References: <20260930163109.3910509-1-kuba@kernel.org>
In-Reply-To: <20260930163109.3910509-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, nb@tipi-net.de,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 09:31:09 -0700 you wrote:
> Knowing how AI-generated patches were tested would be a great help
> when reviewing them. Explicitly ask people to describe the discovery
> and validation process they followed.
> 
> I posted this as an RFC a while back and there were some concerns
> from developers that it would gum up the process. With Linus's
> recent complaints about the size of our PRs, we really need
> this information. I launched an AI bot which complains if
> people don't explain how bugs were discovered and tested
> (look for netdev-bot+sinfo@kernel.org, s=series info).
> We need to document this requirement.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] docs: netdev: additional info requirements for bug fixes
    https://git.kernel.org/netdev/net-next/c/fe8a42931853

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


