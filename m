Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FAA35C6BE
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035075; cv=none; b=EpVP7C3TUvdyZyU+tkZ2gXH18doxBfh0NwNmkIjN7QieuZBnbltkLjkqWTJxh1veUaqyHMYMpkflRhtrSSrpnxDtyqDB5frYKU0kuJ1GC7LYUCP3xT+QTRjORgslDgFm78L0brAV0e4fGtCeSSfOZy358SHIvdmPkTQD4sTF5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035075; c=relaxed/simple;
	bh=LGA9Q0CNaz1Zj8YaIZTa6YaXFaRGttuRDrwITf+7oY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NL/Jf5Q6MN+EC7V8uxujtbgaNMvdKz6uvtCdKOkGEShAvmTehbrB0pKo47IxJkF0HxujtUl5bw1MMD9qxULtDbKUANObJdZYxq7Yd8SuxRELJo3n9QczCK9G9ycgfJqRL0UHOvVLEMcKoQrQW7lL+SMlipDV5y+BNSmnj0YoCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmbKSSjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmbKSSjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CCC1F000FF;
	Thu, 10 Sep 2026 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789035068;
	bh=kitfu5LEYnJu7RvhE1IWW2XbP3ZKU/jy9uLq5Ex+piY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dmbKSSjrRyrOaZUdjlob6hMav65apj41Mquzr6Y6FBnLNXOknumMwJMouPSBldN/e
	 TlyocYSd7H2U49IJ69mW+tso+TuTzYRUSs4sJjlTaNNp+UsZFcuzxWqqEjwRqIYJ1W
	 JE6KIMH5hPlyCbIZDTgX1ZH9+I1CjhZuDgrTRQe4/Xr66FzjWWuqSgKyvoL19wUMJG
	 1wk4fnzmuZBIPLD/9ZZRs2p67/6HGqe+gYNlVh5IFmI0xpRTsupn7XrNsT4uEY1xMI
	 M6T5WW4S9TtCdngh5+k5KvUchQNe9PJhzr/Idl6aP3ez5rFtzUCnlXeApi37rml/1x
	 PFc55lLVm8Bbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567EA380CFD6;
	Thu, 10 Sep 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net/sched: cls_api: Don't replay RTM_GETCHAIN in
 tc_ctl_chain().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178903500614.1334538.13024696735558909937.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 10:10:06 +0000
References: <20260908205537.863484-1-kuniyu@google.com>
In-Reply-To: <20260908205537.863484-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gustavo@embeddedor.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 tarasmadan@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  8 Sep 2026 20:55:25 +0000 you wrote:
> If a netlink socket sends RTM_GETCHAIN requests repeatedly
> without recv()ing the responses, tc_ctl_chain() hogs CPU and
> triggers Hung Task splat. [0]
> 
> As caught in the stack trace, netlink_attachskb() could confuse
> tc_ctl_chain() by returning -EAGAIN when the userspace netlink
> socket's receive buffer is full.
> 
> [...]

Here is the summary with links:
  - [v1,net] net/sched: cls_api: Don't replay RTM_GETCHAIN in tc_ctl_chain().
    https://git.kernel.org/netdev/net/c/dff39930ad5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


