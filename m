Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACAB23B62C;
	Thu, 19 Mar 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881069; cv=none; b=jaTVm+nuEup64C8NVUNQMprYTKyb0pnZsFaLp537eI8So/xLfZjC/uB9SNdXxIAwk+HLwwjOuYXe56+4CcRhPa/Vt/74nU7neybBupNVYEBKNdcabxM0HdF0KGB7yY5otsjTXaXN9WTkxO8Oj41nh66V89RQjxPbiykXY3JsOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881069; c=relaxed/simple;
	bh=QyvoHK+CRCQGQDwhy9eOgNgbqaj1UunQNZKLcT6IG8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XyKPJPo2rbIIi5JDz2LlIDK0dl6HxvNZEs0s1INX8UGMKhM8vXBvS3dg5+tsPSLyPR1QC4HptcQ5MZQLFnudUYAhEICRmUaDXuYXb4/J5V/RoXsOMZoDGv3I43BzYR9inubGPL2kKYXiZcSBpmZewlcigmLLWOu28aNGimk+fIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUmhpZHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUmhpZHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBA0C2BC9E;
	Thu, 19 Mar 2026 00:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881068;
	bh=QyvoHK+CRCQGQDwhy9eOgNgbqaj1UunQNZKLcT6IG8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aUmhpZHRJSvHj8WSnAk/Br2aUTpPfT79YV7JP3DnJ5OPMTG28qpLecyO5UkZGnNM+
	 8K2RSjPZO6b7seTpxJvwE6ymyi1FoD21yOMnCBG7VlZ1MnCPtotMH111XDVtV9Q4Ek
	 W93NTL520RJzYS3QsLlukDknYTyKJl/G3ontBcPNtWY6pyhNPRLmAkloyHrn7v2hkA
	 l0os/ImVPN+Y7kGK9qeDCf4BpFt2+b2JNtvn1+8ReOXYifMv/KY3POwYy5Vf0L8CDH
	 Ny6UR3SU4KTy9ic5tjOQLW/TG+vmK5HMpZ/TIZ25jksrAsNpUZpcnmPdnmq9cWscfM
	 sz1wjciArmiig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE833808200;
	Thu, 19 Mar 2026 00:44:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdevsim: drop PSP ext ref on forward failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388105978.935482.17109055611230059426.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:19 +0000
References: <20260317061431.1482716-1-atwellwea@gmail.com>
In-Reply-To: <20260317061431.1482716-1-atwellwea@gmail.com>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com,
 daniel.zahka@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Mar 2026 00:14:31 -0600 you wrote:
> nsim_do_psp() takes an extra reference to the PSP skb extension so the
> extension survives __dev_forward_skb(). That forward path scrubs the skb
> and drops attached skb extensions before nsim_psp_handle_ext() can
> reattach the PSP metadata.
> 
> If __dev_forward_skb() fails in nsim_forward_skb(), the function returns
> before nsim_psp_handle_ext() can attach that extension to the skb, leaving
> the extra reference leaked.
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: drop PSP ext ref on forward failure
    https://git.kernel.org/netdev/net/c/7d9351435ebb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


