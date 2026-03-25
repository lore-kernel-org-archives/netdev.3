Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140C23BF9B;
	Wed, 25 Mar 2026 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411820; cv=none; b=Omz6XUEcBUa1bA7YbcOAHdZMHi0K5HLiOCbfUDnlinKHs/S6zGOojaMVNfzeU/3k23vXM/Xks+iHvVrGZxNx9hb01MmcebtKgNEqBYiJQ/xVWebiTihjoBVOPjxh7RXvejX+1mbqaBEJbjNZGrL9O1W2LJHfiT8BABzS3E6tk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411820; c=relaxed/simple;
	bh=YVVJrC6lw4JgBCw4Kxevuq5mZKtsANAXjEOqe+5DUMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KWDGAIlcmeQzu5om+jLy4Wr4AFxFxNxxqDYTh/aYgf6lw0tTp01BOX+bHvrpoY603jMWAymsBpqy5sbwdiKXOVYq4W5jkRVEc59jfwf73CtfBXpLxY3u63Doq63klLJ0vmz7V8kL0Rzd3VZNTRkIxcuBqTX3Y0coyFetdTxnjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OORmGIY0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OORmGIY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE00FC4CEF7;
	Wed, 25 Mar 2026 04:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411819;
	bh=YVVJrC6lw4JgBCw4Kxevuq5mZKtsANAXjEOqe+5DUMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OORmGIY0qBkkhwJtsQwAn6CqXIvGRsHLzSVUUPHUsc8+ISiChQHf/BHeb6ciWZcUl
	 F4aFXlOoEWAhWEzlJ248ELkc92MVbAW8qjxbYq73Eg8wRoE4tvAzQLIRBdiSSlQqq7
	 PTQX/i9l0LT57P4G7Tt5iIfqcC5hx7mFfcJhAuHq6QtUx9Y7BZwTPDcPgYC7r449Vf
	 8iR8zKedf6KuSFpxh3GZ0h6sMDpVIK8BnfFFymKV7gUoqYP227cI8gL18YolvwK8Xs
	 KrIDmJsOL0M+hdghivAZ9Oq/5i73lFBDatZsQ1TrEM/AkZA/0QvKsd3UcadQV7ASRo
	 KseSYZilZU3qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D4113808203;
	Wed, 25 Mar 2026 04:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net_sched: codel: fix stale state for empty flows in
 fq_codel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441180729.1422230.5368917976493908584.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 04:10:07 +0000
References: <20260323174920.253526-1-hawk@kernel.org>
In-Reply-To: <20260323174920.253526-1-hawk@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 j.koeppeler@tu-berlin.de, carges@cloudflare.com, toke@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 18:49:20 +0100 you wrote:
> From: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> 
> When codel_dequeue() finds an empty queue, it resets vars->dropping
> but does not reset vars->first_above_time.  The reference CoDel
> algorithm (Nichols & Jacobson, ACM Queue 2012) resets both:
> 
>   dodeque_result codel_queue_t::dodeque(time_t now) {
>       ...
>       if (r.p == NULL) {
>           first_above_time = 0;   // <-- Linux omits this
>       }
>       ...
>   }
> 
> [...]

Here is the summary with links:
  - net_sched: codel: fix stale state for empty flows in fq_codel
    https://git.kernel.org/netdev/net/c/815980fe6dbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


