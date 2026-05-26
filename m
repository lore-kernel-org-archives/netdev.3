Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32C33FE02;
	Tue, 26 May 2026 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787804; cv=none; b=j9gU2PqO5YzO4Kqa2jKOC32f93NDDUSnKOq1/aKGyj4mhTTGliJPC939JRZmukUarvyq3JnLp3i27PmsVC0oJDf9LTxPgS1mXJMGsZfPfFtDG/K07u6oZra7BDwfxrTQR44W68oe+KfswYz2f3c4XmPIa10qPJNc2stzstgUYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787804; c=relaxed/simple;
	bh=C6JTlSWJ6UTWLfty6893Trz5EJLQuv+avLJUnldQD9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQoHogj6+e5YopgVDfUqMdSoonpoGHCHEzdnDXiQA/oeDmV+6KYT9Efyc4yIhRhUiLuJNKUErDMejTyNLAf8E9jaCwgP20qF2MaByQCHvDPpM2BwmhCrsbl4XI/FnMn8kVcDtNcXuSTLa7/CWxoE9dToDkpY1/wkwkApPNwwrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqOKWuLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqOKWuLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA961F000E9;
	Tue, 26 May 2026 09:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787802;
	bh=34cNSpRjbMNs7v786OsvSmA321upWkDNt7Am792BH8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VqOKWuLGge3d6nzPBiKBsrg63KZxKF7HxnNGYPuxViw642wYYz3TikxeSdWHjINc7
	 dBK77XyI7V5UzlXdAk31OnlCuFsYC/7R9WlGrDQTEdzA3/QudXZ/QDGWwFbciCL52U
	 oJEByeGUbqgHw1NSUfJOR6t6zMCFZzB/vHbch47RcFn7uzPxiMg9JAal8rF4kkSVyq
	 vXKTVGNiKH4OIpiTykXhXeJdMNuM/bTr1ZIG+B4R53DMkE3ANL4B0qTVXhgmKEXwY2
	 wGWhQDmWl2/SMRCmLDMAqIA6Xmjo5GU906CCzr81qbtUoXEGPI40yYSTFr5ZoEIIHa
	 /s0fKWybZhtQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E04380CED0;
	Tue, 26 May 2026 09:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] ip6_vti: vti6_changelink and
 vti6_siocdevprivate
 netns fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177978780814.3286183.4781727530904846983.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 09:30:08 +0000
References: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260521130555.3421684-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, kuniyu@google.com,
 steffen.klassert@secunet.com, shaw.leon@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 May 2026 21:05:53 +0800 you wrote:
> v3 -> v4
> 
>  - Update Fixes tag on both patches to commit 61220ab34948
>    ("vti6: Enable namespace changing"). Xiao noted the old tag
>    5e72ce3e3980 is not the introducing commit. dev_net(dev) and
>    t->net first diverge when 61220ab34948 dropped
>    NETIF_F_NETNS_LOCAL and made vti6 devices movable through
>    IFLA_NET_NS_FD. Same Fixes shape Jakub took for the sibling
>    fix 1d324c2f43f7.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
    https://git.kernel.org/netdev/net/c/11b326fb0a37
  - [net,v4,2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
    https://git.kernel.org/netdev/net/c/8b484efd5cb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


