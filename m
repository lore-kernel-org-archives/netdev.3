Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236808;
	b=A+420Z/3tuMAFQsjrJBUAzqGT8CfdqVPBlsMN6iPmP/7nNiCmvCnsOIjZ+rylk94EqGL
	 +x8KzN5hUcK05wWwRtgfLbrhdLnY03AK5iBLGkVpU4k3cgt1uz86Ho2TvRAD9bkqttwyI
	 BCBr87lw8QclyLNh2SVFLjNO1Rg98AF3zUASYTQR2eTTvmy1ilsvPeZ2BIsg1lArodi0t
	 5QSu/2qT1fLextw5YDJvsnuRuB4v/lArwLnFtQdk9LKs5ZGrOXaFaZYwtI/VXV/v4UrCM
	 UhjW6erymej43+xXUDCILik5wgQ4xhflGm3P3WnYEhWnuEaQdkJDRljeZc9N5BwzRKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=18QYqo+bXz1pZaH6T1vs+7njMvsin+4sOdIS0MUUpf0=;
	b=CJt65zzDE70SuMppHWIEtjDIaqurSWeVSTQEBIWnT3+xyw5L0OSWzJkF6H16C7A1lOv+
	 AI8vu+dy8tHOK2HUiunQSTUo003QqjL7DDlfBIqsCHlBUG8kO/tuP/+7Gb9zO6Li8/Y0k
	 lpSBXTvsUaQFDY6oLk+DUVSPOmg5aEodd2GHoewosTXmX5SL1MCupkyH7fuxm2yMVj+fo
	 Ov1PKxdKQhYoQQBIlRQ7ejK13M/XKCX2jriUYaT/BiSvvnc43ZnXn5IWzaSoFHz1S01Xk
	 97RtKSMvKXNYbv3nfnY0wrdjtbAfgF1GzP3up485YF1USWfrUMJNpfCuSvVIDn0wUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Knutpfr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F70606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Knutpfr3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD091F01825;
	Thu, 29 Oct 2026 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793236807;
	bh=18QYqo+bXz1pZaH6T1vs+7njMvsin+4sOdIS0MUUpf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Knutpfr3+oLEUj98RXYwu4V8Egs1LQD3HAPvn+Yzcsosd1f49a/eFIMBtDAcr9ZSE
	 NtMLazCC5sq9X6yN27MxilozIqQABshKmRo5EI50tPbhwMhK46uchPrF/T3RRtvheT
	 +QkS+wPBNfZ8ZoaE4ZMfJoHiTVIbofemXNEibYn6p+8rzLWZlbq61kp71RV06rZRA0
	 T2As3QTnvDcjMWpweqopJoeKPLUapqewMDJ/mWylwgcydRBvVMrWKnTxKRSm9E6Zwc
	 em+wuq5hniJA4+VHLar0JpyjqE9bfqCfL9RQUkbXdsJLU4F37dkjCktIL7H4W113nS
	 ghg3I88EVhVOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4457C3AAFC4F;
	Thu, 29 Oct 2026 01:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net 0/6] ice: E82x: reduced timestamp processing logic
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179323680607.1512684.10140194376878550484.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 01:20:06 +0000
References: <20261027-reduction-v1-0-81237c67a361@intel.com>
In-Reply-To: <20261027-reduction-v1-0-81237c67a361@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Oct 2026 17:05:36 -0700 you wrote:
> Jake Keller says:
> 
> This is a reduced set patches originally posted as part of [1] which
> previously passes Sashiko review without comments. It does not completely
> resolve the outstanding issues that we had, but can hopefully unblock some
> progress.
> 
> [...]

Here is the summary with links:
  - [net,1/6] ice: use reference counting and SRCU for PTP port access
    https://git.kernel.org/netdev/net/c/d5d859a6efff
  - [net,2/6] ice: set in_use only after preparing Tx timestamp index
    https://git.kernel.org/netdev/net/c/50870d621160
  - [net,3/6] ice: E822: keep Tx timestamps disabled during offset calibration
    https://git.kernel.org/netdev/net/c/56af436b90ac
  - [net,4/6] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
    (no matching commit)
  - [net,5/6] ice: E825: clear PHY_TSTAMP memory prior to soft reset
    (no matching commit)
  - [net,6/6] ice: skip reading Tx ready bitmap on ports with no timestamps
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


