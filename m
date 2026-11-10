Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279322;
	b=vT39oNrMYo/zpcRrOztL6T3hCvZ0ReCjY2dMv7YkVLUj0eVGxWPVbU31J9b3+HsTocVA
	 AZ3+4Cc7JPGjPzANOwjpUFpS+ENIu64dsi2UHeh4+SZfPry9C01ahgVXgVePqt+5zWy0F
	 oxjkDKKZ5HbSXuJrXzAdwY2/9dvnoAQO787QuFCkABXBPbp1Dy6g4IWyGfcgIjyndb0HB
	 CNJSQwxqGbqd6fY18IJHe4svACRTuxzLGEV94/RH81VuZUqobPuSUoalca9SREy7+ni9J
	 48rjn4TYZUtAsrUAT4qFlIlZVTQD4CWWNIqiuSCe9MHuX2HpRbuW5Wl2t46ZdaFpu2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279322;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ZPBtGIOGFLrEbxTWvg5dr/Uvnp+M0Ms0sRfcLMTJMA4=;
	b=3tDTBParEQB7sObpJZOXYcRwhV5ogp84Uo447SQaXGQKINcINOSgWib0+6VtLZu4QQ8F
	 dxJHum+jCdocGoFv5j5z1mdmXynXl3pFOD5rNGvZXuI+zzcaNdTffz5/QOtFUDoy24CDF
	 UgVghuwqHGzite19oQmnFri/14OiH4NahrowcFy3xwj/cgdGcag9CXVJEyjIKpUhrzsHi
	 VgfjxjZDhyzYuajlT7uAIxXKWZQBDgdc/iUO7Y9NVF1KRzNp7dP0MC5IVDLZZZF3wJloa
	 rTnqVqjXL1yi7pyJABfwq0MCWehDCWkzzA9NS70f7HFjb1KEUCAYWCNs+xo61HiLx/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAdyYYWR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302C60A3807;
	Tue, 10 Nov 2026 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAdyYYWR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF3D1F0089F;
	Tue, 10 Nov 2026 02:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279322;
	bh=ZPBtGIOGFLrEbxTWvg5dr/Uvnp+M0Ms0sRfcLMTJMA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gAdyYYWRpCq5zmeCxURVwSsstv+DgEkVOtd9ajI5cyFOwJkm0eSErbQT+3TFrupu+
	 IBGYCW0fbQmfv9vFkQde/Br/xfKBo8TFtmxToqGLV4zNwOLid7tafrfqIZkRqjExyF
	 /9vAXzdosoEbp7cfnO3cKxkL7Afxkx7GJK5/OQQnGQ1ZvnOTJUgWNM2l9/APFAmGDA
	 Q1naPLX4llu+7mcZt76/4300ZfRkZ0sH8K8lMAgInjGTLsvWJrSGaFELFTOpsppiYV
	 3ggd5oVSVlOclS1232HwKBDx45WDDZeNqyB+kILnhghOIRVIfw7p+TkuY5F+6FdkXh
	 zxo+i6teP9i+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E6323391AFCB;
	Tue, 10 Nov 2026 02:55:21 +0000 (UTC)
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
Subject: Re: [PATCH net] netdevsim: check the driver is bound in
 new_port/del_port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427932067.3612825.8436433275701655863.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:20 +0000
References: <20261101135824.24484-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20261101135824.24484-1-ngocthang2710.1999@gmail.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Nov 2026 20:58:24 +0700 you wrote:
> new_port and del_port are attributes of the bus device, so they stay
> reachable after the driver is unbound. nsim_drv_remove() clears
> drvdata, yet both handlers pass it straight to priv_to_devlink() and
> devl_lock(), which faults on a small negative pointer:
> 
>   BUG: unable to handle page fault for address: fffffffffffffeb0
>   RIP: 0010:__lock_acquire+0x41/0x2de0 kernel/locking/lockdep.c:5140
>   Call Trace:
>    lock_acquire+0x115/0x350
>    mutex_lock_nested+0x55/0x1d0
>    nsim_drv_port_add+0x5a/0x140 drivers/net/netdevsim/dev.c:1760
>    new_port_store+0x1a5/0x280 drivers/net/netdevsim/bus.c:96
>    kernfs_fop_write_iter+0x3a5/0x540
> 
> [...]

Here is the summary with links:
  - [net] netdevsim: check the driver is bound in new_port/del_port
    https://git.kernel.org/netdev/net-next/c/98aaf4da98d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


