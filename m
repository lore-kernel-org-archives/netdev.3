Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E921352C42
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963240; cv=none; b=tq0BW/LJruScwLZayeuvheIDHsyptIg142OzQSzzjZFCIr3e0Ud/mGME+J2CeyUdQrsntFNClU/LsEKiqkMfqOhDC7MkmqTCaKyhnG0yWF2NOkdikROvfL1cRjxAq5aYiDp8KPu5nlIExaRLrglhmAb+r82UGK0Gji3e7yTHjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963240; c=relaxed/simple;
	bh=zM2iBnDTZM5SSzR6cRKu3KJN65KoLyl4NSwpXjdYTfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z6Kf2l9w9HJMyB4zoxd5Fhu+cNOaaLrBXzO9q/ir+06Ph0BEZuh6qIk7vSzQqjiKRKDeVbkuzSOjEuNTdsdcQa8Vv0qaExo0nvwUEkSveQdaKl695uvGUtgPdSq6GOYI53JBrlZPPgZ816Njj9xMeZ+kdw+3Mkd4y/Ef0bghF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdFqhQZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdFqhQZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE2AC16AAE;
	Wed, 21 Jan 2026 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963240;
	bh=zM2iBnDTZM5SSzR6cRKu3KJN65KoLyl4NSwpXjdYTfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CdFqhQZnWWhxBu+Wy1D0ArwUam0Jq/QzBO/JvthTQaDA6XDqylXjkWgRhqqGO3Om8
	 PTBB9Hq++tvGTotJVTGHZxigMCW343eUEmiynxTnmIAF+5Jat8JW4GGaNhA8Hl51oX
	 NtG9c/nj5Zfxj7Uu4eyXZ/9RlRrx1auV55fh+zEgajGRMy1ipczYiYNRLB1kCzeygW
	 rApgaJCATB9zFOO+FNAmP8PYkpkGjwoXx/Ob1O7oVCCE2C2LnGhlDH4zoI4qht9PHN
	 rVJM71rgZzRMlVXcHC/amSd2JE00tEZlhcRpfdZ41goLRdA/X9f82uo9QsXa6jLZEO
	 JgGZN4DzHV3fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B4F380820D;
	Wed, 21 Jan 2026 02:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fclone allocation small optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896323784.699622.137012293284778508.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:37 +0000
References: <20260116164402.1872649-1-edumazet@google.com>
In-Reply-To: <20260116164402.1872649-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 16:44:02 +0000 you wrote:
> After skb allocation, initial skb->fclone value is 0 (SKB_FCLONE_UNAVAILABLE)
> 
> We can replace one RMW sequence with a single OR instruction.
> 
> 	movzbl 0x7e(%r13),%eax // skb->fclone = SKB_FCLONE_ORIG;
> 	and    $0xf3,%al
> 	or     $0x4,%al
> 	mov    %al,0x7e(%r13)
> ->
> 	or     $0x4,0x7e(%r13) // skb->fclone |= SKB_FCLONE_ORIG;
> 
> [...]

Here is the summary with links:
  - [net-next] net: fclone allocation small optimization
    https://git.kernel.org/netdev/net-next/c/79bfa5fb8587

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


