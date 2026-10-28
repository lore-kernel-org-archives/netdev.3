Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188206;
	b=b0vCIAOxpZpJdjRLBbzWh3tjedBL6VUGnIuahFkD7RcqMySb4H81rZeW3w/83ibzY9gS
	 CWQN7ZLE31optBtl/46WtW4WxsT7mEqINZ5aHPfKfR6NQIcKtIp1vd4Ov302m8mBCyaGw
	 gV6sg0CLZVIlSol59WqK0APa1lPdZOkgg4DhWEliL50vGcvSVsjPHXwVUgfzE3oQYETxJ
	 JTWtEFXBRyQSb3vW9TPHeb22ls8DIErIp16XQYtmWmS7dEm6ZFKaBwyctqo7UcPsnjqWe
	 0VWnF7Nje0hzipQ24UflPmu789fuTrhd0ToBzlMFJLk0mnPXGlKcS3geT/D7E0Y09hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eZCjIfua1NVGQXe03RlVuUyF2WuomENUggZmCurRgP4=;
	b=jcUxqATcxVy/ljjyKZst+MeH5EY7AJXgryfBdZYuPR8swCahiXNxhu98zYLRyjU7nRom
	 vBpL47MdbYMZd3CysL9SlrNSuFJvwPrUb/MkqqHs+s8aoYgqWtlTnqGgnCyv/YP4FbRbo
	 uWNwhRw8WQUKE9ZhGja6b3f0R7M6s7GFQ5t0K35Af+k/9vTEZytyhWhXrFZQW2YofWvca
	 oDdrMVZ4PYR2mL+ChD+fkMkzpIZtiCkF+UsK/5x+YjSOP/kdl8+Cu6B7y8+Sdx3cp4Bbx
	 i6Z/Wz8cxWbOJWP8hR8IThlzI8hljroFSi+5XOuv0mAYT+i2aONjg43kEU/YLSnOEzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/3UWtxs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74E606A31C;
	Wed, 28 Oct 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/3UWtxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F94A1F01828;
	Wed, 28 Oct 2026 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188205;
	bh=eZCjIfua1NVGQXe03RlVuUyF2WuomENUggZmCurRgP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a/3UWtxsIp/ziY58P3nzikTBK4B/Rz2/DTN/lvSIhEJhilYFUwFQnG6IX3IUKU9we
	 j9JJCAKaNsHFizWWE7frxzjuoBY4Eg9cqQGfURbT1kkb2GMHkIxvCciwthq/7I7fYq
	 7nxeX1lLwIba+iKB4n/tdOwHneCVfP2ktReyB3hKT50LaK8AQHImtIz3f2pl55sXrb
	 26PFs11QaE6rxaRHtJ2hdZCZyY6orwCAGc8e3EuquwtqWqdlOTkF9i9yDwIfVR5xZm
	 nr8XDfQ1hByOb8Xbhfj72Z/8hz6ZvZVIL9sjttLIdEXb3YGrykgyGoSge/XG58oHfa
	 adw/vHCKUA+iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8150D3AAA6CC;
	Wed, 28 Oct 2026 11:50:05 +0000 (UTC)
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
Subject: Re: [PATCH] net: sched: em_ipt: validate hook value from netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179318820432.674732.3698525593677079612.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 11:50:04 +0000
References: <20261026090717.41597-1-fangxy@xiaopeng.com>
In-Reply-To: <20261026090717.41597-1-fangxy@xiaopeng.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 eyal.birger@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 liuwb@xiaopeng.com, zhugl3@xiaopeng.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Mon, 26 Oct 2026 17:07:17 +0800 you wrote:
> em_ipt_change() accepts the user-provided TCA_EM_IPT_HOOK value
> without validating its range.
> 
> The value is later used in check_match() as "1 << im->hook".  A hook
> value of 32 or greater causes undefined behavior and may undermine the
> xt match hook-mask validation.  The value is also passed to
> nf_hook_state_init() as a hook index.
> 
> [...]

Here is the summary with links:
  - net: sched: em_ipt: validate hook value from netlink
    https://git.kernel.org/netdev/net/c/94cea342e891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


