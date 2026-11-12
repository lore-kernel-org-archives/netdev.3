Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481806;
	b=iUONQiGou7XSnAfYYSLHjV/O3ES9mKFY56x40OqJaT5JPDldEihDIGSe/X45Hb4fglJf
	 +xwe+7PtSx3JuMzgHqxocdfn+zbrmneUYfC2mwrwu0inE9IJMvAX5/2ePu3bh2FWcDLZa
	 GhOxcxwV0SazwMb5kLevQrom/R2qkezx0+LkrBpdYpAe8HyIUmFx7OyL90q4AFp/94MPW
	 +Tc3MCPG80EB5ePidzvv9xdwiqc2ZxiL3o+3/k+E8CXOGtZM1lwnedQhJpH0IGtkr+E/j
	 JerDTxIGMJyDXQ0b8oxpc75yb9ZwW7zNYPfauKmGjW9EdFCCAuD/76KpPhR63jUDp2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hn5JHRn1D+0dPUmFjVPSY2298ewtxyUPc3PuzoACQ90=;
	b=oguKvFaws82LzsIlUbV6RRGTywwOnMOzWTCd4aPMiK/hJ/4iLApfpdQPKawX/WPlp4Tl
	 D5iOJErbt0DwLVoY6yIFrpXxjHXzOUzLjWBP6iBFvNjUtWki8KsvaBd2TuwHKhR+Suwd4
	 N4hNB959U0vO4JD4S1AcLI3Prl9pPfqsYBpjswLJmDcffApfpIiwXpM3FcNhaRFAt5/ye
	 OnvINRSdSUVewBGXNKt+v9olPdj0POHrLfeN5NYzTxc/kC6TzxCYJwV/VfK+5Ionify7U
	 oIN1OyBEEHW2hZVAoOhlihGrDLZUqKRdyJFynkbiNr+T4l/jrNhwuKo7CMnkYV2eBgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+mFTVll;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D51606A31C;
	Thu, 12 Nov 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+mFTVll
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF61F00A05;
	Thu, 12 Nov 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481805;
	bh=hn5JHRn1D+0dPUmFjVPSY2298ewtxyUPc3PuzoACQ90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J+mFTVllvw2p8ex1twvleZRF9qfxWHaDebcXzVK0ImD9E7jftkJ9sNv9oWEpXD0ZB
	 WMDjq6/odYKkf/0uTfYnu33Kcq2le0T5yPBcr6Hs6B7hfAm5gEkqoYMllKkYWB2Bgn
	 YEMOXsNlh57Yzm8czMfQ7KfOL2vzScEl8dTdzcjilGH4tVAAzc8VRCBJr2C44Vz18q
	 mU6cUmukNVw9GT9KACtaajrTzXixdEllGDsiF4BaxodQFH39a26c/7FOZuSimucKGN
	 mGNXmm3ske+cD4i1984HyOxEnpSUCjvOwWgyyRQYw/BF+1VOUtKRvkYvhgyZmt2hAC
	 MKuXuDGVD8gIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D82843AA9F46;
	Thu, 12 Nov 2026 11:10:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2] net/sched: cls_fw: allow filter replace
 without
 re-specifying mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179448180472.2021886.7663013932315306240.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 11:10:04 +0000
References: <20261106063133.98515-1-taowei@kylinos.cn>
In-Reply-To: <20261106063133.98515-1-taowei@kylinos.cn>
To: Wei Tao <taowei@kylinos.cn>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Nov 2026 14:31:33 +0800 you wrote:
> The fw classifier keeps the fwmark mask in the fw_head shared by all
> filters of a tcf_proto instance, so the mask is a property of the head
> and not of the individual filter: it is set when the head is created
> and cannot be changed by a filter that is being replaced.  Nevertheless
> fw_set_parms() rejects such a replace with -EINVAL whenever the head
> mask is not the default 0xFFFFFFFF and the mask is not repeated on the
> command line:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/sched: cls_fw: allow filter replace without re-specifying mask
    https://git.kernel.org/netdev/net-next/c/0cd24172516c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


