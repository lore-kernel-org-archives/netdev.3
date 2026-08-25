Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEA38B7D8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649062; cv=none; b=DffH4nIu64b3Nm7saeLL32rOZi/IONCnpBGaSI9z80yTjPeOokLOHax7FXQlsrrJAa6FaVJ7fFs5ebaDx2i4qikyN2WxJe0Lvc35rLgecx2ovdQmsGI+VJXr+FZWjOQWR61BPSAWDCRZrMbAld9pfm0BKbigqYSkBeYsxc5vwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649062; c=relaxed/simple;
	bh=PnnXgjK6/rW+GzrsrMJ82tEY0/295tiZvop168/OpM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sOFYdrm48f/3VCd1v0+KS17Zxww3YFuquEJVoWKltOq2acMcFi7MFVJev8UowJU+M9jMhTuqqPnQWX9uJnnIEyGNYMtPDpIyyjZf6MWkjaKHoWwQG+mjwuc8CO/x33nBIoNrjk80BXYRNya3nMKvJCF+NMHjZ4oO61zJl0NUqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIHy932I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIHy932I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4791F000E9;
	Tue, 25 Aug 2026 09:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787649061;
	bh=HRHOgo/vsxDhOB4xFQGCOZPb4xogO2S0U40uU4/ZxF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UIHy932IBLMe/aYX+FOmotgknFHcevrAxy1b2OLJgnIGF2vgilGec+ud3EBPXdGT+
	 bmFr13b1u2OJDUvhkf260NVBZp0OHKV+xQHfPVA90DRTT8VmKB++FPxL9DwlQECK3G
	 +N6MkJGnPG6sOXDbq6IGx1IcoNckWQtefTOtG5aqzHs+7eR/zP2MJGbK5kZD1Fu9J6
	 NJumLOPP565rYkDUXtElGxRDP8T4nccmLgvCOPXBnsml5oFHsAKMsx7k7Lns19cdUi
	 lc6etXtmwRPpAdZdpev5EBbIsPKRRQHXW9jjz5nYLQ0NaZC18ImLB4nURPefcQZUNn
	 xdOKeWquDW6Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569583924A77;
	Tue, 25 Aug 2026 09:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_skbmod: fix length calculations and
 avoid
 invalid header warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178764900791.3343118.3927543249997179778.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 09:10:07 +0000
References: <20260823182241.1958695-1-edumazet@google.com>
In-Reply-To: <20260823182241.1958695-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1d56f14f95c0480cfdc9@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Aug 2026 18:22:41 +0000 you wrote:
> syzbot reported a warning in skb_network_header_len() triggered
> by tcf_skbmod_act():
> 
>   !skb_transport_header_was_set(skb)
>   WARNING: CPU: 0 PID: 14949 at include/linux/skbuff.h:3243 skb_network_header_len include/linux/skbuff.h:3243 [inline]
>   WARNING: CPU: 0 PID: 14949 at net/sched/act_skbmod.c:55 tcf_skbmod_act+0xfe8/0x1810 net/sched/act_skbmod.c:55
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_skbmod: fix length calculations and avoid invalid header warnings
    https://git.kernel.org/netdev/net/c/81d0d1e64f30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


