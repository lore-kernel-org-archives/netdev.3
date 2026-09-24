Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6664A4F0D;
	Thu, 24 Sep 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267478; cv=none; b=geHMMHfxkF3FpKO3Ou+0FY51udmNpSOOSYzZEI/YDQppG/tmPwet6ZLmz9srxNKlRhKL8SQSD/ag3euPR6GfW9n5n5KK0rEz3z656Hdtq9StIs00cOM4yNsaVzEfrw2fyLL3kE7WvAtBSYGRuk8HY11nhOWvzcojkqqbn37r7J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267478; c=relaxed/simple;
	bh=hnyGZN0MVA9i3zS9GTrheMiODq9wuUifNqFVs6AZsCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kHQcpQqe5By9twsfdN4g92rELj7uFeaU5J2ThbsBuRHyBIXtxJsuc7AIetvQZmqPRCdn/7XNo3NS7DG0vO9nC8hTYcnR3pEkhjBciJUCVGqhoGRqpMfDIJ+TlpD2eAjE65IJ5sOF+VWrXpUX+9Cj7M3mZqNQOEdm0Z+ZnXV7OCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo0rf0nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo0rf0nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6069D1F000FF;
	Thu, 24 Sep 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267477;
	bh=dhwjLRgB/dNMn7KDb7d2V1FiaAekz3iKKlUNXJG50cU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qo0rf0nmgHbdGVEqzJRjcSR3B+OgdHG0R5YXRDGhNgNRYvksJtfNWCsxdhdW3LC/y
	 voJOqKVDRL9VgrOon612105OvuC1YmvQoLCd2p659720ld4Rv5UA25H8dWW0UKAKbp
	 3PmnCWuSOaLgafmFz403E6+elOoFWaqwwxF5+PC11mDBSsCmtkiC2rbZvTgHlRa/7Z
	 B8UzISfyMPsqpagmr19/Q4Dc3EjFGQxoB2CxExKbeqrzaZjNfjKzY3p25+qJh+ICKb
	 G766WMSUhF2Yuusrjg+RsWfVuiaiC2c4vtQoORq6qoxg778oOoGU8tUIj/I/CLciEm
	 G4QUZTEkGqSzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939943A566CE;
	Thu, 24 Sep 2026 16:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tcp: fix use-after-free of retransmit_skb_hint in
 tcp_send_synack()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026740614.1641283.16358381114334311829.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:30:06 +0000
References: 
 <8a9dff4063a2745653b7e88ceb745d75efa16e68.1790224474.git.yilinzhang@moonshot.ai>
In-Reply-To: 
 <8a9dff4063a2745653b7e88ceb745d75efa16e68.1790224474.git.yilinzhang@moonshot.ai>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 ncardwell@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bug-report@moonshot.ai, shiweiming@moonshot.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 12:49:00 +0800 you wrote:
> When tcp_send_synack() replaces the cloned SYN skb at the head of the
> retransmit queue with a copy, it frees the original with
> tcp_rtx_queue_unlink_and_free() and only repairs tp->highest_sack.
> tp->retransmit_skb_hint keeps pointing at the freed
> skbuff_fclone_cache object.
> 
> The dangling hint is read in tcp_verify_retransmit_hint() and used as
> the root of the rbtree walk in tcp_xmit_retransmit_queue().  An
> unprivileged TFO client (sendmsg(MSG_FASTOPEN)) can arm the hint with
> an attacker-supplied ICMP fragmentation-needed message, after which a
> simultaneous open frees the armed SYN skb:
> 
> [...]

Here is the summary with links:
  - [v2] tcp: fix use-after-free of retransmit_skb_hint in tcp_send_synack()
    https://git.kernel.org/netdev/net/c/fe99bbeee5c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


