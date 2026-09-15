Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD023EC837;
	Tue, 15 Sep 2026 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460509; cv=none; b=TgBqN6b/xwG04oj2U0lPO0g91gfEbDtik9bkWJq3qlixiY2Ao2iJKYE/R4EycDXpGIWDwyGjy5663BFuBsRSxdjS+rpuJU28S+jKY2AAn8AOLFYevG2/ucJU9yM9J4x2Qhvg9GgrTFiW+Ab1V9Kmj4i/kV3ZldQuanLb/a1v/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460509; c=relaxed/simple;
	bh=6OXLOMN1tT+2LCdpc4U+qP8GJa0HjXvylGogrLIrRXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CliIb7g/V6ysnXoegQja1rpNms/nY9RlKBOToL+PgeGfBw+LL+cZsAURdZ0XrYuiKNDpuIx4T0rF6pBvmmlU2wa+Xx2a7ODIbXSsZlD6hvBNTiNbHeQIEXIg+Ydl6nWczRZnO8VPUErmAneeOy7paT37SQrxC3f4L99M7ZYSObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg5XvQyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg5XvQyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCCB1F000FF;
	Tue, 15 Sep 2026 08:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789460479;
	bh=PmiReS6uxC4r5hg+N62nj1I2PQSmsT8XxX9Bgx2Kavk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cg5XvQyJYRuQQRpLYuyeoImBss8CHRlKAMjKOOqMUmR9Kjn5edEQtKGHsFhuPKGcJ
	 S+DgXpuRyvz5ARXSFDIjoqHzVU8qzAynO6JbuzqoFhmTV0n9HgGFatuEHL7Za6WMJw
	 DPb9mWHFtr2kAEHaCq2IVB1D0KqKLjzOo+aiXk5gNogrNArMB3odisE89j/bIJybWO
	 4vZxn3A0DAtsRH4vz/zAJw+pvXfm2LyFJvPTReJNRXQ8AcD5yUy+Iqkf9apy84VEhk
	 4UpJeTqLIRpLPRYkF5dx5XI1tg0Q47g0teLIgpra/o7wLEztHuup4/B2/ngC7rEy0B
	 42+wBY9OxZgYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BA39253E9;
	Tue, 15 Sep 2026 08:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 1/2] net: fec: Propagate PTP initialization
 errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178946041395.1433766.9518357257056038239.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 08:20:13 +0000
References: <20260911040021.12289-1-phucduc.bui@gmail.com>
In-Reply-To: <20260911040021.12289-1-phucduc.bui@gmail.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 11 Sep 2026 11:00:20 +0700 you wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Change fec_ptp_init() to return an error code instead of silently
> ignoring failures during PTP initialization.
> 
> The PPS IRQ is not required for the FEC/PTP functionality, so its
> absence should not make the probe fail. However, an unavailable
> optional IRQ should be distinguished from an actual error returned
> during the IRQ lookup.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: fec: Propagate PTP initialization errors
    https://git.kernel.org/netdev/net-next/c/2343cff0b382
  - [net-next,v6,2/2] net: fec: Handle optional IRQ lookup errors correctly
    https://git.kernel.org/netdev/net-next/c/20d1b74a32d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


