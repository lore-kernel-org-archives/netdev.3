Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13133A9C3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087641; cv=none; b=RTj5+tlz77vD90OQPudED491vwRWsiCZ7CI2oIrzLIZAqYOV0ZYgfu6mLJf2ig2kGulk85u8gf43Jnpj0Vt86ULVagos3yP8qCy+3rBOQ3MmWuilQ0yeP2xTUyb7PL6Nf7ikZu3oQS/J1P3TPanhWAeWSspxy8+Pgv5e5oXFqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087641; c=relaxed/simple;
	bh=8ybY5IpfDrVmFUOd7CZ9BIkn/QBNxMzGRxZwn3+F2eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bXua0JCtGZdRyRyLarrB8ctGua1E3K2TJGZXJxhN/AX5ayhz4ltoCG/ziuqlyFCiQhdbbqiDX7KO8/zukJKmLeoMFbZ5zgFSJ+KxsS6NEPTX+/004DQs0QRKRqWMpzWDWE7hzmlrz8StTdfeOwJD/cplMUglKhZh+kKSnT75hXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7nFcTMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7nFcTMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E3C2BCAF;
	Mon, 13 Apr 2026 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776087641;
	bh=8ybY5IpfDrVmFUOd7CZ9BIkn/QBNxMzGRxZwn3+F2eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f7nFcTMcIOS74JcyikG/MrbvAcP8c+Zn1ffNRusg5+4s+/IYcRoEylFH3ZH1t50pE
	 umSbGHZuD7vxPW4Xa5CYrn+WmoZJsayRBa9Raz2DX/AwU8TRhY7gaNAv/o9ZIODy8N
	 2rEnn5D8ofD1G2YMbv/XsCilz4ZmCALpWy8oSutNyLtU7XfSvOBXUV3J0kouXzL/hP
	 b/oOPX8MwCo2Gre8GIFUQA0mTcdgdQZ1/Oi01fIDbFZ2pc0PSUldj4L21MPdB9jely
	 9X7c21eO2s+IlXe2yHNe/jSYOqbJIpH4i9Pkzio9PCc9WAF+RtFjgmwF36zMBm20Tc
	 PloumwhVyYlQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C6C3809A8D;
	Mon, 13 Apr 2026 13:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: update window_clamp when SO_RCVBUF is set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177608761254.4132316.5496671723611036519.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 13:40:12 +0000
References: <20260408001438.129165-1-kuba@kernel.org>
In-Reply-To: <20260408001438.129165-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 dsahern@kernel.org, quic_subashab@quicinc.com, quic_stranche@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Apr 2026 17:14:38 -0700 you wrote:
> Commit under Fixes moved recomputing the window clamp to
> tcp_measure_rcv_mss() (when scaling_ratio changes).
> I suspect it missed the fact that we don't recompute the clamp
> when rcvbuf is set. Until scaling_ratio changes we are
> stuck with the old window clamp which may be based on
> the small initial buffer. scaling_ratio may never change.
> 
> [...]

Here is the summary with links:
  - [net] tcp: update window_clamp when SO_RCVBUF is set
    https://git.kernel.org/netdev/net-next/c/b025461303d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


