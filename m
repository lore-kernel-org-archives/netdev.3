Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68B2DF3F2;
	Sat, 26 Sep 2026 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383286; cv=none; b=m/QFiBE8FVyRx9TLWwaRbL0zsoCINTMMvo+Js7jtxYBIRb196zO087pD+lBQxeJn2j3iYN8Qcg1qx9wVGP6+Yke5CWK7UiLG7RUBSLz35gubn1y6TnMLLZQ7jCWPbnevIVlporhw4jv3uFXZg6ybL8ntGDbQ0S6Mmk1U5RE9LP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383286; c=relaxed/simple;
	bh=vImoQ8vshXffMZVjWzF1BVJugG8mN0pP0jrKcXWIhJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=of1xaFsASvxjp8WJczJz1cplaC/n2r59m7I9WtM/nacXgtU9qprGcqKln/9nF4LoXlZZ8h0wg/3NSCLli/rE2C97SmF69lY745DpVFjyYumlJNlTttf0YTwvfZ1tTzIuAZ70KTrm0xxfDE5QSBmtrShj7FT1pmFFuknhWmAlY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm3oSDxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm3oSDxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185241F00893;
	Sat, 26 Sep 2026 00:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383285;
	bh=SMvdhML++CPtLnTHT5YCs+UHE+cDH/jJ5yo24G2RvC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mm3oSDxqFUdr/bUCM6Jytyd62E4V/547ZgcvODpWBIAmEhUdYSqwxAnZx9+uwjkqF
	 IO4+rvPOFyjNVVKJnanMbUWqKCgbeddujlzNPymDUc3kCmzWX5K6LgP5oDBI1xMnDB
	 Z21ERBCap6lYU8v9mLWQqpGohCvmvnm3ilE0w7nsn5RcJicxWVpHQdymlLt6q21QJP
	 yrCeQ23e+4UPh8Wnch1hvqpBOyjfDeXlJ3XaqDVbCQmnr1xn927NqK5QANSdwqf+Hg
	 JDtE2ctZc7pgauntaDKP/O1F0YihSaKb/yHNcYBQjLQyoWucf8L1YtjbDUJWcOhONu
	 Pncuai36nT69Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D086B3809A04;
	Sat, 26 Sep 2026 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] ch9200: stop ignoring the register write
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038321238.3221981.1516281507990689977.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:40:12 +0000
References: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
In-Reply-To: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 23:14:37 +0300 you wrote:
> The successful register writes, done via the USB control requests, seem
> vital for the normal functioning of the device, however the driver tends
> to completely ignore the register write errors, even though it could well
> propagate the errors from its bind() method.  Additionally, it masks any
> USB errors returned by usb_control_msg(), pretending that the call was
> successful. Let's stop doing all that and see how it goes... :-)
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] ch9200: return error on failed register writes in ch9200_bind()
    https://git.kernel.org/netdev/net-next/c/52c895f638fe
  - [net-next,v3,2/2] ch9200: do return USB errors from control_write()
    https://git.kernel.org/netdev/net-next/c/7bfc50171800

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


