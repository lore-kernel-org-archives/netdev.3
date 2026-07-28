Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258E41DDE0;
	Tue, 28 Jul 2026 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230442; cv=none; b=AJyg4Fb7tXNzmoRqR1Zfyhi9On00UreOj4Wvn0aPv0ly6rn/vj5p+KpmIgh//bveLDSlcZdY5flhvG4iHa7C5gzcPHKpbqMbKUityX8vPL6ANK5G9DimQUDqo5X7cEV5a3Uk37SluUIxIkZQMyjQVADEfhUHBeEEi1fwDrFClOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230442; c=relaxed/simple;
	bh=28JokKU5qqwzlj3Un3l6+Pn2NEWl9WIOU37zcYHwa2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URFi3epVrBQqydN9Ed3PGZC325Xmoc/gjVB0hXU0NE40Ye52m0i564NKimzkSEPHju8Jz8+eJKffi8V3Vn6XaL1pbc3Z/aXnVH0wwc/DIg3gDPbjZGx1Rf6QgTtyPB+60Ah43LgF9YScDptWb9PXwMW9BknwMKmMPqVeIQ2Xm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwuPYvQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwuPYvQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA9A1F000E9;
	Tue, 28 Jul 2026 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230441;
	bh=Hu62MNKZpbsNXanpNLePFFWON/P2hRUPlcXPYCIR61k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XwuPYvQ3wDNH7h43Bh4vee+2c25EDTKNygW5kImGj20h7gm4l+KIYUisOMwDPQqxu
	 Lf1VCSJ6V9nyiwKDbphG55V0E57UwugwBpcSWA59OT26/529n90phxkosez+pZSvix
	 mc6ZX/DZtGdZJNQAVNa9S3FuFBmj0hBKXctj9He1xmUMCtGsjn0wIwGT/1a/SePkIt
	 iTxgkPhHatfZG8nvThDXZvwIgKBmxPBLyjSD1qxqRYhqFwwgUXNKIDqFh3uS+dWhOy
	 ffIZEvCyuFD/xJRgl1NQT7nJYg1iodHaEwKIh8jsCAfTPv2f8aw5wsJYgKDeUmbiAm
	 yinddQFN1GjrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19840380CFE4;
	Tue, 28 Jul 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mpls: initialize rtm_tos in mpls_getroute()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178523040571.1637186.17942747370476390134.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 09:20:05 +0000
References: <20260723010830.289917-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20260723010830.289917-1-yhlee@isslab.korea.ac.kr>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, roopa@nvidia.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Jul 2026 10:08:29 +0900 you wrote:
> mpls_getroute() builds the RTM_NEWROUTE reply to an RTM_GETROUTE
> request by filling a struct rtmsg allocated from an skb whose data
> area is not zeroed (alloc_skb(NLMSG_GOODSIZE, ...)). It sets every
> field of the header except rtm_tos:
> 
> 	r = nlmsg_data(nlh);
> 	r->rtm_family	 = AF_MPLS;
> 	r->rtm_dst_len	= 20;
> 	r->rtm_src_len	= 0;
> 	r->rtm_table	= RT_TABLE_MAIN;
> 	r->rtm_type	= RTN_UNICAST;
> 	r->rtm_scope	= RT_SCOPE_UNIVERSE;
> 	r->rtm_protocol = rt->rt_protocol;
> 	r->rtm_flags	= 0;
> 
> [...]

Here is the summary with links:
  - [net] net: mpls: initialize rtm_tos in mpls_getroute()
    https://git.kernel.org/netdev/net/c/295dd295e213

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


