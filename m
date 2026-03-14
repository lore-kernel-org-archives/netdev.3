Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EF3B2BA;
	Sat, 14 Mar 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505227; cv=none; b=bfig+dO6mSDv4yRvc3RxTrOAtJMcxCw3TVeL4Cd+93Gb4VCYBbNIpV+m8VCroSHP/DIbzW4OWLJeKi/Twn0K/1l0ngOUMqODVAztdUbRgFYitE9TP/VupGVlUOhCLvUDU+K+dP84qXdPQX40qImt/QVjQA3GrWIn1hgQToGn7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505227; c=relaxed/simple;
	bh=BSdXDCCk8ELvcQzcfmVKL0N+wRZFKhwL/V7gS3g5Bq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkgQEFf4SrNUqOX/BvPUb11PbL8/mnBHr2r6AFduhjGFRIjNUoKkNqFkhITclIXF+gzov8OninMfJqITqYNkFJ48gDWCWmbegy6MbNQGMz6w4lwpkz9bYbE+iyKBRa2+Vc0w+Mrc2fcfpxvOLNXmT3v0MZmi53tkbvg99hrCQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNWTYKYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNWTYKYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510E5C116C6;
	Sat, 14 Mar 2026 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773505227;
	bh=BSdXDCCk8ELvcQzcfmVKL0N+wRZFKhwL/V7gS3g5Bq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNWTYKYKpwE1Vof1nE3D3Y+B7lDRol1N502sGBf54guGDyXR0/DKI/jCe4quSgS0P
	 jAWlGJuLDU9evU2NqyjQPjT+B3lC1Ba5zyXMqcjUSTccN8kcdjNkE/l6xLw3kOHHeq
	 AmUY5LsaGCoLLT0kmUa8zpD0JDM5ljmkgbQN78RmuFdd7GTN/0BHKl+9LFdGi3ivwG
	 0od8beX4lq7sykLL92WyBDoISykg9WPlelguBUhrWbbyt4+6jIqFMOS4D2lzo1nrhU
	 t7F/htK93xogHIh0WRMtDp4IGnG/Kj2GUL/bp5dRDcnRuMYzcneQOX6+EvDzc+6D0B
	 97NtbUKm1NPFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0663808200;
	Sat, 14 Mar 2026 16:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: enetc: remove stray semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350522128.1725156.14815410959667583831.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:20:21 +0000
References: <20260313112454.427191-1-wei.fang@nxp.com>
In-Reply-To: <20260313112454.427191-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 19:24:54 +0800 you wrote:
> Remove stray semicolon from ntmp_table_name().
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/ntmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: enetc: remove stray semicolon
    https://git.kernel.org/netdev/net-next/c/f4ce4922df8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


