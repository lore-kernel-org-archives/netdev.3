Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56330DD2A;
	Wed, 27 May 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846601; cv=none; b=qdfHtgvQ6S3mliwNx/nj8xAjh65sBzM56j3JXetA7uV0bpLznoBOwTZtDz3Pyv9McAff2G7RQYB4aFa9LZtrsYBSkSqobHabX7W5U9RMf9loNBqQ6EI91vJg90KrO5OO7fsg8wvpp15WiTPMoPzY62P3sJBjNvELxMVwTAl/j8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846601; c=relaxed/simple;
	bh=otpe+9lEnw4qI8g6ZREJHsg1x9eCmYzmWLjkFoSjvwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iM+fomQIvaUh/oXjcNvqDFdkuJoUqKT/nZR1D/mETEjtp8ahfBT27ol1Er3WW/jVWlS3XlLJCH585DioN4yOmZH4SeGVzvn9BRxF7mWHxinrHUNOJW//9p9pa9trJqHTM3w1kx2Y05qHTHlUqJZZtux7EvtMKm9+6gegHlgHOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/J6fnbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/J6fnbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8F81F000E9;
	Wed, 27 May 2026 01:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779846600;
	bh=iU836e323LRcOajOykaTp25SDqaHWb8OLOitpaKAM2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b/J6fnbJ3koUU8FVvMw1glRInYQLZgjRHXmBqPbJb20euXMNCzdgDA1lVB721eM7R
	 RVFcIsM+idAD/8E65Qv6RjtBnC/s+mHI/THsZ9Ui+5H86ktlQQGdpZfebegwzIe1dF
	 agIyLs3FOUqjZs12oYVY/0ap3B6oHhcLcKvs27FzHivkGuUFSOeJng3saFpr6PkuOd
	 yw5Kb+YEudB7Ya0uFEKj6O79Pq2YlIO/q81v1T2jLjCFuzpSSkIXUKWx1scJAxm12L
	 zb8t7hEaLOPXTP6fzy1wIGgNXFXg5ue7OrJePs5aSshjJAss86pDYScexGfFE14WJZ
	 TP3L2J+kpbgCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BB1380CEED;
	Wed, 27 May 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] net: hsr: require valid EOT supervision TLV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984660589.4046339.17294163717293714058.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:50:05 +0000
References: <20260523130420.62144-1-luka.gejak@linux.dev>
In-Reply-To: <20260523130420.62144-1-luka.gejak@linux.dev>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 15:04:20 +0200 you wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> Supervision frames are only valid if terminated with a zero-length EOT
> TLV. The current check fails to reject non-EOT entries as the terminal
> TLV, potentially allowing malformed supervision traffic.
> 
> Fix this by strictly requiring the terminal TLV to be HSR_TLV_EOT with
> a length of zero.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] net: hsr: require valid EOT supervision TLV
    https://git.kernel.org/netdev/net-next/c/46d111a3ef3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


