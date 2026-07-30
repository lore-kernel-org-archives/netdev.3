Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7583BED63;
	Thu, 30 Jul 2026 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369664; cv=none; b=M58qgldeFOLZhQ18MhSiAiOJJnosc+43YWiiQfboTwZ1F8IWTuHc1MZNbFz6mBdzHWbhrvBwRD/9mSheuKkTq5LwBnUE0MXBkQFSjC20l122ZH++P0WTB66pBEU/ijMeOnhHmYkAcZniBut1ubVi+xOqRXQ7F0lJ/1fz+UKcJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369664; c=relaxed/simple;
	bh=0htR6Gq0crBymhLm8aPx9NOs7rbZNO/mO8O+/tjvQls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QqNY0k1L6NiLwwOHgVFsGAqe6QSnCuDPDPotwGItAYq1iiV8b1dPUJ4yxB59lGyV0iEPerOiga0HTU1u6qkKHua8n0q2Uf/G7pHMrjxArcb420JYOsCC2t0F5SFdIG5qIzGBuIll9o8THOAU5krnox/JFxcrzffAxD4bt9otVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHJaPl34; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHJaPl34"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AC01F000E9;
	Thu, 30 Jul 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369659;
	bh=C1yC0DoF3sowZEzyCXigudqp9J4hboj/3PMLdsnemM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IHJaPl34C/frObHv91daOYYjkptBFQe3gaZmMKtEobpnLLlOptZQaVrpaoAhKAxv0
	 y4PawVx1Jqbh9uUIWTwf7mMN0qWOaLPl5ytI/+T7EvP9laCQGYhNNUQ/NfzrESmBml
	 K5nbTp+6HMlzD8xWGPlrPUhhzs2yskXfjM3QQLBKxBNXKZ8dJ2JdkZJuprF5APIUs4
	 W50B2p4NSOpTafLWrY+96kosCuM96Fp9mQu3pPcXCmk9tNFpGfu3ZI1oRqprRjPbAo
	 pJipXUiNo+mNR8Xp372u17hLrRgRyMU95bj3DhEhnbctZ1Qp2ppC3wtDx9LCWtcqL1
	 O0Qrx1ADHtXpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D10AA3926250;
	Thu, 30 Jul 2026 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] psp: fix NULL genl_sock deref race with concurrent
 netns teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178536962339.3288516.4696064079043880319.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 00:00:23 +0000
References: <20260727101628.502042-1-kiran.kella@broadcom.com>
In-Reply-To: <20260727101628.502042-1-kiran.kella@broadcom.com>
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: daniel.zahka@gmail.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, weibunny@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com,
 vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 03:16:28 -0700 you wrote:
> The race occurs between network namespace removal and PSP device
> unregistration.  When a netns is deleted while a PSP device associated
> with that netns is concurrently being removed, psp_dev_unregister()
> triggers psp_nl_notify_dev() to send a device change notification.
> Concurrently, cleanup_net() running in the netns workqueue calls
> genl_pernet_exit(), which sets net->genl_sock to NULL. If
> genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
> then dereference the NULL socket and crash:
> 
> [...]

Here is the summary with links:
  - [net,v4] psp: fix NULL genl_sock deref race with concurrent netns teardown
    https://git.kernel.org/netdev/net/c/fc9c7ca5fcbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


