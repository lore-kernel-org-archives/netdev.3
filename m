Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4653B42F4
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553614; cv=none; b=TMEmq2twGPHEcHv5LI6Mdqr9JiNCyr7t//MrBwdsBfb25zKrOIqufuErgk+qcPImNEuS2xcITCa8yYXBRLUIZo/Q5X5VWbzGjHz0ifDdSxK9ET546P5DJul1AfbRsBGsebOQC2UOVL/5e9Dc4MAVXhNPcsLWDH5VLSbIGzWv810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553614; c=relaxed/simple;
	bh=qKfooVQO5FAQ2uKaXdb45oaw4bztcgFjZ/m6GeHu9lY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H/7NoHQgM2RSeMSQfBHueIAidQY2SuT+2f6gwA+abGJTOpDjZ6HbEdYHNMcDoo2Mj0qn0K0MrFelk/PkpN1Lw08/c/lp4L71PSsTpmMP0Io08y/gEVkoHICdNhRPlP7G7tZBzb/UrxjxUyozPckNy901tRGGPy1gwCgUvmOa3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrOnm/6K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrOnm/6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BFF1F000E9;
	Mon, 15 Jun 2026 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553613;
	bh=cQwH9sD+aVZcat2wfR27rUr5vgLOt64pW/pgqA4vdEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WrOnm/6Kj7o9EWDnV9i4JJi8M/1HFlwWy+L/I0LKr9j4NsujvTkKjixDxjiRXDYep
	 IPfGZAJAuvnWWUwtk3zKyUsOKkJ88/8TnP5GNPZ0R9IoHdR2lraYf7miyXsfwolZrn
	 HeN3HHhz7deMYqvO6H29ZGoyXNF6U5xSrlY7q1QWk747hoXw21i8rhJaLzt1tUYl5k
	 VZexGLlfD97qAoNmmmXxxzjQn6vihtSPGTXuiQ4ecLOc8x0Z5ZVPpIplohuMVrmhba
	 vFWv5aeLswMccqYJ+IKN1FNahJSmxxXanQumU/8cJJADcwr2bDh+7gN/yP3niFvFIt
	 LpAw5KTL+QLfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688C3839A06;
	Mon, 15 Jun 2026 20:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155360788.272818.6185540664390740665.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:00:07 +0000
References: <20260612135949.4010482-1-edumazet@google.com>
In-Reply-To: <20260612135949.4010482-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com, jmaloy@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 13:59:49 +0000 you wrote:
> Syzbot reported a slab-use-after-free in ipvlan_hard_header() when
> called from tipc_l2_send_msg().
> 
> The root cause is that tipc_disable_l2_media() calls synchronize_net()
> while b->media_ptr is still valid. This allows concurrent RCU readers
> to obtain the device pointer after synchronize_net() has finished.
> The pointer is cleared later in bearer_disable(), but without any
> subsequent synchronization, allowing the device to be freed while
> still in use by readers.
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix UAF in tipc_l2_send_msg()
    https://git.kernel.org/netdev/net/c/f4c3d89fc986

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


