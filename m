Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404EF36213D
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011228; cv=none; b=NQmQSntcjh6DjN+9Dh3b57jiaAPntB/eEA0n4V501oW0X0QswRtIhlBzf1ws96KpEuK1sIFCOr5mGdDItcOcMDYHluAPVDe2UPkmCo70RcnaDpyCwj2tn/07PKrO5egHWThMtg8q0oGubgSbCrnwzMoHrZhPVHlqseofkvVj6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011228; c=relaxed/simple;
	bh=F77V0qacPu1vsT0FF1/qkJ4lDD4ex7Tvwh26H0RDfT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OrYHVxlPB1ME56qW5WRKxh8LVNeUCrV2vKTlC1qPLG1G/TW0prlQqBzzeLDXrdSTvcKRWMRfR1H2+I9bcUhP3g5qJaX00QNs7VEg02Dmv+GV35mekSTcZb/qA9EnhwMNGQ0Q5u0a4yoYq1un9ZgmLSECh+qROjalN55XBQ3u8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnDQpZyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnDQpZyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E28EC19423;
	Wed,  1 Apr 2026 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775011227;
	bh=F77V0qacPu1vsT0FF1/qkJ4lDD4ex7Tvwh26H0RDfT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hnDQpZyUmF5pzivLNcBWW/aekszVoClHVqiREtpV4lnfq4i87xhLVMYTx1iKb/g3Z
	 4uDhC7DLQhaYkR3HRPy+TntSKakePRTJGutqWr30q8zaVGRoQzwJ19+gLteE90qHj/
	 GLB+F3WSL2znt9OIf1pERFatXlA1m/V3qa8GvIcBzLCVZnP7l+8XEY4K8h+swxRe7N
	 RjY4VK4sxHIWtYC5VXF8Fcu1+L4bMb1bz+RVzV70yPX2xS8hL6N7wi8eoNnT0Go5jf
	 M3Pe2M65I2LR0ff10Sj+WlhbitGBVsRaFCGFzkJkygdxv1cBTv2eb312hYJhdsa4za
	 KDc4zFeSXY8aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0453808203;
	Wed,  1 Apr 2026 02:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Fix typo in
 airoha_set_gdm2_loopback
 routine name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501121053.3042140.8960610979272112652.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:40:10 +0000
References: 
 <20260330-airoha_set_gdm2_loopback-fix-typo-v1-1-a1320ff6b6cc@kernel.org>
In-Reply-To: 
 <20260330-airoha_set_gdm2_loopback-fix-typo-v1-1-a1320ff6b6cc@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 00:03:49 +0200 you wrote:
> Rename airhoha_set_gdm2_loopback() in airoha_set_gdm2_loopback()
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Fix typo in airoha_set_gdm2_loopback routine name
    https://git.kernel.org/netdev/net-next/c/a94ddc191f19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


