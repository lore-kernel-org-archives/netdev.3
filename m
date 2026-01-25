Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938330DECA
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378422; cv=none; b=GSSVwK7S55P3RSPeGEZjITxdvtayXcMAPoU24ftKIC+AWXADaqapPCmtbGlFfcSKJK6t7Hb2dcSMdqp7UFK1u3dTNW+Z7W6PyKeyMVwZx7gFALLR7WIhh8lxK5g5XzExTV4x2x+6vSvtK5q3bWwKmtvhxAO5xGCdHUUrt+DXP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378422; c=relaxed/simple;
	bh=HW27MiLOK32VYImUOyr69ibGMQRFMFLaAqVhp3/X02U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FELJBZTJXJzC14fMx10d7/bZh7yV824RRqJO5Z8qEaQfyB8/TFReuH6ArWqqjGNMWR53tcZuYlT6cnLIozhiwE7xISBqNjqmy/jNI86whRh5MtEhPjPB5E0NIt+d53RTwzNr6EAutWpzP5qgnvaLbVOKlPxu958DrfmqNMnmRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLKF1uSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLKF1uSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79337C4CEF1;
	Sun, 25 Jan 2026 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769378422;
	bh=HW27MiLOK32VYImUOyr69ibGMQRFMFLaAqVhp3/X02U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLKF1uSefMZh9j7Jij96B/nmIhnvmdMH+9O2Q3nw6c6O28xuezbnXti/WCi0q8aTe
	 7MDabxaWdLS7+AUzPnqj9jAiQ/T/4PZwtMDDtgWSHEJ+UmLSQ6JxwZKqaYjJFRYl4M
	 f9x2JAOaDkKAqr1eDOGcjsNhAKEvsmYR5MedKAe/AZmyUQ6e5B3jWSZbdFbH8IV97W
	 0beekuyV7CfSXpQ+I4QfSkFj7+47x6PF7SKXFo+vdDPCpQAu9R0mHjE82yHazNNw49
	 IukR0EfRZfPkzAcSmiTi6x1HIQJR06HultSM2qgvN0pDSINbzYGHar7tuNdAuNTy/a
	 rdeCvOUFMpQlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBDF3809A15;
	Sun, 25 Jan 2026 22:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937841734.3595884.16457045561284953326.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 22:00:17 +0000
References: <20260122190349.2771064-1-edumazet@google.com>
In-Reply-To: <20260122190349.2771064-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 19:03:49 +0000 you wrote:
> NETDEV_RSS_KEY_LEN has been set to 52 bytes in 2014, until now.
> 
> Jakub suggested we bump the size to 128 bytes or more.
> 
> Some drivers (like idpf) were already working around the core limit.
> 
> Since this change might cause some issues in admin scripts,
> bump it directly to 256 in one go.
> 
> [...]

Here is the summary with links:
  - [net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
    https://git.kernel.org/netdev/net-next/c/37b0ea8fef56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


