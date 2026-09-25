Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF650C28C;
	Fri, 25 Sep 2026 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379678; cv=none; b=ZHz5FEdUSxzX8KkEttK2PgJXJqqItysdzvD+EHQ4kkfwR+tYWELPM7ICvcb3SXpFAuV083CE1F+FjMc00kB4qjG1wTpiRgkoh5AnJ2U5n7p5DZWY+S4Ue5kseT+kphfR+uFWPoGzVXaVvz8zhuhP98tKDGCf/ZiCID7f1ZTbVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379678; c=relaxed/simple;
	bh=6CdhQVFmF/dZ4Ucu1U6vxKEJWpmsCASOOZKzUt4Ye/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDZUFUEiaGoG8U1WHPFP3O3++MlJ4XmZh7/H0XJlFyUNUMuooyo9AhG2yD5hUwdWRHz/5mvuyLy9ez3xOc6k9hSV8p5UQy/IPe0UpAi00VbQPEqB06toGxMY5KkzjNkAsKBv4Z3lBdKGA2eoT2SXcVDib69P2SGrQ/XFTaaZnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxhb9QCS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxhb9QCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62071F000FF;
	Fri, 25 Sep 2026 23:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379676;
	bh=7fSKzAttTvMTl4wo0UZcF+j/vO3XY9jR+4L6IHE53m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nxhb9QCShq8RFATeNl5t+wfq0fgDaegHpUjrgtZntZ/O/OMEgn1cixfV+xDgjbqBw
	 rXbDhEssZpYn0D8iN8Lyn+2TDOCBG035ySyZvLdR9v80l5+naQw8rR/ZWDg+JkbjUa
	 rG8Rx5SheAUSzdkEnqGhIZUYKdP3nml68U7Ln3iDjRuGrD3FcdocJjE7oX1yx5vnz3
	 1M/MW/PKUsaD0X38YeyCIfTXKkihdZGUHOr4CyZKvKjMQSffOA6r0c+7LIx2+/0H7Y
	 syig3PqPPcnNBdp5F8Lfq7nmZF+rTy8iSOGHJA2cvRfJtWAKoevCsO4vmw0JsBq5pn
	 xpbFKqSMvN5cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938F23809A04;
	Fri, 25 Sep 2026 23:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/mctp: publish the mctp_dev only after it is
 initialised
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179037960440.3207107.1869825882080445252.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 23:40:04 +0000
References: <729830b8.130.1a0c945579d.Coremail.18983559317@163.com>
In-Reply-To: <729830b8.130.1a0c945579d.Coremail.18983559317@163.com>
To: Binbin Deng <18983559317@163.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dengbinbin21@nudt.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 21:19:19 +0800 (CST) you wrote:
> From: Binbin Deng <18983559317@163.com>
> 
> mctp_add_dev() links the new mctp_dev into dev->mctp_ptr before mdev->dev
> is assigned, so a reader that picks the device up in that window
> dereferences a net_device pointer that is still NULL:
> 
> KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
> Call Trace:
>  <TASK>
>  ? __pfx_mctp_sendmsg (./include/linux/sockptr.h:49)
>  ? __pfx_mctp_dst_output (net/mctp/route.c:41)
>  ? selinux_socket_sendmsg (security/selinux/hooks.c:5278)
>  ____sys_sendmsg (net/socket.c:775 (discriminator 1) net/socket.c:790
>  (discriminator 1) net/socket.c:2684 (discriminator 1))
>  ? __pfx_____sys_sendmsg (net/socket.c:1131)
>  ? __pfx_copy_msghdr_from_user (net/socket.c:2590)
>  ? update_cfs_rq_load_avg (kernel/sched/fair.c:5478)
>  ___sys_sendmsg (net/socket.c:2738)
>  ? __pfx____sys_sendmsg (net/socket.c:2625)
>  ? perf_event_task_tick (./include/linux/rcupdate.h:838)
>  ? sched_tick (kernel/sched/core.c:5818)
>  ? clockevents_program_event (kernel/time/clockevents.c:372)
>  ? fdget (./include/linux/rcupdate.h:873 fs/file.c:1100)
>  __sys_sendmsg (net/socket.c:2770)
>  ? __pfx___sys_sendmsg (net/socket.c:2751)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>  </TASK>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/mctp: publish the mctp_dev only after it is initialised
    https://git.kernel.org/netdev/net/c/aadf655e8ea9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


