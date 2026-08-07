Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D32414A08
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146684; cv=none; b=Yhkh1bWFVYFjmf1x/mlwwSrvdG18dSwBO3hHmK0rrDjujPmxE7aNxFDDNyfdweTJAUwh1gmGYPVG74SEW4mqCZR2swPPVCdO0Z+050AWauCt6wJq108aRW07rWKiUAbwhas3dwPRgSTlXC9Azl9AeOfBdyYU+8/xTlqyKEGRPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146684; c=relaxed/simple;
	bh=/trS4uMoAhnkNiDwlFe43pDclXNjwyvSHl+sa+0V9sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UvjpNZNRDkGb/Ej+X8AZcqLrbtDLQaND1KBU9qBrkJjIj4p3kyxII9GWeZ/XGRdpLt4JOMv5k3YUESiM33F+bT1J8Agc1k9WApEM96w5NWMhi+iB0KO321N3Q1b27uCmEvlerO8lpfggj03PUJiLtamvOgQ9eAOdMab2rfO7lLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf20NWKJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf20NWKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F2B1F000E9;
	Fri,  7 Aug 2026 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146683;
	bh=qZBPikskH+oIHSDWkS3tCRQPMgtdk1YbqqNSrbMIKgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zf20NWKJTF0GRiF0HAVaCCn0pI8NRxcNHkqeQgA6q3QMfXnD/a1lFJ/jYKFYGz2fR
	 SgDpKamyDaPB1WrR+aNYeLIAkg90vgFcSYx3GpXkDblUhYUc5p02uaEho07KCRHogE
	 cVHptoNdzSHn30BAEfNxs1hV8f/oMJ3wu1uLzL3vd+Mg5alYMjow7jTVikAHnia8+N
	 G6awxBo9D6kQCNIazGPjUOz4sM12TnYmA/1IwfZK6he4W2bnSEeY6otOl/APpBXpl4
	 XD/MsYSlXdLIBiqVC6ARf0Yvm5KZXRMFtJiIxvTuFd6fAkUsUPs3/JhVAJkYSUpaBe
	 8oda2t+OGIdLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C9380CEF9;
	Fri,  7 Aug 2026 23:50:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: niu: fix potential buffer overflow/truncation in
 irq
 names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614664163.2467553.5421204651277744533.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 23:50:41 +0000
References: <20260803211149.10585-1-ronanmarchal29@gmail.com>
In-Reply-To: <20260803211149.10585-1-ronanmarchal29@gmail.com>
To: Ronan Marchal <ronanmarchal29@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 23:11:49 +0200 you wrote:
> Building with W=1 reports a -Wformat-truncation warning on
> niu_set_irq_name(): the "%s:SYSERR" format could be truncated
> because irq_name[] was one byte too small for the worst case
> interface name length (IFNAMSIZ-1) plus the ":SYSERR" suffix.
> 
> Increase the irq_name buffer size to account for the suffix and
> replace the remaining sprintf() calls in the same function with
> snprintf() to avoid possible buffer overflows.
> 
> [...]

Here is the summary with links:
  - [v2] net: niu: fix potential buffer overflow/truncation in irq names
    https://git.kernel.org/netdev/net-next/c/4d8e0becfd34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


