Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E922D781B
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883816; cv=none; b=T28ScOhI5aXOB+zcSyMZ0WZD/+6lb25xf2Yg4+9FkzEtuBhPwkbgnjazub+O+qAFvCaJmpXkSsGjl3KlNSKbAFYpJwIEBAqEMHu8SlPNby9JhKeyoD2vNp+eJoSyubSWQGT/rnC+fnZjtN2+cLQd6p3R93AsNaPeTMXNGX7OqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883816; c=relaxed/simple;
	bh=Br6U2Zp74tILjMB1uCYlV5K9Skk0l/e9eGDGw0mDGJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uSBKT0sdprhWvgv5buk9e6kYQ9U2//xq9A+v84pfSryckCLN7BkrejSj0c6hJZKRLPVuBKv03tkCK1usqhHnL6DJoAliD0MgiwVvAzOVghIKOYotpptBVKD0o5KEMv4Kp65ImObbVtTqFqdqcE6/ksK6C1a4fLqdCfbspQ1Psk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcQQUNBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcQQUNBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27357C19421;
	Thu, 19 Mar 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773883816;
	bh=Br6U2Zp74tILjMB1uCYlV5K9Skk0l/e9eGDGw0mDGJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CcQQUNByHfzwX+1EeIvT4m1ZZZZ9W435ShmXJPy4jPFqnt9wTBaWVfhwu3vlNxYc+
	 BsRbKhZPHXapNtns/HCXw2BDU6SSh/PmRi48C/YqIpxEvTnoVU5coO2aPXdhbbB5IL
	 mlHxwOg0u67xteIiGvUfgMKzHKcmQBQXdI+spO0QmNYJAhylaclWQU2rUG/CGp2lUE
	 fJisyREpZWT91O2VnVajFllAxF3euQnWubXkDob5xMTesbyBABSzXMNPF/fZPIx00z
	 IcnIlGDGU2kodi4fhNrzePsdQ6pquQoUbdMwclO0lYeB8EBiRgBiqcVxk/blCVcCCv
	 291AJCw4rOBnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA13808200;
	Thu, 19 Mar 2026 01:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] udp_tunnel: fix NULL deref caused by
 udp_sock_create6
 when CONFIG_IPV6=n
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388380728.978731.6249220360238543970.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 01:30:07 +0000
References: <20260317010241.1893893-1-xmei5@asu.edu>
In-Reply-To: <20260317010241.1893893-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 18:02:41 -0700 you wrote:
> When CONFIG_IPV6 is disabled, the udp_sock_create6() function returns 0
> (success) without actually creating a socket. Callers such as
> fou_create() then proceed to dereference the uninitialized socket
> pointer, resulting in a NULL pointer dereference.
> 
> The captured NULL deref crash:
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   RIP: 0010:fou_nl_add_doit (net/ipv4/fou_core.c:590 net/ipv4/fou_core.c:764)
>   [...]
>   Call Trace:
>     <TASK>
>     genl_family_rcv_msg_doit.constprop.0 (net/netlink/genetlink.c:1114)
>     genl_rcv_msg (net/netlink/genetlink.c:1194 net/netlink/genetlink.c:1209)
>     [...]
>     netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>     genl_rcv (net/netlink/genetlink.c:1219)
>     netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1344)
>     netlink_sendmsg (net/netlink/af_netlink.c:1894)
>     __sock_sendmsg (net/socket.c:727 (discriminator 1) net/socket.c:742 (discriminator 1))
>     __sys_sendto (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) net/socket.c:2183 (discriminator 1))
>     __x64_sys_sendto (net/socket.c:2213 (discriminator 1) net/socket.c:2209 (discriminator 1) net/socket.c:2209 (discriminator 1))
>     do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
>     entry_SYSCALL_64_after_hwframe (net/arch/x86/entry/entry_64.S:130)
> 
> [...]

Here is the summary with links:
  - [net,v2] udp_tunnel: fix NULL deref caused by udp_sock_create6 when CONFIG_IPV6=n
    https://git.kernel.org/netdev/net/c/b3a6df291fec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


