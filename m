Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB623EA8B
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402646; cv=none; b=lAc7BLTNxfTTIW4EN+hxqKdyxjZAwkEVNwdIjSzT6kMYigtF2vG98iioFGaeGc4XLx9vY40Z8myK377B6Z3eXuxinEqComxXV+Rw3HeTGZNW4RkWHdko1Dm3vd/eg8JCpcbB6WuYHQxb4rpuJ/8R3gH1+jpTRtZZrreG1oWTWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402646; c=relaxed/simple;
	bh=w8U9vZ8a/Xofocg2LnnOt9/nbyFtXUXpqGiAusaJJJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrJQMpKOXUILu54fGjwp8gVOk8Axg3e0aPX7Mzu2tx6FT5aqHNd2+0SMNxkvlZ3ZSjcZFdYGKsGwitP/Fc4oH29MPu1+FlPzcd4FMeWu4XVvmucR203jCl1LRcFT/lw4xcl9Y0h2/XS+aiomjrLo+sPmzDKLsg2Z1LAKBFjwdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWBt1ts1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWBt1ts1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A47B1F000E9;
	Thu, 30 Jul 2026 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402645;
	bh=Usjl94WjbvL5HPDbpUnThOOZFqggo0Gv4LI53xZwHEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HWBt1ts1Yq826mmQHTgZ11Gkp++3ch2e+JcHmuQVS+4CByMJyyIoLkhOjcJeax1u1
	 StkO78ydFboPk+JNP2UEvkiAua0ycZAYE/2AmAASo9Q+uQYdhnc6vo5pTh6fJx1Tng
	 srKEpJYyPSixSmib/muODYc9B3pVD/w66T7Pou0ZU/5Gj7PnkFZ//KETwR9EGnmDXv
	 yOanM5RoqbKLsJECLaBlkqstKZqA+XlcEhbetaRZwGTKFhHkj9HEWXCAptZ+in+rch
	 gxuxbroiBhHvhYem9gAn0f3nzdVFoPAK0veCw9YUixuLK6l6GYM6KQlhiQVVCP3mDK
	 MeZYwQpk+4NJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D13811958;
	Thu, 30 Jul 2026 09:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] Improve wwan qcdm compatibility with
 user-space tools
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540260889.3451810.4182920404720112423.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 09:10:08 +0000
References: <20260724142909.3270824-1-dnlplm@gmail.com>
In-Reply-To: <20260724142909.3270824-1-dnlplm@gmail.com>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Jul 2026 16:28:16 +0200 you wrote:
> Historically, Qualcomm diagnostic port was a serial device, so user-space
> tools were developed using tty specific features. One of the most common
> tool is, for example, ModemManager libqcdm, available at
> https://gitlab.freedesktop.org/mobile-broadband/ModemManager
> which requires tcgetattr/tcsetattr and the possibility to get exclusive
> device access to properly work.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: wwan: add minimalistic IOCTls support also to QCDM port
    https://git.kernel.org/netdev/net-next/c/4762f405d041
  - [net-next,v3,2/2] net: wwan: add exclusive open mode capability to AT and QCDM ports
    https://git.kernel.org/netdev/net-next/c/1a87048a4c68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


