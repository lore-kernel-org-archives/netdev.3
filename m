Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990562D838A;
	Tue, 10 Mar 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108014; cv=none; b=nujkmkmcOR0UxEGV5ZoBCoIm4IV01MWs6KK9vmuYgZen31MM24WPtGwdPjpSgyo3jpRpRojcJC4cg+KnFobQwNAUvmdZJwVXNqgNg0D+KCyji3wd3tkzSuosOkOfLXMPlJv8bw8Zzd3c0uWRA/GxrHIIreymO5Jcrq/QTd6mAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108014; c=relaxed/simple;
	bh=tFQztmaF18E2s5/2IQDsx6U3eT7pUDdS3X216fcsPvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qAR5CaxdVDOTgjKZcHyVe0UIN73ID9gOt0QUY6uOJMKShAjElIRNHSbZKeLHRoLFC4zObnmJlbmXTtNlty2w0pi1Jwknt5Ascsbu0yFOdZCn8ZS7PQ6E6dBopROBrZs0Y7uTzSUpJS85L8PnYFdI/i2ju5ZCL+MPFcVdLZEx2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv+LyPJn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv+LyPJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23101C4CEF7;
	Tue, 10 Mar 2026 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108014;
	bh=tFQztmaF18E2s5/2IQDsx6U3eT7pUDdS3X216fcsPvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iv+LyPJnaWn8a6Be3p8Rf+nPzwBKbOanekIpNXWFvCOsFfDkV1Plyr65achdEeTph
	 yDyztcEYuKzqZJuNIJdBC/tzwBDQR9QRd6DRMRbL3Iu5zZE/jWI0jkLAh2ZhznqJFc
	 h70XB+sQL3NP36KD+F0dTnHA2jtI+Q/h7tKW0i/5uwspwOzBMxKfXWGZ7sg+bKN4V3
	 PzPix02k2aPFX0VuHsdRG/Y8riyveuxZsM5dK+GSEx+OBIsgp4Qf/syAu3M4syNqHJ
	 wg7cR/zBNM3CME5Te2r5MrcXgT3BLM+LL/eN/GyI96eVsGsnx+TGWgLTndzrLY9Ddr
	 w2ZV0lauZpCKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE533808200;
	Tue, 10 Mar 2026 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] serial: caif: hold tty->link reference in
 ldisc_open
 and ser_release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310801104.2022132.17691657307991494118.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:11 +0000
References: <20260306034006.3395740-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260306034006.3395740-1-shuangpeng.kernel@gmail.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, gregkh@linuxfoundation.org, horms@kernel.org,
 jirislaby@kernel.org, shaojijie@huawei.com, jiayuan.chen@shopee.com,
 alan@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 22:40:06 -0500 you wrote:
> A reproducer triggers a KASAN slab-use-after-free in pty_write_room()
> when caif_serial's TX path calls tty_write_room(). The faulting access
> is on tty->link->port.
> 
> Hold an extra kref on tty->link for the lifetime of the caif_serial line
> discipline: get it in ldisc_open() and drop it in ser_release(), and
> also drop it on the ldisc_open() error path.
> 
> [...]

Here is the summary with links:
  - [net,v5] serial: caif: hold tty->link reference in ldisc_open and ser_release
    https://git.kernel.org/netdev/net/c/288598d80a06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


