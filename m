Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F4400E0D;
	Wed,  8 Jul 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498832; cv=none; b=JNLvDJdRffYe6Z5xn1ka7q3EXasNRyLGBfM8M8yiY3e8MXEwvTwjzkcawamF+fgWUif8g4l/H7FiU6qlJ0/IOPCm9mX/LBiF3lzQVRwrydXIvYLNSFjMsN/dT60IsyDmzVfPfMJNwlRR9Bg8Lnh+Z7pbA5J6mbWBtDPyse1yZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498832; c=relaxed/simple;
	bh=/zob/0v/vv3frYAz5iN9lPagsNpEWBXyRBeDCHl/PWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VczWNB6VLGYR4grgkZjLEKUtyseq4qOHTRodJV7znCc2vCZgRt0UOoD7OLahWm9FoIx1NtJGQ0eK/jFT7H4S0B/Qr6cslG25kEDeXTis/rbvGITmiq1gg+j47kFkzfjlVQp3kiecEt1j8zKTf3qYSVk0GWWv0fqHRoZSxu65wTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fikWL1O9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fikWL1O9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C9A1F00A3A;
	Wed,  8 Jul 2026 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498830;
	bh=MGlgPGmyFkJVjwQTg7vHl77JdK+1Bmhg0ss3JRQKito=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fikWL1O9mKeXdaY+fVAMic9fxYHP2C/kYLNGcuFUkrMJXpYwEYF74JpSHlgB89C4e
	 uuGK/3ksPt5iAqQ/UYc1cN1fAlcB1BpOw38qgj5eZIPhEyNGZtdSvOMwSxHECI7kdm
	 5as4SlEV1FfoGrmxImEXtmlqbcNoFvz5NenLsd0AsnOV5QwhCF4Wodf8/Gwervzck6
	 1FEY2EAVmTi1xFXE5C6RSEKZYn65iJYAFO80qsZJTkxjq3/EG9LZvk3uZ5d2nM+0I7
	 DNtalcQYxCzG5Veg21wIgKEbF4qFsKXVeZ2GvqBO827/D8rjpepAZ2BzgfF+anZN2g
	 x/ukJbX6EsEnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AEA3926383;
	Wed,  8 Jul 2026 08:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gtp: annotate PDP lookups under RTNL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178349880988.2367097.8758757633307166154.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 08:20:09 +0000
References: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260701123925.3193089-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 20:39:25 +0800 you wrote:
> The GTP PDP lookup helpers are shared by RCU-protected data and report
> paths and RTNL-protected control paths such as gtp_genl_new_pdp(). The
> helpers walk RCU hlists, but they do not currently pass the RTNL
> condition for the control-path lookups.
> 
> Pass lockdep_rtnl_is_held() to the PDP hlist iterators. Existing
> RCU-reader callers remain valid because the RCU-list macros also accept
> an active RCU read-side section; the added condition only documents the
> non-RCU protection already used by RTNL control paths.
> 
> [...]

Here is the summary with links:
  - [net-next] gtp: annotate PDP lookups under RTNL
    https://git.kernel.org/netdev/net-next/c/0be5c3f0fbef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


