Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8D284665;
	Fri, 30 Jan 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744420; cv=none; b=oJ04cKBfYKZIPolRh8RubbfqibupJ49QbF/uV0BJc33ZbaeILx+Md6BeXoGKsv6tbuehcaAcJ9aX7KwU7RoVlcP/sifzfKk/5MBa5jdTUY3FdIoFg2Rh+QaFPAuWiqI95A6NWDwy8b3RbXEwyj4Onz4J1XMWZ4xpsiPfuKC2dbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744420; c=relaxed/simple;
	bh=Qxinxyl20wLv11EZeIQLPfuV1s06icKYCS/fEEZ14eM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sxKEjNdS6VuqWpweK1Gpyvef3MALqy+kf07X8IaEZ2SWszSRqAjhldADY32/RL0YXnDHdugxqQz/4g8/EjhHTac3SjZ+aqt9auL4VMBuf6zKVfMNoV0w1jg7z/ug07qiB7vW+hllBx5oWKB+KUaFqq35wRL9mliFjcy6P+zjvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMxKgCZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMxKgCZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD23C4CEF7;
	Fri, 30 Jan 2026 03:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769744420;
	bh=Qxinxyl20wLv11EZeIQLPfuV1s06icKYCS/fEEZ14eM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vMxKgCZH4SfvPuq3POsWl/n3cjdqy6zFfy6sUgl9BWvpmSxz4tAFaT5clP5YhA5eJ
	 sGhEDUYFWKCseJLigeAuZF6/9O1OuBhKZEEpzixoNadB1dnTsUa3dvgUhC964hgXbX
	 jrofwTsMUGiHRrok/vx5vXPrsuZzQjDDDE8zVcgkZX9nC/6RG+c2qp2ZLocN/G41qF
	 cu4f2WD0QcHEw3NFGk3Bze/RB8hHTtDfFCwVSVVN2z6lO3G3ZmSDMJs56qYCJ1Lnd3
	 xeCHEV6iYEuIHd+o6L0lhiUWfREjMHkgLcZQWrmmlEZWhllWgL6jKXp8PZMo4lGT/1
	 4aXgzqMulX3NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11AED380CEE0;
	Fri, 30 Jan 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] octeontx2-pf: cn10k/cn20k: Update count_eot
 in
 NPA_LF_AURA_BATCH_FREE0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974441260.3161630.17605690465239171654.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 03:40:12 +0000
References: <20260128022448.4402-1-gakula@marvell.com>
In-Reply-To: <20260128022448.4402-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 07:54:48 +0530 you wrote:
> This patch updates the count_eot calculation for CN20K devices.
> Where the count_eot feild extended to 2 bits, while maintaining
> CN10K compatibility where only bit 0 is used.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
> v1-v2: Fix size value based on count_eot
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-pf: cn10k/cn20k: Update count_eot in NPA_LF_AURA_BATCH_FREE0
    https://git.kernel.org/netdev/net-next/c/988719c5eafd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


