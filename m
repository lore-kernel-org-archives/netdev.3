Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837732C312
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771540199; cv=none; b=plN9d/HFAzYXnY2OCZqrjOQc0ykfzGMqdhyLo92F9h3KA1S8vTorAYOS8egE85RcUgn/Nww/4TZDss3AcU/SQ5D62Q8fdzzcJk0HljcWFvHPnKHqTDrhDNVojZVOYaLUBH2GVrf81XHRLgKi7syETAH6ezlhm2cP6Zho6kZRS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771540199; c=relaxed/simple;
	bh=G2B2zdUYlPI97aigYFbdzXLwUbh0l/nzP3pFgT0pmzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T6Q+uLiGeUQQxLuprdG3WUtqBjGHURwVCVTtq/9VOuYVDCVYHyAKTBgzaIUP9azXtEgq067wac0Q9dd2B7qhWbAgEwo3UPH3DKQh1awtQcNWkDjmeQIwoiRPB7FbfBzheLy7KIiZtlYLu3Ynoni5VelpvNz+nwKI9DagFKe9Dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSVIM9mh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSVIM9mh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D9C2BC87;
	Thu, 19 Feb 2026 22:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771540199;
	bh=G2B2zdUYlPI97aigYFbdzXLwUbh0l/nzP3pFgT0pmzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSVIM9mhCxyIOpI/sVzCgOdhdU7Z+G4TYCp6fyjidDqqmVEHRDrQQSklTtRBG3ndM
	 XPbsgV8HunSZOo32IKp+5s6KUrrepGt3atFIBnDuVaWastIunjs9ffIszkBx+qsxvf
	 TkqjhfjKYM8fUcSP1OLA4y8jcouOYsrMOEKGcr2sRWgujaLpwqzz1SQ7SJ8a0Z/sVt
	 LXpYxW8STj9Umuj/mXRtoiqhNFidBC2xAK2GAOA/gVxaOyN4GDJUFiQ2b2b5KhmP+Z
	 QKeBWclQFPKPQ5mGF06HzZJMhznWXhW6HgrVgngKjjXd5AJpkZ/lAkltHMjXZnQaBu
	 y8VBJsK5XPRqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D363809A87;
	Thu, 19 Feb 2026 22:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix potential race in tcp_v6_syn_recv_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177154020754.115050.16114884600252600916.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 22:30:07 +0000
References: <20260217161205.2079883-1-edumazet@google.com>
In-Reply-To: <20260217161205.2079883-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Feb 2026 16:12:05 +0000 you wrote:
> Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
> is done too late.
> 
> After tcp_v4_syn_recv_sock(), the child socket is already visible
> from TCP ehash table and other cpus might use it.
> 
> Since newinet->pinet6 is still pointing to the listener ipv6_pinfo
> bad things can happen as syzbot found.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix potential race in tcp_v6_syn_recv_sock()
    https://git.kernel.org/netdev/net/c/858d2a4f67ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


