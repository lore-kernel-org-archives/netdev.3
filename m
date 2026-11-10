Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346813;
	b=uk17UJn/24JNnDpVUjkNE9aVVGmBFzVnCEUzS08hE4+gRRgMFf7pAek5reI/mwgsI1A8
	 h4XGP6QY3fkx2PWxSdBuLenkg0OWnFmyt8DGyMh84b84lnYF2Aer7rOYaEzdy60cQj2gt
	 1n5onF8kT5zaSliP8gr3eKU5O4uP9JB4lZCZJgPUsE36Od7WAChzi64hoOo/XnAPSa+FX
	 tzqD/WUBFiKMBamZyxzWvG/piTJOGcWVm8lR5a4//1vmpWaRKz6KcxN8mRtP6BwTpbpp5
	 Q0EMG/tT2RqNU55WVLPc3g94O5/dMPn0z6UTM6yKH83qW3Ptqi921XMov5EExa/ikLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346813;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PDM5AgYQk1VEu2QNvRVlY3EllPW/RzaW6vtCCatFRG8=;
	b=Ie8gAKiaDgA6X1fyxcd7SwAMZN94wtF5MgkyO57Ak72sckZrB+pxIMuDn9wdr1YkgnoY
	 v5yDzZwnH2pVV4JaD+3vJaTxthDJQx8hoa6tYxRgpUveO5q/RZuo78E9JiSiyk1dIhyU3
	 JXDjZB3W00Nc5hG88akDN6mVSG5JUfWpsZ32P+0kF5EqWL7f7O3ZwYPCLREsUwdJ/CI+f
	 /KTnoCi4NcHErIQM+6J/Sfz0JgX9sJ4tF6gf/LXGe4POT5N6pnIH98C7aiW5jMiTThbfG
	 4DEHlM867i3FlJ9MyG+pgKM5Wid/xzlQc19Oa5Cj4kRI1ZQmGcBMi9i9XTochwki8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No6qXKuG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342360A2608;
	Tue, 10 Nov 2026 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=No6qXKuG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A670E1F008A4;
	Tue, 10 Nov 2026 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346812;
	bh=PDM5AgYQk1VEu2QNvRVlY3EllPW/RzaW6vtCCatFRG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=No6qXKuGIgxW/umR4tQjz/YQzKEhccJssBOP1mPW9FDBPuWcodzTGiZGK8K8yY64/
	 SWRm4u/otm2/UpeWUgPXtG1N85+bFCXbQk8dIepaEDLBBWanmM28UaPhH7/Vk4QCvv
	 8xXHMFG0OlX4RSdPbdrhrgKn5WjfddxCLy7rbeycNcy+2EL2B+b7kp5pUmhwFEghEE
	 +q7kx03FbZC1ii5Cp235LifrJBj3hyKV1m017rOEmDCddCDmkM7Nhay1oqTyrVZ/KV
	 K91hxcjyuEK92cNXRFccqaHIbiPmUfpePxZBvrFz2AxVXp8GUMpmg74YcLPwlaMDjI
	 iDaSWQ6U0zFzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B25139E8A40;
	Tue, 10 Nov 2026 21:40:12 +0000 (UTC)
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
Subject: Re: [PATCH net-next] sfc: avoid truncating MCDI hwmon attribute names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434681117.71955.13887158887547075759.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 21:40:11 +0000
References: <20261105020115.278-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261105020115.278-1-xujiahao@cmss.chinamobile.com>
To: xujiahao <xujiahao@cmss.chinamobile.com>
Cc: ecree.xilinx@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 10:01:15 +0800 you wrote:
> The name of each MCDI hwmon attribute is built in a 12-byte buffer as
> prefix + 1-based per-type index + suffix, with prefixes up to "power"
> and suffixes up to "_input".  With W=1 gcc reports:
> 
>   warning: 'snprintf' output may be truncated before the last format
>   character [-Wformat-truncation=]
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: avoid truncating MCDI hwmon attribute names
    https://git.kernel.org/netdev/net-next/c/97ced2c090bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


