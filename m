Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B64D4885;
	Thu,  8 Oct 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483009; cv=none; b=JifarTp8vP9z0+b7X49M0VeZ5jtcqndyfk0mX4gNLiA15E5ww77T/D6AKgPIVAbKQ3159aI8TbAH3LkrI6G1fObn5BV9LCERiv8jmBCfKumOJo2xZa8rgaPiTtaYWFv6YJO0ONoul5IMiE732Z1WcdmDouwCKJ45afVR2+aCRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483009; c=relaxed/simple;
	bh=M81CMcnxJA/B6pZEfbGzCR+knD4hL8uWWpmRrZU2R9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U23CghUIoKvDWUogQ6cbyCf5FPE9xCbVQ70ZrXTYIg5Gt4oUCpFRAEvG68Ug2sABZASRpFOCHcD80ZZBtvd5Gw79jfYxmT56WFQZyGmE6XzErFRs4ZlJ6mvS4LvOsumn//eJBP3Vk1C2n4uJ1HObZfxwrUJNF03E0dkwesSIdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO/QaKBE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO/QaKBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F4D1F000FF;
	Thu,  8 Oct 2026 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791483008;
	bh=Mgz/JEEGECPTRgQwrTAyDQTSbYKXx3QIQooxppgQLKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZO/QaKBEKdt/mDfkwBDFGBqgSTggBDXHYvDpzWpD6hKapIlxL2hZZxDHYijP/NxU3
	 v7PdO0MZzveOtmCijDmH/bIbjpSA3Tp8FSyLCb/GkJg4SHIQyexP+um+SsAPKqZ51X
	 A0TrTF4Wb34+LmKejWCWfZw/u1Xq6G1zZOek9iejfFXFmresCVidKpwCwABI5WXYhA
	 Ec/+vmedTYxtW+6Y13EcqrYnzbpzlAf+98GdF+z+TNgbBoX/CehILJFa9J0h0bCqjU
	 w0lUdZIqNVIjusPhnYCoi9m8psLvP4iiimHm6xx49XBYtY4PRwysYioYiXRITA5HK8
	 FXAfUrp34uBfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1657380CEC8;
	Thu,  8 Oct 2026 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: fix NULL dereference in skb realloc fault
 injection devname filter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148300651.376744.893341011856074235.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:10:06 +0000
References: <20261007004158.1266795-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261007004158.1266795-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, leitao@debian.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gnault@redhat.com, akinobu.mita@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Oct 2026 08:41:58 +0800 you wrote:
> When a device name filter is set in
> /sys/kernel/debug/fail_skb_realloc/devname, should_fail_net_realloc_skb()
> compares it with skb->dev->name without checking skb->dev first.
> 
> skb_might_realloc() is called from pskb_may_pull(), pskb_trim() and
> pskb_trim_rcsum(), which also run on skbs that are not associated with
> a device. One example is a netlink broadcast to a listener with a socket
> filter attached, which goes through sk_filter_trim_cap(). With the
> filter set, such an skb makes the kernel oops:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: fix NULL dereference in skb realloc fault injection devname filter
    https://git.kernel.org/netdev/net-next/c/670ff95811b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


