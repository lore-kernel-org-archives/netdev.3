Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31A23395C;
	Thu, 13 Aug 2026 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581059; cv=none; b=q+YmbUEVIGDkcihAiMikGvblkkG8yX4wHWSN2v9rmk2Vqh5H8Y2DogmbZlEPJ1v7c4+qFIXo99p5jipD7Kf59gjfKu+1e8Byj0IAN8FTDlNdZESIKUyQzJk1sr/QWuhtq/xhbzuCKF6Atprpc9q5QiMyVMhhI0wZZyrH+V/5BcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581059; c=relaxed/simple;
	bh=b0wfI8VaB1XW5c942t7Qkvi9v3c1soEKoIaUPMGWmP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eV8N91uYfmR5p/QvTKG+hQuEDX64FuuSsuz1RhgscAzTIFI0sui1MtnncR/N4pMgOPzETfz9M+i86J0sDELsXDVJqcDKjDwUAji2s8PAWSfrnCX6ciVnf3Nau74JQRVcf6RvMmmY4Ez+7fSaV8fF8A5qo16h+hXXxpzi3054W4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4GJWwmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4GJWwmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E889D1F000E9;
	Thu, 13 Aug 2026 00:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786581058;
	bh=Y9u3cXk4QoUHnDGMQsz9KdIsHpu4lBUyuiKLt4Xs+RY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J4GJWwmilbqcsVnCSvQ2z1w4gteFBIulEFZyFVQMD4JvftD2IrsxZ3G+bnjW+Cpak
	 n3t98eMGF+BMzg8LkxUkhR5i0YTcsu7ifkOEPD4h5hhhNBaEUiOAQ/WlU/W2lGre72
	 woJXaLZQLKhaIzwNmfj+++nkSeHo2EmmXjysu6oSwmA85UhVrah2OSFq1at6/3x0mK
	 PhgWjFxwM2ZLB6Y/WU5MZKt7Hjyh4rAhUnNZUD2p4ibyT0xm/h33BV7FRpYezByDgK
	 FuEKq9DcAMOKT5E3R0sf1XgI+meMOLEoGIdSzlXJQNHX9rLDOPKllvHueVSQ6KFy1R
	 bNtnCXma11BiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56856380CED0;
	Thu, 13 Aug 2026 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pptp: drop packets received before connect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658101288.2163205.7866171719387216869.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 00:30:12 +0000
References: <20260811074948.345834-1-qingfang.deng@linux.dev>
In-Reply-To: <20260811074948.345834-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kees@kernel.org, xeb@mail.ru,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 15:49:47 +0800 you wrote:
> pptp_bind() publishes the socket by its local call ID before it is
> connected, so GRE packets can reach pptp_rcv_core() while
> PPPOX_CONNECTED is clear.
> 
> Such packets are queued on sk_receive_queue, but PPTP provides no recvmsg
> operation and never drains the queue after connect. The packets therefore
> remain there until socket destruction.
> 
> [...]

Here is the summary with links:
  - [net] pptp: drop packets received before connect
    https://git.kernel.org/netdev/net-next/c/a0d6255b4adc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


