Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279324;
	b=HI/A60cQ3S7ZjwlKa4nQSfVnWHJ4lLq4DcLyJl/vV6MpMCzk0Qf+2pW3BOaxte+qrTKG
	 8crMFRMERhM6PRhkz5h9M+QnpY/1jIHJbt2/F0qALzVP5zwwhd36nMwbbOd6LUjCZhWL6
	 YikKzDz87RNIwz5ehAwnF3dUahTILY+5mAqns26aKfMaytcqfzvDpR2wGsPagC2jKoi6e
	 GvXKUJv36PcBmlwHovqO4y1hdTQJZBDUCEt5+CKVV0uz04gJ6QFXK60tO0Fal/N0DAPTq
	 CcbsW9DQpA/xKcftyPji/M1Bk3KfTfKxU2Bv85L9QaOK1Axd5CMLr80LaLKUl82gY7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279324;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=846j6wL4j7UvBVjd/28Rgk3idfp9HTNpB1bpeGDTWng=;
	b=A3OdPLnpln20B4ao3vcw2TYd6tAZBFw0ix6ctfgk6s/hdg/Y+OAFVSE0Q10m2KRAN2DL
	 9ErOX7rUHDQ9u+CBkWDn6c5x4J6rvWO7Ppxlk4EetNKjDt4WrVkNbxoeGSDbMl020pM21
	 HlJkJcQ6NnZHr+NEBLy5InQKtjPhOr9RL6eTlZp143TD4PD/j1vYCAuleO6jV3kxihYSt
	 ztMF4mdboUwL7SajvH5+gBNi+FNksy1M4/Y3aPpsuJ/6yiyBYiolVYFZMm64NdbyxeldJ
	 jqa40LSJDHfr5USZczBaNu16CPAzM2R9Xk86kaLb0fSXb2zb+PH0NEeKPsIsqArs2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehcs4YFY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B20606C6D1;
	Tue, 10 Nov 2026 02:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehcs4YFY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB01F0089F;
	Tue, 10 Nov 2026 02:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279323;
	bh=846j6wL4j7UvBVjd/28Rgk3idfp9HTNpB1bpeGDTWng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ehcs4YFYbwPN7lGLVw4nRjvIKzJuMs+nJVBbZ1HEETYCKz/yDxekLyx6XlE9VlOLf
	 wvrIcIDJar03NkNF/fodXcYM7k2s7pwf6FIOSJpMCuobp2X6bXinJN5bRRobAs9Grd
	 ZbLPf/IhI5mDCwJVorNzJsDH/y+jxlJdzijcltclEGiTcBNOYgNVaMeXQqqZvBD9eH
	 YsC46xgN1/RBkWC4hVTZxZZiKbLYah9KyAR14TCKORXAOi60s0CI2EmVuSLAV6GnRN
	 ynPzdbWHddR+LuwVEp/zz/xdBN8/x1SJcwEz62ubIbGf3GTwPlAdTeOUJ/Zyts/mTo
	 oZx7Fr/I9dyKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E221391AFCB;
	Tue, 10 Nov 2026 02:55:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdevsim: fix NULL deref in port attrs after unbind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427932199.3612825.4107115664399893985.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:21 +0000
References: <tencent_C7E2CBFD5E5A8E8541FEA08915F742EC6405@qq.com>
In-Reply-To: <tencent_C7E2CBFD5E5A8E8541FEA08915F742EC6405@qq.com>
To: Shuai Liu <847807867@qq.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  7 Nov 2026 17:20:09 +0800 you wrote:
> The new_port and del_port device attributes call nsim_drv_port_add() and
> nsim_drv_port_del(), which fetch the driver private data with
> dev_get_drvdata().  If the device has been unbound from the driver, that
> private data is NULL and priv_to_devlink() turns it into a bogus pointer,
> so a write to either attribute faults in devl_lock():
> 
>   BUG: unable to handle page fault for address: fffffffffffffeb0
>   RIP: 0010:__lock_acquire
>   Call Trace:
>    ...
>    nsim_drv_port_add
>    new_port_store
> 
> [...]

Here is the summary with links:
  - netdevsim: fix NULL deref in port attrs after unbind
    https://git.kernel.org/netdev/net-next/c/98aaf4da98d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


